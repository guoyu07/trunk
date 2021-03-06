package com.eshore.nrms.controller;

import com.eshore.khala.common.model.PageConfig;
import com.eshore.nrms.sysmgr.pojo.Menu;
import com.eshore.nrms.sysmgr.pojo.Role;
import com.eshore.nrms.sysmgr.service.IMenuService;
import com.eshore.nrms.sysmgr.service.IRoleService;
import com.eshore.nrms.vo.ExecResult;
import com.eshore.nrms.vo.PageVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;
import java.util.UUID;

/**
 * Created by forgeeks at 2017-02-25 17:10
 */
@Controller
public class RoleController {

    @Autowired
    private IRoleService roleService;
    @Autowired
    IMenuService menuService;

    /**
     * 分页显示角色
     *
     * @param role
     * @param page
     * @return
     */

    @RequestMapping("/role/list")
    public ModelAndView list(Role role, PageConfig page) {
        ModelAndView view = new ModelAndView("role/roleList");
        PageVo<Role> list = roleService.queryRoleListByPage(role, page);
        view.addObject("page", list);
        view.addObject("searchParam", role);
        return view;
    }

    /**
     * 转向角色添加页面
     *
     * @return
     */
    @RequestMapping("/role/toadd")
    public ModelAndView toAdd() {
        List<Role> roles = roleService.list(new Role(), null);
        ModelAndView view = new ModelAndView("role/add");
        return view;
    }

    /**
     * 角色添加方法
     *
     * @param role
     * @param ids
     * @return
     */
    @RequestMapping("/role/add")
    @ResponseBody
    public ExecResult add(Role role, String ids) {
        ExecResult result = new ExecResult();
        Integer count = roleService.queryCountByRoleName(role.getRoleName());
        if (count >= 1) {
            result.setMsg("同名角色不合法！");
            result.setSuccess(false);
            return result;
        }
        role.setId(UUID.randomUUID().toString().substring(0, 31));
        roleService.save(role);
        String[] idArr = ids.split(",");
        roleService.distributeAccees(role, idArr);
        result.setMsg("保存成功");
        result.setSuccess(true);
        return result;
    }

    /**
     * 跳转角色编辑页面
     *
     * @param id
     * @return
     */
    @RequestMapping("/role/toedit")
    public ModelAndView toEdit(String id) {
        ModelAndView view = new ModelAndView("role/edit");
        view.addObject("role", roleService.get(id));
        List<Menu> list = menuService.queryMenuListByRoleId(id);
        String allUrl = "";
        for (Menu menu : list) allUrl += menu.getId() + " ";
        view.addObject("allUrl", allUrl);
        return view;
    }

    /**
     * 角色编辑逻辑操作
     *
     * @param role
     * @param ids
     * @return
     */
    @RequestMapping("/role/edit")
    @ResponseBody
    public ExecResult Edit(Role role, String ids) {
        ExecResult result = new ExecResult();
        roleService.update(role);
        String[] idArr = ids.split(",");

        roleService.updateAccess(role, idArr);

        result.setMsg("更新成功");
        result.setSuccess(true);
        return result;
    }

    /**
     * 删除角色，若有该角色活跃用户就删不了，否则就删除，相应菜单关联表也删除
     *
     * @param id
     * @return
     */
    @RequestMapping("/role/delete")
    @ResponseBody
    public ExecResult delete(String id) {
        ExecResult result = new ExecResult();
        if (roleService.queryCountOfRoleById(id) >= 1) {
            result.setMsg("删除失败！尚有用户属于该角色，请重新查看！");
            result.setSuccess(false);
            return result;
        }else {
            Role role = roleService.get(id);
            roleService.delete(id);
            roleService.updateAccess(role, null);
            result.setMsg("删除成功！");
            result.setSuccess(true);
            return result;
        }
    }

}
