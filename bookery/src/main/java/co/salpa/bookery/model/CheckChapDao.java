package co.salpa.bookery.model;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import co.salpa.bookery.model.entity.CheckChapVo;
import co.salpa.bookery.model.entity.CheckPageVo;

public interface CheckChapDao {

	List<CheckChapVo> selectAllByStudyId(int study_id) throws DataAccessException;
	
	CheckChapVo selectRecentChecked() throws DataAccessException;

	int selectActualChapsToday(Map<String, String> map) throws DataAccessException;
	
	int selectPlanChapsToday(Map<String, String> map) throws DataAccessException;
	
	List<CheckChapVo> selectAllByDate(Map<String, String> map) throws DataAccessException;

	void insertOne(CheckChapVo bean) throws DataAccessException;
	
	int updateOne(int id) throws DataAccessException;

	int updateTimeStudy(int study_id) throws DataAccessException;

}
