package model2.mvcboard;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import utils.BoardPage;

public class ListController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
       // DAO ����
       MVCBoardDAO dao = new MVCBoardDAO();

        // �信 ������ �Ű����� ����� �� ����
        Map<String, Object> map = new HashMap<String, Object>();

        String searchField = req.getParameter("searchField");
        String searchWord = req.getParameter("searchWord");
        if (searchWord != null) {
            // ������Ʈ������ ���޹��� �Ű����� �� �˻�� �ִٸ� map�� ����
            map.put("searchField", searchField);
            map.put("searchWord", searchWord);
        }
        int totalCount = dao.selectCount(map);  // �Խù� ����

        /* ������ ó�� start */
        ServletContext application = getServletContext();
        int pageSize = Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
        int blockPage = Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));

        // ���� ������ Ȯ��
        int pageNum = 1;  // �⺻��
        String pageTemp = req.getParameter("pageNum");
        if (pageTemp != null && !pageTemp.equals(""))
            pageNum = Integer.parseInt(pageTemp); // ��û���� �������� ����

        // ��Ͽ� ����� �Խù� ���� ���
        int start = (pageNum - 1) * pageSize + 1;  // ù �Խù� ��ȣ
        int end = pageNum * pageSize; // ������ �Խù� ��ȣ
        map.put("start", start);
        map.put("end", end);
        /* ������ ó�� end */

        List<MVCBoardDTO> boardLists = dao.selectListPage(map);  // �Խù� ��� �ޱ�
        dao.close(); // DB ���� �ݱ�

        // �信 ������ �Ű����� �߰�
        String pagingImg = BoardPage.pagingStr(totalCount, pageSize,
                blockPage, pageNum, "../mvcboard/list.do");  // �ٷΰ��� ���� HTML ���ڿ�
        map.put("pagingImg", pagingImg);
        map.put("totalCount", totalCount);
        map.put("pageSize", pageSize);
        map.put("pageNum", pageNum);

        // ������ �����͸� request ������ ���� �� List.jsp�� ������
        req.setAttribute("boardLists", boardLists);
        req.setAttribute("map", map);
        req.getRequestDispatcher("/MVCBoard/List.jsp").forward(req, resp);
    }
}
