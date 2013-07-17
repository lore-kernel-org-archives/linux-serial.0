From: Huang Shijie <b32955@freescale.com>
Subject: Re: [PATCH v2 2/3] serial: mxs: enable the DMA only when the RTS/CTS
 is valid
Date: Wed, 17 Jul 2013 15:33:22 +0800
Message-ID: <51E648C2.3010304@freescale.com>
References: <1373957732-16638-1-git-send-email-b32955@freescale.com> <1373957732-16638-3-git-send-email-b32955@freescale.com> <20130716095449.GS12139@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]:43585
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752347Ab3GQHaQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 17 Jul 2013 03:30:16 -0400
In-Reply-To: <20130716095449.GS12139@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>
Cc: gregkh@linuxfoundation.org, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org

=E4=BA=8E 2013=E5=B9=B407=E6=9C=8816=E6=97=A5 17:54, Uwe Kleine-K=C3=B6=
nig =E5=86=99=E9=81=93:
> On Tue, Jul 16, 2013 at 02:55:31PM +0800, Huang Shijie wrote:
>> The original DMA support works only when RTS/CTS is enabled.
> What is original here?
>
i will add more information for this in the next version.
>> But after several patches, DMA support has lost this limit.
> This is still misleading.
>
>> This patch adds an optional property for the UART DT node
>> which indicates the UART has RTS and CTS lines.
>>
>> This patch also adds a macro MXS_AUART_RTSCTS, and uses it to check
>> RTS/CTS before we enable the DMA for the UART.
> I still think this should go to stable. The options are:
>
> 	a) also take patch 1 into stable
> 	b) apply this patch without patch 1
>
> I don't know if option a) is OK, b) is probably preferable. And as Gr=
eg
to Greg:

I think a) is ok to me. what's your opinion?


> has much to do anyhow, better move this patch first. (Otherwise he wi=
ll
> probably only say: That patch doesn't apply, please help.)
>
>> Signed-off-by: Huang Shijie<b32955@freescale.com>
>> ---
>>   .../bindings/tty/serial/fsl-mxs-auart.txt          |    4 ++++
>>   drivers/tty/serial/mxs-auart.c                     |    5 ++++-
>>   2 files changed, 8 insertions(+), 1 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/tty/serial/fsl-mxs-au=
art.txt b/Documentation/devicetree/bindings/tty/serial/fsl-mxs-auart.tx=
t
>> index 2c00ec6..59a40f1 100644
>> --- a/Documentation/devicetree/bindings/tty/serial/fsl-mxs-auart.txt
>> +++ b/Documentation/devicetree/bindings/tty/serial/fsl-mxs-auart.txt
>> @@ -10,6 +10,10 @@ Required properties:
>>     Refer to dma.txt and fsl-mxs-dma.txt for details.
>>   - dma-names: "rx" for RX channel, "tx" for TX channel.
>>
>> +Optional properties:
>> +- fsl,uart-has-rtscts : Indicate the UART has RTS and CTS lines,
>> +	it also means you enable the DMA support for this UART.
>> +
>>   Example:
>>   auart0: serial@8006a000 {
>>   	compatible =3D "fsl,imx28-auart", "fsl,imx23-auart";
>> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs=
-auart.c
>> index 465ef0b..27532fd 100644
>> --- a/drivers/tty/serial/mxs-auart.c
>> +++ b/drivers/tty/serial/mxs-auart.c
>> @@ -134,6 +134,7 @@ enum mxs_auart_type {
>>   struct mxs_auart_port {
>>   	struct uart_port port;
>>
>> +#define MXS_AUART_RTSCTS	1
>>   #define MXS_AUART_DMA_ENABLED	0x2
>>   #define MXS_AUART_DMA_TX_SYNC	2  /* bit 2 */
>>   #define MXS_AUART_DMA_RX_READY	3  /* bit 3 */
>> @@ -639,7 +640,7 @@ static void mxs_auart_settermios(struct uart_por=
t *u,
>>   		 * we can only implement the DMA support for auart
>>   		 * in mx28.
>>   		 */
>> -		if (is_imx28_auart(s)) {
>> +		if (is_imx28_auart(s)&&  (s->flags&  MXS_AUART_RTSCTS)) {
> I thought you wanted to add a comment here. Without knowing the detai=
ls
>
> 	if (RTSCTS)
> 		enable_dma();
>
ok, no problem.


thanks
Huang Shijie

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
