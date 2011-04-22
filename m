From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH V2] tty/serial: add support for Xilinx PS UART
Date: Fri, 22 Apr 2011 09:40:39 -0600
Message-ID: <BANLkTimhk-szP=gbZLpRrofi2EB2YbXrqg@mail.gmail.com>
References: <90e49570-bc82-41a9-ac79-2f5007e93a2a@VA3EHSMHS018.ehs.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:36442 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755453Ab1DVPk7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 22 Apr 2011 11:40:59 -0400
In-Reply-To: <90e49570-bc82-41a9-ac79-2f5007e93a2a@VA3EHSMHS018.ehs.local>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: John Linn <john.linn@xilinx.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, alan@lxorguk.ukuu.org.uk, greg@kroah.com

On Wed, Apr 20, 2011 at 1:03 PM, John Linn <john.linn@xilinx.com> wrote=
:
> The Xilinx PS Uart is used on the new ARM based SoC. This
> UART is not compatible with others such that a seperate
> driver is required.
>
> Signed-off-by: John Linn <john.linn@xilinx.com>

Out of curiosity, who is the vendor of this uart IP block?  Is it new
hardware created by xilinx for zinq, or is it provided by a third
party.  If its from a third party it is within the realm of
possibility that a driver already exists for it.

g.


> ---
>
> V2 Changes
>
> Updated based on Alan Cox and Greg KH comments. Thanks for their inpu=
t.
> I hope I corrected everything as expected.
>
> 1. Now using dynamic device nodes so Doc*/devices.txt removed from pa=
tch.
> 2. Other minor updates based on Alan's input.
>
> =A0drivers/tty/serial/Kconfig =A0 =A0 =A0 =A0 | =A0 13 +
> =A0drivers/tty/serial/Makefile =A0 =A0 =A0 =A0| =A0 =A01 +
> =A0drivers/tty/serial/xilinx_uartps.c | 1121 ++++++++++++++++++++++++=
++++++++++++
> =A0include/linux/serial_core.h =A0 =A0 =A0 =A0| =A0 =A03 +
> =A04 files changed, 1138 insertions(+), 0 deletions(-)
> =A0create mode 100644 drivers/tty/serial/xilinx_uartps.c
>
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 80484af..84876ec 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1612,4 +1612,17 @@ config SERIAL_MXS_AUART_CONSOLE
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0Enable a MXS AUART port to be the system console.
>
> +config SERIAL_XILINX_PS_UART
> + =A0 =A0 =A0 tristate "Xilinx PS UART support"
> + =A0 =A0 =A0 select SERIAL_CORE
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 This driver supports the Xilinx PS UART port.
> +
> +config SERIAL_XILINX_PS_UART_CONSOLE
> + =A0 =A0 =A0 bool "Xilinx PS UART console support"
> + =A0 =A0 =A0 depends on SERIAL_XILINX_PS_UART=3Dy
> + =A0 =A0 =A0 select SERIAL_CORE_CONSOLE
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 Enable a Xilinx PS UART port to be the system conso=
le.
> +
> =A0endmenu
> diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefil=
e
> index fee0690..aafddf1 100644
> --- a/drivers/tty/serial/Makefile
> +++ b/drivers/tty/serial/Makefile
> @@ -94,3 +94,4 @@ obj-$(CONFIG_SERIAL_IFX6X60) =A0 =A0 =A0 =A0 =A0+=3D=
 ifx6x60.o
> =A0obj-$(CONFIG_SERIAL_PCH_UART) =A0+=3D pch_uart.o
> =A0obj-$(CONFIG_SERIAL_MSM_SMD) =A0 +=3D msm_smd_tty.o
> =A0obj-$(CONFIG_SERIAL_MXS_AUART) +=3D mxs-auart.o
> +obj-$(CONFIG_SERIAL_XILINX_PS_UART) +=3D xilinx_uartps.o
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/=
xilinx_uartps.c
> new file mode 100644
> index 0000000..814fb5b
> --- /dev/null
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -0,0 +1,1121 @@
> +/*
> + * Xilinx PS UART driver
> + *
> + * 2011 (c) Xilinx Inc.
> + *
> + * This program is free software; you can redistribute it
> + * and/or modify it under the terms of the GNU General Public
> + * License as published by the Free Software Foundation;
> + * either version 2 of the License, or (at your option) any
> + * later version.
> + *
> + */
> +
> +#include <linux/platform_device.h>
> +#include <linux/serial_core.h>
> +#include <linux/console.h>
> +#include <linux/serial.h>
> +#include <linux/irq.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +
> +#define XUARTPS_TTY_NAME =A0 =A0 =A0 "ttyPS"
> +#define XUARTPS_NAME =A0 =A0 =A0 =A0 =A0 "xuartps"
> +#define XUARTPS_MAJOR =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 /* use dynami=
c node allocation */
> +#define XUARTPS_MINOR =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 /* works best=
 with devtmpfs */
> +#define XUARTPS_NR_PORTS =A0 =A0 =A0 2
> +#define XUARTPS_FIFO_SIZE =A0 =A0 =A016 =A0 =A0 =A0/* FIFO size */
> +#define XUARTPS_REGISTER_SPACE 0xFFF
> +
> +#define xuartps_readl(offset) =A0 =A0 =A0 =A0 =A0ioread32(port->memb=
ase + offset)
> +#define xuartps_writel(val, offset) =A0 =A0iowrite32(val, port->memb=
ase + offset)
> +
> +/********************************Register Map***********************=
*********/
> +/** UART
> + *
> + * Register offsets for the UART.
> + *
> + */
> +#define XUARTPS_CR_OFFSET =A0 =A0 =A00x00 =A0/* Control Register [8:=
0] */
> +#define XUARTPS_MR_OFFSET =A0 =A0 =A00x04 =A0/* Mode Register [10:0]=
 */
> +#define XUARTPS_IER_OFFSET =A0 =A0 0x08 =A0/* Interrupt Enable [10:0=
] */
> +#define XUARTPS_IDR_OFFSET =A0 =A0 0x0C =A0/* Interrupt Disable [10:=
0] */
> +#define XUARTPS_IMR_OFFSET =A0 =A0 0x10 =A0/* Interrupt Mask [10:0] =
*/
> +#define XUARTPS_ISR_OFFSET =A0 =A0 0x14 =A0/* Interrupt Status [10:0=
]*/
> +#define XUARTPS_BAUDGEN_OFFSET 0x18 =A0/* Baud Rate Generator [15:0]=
 */
> +#define XUARTPS_RXTOUT_OFFSET =A00x1C =A0/* RX Timeout [7:0] */
> +#define XUARTPS_RXWM_OFFSET =A0 =A00x20 =A0/* RX FIFO Trigger Level =
[5:0] */
> +#define XUARTPS_MODEMCR_OFFSET 0x24 =A0/* Modem Control [5:0] */
> +#define XUARTPS_MODEMSR_OFFSET 0x28 =A0/* Modem Status [8:0] */
> +#define XUARTPS_SR_OFFSET =A0 =A0 =A00x2C =A0/* Channel Status [11:0=
] */
> +#define XUARTPS_FIFO_OFFSET =A0 =A00x30 =A0/* FIFO [15:0] or [7:0] *=
/
> +#define XUARTPS_BAUDDIV_OFFSET 0x34 =A0/* Baud Rate Divider [7:0] */
> +#define XUARTPS_FLOWDEL_OFFSET 0x38 =A0/* Flow Delay [15:0] */
> +#define XUARTPS_IRRX_PWIDTH_OFFSET 0x3C /* IR Minimum Received Pulse
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 Width [15:0] */
> +#define XUARTPS_IRTX_PWIDTH_OFFSET 0x40 /* IR Transmitted pulse
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 Width [7:0] */
> +#define XUARTPS_TXWM_OFFSET =A0 =A00x44 =A0/* TX FIFO Trigger Level =
[5:0] */
> +
> +/** Control Register
> + *
> + * The Control register (CR) controls the major functions of the dev=
ice.
> + *
> + * Control Register Bit Definitions
> + */
> +#define XUARTPS_CR_STOPBRK =A0 =A0 0x00000100 =A0/* Stop TX break */
> +#define XUARTPS_CR_STARTBRK =A0 =A00x00000080 =A0/* Set TX break */
> +#define XUARTPS_CR_TX_DIS =A0 =A0 =A00x00000020 =A0/* TX disabled. *=
/
> +#define XUARTPS_CR_TX_EN =A0 =A0 =A0 0x00000010 =A0/* TX enabled */
> +#define XUARTPS_CR_RX_DIS =A0 =A0 =A00x00000008 =A0/* RX disabled. *=
/
> +#define XUARTPS_CR_RX_EN =A0 =A0 =A0 0x00000004 =A0/* RX enabled */
> +#define XUARTPS_CR_TXRST =A0 =A0 =A0 0x00000002 =A0/* TX logic reset=
 */
> +#define XUARTPS_CR_RXRST =A0 =A0 =A0 0x00000001 =A0/* RX logic reset=
 */
> +#define XUARTPS_CR_RST_TO =A0 =A0 =A00x00000040 =A0/* Restart Timeou=
t Counter */
> +
> +/** Mode Register
> + *
> + * The mode register (MR) defines the mode of transfer as well as th=
e data
> + * format. If this register is modified during transmission or recep=
tion,
> + * data validity cannot be guaranteed.
> + *
> + * Mode Register Bit Definitions
> + *
> + */
> +#define XUARTPS_MR_CLKSEL =A0 =A0 =A0 =A0 =A0 =A0 =A00x00000001 =A0/=
* Pre-scalar selection */
> +#define XUARTPS_MR_CHMODE_L_LOOP =A0 =A0 =A0 0x00000200 =A0/* Local =
loop back mode */
> +#define XUARTPS_MR_CHMODE_NORM =A0 =A0 =A0 =A0 0x00000000 =A0/* Norm=
al mode */
> +
> +#define XUARTPS_MR_STOPMODE_2_BIT =A0 =A0 =A00x00000080 =A0/* 2 stop=
 bits */
> +#define XUARTPS_MR_STOPMODE_1_BIT =A0 =A0 =A00x00000000 =A0/* 1 stop=
 bit */
> +
> +#define XUARTPS_MR_PARITY_NONE =A0 =A0 =A0 =A0 0x00000020 =A0/* No p=
arity mode */
> +#define XUARTPS_MR_PARITY_MARK =A0 =A0 =A0 =A0 0x00000018 =A0/* Mark=
 parity mode */
> +#define XUARTPS_MR_PARITY_SPACE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x000=
00010 =A0/* Space parity mode */
> +#define XUARTPS_MR_PARITY_ODD =A0 =A0 =A0 =A0 =A00x00000008 =A0/* Od=
d parity mode */
> +#define XUARTPS_MR_PARITY_EVEN =A0 =A0 =A0 =A0 0x00000000 =A0/* Even=
 parity mode */
> +
> +#define XUARTPS_MR_CHARLEN_6_BIT =A0 =A0 =A0 0x00000006 =A0/* 6 bits=
 data */
> +#define XUARTPS_MR_CHARLEN_7_BIT =A0 =A0 =A0 0x00000004 =A0/* 7 bits=
 data */
> +#define XUARTPS_MR_CHARLEN_8_BIT =A0 =A0 =A0 0x00000000 =A0/* 8 bits=
 data */
> +
> +/** Interrupt Registers
> + *
> + * Interrupt control logic uses the interrupt enable register (IER) =
and the
> + * interrupt disable register (IDR) to set the value of the bits in =
the
> + * interrupt mask register (IMR). The IMR determines whether to pass=
 an
> + * interrupt to the interrupt status register (ISR).
> + * Writing a 1 to IER Enables an interrupt, writing a 1 to IDR disab=
les an
> + * interrupt. IMR and ISR are read only, and IER and IDR are write o=
nly.
> + * Reading either IER or IDR returns 0x00.
> + *
> + * All four registers have the same bit definitions.
> + */
> +#define XUARTPS_IXR_TOUT =A0 =A0 =A0 0x00000100 /* RX Timeout error =
interrupt */
> +#define XUARTPS_IXR_PARITY =A0 =A0 0x00000080 /* Parity error interr=
upt */
> +#define XUARTPS_IXR_FRAMING =A0 =A00x00000040 /* Framing error inter=
rupt */
> +#define XUARTPS_IXR_OVERRUN =A0 =A00x00000020 /* Overrun error inter=
rupt */
> +#define XUARTPS_IXR_TXFULL =A0 =A0 0x00000010 /* TX FIFO Full interr=
upt */
> +#define XUARTPS_IXR_TXEMPTY =A0 =A00x00000008 /* TX FIFO empty inter=
rupt */
> +#define XUARTPS_ISR_RXEMPTY =A0 =A00x00000002 /* RX FIFO empty inter=
rupt */
> +#define XUARTPS_IXR_RXTRIG =A0 =A0 0x00000001 /* RX FIFO trigger int=
errupt */
> +#define XUARTPS_IXR_RXFULL =A0 =A0 0x00000004 /* RX FIFO full interr=
upt. */
> +#define XUARTPS_IXR_RXEMPTY =A0 =A00x00000002 /* RX FIFO empty inter=
rupt. */
> +#define XUARTPS_IXR_MASK =A0 =A0 =A0 0x00001FFF /* Valid bit mask */
> +
> +
> +/** Channel Status Register
> + *
> + * The channel status register (CSR) is provided to enable the contr=
ol logic
> + * to monitor the status of bits in the channel interrupt status reg=
ister,
> + * even if these are masked out by the interrupt mask register.
> + */
> +#define XUARTPS_SR_RXEMPTY =A0 =A0 0x00000002 /* RX FIFO empty */
> +#define XUARTPS_SR_TXEMPTY =A0 =A0 0x00000008 /* TX FIFO empty */
> +#define XUARTPS_SR_TXFULL =A0 =A0 =A00x00000010 /* TX FIFO full */
> +#define XUARTPS_SR_RXTRIG =A0 =A0 =A00x00000001 /* Rx Trigger */
> +
> +
> +/**
> + * xuartps_isr - Interrupt handler
> + * @irq: Irq number
> + * @dev_id: Id of the port
> + *
> + * Returns IRQHANDLED
> + **/
> +static irqreturn_t xuartps_isr(int irq, void *dev_id)
> +{
> + =A0 =A0 =A0 struct uart_port *port =3D (struct uart_port *)dev_id;
> + =A0 =A0 =A0 struct tty_struct *tty;
> + =A0 =A0 =A0 unsigned long flags;
> + =A0 =A0 =A0 unsigned int isrstatus, numbytes;
> + =A0 =A0 =A0 unsigned int data;
> + =A0 =A0 =A0 char status =3D TTY_NORMAL;
> +
> + =A0 =A0 =A0 /* Get the tty which could be NULL so don't assume it's=
 valid */
> + =A0 =A0 =A0 tty =3D tty_port_tty_get(&port->state->port);
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&port->lock, flags);
> +
> + =A0 =A0 =A0 /* Read the interrupt status register to determine whic=
h
> + =A0 =A0 =A0 =A0* interrupt(s) is/are active.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 isrstatus =3D xuartps_readl(XUARTPS_ISR_OFFSET);
> +
> + =A0 =A0 =A0 /* drop byte with parity error if IGNPAR specified */
> + =A0 =A0 =A0 if (isrstatus & port->ignore_status_mask & XUARTPS_IXR_=
PARITY)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 isrstatus &=3D ~(XUARTPS_IXR_RXTRIG | X=
UARTPS_IXR_TOUT);
> +
> + =A0 =A0 =A0 isrstatus &=3D port->read_status_mask;
> + =A0 =A0 =A0 isrstatus &=3D ~port->ignore_status_mask;
> +
> + =A0 =A0 =A0 if ((isrstatus & XUARTPS_IXR_TOUT) ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (isrstatus & XUARTPS_IXR_RXTRIG)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Receive Timeout Interrupt */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while ((xuartps_readl(XUARTPS_SR_OFFSET=
) &
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 XUARTPS_SR_RXEMPTY) !=3D=
 XUARTPS_SR_RXEMPTY) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data =3D xuartps_readl(=
XUARTPS_FIFO_OFFSET);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 port->icount.rx++;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (isrstatus & XUARTPS=
_IXR_PARITY) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 port->i=
count.parity++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =
=3D TTY_PARITY;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (isrstatus & =
XUARTPS_IXR_FRAMING) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 port->i=
count.frame++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =
=3D TTY_FRAME;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (isrstatus & =
XUARTPS_IXR_OVERRUN)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 port->i=
count.overrun++;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (tty)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart_in=
sert_char(port, isrstatus,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 XUARTPS_IXR_OVERRUN, data,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 status);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&port->lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (tty)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tty_flip_buffer_push(tt=
y);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock(&port->lock);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Dispatch an appropriate handler */
> + =A0 =A0 =A0 if ((isrstatus & XUARTPS_IXR_TXEMPTY) =3D=3D XUARTPS_IX=
R_TXEMPTY) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (uart_circ_empty(&port->state->xmit)=
) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xuartps_writel(XUARTPS_=
IXR_TXEMPTY,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 XUARTPS_IDR_OFFSET);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 numbytes =3D port->fifo=
size;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Break if no more dat=
a available in the UART buffer */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (numbytes--) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (uar=
t_circ_empty(&port->state->xmit))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Get =
the data from the UART circular buffer
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* an=
d write it to the xuartps's TX_FIFO
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* re=
gister.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xuartps=
_writel(
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 port->state->xmit.buf[port->state->xmit.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 tail], XUARTPS_FIFO_OFFSET);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 port->i=
count.tx++;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Adju=
st the tail of the UART buffer and wrap
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* th=
e buffer if it reaches limit.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 port->s=
tate->xmit.tail =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 (port->state->xmit.tail + 1) & \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 (UART_XMIT_SIZE - 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (uart_circ_chars_pen=
ding(
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 &port->state->xmit) < WAKEUP_CHARS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart_wr=
ite_wakeup(port);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 xuartps_writel(isrstatus, XUARTPS_ISR_OFFSET);
> +
> + =A0 =A0 =A0 /* be sure to release the lock and tty before leaving *=
/
> + =A0 =A0 =A0 spin_unlock_irqrestore(&port->lock, flags);
> + =A0 =A0 =A0 tty_kref_put(tty);
> +
> + =A0 =A0 =A0 return IRQ_HANDLED;
> +}
> +
> +/**
> + * xuartps_set_baud_rate - Calculate and set the baud rate
> + * @port: Handle to the uart port structure
> + * @baud: Baud rate to set
> + *
> + **/
> +static void xuartps_set_baud_rate(struct uart_port *port, unsigned i=
nt baud)
> +{
> + =A0 =A0 =A0 unsigned int sel_clk;
> + =A0 =A0 =A0 unsigned int calc_baud;
> + =A0 =A0 =A0 unsigned int brgr_val, brdiv_val;
> + =A0 =A0 =A0 unsigned int bauderror, percent_err =3D 100;
> +
> + =A0 =A0 =A0 /* Formula to obtain baud rate is
> + =A0 =A0 =A0 =A0* =A0 =A0 =A0baud_tx/rx rate =3D sel_clk/CD * (BDIV =
+ 1)
> + =A0 =A0 =A0 =A0* =A0 =A0 =A0input_clk =3D (Uart User Defined Clock =
or Apb Clock)
> + =A0 =A0 =A0 =A0* =A0 =A0 =A0 =A0 =A0 =A0 =A0depends on UCLKEN in MR=
 Reg
> + =A0 =A0 =A0 =A0* =A0 =A0 =A0sel_clk =3D input_clk or input_clk/8;
> + =A0 =A0 =A0 =A0* =A0 =A0 =A0 =A0 =A0 =A0 =A0depends on CLKS in MR r=
eg
> + =A0 =A0 =A0 =A0* =A0 =A0 =A0CD and BDIV depends on values in
> + =A0 =A0 =A0 =A0* =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0baud ra=
te generate register
> + =A0 =A0 =A0 =A0* =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0baud ra=
te clock divisor register
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 sel_clk =3D port->uartclk;
> + =A0 =A0 =A0 if (xuartps_readl(XUARTPS_MR_OFFSET) & XUARTPS_MR_CLKSE=
L)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sel_clk =3D sel_clk / 8;
> +
> + =A0 =A0 =A0 /* Check for the values of baud clk divisor value rangi=
ng from 4 to 255
> + =A0 =A0 =A0 =A0* where the percent_err for the given baud rate is a=
cceptable.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 for (brdiv_val =3D 4; brdiv_val < 255; brdiv_val++) {
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 brgr_val =3D sel_clk / (baud * (brdiv_v=
al + 1));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (brgr_val < 2 || brgr_val > 65535)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 calc_baud =3D sel_clk / (brgr_val * (br=
div_val + 1));
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (baud > calc_baud)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bauderror =3D baud - ca=
lc_baud;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bauderror =3D calc_baud=
 - baud;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 percent_err =3D (bauderror * 100) / bau=
d;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (percent_err < 3)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (percent_err >=3D 3)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(port->dev, "Error too large, ba=
ud rate not set\n");
> + =A0 =A0 =A0 else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Set the values for the new baud rate=
 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xuartps_writel(brgr_val, XUARTPS_BAUDGE=
N_OFFSET);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xuartps_writel(brdiv_val, XUARTPS_BAUDD=
IV_OFFSET);
> +
> + =A0 =A0 =A0 }
> +}
> +
> +
> +/*----------------------Uart Operations---------------------------*/
> +
> +/**
> + * xuartps_start_tx - =A0Start transmitting bytes
> + * @port: Handle to the uart port structure
> + *
> + **/
> +static void xuartps_start_tx(struct uart_port *port)
> +{
> + =A0 =A0 =A0 unsigned int status, numbytes =3D port->fifosize;
> +
> + =A0 =A0 =A0 if (uart_circ_empty(&port->state->xmit) || uart_tx_stop=
ped(port))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 status =3D xuartps_readl(XUARTPS_CR_OFFSET);
> + =A0 =A0 =A0 /* Set the TX enable bit and clear the TX disable bit t=
o enable the
> + =A0 =A0 =A0 =A0* transmitter.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 xuartps_writel((status & ~XUARTPS_CR_TX_DIS) | XUARTPS_=
CR_TX_EN,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 XUARTPS_CR_OFFSET);
> +
> + =A0 =A0 =A0 while (numbytes-- && ((xuartps_readl(XUARTPS_SR_OFFSET)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 & XUARTPS_SR_TXFULL)) !=3D XUARTPS_SR_T=
XFULL) {
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Break if no more data available in t=
he UART buffer */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (uart_circ_empty(&port->state->xmit)=
)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Get the data from the UART circular =
buffer and
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* write it to the xuartps's TX_FIFO =
register.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xuartps_writel(
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 port->state->xmit.buf[p=
ort->state->xmit.tail],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 XUARTPS_FIFO_OFFSET);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 port->icount.tx++;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Adjust the tail of the UART buffer a=
nd wrap
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* the buffer if it reaches limit.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 port->state->xmit.tail =3D (port->state=
->xmit.tail + 1) &
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 (UART_XMIT_SIZE - 1);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Enable the TX Empty interrupt */
> + =A0 =A0 =A0 xuartps_writel(XUARTPS_IXR_TXEMPTY, XUARTPS_IER_OFFSET)=
;
> +
> + =A0 =A0 =A0 if (uart_circ_chars_pending(&port->state->xmit) < WAKEU=
P_CHARS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart_write_wakeup(port);
> +
> +}
> +
> +/**
> + * xuartps_stop_tx - Stop TX
> + * @port: Handle to the uart port structure
> + *
> + **/
> +static void xuartps_stop_tx(struct uart_port *port)
> +{
> + =A0 =A0 =A0 unsigned int regval;
> +
> + =A0 =A0 =A0 regval =3D xuartps_readl(XUARTPS_CR_OFFSET);
> + =A0 =A0 =A0 regval |=3D XUARTPS_CR_TX_DIS;
> + =A0 =A0 =A0 /* Disable the transmitter */
> + =A0 =A0 =A0 xuartps_writel(regval, XUARTPS_CR_OFFSET);
> +}
> +
> +/**
> + * xuartps_stop_rx - Stop RX
> + * @port: Handle to the uart port structure
> + *
> + **/
> +static void xuartps_stop_rx(struct uart_port *port)
> +{
> + =A0 =A0 =A0 unsigned int regval;
> +
> + =A0 =A0 =A0 regval =3D xuartps_readl(XUARTPS_CR_OFFSET);
> + =A0 =A0 =A0 regval |=3D XUARTPS_CR_RX_DIS;
> + =A0 =A0 =A0 /* Disable the receiver */
> + =A0 =A0 =A0 xuartps_writel(regval, XUARTPS_CR_OFFSET);
> +}
> +
> +/**
> + * xuartps_tx_empty - =A0Check whether TX is empty
> + * @port: Handle to the uart port structure
> + *
> + * Returns TIOCSER_TEMT on success, 0 otherwise
> + **/
> +static unsigned int xuartps_tx_empty(struct uart_port *port)
> +{
> + =A0 =A0 =A0 unsigned int status;
> +
> + =A0 =A0 =A0 status =3D xuartps_readl(XUARTPS_ISR_OFFSET) & XUARTPS_=
IXR_TXEMPTY;
> + =A0 =A0 =A0 return status ? TIOCSER_TEMT : 0;
> +
> +}
> +
> +
> +/**
> + * xuartps_break_ctl - Based on the input ctl we have to start or st=
op
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 transmitting char breaks
> + * @port: Handle to the uart port structure
> + * @ctl: Value based on which start or stop decision is taken
> + *
> + **/
> +static void xuartps_break_ctl(struct uart_port *port, int ctl)
> +{
> + =A0 =A0 =A0 unsigned int status;
> + =A0 =A0 =A0 unsigned long flags;
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&port->lock, flags);
> +
> + =A0 =A0 =A0 status =3D xuartps_readl(XUARTPS_CR_OFFSET);
> +
> + =A0 =A0 =A0 if (ctl =3D=3D -1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xuartps_writel(XUARTPS_CR_STARTBRK | st=
atus,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 XUARTPS_CR_OFFSET);
> + =A0 =A0 =A0 else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((status & XUARTPS_CR_STOPBRK) =3D=3D=
 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xuartps_writel(XUARTPS_=
CR_STOPBRK | status,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0XUARTPS_CR_OFFSET);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 spin_unlock_irqrestore(&port->lock, flags);
> +}
> +
> +/**
> + * xuartps_set_termios - termios operations, handling data length, p=
arity,
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 stop bits=
, flow control, baud rate
> + * @port: Handle to the uart port structure
> + * @termios: Handle to the input termios structure
> + * @old: Values of the previously saved termios structure
> + *
> + **/
> +static void xuartps_set_termios(struct uart_port *port,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct =
ktermios *termios, struct ktermios *old)
> +{
> + =A0 =A0 =A0 unsigned int cval =3D 0;
> + =A0 =A0 =A0 unsigned int baud;
> + =A0 =A0 =A0 unsigned long flags;
> + =A0 =A0 =A0 unsigned int ctrl_reg, mode_reg;
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&port->lock, flags);
> +
> + =A0 =A0 =A0 /* Empty the receive FIFO 1st before making changes */
> + =A0 =A0 =A0 while ((xuartps_readl(XUARTPS_SR_OFFSET) &
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0XUARTPS_SR_RXEMPTY) !=3D XUARTPS_SR_=
RXEMPTY) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xuartps_readl(XUARTPS_FIFO_OFFSET);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Disable the TX and RX to set baud rate */
> + =A0 =A0 =A0 xuartps_writel(xuartps_readl(XUARTPS_CR_OFFSET) |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (XUARTPS_CR_TX_DIS | XU=
ARTPS_CR_RX_DIS),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 XUARTPS_CR_OFFSET);
> +
> + =A0 =A0 =A0 /* Min baud rate =3D 6bps and Max Baud Rate is 10Mbps f=
or 100Mhz clk */
> + =A0 =A0 =A0 baud =3D uart_get_baud_rate(port, termios, old, 0, 1000=
0000);
> + =A0 =A0 =A0 xuartps_set_baud_rate(port, baud);
> + =A0 =A0 =A0 if (tty_termios_baud_rate(termios))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tty_termios_encode_baud_rate(termios, b=
aud, baud);
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Update the per-port timeout.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 uart_update_timeout(port, termios->c_cflag, baud);
> +
> + =A0 =A0 =A0 /* Set TX/RX Reset */
> + =A0 =A0 =A0 xuartps_writel(xuartps_readl(XUARTPS_CR_OFFSET) |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (XUARTPS_CR_TXRST | XUA=
RTPS_CR_RXRST),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 XUARTPS_CR_OFFSET);
> +
> + =A0 =A0 =A0 ctrl_reg =3D xuartps_readl(XUARTPS_CR_OFFSET);
> +
> + =A0 =A0 =A0 /* Clear the RX disable and TX disable bits and then se=
t the TX enable
> + =A0 =A0 =A0 =A0* bit and RX enable bit to enable the transmitter an=
d receiver.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 xuartps_writel(
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (ctrl_reg & ~(XUARTPS_CR_TX_DIS | XUART=
PS_CR_RX_DIS))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | (XUARTPS_CR_TX_EN | X=
UARTPS_CR_RX_EN),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 XUARTPS_CR_OFFSET);
> +
> + =A0 =A0 =A0 xuartps_writel(10, XUARTPS_RXTOUT_OFFSET);
> +
> + =A0 =A0 =A0 port->read_status_mask =3D XUARTPS_IXR_TXEMPTY | XUARTP=
S_IXR_RXTRIG |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 XUARTPS_IXR_OVERRUN | X=
UARTPS_IXR_TOUT;
> + =A0 =A0 =A0 port->ignore_status_mask =3D 0;
> +
> + =A0 =A0 =A0 if (termios->c_iflag & INPCK)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 port->read_status_mask |=3D XUARTPS_IXR=
_PARITY |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 XUARTPS_IXR_FRAMING;
> +
> + =A0 =A0 =A0 if (termios->c_iflag & IGNPAR)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 port->ignore_status_mask |=3D XUARTPS_I=
XR_PARITY |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 XUARTPS_IXR_FRAMING | X=
UARTPS_IXR_OVERRUN;
> +
> + =A0 =A0 =A0 /* ignore all characters if CREAD is not set */
> + =A0 =A0 =A0 if ((termios->c_cflag & CREAD) =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 port->ignore_status_mask |=3D XUARTPS_I=
XR_RXTRIG |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 XUARTPS_IXR_TOUT | XUAR=
TPS_IXR_PARITY |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 XUARTPS_IXR_FRAMING | X=
UARTPS_IXR_OVERRUN;
> +
> + =A0 =A0 =A0 mode_reg =3D xuartps_readl(XUARTPS_MR_OFFSET);
> +
> + =A0 =A0 =A0 /* Handling Data Size */
> + =A0 =A0 =A0 switch (termios->c_cflag & CSIZE) {
> + =A0 =A0 =A0 case CS6:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cval |=3D XUARTPS_MR_CHARLEN_6_BIT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case CS7:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cval |=3D XUARTPS_MR_CHARLEN_7_BIT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 case CS8:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cval |=3D XUARTPS_MR_CHARLEN_8_BIT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 termios->c_cflag &=3D ~CSIZE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 termios->c_cflag |=3D CS8;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Handling Parity and Stop Bits length */
> + =A0 =A0 =A0 if (termios->c_cflag & CSTOPB)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cval |=3D XUARTPS_MR_STOPMODE_2_BIT; /*=
 2 STOP bits */
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cval |=3D XUARTPS_MR_STOPMODE_1_BIT; /*=
 1 STOP bit */
> +
> + =A0 =A0 =A0 if (termios->c_cflag & PARENB) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Mark or Space parity */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (termios->c_cflag & CMSPAR) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (termios->c_cflag & =
PARODD)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cval |=3D=
 XUARTPS_MR_PARITY_MARK;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cval |=3D=
 XUARTPS_MR_PARITY_SPACE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (termios->c_cflag & PARODD)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cval |=3D=
 XUARTPS_MR_PARITY_ODD;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cval |=3D=
 XUARTPS_MR_PARITY_EVEN;
> + =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cval |=3D XUARTPS_MR_PARITY_NONE;
> + =A0 =A0 =A0 xuartps_writel(cval , XUARTPS_MR_OFFSET);
> +
> + =A0 =A0 =A0 spin_unlock_irqrestore(&port->lock, flags);
> +}
> +
> +/**
> + * xuartps_startup - Called when an application opens a xuartps port
> + * @port: Handle to the uart port structure
> + *
> + * Returns 0 on success, negative error otherwise
> + **/
> +static int xuartps_startup(struct uart_port *port)
> +{
> + =A0 =A0 =A0 unsigned int retval =3D 0, status =3D 0;
> +
> + =A0 =A0 =A0 retval =3D request_irq(port->irq, xuartps_isr, 0, XUART=
PS_NAME,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (void *)port);
> + =A0 =A0 =A0 if (retval)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return retval;
> +
> + =A0 =A0 =A0 /* Disable the TX and RX */
> + =A0 =A0 =A0 xuartps_writel(XUARTPS_CR_TX_DIS | XUARTPS_CR_RX_DIS,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 XUARTPS_CR_OFFSET);
> +
> + =A0 =A0 =A0 /* Set the Control Register with TX/RX Enable, TX/RX Re=
set,
> + =A0 =A0 =A0 =A0* no break chars.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 xuartps_writel(XUARTPS_CR_TXRST | XUARTPS_CR_RXRST,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 XUARTPS=
_CR_OFFSET);
> +
> + =A0 =A0 =A0 status =3D xuartps_readl(XUARTPS_CR_OFFSET);
> +
> + =A0 =A0 =A0 /* Clear the RX disable and TX disable bits and then se=
t the TX enable
> + =A0 =A0 =A0 =A0* bit and RX enable bit to enable the transmitter an=
d receiver.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 xuartps_writel((status & ~(XUARTPS_CR_TX_DIS | XUARTPS_=
CR_RX_DIS))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | (XUARTPS_CR_TX_EN | X=
UARTPS_CR_RX_EN |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 XUARTPS_CR_STOPBRK), XU=
ARTPS_CR_OFFSET);
> +
> + =A0 =A0 =A0 /* Set the Mode Register with normal mode,8 data bits,1=
 stop bit,
> + =A0 =A0 =A0 =A0* no parity.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 xuartps_writel(XUARTPS_MR_CHMODE_NORM | XUARTPS_MR_STOP=
MODE_1_BIT
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 | XUARTPS_MR_PARITY_NONE | XUARTPS_MR_C=
HARLEN_8_BIT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0XUARTPS_MR_OFFSET);
> +
> + =A0 =A0 =A0 /* Set the RX FIFO Trigger level to 14 assuming FIFO si=
ze as 16 */
> + =A0 =A0 =A0 xuartps_writel(14, XUARTPS_RXWM_OFFSET);
> +
> + =A0 =A0 =A0 /* Receive Timeout register is enabled with value of 10=
 */
> + =A0 =A0 =A0 xuartps_writel(10, XUARTPS_RXTOUT_OFFSET);
> +
> +
> + =A0 =A0 =A0 /* Set the Interrupt Registers with desired interrupts =
*/
> + =A0 =A0 =A0 xuartps_writel(XUARTPS_IXR_TXEMPTY | XUARTPS_IXR_PARITY=
 |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 XUARTPS_IXR_FRAMING | XUARTPS_IXR_OVERR=
UN |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 XUARTPS_IXR_RXTRIG | XUARTPS_IXR_TOUT, =
XUARTPS_IER_OFFSET);
> + =A0 =A0 =A0 xuartps_writel(~(XUARTPS_IXR_TXEMPTY | XUARTPS_IXR_PARI=
TY |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 XUARTPS_IXR_FRAMING | XUARTPS_IXR_OVERR=
UN |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 XUARTPS_IXR_RXTRIG | XUARTPS_IXR_TOUT),=
 XUARTPS_IDR_OFFSET);
> +
> + =A0 =A0 =A0 return retval;
> +}
> +
> +/**
> + * xuartps_shutdown - Called when an application closes a xuartps po=
rt
> + * @port: Handle to the uart port structure
> + *
> + **/
> +static void xuartps_shutdown(struct uart_port *port)
> +{
> + =A0 =A0 =A0 int status;
> +
> + =A0 =A0 =A0 /* Disable interrupts */
> + =A0 =A0 =A0 status =3D xuartps_readl(XUARTPS_IMR_OFFSET);
> + =A0 =A0 =A0 xuartps_writel(status, XUARTPS_IDR_OFFSET);
> +
> + =A0 =A0 =A0 /* Disable the TX and RX */
> + =A0 =A0 =A0 xuartps_writel(XUARTPS_CR_TX_DIS | XUARTPS_CR_RX_DIS,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0XUAR=
TPS_CR_OFFSET);
> + =A0 =A0 =A0 free_irq(port->irq, port);
> +}
> +
> +/**
> + * xuartps_type - Set UART type to xuartps port
> + * @port: Handle to the uart port structure
> + *
> + * Returns string on success, NULL otherwise
> + **/
> +static const char *xuartps_type(struct uart_port *port)
> +{
> + =A0 =A0 =A0 return port->type =3D=3D PORT_XUARTPS ? XUARTPS_NAME : =
NULL;
> +}
> +
> +/**
> + * xuartps_verify_port - Verify the port params
> + * @port: Handle to the uart port structure
> + * @ser: Handle to the structure whose members are compared
> + *
> + * Returns 0 if success otherwise -EINVAL
> + **/
> +static int xuartps_verify_port(struct uart_port *port,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 struct serial_struct *ser)
> +{
> + =A0 =A0 =A0 if (ser->type !=3D PORT_UNKNOWN && ser->type !=3D PORT_=
XUARTPS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 if (port->irq !=3D ser->irq)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 if (ser->io_type !=3D UPIO_MEM)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 if (port->iobase !=3D ser->port)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 if (ser->hub6 !=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/**
> + * xuartps_request_port - Claim the memory region attached to xuartp=
s port,
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 called wh=
en the driver adds a xuartps port via
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart_add_=
one_port()
> + * @port: Handle to the uart port structure
> + *
> + * Returns 0, -ENOMEM if request fails
> + **/
> +static int xuartps_request_port(struct uart_port *port)
> +{
> + =A0 =A0 =A0 if (!request_mem_region(port->mapbase, XUARTPS_REGISTER=
_SPACE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0XUARTPS_NAME)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 port->membase =3D ioremap(port->mapbase, XUARTPS_REGIST=
ER_SPACE);
> + =A0 =A0 =A0 if (!port->membase) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(port->dev, "Unable to map regis=
ters\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_mem_region(port->mapbase, XUART=
PS_REGISTER_SPACE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/**
> + * xuartps_release_port - Release the memory region attached to a xu=
artps
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 port, cal=
led when the driver removes a xuartps
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 port via =
uart_remove_one_port().
> + * @port: Handle to the uart port structure
> + *
> + **/
> +static void xuartps_release_port(struct uart_port *port)
> +{
> + =A0 =A0 =A0 release_mem_region(port->mapbase, XUARTPS_REGISTER_SPAC=
E);
> + =A0 =A0 =A0 iounmap(port->membase);
> + =A0 =A0 =A0 port->membase =3D NULL;
> +}
> +
> +/**
> + * xuartps_config_port - Configure xuartps, called when the driver a=
dds a
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xuartps p=
ort
> + * @port: Handle to the uart port structure
> + * @flags: If any
> + *
> + **/
> +static void xuartps_config_port(struct uart_port *port, int flags)
> +{
> + =A0 =A0 =A0 if (flags & UART_CONFIG_TYPE && xuartps_request_port(po=
rt) =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 port->type =3D PORT_XUARTPS;
> +
> +}
> +
> +/**
> + * xuartps_get_mctrl - Get the modem control state
> + *
> + * @port: Handle to the uart port structure
> + *
> + * Returns the modem control state
> + *
> + **/
> +static unsigned int xuartps_get_mctrl(struct uart_port *port)
> +{
> + =A0 =A0 =A0 return TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;
> +}
> +
> +static void xuartps_set_mctrl(struct uart_port *port, unsigned int m=
ctrl)
> +{
> + =A0 =A0 =A0 /* N/A */
> +}
> +
> +static void xuartps_enable_ms(struct uart_port *port)
> +{
> + =A0 =A0 =A0 /* N/A */
> +}
> +
> +/** The UART operations structure
> + */
> +static struct uart_ops xuartps_ops =3D {
> + =A0 =A0 =A0 .set_mctrl =A0 =A0 =A0=3D xuartps_set_mctrl,
> + =A0 =A0 =A0 .get_mctrl =A0 =A0 =A0=3D xuartps_get_mctrl,
> + =A0 =A0 =A0 .enable_ms =A0 =A0 =A0=3D xuartps_enable_ms,
> +
> + =A0 =A0 =A0 .start_tx =A0 =A0 =A0 =3D xuartps_start_tx, =A0 =A0 /* =
Start transmitting */
> + =A0 =A0 =A0 .stop_tx =A0 =A0 =A0 =A0=3D xuartps_stop_tx, =A0 =A0 =A0=
/* Stop transmission */
> + =A0 =A0 =A0 .stop_rx =A0 =A0 =A0 =A0=3D xuartps_stop_rx, =A0 =A0 =A0=
/* Stop reception */
> + =A0 =A0 =A0 .tx_empty =A0 =A0 =A0 =3D xuartps_tx_empty, =A0 =A0 /* =
Transmitter busy? */
> + =A0 =A0 =A0 .break_ctl =A0 =A0 =A0=3D xuartps_break_ctl, =A0 =A0/* =
Start/stop
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0* transmitting break
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 .set_termios =A0 =A0=3D xuartps_set_termios, =A0/* Set =
termios */
> + =A0 =A0 =A0 .startup =A0 =A0 =A0 =A0=3D xuartps_startup, =A0 =A0 =A0=
/* App opens xuartps */
> + =A0 =A0 =A0 .shutdown =A0 =A0 =A0 =3D xuartps_shutdown, =A0 =A0 /* =
App closes xuartps */
> + =A0 =A0 =A0 .type =A0 =A0 =A0 =A0 =A0 =3D xuartps_type, =A0 =A0 =A0=
 =A0 /* Set UART type */
> + =A0 =A0 =A0 .verify_port =A0 =A0=3D xuartps_verify_port, =A0/* Veri=
fication of port
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0* params
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 .request_port =A0 =3D xuartps_request_port, /* Claim re=
sources
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0* associated with a
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0* xuartps port
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 .release_port =A0 =3D xuartps_release_port, /* Release =
resources
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0* associated with a
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0* xuartps port
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 .config_port =A0 =A0=3D xuartps_config_port, =A0/* Conf=
igure when driver
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0* adds a xuartps port
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> +};
> +
> +static struct uart_port xuartps_port[2];
> +
> +/**
> + * xuartps_get_port - Configure the port from the platform device re=
source
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 info
> + *
> + * Returns a pointer to a uart_port or NULL for failure
> + **/
> +static struct uart_port *xuartps_get_port(void)
> +{
> + =A0 =A0 =A0 struct uart_port *port;
> + =A0 =A0 =A0 int id;
> +
> + =A0 =A0 =A0 /* Find the next unused port */
> + =A0 =A0 =A0 for (id =3D 0; id < XUARTPS_NR_PORTS; id++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (xuartps_port[id].mapbase =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 if (id >=3D XUARTPS_NR_PORTS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> +
> + =A0 =A0 =A0 port =3D &xuartps_port[id];
> +
> + =A0 =A0 =A0 /* At this point, we've got an empty uart_port struct, =
initialize it */
> + =A0 =A0 =A0 spin_lock_init(&port->lock);
> + =A0 =A0 =A0 port->membase =A0 =3D NULL;
> + =A0 =A0 =A0 port->iobase =A0 =A0=3D 1; /* mark port in use */
> + =A0 =A0 =A0 port->irq =A0 =A0 =A0 =3D NO_IRQ;
> + =A0 =A0 =A0 port->type =A0 =A0 =A0=3D PORT_UNKNOWN;
> + =A0 =A0 =A0 port->iotype =A0 =A0=3D UPIO_MEM32;
> + =A0 =A0 =A0 port->flags =A0 =A0 =3D UPF_BOOT_AUTOCONF;
> + =A0 =A0 =A0 port->ops =A0 =A0 =A0 =3D &xuartps_ops;
> + =A0 =A0 =A0 port->fifosize =A0=3D XUARTPS_FIFO_SIZE;
> + =A0 =A0 =A0 port->line =A0 =A0 =A0=3D id;
> + =A0 =A0 =A0 port->dev =A0 =A0 =A0 =3D NULL;
> + =A0 =A0 =A0 return port;
> +}
> +
> +/*-----------------------Console driver operations------------------=
--------*/
> +
> +#ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
> +/**
> + * xuartps_console_wait_tx - Wait for the TX to be full
> + * @port: Handle to the uart port structure
> + *
> + **/
> +static void xuartps_console_wait_tx(struct uart_port *port)
> +{
> + =A0 =A0 =A0 while ((xuartps_readl(XUARTPS_SR_OFFSET) & XUARTPS_SR_T=
XEMPTY)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !=3D XU=
ARTPS_SR_TXEMPTY)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 barrier();
> +}
> +
> +/**
> + * xuartps_console_putchar - write the character to the FIFO buffer
> + * @port: Handle to the uart port structure
> + * @ch: Character to be written
> + *
> + **/
> +static void xuartps_console_putchar(struct uart_port *port, int ch)
> +{
> + =A0 =A0 =A0 xuartps_console_wait_tx(port);
> + =A0 =A0 =A0 xuartps_writel(ch, XUARTPS_FIFO_OFFSET);
> +}
> +
> +/**
> + * xuartps_console_write - perform write operation
> + * @port: Handle to the uart port structure
> + * @s: Pointer to character array
> + * @count: No of characters
> + **/
> +static void xuartps_console_write(struct console *co, const char *s,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigne=
d int count)
> +{
> + =A0 =A0 =A0 struct uart_port *port =3D &xuartps_port[co->index];
> + =A0 =A0 =A0 unsigned long flags;
> + =A0 =A0 =A0 unsigned int imr;
> + =A0 =A0 =A0 int locked =3D 1;
> +
> + =A0 =A0 =A0 if (oops_in_progress)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 locked =3D spin_trylock_irqsave(&port->=
lock, flags);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&port->lock, flags);
> +
> + =A0 =A0 =A0 /* save and disable interrupt */
> + =A0 =A0 =A0 imr =3D xuartps_readl(XUARTPS_IMR_OFFSET);
> + =A0 =A0 =A0 xuartps_writel(imr, XUARTPS_IDR_OFFSET);
> +
> + =A0 =A0 =A0 uart_console_write(port, s, count, xuartps_console_putc=
har);
> + =A0 =A0 =A0 xuartps_console_wait_tx(port);
> +
> + =A0 =A0 =A0 /* restore interrupt state, it seems like there may be =
a h/w bug
> + =A0 =A0 =A0 =A0* in that the interrupt enable register should not n=
eed to be
> + =A0 =A0 =A0 =A0* written based on the data sheet
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 xuartps_writel(~imr, XUARTPS_IDR_OFFSET);
> + =A0 =A0 =A0 xuartps_writel(imr, XUARTPS_IER_OFFSET);
> +
> + =A0 =A0 =A0 if (locked)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&port->lock, fla=
gs);
> +}
> +
> +/**
> + * xuartps_console_setup - Initialize the uart to default config
> + * @co: Console handle
> + * @options: Initial settings of uart
> + *
> + * Returns 0, -ENODEV if no device
> + **/
> +static int __init xuartps_console_setup(struct console *co, char *op=
tions)
> +{
> + =A0 =A0 =A0 struct uart_port *port =3D &xuartps_port[co->index];
> + =A0 =A0 =A0 int baud =3D 9600;
> + =A0 =A0 =A0 int bits =3D 8;
> + =A0 =A0 =A0 int parity =3D 'n';
> + =A0 =A0 =A0 int flow =3D 'n';
> +
> + =A0 =A0 =A0 if (co->index < 0 || co->index >=3D XUARTPS_NR_PORTS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 if (!port->mapbase) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("console on ttyPS%i not presen=
t\n", co->index);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (options)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart_parse_options(options, &baud, &par=
ity, &bits, &flow);
> +
> + =A0 =A0 =A0 return uart_set_options(port, co, baud, parity, bits, f=
low);
> +}
> +
> +static struct uart_driver xuartps_uart_driver;
> +
> +static struct console xuartps_console =3D {
> + =A0 =A0 =A0 .name =A0 =3D XUARTPS_TTY_NAME,
> + =A0 =A0 =A0 .write =A0=3D xuartps_console_write,
> + =A0 =A0 =A0 .device =3D uart_console_device,
> + =A0 =A0 =A0 .setup =A0=3D xuartps_console_setup,
> + =A0 =A0 =A0 .flags =A0=3D CON_PRINTBUFFER,
> + =A0 =A0 =A0 .index =A0=3D -1, /* Specified on the cmdline (e.g. con=
sole=3DttyPS ) */
> + =A0 =A0 =A0 .data =A0 =3D &xuartps_uart_driver,
> +};
> +
> +/**
> + * xuartps_console_init - Initialization call
> + *
> + * Returns 0 on success, negative error otherwise
> + **/
> +static int __init xuartps_console_init(void)
> +{
> + =A0 =A0 =A0 register_console(&xuartps_console);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +console_initcall(xuartps_console_init);
> +
> +#endif /* CONFIG_SERIAL_XILINX_PS_UART_CONSOLE */
> +
> +/** Structure Definitions
> + */
> +static struct uart_driver xuartps_uart_driver =3D {
> + =A0 =A0 =A0 .owner =A0 =A0 =A0 =A0 =A0=3D THIS_MODULE, =A0 =A0 =A0 =
=A0 =A0/* Owner */
> + =A0 =A0 =A0 .driver_name =A0 =A0=3D XUARTPS_NAME, =A0 =A0 =A0 =A0 /=
* Driver name */
> + =A0 =A0 =A0 .dev_name =A0 =A0 =A0 =3D XUARTPS_TTY_NAME, =A0 =A0 /* =
Node name */
> + =A0 =A0 =A0 .major =A0 =A0 =A0 =A0 =A0=3D XUARTPS_MAJOR, =A0 =A0 =A0=
 =A0/* Major number */
> + =A0 =A0 =A0 .minor =A0 =A0 =A0 =A0 =A0=3D XUARTPS_MINOR, =A0 =A0 =A0=
 =A0/* Minor number */
> + =A0 =A0 =A0 .nr =A0 =A0 =A0 =A0 =A0 =A0 =3D XUARTPS_NR_PORTS, =A0 =A0=
 /* Number of UART ports */
> +#ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
> + =A0 =A0 =A0 .cons =A0 =A0 =A0 =A0 =A0 =3D &xuartps_console, =A0 =A0=
 /* Console */
> +#endif
> +};
> +
> +/* -----------------------------------------------------------------=
----
> + * Platform bus binding
> + */
> +/**
> + * xuartps_probe - Platform driver probe
> + * @pdev: Pointer to the platform device structure
> + *
> + * Returns 0 on success, negative error otherwise
> + **/
> +static int __devinit xuartps_probe(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 int rc;
> + =A0 =A0 =A0 struct uart_port *port;
> + =A0 =A0 =A0 struct resource *res, *res2;
> + =A0 =A0 =A0 int clk =3D 0;
> +
> +#ifdef CONFIG_OF
> + =A0 =A0 =A0 const unsigned int *prop;
> +
> + =A0 =A0 =A0 prop =3D of_get_property(pdev->dev.of_node, "clock", NU=
LL);
> + =A0 =A0 =A0 if (prop)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk =3D be32_to_cpup(prop);
> +#else
> + =A0 =A0 =A0 clk =3D *((unsigned int *)(pdev->dev.platform_data));
> +#endif
> + =A0 =A0 =A0 if (!clk) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "no clock specified=
\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> + =A0 =A0 =A0 if (!res)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> +
> + =A0 =A0 =A0 res2 =3D platform_get_resource(pdev, IORESOURCE_IRQ, 0)=
;
> + =A0 =A0 =A0 if (!res2)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> +
> + =A0 =A0 =A0 /* Initialize the port structure */
> + =A0 =A0 =A0 port =3D xuartps_get_port();
> +
> + =A0 =A0 =A0 if (!port) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Cannot get uart_po=
rt structure\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Register the port.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* This function also registers this =
device with the tty layer
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* and triggers invocation of the con=
fig_port() entry point.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 port->mapbase =3D res->start;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 port->irq =3D res2->start;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 port->dev =3D &pdev->dev;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 port->uartclk =3D clk;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_set_drvdata(&pdev->dev, port);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D uart_add_one_port(&xuartps_uart_=
driver, port);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (rc) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "ua=
rt_add_one_port() failed; \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 err=3D%i\n", rc);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_set_drvdata(&pdev->=
dev, NULL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return rc;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> +}
> +
> +/**
> + * xuartps_remove - called when the platform driver is unregistered
> + * @pdev: Pointer to the platform device structure
> + *
> + * Returns 0 on success, negative error otherwise
> + **/
> +static int __devexit xuartps_remove(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct uart_port *port =3D dev_get_drvdata(&pdev->dev);
> + =A0 =A0 =A0 int rc =3D 0;
> +
> + =A0 =A0 =A0 /* Remove the xuartps port from the serial core */
> + =A0 =A0 =A0 if (port) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D uart_remove_one_port(&xuartps_ua=
rt_driver, port);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_set_drvdata(&pdev->dev, NULL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 port->mapbase =3D 0;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return rc;
> +}
> +
> +/**
> + * xuartps_suspend - suspend event
> + * @pdev: Pointer to the platform device structure
> + * @state: State of the device
> + *
> + * Returns 0
> + **/
> +static int xuartps_suspend(struct platform_device *pdev, pm_message_=
t state)
> +{
> + =A0 =A0 =A0 /* Call the API provided in serial_core.c file which ha=
ndles
> + =A0 =A0 =A0 =A0* the suspend.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 uart_suspend_port(&xuartps_uart_driver, &xuartps_port[p=
dev->id]);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/**
> + * xuartps_resume - Resume after a previous suspend
> + * @pdev: Pointer to the platform device structure
> + *
> + * Returns 0
> + **/
> +static int xuartps_resume(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 uart_resume_port(&xuartps_uart_driver, &xuartps_port[pd=
ev->id]);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/* Match table for of_platform binding */
> +
> +#ifdef CONFIG_OF
> +static struct of_device_id xuartps_of_match[] __devinitdata =3D {
> + =A0 =A0 =A0 { .compatible =3D "xlnx,xuartps", },
> + =A0 =A0 =A0 {}
> +};
> +MODULE_DEVICE_TABLE(of, xuartps_of_match);
> +#endif
> +
> +static struct platform_driver xuartps_platform_driver =3D {
> + =A0 =A0 =A0 .probe =A0 =3D xuartps_probe, =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 /* Probe method */
> + =A0 =A0 =A0 .remove =A0=3D __exit_p(xuartps_remove), =A0 =A0/* Deta=
ch method */
> + =A0 =A0 =A0 .suspend =3D xuartps_suspend, =A0 =A0 =A0 =A0 =A0 =A0 /=
* Suspend */
> + =A0 =A0 =A0 .resume =A0=3D xuartps_resume, =A0 =A0 =A0 =A0 =A0 =A0 =
=A0/* Resume after a suspend */
> + =A0 =A0 =A0 .driver =A0=3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =3D THIS_MODULE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D XUARTPS_NAME, =A0 =A0 =A0 =A0=
 =A0 /* Driver name */
> +#ifdef CONFIG_OF
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .of_match_table =3D xuartps_of_match,
> +#endif
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> +};
> +
> +
> +/* -----------------------------------------------------------------=
----
> + * Module Init and Exit
> + */
> +/**
> + * xuartps_init - Initial driver registration call
> + *
> + * Returns whether the registration was successful or not
> + **/
> +static int __init xuartps_init(void)
> +{
> + =A0 =A0 =A0 int retval =3D 0;
> +
> + =A0 =A0 =A0 /* Register the xuartps driver with the serial core */
> + =A0 =A0 =A0 retval =3D uart_register_driver(&xuartps_uart_driver);
> + =A0 =A0 =A0 if (retval)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return retval;
> +
> + =A0 =A0 =A0 /* Register the platform driver */
> + =A0 =A0 =A0 retval =3D platform_driver_register(&xuartps_platform_d=
river);
> + =A0 =A0 =A0 if (retval)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart_unregister_driver(&xuartps_uart_dr=
iver);
> +
> + =A0 =A0 =A0 return retval;
> +}
> +
> +/**
> + * xuartps_exit - Driver unregistration call
> + **/
> +static void __exit xuartps_exit(void)
> +{
> + =A0 =A0 =A0 /* The order of unregistration is important. Unregister=
 the
> + =A0 =A0 =A0 =A0* UART driver before the platform driver crashes the=
 system.
> + =A0 =A0 =A0 =A0*/
> +
> + =A0 =A0 =A0 /* Unregister the platform driver */
> + =A0 =A0 =A0 platform_driver_unregister(&xuartps_platform_driver);
> +
> + =A0 =A0 =A0 /* Unregister the xuartps driver */
> + =A0 =A0 =A0 uart_unregister_driver(&xuartps_uart_driver);
> +}
> +
> +module_init(xuartps_init);
> +module_exit(xuartps_exit);
> +
> +MODULE_DESCRIPTION("Driver for PS UART");
> +MODULE_AUTHOR("Xilinx Inc.");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.=
h
> index 758c5b0..95d479b 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -202,6 +202,9 @@
> =A0/* VIA VT8500 SoC */
> =A0#define PORT_VT8500 =A0 =A097
>
> +/* Xilinx PSS UART */
> +#define PORT_XUARTPS =A0 98
> +
> =A0#ifdef __KERNEL__
>
> =A0#include <linux/compiler.h>
> --
> 1.5.4.7
>
>
>
> This email and any attachments are intended for the sole use of the n=
amed recipient(s) and contain(s) confidential information that may be p=
roprietary, privileged or copyrighted under applicable law. If you are =
not the intended recipient, do not read, copy, or forward this email me=
ssage or any attachments. Delete this email message and any attachments=
 immediately.
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
