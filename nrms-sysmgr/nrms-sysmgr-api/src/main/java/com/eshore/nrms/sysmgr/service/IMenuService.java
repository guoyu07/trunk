package com.eshore.nrms.sysmgr.service;

import com.eshore.khala.common.model.PageConfig;
import com.eshore.khala.core.api.IBaseService;
import com.eshore.nrms.sysmgr.pojo.Menu;

import java.util.List;

/**
 * Created by forgeeks at 2017-02-27 17:11
 */
public interface IMenuService extends IBaseService<Menu>{

    /**
     * 通过用户角色来显示不同用户菜单项
     * @param roleId
     * @return
     */
    public List<Menu> queryMenuListByRoleId(String roleId);

    /***
     * 可拓展成单独的菜单管理
     * @param menu
     * @param pageConfig
     * @return
     */
//    public List<Menu> querymenuListByPage(Menu menu, PageConfig pageConfig);




}