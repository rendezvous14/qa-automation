from bhkey import tools
import uuid
from  bh_rabbitmq import bh_rabbitmq as rabbit

def gen_bh_key():
    print('key = ', tools.gen_key())
    return tools.gen_key()

def gen_msg_id():
    print('msg-id = ', uuid.uuid4())
    return uuid.uuid4()

def connect_rabbit(host, port, user, password, vhost):
    rabbit_publisher = rabbit()
    rabbit_publisher.init_rabbitmq_connection(host, port, user, password, vhost)

def publish_message(bh_key, msg_id):
    payload = '''<message>
            <control>
                <message-id>%s</message-id>
            </control>
            <body>
                <Items>
                    <Item>
                        <Action>SAVE</Action>
                        <DateTimeStamp>2018-06-29T07:17:19z</DateTimeStamp>
                        <UserDef1>FIFO</UserDef1>
                        <UserDef2>N</UserDef2>
                        <UserDef3></UserDef3>
                        <Active>Y</Active>
                        <Company>3969-bm1-th</Company>
                        <Desc>UPC1 - ITEM_3969_20180619_1</Desc>
                        <EPCItemReference>ITEM_3969_20180619_1</EPCItemReference>
                        <Item>%s</Item>
                        <ItemCategories>
                            <Category1>General</Category1>
                            <Category2>General</Category2>
                        </ItemCategories>
                        <InboundQcAmount>0.00000</InboundQcAmount>
                        <InboundQcAmountType>P</InboundQcAmountType>
                        <InboundQcEligible>N</InboundQcEligible>
                        <InboundQcUm>EA</InboundQcUm>
                        <InventoryTracking>Y</InventoryTracking>
                        <LongDesc>UPC1 - ITEM_3969_20180619_1</LongDesc>
                        <LotControlled>Y</LotControlled>
                        <SerialNumTrackInbound>N</SerialNumTrackInbound>
                        <SerialNumTrackInventory>N</SerialNumTrackInventory>
                        <SerialNumTrackOutbound>N</SerialNumTrackOutbound>
                        <StorageTemplate>
                            <Template>*Default</Template>
                        </StorageTemplate>
                        <UOMS>
                            <UOM>
                                <Action>SAVE</Action>
                                <ConvQty>1</ConvQty>
                                <DimensionUm>CM</DimensionUm>
                                <Height>1.20000</Height>
                                <Length>1.00000</Length>
                                <QtyUm>EA</QtyUm>
                                <Sequence>1</Sequence>
                                <TreatAsLoose>Y</TreatAsLoose>
                                <Weight>0.01000</Weight>
                                <WeightUm>KG</WeightUm>
                                <Width>1.20000</Width>
                            </UOM>
                        </UOMS>
                        <XRefs>
                            <XRef>
                                <Action>SAVE</Action>
                                <XRefItem>UPC1</XRefItem>
                                <XRefUM>EA</XRefUM>
                            </XRef>
                        </XRefs>
                    </Item>
                </Items>
            </body>
        </message>''' % (msg_id, bh_key)
    # print(payload)
    return payload


if __name__ == "__main__":
    rabbit_mq_url = "queue-common.acommercedev.service"
    rabbit_port = "5672"
    rabbit_username = "admin"
    rabbit_password = "aCom1234"
    rabbit_vhost = "ScaleBridge-staging"
    rabbit_exchange = "download.ID-ACOM-HLM"
    rabbit_routing = "ws.items-Downloaded"
    rabbit_publisher = rabbit()
    rabbit_publisher.init_rabbitmq_connection(rabbit_mq_url, rabbit_port, rabbit_username, rabbit_password, rabbit_vhost)
    print ("connected")
    loop = 100000
    for x in range(0, loop):
        bh_key = gen_bh_key()
        msg_id = gen_msg_id()
        payload = publish_message(bh_key, msg_id)
        rabbit_publisher.send_rabbitmq_msg(payload, rabbit_exchange, rabbit_routing)
        print("%s / %s") % (x, loop)
    
    print ("sent")
    rabbit_publisher.close_rabbitmq_connection()
    print ("closed")



