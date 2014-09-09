From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH] serial: sirf: fix line over 80 characters style issue
Date: Tue, 09 Sep 2014 08:16:47 +0800
Message-ID: <D034651C.21637%21cnbao@gmail.com>
References: <20140908231527.GA23907@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:34548 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754449AbaIIARY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 8 Sep 2014 20:17:24 -0400
Received: by mail-pd0-f173.google.com with SMTP id ft15so5724068pdb.18
        for <linux-serial@vger.kernel.org>; Mon, 08 Sep 2014 17:17:23 -0700 (PDT)
In-Reply-To: <20140908231527.GA23907@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>, Barry Song <Barry.Song@csr.com>
Cc: linux-serial@vger.kernel.org, workgroup.linux@csr.com, Qipan Li <Qipan.Li@csr.com>, Barry Song <Baohua.Song@csr.com>



On 14-9-9 =C9=CF=CE=E77:15, "Greg KH" <gregkh@linuxfoundation.org> wrot=
e:

>On Mon, Aug 18, 2014 at 05:32:52PM +0800, Barry Song wrote:
>> From: Qipan Li <Qipan.Li@csr.com>
>>=20
>> According to key customer's requirement, fix "line over 80
>> characters".
>
>Someone is forcing you to fix all upstream kernel.org code for 80
>columns?  Who?

we were asked to fix csr platform codes some days ago. They have been
fixed locally.=20
You know, the difficulty is maintaining the difference between mainline
and local codes.
So I thought this is better if you can merge it.

>
>> Signed-off-by: Qipan Li <Qipan.Li@csr.com>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>> ---
>>  drivers/tty/serial/sirfsoc_uart.c | 14 +++++++++-----
>>  1 file changed, 9 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/drivers/tty/serial/sirfsoc_uart.c
>>b/drivers/tty/serial/sirfsoc_uart.c
>> index 4102192..89f1e59 100644
>> --- a/drivers/tty/serial/sirfsoc_uart.c
>> +++ b/drivers/tty/serial/sirfsoc_uart.c
>> @@ -525,7 +525,8 @@ static void sirfsoc_rx_tmo_process_tl(unsigned l=
ong
>>param)
>> =20
>>  	spin_lock_irqsave(&port->lock, flags);
>>  	while (DMA_COMPLETE =3D=3D dmaengine_tx_status(sirfport->rx_dma_ch=
an,
>> -		sirfport->rx_dma_items[sirfport->rx_completed].cookie, &tx_state)=
) {
>> +		sirfport->rx_dma_items[sirfport->rx_completed].cookie,
>> +		&tx_state)) {
>
>Isn't that now harder to read?
>
>>  		sirfsoc_uart_insert_rx_buf_to_tty(sirfport,
>>  					SIRFSOC_RX_DMA_BUF_SIZE);
>>  		sirfport->rx_completed++;
>> @@ -707,7 +708,8 @@ static void
>>sirfsoc_uart_rx_dma_complete_tl(unsigned long param)
>>  	struct dma_tx_state tx_state;
>>  	spin_lock_irqsave(&port->lock, flags);
>>  	while (DMA_COMPLETE =3D=3D dmaengine_tx_status(sirfport->rx_dma_ch=
an,
>> -			sirfport->rx_dma_items[sirfport->rx_completed].cookie, &tx_state=
)) {
>> +		sirfport->rx_dma_items[sirfport->rx_completed].cookie,
>> +		&tx_state)) {
>
>Same here.
>
>>  		sirfsoc_uart_insert_rx_buf_to_tty(sirfport,
>>  					SIRFSOC_RX_DMA_BUF_SIZE);
>>  		if (rd_regl(port, ureg->sirfsoc_int_en_reg) &
>> @@ -1303,7 +1305,8 @@ static int sirfsoc_uart_probe(struct
>>platform_device *pdev)
>>  		"sirf,uart-has-rtscts");
>>  	if (of_device_is_compatible(pdev->dev.of_node, "sirf,prima2-uart")=
)
>>  		sirfport->uart_reg->uart_type =3D SIRF_REAL_UART;
>> -	if (of_device_is_compatible(pdev->dev.of_node,
>>"sirf,prima2-usp-uart")) {
>> +	if (of_device_is_compatible(pdev->dev.of_node,
>> +		"sirf,prima2-usp-uart")) {
>
>Same.
>
>>  		sirfport->uart_reg->uart_type =3D	SIRF_USP_UART;
>>  		if (!sirfport->hw_flow_ctrl)
>>  			goto usp_no_flow_control;
>> @@ -1360,11 +1363,12 @@ usp_no_flow_control:
>>  		goto err;
>>  	}
>>  	tasklet_init(&sirfport->rx_dma_complete_tasklet,
>> -			sirfsoc_uart_rx_dma_complete_tl, (unsigned long)sirfport);
>> +		sirfsoc_uart_rx_dma_complete_tl, (unsigned long)sirfport);
>
>Same.
>
>You can break this line at the last variable instead.
>
>>  	tasklet_init(&sirfport->rx_tmo_process_tasklet,
>>  			sirfsoc_rx_tmo_process_tl, (unsigned long)sirfport);
>>  	port->mapbase =3D res->start;
>> -	port->membase =3D devm_ioremap(&pdev->dev, res->start,
>>resource_size(res));
>> +	port->membase =3D devm_ioremap(&pdev->dev,
>> +			res->start, resource_size(res));
>
>same here, it could be made to look better.
>
>Sorry, not going to take this, if your customer blames you, point them
>at me.

I understand you are very helpful. But pointing them to you will actual=
ly
make things worse as I think we have no chance to convince them as we h=
ave
tried our best to do that.
The benefit of this patch is making people happy. But if you are not
happy, I can make myself unhappy to maintain two versions.
=20
>
>seriously.
>
>greg k-h
>

-barry


--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
