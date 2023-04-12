package model2.mvcboard;

import java.util.List;
import java.util.Map;
import java.util.Vector;

import common.DBConnPool;

public class MVCBoardDAO extends DBConnPool {
    public MVCBoardDAO() {
        super();
    }

    // �˻� ���ǿ� �´� �Խù��� ������ ��ȯ�մϴ�.
    public int selectCount(Map<String, Object> map) {
        int totalCount = 0;
        String query = "SELECT COUNT(*) FROM mvcboard";
        if (map.get("searchWord") != null) {
            query += " WHERE " + map.get("searchField") + " "
                   + " LIKE '%" + map.get("searchWord") + "%'";
        }
        try {
            stmt = con.createStatement();
            rs = stmt.executeQuery(query);
            rs.next();
            totalCount = rs.getInt(1);
        }
        catch (Exception e) {
            System.out.println("�Խù� ī��Ʈ �� ���� �߻�");
            e.printStackTrace();
        }

        return totalCount;
    }

    // �˻� ���ǿ� �´� �Խù� ����� ��ȯ�մϴ�(����¡ ��� ����).
    public List<MVCBoardDTO> selectListPage(Map<String,Object> map) {
        List<MVCBoardDTO> board = new Vector<MVCBoardDTO>();
        String query = " "
                     + "SELECT * FROM ( "
                     + "    SELECT Tb.*, ROWNUM rNum FROM ( "
                     + "        SELECT * FROM mvcboard ";

        if (map.get("searchWord") != null)
        {
            query += " WHERE " + map.get("searchField")
                   + " LIKE '%" + map.get("searchWord") + "%' ";
        }

        query += "        ORDER BY idx DESC "
               + "    ) Tb "
               + " ) "
               + " WHERE rNum BETWEEN ? AND ?";

        try {
            psmt = con.prepareStatement(query);
            psmt.setString(1, map.get("start").toString());
            psmt.setString(2, map.get("end").toString());
            rs = psmt.executeQuery();

            while (rs.next()) {
                MVCBoardDTO dto = new MVCBoardDTO();

                dto.setIdx(rs.getString(1));
                dto.setName(rs.getString(2));
                dto.setTitle(rs.getString(3));
                dto.setContent(rs.getString(4));
                dto.setPostdate(rs.getDate(5));
                dto.setOfile(rs.getString(6));
                dto.setSfile(rs.getString(7));
                dto.setDowncount(rs.getInt(8));
                dto.setPass(rs.getString(9));
                dto.setVisitcount(rs.getInt(10));

                board.add(dto);
            }
        }
        catch (Exception e) {
            System.out.println("�Խù� ��ȸ �� ���� �߻�");
            e.printStackTrace();
        }
        return board;
    }

    // �Խñ� �����͸� �޾� DB�� �߰��մϴ�(���� ���ε� ����).
    public int insertWrite(MVCBoardDTO dto) {
        int result = 0;
        try {
            String query = "INSERT INTO mvcboard ( "
                         + " idx, name, title, content, ofile, sfile, pass) "
                         + " VALUES ( "
                         + " seq_board_num.NEXTVAL,?,?,?,?,?,?)";
            psmt = con.prepareStatement(query);
            psmt.setString(1, dto.getName());
            psmt.setString(2, dto.getTitle());
            psmt.setString(3, dto.getContent());
            psmt.setString(4, dto.getOfile());
            psmt.setString(5, dto.getSfile());
            psmt.setString(6, dto.getPass());
            result = psmt.executeUpdate();
        }
        catch (Exception e) {
            System.out.println("�Խù� �Է� �� ���� �߻�");
            e.printStackTrace();
        }
        return result;
    }

    // �־��� �Ϸù�ȣ�� �ش��ϴ� �Խù��� DTO�� ��� ��ȯ�մϴ�.
    public MVCBoardDTO selectView(String idx) {
        MVCBoardDTO dto = new MVCBoardDTO();  // DTO ��ü ����
        String query = "SELECT * FROM mvcboard WHERE idx=?";  // ������ ���ø� �غ�
        try {
            psmt = con.prepareStatement(query);  // ������ �غ�
            psmt.setString(1, idx);  // ���Ķ���� ����
            rs = psmt.executeQuery();  // ������ ����

            if (rs.next()) {  // ����� DTO ��ü�� ����
                dto.setIdx(rs.getString(1));
                dto.setName(rs.getString(2));
                dto.setTitle(rs.getString(3));
                dto.setContent(rs.getString(4));
                dto.setPostdate(rs.getDate(5));
                dto.setOfile(rs.getString(6));
                dto.setSfile(rs.getString(7));
                dto.setDowncount(rs.getInt(8));
                dto.setPass(rs.getString(9));
                dto.setVisitcount(rs.getInt(10));
            }
        }
        catch (Exception e) {
            System.out.println("�Խù� �󼼺��� �� ���� �߻�");
            e.printStackTrace();
        }
        return dto;  // ��� ��ȯ
    }

    // �־��� �Ϸù�ȣ�� �ش��ϴ� �Խù��� ��ȸ���� 1 ������ŵ�ϴ�.
    public void updateVisitCount(String idx) {
        String query = "UPDATE mvcboard SET "
                     + " visitcount=visitcount+1 "
                     + " WHERE idx=?"; 
        try {
            psmt = con.prepareStatement(query);
            psmt.setString(1, idx);
            psmt.executeQuery();
        }
        catch (Exception e) {
            System.out.println("�Խù� ��ȸ�� ���� �� ���� �߻�");
            e.printStackTrace();
        }
    }

    // �ٿ�ε� Ƚ���� 1 ������ŵ�ϴ�.
    public void downCountPlus(String idx) {
        String sql = "UPDATE mvcboard SET "
                + " downcount=downcount+1 "
                + " WHERE idx=? "; 
        try {
            psmt = con.prepareStatement(sql);
            psmt.setString(1, idx);
            psmt.executeUpdate();
        }
        catch (Exception e) {}
    }
    // �Է��� ��й�ȣ�� ������ �Ϸù�ȣ�� �Խù��� ��й�ȣ�� ��ġ�ϴ��� Ȯ���մϴ�.
    public boolean confirmPassword(String pass, String idx) {
        boolean isCorr = true;
        try {
            String sql = "SELECT COUNT(*) FROM mvcboard WHERE pass=? AND idx=?";
            psmt = con.prepareStatement(sql);
            psmt.setString(1, pass);
            psmt.setString(2, idx);
            rs = psmt.executeQuery();
            rs.next();
            if (rs.getInt(1) == 0) {
                isCorr = false;
            }
        }
        catch (Exception e) {
            isCorr = false;
            e.printStackTrace();
        }
        return isCorr;
    }

    // ������ �Ϸù�ȣ�� �Խù��� �����մϴ�.
    public int deletePost(String idx) {
        int result = 0;
        try {
            String query = "DELETE FROM mvcboard WHERE idx=?";
            psmt = con.prepareStatement(query);
            psmt.setString(1, idx);
            result = psmt.executeUpdate();
        }
        catch (Exception e) {
            System.out.println("�Խù� ���� �� ���� �߻�");
            e.printStackTrace();
        }
        return result;
    }

    // �Խñ� �����͸� �޾� DB�� ����Ǿ� �ִ� ������ �����մϴ�(���� ���ε� ����).
    public int updatePost(MVCBoardDTO dto) {
        int result = 0;
        try {
            // ������ ���ø� �غ�
            String query = "UPDATE mvcboard"
                         + " SET title=?, name=?, content=?, ofile=?, sfile=? "
                         + " WHERE idx=? and pass=?";

            // ������ �غ�
            psmt = con.prepareStatement(query);
            psmt.setString(1, dto.getTitle());
            psmt.setString(2, dto.getName());
            psmt.setString(3, dto.getContent());
            psmt.setString(4, dto.getOfile());
            psmt.setString(5, dto.getSfile());
            psmt.setString(6, dto.getIdx());
            psmt.setString(7, dto.getPass());

            // ������ ����
            result = psmt.executeUpdate();
        }
        catch (Exception e) {
            System.out.println("�Խù� ���� �� ���� �߻�");
            e.printStackTrace();
        }
        return result;
    }

}
