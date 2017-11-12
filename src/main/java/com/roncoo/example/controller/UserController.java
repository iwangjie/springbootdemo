package com.roncoo.example.controller;

import com.roncoo.example.bean.RoncooUser;
import com.roncoo.example.dao.RoncooUserDao;
import com.roncoo.example.util.base.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.websocket.server.PathParam;
import java.util.Date;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private RoncooUserDao roncooUserDao;

    @RequestMapping("/**")
    public String index(@RequestParam(value = "page",defaultValue = "1")Integer page, ModelMap map){
        if (null == page)page=1;
        //查询所有用户
        Page<RoncooUser> roncooUserPage = roncooUserDao.queryForPage(page, 5, "");
        map.put("page",roncooUserPage);
        return "userview/index";
    }

    @ResponseBody
    @RequestMapping("/{id}")
    public RoncooUser selectUser(@PathVariable Integer id){
        RoncooUser roncooUser = roncooUserDao.selectById(id);
        return roncooUser;
    }

    /**
     * 新增页面展示
     * @return
     */
    @RequestMapping(value = "/add",method = RequestMethod.GET)
    public String addview(){
        return "user/add";
    }

    /**
     * 插入用户
     * @return
     */
    @RequestMapping(value = "/add",method = RequestMethod.POST)
    public String adduser(@RequestParam("name") String name,ModelMap map){
        if (null==name||"".equals(name)){
            map.put("msg","用户名不能为空！");
            return "user/error";
        }
        RoncooUser roncooUser = new RoncooUser();
        roncooUser.setName(name);
        roncooUser.setCreateTime(new Date());
        roncooUserDao.insert(roncooUser);
        return "redirect:/user";
    }

    /**
     * 删除用户
     * @return
     */
    @RequestMapping(value = "/del/{id}",method = RequestMethod.POST)
    public String deleteUser(@PathVariable("id")Integer id, ModelMap map){
        if (null==id||"".equals(id)){
            map.put("msg","删除用户不存在！");
            return "user/error";
        }
        roncooUserDao.deleteById(id);
        return "redirect:/user";
    }

    /**
     * 编辑用户
     * @return
     */
    @RequestMapping(value = "/edit/{id}",method = RequestMethod.GET)
    public String editUser(@PathVariable("id")Integer id, ModelMap map){
        if (null==id||"".equals(id)){
            map.put("msg","编辑用户不存在！");
            return "user/error";
        }
        RoncooUser roncooUser = roncooUserDao.selectById(id);
        map.put("user",roncooUser);
        return "user/edit";
    }

    /**
     * 更新用户
     * @return
     */
    @RequestMapping(value = "/update",method = RequestMethod.POST)
    public ModelAndView updateUser(@RequestParam("id")Integer id,@RequestParam("name") String name, ModelMap map){
        ModelAndView mv = new ModelAndView("redirect:/user");//redirect模式
        if (null==id||"".equals(id)){
            map.put("msg","更新用户不存在！");
            mv.setViewName("redirect:/user/error");
        }
        RoncooUser roncooUser = roncooUserDao.selectById(id);
        roncooUser.setName(name);
        roncooUserDao.updateById(roncooUser);
        return mv;
    }

}
