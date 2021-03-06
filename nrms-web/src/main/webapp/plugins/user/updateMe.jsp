<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/common-ui.jsp"%>
<html>

<script type="text/javascript">
/* 用户重置或者修改自己的邮箱 */	
	function resetEmail(id){
		var email = $("#newEmail").val();
		//var newLoginPw = $("#reNewPwd").val();
		if(checkBlank(email)){
			var reg = /^(\w)+(\.\w+)*@(\w)+((\.\w+)+)$/;
			if(!reg.test(email)){
				debugger;
				$("#msgBoxInfo").html("邮箱格式不正确，请填写正确的邮箱");
				$("#msgBox").modal('show');
				return;
			}
		}
		$("#msgBoxConfirmInfo").html("确定要修改邮箱吗?");
		$("#msgBoxConfirm").modal('show');
		$("#msgBoxConfirmButton").on('click' , function(){
			$("#msgBoxConfirm").modal('hide');
			$.ajax({
				type : 'POST',
				url : '${basePath}/user/resetUserInfo',
				data : {
					'id' : id,
					'email' : email
				},
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						$("#msgBoxInfo").html(data.msg);
						$("#msgBox").modal('show');
						$("#msgBoxOKButton").on('click' , function(){
							window.location.href = "${basePath}/" ;
						});
					} else {
						$("#msgBoxInfo").html(data.msg);
						$("#msgBox").modal('show');
					}
				},
				error : function(data) {
					$("#msgBoxInfo").html("程序执行出错");
					$("#msgBox").modal('show');
				}
			});
		});
	}
	
</script>

<head>
</head>

<body>

<%@include file="/common/headAndLeft.jsp"%>
		<div class="up-modal-body" style="margin-top: 100px; margin-left: 200px;">
		<form id="dataForm" class="up-form-horizontal">
			<input type="hidden" id="id" name="id" value="${user.id }" />
			<div class="up-form-group">
				<label for="" class="up-col-sm-2 up-control-label">
					<span class="up-cq-red-star">*</span>登录账号
				</label>
				<div class="up-col-sm-7">
					<input type="text" class="up-form-control" id="loginName" name="loginName" placeholder="请输入帐号" <c:if test="${not empty  user }">readOnly="true"</c:if> value="${user.loginName }">
				</div>
			</div>
			<div class="up-form-group">
				<label for="" class="up-col-sm-2 up-control-label">
					<span class="up-cq-red-star">*</span>用户姓名
				</label>
				<div class="up-col-sm-7">
					<input type="text" class="up-form-control" id="uname" name="uname" placeholder="请输入姓名" <c:if test="${not empty  user }">readOnly="true"</c:if>  value="${user.uname }">
				</div>
			</div>
			<div class="up-form-group">
				<label for="" class="up-col-sm-2 up-control-label">
					<span class="up-cq-red-star"></span>邮箱
				</label>
				<div class="up-col-sm-7">
					<input type="text" class="up-form-control" id="newEmail" name="email" placeholder="请输入邮箱"   value="${user.email }">
				</div>
			</div>
			
<%-- 			<c:if test="${not empty user }">
				<div class="up-form-group">
					<label for="" class="up-col-sm-2 up-control-label">
						<span class="up-cq-red-star">*</span>新的邮箱
					</label>
					<div class="up-col-sm-7">
						<input type="text" class="up-form-control" id="newEmail" name="newEmail" placeholder="请输入新的邮箱"   value="">
					</div>
				</div>
			</c:if> --%>
			
			<div class="up-form-group">
				<label for="" class="up-col-sm-2 up-control-label">
					<span class="up-cq-red-star">*</span>角色
				</label>
				<div class="up-col-sm-4">
					<c:if test="${not empty  user }">
						<select name="roleId1" id="roleId" class="up-form-control" <c:if test="${not empty  user }">disabled="disabled"</c:if> style="width:260px">
							<option value="${user.roleId }" >${user.role }</option>
						</select>
					</c:if>
					<c:if test="${ empty  user }">
						<select name="roleId" id="roleId" class="up-form-control" style="width:260px">
							<option value="">请选择</option>
							<c:forEach var="rolelist" items="${rolelist }">
								<option value="${rolelist.id }">${rolelist.roleName }</option>
							</c:forEach>
						</select>
					</c:if>
				</div>
			</div>
			
			<div class="up-form-group">
				<label for="" class="up-col-sm-2 up-control-label">
					<span class="up-cq-red-star">*</span>部门
				</label>
				<div class="up-col-sm-4">
					<c:if test="${not empty  user }">
						<select name="deptKey1" id="deptKey" class="up-form-control"  <c:if test="${not empty  user }">disabled="disabled"</c:if> style="width:260px">
							<option value="${user.deptKey }" >${user.dept }</option>
						</select>
					</c:if>
					<c:if test="${ empty  user }">
						<select name="deptKey" id="deptKey" class="up-form-control" style="width:260px">
							<option value="">请选择</option>
							<c:forEach var="departlist" items="${departlist }">
								<option value="${departlist.dicKey }">${departlist.dicValue }</option>
							</c:forEach>
						</select>
					</c:if>
				</div>
			</div>
			
			<div class="up-form-group">
				<label for="" class="up-col-sm-2 up-control-label">
					<span class="up-cq-red-star">*</span>工作
				</label>
				<div class="up-col-sm-4">
					<c:if test="${not empty  user }">
						<select name="jobKey1" id="jobKey" class="up-form-control"  <c:if test="${not empty  user }">disabled="disabled"</c:if> style="width:260px">
							<option value="${user.jobKey }" >${user.job }</option>
						</select>
					</c:if>
					<c:if test="${ empty  user }">
						<select name="jobKey" id="jobKey" class="up-form-control" style="width:260px">
							<option value="">请选择</option>
							<c:forEach var="jobtlist" items="${jobtlist }">
								<option value="${jobtlist.dicKey }">${jobtlist.dicValue }</option>
							</c:forEach>
						</select>
					</c:if>
				</div>
			</div>
			
			<div class="up-form-group">
				<label for="" class="up-col-sm-2 up-control-label">
					<span class="up-cq-red-star">*</span>职位
				</label>
				<div class="up-col-sm-4">
					<c:if test="${not empty  user }">
						<select name="positionKey1" id="positionKey" class="up-form-control"  <c:if test="${not empty  user }">disabled="disabled"</c:if> style="width:260px">
							<option value="${user.positionKey }" >${user.posi }</option>
						</select>
					</c:if>
					<c:if test="${ empty  user }">
						<select name="positionKey" id="positionKey" class="up-form-control" style="width:260px">
							<option value="">请选择</option>
							<c:forEach var="positionlist" items="${positionlist }">
								<option value="${positionlist.dicKey }">${positionlist.dicValue }</option>
							</c:forEach>
						</select>
					</c:if>
				</div>
			</div>
		</form>
	</div>
	<div class="up-modal-footer up-modal-footer1">
		<button type="button" class="up-btn up-btn-primary" onClick="resetEmail('${user.id }')">保存</button>
		<a href="${basePath }/" ><button type="button" class="up-btn up-btn-default" onClick="parent.window.hideDialog()">取消</button></a>
	</div>
	
	<!--    提示框 start -->
		<%@include file="/common/msgBox.jsp"%>
		<!--    提示框 -->
	
</body>

</html>
