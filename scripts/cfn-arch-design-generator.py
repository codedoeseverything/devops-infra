from diagrams import Diagram, Cluster, Edge

from diagrams.onprem.client import Client, Users
from diagrams.onprem.network import Internet
from diagrams.aws.compute import Lambda
from diagrams.aws.network import Route53, APIGateway, CF
from diagrams.aws.security import Cognito, IAM, WAF
from diagrams.aws.storage import S3
from diagrams.aws.engagement import SES
from diagrams.aws.database import DDB
from diagrams.aws.management import Cloudwatch

graph_attr = {
    "fontsize": "40"
}

with Diagram("Static Website on Amazon S3 ",
             filename="diagram", show=False, graph_attr=graph_attr):

    users = Users()

    with Cluster("AWS"):

        security = Cognito("Cognito")
        gateway = APIGateway("Gateway")
        route = Route53("Route53")
        db = DDB("DynamoDB")
        email_service = SES("SES")
        monitoring = Cloudwatch("AWS CloudWatch ")
        firewall = WAF("AWS WAF")
        identity = IAM("AWS IAM")

        with Cluster("CDN"):
            cdn = S3("S3") >> CF("CloudFront CDN")

        with Cluster("Functions") as xyz:
            func_send_mail = Lambda("Send Email")
            func_store_data = Lambda("Store Data")
            functions = [func_send_mail, func_store_data]
            gateway >> Edge() << functions

        functions >> Edge() << identity

        func_send_mail >> Edge() >> email_service >> users
        func_store_data - Edge() - db
        cdn >> Edge() << route

        # Monitoring
        log_connection = Edge(color="darkpink", style="dotted")
        monitoring >> log_connection << gateway
        monitoring >> log_connection << [func_send_mail, func_store_data]
        monitoring >> log_connection << firewall

        firewall >> Edge() << cdn >> Edge() << gateway
        security >> Edge() << gateway

    Client() - \
        Internet("www.yoursite.com") >> \
        Edge(color="darkgreen", style="dotted") << \
        route >> Edge() << gateway