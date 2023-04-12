package model2.mvcboard;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import fileupload.FileUtil;

@WebServlet("/mvcboard/download.do")
public class DownloadController extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException {
        // �Ű����� �ޱ�
        String ofile = req.getParameter("ofile");  // ���� ���ϸ�
        String sfile = req.getParameter("sfile");  // ����� ���ϸ�
        String idx = req.getParameter("idx");      // �Խù� �Ϸù�ȣ

        // ���� �ٿ�ε�
        FileUtil.download(req, resp, "/Uploads", sfile, ofile);

        // �ش� �Խù��� �ٿ�ε� �� 1 ����
        MVCBoardDAO dao = new MVCBoardDAO();
        dao.downCountPlus(idx);
        dao.close();
    }
}

