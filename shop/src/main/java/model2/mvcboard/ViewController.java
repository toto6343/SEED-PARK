package model2.mvcboard;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/mvcboard/view.do")
public class ViewController extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException {
        // �Խù� �ҷ�����
        MVCBoardDAO dao = new MVCBoardDAO();
        String idx = req.getParameter("idx");
        dao.updateVisitCount(idx);  // ��ȸ�� 1 ����
        MVCBoardDTO dto = dao.selectView(idx);
        dao.close();

        // �ٹٲ� ó��
        dto.setContent(dto.getContent().replaceAll("\r\n", "<br/>"));

        // �Խù�(dto) ���� �� ��� ������
        req.setAttribute("dto", dto);
        req.getRequestDispatcher("/MVCBoard/View.jsp").forward(req, resp);
    }
}