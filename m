From: Huang Shijie <b32955@freescale.com>
Subject: Re: [PATCH 1/2] serial/imx: add DMA support
Date: Fri, 27 Apr 2012 15:00:39 +0800
Message-ID: <4F9A4417.7080107@freescale.com>
References: <1335436632-29499-1-git-send-email-b32955@freescale.com> <1335436632-29499-2-git-send-email-b32955@freescale.com> <20120426111116.GF24211@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from am1ehsobe001.messaging.microsoft.com ([213.199.154.204]:32717
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756204Ab2D0G45 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 27 Apr 2012 02:56:57 -0400
In-Reply-To: <20120426111116.GF24211@n2100.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: alan@linux.intel.com, B20596@freescale.com, B20223@freescale.com, gregkh@linuxfoundation.org, r58066@freescale.com, linux-serial@vger.kernel.org, shawn.guo@linaro.org, s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org

=E4=BA=8E 2012=E5=B9=B404=E6=9C=8826=E6=97=A5 19:11, Russell King - ARM=
 Linux =E5=86=99=E9=81=93:
> On Thu, Apr 26, 2012 at 06:37:11PM +0800, Huang Shijie wrote:
>> Add the DMA support for uart RX and TX.
>>
>> Signed-off-by: Huang Shijie<b32955@freescale.com>
>> ---
> Apart from the comments below,
>
> 1. How do you deal with transmitting the high-priority XON/XOFF
>     characters (port->x_char) which occur with s/w flow control and
>     the tty buffers fill up?
> 2. How do you deal with flow control in general?  IOW, what happens
>     when the remote end deasserts your CTS with h/w flow control enab=
led.
>     How does your end deal with sending RTS according to flow control
>     conditions?
>
> i
The UART uses the DMA for RX/TX with the hardware flow control (RTS/CTS=
)=20
enabled all the time.
If we use the software flow control(XON/XOFF), we should not enable the=
 DMA.
I think i should add more comments about this issue.

=46or example:
The MX6Q arm2 has two uarts, one with the DMA disabled is used for debu=
g,
the other one with the DMA/RTS.CTS enabled can be used for the Bluetoot=
h.
>>   .../bindings/tty/serial/fsl-imx-uart.txt           |    7 +
>>   drivers/tty/serial/imx.c                           |  386 ++++++++=
+++++++++++-
>>   2 files changed, 389 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/tty/serial/fsl-imx-ua=
rt.txt b/Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.txt
>> index a9c0406..f27489d 100644
>> --- a/Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.txt
>> +++ b/Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.txt
>> @@ -8,6 +8,10 @@ Required properties:
>>   Optional properties:
>>   - fsl,uart-has-rtscts : Indicate the uart has rts and cts
>>   - fsl,irda-mode : Indicate the uart supports irda mode
>> +- fsl,enable-dma : Indicate the uart supports DMA
>> +- fsl,uart-dma-events : contains the DMA events for RX and TX,
>> +	          The first is the RX event, while the other is TX.
>> +- fsl,enable-dte: Indicate the uart works in DTE mode
>>
>>   Example:
>>
>> @@ -16,4 +20,7 @@ uart@73fbc000 {
>>   	reg =3D<0x73fbc000 0x4000>;
>>   	interrupts =3D<31>;
>>   	fsl,uart-has-rtscts;
>> +	fsl,enable-dma;
>> +	fsl,uart-dma-events =3D<xx xx>;
>> +	fsl,enable-dte;
>>   };
>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> index e7fecee..65ba24d 100644
>> --- a/drivers/tty/serial/imx.c
>> +++ b/drivers/tty/serial/imx.c
>> @@ -47,9 +47,11 @@
>>   #include<linux/slab.h>
>>   #include<linux/of.h>
>>   #include<linux/of_device.h>
>> +#include<linux/dma-mapping.h>
>>
>>   #include<asm/io.h>
>>   #include<asm/irq.h>
>> +#include<mach/dma.h>
>>   #include<mach/imx-uart.h>
>>
>>   /* Register definitions */
>> @@ -82,6 +84,7 @@
>>   #define  UCR1_ADBR       (1<<14) /* Auto detect baud rate */
>>   #define  UCR1_TRDYEN     (1<<13) /* Transmitter ready interrupt en=
able */
>>   #define  UCR1_IDEN       (1<<12) /* Idle condition interrupt */
>> +#define  UCR1_ICD_REG(x) (((x)&  3)<<  10) /* idle condition detect=
 */
>>   #define  UCR1_RRDYEN     (1<<9)	 /* Recv ready interrupt enable */
>>   #define  UCR1_RDMAEN     (1<<8)	 /* Recv ready DMA enable */
>>   #define  UCR1_IREN       (1<<7)	 /* Infrared interface enable */
>> @@ -125,6 +128,7 @@
>>   #define  UCR4_ENIRI 	 (1<<8)  /* Serial infrared interrupt enable =
*/
>>   #define  UCR4_WKEN  	 (1<<7)  /* Wake interrupt enable */
>>   #define  UCR4_REF16 	 (1<<6)  /* Ref freq 16 MHz */
>> +#define  UCR4_IDDMAEN    (1<<6)  /* DMA IDLE Condition Detected */
>>   #define  UCR4_IRSC  	 (1<<5)  /* IR special case */
>>   #define  UCR4_TCEN  	 (1<<3)  /* Transmit complete interrupt enabl=
e */
>>   #define  UCR4_BKEN  	 (1<<2)  /* Break condition interrupt enable =
*/
>> @@ -134,6 +138,7 @@
>>   #define  UFCR_RFDIV      (7<<7)  /* Reference freq divider mask */
>>   #define  UFCR_RFDIV_REG(x)	(((x)<  7 ? 6 - (x) : 6)<<  7)
>>   #define  UFCR_TXTL_SHF   10      /* Transmitter trigger level shif=
t */
>> +#define  UFCR_DCEDTE	 (1<<6)
>>   #define  USR1_PARITYERR  (1<<15) /* Parity error interrupt flag */
>>   #define  USR1_RTSS  	 (1<<14) /* RTS pin status */
>>   #define  USR1_TRDY  	 (1<<13) /* Transmitter ready interrupt/dma f=
lag */
>> @@ -200,12 +205,27 @@ struct imx_port {
>>   	unsigned int		old_status;
>>   	int			txirq,rxirq,rtsirq;
>>   	unsigned int		have_rtscts:1;
>> +	unsigned int		enable_dte:1;
>> +	unsigned int		enable_dma:1;
>>   	unsigned int		use_irda:1;
>>   	unsigned int		irda_inv_rx:1;
>>   	unsigned int		irda_inv_tx:1;
>>   	unsigned short		trcv_delay; /* transceiver delay */
>>   	struct clk		*clk;
>>   	struct imx_uart_data	*devdata;
>> +
>> +	/* DMA fields */
>> +	unsigned int		dma_req_rx;
>> +	unsigned int		dma_req_tx;
>> +	struct imx_dma_data	dma_data;
>> +	struct dma_chan		*dma_chan_rx, *dma_chan_tx;
>> +	struct scatterlist	rx_sgl, tx_sgl[2];
>> +	void			*rx_buf;
>> +	unsigned int		rx_bytes, tx_bytes;
>> +	struct work_struct	tsk_dma_rx, tsk_dma_tx;
> Why do you need a work struct to deal with DMA?
>
The uart uses the SDMA (drivers/dma/imx-sdma.c). And the SDMA may=20
schedule out in :
sdma_prep_slave_sg() --> sdma_load_contex() -->sdma_run_channel() .

So i have to add a work struct to prepare and triger the DMA operations=
=2E
>> +	unsigned int		dma_tx_nents;
>> +	bool			dma_is_rxing;
>> +	wait_queue_head_t	dma_wait;
>>   };
>>
>>   struct imx_port_ucrs {
>> @@ -394,6 +414,13 @@ static void imx_stop_rx(struct uart_port *port)
>>   	struct imx_port *sport =3D (struct imx_port *)port;
>>   	unsigned long temp;
>>
>> +	/*
>> +	 * We are maybe in the SMP now, so if the DMA RX thread is running=
,
>> +	 * we have to wait for it to finish.
>> +	 */
>> +	if (sport->enable_dma&&  sport->dma_is_rxing)
>> +		return;
>> +
>>   	temp =3D readl(sport->port.membase + UCR2);
>>   	writel(temp&~ UCR2_RXEN, sport->port.membase + UCR2);
>>   }
>> @@ -429,6 +456,80 @@ static inline void imx_transmit_buffer(struct i=
mx_port *sport)
>>   		imx_stop_tx(&sport->port);
>>   }
>>
>> +static void dma_tx_callback(void *data)
>> +{
>> +	struct imx_port *sport =3D data;
>> +	struct scatterlist *sgl =3D&sport->tx_sgl[0];
> 	struct scatterlist *sgl =3D sport->tx_sgl;
>
> is equivalent, and less typing.
>
>> +	struct circ_buf *xmit =3D&sport->port.state->xmit;
>> +
>> +	dma_unmap_sg(sport->port.dev, sgl, sport->dma_tx_nents, DMA_TO_DEV=
ICE);
>> +
>> +	/* update the stat */
>> +	spin_lock(&sport->port.lock);
>> +	xmit->tail =3D (xmit->tail + sport->tx_bytes)&  (UART_XMIT_SIZE - =
1);
>> +	sport->port.icount.tx +=3D sport->tx_bytes;
>> +	spin_unlock(&sport->port.lock);
> Callbacks are called from tasklet context, and will have IRQs enabled=
=2E
> As the port lock is taken from IRQ context, this is waiting for a dea=
dlock
> to happen.  Have you run this with lockdep enabled?
>
This callback is called from IRQ context, with all the IRQ disabled. se=
e:
sdma_int_handler() -->mxc_sdma_handle_channel() -->=20
mxc_sdma_handle_channel_normal()
--> .callback().

So spin_lock() is enough.

Best Regards
Huang Shijie


--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
