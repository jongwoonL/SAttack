package data;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DBBean {

	private static DBBean instance = new DBBean();

	public static DBBean getInstance() {
		return instance;
	}

	private DBBean() {
	}

	// 커넥션풀로부터 커넥션객체를 얻어내는 메소드
	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/basicjsp");
		return ds.getConnection();
	}

	// 시각화에 사용할 국가별 카운트 데이터를 얻어내는 메소드
		public List<DataBean> getDatas() throws Exception {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List<DataBean> dataList = null;

			try {
				conn = getConnection();

				String sql1 = "SELECT * from data order by cNum2020 desc;";
				pstmt = conn.prepareStatement(sql1);				
				rs = pstmt.executeQuery();

				if (rs.next()) {
					dataList = new ArrayList<DataBean>();
					do {
						DataBean data = new DataBean();
						data.setcName(rs.getString("cName"));
						data.setcCode(rs.getString("cCode"));
						data.setLongitude(rs.getFloat("longitude"));
						data.setLatitude(rs.getFloat("latitude"));
						data.setcNum2018(rs.getInt("cNum2018"));
						data.setcNum2019(rs.getInt("cNum2019"));
						data.setcNum2020(rs.getInt("cNum2020"));

						dataList.add(data);
					} while (rs.next());
				}
			} catch (Exception ex) {
				ex.printStackTrace();
			} finally {
				if (rs != null)
					try {
						rs.close();
					} catch (SQLException ex) {
					}
				if (pstmt != null)
					try {
						pstmt.close();
					} catch (SQLException ex) {
					}
				if (conn != null)
					try {
						conn.close();
					} catch (SQLException ex) {
					}
			}		    
			return dataList;
		}
}
