package model2.mvcboard;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import fileupload.FileUtil;
import utils.JSFunction;

public class WriteController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/MVCBoard/Write.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // 1. ���� ���ε� ó�� =============================
        // ���ε� ���͸��� ������ ��� Ȯ��
        String saveDirectory = req.getServletContext().getRealPath("/Uploads");

        // �ʱ�ȭ �Ű������� ������ ÷�� ���� �ִ� �뷮 Ȯ��
        ServletContext application = getServletContext();
        int maxPostSize = Integer.parseInt(application.getInitParameter("maxPostSize"));

        // ���� ���ε�
        MultipartRequest mr = FileUtil.uploadFile(req, saveDirectory, maxPostSize);
        if (mr == null) {
            // ���� ���ε� ����
            JSFunction.alertLocation(resp, "÷�� ������ ���� �뷮�� �ʰ��մϴ�.",
                                     "../mvcboard/write.do");  
            return;
        }

        // 2. ���� ���ε� �� ó�� =============================
        // ������ DTO�� ����
        MVCBoardDTO dto = new MVCBoardDTO(); 
        dto.setName(mr.getParameter("name"));
        dto.setTitle(mr.getParameter("title"));
        dto.setContent(mr.getParameter("content"));
        dto.setPass(mr.getParameter("pass"));

        // ���� ���ϸ�� ����� ���� �̸� ����
        String fileName = mr.getFilesystemName("ofile");
        if (fileName != null) {
            // ÷�� ������ ���� ��� ���ϸ� ����
            // ���ο� ���ϸ� ����
            String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
            String ext = fileName.substring(fileName.lastIndexOf("."));
            String newFileName = now + ext;

            // ���ϸ� ����
            File oldFile = new File(saveDirectory + File.separator + fileName);
            File newFile = new File(saveDirectory + File.separator + newFileName);
            oldFile.renameTo(newFile);
            
            dto.setOfile(fileName);  // ���� ���� �̸�
            dto.setSfile(newFileName);  // ������ ����� ���� �̸�
        }

        // DAO�� ���� DB�� �Խ� ���� ����
        MVCBoardDAO dao = new MVCBoardDAO();
        int result = dao.insertWrite(dto);
        dao.close();

        // ���� or ����?
        if (result == 1) {  // �۾��� ����
            resp.sendRedirect("../mvcboard/list.do");
        }
        else {  // �۾��� ����
            resp.sendRedirect("../mvcboard/write.do");
        }
    }}
