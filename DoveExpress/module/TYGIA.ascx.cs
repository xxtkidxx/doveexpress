using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Data;
using Telerik.Web.UI;

public partial class module_TYGIA : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadXml();
        }
    }
    string TimeUpdate ="";
    private void LoadXml()
    {
        try
        {
            XmlDocument xmlDocument = new XmlDocument();
            String xmlSourceUrl = "http://www.vietcombank.com.vn/ExchangeRates/ExrateXML.aspx";
            xmlDocument.Load(xmlSourceUrl);
            //từ đây hoàn toàn có thể thao tác dữ liệu xml bằng đối tượng xmlDocument
            //lấy ví zụ chuyển từ XmlDocument thành tập các đối tượng Generic dạng List<Exrate>
            XmlNodeList TimeList = xmlDocument.GetElementsByTagName("DateTime");
            TimeUpdate = String.Format("{0:dd/MM/yyyy hh:mm:ss tt}", Convert.ToDateTime(TimeList[0].InnerText));
            XmlNodeList nodeList = xmlDocument.GetElementsByTagName("Exrate");
            List<Exrate> listExrate = null;
            if (nodeList != null && nodeList.Count > 0)
            {
                listExrate = new List<Exrate>();
                foreach (XmlNode xmlNode in nodeList)
                {                   
                    Exrate entityExrate = new Exrate();
                    entityExrate.CurrencyCode = xmlNode.Attributes["CurrencyCode"].InnerText;
                    entityExrate.CurrencyName = xmlNode.Attributes["CurrencyName"].InnerText;
                    entityExrate.Buy = float.Parse(xmlNode.Attributes["Buy"].InnerText);
                    entityExrate.Transfer = float.Parse(xmlNode.Attributes["Transfer"].InnerText);
                    entityExrate.Sell = float.Parse(xmlNode.Attributes["Sell"].InnerText);
                    listExrate.Add(entityExrate);
                }
                //thực hiện việc bind dữ liệu vào GridView
                RadGridTYGIA.DataSource = listExrate;
                RadGridTYGIA.DataBind();
            }          
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
    }
    protected void RadGridTYGIA_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        GridItem cmdItem = RadGridTYGIA.MasterTableView.GetItems(GridItemType.CommandItem)[0];
        Label lblTime = (Label)cmdItem.FindControl("lblTime");
        lblTime.Text = TimeUpdate;
    }
}
public class Exrate
{
    private string _CurrencyCode = string.Empty;

    public string CurrencyCode
    {
        get { return _CurrencyCode; }
        set { _CurrencyCode = value; }
    }
    private string _CurrencyName = string.Empty;

    public string CurrencyName
    {
        get { return _CurrencyName; }
        set { _CurrencyName = value; }
    }
    private float _Buy = 0;

    public float Buy
    {
        get { return _Buy; }
        set { _Buy = value; }
    }
    private float _Transfer = 0;

    public float Transfer
    {
        get { return _Transfer; }
        set { _Transfer = value; }
    }
    private float _Sell = 0;

    public float Sell
    {
        get { return _Sell; }
        set { _Sell = value; }
    }
}