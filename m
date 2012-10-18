From: Huang Shijie <b32955@freescale.com>
Subject: Re: [PATCH 2/3] serial: mxs-auart: add the DMA support for mx28
Date: Thu, 18 Oct 2012 14:22:03 +0800
Message-ID: <507FA00B.7040709@freescale.com>
References: <1350367386-7742-1-git-send-email-b32955@freescale.com> <1350367386-7742-3-git-send-email-b32955@freescale.com> <20121018032022.GB4378@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ch1ehsobe001.messaging.microsoft.com ([216.32.181.181]:57905
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754472Ab2JRGSu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 18 Oct 2012 02:18:50 -0400
In-Reply-To: <20121018032022.GB4378@S2101-09.ap.freescale.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: gregkh@linuxfoundation.org, alan@linux.intel.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, lauri.hintsala@bluegiga.com, vinod.koul@intel.com

=E4=BA=8E 2012=E5=B9=B410=E6=9C=8818=E6=97=A5 11:20, Shawn Guo =E5=86=99=
=E9=81=93:
> On Tue, Oct 16, 2012 at 02:03:05PM +0800, Huang Shijie wrote:
>> Only we meet the following conditions, we can enable the DMA support=
 for
>> auart:
>>
>> @@ -6,11 +6,18 @@ Required properties:
>>   - reg : Address and length of the register set for the device
>>   - interrupts : Should contain the auart interrupt numbers
>>
>> +Optional properties:
>> +- fsl,auart-dma-channel : The DMA channels, the first is for RX, th=
e other
>> +			is for TX.
>> +- fsl,auart-enable-dma : Enable the DMA support for the auart.
>> +
> If we want to have it decided by device tree, can we drop the propert=
y
> and simply check if "fsl,auart-dma-channel" presents?
It's ok to me. fix it in next version.
>>   Example:
>>   auart0: serial@8006a000 {
>>   	compatible =3D "fsl,imx28-auart";
>>   	reg =3D<0x8006a000 0x2000>;
>>   	interrupts =3D<112 70 71>;
>> +	fsl,auart-dma-channel =3D<8 9>;
>> +	fsl,auart-enable-dma;
>>   };
>>
>>   Note: Each auart port should have an alias correctly numbered in "=
aliases"
>> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs=
-auart.c
>> index cd9ec1d..2271330 100644
>> --- a/drivers/tty/serial/mxs-auart.c
>> +++ b/drivers/tty/serial/mxs-auart.c
>> @@ -34,6 +34,8 @@
>>   #include<linux/io.h>
>>   #include<linux/pinctrl/consumer.h>
>>   #include<linux/of_device.h>
>> +#include<linux/dma-mapping.h>
>> +#include<linux/fsl/mxs-dma.h>
>>
>>   #include<asm/cacheflush.h>
>>
>> @@ -76,7 +78,15 @@
>>
>>   #define AUART_CTRL0_SFTRST			(1<<  31)
>>   #define AUART_CTRL0_CLKGATE			(1<<  30)
>> +#define AUART_CTRL0_RXTO_ENABLE			(1<<  27)
>> +#define AUART_CTRL0_RXTIMEOUT(v)		(((v)&  0x7ff)<<  16)
>> +#define AUART_CTRL0_XFER_COUNT(v)		((v)&  0xffff)
>>
>> +#define AUART_CTRL1_XFER_COUNT(v)		((v)&  0xffff)
>> +
>> +#define AUART_CTRL2_DMAONERR			(1<<  26)
>> +#define AUART_CTRL2_TXDMAE			(1<<  25)
>> +#define AUART_CTRL2_RXDMAE			(1<<  24)
>>   #define AUART_CTRL2_CTSEN			(1<<  15)
>>   #define AUART_CTRL2_RTSEN			(1<<  14)
>>   #define AUART_CTRL2_RTS				(1<<  11)
>> @@ -116,12 +126,15 @@
>>   #define AUART_STAT_BERR				(1<<  18)
>>   #define AUART_STAT_PERR				(1<<  17)
>>   #define AUART_STAT_FERR				(1<<  16)
>> +#define AUART_STAT_RXCOUNT_MASK			0xffff
>>
>>   static struct uart_driver auart_driver;
>>
>>   struct mxs_auart_port {
>>   	struct uart_port port;
>>
>> +#define MXS_AUART_DMA_CONFIG	0x1
>> +#define MXS_AUART_DMA_ENABLED	0x2
>>   	unsigned int flags;
>>   	unsigned int ctrl;
>>
>> @@ -130,16 +143,116 @@ struct mxs_auart_port {
>>   	struct clk *clk;
>>   	struct device *dev;
>>   	struct platform_device *pdev;
>> +
>> +	/* for DMA */
>> +	struct mxs_dma_data dma_data;
>> +	int dma_channel_rx, dma_channel_tx;
>> +	int dma_irq_rx, dma_irq_tx;
>> +	int dma_channel;
>> +
>> +	struct scatterlist tx_sgl;
>> +	struct dma_chan	*tx_dma_chan;
>> +	void *tx_dma_buf;
>> +
>> +	struct scatterlist rx_sgl;
>> +	struct dma_chan	*rx_dma_chan;
>> +	void *rx_dma_buf;
>>   };
>>
>> +static inline bool auart_dma_enabled(struct mxs_auart_port *s)
>> +{
>> +	return s->flags&  MXS_AUART_DMA_ENABLED;
>> +}
>> +
>>   static void mxs_auart_stop_tx(struct uart_port *u);
>>
>>   #define to_auart_port(u) container_of(u, struct mxs_auart_port, po=
rt)
>>
>> +static inline void mxs_auart_tx_chars(struct mxs_auart_port *s);
>> +
>> +static void dma_tx_callback(void *param)
>> +{
>> +	struct mxs_auart_port *s =3D param;
>> +	struct circ_buf *xmit =3D&s->port.state->xmit;
>> +
>> +	dma_unmap_sg(s->dev,&s->tx_sgl, 1, DMA_TO_DEVICE);
>> +
>> +	/* wake up the possible processes. */
>> +	if (uart_circ_chars_pending(xmit)<  WAKEUP_CHARS)
>> +		uart_write_wakeup(&s->port);
>> +
>> +	mxs_auart_tx_chars(s);
>> +}
>> +
>> +static int mxs_auart_dma_tx(struct mxs_auart_port *s, int size)
>> +{
>> +	struct dma_async_tx_descriptor *desc;
>> +	struct scatterlist *sgl =3D&s->tx_sgl;
>> +	struct dma_chan *channel =3D s->tx_dma_chan;
>> +	u32 pio[1];
> One element array looks strange to me.
got it.
>> +
>> +	/* [1] : send PIO. Note, the first pio word is CTRL1. */
>> +	pio[0] =3D AUART_CTRL1_XFER_COUNT(size);
>> +	desc =3D dmaengine_prep_slave_sg(channel, (struct scatterlist *)pi=
o,
>> +					1, DMA_TRANS_NONE, 0);
>> +	if (!desc) {
>> +		dev_err(s->dev, "step 1 error\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* [2] : set DMA buffer. */
>> +	sg_init_one(sgl, s->tx_dma_buf, size);
>> +	dma_map_sg(s->dev, sgl, 1, DMA_TO_DEVICE);
>> +	desc =3D dmaengine_prep_slave_sg(channel, sgl,
>> +			1, DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>> +	if (!desc) {
>> +		dev_err(s->dev, "step 2 error\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* [3] : submit the DMA */
>> +	desc->callback =3D dma_tx_callback;
>> +	desc->callback_param =3D s;
>> +	dmaengine_submit(desc);
>> +	dma_async_issue_pending(channel);
>> +	return 0;
>> +}
>> +
>>   static inline void mxs_auart_tx_chars(struct mxs_auart_port *s)
> I'm not sure why this function is inline from the beginning.  It
yes. The inline is not proper.

Best Regards
Huang Shijie

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
