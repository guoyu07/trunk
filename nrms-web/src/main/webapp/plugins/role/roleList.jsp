<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="/com.eshore.InitDataTag" prefix="i" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>
<script>
    var basePath = '${basePath}';
</script>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="renderer" content="webkit">
    <title>网络资源管理系统</title>
    <meta name="description" content="">
    <meta name="keywords" content="">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <link rel="stylesheet" href="${basePath }/resources/css/uplan.min.css">
    <link href="${basePath }/resources/css/style.css" rel="stylesheet">

    <script src="${basePath }/resources/js/require.js"></script>
    <script src="${basePath }/resources/js/main.js"></script>

    <script type="text/javascript" charset="utf-8" src="${basePath }/resources/js/common-check.js"></script>
    <style type="text/css">
        html, body {
            height: 100%;
            position: relative;
        }
    </style>

    <link rel="stylesheet" href="${basePath}/resources/css/zTreeStyle.css" type="text/css">
    <script type="text/javascript" src="${basePath}/resources/js/jquery-1.4.4.min.js"></script>
    <script type="text/javascript" src="${basePath}/resources/js/jquery.ztree.core.js"></script>
    <script type="text/javascript" src="${basePath}/resources/js/jquery.ztree.excheck.js"></script>


    <script type="text/javascript">
        function showDialog(title, url, height) {
            $("#modalDialogTitle").html(title);
            $("#modalDialogFrame").attr("height", height);
            $("#modalDialogFrame").attr("src", url);
            $("#modalDialog").modal('show');
        }

        function hideDialog() {
            $("#modalDialog").modal('hide');
        }

        function deleteUser(id) {

            $("#msgBoxConfirmInfo").html("确定要删除该角色吗");
            $("#msgBoxConfirm").modal('show');
            $("#msgBoxConfirmButton").on('click', function () {
                $("#msgBoxConfirm").modal('hide');
                $.ajax({
                    type: 'POST',
                    dataType: 'json',
                    url: '${basePath}/role/delete',
                    data: {
                        'id': id
                    },
                    success: function (data) {
                        if (data.success) {
                            $("#msgBoxInfo").html(data.msg);
                            $("#msgBox").modal('show');
                            $("#msgBoxOKButton").on('click', function () {
                                parent.window.location.reload();
                            });
                        } else {
                            $("#msgBoxInfo").html(data.msg);
                            $("#msgBox").modal('show');
                            $("#msgBoxOKButton").on('click', function () {
                                parent.window.location.reload();
                            });
                        }
                    },
                    error: function (data) {
                        $("#msgBoxInfo").html("程序执行出错");
                        $("#msgBox").modal('show');
                    }
                });
            });

        }

        function resetUserPwd(userId) {

            $("#msgBoxConfirm").modal('show');
            $("#msgBoxConfirmButton").on('click', function () {
                $("#msgBoxConfirm").modal('hide');
                $.ajax({
                    type: 'POST',
                    url: '${basePath}/role/resetpwd',
                    data: {
                        'id': id
                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data.success) {
                            $("#msgBoxInfo").html(data.msg);
                            $("#msgBox").modal('show');
                            $("#msgBoxOKButton").on('click', function () {
                                window.location.reload();
                            });
                        } else {
                            $("#msgBoxInfo").html(data.msg);
                            $("#msgBox").modal('show');
                        }
                    },
                    error: function (data) {
                        $("#msgBoxInfo").html("程序执行出错");
                        $("#msgBox").modal('show');
                    }
                });
            });

        }

        function showDialog(title, url, height) {
            $("#modalDialogTitle").html(title);
            $("#modalDialogFrame").attr("height", height);
            $("#modalDialogFrame").attr("src", url);
            $("#modalDialog").modal('show');
        }

        function hideDialog() {
            $("#modalDialog").modal('hide');
        }
    </script>

    <head>
    </head>

<body>
<div id="wrap" class="">
    <!--    头部 和  菜单 start -->
    <%@include file="/common/headAndLeft.jsp" %>
    <!--    头部 和  菜单 end -->

    <!-- 内容start -->
    <main class="main up-container-fluid">
        <div class="up-tab-content">
            <div class="up-tab-pane up-active" id="tabs1">
                <div class="border_btm first_title">
                    <h4 class="up-top-cq-color">
                        <span class="icon-right-dir"></span> 角色管理
                    </h4>
                </div>
                <div class="up_page_con">
                    <div class="ex_tab2" role="tabpanel" data-example-id="togglable-tabs">
                        <div id="" class="up-tab-content">
                            <div role="tabpanel" class="up-tab-pane up-active" id="mytab11"
                                 aria-labelledby="mytab11-tab">
                                <div class="up-table-responsive">
                                    <div class="up-cq-table">
                                        <div class="up-cq-table-outer">
                                            <div class="up-cq-table-inner">
                                                <div class="up-clearfix table_head margin_bottom10">
                                                    <div class="reference_search">

                                                        <form class="up-form-inline" id="searchForm" method="post"
                                                              action="${basePath}/role/list">
                                                            <input type="hidden" id="pageNum" name="pageNum" value="1">
                                                            <div class="up-form-group">
                                                                <label for="" class="up-control-label">角色名:</label>
                                                                <input type="text" class="up-form-control" id="key"
                                                                       name="roleName" value="${searchParam.roleName}">
                                                            </div>
                                                            <div class="up-form-group">
                                                                <button type="submit" class="up-btn up-btn-primary">查询
                                                                </button>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                                <div class="up-clearfix table_head">
                                                    <div class="reference_search">
                                                        <div class="up-form-group">
                                                            <button type="submit"
                                                                    class="up-btn up-btn-primary up-btn-primary-red"
                                                                    data-toggle="modal"
                                                                    onClick="showDialog('新增角色' , '${basePath}/role/toadd' , '470px')">
                                                                新增
                                                            </button>
                                                        </div>
                                                    </div>
                                                </div>
                                                <table
                                                        class="up-table up-table-bordered up-table-hover margin_bottom10 up-text-center">
                                                    <thead>
                                                    <tr class="up-active">
                                                        <th>编号</th>
                                                        <th>角色名</th>
                                                        <th>角色描述</th>
                                                        <th>操作</th>
                                                    </tr>
                                                    </thead>
                                                    <tbody>
                                                    <%
                                                        Integer i = 1;
                                                    %>
                                                    <c:forEach var="role" items="${page.dataList }">
                                                        <tr>
                                                            <td><%out.print(i++); %></td>
                                                            <td>${role.roleName}</td>
                                                            <td>${role.roleDesc}</td>
                                                            <td>

                                                                <a href="javascript:void(0)"
                                                                   onClick="showDialog('编辑' , '${basePath}/role/toedit?id=${role.id }' , '470px')">修改</a>
                                                                <a href="javascript:void(0)"
                                                                   onClick="deleteUser('${role.id}')">删除</a>

                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                    </tbody>
                                                </table>

                                                <div class="up-clearfix">
                                                    <div class="up-pull-right">
                                                        <%@include file="/common/page.jsp" %>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- 侧栏提示工具容器 -->
    <div id="tooltip_box"></div>
    <!-- 侧栏提示工具容器 -->

    <!--    提示框 start -->
    <%@include file="/common/msgBox.jsp" %>
    <!--    提示框 -->

    <div class="up-modal up-fade" id="modalDialog" data-drag="true" data-backdrop="static">
        <div class="up-modal-dialog up-modal-lg">
            <div class="up-modal-content">
                <div class="up-modal-header">
                    <button type="button" class="up-close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">×</span></button>
                    <h4 class="up-modal-title" id="modalDialogTitle">新增角色</h4>
                </div>
                <iframe id="modalDialogFrame" width="100%" height="420px" frameborder="0"></iframe>
            </div>
        </div>
    </div>

</div>
</body>

</html>
