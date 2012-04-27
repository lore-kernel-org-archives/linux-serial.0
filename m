From: Richard Zhao <richard.zhao@freescale.com>
Subject: Re: [PATCH 1/2] serial/imx: add DMA support
Date: Fri, 27 Apr 2012 16:38:22 +0800
Message-ID: <20120427083821.GN28063@b20223-02.ap.freescale.net>
References: <1335436632-29499-1-git-send-email-b32955@freescale.com>
 <1335436632-29499-2-git-send-email-b32955@freescale.com>
 <20120426111116.GF24211@n2100.arm.linux.org.uk>
 <4F9A4417.7080107@freescale.com>
 <20120427082245.GJ24211@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]:55588
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759489Ab2D0Iic convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 27 Apr 2012 04:38:32 -0400
Content-Disposition: inline
In-Reply-To: <20120427082245.GJ24211@n2100.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Huang Shijie <b32955@freescale.com>, alan@linux.intel.com, B20596@freescale.com, B20223@freescale.com, gregkh@linuxfoundation.org, r58066@freescale.com, linux-serial@vger.kernel.org, shawn.guo@linaro.org, s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org

On Fri, Apr 27, 2012 at 09:22:45AM +0100, Russell King - ARM Linux wrot=
e:
> On Fri, Apr 27, 2012 at 03:00:39PM +0800, Huang Shijie wrote:
> > =E4=BA=8E 2012=E5=B9=B404=E6=9C=8826=E6=97=A5 19:11, Russell King -=
 ARM Linux =E5=86=99=E9=81=93:
> >> On Thu, Apr 26, 2012 at 06:37:11PM +0800, Huang Shijie wrote:
> >>> Add the DMA support for uart RX and TX.
> >>>
> >>> Signed-off-by: Huang Shijie<b32955@freescale.com>
> >>> ---
> >> Apart from the comments below,
> >>
> >> 1. How do you deal with transmitting the high-priority XON/XOFF
> >>     characters (port->x_char) which occur with s/w flow control an=
d
> >>     the tty buffers fill up?
> >> 2. How do you deal with flow control in general?  IOW, what happen=
s
> >>     when the remote end deasserts your CTS with h/w flow control e=
nabled.
> >>     How does your end deal with sending RTS according to flow cont=
rol
> >>     conditions?
> >>
> >> i
> > The UART uses the DMA for RX/TX with the hardware flow control (RTS=
/CTS) =20
> > enabled all the time.
>=20
> Your answer is too vague.  Please try again.
>=20
> > If we use the software flow control(XON/XOFF), we should not enable=
 the DMA.
> > I think i should add more comments about this issue.
> >
> > For example:
> > The MX6Q arm2 has two uarts, one with the DMA disabled is used for =
debug,
> > the other one with the DMA/RTS.CTS enabled can be used for the Blue=
tooth.
> >>>   .../bindings/tty/serial/fsl-imx-uart.txt           |    7 +
> >>>   drivers/tty/serial/imx.c                           |  386 +++++=
++++++++++++++-
> >>>   2 files changed, 389 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/tty/serial/fsl-imx=
-uart.txt b/Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.t=
xt
> >>> index a9c0406..f27489d 100644
> >>> --- a/Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.t=
xt
> >>> +++ b/Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.t=
xt
> >>> @@ -8,6 +8,10 @@ Required properties:
> >>>   Optional properties:
> >>>   - fsl,uart-has-rtscts : Indicate the uart has rts and cts
> >>>   - fsl,irda-mode : Indicate the uart supports irda mode
> >>> +- fsl,enable-dma : Indicate the uart supports DMA
> >>> +- fsl,uart-dma-events : contains the DMA events for RX and TX,
> >>> +	          The first is the RX event, while the other is TX.
> >>> +- fsl,enable-dte: Indicate the uart works in DTE mode
> >>>
> >>>   Example:
> >>>
> >>> @@ -16,4 +20,7 @@ uart@73fbc000 {
> >>>   	reg =3D<0x73fbc000 0x4000>;
> >>>   	interrupts =3D<31>;
> >>>   	fsl,uart-has-rtscts;
> >>> +	fsl,enable-dma;
> >>> +	fsl,uart-dma-events =3D<xx xx>;
> >>> +	fsl,enable-dte;
> >>>   };
> >>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> >>> index e7fecee..65ba24d 100644
> >>> --- a/drivers/tty/serial/imx.c
> >>> +++ b/drivers/tty/serial/imx.c
> >>> @@ -47,9 +47,11 @@
> >>>   #include<linux/slab.h>
> >>>   #include<linux/of.h>
> >>>   #include<linux/of_device.h>
> >>> +#include<linux/dma-mapping.h>
> >>>
> >>>   #include<asm/io.h>
> >>>   #include<asm/irq.h>
> >>> +#include<mach/dma.h>
> >>>   #include<mach/imx-uart.h>
> >>>
> >>>   /* Register definitions */
> >>> @@ -82,6 +84,7 @@
> >>>   #define  UCR1_ADBR       (1<<14) /* Auto detect baud rate */
> >>>   #define  UCR1_TRDYEN     (1<<13) /* Transmitter ready interrupt=
 enable */
> >>>   #define  UCR1_IDEN       (1<<12) /* Idle condition interrupt */
> >>> +#define  UCR1_ICD_REG(x) (((x)&  3)<<  10) /* idle condition det=
ect */
> >>>   #define  UCR1_RRDYEN     (1<<9)	 /* Recv ready interrupt enable=
 */
> >>>   #define  UCR1_RDMAEN     (1<<8)	 /* Recv ready DMA enable */
> >>>   #define  UCR1_IREN       (1<<7)	 /* Infrared interface enable *=
/
> >>> @@ -125,6 +128,7 @@
> >>>   #define  UCR4_ENIRI 	 (1<<8)  /* Serial infrared interrupt enab=
le */
> >>>   #define  UCR4_WKEN  	 (1<<7)  /* Wake interrupt enable */
> >>>   #define  UCR4_REF16 	 (1<<6)  /* Ref freq 16 MHz */
> >>> +#define  UCR4_IDDMAEN    (1<<6)  /* DMA IDLE Condition Detected =
*/
> >>>   #define  UCR4_IRSC  	 (1<<5)  /* IR special case */
> >>>   #define  UCR4_TCEN  	 (1<<3)  /* Transmit complete interrupt en=
able */
> >>>   #define  UCR4_BKEN  	 (1<<2)  /* Break condition interrupt enab=
le */
> >>> @@ -134,6 +138,7 @@
> >>>   #define  UFCR_RFDIV      (7<<7)  /* Reference freq divider mask=
 */
> >>>   #define  UFCR_RFDIV_REG(x)	(((x)<  7 ? 6 - (x) : 6)<<  7)
> >>>   #define  UFCR_TXTL_SHF   10      /* Transmitter trigger level s=
hift */
> >>> +#define  UFCR_DCEDTE	 (1<<6)
> >>>   #define  USR1_PARITYERR  (1<<15) /* Parity error interrupt flag=
 */
> >>>   #define  USR1_RTSS  	 (1<<14) /* RTS pin status */
> >>>   #define  USR1_TRDY  	 (1<<13) /* Transmitter ready interrupt/dm=
a flag */
> >>> @@ -200,12 +205,27 @@ struct imx_port {
> >>>   	unsigned int		old_status;
> >>>   	int			txirq,rxirq,rtsirq;
> >>>   	unsigned int		have_rtscts:1;
> >>> +	unsigned int		enable_dte:1;
> >>> +	unsigned int		enable_dma:1;
> >>>   	unsigned int		use_irda:1;
> >>>   	unsigned int		irda_inv_rx:1;
> >>>   	unsigned int		irda_inv_tx:1;
> >>>   	unsigned short		trcv_delay; /* transceiver delay */
> >>>   	struct clk		*clk;
> >>>   	struct imx_uart_data	*devdata;
> >>> +
> >>> +	/* DMA fields */
> >>> +	unsigned int		dma_req_rx;
> >>> +	unsigned int		dma_req_tx;
> >>> +	struct imx_dma_data	dma_data;
> >>> +	struct dma_chan		*dma_chan_rx, *dma_chan_tx;
> >>> +	struct scatterlist	rx_sgl, tx_sgl[2];
> >>> +	void			*rx_buf;
> >>> +	unsigned int		rx_bytes, tx_bytes;
> >>> +	struct work_struct	tsk_dma_rx, tsk_dma_tx;
> >> Why do you need a work struct to deal with DMA?
> >>
> > The uart uses the SDMA (drivers/dma/imx-sdma.c). And the SDMA may =20
> > schedule out in :
> > sdma_prep_slave_sg() --> sdma_load_contex() -->sdma_run_channel() .
>=20
> It should not.  prep_slave_sg() must be callable from atomic contexts=
=2E
I just sent out a patch to fix it.=20
[PATCH 01/11] dma: imx-sdma: make channel0 operations atomic

Thanks
Richard
>=20
> > This callback is called from IRQ context, with all the IRQ disabled=
=2E see:
> > sdma_int_handler() -->mxc_sdma_handle_channel() --> =20
> > mxc_sdma_handle_channel_normal()
> > --> .callback().
>=20
> That's a bug in your dmaengine driver.
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
