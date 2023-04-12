package model2.mvcboard;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import fileupload.FileUtil;
import utils.JSFunction;

@WebServlet("/mvcboard/edit.do")
public class EditController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String idx = req.getParameter("idx");
        MVCBoardDAO dao = new MVCBoardDAO();
        MVCBoardDTO dto = dao.selectView(idx);
        req.setAttribute("dto", dto);
        req.getRequestDispatcher("/MVCBoard/Edit.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException {
        // 1. ���� ���ε� ó�� =============================
        // ���ε� ���͸��� ������ ��� Ȯ��
        String saveDirectory = req.getServletContext().getRealPath("/Uploads");

        // �ʱ�ȭ �Ű������� ������ ÷�� ���� �ִ� �뷮 Ȯ��
        ServletContext application = this.getServletContext();
        int maxPostSize = Integer.parseInt(application.getInitParameter("maxPostSize"));

        // ���� ���ε�
        MultipartRequest mr = FileUtil.uploadFile(req, saveDirectory, maxPostSize);

        if (mr == null) {
            // ���� ���ε� ����
            JSFunction.alertBack(resp, "÷�� ������ ���� �뷮�� �ʰ��մϴ�.");
            return;
        }

        // 2. ���� ���ε� �� ó�� =============================
        // ���� ������ �Ű��������� ����
        String idx = mr.getParameter("idx");
        String prevOfile = mr.getParameter("prevOfile");
        String prevSfile = mr.getParameter("prevSfile");

        String name = mr.getParameter("name");
        String title = mr.getParameter("title");
        String content = mr.getParameter("content");
            
        // ��й�ȣ�� session���� ������
        HttpSession session = req.getSession();
        String pass = (String)session.getAttribute("pass");

        // DTO�� ����
        MVCBoardDTO dto = new MVCBoardDTO();
        dto.setIdx(idx);
        dto.setName(name);
        dto.setTitle(title);
        dto.setContent(content);
        dto.setPass(pass);
            
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

            // DTO�� ����
            dto.setOfile(fileName);  // ���� ���� �̸�
            dto.setSfile(newFileName);  // ������ ����� ���� �̸�

            // ���� ���� ����
            FileUtil.deleteFile(req, "/Uploads", prevSfile);
        }
        else {
            // ÷�� ������ ������ ���� �̸� ����
            dto.setOfile(prevOfile);
            dto.setSfile(prevSfile);
        }

        // DB�� ���� ���� �ݿ�
        MVCBoardDAO dao = new MVCBoardDAO();
        int result = dao.updatePost(dto);
        dao.close();

        // ���� or ����?
        if (result == 1) {  // ���� ����
            session.removeAttribute("pass");
            resp.sendRedirect("../mvcboard/view.do?idx=" + idx);
        }
        else {  // ���� ����
            JSFunction.alertLocation(resp, "��й�ȣ ������ �ٽ� �������ּ���.",
                "../mvcboard/view.do?idx=" + idx);
        }
    }
}