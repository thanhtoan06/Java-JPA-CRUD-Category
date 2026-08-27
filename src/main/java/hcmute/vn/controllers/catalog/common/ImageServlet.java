package hcmute.vn.controllers.catalog.common;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;

@WebServlet("/uploads/*")
public class ImageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String DEFAULT_AVATAR_SVG = 
        "<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='%2394a3b8'>" +
        "<path d='M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 4c1.93 0 3.5 1.57 3.5 3.5S13.93 13 12 13s-3.5-1.57-3.5-3.5S10.07 6 12 6zm0 14c-2.03 0-3.8-.85-5.05-2.2.03-1.67 3.33-2.58 5.05-2.58 1.72 0 5.02.91 5.05 2.58C15.8 19.15 14.03 20 12 20z'/>" +
        "</svg>";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        resp.setHeader("Pragma", "no-cache");
        resp.setDateHeader("Expires", 0);

        String imagePath = req.getPathInfo();
        if (imagePath == null || imagePath.equals("/")) {
            sendDefaultImage(resp);
            return;
        }

        String realPath = getServletContext().getRealPath("/uploads" + imagePath);
        File file = new File(realPath);

        if (!file.exists()) {
            try {
                if (realPath != null && realPath.contains(".metadata")) {
                    File deployedFolder = new File(getServletContext().getRealPath(""));
                    String projectName = deployedFolder.getName();
                    String workspacePath = realPath.substring(0, realPath.indexOf(".metadata"));

                    String projectPath = workspacePath + projectName + File.separator 
                                       + "src" + File.separator + "main" + File.separator 
                                       + "webapp" + File.separator + "uploads" + imagePath;
                    file = new File(projectPath);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        if (!file.exists()) {
            sendDefaultImage(resp);
            return;
        }

        String contentType = getServletContext().getMimeType(file.getName());
        if (contentType == null) contentType = "image/png";
        resp.setContentType(contentType);
        resp.setContentLength((int) file.length());

        try (BufferedInputStream in = new BufferedInputStream(new FileInputStream(file));
             BufferedOutputStream out = new BufferedOutputStream(resp.getOutputStream())) {
            byte[] buffer = new byte[1024];
            int length;
            while ((length = in.read(buffer)) > 0) {
                out.write(buffer, 0, length);
            }
        }
    }

    private void sendDefaultImage(HttpServletResponse resp) throws IOException {
        resp.setContentType("image/svg+xml");
        resp.getWriter().write(DEFAULT_AVATAR_SVG);
    }
}