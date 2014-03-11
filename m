From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH v2 5/7] tty: xuartps: Rebrand driver as Cadence UART
Date: Tue, 11 Mar 2014 08:47:06 -0700
Message-ID: <6218b762-79dd-4ef7-b5ec-0a4ff82c3181@AM1EHSMHS005.ehs.local>
References: <1394487610-2419-1-git-send-email-soren.brinkmann@xilinx.com>
 <1394487610-2419-6-git-send-email-soren.brinkmann@xilinx.com>
 <08f123a4-5045-4ad1-909d-1c23eabee1c9@CO9EHSMHS023.ehs.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <08f123a4-5045-4ad1-909d-1c23eabee1c9@CO9EHSMHS023.ehs.local>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Peter Crosthwaite <peter.crosthwaite@xilinx.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Rob Landley <rob@landley.net>, Grant Likely <grant.likely@linaro.org>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, 2014-03-11 at 09:50AM +0100, Michal Simek wrote:
> On 03/10/2014 10:40 PM, Soren Brinkmann wrote:
> > Zynq's UART is Cadence IP. Make this visible in the prompt in kconf=
ig
> > and additional comments in the driver.
> > This also renames functions and symbols, as far as possible without
> > breaking user space API, to reflect the Cadence origin. This is ach=
ieved
> > through simple search and replace:
> >  - s/XUARTPS/CDNS_UART/g
> >  - s/xuartps/cdns_uart/g
> > The only exception is PORT_XUARTPS, which stays as is, due to its
> > exposure to user space.
> >=20
> > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> > ---
> >  drivers/tty/serial/Kconfig         |   9 +-
> >  drivers/tty/serial/xilinx_uartps.c | 908 +++++++++++++++++++------=
------------
> >  include/uapi/linux/serial_core.h   |   2 +-
> >  3 files changed, 471 insertions(+), 448 deletions(-)
> >=20
> > diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfi=
g
> > index a3815eaed421..1294284342bc 100644
> > --- a/drivers/tty/serial/Kconfig
> > +++ b/drivers/tty/serial/Kconfig
> > @@ -1368,18 +1368,19 @@ config SERIAL_MXS_AUART_CONSOLE
> >  	  Enable a MXS AUART port to be the system console.
> > =20
> >  config SERIAL_XILINX_PS_UART
> > -	tristate "Xilinx PS UART support"
> > +	tristate "Cadence (Xilinx Zynq) UART support"
> >  	depends on OF
> >  	select SERIAL_CORE
> >  	help
> > -	  This driver supports the Xilinx PS UART port.
> > +	  This driver supports the Cadence UART. It is found e.g. in Xili=
nx
> > +	  Zynq.
> > =20
> >  config SERIAL_XILINX_PS_UART_CONSOLE
> > -	bool "Xilinx PS UART console support"
> > +	bool "Cadence UART console support"
> >  	depends on SERIAL_XILINX_PS_UART=3Dy
> >  	select SERIAL_CORE_CONSOLE
> >  	help
> > -	  Enable a Xilinx PS UART port to be the system console.
> > +	  Enable a Cadence UART port to be the system console.
> > =20
> >  config SERIAL_AR933X
> >  	tristate "AR933X serial port support"
> > diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/seria=
l/xilinx_uartps.c
> > index a39c2d290902..f8729eabe302 100644
> > --- a/drivers/tty/serial/xilinx_uartps.c
> > +++ b/drivers/tty/serial/xilinx_uartps.c
> > @@ -1,5 +1,5 @@
> >  /*
> > - * Xilinx PS UART driver
> > + * Cadence UART driver (found in Xilinx Zynq)
> >   *
> >   * 2011 - 2014 (C) Xilinx Inc.
> >   *
> > @@ -8,6 +8,10 @@
> >   * License as published by the Free Software Foundation;
> >   * either version 2 of the License, or (at your option) any
> >   * later version.
> > + *
> > + * This driver has originally been pushed by Xilinx using a Zynq-b=
randing. This
> > + * still shows in the naming of this file, the kconfig symbols and=
 some symbols
> > + * in the code.
> >   */
> > =20
> >  #if defined(CONFIG_SERIAL_XILINX_PS_UART_CONSOLE) && defined(CONFI=
G_MAGIC_SYSRQ)
> > @@ -27,16 +31,16 @@
> >  #include <linux/of.h>
> >  #include <linux/module.h>
> > =20
> > -#define XUARTPS_TTY_NAME	"ttyPS"
> > -#define XUARTPS_NAME		"xuartps"
> > -#define XUARTPS_MAJOR		0	/* use dynamic node allocation */
> > -#define XUARTPS_MINOR		0	/* works best with devtmpfs */
> > -#define XUARTPS_NR_PORTS	2
> > -#define XUARTPS_FIFO_SIZE	64	/* FIFO size */
> > -#define XUARTPS_REGISTER_SPACE	0xFFF
> > +#define CDNS_UART_TTY_NAME	"ttyPS"
> > +#define CDNS_UART_NAME		"xuartps"
> > +#define CDNS_UART_MAJOR		0	/* use dynamic node allocation */
> > +#define CDNS_UART_MINOR		0	/* works best with devtmpfs */
> > +#define CDNS_UART_NR_PORTS	2
> > +#define CDNS_UART_FIFO_SIZE	64	/* FIFO size */
> > +#define CDNS_UART_REGISTER_SPACE	0xFFF
> > =20
> > -#define xuartps_readl(offset)		ioread32(port->membase + offset)
> > -#define xuartps_writel(val, offset)	iowrite32(val, port->membase +=
 offset)
> > +#define cdns_uart_readl(offset)		ioread32(port->membase + offset)
> > +#define cdns_uart_writel(val, offset)	iowrite32(val, port->membase=
 + offset)
> > =20
> >  /* Rx Trigger level */
> >  static int rx_trigger_level =3D 56;
> > @@ -49,35 +53,35 @@ module_param(rx_timeout, uint, S_IRUGO);
> >  MODULE_PARM_DESC(rx_timeout, "Rx timeout, 1-255");
> > =20
> >  /* Register offsets for the UART. */
> > -#define XUARTPS_CR_OFFSET	0x00  /* Control Register */
> > -#define XUARTPS_MR_OFFSET	0x04  /* Mode Register */
> > -#define XUARTPS_IER_OFFSET	0x08  /* Interrupt Enable */
> > -#define XUARTPS_IDR_OFFSET	0x0C  /* Interrupt Disable */
> > -#define XUARTPS_IMR_OFFSET	0x10  /* Interrupt Mask */
> > -#define XUARTPS_ISR_OFFSET	0x14  /* Interrupt Status */
> > -#define XUARTPS_BAUDGEN_OFFSET	0x18  /* Baud Rate Generator */
> > -#define XUARTPS_RXTOUT_OFFSET	0x1C  /* RX Timeout */
> > -#define XUARTPS_RXWM_OFFSET	0x20  /* RX FIFO Trigger Level */
> > -#define XUARTPS_MODEMCR_OFFSET	0x24  /* Modem Control */
> > -#define XUARTPS_MODEMSR_OFFSET	0x28  /* Modem Status */
> > -#define XUARTPS_SR_OFFSET	0x2C  /* Channel Status */
> > -#define XUARTPS_FIFO_OFFSET	0x30  /* FIFO */
> > -#define XUARTPS_BAUDDIV_OFFSET	0x34  /* Baud Rate Divider */
> > -#define XUARTPS_FLOWDEL_OFFSET	0x38  /* Flow Delay */
> > -#define XUARTPS_IRRX_PWIDTH_OFFSET 0x3C /* IR Minimum Received Pul=
se Width */
> > -#define XUARTPS_IRTX_PWIDTH_OFFSET 0x40 /* IR Transmitted pulse Wi=
dth */
> > -#define XUARTPS_TXWM_OFFSET	0x44  /* TX FIFO Trigger Level */
> > +#define CDNS_UART_CR_OFFSET		0x00  /* Control Register */
> > +#define CDNS_UART_MR_OFFSET		0x04  /* Mode Register */
> > +#define CDNS_UART_IER_OFFSET		0x08  /* Interrupt Enable */
> > +#define CDNS_UART_IDR_OFFSET		0x0C  /* Interrupt Disable */
> > +#define CDNS_UART_IMR_OFFSET		0x10  /* Interrupt Mask */
> > +#define CDNS_UART_ISR_OFFSET		0x14  /* Interrupt Status */
> > +#define CDNS_UART_BAUDGEN_OFFSET	0x18  /* Baud Rate Generator */
> > +#define CDNS_UART_RXTOUT_OFFSET		0x1C  /* RX Timeout */
> > +#define CDNS_UART_RXWM_OFFSET		0x20  /* RX FIFO Trigger Level */
> > +#define CDNS_UART_MODEMCR_OFFSET	0x24  /* Modem Control */
> > +#define CDNS_UART_MODEMSR_OFFSET	0x28  /* Modem Status */
> > +#define CDNS_UART_SR_OFFSET		0x2C  /* Channel Status */
> > +#define CDNS_UART_FIFO_OFFSET		0x30  /* FIFO */
> > +#define CDNS_UART_BAUDDIV_OFFSET	0x34  /* Baud Rate Divider */
> > +#define CDNS_UART_FLOWDEL_OFFSET	0x38  /* Flow Delay */
> > +#define CDNS_UART_IRRX_PWIDTH_OFFSET	0x3C  /* IR Min Received Puls=
e Width */
> > +#define CDNS_UART_IRTX_PWIDTH_OFFSET	0x40  /* IR Transmitted pulse=
 Width */
> > +#define CDNS_UART_TXWM_OFFSET		0x44  /* TX FIFO Trigger Level */
> > =20
> >  /* Control Register Bit Definitions */
> > -#define XUARTPS_CR_STOPBRK	0x00000100  /* Stop TX break */
> > -#define XUARTPS_CR_STARTBRK	0x00000080  /* Set TX break */
> > -#define XUARTPS_CR_TX_DIS	0x00000020  /* TX disabled. */
> > -#define XUARTPS_CR_TX_EN	0x00000010  /* TX enabled */
> > -#define XUARTPS_CR_RX_DIS	0x00000008  /* RX disabled. */
> > -#define XUARTPS_CR_RX_EN	0x00000004  /* RX enabled */
> > -#define XUARTPS_CR_TXRST	0x00000002  /* TX logic reset */
> > -#define XUARTPS_CR_RXRST	0x00000001  /* RX logic reset */
> > -#define XUARTPS_CR_RST_TO	0x00000040  /* Restart Timeout Counter *=
/
> > +#define CDNS_UART_CR_STOPBRK	0x00000100  /* Stop TX break */
> > +#define CDNS_UART_CR_STARTBRK	0x00000080  /* Set TX break */
> > +#define CDNS_UART_CR_TX_DIS	0x00000020  /* TX disabled. */
> > +#define CDNS_UART_CR_TX_EN	0x00000010  /* TX enabled */
> > +#define CDNS_UART_CR_RX_DIS	0x00000008  /* RX disabled. */
> > +#define CDNS_UART_CR_RX_EN	0x00000004  /* RX enabled */
> > +#define CDNS_UART_CR_TXRST	0x00000002  /* TX logic reset */
> > +#define CDNS_UART_CR_RXRST	0x00000001  /* RX logic reset */
> > +#define CDNS_UART_CR_RST_TO	0x00000040  /* Restart Timeout Counter=
 */
> > =20
> >  /*
> >   * Mode Register:
> > @@ -85,22 +89,22 @@ MODULE_PARM_DESC(rx_timeout, "Rx timeout, 1-255=
");
> >   * format. If this register is modified during transmission or rec=
eption,
> >   * data validity cannot be guaranteed.
> >   */
> > -#define XUARTPS_MR_CLKSEL		0x00000001  /* Pre-scalar selection */
> > -#define XUARTPS_MR_CHMODE_L_LOOP	0x00000200  /* Local loop back mo=
de */
> > -#define XUARTPS_MR_CHMODE_NORM		0x00000000  /* Normal mode */
> > +#define CDNS_UART_MR_CLKSEL		0x00000001  /* Pre-scalar selection *=
/
> > +#define CDNS_UART_MR_CHMODE_L_LOOP	0x00000200  /* Local loop back =
mode */
> > +#define CDNS_UART_MR_CHMODE_NORM	0x00000000  /* Normal mode */
> > =20
> > -#define XUARTPS_MR_STOPMODE_2_BIT	0x00000080  /* 2 stop bits */
> > -#define XUARTPS_MR_STOPMODE_1_BIT	0x00000000  /* 1 stop bit */
> > +#define CDNS_UART_MR_STOPMODE_2_BIT	0x00000080  /* 2 stop bits */
> > +#define CDNS_UART_MR_STOPMODE_1_BIT	0x00000000  /* 1 stop bit */
> > =20
> > -#define XUARTPS_MR_PARITY_NONE		0x00000020  /* No parity mode */
> > -#define XUARTPS_MR_PARITY_MARK		0x00000018  /* Mark parity mode */
> > -#define XUARTPS_MR_PARITY_SPACE		0x00000010  /* Space parity mode =
*/
> > -#define XUARTPS_MR_PARITY_ODD		0x00000008  /* Odd parity mode */
> > -#define XUARTPS_MR_PARITY_EVEN		0x00000000  /* Even parity mode */
> > +#define CDNS_UART_MR_PARITY_NONE	0x00000020  /* No parity mode */
> > +#define CDNS_UART_MR_PARITY_MARK	0x00000018  /* Mark parity mode *=
/
> > +#define CDNS_UART_MR_PARITY_SPACE	0x00000010  /* Space parity mode=
 */
> > +#define CDNS_UART_MR_PARITY_ODD		0x00000008  /* Odd parity mode */
> > +#define CDNS_UART_MR_PARITY_EVEN	0x00000000  /* Even parity mode *=
/
> > =20
> > -#define XUARTPS_MR_CHARLEN_6_BIT	0x00000006  /* 6 bits data */
> > -#define XUARTPS_MR_CHARLEN_7_BIT	0x00000004  /* 7 bits data */
> > -#define XUARTPS_MR_CHARLEN_8_BIT	0x00000000  /* 8 bits data */
> > +#define CDNS_UART_MR_CHARLEN_6_BIT	0x00000006  /* 6 bits data */
> > +#define CDNS_UART_MR_CHARLEN_7_BIT	0x00000004  /* 7 bits data */
> > +#define CDNS_UART_MR_CHARLEN_8_BIT	0x00000000  /* 8 bits data */
> > =20
> >  /*
> >   * Interrupt Registers:
> > @@ -113,20 +117,20 @@ MODULE_PARM_DESC(rx_timeout, "Rx timeout, 1-2=
55");
> >   * Reading either IER or IDR returns 0x00.
> >   * All four registers have the same bit definitions.
> >   */
> > -#define XUARTPS_IXR_TOUT	0x00000100 /* RX Timeout error interrupt =
*/
> > -#define XUARTPS_IXR_PARITY	0x00000080 /* Parity error interrupt */
> > -#define XUARTPS_IXR_FRAMING	0x00000040 /* Framing error interrupt =
*/
> > -#define XUARTPS_IXR_OVERRUN	0x00000020 /* Overrun error interrupt =
*/
> > -#define XUARTPS_IXR_TXFULL	0x00000010 /* TX FIFO Full interrupt */
> > -#define XUARTPS_IXR_TXEMPTY	0x00000008 /* TX FIFO empty interrupt =
*/
> > -#define XUARTPS_ISR_RXEMPTY	0x00000002 /* RX FIFO empty interrupt =
*/
> > -#define XUARTPS_IXR_RXTRIG	0x00000001 /* RX FIFO trigger interrupt=
 */
> > -#define XUARTPS_IXR_RXFULL	0x00000004 /* RX FIFO full interrupt. *=
/
> > -#define XUARTPS_IXR_RXEMPTY	0x00000002 /* RX FIFO empty interrupt.=
 */
> > -#define XUARTPS_IXR_MASK	0x00001FFF /* Valid bit mask */
> > +#define CDNS_UART_IXR_TOUT	0x00000100 /* RX Timeout error interrup=
t */
> > +#define CDNS_UART_IXR_PARITY	0x00000080 /* Parity error interrupt =
*/
> > +#define CDNS_UART_IXR_FRAMING	0x00000040 /* Framing error interrup=
t */
> > +#define CDNS_UART_IXR_OVERRUN	0x00000020 /* Overrun error interrup=
t */
> > +#define CDNS_UART_IXR_TXFULL	0x00000010 /* TX FIFO Full interrupt =
*/
> > +#define CDNS_UART_IXR_TXEMPTY	0x00000008 /* TX FIFO empty interrup=
t */
> > +#define CDNS_UART_ISR_RXEMPTY	0x00000002 /* RX FIFO empty interrup=
t */
> > +#define CDNS_UART_IXR_RXTRIG	0x00000001 /* RX FIFO trigger interru=
pt */
> > +#define CDNS_UART_IXR_RXFULL	0x00000004 /* RX FIFO full interrupt.=
 */
> > +#define CDNS_UART_IXR_RXEMPTY	0x00000002 /* RX FIFO empty interrup=
t. */
> > +#define CDNS_UART_IXR_MASK	0x00001FFF /* Valid bit mask */
> > =20
> >  /* Goes in read_status_mask for break detection as the HW doesn't =
do it*/
> > -#define XUARTPS_IXR_BRK		0x80000000
> > +#define CDNS_UART_IXR_BRK	0x80000000
> > =20
> >  /*
> >   * Channel Status Register:
> > @@ -134,41 +138,42 @@ MODULE_PARM_DESC(rx_timeout, "Rx timeout, 1-2=
55");
> >   * to monitor the status of bits in the channel interrupt status r=
egister,
> >   * even if these are masked out by the interrupt mask register.
> >   */
> > -#define XUARTPS_SR_RXEMPTY	0x00000002 /* RX FIFO empty */
> > -#define XUARTPS_SR_TXEMPTY	0x00000008 /* TX FIFO empty */
> > -#define XUARTPS_SR_TXFULL	0x00000010 /* TX FIFO full */
> > -#define XUARTPS_SR_RXTRIG	0x00000001 /* Rx Trigger */
> > +#define CDNS_UART_SR_RXEMPTY	0x00000002 /* RX FIFO empty */
> > +#define CDNS_UART_SR_TXEMPTY	0x00000008 /* TX FIFO empty */
> > +#define CDNS_UART_SR_TXFULL	0x00000010 /* TX FIFO full */
> > +#define CDNS_UART_SR_RXTRIG	0x00000001 /* Rx Trigger */
> > =20
> >  /* baud dividers min/max values */
> > -#define XUARTPS_BDIV_MIN	4
> > -#define XUARTPS_BDIV_MAX	255
> > -#define XUARTPS_CD_MAX		65535
> > +#define CDNS_UART_BDIV_MIN	4
> > +#define CDNS_UART_BDIV_MAX	255
> > +#define CDNS_UART_CD_MAX	65535
> > =20
> >  /**
> > - * struct xuartps - device data
> > + * struct cdns_uart - device data
> >   * @port:		Pointer to the UART port
> > - * @refclk:		Reference clock
> > - * @aperclk:		APB clock
> > + * @uartclk:		Reference clock
> > + * @pclk:		APB clock
> >   * @baud:		Current baud rate
> >   * @clk_rate_change_nb:	Notifier block for clock changes
> >   */
> > -struct xuartps {
> > +struct cdns_uart {
> >  	struct uart_port	*port;
> > -	struct clk		*refclk;
> > -	struct clk		*aperclk;
> > +	struct clk		*uartclk;
> > +	struct clk		*pclk;
> >  	unsigned int		baud;
> >  	struct notifier_block	clk_rate_change_nb;
> >  };
> > -#define to_xuartps(_nb) container_of(_nb, struct xuartps, clk_rate=
_change_nb);
> > +#define to_cdns_uart(_nb) container_of(_nb, struct cdns_uart, \
> > +		clk_rate_change_nb);
> > =20
> >  /**
> > - * xuartps_isr - Interrupt handler
> > + * cdns_uart_isr - Interrupt handler
> >   * @irq: Irq number
> >   * @dev_id: Id of the port
> >   *
> >   * Return: IRQHANDLED
> >   */
> > -static irqreturn_t xuartps_isr(int irq, void *dev_id)
> > +static irqreturn_t cdns_uart_isr(int irq, void *dev_id)
> >  {
> >  	struct uart_port *port =3D (struct uart_port *)dev_id;
> >  	unsigned long flags;
> > @@ -181,42 +186,42 @@ static irqreturn_t xuartps_isr(int irq, void =
*dev_id)
> >  	/* Read the interrupt status register to determine which
> >  	 * interrupt(s) is/are active.
> >  	 */
> > -	isrstatus =3D xuartps_readl(XUARTPS_ISR_OFFSET);
> > +	isrstatus =3D cdns_uart_readl(CDNS_UART_ISR_OFFSET);
> > =20
> >  	/*
> >  	 * There is no hardware break detection, so we interpret framing
> >  	 * error with all-zeros data as a break sequence. Most of the tim=
e,
> >  	 * there's another non-zero byte at the end of the sequence.
> >  	 */
> > -	if (isrstatus & XUARTPS_IXR_FRAMING) {
> > -		while (!(xuartps_readl(XUARTPS_SR_OFFSET) &
> > -					XUARTPS_SR_RXEMPTY)) {
> > -			if (!xuartps_readl(XUARTPS_FIFO_OFFSET)) {
> > -				port->read_status_mask |=3D XUARTPS_IXR_BRK;
> > -				isrstatus &=3D ~XUARTPS_IXR_FRAMING;
> > +	if (isrstatus & CDNS_UART_IXR_FRAMING) {
> > +		while (!(cdns_uart_readl(CDNS_UART_SR_OFFSET) &
> > +					CDNS_UART_SR_RXEMPTY)) {
> > +			if (!cdns_uart_readl(CDNS_UART_FIFO_OFFSET)) {
> > +				port->read_status_mask |=3D CDNS_UART_IXR_BRK;
> > +				isrstatus &=3D ~CDNS_UART_IXR_FRAMING;
> >  			}
> >  		}
> > -		xuartps_writel(XUARTPS_IXR_FRAMING, XUARTPS_ISR_OFFSET);
> > +		cdns_uart_writel(CDNS_UART_IXR_FRAMING, CDNS_UART_ISR_OFFSET);
> >  	}
> > =20
> >  	/* drop byte with parity error if IGNPAR specified */
> > -	if (isrstatus & port->ignore_status_mask & XUARTPS_IXR_PARITY)
> > -		isrstatus &=3D ~(XUARTPS_IXR_RXTRIG | XUARTPS_IXR_TOUT);
> > +	if (isrstatus & port->ignore_status_mask & CDNS_UART_IXR_PARITY)
> > +		isrstatus &=3D ~(CDNS_UART_IXR_RXTRIG | CDNS_UART_IXR_TOUT);
> > =20
> >  	isrstatus &=3D port->read_status_mask;
> >  	isrstatus &=3D ~port->ignore_status_mask;
> > =20
> > -	if ((isrstatus & XUARTPS_IXR_TOUT) ||
> > -		(isrstatus & XUARTPS_IXR_RXTRIG)) {
> > +	if ((isrstatus & CDNS_UART_IXR_TOUT) ||
> > +		(isrstatus & CDNS_UART_IXR_RXTRIG)) {
> >  		/* Receive Timeout Interrupt */
> > -		while ((xuartps_readl(XUARTPS_SR_OFFSET) &
> > -			XUARTPS_SR_RXEMPTY) !=3D XUARTPS_SR_RXEMPTY) {
> > -			data =3D xuartps_readl(XUARTPS_FIFO_OFFSET);
> > +		while ((cdns_uart_readl(CDNS_UART_SR_OFFSET) &
> > +			CDNS_UART_SR_RXEMPTY) !=3D CDNS_UART_SR_RXEMPTY) {
> > +			data =3D cdns_uart_readl(CDNS_UART_FIFO_OFFSET);
> > =20
> >  			/* Non-NULL byte after BREAK is garbage (99%) */
> >  			if (data && (port->read_status_mask &
> > -						XUARTPS_IXR_BRK)) {
> > -				port->read_status_mask &=3D ~XUARTPS_IXR_BRK;
> > +						CDNS_UART_IXR_BRK)) {
> > +				port->read_status_mask &=3D ~CDNS_UART_IXR_BRK;
> >  				port->icount.brk++;
> >  				if (uart_handle_break(port))
> >  					continue;
> > @@ -240,17 +245,17 @@ static irqreturn_t xuartps_isr(int irq, void =
*dev_id)
> > =20
> >  			port->icount.rx++;
> > =20
> > -			if (isrstatus & XUARTPS_IXR_PARITY) {
> > +			if (isrstatus & CDNS_UART_IXR_PARITY) {
> >  				port->icount.parity++;
> >  				status =3D TTY_PARITY;
> > -			} else if (isrstatus & XUARTPS_IXR_FRAMING) {
> > +			} else if (isrstatus & CDNS_UART_IXR_FRAMING) {
> >  				port->icount.frame++;
> >  				status =3D TTY_FRAME;
> > -			} else if (isrstatus & XUARTPS_IXR_OVERRUN) {
> > +			} else if (isrstatus & CDNS_UART_IXR_OVERRUN) {
> >  				port->icount.overrun++;
> >  			}
> > =20
> > -			uart_insert_char(port, isrstatus, XUARTPS_IXR_OVERRUN,
> > +			uart_insert_char(port, isrstatus, CDNS_UART_IXR_OVERRUN,
> >  					data, status);
> >  		}
> >  		spin_unlock(&port->lock);
> > @@ -259,10 +264,10 @@ static irqreturn_t xuartps_isr(int irq, void =
*dev_id)
> >  	}
> > =20
> >  	/* Dispatch an appropriate handler */
> > -	if ((isrstatus & XUARTPS_IXR_TXEMPTY) =3D=3D XUARTPS_IXR_TXEMPTY)=
 {
> > +	if ((isrstatus & CDNS_UART_IXR_TXEMPTY) =3D=3D CDNS_UART_IXR_TXEM=
PTY) {
> >  		if (uart_circ_empty(&port->state->xmit)) {
> > -			xuartps_writel(XUARTPS_IXR_TXEMPTY,
> > -						XUARTPS_IDR_OFFSET);
> > +			cdns_uart_writel(CDNS_UART_IXR_TXEMPTY,
> > +						CDNS_UART_IDR_OFFSET);
> >  		} else {
> >  			numbytes =3D port->fifosize;
> >  			/* Break if no more data available in the UART buffer */
> > @@ -270,12 +275,12 @@ static irqreturn_t xuartps_isr(int irq, void =
*dev_id)
> >  				if (uart_circ_empty(&port->state->xmit))
> >  					break;
> >  				/* Get the data from the UART circular buffer
> > -				 * and write it to the xuartps's TX_FIFO
> > +				 * and write it to the cdns_uart's TX_FIFO
> >  				 * register.
> >  				 */
> > -				xuartps_writel(
> > +				cdns_uart_writel(
> >  					port->state->xmit.buf[port->state->xmit.
> > -					tail], XUARTPS_FIFO_OFFSET);
> > +					tail], CDNS_UART_FIFO_OFFSET);
> > =20
> >  				port->icount.tx++;
> > =20
> > @@ -293,7 +298,7 @@ static irqreturn_t xuartps_isr(int irq, void *d=
ev_id)
> >  		}
> >  	}
> > =20
> > -	xuartps_writel(isrstatus, XUARTPS_ISR_OFFSET);
> > +	cdns_uart_writel(isrstatus, CDNS_UART_ISR_OFFSET);
> > =20
> >  	/* be sure to release the lock and tty before leaving */
> >  	spin_unlock_irqrestore(&port->lock, flags);
> > @@ -302,7 +307,7 @@ static irqreturn_t xuartps_isr(int irq, void *d=
ev_id)
> >  }
> > =20
> >  /**
> > - * xuartps_calc_baud_divs - Calculate baud rate divisors
> > + * cdns_uart_calc_baud_divs - Calculate baud rate divisors
> >   * @clk: UART module input clock
> >   * @baud: Desired baud rate
> >   * @rbdiv: BDIV value (return value)
> > @@ -321,8 +326,8 @@ static irqreturn_t xuartps_isr(int irq, void *d=
ev_id)
> >   *			baud rate generate register
> >   *			baud rate clock divisor register
> >   */
> > -static unsigned int xuartps_calc_baud_divs(unsigned int clk, unsig=
ned int baud,
> > -		u32 *rbdiv, u32 *rcd, int *div8)
> > +static unsigned int cdns_uart_calc_baud_divs(unsigned int clk,
> > +		unsigned int baud, u32 *rbdiv, u32 *rcd, int *div8)
> >  {
> >  	u32 cd, bdiv;
> >  	unsigned int calc_baud;
> > @@ -330,16 +335,16 @@ static unsigned int xuartps_calc_baud_divs(un=
signed int clk, unsigned int baud,
> >  	unsigned int bauderror;
> >  	unsigned int besterror =3D ~0;
> > =20
> > -	if (baud < clk / ((XUARTPS_BDIV_MAX + 1) * XUARTPS_CD_MAX)) {
> > +	if (baud < clk / ((CDNS_UART_BDIV_MAX + 1) * CDNS_UART_CD_MAX)) {
> >  		*div8 =3D 1;
> >  		clk /=3D 8;
> >  	} else {
> >  		*div8 =3D 0;
> >  	}
> > =20
> > -	for (bdiv =3D XUARTPS_BDIV_MIN; bdiv <=3D XUARTPS_BDIV_MAX; bdiv+=
+) {
> > +	for (bdiv =3D CDNS_UART_BDIV_MIN; bdiv <=3D CDNS_UART_BDIV_MAX; b=
div++) {
> >  		cd =3D DIV_ROUND_CLOSEST(clk, baud * (bdiv + 1));
> > -		if (cd < 1 || cd > XUARTPS_CD_MAX)
> > +		if (cd < 1 || cd > CDNS_UART_CD_MAX)
> >  			continue;
> > =20
> >  		calc_baud =3D clk / (cd * (bdiv + 1));
> > @@ -364,47 +369,47 @@ static unsigned int xuartps_calc_baud_divs(un=
signed int clk, unsigned int baud,
> >  }
> > =20
> >  /**
> > - * xuartps_set_baud_rate - Calculate and set the baud rate
> > + * cdns_uart_set_baud_rate - Calculate and set the baud rate
> >   * @port: Handle to the uart port structure
> >   * @baud: Baud rate to set
> >   * Return: baud rate, requested baud when possible, or actual baud=
 when there
> >   *	   was too much error, zero if no valid divisors are found.
> >   */
> > -static unsigned int xuartps_set_baud_rate(struct uart_port *port,
> > +static unsigned int cdns_uart_set_baud_rate(struct uart_port *port=
,
> >  		unsigned int baud)
> >  {
> >  	unsigned int calc_baud;
> >  	u32 cd =3D 0, bdiv =3D 0;
> >  	u32 mreg;
> >  	int div8;
> > -	struct xuartps *xuartps =3D port->private_data;
> > +	struct cdns_uart *cdns_uart =3D port->private_data;
> > =20
> > -	calc_baud =3D xuartps_calc_baud_divs(port->uartclk, baud, &bdiv, =
&cd,
> > +	calc_baud =3D cdns_uart_calc_baud_divs(port->uartclk, baud, &bdiv=
, &cd,
> >  			&div8);
> > =20
> >  	/* Write new divisors to hardware */
> > -	mreg =3D xuartps_readl(XUARTPS_MR_OFFSET);
> > +	mreg =3D cdns_uart_readl(CDNS_UART_MR_OFFSET);
> >  	if (div8)
> > -		mreg |=3D XUARTPS_MR_CLKSEL;
> > +		mreg |=3D CDNS_UART_MR_CLKSEL;
> >  	else
> > -		mreg &=3D ~XUARTPS_MR_CLKSEL;
> > -	xuartps_writel(mreg, XUARTPS_MR_OFFSET);
> > -	xuartps_writel(cd, XUARTPS_BAUDGEN_OFFSET);
> > -	xuartps_writel(bdiv, XUARTPS_BAUDDIV_OFFSET);
> > -	xuartps->baud =3D baud;
> > +		mreg &=3D ~CDNS_UART_MR_CLKSEL;
> > +	cdns_uart_writel(mreg, CDNS_UART_MR_OFFSET);
> > +	cdns_uart_writel(cd, CDNS_UART_BAUDGEN_OFFSET);
> > +	cdns_uart_writel(bdiv, CDNS_UART_BAUDDIV_OFFSET);
> > +	cdns_uart->baud =3D baud;
> > =20
> >  	return calc_baud;
> >  }
> > =20
> >  #ifdef CONFIG_COMMON_CLK
> >  /**
> > - * xuartps_clk_notitifer_cb - Clock notifier callback
> > + * cdns_uart_clk_notitifer_cb - Clock notifier callback
> >   * @nb:		Notifier block
> >   * @event:	Notify event
> >   * @data:	Notifier data
> >   * Return:	NOTIFY_OK or NOTIFY_DONE on success, NOTIFY_BAD on erro=
r.
> >   */
> > -static int xuartps_clk_notifier_cb(struct notifier_block *nb,
> > +static int cdns_uart_clk_notifier_cb(struct notifier_block *nb,
> >  		unsigned long event, void *data)
> >  {
> >  	u32 ctrl_reg;
> > @@ -412,9 +417,9 @@ static int xuartps_clk_notifier_cb(struct notif=
ier_block *nb,
> >  	int locked =3D 0;
> >  	struct clk_notifier_data *ndata =3D data;
> >  	unsigned long flags =3D 0;
> > -	struct xuartps *xuartps =3D to_xuartps(nb);
> > +	struct cdns_uart *cdns_uart =3D to_cdns_uart(nb);
> > =20
> > -	port =3D xuartps->port;
> > +	port =3D cdns_uart->port;
> >  	if (port->suspended)
> >  		return NOTIFY_OK;
> > =20
> > @@ -428,20 +433,20 @@ static int xuartps_clk_notifier_cb(struct not=
ifier_block *nb,
> >  		 * Find out if current baud-rate can be achieved with new clock
> >  		 * frequency.
> >  		 */
> > -		if (!xuartps_calc_baud_divs(ndata->new_rate, xuartps->baud,
> > +		if (!cdns_uart_calc_baud_divs(ndata->new_rate, cdns_uart->baud,
> >  					&bdiv, &cd, &div8)) {
> >  			dev_warn(port->dev, "clock rate change rejected\n");
> >  			return NOTIFY_BAD;
> >  		}
> > =20
> > -		spin_lock_irqsave(&xuartps->port->lock, flags);
> > +		spin_lock_irqsave(&cdns_uart->port->lock, flags);
> > =20
> >  		/* Disable the TX and RX to set baud rate */
> > -		ctrl_reg =3D xuartps_readl(XUARTPS_CR_OFFSET);
> > -		ctrl_reg |=3D XUARTPS_CR_TX_DIS | XUARTPS_CR_RX_DIS;
> > -		xuartps_writel(ctrl_reg, XUARTPS_CR_OFFSET);
> > +		ctrl_reg =3D cdns_uart_readl(CDNS_UART_CR_OFFSET);
> > +		ctrl_reg |=3D CDNS_UART_CR_TX_DIS | CDNS_UART_CR_RX_DIS;
> > +		cdns_uart_writel(ctrl_reg, CDNS_UART_CR_OFFSET);
> > =20
> > -		spin_unlock_irqrestore(&xuartps->port->lock, flags);
> > +		spin_unlock_irqrestore(&cdns_uart->port->lock, flags);
> > =20
> >  		return NOTIFY_OK;
> >  	}
> > @@ -451,25 +456,25 @@ static int xuartps_clk_notifier_cb(struct not=
ifier_block *nb,
> >  		 * frequency.
> >  		 */
> > =20
> > -		spin_lock_irqsave(&xuartps->port->lock, flags);
> > +		spin_lock_irqsave(&cdns_uart->port->lock, flags);
> > =20
> >  		locked =3D 1;
> >  		port->uartclk =3D ndata->new_rate;
> > =20
> > -		xuartps->baud =3D xuartps_set_baud_rate(xuartps->port,
> > -				xuartps->baud);
> > +		cdns_uart->baud =3D cdns_uart_set_baud_rate(cdns_uart->port,
> > +				cdns_uart->baud);
> >  		/* fall through */
> >  	case ABORT_RATE_CHANGE:
> >  		if (!locked)
> > -			spin_lock_irqsave(&xuartps->port->lock, flags);
> > +			spin_lock_irqsave(&cdns_uart->port->lock, flags);
> > =20
> >  		/* Set TX/RX Reset */
> > -		ctrl_reg =3D xuartps_readl(XUARTPS_CR_OFFSET);
> > -		ctrl_reg |=3D XUARTPS_CR_TXRST | XUARTPS_CR_RXRST;
> > -		xuartps_writel(ctrl_reg, XUARTPS_CR_OFFSET);
> > +		ctrl_reg =3D cdns_uart_readl(CDNS_UART_CR_OFFSET);
> > +		ctrl_reg |=3D CDNS_UART_CR_TXRST | CDNS_UART_CR_RXRST;
> > +		cdns_uart_writel(ctrl_reg, CDNS_UART_CR_OFFSET);
> > =20
> > -		while (xuartps_readl(XUARTPS_CR_OFFSET) &
> > -				(XUARTPS_CR_TXRST | XUARTPS_CR_RXRST))
> > +		while (cdns_uart_readl(CDNS_UART_CR_OFFSET) &
> > +				(CDNS_UART_CR_TXRST | CDNS_UART_CR_RXRST))
> >  			cpu_relax();
> > =20
> >  		/*
> > @@ -477,13 +482,13 @@ static int xuartps_clk_notifier_cb(struct not=
ifier_block *nb,
> >  		 * enable bit and RX enable bit to enable the transmitter and
> >  		 * receiver.
> >  		 */
> > -		xuartps_writel(rx_timeout, XUARTPS_RXTOUT_OFFSET);
> > -		ctrl_reg =3D xuartps_readl(XUARTPS_CR_OFFSET);
> > -		ctrl_reg &=3D ~(XUARTPS_CR_TX_DIS | XUARTPS_CR_RX_DIS);
> > -		ctrl_reg |=3D XUARTPS_CR_TX_EN | XUARTPS_CR_RX_EN;
> > -		xuartps_writel(ctrl_reg, XUARTPS_CR_OFFSET);
> > +		cdns_uart_writel(rx_timeout, CDNS_UART_RXTOUT_OFFSET);
> > +		ctrl_reg =3D cdns_uart_readl(CDNS_UART_CR_OFFSET);
> > +		ctrl_reg &=3D ~(CDNS_UART_CR_TX_DIS | CDNS_UART_CR_RX_DIS);
> > +		ctrl_reg |=3D CDNS_UART_CR_TX_EN | CDNS_UART_CR_RX_EN;
> > +		cdns_uart_writel(ctrl_reg, CDNS_UART_CR_OFFSET);
> > =20
> > -		spin_unlock_irqrestore(&xuartps->port->lock, flags);
> > +		spin_unlock_irqrestore(&cdns_uart->port->lock, flags);
> > =20
> >  		return NOTIFY_OK;
> >  	default:
> > @@ -493,35 +498,35 @@ static int xuartps_clk_notifier_cb(struct not=
ifier_block *nb,
> >  #endif
> > =20
> >  /**
> > - * xuartps_start_tx -  Start transmitting bytes
> > + * cdns_uart_start_tx -  Start transmitting bytes
> >   * @port: Handle to the uart port structure
> >   */
> > -static void xuartps_start_tx(struct uart_port *port)
> > +static void cdns_uart_start_tx(struct uart_port *port)
> >  {
> >  	unsigned int status, numbytes =3D port->fifosize;
> > =20
> >  	if (uart_circ_empty(&port->state->xmit) || uart_tx_stopped(port))
> >  		return;
> > =20
> > -	status =3D xuartps_readl(XUARTPS_CR_OFFSET);
> > +	status =3D cdns_uart_readl(CDNS_UART_CR_OFFSET);
> >  	/* Set the TX enable bit and clear the TX disable bit to enable t=
he
> >  	 * transmitter.
> >  	 */
> > -	xuartps_writel((status & ~XUARTPS_CR_TX_DIS) | XUARTPS_CR_TX_EN,
> > -		XUARTPS_CR_OFFSET);
> > +	cdns_uart_writel((status & ~CDNS_UART_CR_TX_DIS) | CDNS_UART_CR_T=
X_EN,
> > +		CDNS_UART_CR_OFFSET);
> > =20
> > -	while (numbytes-- && ((xuartps_readl(XUARTPS_SR_OFFSET) &
> > -				XUARTPS_SR_TXFULL)) !=3D XUARTPS_SR_TXFULL) {
> > +	while (numbytes-- && ((cdns_uart_readl(CDNS_UART_SR_OFFSET) &
> > +				CDNS_UART_SR_TXFULL)) !=3D CDNS_UART_SR_TXFULL) {
> >  		/* Break if no more data available in the UART buffer */
> >  		if (uart_circ_empty(&port->state->xmit))
> >  			break;
> > =20
> >  		/* Get the data from the UART circular buffer and
> > -		 * write it to the xuartps's TX_FIFO register.
> > +		 * write it to the cdns_uart's TX_FIFO register.
> >  		 */
> > -		xuartps_writel(
> > +		cdns_uart_writel(
> >  			port->state->xmit.buf[port->state->xmit.tail],
> > -			XUARTPS_FIFO_OFFSET);
> > +			CDNS_UART_FIFO_OFFSET);
> >  		port->icount.tx++;
> > =20
> >  		/* Adjust the tail of the UART buffer and wrap
> > @@ -530,90 +535,90 @@ static void xuartps_start_tx(struct uart_port=
 *port)
> >  		port->state->xmit.tail =3D (port->state->xmit.tail + 1) &
> >  					(UART_XMIT_SIZE - 1);
> >  	}
> > -	xuartps_writel(XUARTPS_IXR_TXEMPTY, XUARTPS_ISR_OFFSET);
> > +	cdns_uart_writel(CDNS_UART_IXR_TXEMPTY, CDNS_UART_ISR_OFFSET);
> >  	/* Enable the TX Empty interrupt */
> > -	xuartps_writel(XUARTPS_IXR_TXEMPTY, XUARTPS_IER_OFFSET);
> > +	cdns_uart_writel(CDNS_UART_IXR_TXEMPTY, CDNS_UART_IER_OFFSET);
> > =20
> >  	if (uart_circ_chars_pending(&port->state->xmit) < WAKEUP_CHARS)
> >  		uart_write_wakeup(port);
> >  }
> > =20
> >  /**
> > - * xuartps_stop_tx - Stop TX
> > + * cdns_uart_stop_tx - Stop TX
> >   * @port: Handle to the uart port structure
> >   */
> > -static void xuartps_stop_tx(struct uart_port *port)
> > +static void cdns_uart_stop_tx(struct uart_port *port)
> >  {
> >  	unsigned int regval;
> > =20
> > -	regval =3D xuartps_readl(XUARTPS_CR_OFFSET);
> > -	regval |=3D XUARTPS_CR_TX_DIS;
> > +	regval =3D cdns_uart_readl(CDNS_UART_CR_OFFSET);
> > +	regval |=3D CDNS_UART_CR_TX_DIS;
> >  	/* Disable the transmitter */
> > -	xuartps_writel(regval, XUARTPS_CR_OFFSET);
> > +	cdns_uart_writel(regval, CDNS_UART_CR_OFFSET);
> >  }
> > =20
> >  /**
> > - * xuartps_stop_rx - Stop RX
> > + * cdns_uart_stop_rx - Stop RX
> >   * @port: Handle to the uart port structure
> >   */
> > -static void xuartps_stop_rx(struct uart_port *port)
> > +static void cdns_uart_stop_rx(struct uart_port *port)
> >  {
> >  	unsigned int regval;
> > =20
> > -	regval =3D xuartps_readl(XUARTPS_CR_OFFSET);
> > -	regval |=3D XUARTPS_CR_RX_DIS;
> > +	regval =3D cdns_uart_readl(CDNS_UART_CR_OFFSET);
> > +	regval |=3D CDNS_UART_CR_RX_DIS;
> >  	/* Disable the receiver */
> > -	xuartps_writel(regval, XUARTPS_CR_OFFSET);
> > +	cdns_uart_writel(regval, CDNS_UART_CR_OFFSET);
> >  }
> > =20
> >  /**
> > - * xuartps_tx_empty -  Check whether TX is empty
> > + * cdns_uart_tx_empty -  Check whether TX is empty
> >   * @port: Handle to the uart port structure
> >   *
> >   * Return: TIOCSER_TEMT on success, 0 otherwise
> >   */
> > -static unsigned int xuartps_tx_empty(struct uart_port *port)
> > +static unsigned int cdns_uart_tx_empty(struct uart_port *port)
> >  {
> >  	unsigned int status;
> > =20
> > -	status =3D xuartps_readl(XUARTPS_ISR_OFFSET) & XUARTPS_IXR_TXEMPT=
Y;
> > +	status =3D cdns_uart_readl(CDNS_UART_ISR_OFFSET) & CDNS_UART_IXR_=
TXEMPTY;
> >  	return status ? TIOCSER_TEMT : 0;
> >  }
> > =20
> >  /**
> > - * xuartps_break_ctl - Based on the input ctl we have to start or =
stop
> > + * cdns_uart_break_ctl - Based on the input ctl we have to start o=
r stop
> >   *			transmitting char breaks
> >   * @port: Handle to the uart port structure
> >   * @ctl: Value based on which start or stop decision is taken
> >   */
> > -static void xuartps_break_ctl(struct uart_port *port, int ctl)
> > +static void cdns_uart_break_ctl(struct uart_port *port, int ctl)
> >  {
> >  	unsigned int status;
> >  	unsigned long flags;
> > =20
> >  	spin_lock_irqsave(&port->lock, flags);
> > =20
> > -	status =3D xuartps_readl(XUARTPS_CR_OFFSET);
> > +	status =3D cdns_uart_readl(CDNS_UART_CR_OFFSET);
> > =20
> >  	if (ctl =3D=3D -1)
> > -		xuartps_writel(XUARTPS_CR_STARTBRK | status,
> > -					XUARTPS_CR_OFFSET);
> > +		cdns_uart_writel(CDNS_UART_CR_STARTBRK | status,
> > +					CDNS_UART_CR_OFFSET);
> >  	else {
> > -		if ((status & XUARTPS_CR_STOPBRK) =3D=3D 0)
> > -			xuartps_writel(XUARTPS_CR_STOPBRK | status,
> > -					 XUARTPS_CR_OFFSET);
> > +		if ((status & CDNS_UART_CR_STOPBRK) =3D=3D 0)
> > +			cdns_uart_writel(CDNS_UART_CR_STOPBRK | status,
> > +					 CDNS_UART_CR_OFFSET);
> >  	}
> >  	spin_unlock_irqrestore(&port->lock, flags);
> >  }
> > =20
> >  /**
> > - * xuartps_set_termios - termios operations, handling data length,=
 parity,
> > + * cdns_uart_set_termios - termios operations, handling data lengt=
h, parity,
> >   *				stop bits, flow control, baud rate
> >   * @port: Handle to the uart port structure
> >   * @termios: Handle to the input termios structure
> >   * @old: Values of the previously saved termios structure
> >   */
> > -static void xuartps_set_termios(struct uart_port *port,
> > +static void cdns_uart_set_termios(struct uart_port *port,
> >  				struct ktermios *termios, struct ktermios *old)
> >  {
> >  	unsigned int cval =3D 0;
> > @@ -624,25 +629,26 @@ static void xuartps_set_termios(struct uart_p=
ort *port,
> >  	spin_lock_irqsave(&port->lock, flags);
> > =20
> >  	/* Empty the receive FIFO 1st before making changes */
> > -	while ((xuartps_readl(XUARTPS_SR_OFFSET) &
> > -		 XUARTPS_SR_RXEMPTY) !=3D XUARTPS_SR_RXEMPTY) {
> > -		xuartps_readl(XUARTPS_FIFO_OFFSET);
> > +	while ((cdns_uart_readl(CDNS_UART_SR_OFFSET) &
> > +		 CDNS_UART_SR_RXEMPTY) !=3D CDNS_UART_SR_RXEMPTY) {
> > +		cdns_uart_readl(CDNS_UART_FIFO_OFFSET);
> >  	}
> > =20
> >  	/* Disable the TX and RX to set baud rate */
> > -	ctrl_reg =3D xuartps_readl(XUARTPS_CR_OFFSET);
> > -	ctrl_reg |=3D XUARTPS_CR_TX_DIS | XUARTPS_CR_RX_DIS;
> > -	xuartps_writel(ctrl_reg, XUARTPS_CR_OFFSET);
> > +	ctrl_reg =3D cdns_uart_readl(CDNS_UART_CR_OFFSET);
> > +	ctrl_reg |=3D CDNS_UART_CR_TX_DIS | CDNS_UART_CR_RX_DIS;
> > +	cdns_uart_writel(ctrl_reg, CDNS_UART_CR_OFFSET);
> > =20
> >  	/*
> >  	 * Min baud rate =3D 6bps and Max Baud Rate is 10Mbps for 100Mhz =
clk
> >  	 * min and max baud should be calculated here based on port->uart=
clk.
> >  	 * this way we get a valid baud and can safely call set_baud()
> >  	 */
> > -	minbaud =3D port->uartclk / ((XUARTPS_BDIV_MAX + 1) * XUARTPS_CD_=
MAX * 8);
> > -	maxbaud =3D port->uartclk / (XUARTPS_BDIV_MIN + 1);
> > +	minbaud =3D port->uartclk /
> > +			((CDNS_UART_BDIV_MAX + 1) * CDNS_UART_CD_MAX * 8);
> > +	maxbaud =3D port->uartclk / (CDNS_UART_BDIV_MIN + 1);
> >  	baud =3D uart_get_baud_rate(port, termios, old, minbaud, maxbaud)=
;
> > -	baud =3D xuartps_set_baud_rate(port, baud);
> > +	baud =3D cdns_uart_set_baud_rate(port, baud);
> >  	if (tty_termios_baud_rate(termios))
> >  		tty_termios_encode_baud_rate(termios, baud, baud);
> > =20
> > @@ -650,52 +656,52 @@ static void xuartps_set_termios(struct uart_p=
ort *port,
> >  	uart_update_timeout(port, termios->c_cflag, baud);
> > =20
> >  	/* Set TX/RX Reset */
> > -	ctrl_reg =3D xuartps_readl(XUARTPS_CR_OFFSET);
> > -	ctrl_reg |=3D XUARTPS_CR_TXRST | XUARTPS_CR_RXRST;
> > -	xuartps_writel(ctrl_reg, XUARTPS_CR_OFFSET);
> > +	ctrl_reg =3D cdns_uart_readl(CDNS_UART_CR_OFFSET);
> > +	ctrl_reg |=3D CDNS_UART_CR_TXRST | CDNS_UART_CR_RXRST;
> > +	cdns_uart_writel(ctrl_reg, CDNS_UART_CR_OFFSET);
> > =20
> >  	/*
> >  	 * Clear the RX disable and TX disable bits and then set the TX e=
nable
> >  	 * bit and RX enable bit to enable the transmitter and receiver.
> >  	 */
> > -	ctrl_reg =3D xuartps_readl(XUARTPS_CR_OFFSET);
> > -	ctrl_reg &=3D ~(XUARTPS_CR_TX_DIS | XUARTPS_CR_RX_DIS);
> > -	ctrl_reg |=3D XUARTPS_CR_TX_EN | XUARTPS_CR_RX_EN;
> > -	xuartps_writel(ctrl_reg, XUARTPS_CR_OFFSET);
> > +	ctrl_reg =3D cdns_uart_readl(CDNS_UART_CR_OFFSET);
> > +	ctrl_reg &=3D ~(CDNS_UART_CR_TX_DIS | CDNS_UART_CR_RX_DIS);
> > +	ctrl_reg |=3D CDNS_UART_CR_TX_EN | CDNS_UART_CR_RX_EN;
> > +	cdns_uart_writel(ctrl_reg, CDNS_UART_CR_OFFSET);
> > =20
> > -	xuartps_writel(rx_timeout, XUARTPS_RXTOUT_OFFSET);
> > +	cdns_uart_writel(rx_timeout, CDNS_UART_RXTOUT_OFFSET);
> > =20
> > -	port->read_status_mask =3D XUARTPS_IXR_TXEMPTY | XUARTPS_IXR_RXTR=
IG |
> > -			XUARTPS_IXR_OVERRUN | XUARTPS_IXR_TOUT;
> > +	port->read_status_mask =3D CDNS_UART_IXR_TXEMPTY | CDNS_UART_IXR_=
RXTRIG |
> > +			CDNS_UART_IXR_OVERRUN | CDNS_UART_IXR_TOUT;
> >  	port->ignore_status_mask =3D 0;
> > =20
> >  	if (termios->c_iflag & INPCK)
> > -		port->read_status_mask |=3D XUARTPS_IXR_PARITY |
> > -		XUARTPS_IXR_FRAMING;
> > +		port->read_status_mask |=3D CDNS_UART_IXR_PARITY |
> > +		CDNS_UART_IXR_FRAMING;
> > =20
> >  	if (termios->c_iflag & IGNPAR)
> > -		port->ignore_status_mask |=3D XUARTPS_IXR_PARITY |
> > -			XUARTPS_IXR_FRAMING | XUARTPS_IXR_OVERRUN;
> > +		port->ignore_status_mask |=3D CDNS_UART_IXR_PARITY |
> > +			CDNS_UART_IXR_FRAMING | CDNS_UART_IXR_OVERRUN;
> > =20
> >  	/* ignore all characters if CREAD is not set */
> >  	if ((termios->c_cflag & CREAD) =3D=3D 0)
> > -		port->ignore_status_mask |=3D XUARTPS_IXR_RXTRIG |
> > -			XUARTPS_IXR_TOUT | XUARTPS_IXR_PARITY |
> > -			XUARTPS_IXR_FRAMING | XUARTPS_IXR_OVERRUN;
> > +		port->ignore_status_mask |=3D CDNS_UART_IXR_RXTRIG |
> > +			CDNS_UART_IXR_TOUT | CDNS_UART_IXR_PARITY |
> > +			CDNS_UART_IXR_FRAMING | CDNS_UART_IXR_OVERRUN;
> > =20
> > -	mode_reg =3D xuartps_readl(XUARTPS_MR_OFFSET);
> > +	mode_reg =3D cdns_uart_readl(CDNS_UART_MR_OFFSET);
> > =20
> >  	/* Handling Data Size */
> >  	switch (termios->c_cflag & CSIZE) {
> >  	case CS6:
> > -		cval |=3D XUARTPS_MR_CHARLEN_6_BIT;
> > +		cval |=3D CDNS_UART_MR_CHARLEN_6_BIT;
> >  		break;
> >  	case CS7:
> > -		cval |=3D XUARTPS_MR_CHARLEN_7_BIT;
> > +		cval |=3D CDNS_UART_MR_CHARLEN_7_BIT;
> >  		break;
> >  	default:
> >  	case CS8:
> > -		cval |=3D XUARTPS_MR_CHARLEN_8_BIT;
> > +		cval |=3D CDNS_UART_MR_CHARLEN_8_BIT;
> >  		termios->c_cflag &=3D ~CSIZE;
> >  		termios->c_cflag |=3D CS8;
> >  		break;
> > @@ -703,133 +709,135 @@ static void xuartps_set_termios(struct uart=
_port *port,
> > =20
> >  	/* Handling Parity and Stop Bits length */
> >  	if (termios->c_cflag & CSTOPB)
> > -		cval |=3D XUARTPS_MR_STOPMODE_2_BIT; /* 2 STOP bits */
> > +		cval |=3D CDNS_UART_MR_STOPMODE_2_BIT; /* 2 STOP bits */
> >  	else
> > -		cval |=3D XUARTPS_MR_STOPMODE_1_BIT; /* 1 STOP bit */
> > +		cval |=3D CDNS_UART_MR_STOPMODE_1_BIT; /* 1 STOP bit */
> > =20
> >  	if (termios->c_cflag & PARENB) {
> >  		/* Mark or Space parity */
> >  		if (termios->c_cflag & CMSPAR) {
> >  			if (termios->c_cflag & PARODD)
> > -				cval |=3D XUARTPS_MR_PARITY_MARK;
> > +				cval |=3D CDNS_UART_MR_PARITY_MARK;
> >  			else
> > -				cval |=3D XUARTPS_MR_PARITY_SPACE;
> > +				cval |=3D CDNS_UART_MR_PARITY_SPACE;
> >  		} else {
> >  			if (termios->c_cflag & PARODD)
> > -				cval |=3D XUARTPS_MR_PARITY_ODD;
> > +				cval |=3D CDNS_UART_MR_PARITY_ODD;
> >  			else
> > -				cval |=3D XUARTPS_MR_PARITY_EVEN;
> > +				cval |=3D CDNS_UART_MR_PARITY_EVEN;
> >  		}
> >  	} else {
> > -		cval |=3D XUARTPS_MR_PARITY_NONE;
> > +		cval |=3D CDNS_UART_MR_PARITY_NONE;
> >  	}
> >  	cval |=3D mode_reg & 1;
> > -	xuartps_writel(cval, XUARTPS_MR_OFFSET);
> > +	cdns_uart_writel(cval, CDNS_UART_MR_OFFSET);
> > =20
> >  	spin_unlock_irqrestore(&port->lock, flags);
> >  }
> > =20
> >  /**
> > - * xuartps_startup - Called when an application opens a xuartps po=
rt
> > + * cdns_uart_startup - Called when an application opens a cdns_uar=
t port
> >   * @port: Handle to the uart port structure
> >   *
> >   * Return: 0 on success, negative errno otherwise
> >   */
> > -static int xuartps_startup(struct uart_port *port)
> > +static int cdns_uart_startup(struct uart_port *port)
> >  {
> >  	unsigned int retval =3D 0, status =3D 0;
> > =20
> > -	retval =3D request_irq(port->irq, xuartps_isr, 0, XUARTPS_NAME,
> > +	retval =3D request_irq(port->irq, cdns_uart_isr, 0, CDNS_UART_NAM=
E,
> >  								(void *)port);
> >  	if (retval)
> >  		return retval;
> > =20
> >  	/* Disable the TX and RX */
> > -	xuartps_writel(XUARTPS_CR_TX_DIS | XUARTPS_CR_RX_DIS,
> > -						XUARTPS_CR_OFFSET);
> > +	cdns_uart_writel(CDNS_UART_CR_TX_DIS | CDNS_UART_CR_RX_DIS,
> > +						CDNS_UART_CR_OFFSET);
> > =20
> >  	/* Set the Control Register with TX/RX Enable, TX/RX Reset,
> >  	 * no break chars.
> >  	 */
> > -	xuartps_writel(XUARTPS_CR_TXRST | XUARTPS_CR_RXRST,
> > -				XUARTPS_CR_OFFSET);
> > +	cdns_uart_writel(CDNS_UART_CR_TXRST | CDNS_UART_CR_RXRST,
> > +				CDNS_UART_CR_OFFSET);
> > =20
> > -	status =3D xuartps_readl(XUARTPS_CR_OFFSET);
> > +	status =3D cdns_uart_readl(CDNS_UART_CR_OFFSET);
> > =20
> >  	/* Clear the RX disable and TX disable bits and then set the TX e=
nable
> >  	 * bit and RX enable bit to enable the transmitter and receiver.
> >  	 */
> > -	xuartps_writel((status & ~(XUARTPS_CR_TX_DIS | XUARTPS_CR_RX_DIS)=
)
> > -			| (XUARTPS_CR_TX_EN | XUARTPS_CR_RX_EN |
> > -			XUARTPS_CR_STOPBRK), XUARTPS_CR_OFFSET);
> > +	cdns_uart_writel((status & ~(CDNS_UART_CR_TX_DIS | CDNS_UART_CR_R=
X_DIS))
> > +			| (CDNS_UART_CR_TX_EN | CDNS_UART_CR_RX_EN |
> > +			CDNS_UART_CR_STOPBRK), CDNS_UART_CR_OFFSET);
> > =20
> >  	/* Set the Mode Register with normal mode,8 data bits,1 stop bit,
> >  	 * no parity.
> >  	 */
> > -	xuartps_writel(XUARTPS_MR_CHMODE_NORM | XUARTPS_MR_STOPMODE_1_BIT
> > -		| XUARTPS_MR_PARITY_NONE | XUARTPS_MR_CHARLEN_8_BIT,
> > -		 XUARTPS_MR_OFFSET);
> > +	cdns_uart_writel(CDNS_UART_MR_CHMODE_NORM | CDNS_UART_MR_STOPMODE=
_1_BIT
> > +		| CDNS_UART_MR_PARITY_NONE | CDNS_UART_MR_CHARLEN_8_BIT,
> > +		 CDNS_UART_MR_OFFSET);
> > =20
> >  	/*
> >  	 * Set the RX FIFO Trigger level to use most of the FIFO, but it
> >  	 * can be tuned with a module parameter
> >  	 */
> > -	xuartps_writel(rx_trigger_level, XUARTPS_RXWM_OFFSET);
> > +	cdns_uart_writel(rx_trigger_level, CDNS_UART_RXWM_OFFSET);
> > =20
> >  	/*
> >  	 * Receive Timeout register is enabled but it
> >  	 * can be tuned with a module parameter
> >  	 */
> > -	xuartps_writel(rx_timeout, XUARTPS_RXTOUT_OFFSET);
> > +	cdns_uart_writel(rx_timeout, CDNS_UART_RXTOUT_OFFSET);
> > =20
> >  	/* Clear out any pending interrupts before enabling them */
> > -	xuartps_writel(xuartps_readl(XUARTPS_ISR_OFFSET), XUARTPS_ISR_OFF=
SET);
> > +	cdns_uart_writel(cdns_uart_readl(CDNS_UART_ISR_OFFSET),
> > +			CDNS_UART_ISR_OFFSET);
> > =20
> >  	/* Set the Interrupt Registers with desired interrupts */
> > -	xuartps_writel(XUARTPS_IXR_TXEMPTY | XUARTPS_IXR_PARITY |
> > -		XUARTPS_IXR_FRAMING | XUARTPS_IXR_OVERRUN |
> > -		XUARTPS_IXR_RXTRIG | XUARTPS_IXR_TOUT, XUARTPS_IER_OFFSET);
> > +	cdns_uart_writel(CDNS_UART_IXR_TXEMPTY | CDNS_UART_IXR_PARITY |
> > +		CDNS_UART_IXR_FRAMING | CDNS_UART_IXR_OVERRUN |
> > +		CDNS_UART_IXR_RXTRIG | CDNS_UART_IXR_TOUT,
> > +		CDNS_UART_IER_OFFSET);
> > =20
> >  	return retval;
> >  }
> > =20
> >  /**
> > - * xuartps_shutdown - Called when an application closes a xuartps =
port
> > + * cdns_uart_shutdown - Called when an application closes a cdns_u=
art port
> >   * @port: Handle to the uart port structure
> >   */
> > -static void xuartps_shutdown(struct uart_port *port)
> > +static void cdns_uart_shutdown(struct uart_port *port)
> >  {
> >  	int status;
> > =20
> >  	/* Disable interrupts */
> > -	status =3D xuartps_readl(XUARTPS_IMR_OFFSET);
> > -	xuartps_writel(status, XUARTPS_IDR_OFFSET);
> > +	status =3D cdns_uart_readl(CDNS_UART_IMR_OFFSET);
> > +	cdns_uart_writel(status, CDNS_UART_IDR_OFFSET);
> > =20
> >  	/* Disable the TX and RX */
> > -	xuartps_writel(XUARTPS_CR_TX_DIS | XUARTPS_CR_RX_DIS,
> > -				 XUARTPS_CR_OFFSET);
> > +	cdns_uart_writel(CDNS_UART_CR_TX_DIS | CDNS_UART_CR_RX_DIS,
> > +				 CDNS_UART_CR_OFFSET);
> >  	free_irq(port->irq, port);
> >  }
> > =20
> >  /**
> > - * xuartps_type - Set UART type to xuartps port
> > + * cdns_uart_type - Set UART type to cdns_uart port
> >   * @port: Handle to the uart port structure
> >   *
> >   * Return: string on success, NULL otherwise
> >   */
> > -static const char *xuartps_type(struct uart_port *port)
> > +static const char *cdns_uart_type(struct uart_port *port)
> >  {
> > -	return port->type =3D=3D PORT_XUARTPS ? XUARTPS_NAME : NULL;
> > +	return port->type =3D=3D PORT_XUARTPS ? CDNS_UART_NAME : NULL;
> >  }
> > =20
> >  /**
> > - * xuartps_verify_port - Verify the port params
> > + * cdns_uart_verify_port - Verify the port params
> >   * @port: Handle to the uart port structure
> >   * @ser: Handle to the structure whose members are compared
> >   *
> >   * Return: 0 on success, negative errno otherwise.
> >   */
> > -static int xuartps_verify_port(struct uart_port *port,
> > +static int cdns_uart_verify_port(struct uart_port *port,
> >  					struct serial_struct *ser)
> >  {
> >  	if (ser->type !=3D PORT_UNKNOWN && ser->type !=3D PORT_XUARTPS)
> > @@ -846,167 +854,167 @@ static int xuartps_verify_port(struct uart_=
port *port,
> >  }
> > =20
> >  /**
> > - * xuartps_request_port - Claim the memory region attached to xuar=
tps port,
> > - *				called when the driver adds a xuartps port via
> > + * cdns_uart_request_port - Claim the memory region attached to cd=
ns_uart port,
> > + *				called when the driver adds a cdns_uart port via
> >   *				uart_add_one_port()
> >   * @port: Handle to the uart port structure
> >   *
> >   * Return: 0 on success, negative errno otherwise.
> >   */
> > -static int xuartps_request_port(struct uart_port *port)
> > +static int cdns_uart_request_port(struct uart_port *port)
> >  {
> > -	if (!request_mem_region(port->mapbase, XUARTPS_REGISTER_SPACE,
> > -					 XUARTPS_NAME)) {
> > +	if (!request_mem_region(port->mapbase, CDNS_UART_REGISTER_SPACE,
> > +					 CDNS_UART_NAME)) {
> >  		return -ENOMEM;
> >  	}
> > =20
> > -	port->membase =3D ioremap(port->mapbase, XUARTPS_REGISTER_SPACE);
> > +	port->membase =3D ioremap(port->mapbase, CDNS_UART_REGISTER_SPACE=
);
> >  	if (!port->membase) {
> >  		dev_err(port->dev, "Unable to map registers\n");
> > -		release_mem_region(port->mapbase, XUARTPS_REGISTER_SPACE);
> > +		release_mem_region(port->mapbase, CDNS_UART_REGISTER_SPACE);
> >  		return -ENOMEM;
> >  	}
> >  	return 0;
> >  }
> > =20
> >  /**
> > - * xuartps_release_port - Release UART port
> > + * cdns_uart_release_port - Release UART port
> >   * @port: Handle to the uart port structure
> >   *
> > - * Release the memory region attached to a xuartps port. Called wh=
en the
> > - * driver removes a xuartps port via uart_remove_one_port().
> > + * Release the memory region attached to a cdns_uart port. Called =
when the
> > + * driver removes a cdns_uart port via uart_remove_one_port().
> >   */
> > -static void xuartps_release_port(struct uart_port *port)
> > +static void cdns_uart_release_port(struct uart_port *port)
> >  {
> > -	release_mem_region(port->mapbase, XUARTPS_REGISTER_SPACE);
> > +	release_mem_region(port->mapbase, CDNS_UART_REGISTER_SPACE);
> >  	iounmap(port->membase);
> >  	port->membase =3D NULL;
> >  }
> > =20
> >  /**
> > - * xuartps_config_port - Configure UART port
> > + * cdns_uart_config_port - Configure UART port
> >   * @port: Handle to the uart port structure
> >   * @flags: If any
> >   */
> > -static void xuartps_config_port(struct uart_port *port, int flags)
> > +static void cdns_uart_config_port(struct uart_port *port, int flag=
s)
> >  {
> > -	if (flags & UART_CONFIG_TYPE && xuartps_request_port(port) =3D=3D=
 0)
> > +	if (flags & UART_CONFIG_TYPE && cdns_uart_request_port(port) =3D=3D=
 0)
> >  		port->type =3D PORT_XUARTPS;
> >  }
> > =20
> >  /**
> > - * xuartps_get_mctrl - Get the modem control state
> > + * cdns_uart_get_mctrl - Get the modem control state
> >   * @port: Handle to the uart port structure
> >   *
> >   * Return: The modem control state
> >   */
> > -static unsigned int xuartps_get_mctrl(struct uart_port *port)
> > +static unsigned int cdns_uart_get_mctrl(struct uart_port *port)
> >  {
> >  	return TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;
> >  }
> > =20
> > -static void xuartps_set_mctrl(struct uart_port *port, unsigned int=
 mctrl)
> > +static void cdns_uart_set_mctrl(struct uart_port *port, unsigned i=
nt mctrl)
> >  {
> >  	/* N/A */
> >  }
> > =20
> > -static void xuartps_enable_ms(struct uart_port *port)
> > +static void cdns_uart_enable_ms(struct uart_port *port)
> >  {
> >  	/* N/A */
> >  }
> > =20
> >  #ifdef CONFIG_CONSOLE_POLL
> > -static int xuartps_poll_get_char(struct uart_port *port)
> > +static int cdns_uart_poll_get_char(struct uart_port *port)
> >  {
> >  	u32 imr;
> >  	int c;
> > =20
> >  	/* Disable all interrupts */
> > -	imr =3D xuartps_readl(XUARTPS_IMR_OFFSET);
> > -	xuartps_writel(imr, XUARTPS_IDR_OFFSET);
> > +	imr =3D cdns_uart_readl(CDNS_UART_IMR_OFFSET);
> > +	cdns_uart_writel(imr, CDNS_UART_IDR_OFFSET);
> > =20
> >  	/* Check if FIFO is empty */
> > -	if (xuartps_readl(XUARTPS_SR_OFFSET) & XUARTPS_SR_RXEMPTY)
> > +	if (cdns_uart_readl(CDNS_UART_SR_OFFSET) & CDNS_UART_SR_RXEMPTY)
> >  		c =3D NO_POLL_CHAR;
> >  	else /* Read a character */
> > -		c =3D (unsigned char) xuartps_readl(XUARTPS_FIFO_OFFSET);
> > +		c =3D (unsigned char) cdns_uart_readl(CDNS_UART_FIFO_OFFSET);
> > =20
> >  	/* Enable interrupts */
> > -	xuartps_writel(imr, XUARTPS_IER_OFFSET);
> > +	cdns_uart_writel(imr, CDNS_UART_IER_OFFSET);
> > =20
> >  	return c;
> >  }
> > =20
> > -static void xuartps_poll_put_char(struct uart_port *port, unsigned=
 char c)
> > +static void cdns_uart_poll_put_char(struct uart_port *port, unsign=
ed char c)
> >  {
> >  	u32 imr;
> > =20
> >  	/* Disable all interrupts */
> > -	imr =3D xuartps_readl(XUARTPS_IMR_OFFSET);
> > -	xuartps_writel(imr, XUARTPS_IDR_OFFSET);
> > +	imr =3D cdns_uart_readl(CDNS_UART_IMR_OFFSET);
> > +	cdns_uart_writel(imr, CDNS_UART_IDR_OFFSET);
> > =20
> >  	/* Wait until FIFO is empty */
> > -	while (!(xuartps_readl(XUARTPS_SR_OFFSET) & XUARTPS_SR_TXEMPTY))
> > +	while (!(cdns_uart_readl(CDNS_UART_SR_OFFSET) & CDNS_UART_SR_TXEM=
PTY))
> >  		cpu_relax();
> > =20
> >  	/* Write a character */
> > -	xuartps_writel(c, XUARTPS_FIFO_OFFSET);
> > +	cdns_uart_writel(c, CDNS_UART_FIFO_OFFSET);
> > =20
> >  	/* Wait until FIFO is empty */
> > -	while (!(xuartps_readl(XUARTPS_SR_OFFSET) & XUARTPS_SR_TXEMPTY))
> > +	while (!(cdns_uart_readl(CDNS_UART_SR_OFFSET) & CDNS_UART_SR_TXEM=
PTY))
> >  		cpu_relax();
> > =20
> >  	/* Enable interrupts */
> > -	xuartps_writel(imr, XUARTPS_IER_OFFSET);
> > +	cdns_uart_writel(imr, CDNS_UART_IER_OFFSET);
> > =20
> >  	return;
> >  }
> >  #endif
> > =20
> > -static struct uart_ops xuartps_ops =3D {
> > -	.set_mctrl	=3D xuartps_set_mctrl,
> > -	.get_mctrl	=3D xuartps_get_mctrl,
> > -	.enable_ms	=3D xuartps_enable_ms,
> > -	.start_tx	=3D xuartps_start_tx,
> > -	.stop_tx	=3D xuartps_stop_tx,
> > -	.stop_rx	=3D xuartps_stop_rx,
> > -	.tx_empty	=3D xuartps_tx_empty,
> > -	.break_ctl	=3D xuartps_break_ctl,
> > -	.set_termios	=3D xuartps_set_termios,
> > -	.startup	=3D xuartps_startup,
> > -	.shutdown	=3D xuartps_shutdown,
> > -	.type		=3D xuartps_type,
> > -	.verify_port	=3D xuartps_verify_port,
> > -	.request_port	=3D xuartps_request_port,
> > -	.release_port	=3D xuartps_release_port,
> > -	.config_port	=3D xuartps_config_port,
> > +static struct uart_ops cdns_uart_ops =3D {
> > +	.set_mctrl	=3D cdns_uart_set_mctrl,
> > +	.get_mctrl	=3D cdns_uart_get_mctrl,
> > +	.enable_ms	=3D cdns_uart_enable_ms,
> > +	.start_tx	=3D cdns_uart_start_tx,
> > +	.stop_tx	=3D cdns_uart_stop_tx,
> > +	.stop_rx	=3D cdns_uart_stop_rx,
> > +	.tx_empty	=3D cdns_uart_tx_empty,
> > +	.break_ctl	=3D cdns_uart_break_ctl,
> > +	.set_termios	=3D cdns_uart_set_termios,
> > +	.startup	=3D cdns_uart_startup,
> > +	.shutdown	=3D cdns_uart_shutdown,
> > +	.type		=3D cdns_uart_type,
> > +	.verify_port	=3D cdns_uart_verify_port,
> > +	.request_port	=3D cdns_uart_request_port,
> > +	.release_port	=3D cdns_uart_release_port,
> > +	.config_port	=3D cdns_uart_config_port,
> >  #ifdef CONFIG_CONSOLE_POLL
> > -	.poll_get_char	=3D xuartps_poll_get_char,
> > -	.poll_put_char	=3D xuartps_poll_put_char,
> > +	.poll_get_char	=3D cdns_uart_poll_get_char,
> > +	.poll_put_char	=3D cdns_uart_poll_put_char,
> >  #endif
> >  };
> > =20
> > -static struct uart_port xuartps_port[2];
> > +static struct uart_port cdns_uart_port[2];
> > =20
> >  /**
> > - * xuartps_get_port - Configure the port from the platform device =
resource info
> > + * cdns_uart_get_port - Configure the port from platform device re=
source info
> >   *
> >   * Return: Pointer to a uart_port or NULL for failure
> >   */
> > -static struct uart_port *xuartps_get_port(void)
> > +static struct uart_port *cdns_uart_get_port(void)
> >  {
> >  	struct uart_port *port;
> >  	int id;
> > =20
> >  	/* Find the next unused port */
> > -	for (id =3D 0; id < XUARTPS_NR_PORTS; id++)
> > -		if (xuartps_port[id].mapbase =3D=3D 0)
> > +	for (id =3D 0; id < CDNS_UART_NR_PORTS; id++)
> > +		if (cdns_uart_port[id].mapbase =3D=3D 0)
> >  			break;
> > =20
> > -	if (id >=3D XUARTPS_NR_PORTS)
> > +	if (id >=3D CDNS_UART_NR_PORTS)
> >  		return NULL;
> > =20
> > -	port =3D &xuartps_port[id];
> > +	port =3D &cdns_uart_port[id];
> > =20
> >  	/* At this point, we've got an empty uart_port struct, initialize=
 it */
> >  	spin_lock_init(&port->lock);
> > @@ -1016,8 +1024,8 @@ static struct uart_port *xuartps_get_port(voi=
d)
> >  	port->type	=3D PORT_UNKNOWN;
> >  	port->iotype	=3D UPIO_MEM32;
> >  	port->flags	=3D UPF_BOOT_AUTOCONF;
> > -	port->ops	=3D &xuartps_ops;
> > -	port->fifosize	=3D XUARTPS_FIFO_SIZE;
> > +	port->ops	=3D &cdns_uart_ops;
> > +	port->fifosize	=3D CDNS_UART_FIFO_SIZE;
> >  	port->line	=3D id;
> >  	port->dev	=3D NULL;
> >  	return port;
> > @@ -1025,37 +1033,37 @@ static struct uart_port *xuartps_get_port(v=
oid)
> > =20
> >  #ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
> >  /**
> > - * xuartps_console_wait_tx - Wait for the TX to be full
> > + * cdns_uart_console_wait_tx - Wait for the TX to be full
> >   * @port: Handle to the uart port structure
> >   */
> > -static void xuartps_console_wait_tx(struct uart_port *port)
> > +static void cdns_uart_console_wait_tx(struct uart_port *port)
> >  {
> > -	while ((xuartps_readl(XUARTPS_SR_OFFSET) & XUARTPS_SR_TXEMPTY)
> > -				!=3D XUARTPS_SR_TXEMPTY)
> > +	while ((cdns_uart_readl(CDNS_UART_SR_OFFSET) & CDNS_UART_SR_TXEMP=
TY)
> > +				!=3D CDNS_UART_SR_TXEMPTY)
> >  		barrier();
> >  }
> > =20
> >  /**
> > - * xuartps_console_putchar - write the character to the FIFO buffe=
r
> > + * cdns_uart_console_putchar - write the character to the FIFO buf=
fer
> >   * @port: Handle to the uart port structure
> >   * @ch: Character to be written
> >   */
> > -static void xuartps_console_putchar(struct uart_port *port, int ch=
)
> > +static void cdns_uart_console_putchar(struct uart_port *port, int =
ch)
> >  {
> > -	xuartps_console_wait_tx(port);
> > -	xuartps_writel(ch, XUARTPS_FIFO_OFFSET);
> > +	cdns_uart_console_wait_tx(port);
> > +	cdns_uart_writel(ch, CDNS_UART_FIFO_OFFSET);
> >  }
> > =20
> >  /**
> > - * xuartps_console_write - perform write operation
> > + * cdns_uart_console_write - perform write operation
> >   * @co: Handle to the console
> >   * @s: Pointer to character array
> >   * @count: No of characters
> >   */
> > -static void xuartps_console_write(struct console *co, const char *=
s,
> > +static void cdns_uart_console_write(struct console *co, const char=
 *s,
> >  				unsigned int count)
> >  {
> > -	struct uart_port *port =3D &xuartps_port[co->index];
> > +	struct uart_port *port =3D &cdns_uart_port[co->index];
> >  	unsigned long flags;
> >  	unsigned int imr, ctrl;
> >  	int locked =3D 1;
> > @@ -1066,45 +1074,45 @@ static void xuartps_console_write(struct co=
nsole *co, const char *s,
> >  		spin_lock_irqsave(&port->lock, flags);
> > =20
> >  	/* save and disable interrupt */
> > -	imr =3D xuartps_readl(XUARTPS_IMR_OFFSET);
> > -	xuartps_writel(imr, XUARTPS_IDR_OFFSET);
> > +	imr =3D cdns_uart_readl(CDNS_UART_IMR_OFFSET);
> > +	cdns_uart_writel(imr, CDNS_UART_IDR_OFFSET);
> > =20
> >  	/*
> >  	 * Make sure that the tx part is enabled. Set the TX enable bit a=
nd
> >  	 * clear the TX disable bit to enable the transmitter.
> >  	 */
> > -	ctrl =3D xuartps_readl(XUARTPS_CR_OFFSET);
> > -	xuartps_writel((ctrl & ~XUARTPS_CR_TX_DIS) | XUARTPS_CR_TX_EN,
> > -		XUARTPS_CR_OFFSET);
> > +	ctrl =3D cdns_uart_readl(CDNS_UART_CR_OFFSET);
> > +	cdns_uart_writel((ctrl & ~CDNS_UART_CR_TX_DIS) | CDNS_UART_CR_TX_=
EN,
> > +		CDNS_UART_CR_OFFSET);
> > =20
> > -	uart_console_write(port, s, count, xuartps_console_putchar);
> > -	xuartps_console_wait_tx(port);
> > +	uart_console_write(port, s, count, cdns_uart_console_putchar);
> > +	cdns_uart_console_wait_tx(port);
> > =20
> > -	xuartps_writel(ctrl, XUARTPS_CR_OFFSET);
> > +	cdns_uart_writel(ctrl, CDNS_UART_CR_OFFSET);
> > =20
> >  	/* restore interrupt state */
> > -	xuartps_writel(imr, XUARTPS_IER_OFFSET);
> > +	cdns_uart_writel(imr, CDNS_UART_IER_OFFSET);
> > =20
> >  	if (locked)
> >  		spin_unlock_irqrestore(&port->lock, flags);
> >  }
> > =20
> >  /**
> > - * xuartps_console_setup - Initialize the uart to default config
> > + * cdns_uart_console_setup - Initialize the uart to default config
> >   * @co: Console handle
> >   * @options: Initial settings of uart
> >   *
> >   * Return: 0 on success, negative errno otherwise.
> >   */
> > -static int __init xuartps_console_setup(struct console *co, char *=
options)
> > +static int __init cdns_uart_console_setup(struct console *co, char=
 *options)
> >  {
> > -	struct uart_port *port =3D &xuartps_port[co->index];
> > +	struct uart_port *port =3D &cdns_uart_port[co->index];
> >  	int baud =3D 9600;
> >  	int bits =3D 8;
> >  	int parity =3D 'n';
> >  	int flow =3D 'n';
> > =20
> > -	if (co->index < 0 || co->index >=3D XUARTPS_NR_PORTS)
> > +	if (co->index < 0 || co->index >=3D CDNS_UART_NR_PORTS)
> >  		return -EINVAL;
> > =20
> >  	if (!port->mapbase) {
> > @@ -1118,53 +1126,53 @@ static int __init xuartps_console_setup(str=
uct console *co, char *options)
> >  	return uart_set_options(port, co, baud, parity, bits, flow);
> >  }
> > =20
> > -static struct uart_driver xuartps_uart_driver;
> > +static struct uart_driver cdns_uart_uart_driver;
> > =20
> > -static struct console xuartps_console =3D {
> > -	.name	=3D XUARTPS_TTY_NAME,
> > -	.write	=3D xuartps_console_write,
> > +static struct console cdns_uart_console =3D {
> > +	.name	=3D CDNS_UART_TTY_NAME,
> > +	.write	=3D cdns_uart_console_write,
> >  	.device	=3D uart_console_device,
> > -	.setup	=3D xuartps_console_setup,
> > +	.setup	=3D cdns_uart_console_setup,
> >  	.flags	=3D CON_PRINTBUFFER,
> >  	.index	=3D -1, /* Specified on the cmdline (e.g. console=3DttyPS =
) */
> > -	.data	=3D &xuartps_uart_driver,
> > +	.data	=3D &cdns_uart_uart_driver,
> >  };
> > =20
> >  /**
> > - * xuartps_console_init - Initialization call
> > + * cdns_uart_console_init - Initialization call
> >   *
> >   * Return: 0 on success, negative error otherwise.
> >   */
> > -static int __init xuartps_console_init(void)
> > +static int __init cdns_uart_console_init(void)
> >  {
> > -	register_console(&xuartps_console);
> > +	register_console(&cdns_uart_console);
> >  	return 0;
> >  }
> > =20
> > -console_initcall(xuartps_console_init);
> > +console_initcall(cdns_uart_console_init);
> > =20
> >  #endif /* CONFIG_SERIAL_XILINX_PS_UART_CONSOLE */
> > =20
> > -static struct uart_driver xuartps_uart_driver =3D {
> > +static struct uart_driver cdns_uart_uart_driver =3D {
> >  	.owner		=3D THIS_MODULE,
> > -	.driver_name	=3D XUARTPS_NAME,
> > -	.dev_name	=3D XUARTPS_TTY_NAME,
> > -	.major		=3D XUARTPS_MAJOR,
> > -	.minor		=3D XUARTPS_MINOR,
> > -	.nr		=3D XUARTPS_NR_PORTS,
> > +	.driver_name	=3D CDNS_UART_NAME,
> > +	.dev_name	=3D CDNS_UART_TTY_NAME,
> > +	.major		=3D CDNS_UART_MAJOR,
> > +	.minor		=3D CDNS_UART_MINOR,
> > +	.nr		=3D CDNS_UART_NR_PORTS,
> >  #ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
> > -	.cons		=3D &xuartps_console,
> > +	.cons		=3D &cdns_uart_console,
> >  #endif
> >  };
> > =20
> >  #ifdef CONFIG_PM_SLEEP
> >  /**
> > - * xuartps_suspend - suspend event
> > + * cdns_uart_suspend - suspend event
> >   * @device: Pointer to the device structure
> >   *
> >   * Return: 0
> >   */
> > -static int xuartps_suspend(struct device *device)
> > +static int cdns_uart_suspend(struct device *device)
> >  {
> >  	struct uart_port *port =3D dev_get_drvdata(device);
> >  	struct tty_struct *tty;
> > @@ -1183,23 +1191,24 @@ static int xuartps_suspend(struct device *d=
evice)
> >  	 * Call the API provided in serial_core.c file which handles
> >  	 * the suspend.
> >  	 */
> > -	uart_suspend_port(&xuartps_uart_driver, port);
> > +	uart_suspend_port(&cdns_uart_uart_driver, port);
> >  	if (console_suspend_enabled && !may_wake) {
> > -		struct xuartps *xuartps =3D port->private_data;
> > +		struct cdns_uart *cdns_uart =3D port->private_data;
> > =20
> > -		clk_disable(xuartps->refclk);
> > -		clk_disable(xuartps->aperclk);
> > +		clk_disable(cdns_uart->uartclk);
> > +		clk_disable(cdns_uart->pclk);
> >  	} else {
> >  		unsigned long flags =3D 0;
> > =20
> >  		spin_lock_irqsave(&port->lock, flags);
> >  		/* Empty the receive FIFO 1st before making changes */
> > -		while (!(xuartps_readl(XUARTPS_SR_OFFSET) & XUARTPS_SR_RXEMPTY))
> > -			xuartps_readl(XUARTPS_FIFO_OFFSET);
> > +		while (!(cdns_uart_readl(CDNS_UART_SR_OFFSET) &
> > +					CDNS_UART_SR_RXEMPTY))
> > +			cdns_uart_readl(CDNS_UART_FIFO_OFFSET);
> >  		/* set RX trigger level to 1 */
> > -		xuartps_writel(1, XUARTPS_RXWM_OFFSET);
> > +		cdns_uart_writel(1, CDNS_UART_RXWM_OFFSET);
> >  		/* disable RX timeout interrups */
> > -		xuartps_writel(XUARTPS_IXR_TOUT, XUARTPS_IDR_OFFSET);
> > +		cdns_uart_writel(CDNS_UART_IXR_TOUT, CDNS_UART_IDR_OFFSET);
> >  		spin_unlock_irqrestore(&port->lock, flags);
> >  	}
> > =20
> > @@ -1207,12 +1216,12 @@ static int xuartps_suspend(struct device *d=
evice)
> >  }
> > =20
> >  /**
> > - * xuartps_resume - Resume after a previous suspend
> > + * cdns_uart_resume - Resume after a previous suspend
> >   * @device: Pointer to the device structure
> >   *
> >   * Return: 0
> >   */
> > -static int xuartps_resume(struct device *device)
> > +static int cdns_uart_resume(struct device *device)
> >  {
> >  	struct uart_port *port =3D dev_get_drvdata(device);
> >  	unsigned long flags =3D 0;
> > @@ -1230,83 +1239,95 @@ static int xuartps_resume(struct device *de=
vice)
> >  	}
> > =20
> >  	if (console_suspend_enabled && !may_wake) {
> > -		struct xuartps *xuartps =3D port->private_data;
> > +		struct cdns_uart *cdns_uart =3D port->private_data;
> > =20
> > -		clk_enable(xuartps->aperclk);
> > -		clk_enable(xuartps->refclk);
> > +		clk_enable(cdns_uart->pclk);
> > +		clk_enable(cdns_uart->uartclk);
> > =20
> >  		spin_lock_irqsave(&port->lock, flags);
> > =20
> >  		/* Set TX/RX Reset */
> > -		ctrl_reg =3D xuartps_readl(XUARTPS_CR_OFFSET);
> > -		ctrl_reg |=3D XUARTPS_CR_TXRST | XUARTPS_CR_RXRST;
> > -		xuartps_writel(ctrl_reg, XUARTPS_CR_OFFSET);
> > -		while (xuartps_readl(XUARTPS_CR_OFFSET) &
> > -				(XUARTPS_CR_TXRST | XUARTPS_CR_RXRST))
> > +		ctrl_reg =3D cdns_uart_readl(CDNS_UART_CR_OFFSET);
> > +		ctrl_reg |=3D CDNS_UART_CR_TXRST | CDNS_UART_CR_RXRST;
> > +		cdns_uart_writel(ctrl_reg, CDNS_UART_CR_OFFSET);
> > +		while (cdns_uart_readl(CDNS_UART_CR_OFFSET) &
> > +				(CDNS_UART_CR_TXRST | CDNS_UART_CR_RXRST))
> >  			cpu_relax();
> > =20
> >  		/* restore rx timeout value */
> > -		xuartps_writel(rx_timeout, XUARTPS_RXTOUT_OFFSET);
> > +		cdns_uart_writel(rx_timeout, CDNS_UART_RXTOUT_OFFSET);
> >  		/* Enable Tx/Rx */
> > -		ctrl_reg =3D xuartps_readl(XUARTPS_CR_OFFSET);
> > -		ctrl_reg &=3D ~(XUARTPS_CR_TX_DIS | XUARTPS_CR_RX_DIS);
> > -		ctrl_reg |=3D XUARTPS_CR_TX_EN | XUARTPS_CR_RX_EN;
> > -		xuartps_writel(ctrl_reg, XUARTPS_CR_OFFSET);
> > +		ctrl_reg =3D cdns_uart_readl(CDNS_UART_CR_OFFSET);
> > +		ctrl_reg &=3D ~(CDNS_UART_CR_TX_DIS | CDNS_UART_CR_RX_DIS);
> > +		ctrl_reg |=3D CDNS_UART_CR_TX_EN | CDNS_UART_CR_RX_EN;
> > +		cdns_uart_writel(ctrl_reg, CDNS_UART_CR_OFFSET);
> > =20
> >  		spin_unlock_irqrestore(&port->lock, flags);
> >  	} else {
> >  		spin_lock_irqsave(&port->lock, flags);
> >  		/* restore original rx trigger level */
> > -		xuartps_writel(rx_trigger_level, XUARTPS_RXWM_OFFSET);
> > +		cdns_uart_writel(rx_trigger_level, CDNS_UART_RXWM_OFFSET);
> >  		/* enable RX timeout interrupt */
> > -		xuartps_writel(XUARTPS_IXR_TOUT, XUARTPS_IER_OFFSET);
> > +		cdns_uart_writel(CDNS_UART_IXR_TOUT, CDNS_UART_IER_OFFSET);
> >  		spin_unlock_irqrestore(&port->lock, flags);
> >  	}
> > =20
> > -	return uart_resume_port(&xuartps_uart_driver, port);
> > +	return uart_resume_port(&cdns_uart_uart_driver, port);
> >  }
> >  #endif /* ! CONFIG_PM_SLEEP */
> > =20
> > -static SIMPLE_DEV_PM_OPS(xuartps_dev_pm_ops, xuartps_suspend, xuar=
tps_resume);
> > +static SIMPLE_DEV_PM_OPS(cdns_uart_dev_pm_ops, cdns_uart_suspend,
> > +		cdns_uart_resume);
> > =20
> >  /**
> > - * xuartps_probe - Platform driver probe
> > + * cdns_uart_probe - Platform driver probe
> >   * @pdev: Pointer to the platform device structure
> >   *
> >   * Return: 0 on success, negative error otherwise.
> >   */
> > -static int xuartps_probe(struct platform_device *pdev)
> > +static int cdns_uart_probe(struct platform_device *pdev)
> >  {
> >  	int rc;
> >  	struct uart_port *port;
> >  	struct resource *res, *res2;
> > -	struct xuartps *xuartps_data;
> > +	struct cdns_uart *cdns_uart_data;
> > =20
> > -	xuartps_data =3D devm_kzalloc(&pdev->dev, sizeof(*xuartps_data),
> > +	cdns_uart_data =3D devm_kzalloc(&pdev->dev, sizeof(*cdns_uart_dat=
a),
> >  			GFP_KERNEL);
> > -	if (!xuartps_data)
> > +	if (!cdns_uart_data)
> >  		return -ENOMEM;
> > =20
> > -	xuartps_data->aperclk =3D devm_clk_get(&pdev->dev, "aper_clk");
> > -	if (IS_ERR(xuartps_data->aperclk)) {
> > -		dev_err(&pdev->dev, "aper_clk clock not found.\n");
> > -		return PTR_ERR(xuartps_data->aperclk);
> > +	cdns_uart_data->pclk =3D devm_clk_get(&pdev->dev, "pclk");
> > +	if (IS_ERR(cdns_uart_data->pclk)) {
> > +		cdns_uart_data->pclk =3D devm_clk_get(&pdev->dev, "aper_clk");
> > +		if (!IS_ERR(cdns_uart_data->pclk))
> > +			dev_err(&pdev->dev, "clock name 'aper_clk' is deprecated.\n");
> > +	}
> > +	if (IS_ERR(cdns_uart_data->pclk)) {
> > +		dev_err(&pdev->dev, "pclk clock not found.\n");
> > +		return PTR_ERR(cdns_uart_data->pclk);
> > +	}
> > +
> > +	cdns_uart_data->uartclk =3D devm_clk_get(&pdev->dev, "uart_clk");
> > +	if (IS_ERR(cdns_uart_data->uartclk)) {
> > +		cdns_uart_data->uartclk =3D devm_clk_get(&pdev->dev, "ref_clk");
> > +		if (!IS_ERR(cdns_uart_data->uartclk))
> > +			dev_err(&pdev->dev, "clock name 'ref_clk' is deprecated.\n");
> >  	}
> > -	xuartps_data->refclk =3D devm_clk_get(&pdev->dev, "ref_clk");
> > -	if (IS_ERR(xuartps_data->refclk)) {
> > -		dev_err(&pdev->dev, "ref_clk clock not found.\n");
> > -		return PTR_ERR(xuartps_data->refclk);
> > +	if (IS_ERR(cdns_uart_data->uartclk)) {
> > +		dev_err(&pdev->dev, "uart_clk clock not found.\n");
> > +		return PTR_ERR(cdns_uart_data->uartclk);
> >  	}
> > =20
> > -	rc =3D clk_prepare_enable(xuartps_data->aperclk);
> > +	rc =3D clk_prepare_enable(cdns_uart_data->pclk);
> >  	if (rc) {
> > -		dev_err(&pdev->dev, "Unable to enable APER clock.\n");
> > +		dev_err(&pdev->dev, "Unable to enable pclk clock.\n");
> >  		return rc;
> >  	}
> > -	rc =3D clk_prepare_enable(xuartps_data->refclk);
> > +	rc =3D clk_prepare_enable(cdns_uart_data->uartclk);
> >  	if (rc) {
> >  		dev_err(&pdev->dev, "Unable to enable device clock.\n");
> > -		goto err_out_clk_dis_aper;
> > +		goto err_out_clk_dis_pclk;
> >  	}
> > =20
> >  	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > @@ -1322,15 +1343,15 @@ static int xuartps_probe(struct platform_de=
vice *pdev)
> >  	}
> > =20
> >  #ifdef CONFIG_COMMON_CLK
> > -	xuartps_data->clk_rate_change_nb.notifier_call =3D
> > -			xuartps_clk_notifier_cb;
> > -	if (clk_notifier_register(xuartps_data->refclk,
> > -				&xuartps_data->clk_rate_change_nb))
> > +	cdns_uart_data->clk_rate_change_nb.notifier_call =3D
> > +			cdns_uart_clk_notifier_cb;
> > +	if (clk_notifier_register(cdns_uart_data->uartclk,
> > +				&cdns_uart_data->clk_rate_change_nb))
> >  		dev_warn(&pdev->dev, "Unable to register clock notifier.\n");
> >  #endif
> > =20
> >  	/* Initialize the port structure */
> > -	port =3D xuartps_get_port();
> > +	port =3D cdns_uart_get_port();
> > =20
> >  	if (!port) {
> >  		dev_err(&pdev->dev, "Cannot get uart_port structure\n");
> > @@ -1344,11 +1365,11 @@ static int xuartps_probe(struct platform_de=
vice *pdev)
> >  		port->mapbase =3D res->start;
> >  		port->irq =3D res2->start;
> >  		port->dev =3D &pdev->dev;
> > -		port->uartclk =3D clk_get_rate(xuartps_data->refclk);
> > -		port->private_data =3D xuartps_data;
> > -		xuartps_data->port =3D port;
> > +		port->uartclk =3D clk_get_rate(cdns_uart_data->uartclk);
> > +		port->private_data =3D cdns_uart_data;
> > +		cdns_uart_data->port =3D port;
> >  		platform_set_drvdata(pdev, port);
> > -		rc =3D uart_add_one_port(&xuartps_uart_driver, port);
> > +		rc =3D uart_add_one_port(&cdns_uart_uart_driver, port);
> >  		if (rc) {
> >  			dev_err(&pdev->dev,
> >  				"uart_add_one_port() failed; err=3D%i\n", rc);
> > @@ -1359,88 +1380,89 @@ static int xuartps_probe(struct platform_de=
vice *pdev)
> > =20
> >  err_out_notif_unreg:
> >  #ifdef CONFIG_COMMON_CLK
> > -	clk_notifier_unregister(xuartps_data->refclk,
> > -			&xuartps_data->clk_rate_change_nb);
> > +	clk_notifier_unregister(cdns_uart_data->uartclk,
> > +			&cdns_uart_data->clk_rate_change_nb);
> >  #endif
> >  err_out_clk_disable:
> > -	clk_disable_unprepare(xuartps_data->refclk);
> > -err_out_clk_dis_aper:
> > -	clk_disable_unprepare(xuartps_data->aperclk);
> > +	clk_disable_unprepare(cdns_uart_data->uartclk);
> > +err_out_clk_dis_pclk:
> > +	clk_disable_unprepare(cdns_uart_data->pclk);
> > =20
> >  	return rc;
> >  }
> > =20
> >  /**
> > - * xuartps_remove - called when the platform driver is unregistere=
d
> > + * cdns_uart_remove - called when the platform driver is unregiste=
red
> >   * @pdev: Pointer to the platform device structure
> >   *
> >   * Return: 0 on success, negative error otherwise.
> >   */
> > -static int xuartps_remove(struct platform_device *pdev)
> > +static int cdns_uart_remove(struct platform_device *pdev)
> >  {
> >  	struct uart_port *port =3D platform_get_drvdata(pdev);
> > -	struct xuartps *xuartps_data =3D port->private_data;
> > +	struct cdns_uart *cdns_uart_data =3D port->private_data;
> >  	int rc;
> > =20
> > -	/* Remove the xuartps port from the serial core */
> > +	/* Remove the cdns_uart port from the serial core */
> >  #ifdef CONFIG_COMMON_CLK
> > -	clk_notifier_unregister(xuartps_data->refclk,
> > -			&xuartps_data->clk_rate_change_nb);
> > +	clk_notifier_unregister(cdns_uart_data->uartclk,
> > +			&cdns_uart_data->clk_rate_change_nb);
> >  #endif
> > -	rc =3D uart_remove_one_port(&xuartps_uart_driver, port);
> > +	rc =3D uart_remove_one_port(&cdns_uart_uart_driver, port);
> >  	port->mapbase =3D 0;
> > -	clk_disable_unprepare(xuartps_data->refclk);
> > -	clk_disable_unprepare(xuartps_data->aperclk);
> > +	clk_disable_unprepare(cdns_uart_data->uartclk);
> > +	clk_disable_unprepare(cdns_uart_data->pclk);
> >  	return rc;
> >  }
> > =20
> >  /* Match table for of_platform binding */
> > -static struct of_device_id xuartps_of_match[] =3D {
> > -	{ .compatible =3D "xlnx,xuartps", },
> > +static struct of_device_id cdns_uart_of_match[] =3D {
> > +	{ .compatible =3D "xlnx,cdns_uart", },
> > +	{ .compatible =3D "cdns,uart-r1p8", },
> >  	{}
>=20
> This doesn't fit with binding doc.
>=20
> +Required properties:
> +- compatible : should be "cdns,uart-r1p8", or "xlnx,xuartps"
>=20
> You have removed xlnx,xuartps from driver and introduce new one cdns_=
uart.
> I think it was done by sed.

Argh, a victim of the search and replace, right. Good catch. It should =
be
xlnx,xuartps, just as it has been before.

	S=C3=B6ren
