package com.KBank;


import java.io.*;
import java.util.*;
import javax.servlet.*;


public class MultipartRequest {

  private static final int DEFAULT_MAX_POST_SIZE = 1024 * 1024;  // 1 Meg

  private ServletRequest req;
  private File dir;
  private int maxSize;
  //private Connection con;
  //private String coNo;
  //public String version= " ";
  //public String storedFileName = " ";
  //public String fileName  = " ";
  //private String docType = " ";
  private Hashtable parameters = new Hashtable();  // name - value
  private Hashtable files = new Hashtable();       // name - UploadedFile


  /**
   * Constructs a new MultipartRequest to handle the specified request,
   * saving any uploaded files to the given directory, and limiting the
   * upload size to 1 Megabyte.  If the content is too large, an
   * IOException is thrown.  This constructor actually parses the
   * <tt>multipart/form-data</tt> and throws an IOException if there's any
   * problem reading or parsing the request.
   *
   * @param request the servlet request
   * @param saveDirectory the directory in which to save any uploaded files
   * @exception IOException if the uploaded content is larger than 1 Megabyte
   * or there's a problem reading or parsing the request
   */

	public MultipartRequest(ServletRequest request,
							String saveDirectory) throws IOException {
		this(request, saveDirectory, DEFAULT_MAX_POST_SIZE);
	}


  /**
   * Constructs a new MultipartRequest to handle the specified request,
   * saving any uploaded files to the given directory, and limiting the
   * upload size to the specified length.  If the content is too large, an
   * IOException is thrown.  This constructor actually parses the
   * <tt>multipart/form-data</tt> and throws an IOException if there's any
   * problem reading or parsing the request.
   *
   * @param request the servlet request
   * @param saveDirectory the directory in which to save any uploaded files
   * @param maxPostSize the maximum size of the POST content
   * @exception IOException if the uploaded content is larger than
   * <tt>maxPostSize</tt> or there's a problem reading or parsing the request
   */
  public MultipartRequest(ServletRequest request,
                          String saveDirectory,
                          int maxPostSize) throws IOException {
    // Sanity check values
    if (request == null)
      throw new IllegalArgumentException("request cannot be null");
    if (saveDirectory == null)
      throw new IllegalArgumentException("saveDirectory cannot be null");
    if (maxPostSize <= 0) {
      throw new IllegalArgumentException("maxPostSize must be positive");
    }

    // Save the request, dir, and max size

    req = request;
    dir = new File(saveDirectory);
    maxSize = maxPostSize;

    // Check saveDirectory is truly a directory
    if (!dir.isDirectory())
      throw new IllegalArgumentException("Not a directory: " + saveDirectory);

    // Check saveDirectory is writable
    if (!dir.canWrite())
      throw new IllegalArgumentException("Not writable: " + saveDirectory);

    // Now parse the request saving data to "parameters" and "files";
    // write the file contents to the saveDirectory
    readRequest(req);
  }

  /**
   * Returns the names of all the parameters as an Enumeration of
   * Strings.  It returns an empty Enumeration if there are no parameters.
   *
   * @return the names of all the parameters as an Enumeration of Strings
   */
  public Enumeration getParameterNames() {
    return parameters.keys();
  }

  /**
   * Returns the names of all the uploaded files as an Enumeration of
   * Strings.  It returns an empty Enumeration if there are no uploaded
   * files.  Each file name is the name specified by the form, not by
   * the user.
   *
   * @return the names of all the uploaded files as an Enumeration of Strings
   */
  public Enumeration getFileNames() {
    return files.keys();
  }

  /**
   * Returns the value of the named parameter as a String, or null if
   * the parameter was not given.  The value is guaranteed to be in its
   * normal, decoded form.  If the parameter has multiple values, only
   * the last one is returned.
   *
   * @param name the parameter name
   * @return the parameter value
   */
  public String getParameter(String name) {
    try {
      String param = (String)parameters.get(name);
      if (param.equals("")) return null;
      return param;
    }
    catch (Exception e) {
      return null;
    }
  }

  /**
   * Returns the filesystem name of the specified file, or null if the
   * file was not included in the upload.  A filesystem name is the name
   * specified by the user.  It is also the name under which the file is
   * actually saved.
   *
   * @param name the file name
   * @return the filesystem name of the file
   */
  public String getFilesystemName(String name) {
    try {
      UploadedFile file = (UploadedFile)files.get(name);
      return file.getFilesystemName();  // may be null
    }
    catch (Exception e) {
      return null;
    }
  }

  /**
   * Returns the content type of the specified file (as supplied by the
   * client browser), or null if the file was not included in the upload.
   *
   * @param name the file name
   * @return the content type of the file
   */
  public String getContentType(String name) {
    try {
      UploadedFile file = (UploadedFile)files.get(name);
      return file.getContentType();  // may be null
    }
    catch (Exception e) {
      return null;
    }
  }

  /**
   * Returns a File object for the specified file saved on the server's
   * filesystem, or null if the file was not included in the upload.
   *
   * @param name the file name
   * @return a File object for the named file
   */
  public File getFile(String name) {
    try {
      UploadedFile file = (UploadedFile)files.get(name);
      return file.getFile();  // may be null
    }
    catch (Exception e) {
      return null;
    }
  }



  /**
   * The workhorse method that actually parses the request.  A subclass
   * can override this method for a better optimized or differently
   * behaved implementation.
   *
   * @exception IOException if the uploaded content is larger than
   * <tt>maxSize</tt> or there's a problem parsing the request
   */
  protected void readRequest(ServletRequest req) throws IOException {
    // Check the content type to make sure it's "multipart/form-data"
    String type = req.getContentType();
    if (type == null ||
        !type.toLowerCase().startsWith("multipart/form-data")) {
      throw new IOException("Posted content type isn't multipart/form-data");
    }

    // Check the content length to prevent denial of service attacks
    int length = req.getContentLength();
    if (length > maxSize) {
      throw new IOException("Posted content length of " + length +
                            " exceeds limit of " + maxSize);
    }

    // Get the boundary string; it's included in the content type.
    // Should look something like "------------------------12012133613061"
    String boundary = extractBoundary(type);
    if (boundary == null) {
      throw new IOException("Separation boundary was not specified");
    }

    // Construct the special input stream we'll read from
    MultipartInputStreamHandler in =
      new MultipartInputStreamHandler(req.getInputStream(),boundary, length);

    // Read the first line, should be the first boundary
    String line = in.readLine();
    if (line == null) {
      throw new IOException("Corrupt form data: premature ending");
    }

    // Verify that the line is the boundary
    if (!line.startsWith(boundary)) {
      throw new IOException("Corrupt form data: no leading boundary");
    }

    // Now that we're just beyond the first boundary, loop over each part
    boolean done = false;
    while (!done) {
      done = readNextPart(req,in, boundary);
    }
  }





  protected boolean readNextPart(ServletRequest req, MultipartInputStreamHandler in,
                                 String boundary) throws IOException {
    // Read the first line, should look like this:
    // content-disposition: form-data; name="field1"; filename="file1.txt"
    String line = in.readLine();
    if (line == null) {
      // No parts left, we're done
      return true;
    }
    //else if (line.length() == 0) {
    //  return true;
    //}

    // Parse the content-disposition line
    String[] dispInfo = extractDispositionInfo(line, req);
    String disposition = dispInfo[0];
    String name = dispInfo[1];
    String filename = dispInfo[2];


    // Now onto the next line.  This will either be empty
    // or contain a Content-Type and then an empty line.
    line = in.readLine();
    if (line == null) {
      // No parts left, we're done
      return true;
    }

    // Get the content type, or null if none specified
    String contentType = extractContentType(line);
    if (contentType != null) {
      // Eat the empty line
      line = in.readLine();
      if (line == null || line.length() > 0) {  // line should be empty
        throw new
          IOException("Malformed line after content type: " + line);
      }
    }
    else {
      // Assume a default content type
      contentType = "application/octet-stream";
    }

    // Now, finally, we read the content (end after reading the boundary)
    if (filename == null) {
      // This is a parameter
      String value = readParameter(in, boundary);
      parameters.put(name, value);
    }
    else {
      // This is a file


      readAndSaveFile(in, boundary, filename);
      if (filename.equals("unknown")) {
        files.put(name, new UploadedFile(null, null, null));
      }
      else {
        files.put(name,
          new UploadedFile(dir.toString(), filename, contentType));
      }
    }
    return false;  // there's more to read
  }




  /**
   * A utility method that reads a single part of the multipart request
   * that represents a parameter.  A subclass can override this method
   * for a better optimized or differently behaved implementation.
   *
   * @param in the stream from which to read the parameter information
   * @param boundary the boundary signifying the end of this part
   * @return the parameter value
   * @exception IOException if there's a problem reading or parsing the
   * request
   */
  protected String readParameter(MultipartInputStreamHandler in,
                                 String boundary) throws IOException {
    StringBuffer sbuf = new StringBuffer();
    String line;

    while ((line = in.readLine()) != null) {
      if (line.startsWith(boundary)) break;
      sbuf.append(line + "\r\n");  // add the \r\n in case there are many lines
    }

    if (sbuf.length() == 0) {
      return null;  // nothing read
    }

    sbuf.setLength(sbuf.length() - 2);  // cut off the last line's \r\n
    return sbuf.toString();  // no URL decoding needed
  }

  // correct up to this point...............

  /**
   * A utility method that reads a single part of the multipart request
   * that represents a file, and saves the file to the given directory.
   * A subclass can override this method for a better optimized or
   * differently behaved implementation.
   *
   * @param in the stream from which to read the file
   * @param boundary the boundary signifying the end of this part
   * @param dir the directory in which to save the uploaded file
   * @param filename the name under which to save the uploaded file
   * @exception IOException if there's a problem reading or parsing the
   * request
   */
  protected void readAndSaveFile(MultipartInputStreamHandler in,
                                 String boundary,
                                 String filename) throws IOException {
    File f = new File(dir + File.separator + filename);
    FileOutputStream fos = new FileOutputStream(f);
    BufferedOutputStream out = new BufferedOutputStream(fos, 8 * 1024); // 8K

    byte[] bbuf = new byte[100 * 1024];  // 100K
    int result;
    String line;

    // ServletInputStream.readLine() has the annoying habit of
    // adding a \r\n to the end of the last line.
    // Since we want a byte-for-byte transfer, we have to cut those chars.
    boolean rnflag = false;
    while ((result = in.readLine(bbuf, 0, bbuf.length)) != -1) {
      // Check for boundary
      if (result > 2 && bbuf[0] == '-' && bbuf[1] == '-') { // quick pre-check
        line = new String(bbuf, 0, result, "ISO-8859-1");
        if (line.startsWith(boundary)) break;
      }
      // Are we supposed to write \r\n for the last iteration?
      if (rnflag) {
        out.write('\r'); out.write('\n');
        rnflag = false;
      }
      // Write the buffer, postpone any ending \r\n
      if (result >= 2 &&
          bbuf[result - 2] == '\r' &&
          bbuf[result - 1] == '\n') {
        out.write(bbuf, 0, result - 2);  // skip the last 2 chars
        rnflag = true;  // make a note to write them on the next iteration
      }
      else {
        out.write(bbuf, 0, result);
      }
    }
    out.flush();
    out.close();
    fos.close();
  }

  // Extracts and returns the boundary token from a line.
  //
  private String extractBoundary(String line) {
    // Use lastIndexOf() because IE 4.01 on Win98 has been known to send the
    // "boundary=" string multiple times.  Thanks to David Wall for this fix.
    int index = line.lastIndexOf("boundary=");
    if (index == -1) {
      return null;
    }
    String boundary = line.substring(index + 9);  // 9 for "boundary="

    // The real boundary is always preceeded by an extra "--"
    boundary = "--" + boundary;

    return boundary;
  }

  // correct up to this point...............

  // Extracts and returns disposition info from a line, as a String array
  // with elements: disposition, name, filename.  Throws an IOException
  // if the line is malformatted.
  //
  private String[] extractDispositionInfo(String line, ServletRequest req) throws IOException {
    // Return the line's data as an array: disposition, name, filename
    String[] retval = new String[3];

    // Convert the line to a lowercase string without the ending \r\n
    // Keep the original line for error messages and for variable names.
    String origline = line;
    line = origline.toLowerCase();

    // Get the content disposition, should be "form-data"
    int start = line.indexOf("content-disposition: ");
    int end = line.indexOf(";");
    if (start == -1 || end == -1) {
      throw new IOException("Content disposition corrupt: " + origline);
    }
    String disposition = line.substring(start + 21, end);
    if (!disposition.equals("form-data")) {
      throw new IOException("Invalid content disposition: " + disposition);
    }

    // Get the field name
    start = line.indexOf("name=\"", end);  // start at last semicolon
    end = line.indexOf("\"", start + 7);   // skip name=\"
    if (start == -1 || end == -1) {
      throw new IOException("Content disposition corrupt: " + origline);
    }
    String name = origline.substring(start + 6, end);

    // Get the filename, if given
    String filename = null;
    start = line.indexOf("filename=\"", end + 2);  // start after name
    end = line.indexOf("\"", start + 10);          // skip filename=\"
    if (start != -1 && end != -1) {                // note the !=
    filename = origline.substring(start + 10, end);



    /*  if(fileame != null){
		// to find out extension of file.......
   		int last = filename.lastIndexOf('.');
   		String ext = filename.substring(last);
  		filename = (String)req.getAttribute("filename") + ext;
 	  }  */


     // The filename may contain a full path.  Cut to just the filename.
      int slash =
        Math.max(filename.lastIndexOf('/'), filename.lastIndexOf('\\'));
      if (slash > -1) {
        filename = filename.substring(slash + 1);  // past last slash
      }

      if (filename.equals("")) filename = "unknown"; // sanity check
    }

    // Return a String array: disposition, name, filename
    retval[0] = disposition;
    retval[1] = name;
    retval[2] = filename;
    return retval;
  }

  // Extracts and returns the content type from a line, or null if the
  // line was empty.  Throws an IOException if the line is malformatted.
  //
  private String extractContentType(String line) throws IOException {
    String contentType = null;

    // Convert the line to a lowercase string
    String origline = line;
    line = origline.toLowerCase();

    // Get the content type, if any
    if (line.startsWith("content-type")) {
      int start = line.indexOf(" ");
      if (start == -1) {
        throw new IOException("Content type corrupt: " + origline);
      }
      contentType = line.substring(start + 1);
    }
    else if (line.length() != 0) {  // no content type, so should be empty
      throw new IOException("Malformed line after disposition: " + origline);
    }

    return contentType;
  }
}


// A class to hold information about an uploaded file.
//
class UploadedFile {

  private String dir;
  private String filename;
  private String type;

  UploadedFile(String dir, String filename, String type) {
    this.dir = dir;
    this.filename = filename;
    this.type = type;
  }

  public String getContentType() {
    return type;
  }

  public String getFilesystemName() {
    return filename;
  }

  public File getFile() {
    if (dir == null || filename == null) {
      return null;
    }
    else {
      return new File(dir + File.separator + filename);
    }
  }
}


// A class to aid in reading multipart/form-data from a ServletInputStream.
// It keeps track of how many bytes have been read and detects when the
// Content-Length limit has been reached.  This is necessary since some
// servlet engines are slow to notice the end of stream.
//
// Mac users: The Mac doesn't like class names which exceed 32 characters
// (including the ".class") so while this class is usable from a JAR
// anywhere, it won't compile on a Mac.
//
class MultipartInputStreamHandler {

  ServletInputStream in;
  String boundary;
  int totalExpected;
  int totalRead = 0;
  byte[] buf = new byte[8 * 1024];

  public MultipartInputStreamHandler(ServletInputStream in,
  									 String boundary,
                                     int totalExpected) {
    this.in = in;
    this.boundary = boundary;
    this.totalExpected = totalExpected;
  }

  // Reads the next line of input.  Returns null to indicate the end
  // of stream.
  //
  public String readLine() throws IOException {
    StringBuffer sbuf = new StringBuffer();
    int result;
    String line;

    do {
      result = this.readLine(buf, 0, buf.length);  // this.readLine() does +=
      if (result != -1) {
        sbuf.append(new String(buf, 0, result, "ISO-8859-1"));
      }
    } while (result == buf.length);  // loop only if the buffer was filled

    if (sbuf.length() == 0) {
      return null;  // nothing read, must be at the end of stream
    }

    sbuf.setLength(sbuf.length() - 2);  // cut off the trailing \r\n
    return sbuf.toString();
  }

  // A pass-through to ServletInputStream.readLine() that keeps track
  // of how many bytes have been read and stops reading when the
  // Content-Length limit has been reached.
  //

  public int readLine(byte b[], int off, int len) throws IOException {
    if (totalRead >= totalExpected) {
      return -1;
    }
    else {
      int result = in.readLine(b, off, len);
      if (result > 0) {
        totalRead += result;
      }
      return result;
    }
  }
}
