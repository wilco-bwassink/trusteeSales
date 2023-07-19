<%@ Page Language="VB" %>
<%@ Import Namespace="System.IO" %>
<%@ import Namespace="System.Data" %>
<%@ import Namespace="System.Math" %>
<%@ import Namespace="System.Data.OleDb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script Language="vb" runat="server">

  Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
    
        Dim oprDataInfo As New DirectoryInfo("E:\Websites\apps.wilco.org\countyclerk\trustee_sales\April\")
      DataDownloadList.DataSource = oprDataInfo.GetFiles("*_file_*.???")
      DataDownloadList.DataBind()
      DataDownloadList.Visible = True
      dataGridNote.Visible = True
      spaces.Visible = False
   
  End Sub

  Function getFileType(ByVal theFileName As String)
      Dim extName As String
      Dim theReturnString As String
      extName = Right(theFileName, 3)
      theReturnString = "<img src=""../wcimages/Icons/" & extName & ".gif"" width=""18"" height=""18"" border=""0"">&nbsp;<div class=""footnoteText"">" & extName.ToUpper() & "</div>"
      Return theReturnString
  End Function

  Function MakeHyperlink(ByVal theFileName As String)
    Dim fullPath As String
    Dim fileNumber As String
    fileNumber = mid(theFileName, 12, 8)
        fullPath = "<A target=""_blank"" HREF=""" & theFileName & """>" & fileNumber & "</a>"
    Return fullPath
  End Function

  Function getFileDate(ByVal theFileName As String)
    Dim extName As String
    Dim theReturnString As String
    extName = left(theFileName, 10)
   ' theReturnString = "<img src=""../wcimages/Icons/" & extName & ".gif"" width=""18"" height=""18"" border=""0"">&nbsp;<div class=""footnoteText"">" & extName.ToUpper() & "</div>"
    extName = Regex.Replace(extName,"-","/")
    return extName
    'Return theReturnString
  End Function

 Function changeFileSize(ByVal theBytes As Integer)
    Dim theNewSize As Double
    Dim theReturnText As String
    If (theBytes > 1048576) Then
      theNewSize = Round((theBytes / 1048576), 2)
      theReturnText = theNewSize.ToString()
      theReturnText = theReturnText & " Mb"
    ElseIf ((theBytes < 1048576) And (theBytes > 1024)) Then
      theNewSize = Round((theBytes / 1024), 0)
      theReturnText = theNewSize.ToString()
      theReturnText = theReturnText & " Kb"
    Else
      theReturnText = theBytes.ToString()
      If theReturnText = "0" Then theReturnText = "< 1"
      theReturnText = theReturnText & " bytes"
    End If
    Return theReturnText
  End Function

 

</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>County Clerk Notice of Trustee Sales</title>
    <LINK REL=Stylesheet TYPE="text/css" HREF="../PORTAL.wwv_setting.render_css.css">
</head>
<body topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0">
    <form id="form1" runat="server" style="text-align: center">

			<input type="HIDDEN" name="nolog" value="1">
			<input type="HIDDEN" name="index" value="407671">

<br>
    <h1>
      <asp:Label runat="server" id="PageTitle" CssClass="pageHeader" align="center" text="Notice of Trustee Sales" />
	</h1>
			<blockquote>
				<p><font size="2">The Trustee Sales are held the first Tuesday 
				of every month from 10:00 AM to 4:00 PM at the Northeast side of 
				the Justice Center Annex at 405 Martin Luther King, Georgetown, 
				Texas, 78626.&nbsp; The County Clerk&apos;s office has nothing to do 
				with the sale itself.&nbsp; We only post the notice of sales and then 
				after a sale is done the Trustee&apos;s Deed is recorded with us. <br><font color="red"><b>The 
                                first file labeled "File_Idx" is the alphabetical index of the Notice 
                                of Trustee Sales filed.</b></font></font></p>
	</blockquote>
	
	<asp:datagrid id="DataDownloadList" runat="server"
		  visible="true"
		  Width="400px"
		  CellPadding="2"
		  BorderWidth="1px"
		  AllowSorting="True"
		  BackColor="#E7E7E7"
		  cssClass="pageText"
		  ItemStyle-CssClass="pageText"
		  AlternatingItemStyle-CssClass="pageText"
		  AlternatingItemStyle-BackColor="#C1DAFB"
		  HeaderStyle-horizontalalign="Center"
		  HeaderStyle-forecolor="White"
		  HeaderStyle-Font-Bold="True"
		  HeaderStyle-BackColor="#004A8D"
		  AutoGenerateColumns="False"
		  HorizontalAlign="Center"
	   >
		  <columns>
			  <asp:TemplateColumn HeaderText="File Name" ItemStyle-Width="80px">
				  <ItemTemplate>
					  <%# MakeHyperlink((DataBinder.Eval(Container.DataItem, "Name"))) %>
				  </ItemTemplate>
			  </asp:TemplateColumn>
			  <asp:TemplateColumn HeaderText="File Size" ItemStyle-Width="80px" ItemStyle-HorizontalAlign="Center">
				  <ItemTemplate>
					  <b><%# changeFileSize(DataBinder.Eval(Container.DataItem, "Length")) %></b>
				  </ItemTemplate>
			  </asp:TemplateColumn>
			  <asp:TemplateColumn HeaderText="Creation Date" ItemStyle-Width="80px" ItemStyle-HorizontalAlign="Center">
				  <ItemTemplate>
					  <b><%# getFileDate((DataBinder.Eval(Container.DataItem, "Name"))) %></b>							  
				  </ItemTemplate>
			  </asp:TemplateColumn>
			  <asp:TemplateColumn HeaderText="File Type" Visible="false" ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Middle">
				  <ItemTemplate>
					  <%# getFileType((DataBinder.Eval(Container.DataItem, "Name"))) %>
				  </ItemTemplate>
			  </asp:TemplateColumn>

		  </columns>
	  </asp:datagrid>
	  <asp:Label runat="server" id="spaces" cssClass="pageText" visible="true"><br/><br/><br/><br/></asp:label>
  <p>
  <br>
  <asp:label runat="server" id="dataGridNote" cssClass="legalText" visible="false"><br/>
	  Please note: The data depicted in the above table is the most current data available. It is read
	  each time this page is called. If you believe that this information is in error, please contact
	  the <a href="mailto:webmaster@wilco.org" target="_self">Webmaster</a>.
  </asp:label>
</p>

<p>&nbsp;</p>
		<font class="inplacedisplayid39709siteid95">
					<span style="font-size: 10pt">

</form>


</body>
</html>