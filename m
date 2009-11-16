From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH 2/2] Uart driver for ST Microelectronics
	ConneXt(STA2X11/STA2X10).
Date: Mon, 16 Nov 2009 11:55:50 +0530
Message-ID: <ce9ab5790911152225h3b541bf5sf112a7322f28938c@mail.gmail.com>
References: <52CF90264091A14888078A031D780F436EF0F9@ism-mail03.corp.ad.wrs.com>
	<52CF90264091A14888078A031D780F4302F89338@ism-mail03.corp.ad.wrs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <52CF90264091A14888078A031D780F4302F89338@ism-mail03.corp.ad.wrs.com>
Sender: linux-pci-owner@vger.kernel.org
To: "Feng, Xiaobing" <Xiaobing.Feng@windriver.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-pci@vger.kernel.org, giancarlo.asnaghi@st.com, "Wallin, Anders" <Anders.Wallin@windriver.com>, "D'Agostino, Raffaele" <raffaele.dagostino@windriver.com>, "Li, Li" <Li.Li@windriver.com>, "Tang, ChunQiang" <ChunQiang.Tang@windriver.com>
List-Id: linux-serial@vger.kernel.org

This patch has got line-wrapping issue. Please fix that and re-post.

-vimal

On Mon, Nov 16, 2009 at 8:55 AM, Feng, Xiaobing
<Xiaobing.Feng@windriver.com> wrote:
> Hi
> =A0 =A0 =A0 =A0 The patch is a serial driver for PL011 UART base on P=
CI
> express. It was develop for ST Microelectronics's ConneXt board.
> ST Microelectronics ConneXt(STA2X11/STA2X10), a PCI express
> multifunction chip that provides Input/Output capabilities.
> =A0 =A0 =A0 =A0This driver derive from drivers/serial/amba-pl011.c, I=
 added PCI
> express feature and some platform-dependent features in it, which mak=
e
> it support PL011 on ConneXt as a PCI express device.
> =A0 =A0 =A0 =A0The patch has been checked by scripts/checkpatch.pl .
>
>
>
> From a567d7644d15b4eb0ae511f4e02307e62be127c9 Mon Sep 17 00:00:00 200=
1
> From: Billy <billy@billy-laptop.(none)>
> Date: Fri, 13 Nov 2009 18:17:04 +0800
> Subject: [PATCH] Add pl011 uart support for STMICRO's ConneXt, which
> base on PCI and derive from Amba-pl011.c
>
> Signed-off-by: XiaoBing Feng (Billy Feng) <xiaobing.feng@windriver.co=
m>
> Acked-by: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>
> ---
> =A0drivers/serial/Kconfig =A0 =A0 | =A0 10 +
> =A0drivers/serial/Makefile =A0 =A0| =A0 =A01 +
> =A0drivers/serial/pl011-pci.c | =A0949
> ++++++++++++++++++++++++++++++++++++++++++++
> =A03 files changed, 960 insertions(+), 0 deletions(-)
> =A0create mode 100644 drivers/serial/pl011-pci.c
>
> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
> index 6553833..c42c402 100644
> --- a/drivers/serial/Kconfig
> +++ b/drivers/serial/Kconfig
> @@ -331,6 +331,16 @@ config SERIAL_AMBA_PL011_CONSOLE
> =A0 =A0 =A0 =A0 =A0your boot loader (lilo or loadlin) about how to pa=
ss options
> to the
> =A0 =A0 =A0 =A0 =A0kernel at boot time.)
>
> +config SERIAL_PCI_PL011
> + =A0 =A0 =A0 tristate "PL011 serial port based on PCI support"
> + =A0 =A0 =A0 depends on PCI
> + =A0 =A0 =A0 select SERIAL_CORE
> +
> +config SERIAL_PCI_PL011_CONSOLE
> + =A0 =A0 =A0 bool "Support for console on PL011 serial port based on=
 PCI"
> + =A0 =A0 =A0 depends on SERIAL_PCI_PL011=3Dy
> + =A0 =A0 =A0 select SERIAL_CORE_CONSOLE
> +
> =A0config SERIAL_SB1250_DUART
> =A0 =A0 =A0 =A0tristate "BCM1xxx on-chip DUART serial support"
> =A0 =A0 =A0 =A0depends on SIBYTE_SB1xxx_SOC=3Dy
> diff --git a/drivers/serial/Makefile b/drivers/serial/Makefile
> index d5a2998..e8e5cfd 100644
> --- a/drivers/serial/Makefile
> +++ b/drivers/serial/Makefile
> @@ -30,6 +30,7 @@ obj-$(CONFIG_SERIAL_8250_HUB6) +=3D 8250_hub6.o
> =A0obj-$(CONFIG_SERIAL_8250_MCA) +=3D 8250_mca.o
> =A0obj-$(CONFIG_SERIAL_AMBA_PL010) +=3D amba-pl010.o
> =A0obj-$(CONFIG_SERIAL_AMBA_PL011) +=3D amba-pl011.o
> +obj-$(CONFIG_SERIAL_PCI_PL011) +=3D pl011-pci.o
> =A0obj-$(CONFIG_SERIAL_CLPS711X) +=3D clps711x.o
> =A0obj-$(CONFIG_SERIAL_PXA) +=3D pxa.o
> =A0obj-$(CONFIG_SERIAL_PNX8XXX) +=3D pnx8xxx_uart.o
> diff --git a/drivers/serial/pl011-pci.c b/drivers/serial/pl011-pci.c
> new file mode 100644
> index 0000000..6783b0d
> --- /dev/null
> +++ b/drivers/serial/pl011-pci.c
> @@ -0,0 +1,949 @@
> +/*
> +* linux/drivers/serial/pl011-pci.c
> +*
> +* ST Microelectronics ConneXt(STA2X11/STA2X10) UART file
> +* derive from AMBA-pl011.c
> +*
> +* Copyright (c) 2009 Wind River Systems, Inc.
> +*
> +* This program is free software; you can redistribute it and/or modi=
fy
> +* it under the terms of the GNU General Public License version 2 as
> +* published by the Free Software Foundation.
> +*
> +* This program is distributed in the hope that it will be useful,
> +* but WITHOUT ANY WARRANTY; without even the implied warranty of
> +* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> +* See the GNU General Public License for more details.
> +*
> +* You should have received a copy of the GNU General Public License
> +* along with this program; if not, write to the Free Software
> +* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-130=
7
> USA
> +*
> +*/
> +#include <linux/moduleparam.h>
> +#include <linux/pci.h>
> +#include <linux/module.h>
> +#include <linux/ioport.h>
> +#include <linux/init.h>
> +#include <linux/console.h>
> +#include <linux/sysrq.h>
> +#include <linux/device.h>
> +#include <linux/tty.h>
> +#include <linux/tty_flip.h>
> +#include <linux/serial_core.h>
> +#include <linux/serial.h>
> +#include <linux/amba/bus.h>
> +#include <linux/amba/serial.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +
> +
> +#if defined(CONFIG_SERIAL_PCI_PL011_CONSOLE) &&
> defined(CONFIG_MAGIC_SYSRQ)
> +#define SUPPORT_SYSRQ
> +#endif
> +
> +#define DRV_VERSION =A0 =A0"1.0.0"
> +#define PCI_PL011_DRIVER_NAME "ttyAM"
> +#define PCI_PL011_MAJOR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0204
> +#define PCI_PL011_MINOR_START =A016
> +#define MAXPORTS =A0 =A0 =A0 =A0 =A0 =A0 =A0 1
> +#define UART_NR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A04
> +#define PL011_HWFC =A0 =A0 =A0 =A0 =A0 =A0 1
> +#define PL011_NO_HWFC =A0 =A0 =A0 =A0 =A02
> +#define AMBA_ISR_PASS_LIMIT =A0 =A0256
> +#define UARTCLK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A032000=
000
> +
> +#define UART_DR_ERROR =A0\
> + =A0 =A0 =A0 (UART011_DR_OE|UART011_DR_BE|UART011_DR_PE|UART011_DR_F=
E)
> +
> +#define UART_DUMMY_DR_RX =A0 =A0 =A0 (1 << 16)
> +#define SZ_4K =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x=
00001000
> +
> +static LIST_HEAD(pci_pl011_adapter_head);
> +/**
> + * We wrap our port structure around the generic uart_port.
> + */
> +struct uart_amba_port {
> + =A0 =A0 =A0 struct uart_port =A0 =A0 =A0 =A0port;
> + =A0 =A0 =A0 struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0*clk;
> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0im; =A0 =A0 /** int=
errupt mask */
> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0old_status;
> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0ifls; =A0 /** vendo=
r-specific */
> +};
> +
> +struct pci_pl011_adapter{
> +
> + =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0rev; =A0 =A0 =A0 =A0 =A0 =
=A0/** PCI revision ID */
> + =A0 =A0 =A0 struct pci_dev =A0*pci_dev;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 type;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 index;
> +
> + =A0 =A0 =A0 spinlock_t =A0 =A0 =A0intr_lock;
> +
> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 irq; =A0 =A0 =A0 =A0 =A0 =A0=
/** Interrupt request number */
> + =A0 =A0 =A0 u64 =A0 =A0 =A0 =A0 =A0 =A0 intr_count; =A0 =A0 /** Cou=
nt of interrupts */
> +
> + =A0 =A0 =A0 u64 =A0 =A0 =A0 =A0 =A0 =A0 membase; =A0 =A0 =A0 =A0/**=
 Start of base memory */
> + =A0 =A0 =A0 u64 =A0 =A0 =A0 =A0 =A0 =A0 membase_end; =A0 =A0/** End=
 of base memory */
> +
> + =A0 =A0 =A0 u8 =A0 =A0 =A0__iomem *re_map_membase;/** Remapped memo=
ry */
> +
> + =A0 =A0 =A0 u64 =A0 =A0 =A0 =A0 =A0 =A0 iobase; =A0 =A0 =A0 =A0 /**=
 Start of io base */
> + =A0 =A0 =A0 u64 =A0 =A0 =A0 =A0 =A0 =A0 iobase_end; =A0 =A0 /** End=
 of io base */
> +
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 numb_ports;
> + =A0 =A0 =A0 struct uart_amba_port port_info[MAXPORTS];
> + =A0 =A0 =A0 struct list_head pci_pl011_adapter_entry;
> +};
> +
> +
> +
> +/** There is by now at least one vendor with differing details, so
> handle it */
> +struct vendor_data {
> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0ifls;
> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0fifosize;
> +};
> +
> +static struct vendor_data vendor_st =3D {
> + =A0 =A0 =A0 .ifls =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D
> UART011_IFLS_RX_HALF|UART011_IFLS_TX_HALF,
> + =A0 =A0 =A0 .fifosize =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 64,
> +};
> +
> +static void pl011_stop_tx(struct uart_port *port)
> +{
> + =A0 =A0 =A0 struct uart_amba_port *uap =3D (struct uart_amba_port *=
)port;
> +
> + =A0 =A0 =A0 uap->im &=3D ~UART011_TXIM;
> + =A0 =A0 =A0 writel(uap->im, uap->port.membase + UART011_IMSC);
> +}
> +
> +static void pl011_start_tx(struct uart_port *port)
> +{
> + =A0 =A0 =A0 struct uart_amba_port *uap =3D (struct uart_amba_port *=
)port;
> +
> + =A0 =A0 =A0 uap->im |=3D UART011_TXIM;
> + =A0 =A0 =A0 writel(uap->im, uap->port.membase + UART011_IMSC);
> +}
> +
> +static void pl011_stop_rx(struct uart_port *port)
> +{
> + =A0 =A0 =A0 struct uart_amba_port *uap =3D (struct uart_amba_port *=
)port;
> +
> + =A0 =A0 =A0 uap->im &=3D ~(UART011_RXIM|UART011_RTIM|UART011_FEIM|
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0UART011_PEIM|UART011_BEIM|UA=
RT011_OEIM);
> + =A0 =A0 =A0 writel(uap->im, uap->port.membase + UART011_IMSC);
> +}
> +
> +static void pl011_enable_ms(struct uart_port *port)
> +{
> + =A0 =A0 =A0 struct uart_amba_port *uap =3D (struct uart_amba_port *=
)port;
> +
> + =A0 =A0 =A0 uap->im |=3D
> UART011_RIMIM|UART011_CTSMIM|UART011_DCDMIM|UART011_DSRMIM;
> + =A0 =A0 =A0 writel(uap->im, uap->port.membase + UART011_IMSC);
> +}
> +
> +static void pl011_rx_chars(struct uart_amba_port *uap)
> +{
> + =A0 =A0 =A0 struct tty_struct *tty =3D uap->port.state->port.tty;
> + =A0 =A0 =A0 unsigned int status, ch, flag, max_count =3D 256;
> +
> + =A0 =A0 =A0 status =3D readl(uap->port.membase + UART01x_FR);
> + =A0 =A0 =A0 while ((status & UART01x_FR_RXFE) =3D=3D 0 && max_count=
--) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ch =3D readl(uap->port.membase + UART01=
x_DR) |
> UART_DUMMY_DR_RX;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 flag =3D TTY_NORMAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uap->port.icount.rx++;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /**
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Note that the error handling code =
is
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* out of the main execution path
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (unlikely(ch & UART_DR_ERROR)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ch & UART011_DR_BE)=
 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ch &=3D=
 ~(UART011_DR_FE | UART011_DR_PE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 uap->po=
rt.icount.brk++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (uar=
t_handle_break(&uap->port))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 goto ignore_char;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (ch & UART011=
_DR_PE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 uap->po=
rt.icount.parity++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (ch & UART011_D=
R_FE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 uap->po=
rt.icount.frame++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ch & UART011_DR_OE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 uap->po=
rt.icount.overrun++;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ch &=3D uap->port.read_=
status_mask;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ch & UART011_DR_BE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flag =3D=
 TTY_BREAK;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (ch & UART011_D=
R_PE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flag =3D=
 TTY_PARITY;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (ch & UART011_D=
R_FE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flag =3D=
 TTY_FRAME;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (uart_handle_sysrq_char(&uap->port, =
ch & 255))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto ignore_char;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart_insert_char(&uap->port, ch, UART01=
1_DR_OE, ch,
> flag);
> +
> +ignore_char:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D readl(uap->port.membase + UA=
RT01x_FR);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 spin_unlock(&uap->port.lock);
> + =A0 =A0 =A0 tty_flip_buffer_push(tty);
> + =A0 =A0 =A0 spin_lock(&uap->port.lock);
> +}
> +
> +static void pl011_tx_chars(struct uart_amba_port *uap)
> +{
> + =A0 =A0 =A0 struct circ_buf *xmit =3D &uap->port.state->xmit;
> + =A0 =A0 =A0 int count;
> +
> + =A0 =A0 =A0 if (uap->port.x_char) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writel(uap->port.x_char, uap->port.memb=
ase +
> UART01x_DR);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uap->port.icount.tx++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uap->port.x_char =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (uart_circ_empty(xmit) || uart_tx_stopped(&uap->port=
)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pl011_stop_tx(&uap->port);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 count =3D uap->port.fifosize >> 1;
> + =A0 =A0 =A0 do {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writel(xmit->buf[xmit->tail], uap->port=
=2Emembase +
> UART01x_DR);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xmit->tail =3D (xmit->tail + 1) & (UART=
_XMIT_SIZE - 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uap->port.icount.tx++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (uart_circ_empty(xmit))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 } while (--count > 0);
> +
> + =A0 =A0 =A0 if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart_write_wakeup(&uap->port);
> +
> + =A0 =A0 =A0 if (uart_circ_empty(xmit))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pl011_stop_tx(&uap->port);
> +}
> +
> +static void pl011_modem_status(struct uart_amba_port *uap)
> +{
> + =A0 =A0 =A0 unsigned int status, delta;
> +
> + =A0 =A0 =A0 status =3D readl(uap->port.membase + UART01x_FR) &
> UART01x_FR_MODEM_ANY;
> +
> + =A0 =A0 =A0 delta =3D status ^ uap->old_status;
> + =A0 =A0 =A0 uap->old_status =3D status;
> +
> + =A0 =A0 =A0 if (!delta)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 if (delta & UART01x_FR_DCD)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart_handle_dcd_change(&uap->port, stat=
us &
> UART01x_FR_DCD);
> +
> + =A0 =A0 =A0 if (delta & UART01x_FR_DSR)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uap->port.icount.dsr++;
> +
> + =A0 =A0 =A0 if (delta & UART01x_FR_CTS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart_handle_cts_change(&uap->port, stat=
us &
> UART01x_FR_CTS);
> +
> + =A0 =A0 =A0 wake_up_interruptible(&uap->port.state->port.delta_msr_=
wait);
> +}
> +
> +static irqreturn_t pl011_int(int irq, void *dev_id)
> +{
> + =A0 =A0 =A0 struct uart_amba_port *uap =3D dev_id;
> + =A0 =A0 =A0 unsigned int status, pass_counter =3D AMBA_ISR_PASS_LIM=
IT;
> + =A0 =A0 =A0 int handled =3D 0;
> +
> + =A0 =A0 =A0 spin_lock(&uap->port.lock);
> +
> + =A0 =A0 =A0 status =3D readl(uap->port.membase + UART011_MIS);
> + =A0 =A0 =A0 if (status) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 do {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 writel(status & ~(UART0=
11_TXIS|UART011_RTIS|
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 UART011_RXIS),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uap->por=
t.membase + UART011_ICR);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (status & (UART011_R=
TIS|UART011_RXIS))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pl011_r=
x_chars(uap);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (status & (UART011_D=
SRMIS|UART011_DCDMIS|
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 UART011_CTSMIS|UART011_RIMIS))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pl011_m=
odem_status(uap);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (status & UART011_TX=
IS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pl011_t=
x_chars(uap);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pass_counter-- =3D=3D=
 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D readl(uap->p=
ort.membase + UART011_MIS);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } while (status !=3D 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 handled =3D 1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 spin_unlock(&uap->port.lock);
> +
> + =A0 =A0 =A0 return IRQ_RETVAL(handled);
> +}
> +
> +static unsigned int pl011_tx_empty(struct uart_port *port)
> +{
> + =A0 =A0 =A0 struct uart_amba_port *uap =3D (struct uart_amba_port *=
)port;
> + =A0 =A0 =A0 unsigned int status =3D readl(uap->port.membase + UART0=
1x_FR);
> + =A0 =A0 =A0 return status & (UART01x_FR_BUSY|UART01x_FR_TXFF) ? 0 :
> TIOCSER_TEMT;
> +}
> +
> +static unsigned int pl011_get_mctrl(struct uart_port *port)
> +{
> + =A0 =A0 =A0 struct uart_amba_port *uap =3D (struct uart_amba_port *=
)port;
> + =A0 =A0 =A0 unsigned int result =3D 0;
> + =A0 =A0 =A0 unsigned int status =3D readl(uap->port.membase + UART0=
1x_FR);
> +
> +#define TIOCMBIT(uartbit, tiocmbit) =A0 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 { =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (status & uartbit) =A0 =A0 =A0 =A0 =A0=
 \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 result |=3D tiocmbit; =A0=
 =A0 \
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 TIOCMBIT(UART01x_FR_DCD, TIOCM_CAR)
> + =A0 =A0 =A0 TIOCMBIT(UART01x_FR_DSR, TIOCM_DSR)
> + =A0 =A0 =A0 TIOCMBIT(UART01x_FR_CTS, TIOCM_CTS)
> + =A0 =A0 =A0 TIOCMBIT(UART011_FR_RI, TIOCM_RNG)
> +#undef TIOCMBIT
> + =A0 =A0 =A0 return result;
> +}
> +
> +static void pl011_set_mctrl(struct uart_port *port, unsigned int mct=
rl)
> +{
> + =A0 =A0 =A0 struct uart_amba_port *uap =3D (struct uart_amba_port *=
)port;
> + =A0 =A0 =A0 unsigned int cr;
> +
> + =A0 =A0 =A0 cr =3D readl(uap->port.membase + UART011_CR);
> +
> +#define =A0 =A0 =A0 =A0TIOCMBIT(tiocmbit, uartbit) =A0 =A0 =A0 =A0 =A0=
 =A0 \
> + =A0 =A0 =A0 do { =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mctrl & tiocmbit) =A0 =A0 =A0 =A0 =A0=
 \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cr |=3D uartbit; =A0 =A0=
 =A0 =A0 =A0\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cr &=3D ~uartbit; =A0 =A0=
 =A0 =A0 \
> + =A0 =A0 =A0 } while (0)
> +
> + =A0 =A0 =A0 TIOCMBIT(TIOCM_RTS, UART011_CR_RTS);
> + =A0 =A0 =A0 TIOCMBIT(TIOCM_DTR, UART011_CR_DTR);
> + =A0 =A0 =A0 TIOCMBIT(TIOCM_OUT1, UART011_CR_OUT1);
> + =A0 =A0 =A0 TIOCMBIT(TIOCM_OUT2, UART011_CR_OUT2);
> + =A0 =A0 =A0 TIOCMBIT(TIOCM_LOOP, UART011_CR_LBE);
> +#undef TIOCMBIT
> +
> + =A0 =A0 =A0 writel(cr, uap->port.membase + UART011_CR);
> +}
> +
> +static void pl011_break_ctl(struct uart_port *port, int break_state)
> +{
> + =A0 =A0 =A0 struct uart_amba_port *uap =3D (struct uart_amba_port *=
)port;
> + =A0 =A0 =A0 unsigned long flags;
> + =A0 =A0 =A0 unsigned int lcr_h;
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&uap->port.lock, flags);
> + =A0 =A0 =A0 lcr_h =3D readl(uap->port.membase + UART011_LCRH);
> + =A0 =A0 =A0 if (break_state =3D=3D -1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 lcr_h |=3D UART01x_LCRH_BRK;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 lcr_h &=3D ~UART01x_LCRH_BRK;
> + =A0 =A0 =A0 writel(lcr_h, uap->port.membase + UART011_LCRH);
> + =A0 =A0 =A0 spin_unlock_irqrestore(&uap->port.lock, flags);
> +}
> +
> +#ifdef CONFIG_CONSOLE_POLL
> +static int pl011_get_poll_char(struct uart_port *port)
> +{
> + =A0 =A0 =A0 struct uart_amba_port *uap =3D (struct uart_amba_port *=
)port;
> + =A0 =A0 =A0 unsigned int status;
> +
> + =A0 =A0 =A0 do {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D readl(uap->port.membase + UA=
RT01x_FR);
> + =A0 =A0 =A0 } while (status & UART01x_FR_RXFE);
> +
> + =A0 =A0 =A0 return readl(uap->port.membase + UART01x_DR);
> +}
> +
> +static void pl011_put_poll_char(struct uart_port *port,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned char ch)
> +{
> + =A0 =A0 =A0 struct uart_amba_port *uap =3D (struct uart_amba_port *=
)port;
> +
> + =A0 =A0 =A0 while (readl(uap->port.membase + UART01x_FR) & UART01x_=
=46R_TXFF)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 barrier();
> +
> + =A0 =A0 =A0 writel(ch, uap->port.membase + UART01x_DR);
> +}
> +
> +#endif /** CONFIG_CONSOLE_POLL */
> +
> +static int pl011_startup(struct uart_port *port)
> +{
> + =A0 =A0 =A0 struct uart_amba_port *uap =3D (struct uart_amba_port *=
)port;
> + =A0 =A0 =A0 unsigned int cr;
> + =A0 =A0 =A0 int retval;
> +
> + =A0 =A0 =A0 uap->port.uartclk =3D UARTCLK;
> + =A0 =A0 =A0 /**
> + =A0 =A0 =A0 =A0* Allocate the IRQ
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 retval =3D request_irq(uap->port.irq, pl011_int,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 IRQF_DISABLED | IRQF_SHARED, "uart-pl01=
1", uap);
> + =A0 =A0 =A0 if (retval)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> +
> + =A0 =A0 =A0 writel(uap->ifls, uap->port.membase + UART011_IFLS);
> +
> + =A0 =A0 =A0 /**
> + =A0 =A0 =A0 =A0* Provoke TX FIFO interrupt into asserting.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 cr =3D UART01x_CR_UARTEN | UART011_CR_TXE | UART011_CR_=
LBE;
> + =A0 =A0 =A0 writel(cr, uap->port.membase + UART011_CR);
> + =A0 =A0 =A0 writel(0, uap->port.membase + UART011_FBRD);
> + =A0 =A0 =A0 writel(1, uap->port.membase + UART011_IBRD);
> + =A0 =A0 =A0 writel(0, uap->port.membase + UART011_LCRH);
> + =A0 =A0 =A0 writel(0, uap->port.membase + UART01x_DR);
> + =A0 =A0 =A0 while (readl(uap->port.membase + UART01x_FR) & UART01x_=
=46R_BUSY)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 barrier();
> +
> + =A0 =A0 =A0 cr =3D UART01x_CR_UARTEN | UART011_CR_RXE | UART011_CR_=
TXE;
> + =A0 =A0 =A0 writel(cr, uap->port.membase + UART011_CR);
> +
> + =A0 =A0 =A0 /**
> + =A0 =A0 =A0 =A0* initialise the old status of the modem signals
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 uap->old_status =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 readl(uap->port.membase + UART01x_FR) &
> UART01x_FR_MODEM_ANY;
> +
> + =A0 =A0 =A0 /**
> + =A0 =A0 =A0 =A0* Finally, enable interrupts
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 spin_lock_irq(&uap->port.lock);
> + =A0 =A0 =A0 uap->im =3D UART011_RXIM | UART011_RTIM;
> + =A0 =A0 =A0 writel(uap->im, uap->port.membase + UART011_IMSC);
> + =A0 =A0 =A0 spin_unlock_irq(&uap->port.lock);
> +
> + =A0 =A0 =A0 return 0;
> +
> + out:
> + =A0 =A0 =A0 return retval;
> +}
> +
> +static void pl011_shutdown(struct uart_port *port)
> +{
> + =A0 =A0 =A0 struct uart_amba_port *uap =3D (struct uart_amba_port *=
)port;
> + =A0 =A0 =A0 unsigned long val;
> +
> + =A0 =A0 =A0 /**
> + =A0 =A0 =A0 =A0* disable all interrupts
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 spin_lock_irq(&uap->port.lock);
> + =A0 =A0 =A0 uap->im =3D 0;
> + =A0 =A0 =A0 writel(uap->im, uap->port.membase + UART011_IMSC);
> + =A0 =A0 =A0 writel(0xffff, uap->port.membase + UART011_ICR);
> + =A0 =A0 =A0 spin_unlock_irq(&uap->port.lock);
> +
> + =A0 =A0 =A0 /**
> + =A0 =A0 =A0 =A0* Free the interrupt
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 free_irq(uap->port.irq, uap);
> +
> + =A0 =A0 =A0 /**
> + =A0 =A0 =A0 =A0* disable the port
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 writel(UART01x_CR_UARTEN |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 UART011_CR_TXE, uap->port.membase + UAR=
T011_CR);
> +
> + =A0 =A0 =A0 /**
> + =A0 =A0 =A0 =A0* disable break condition and fifos
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 val =3D readl(uap->port.membase + UART011_LCRH);
> + =A0 =A0 =A0 val &=3D ~(UART01x_LCRH_BRK | UART01x_LCRH_FEN);
> + =A0 =A0 =A0 writel(val, uap->port.membase + UART011_LCRH);
> +}
> +
> +static void
> +pl011_set_termios(struct uart_port *port, struct ktermios *termios,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct ktermios *old)
> +{
> + =A0 =A0 =A0 unsigned int lcr_h, old_cr;
> + =A0 =A0 =A0 unsigned long flags;
> + =A0 =A0 =A0 unsigned int baud, quot;
> +
> + =A0 =A0 =A0 /**
> + =A0 =A0 =A0 =A0* Ask the core to calculate the divisor for us.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 baud =3D uart_get_baud_rate(port, termios, old, 0,
> port->uartclk/16);
> + =A0 =A0 =A0 quot =3D port->uartclk * 4 / baud;
> +
> + =A0 =A0 =A0 switch (termios->c_cflag & CSIZE) {
> + =A0 =A0 =A0 case CS5:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 lcr_h =3D UART01x_LCRH_WLEN_5;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case CS6:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 lcr_h =3D UART01x_LCRH_WLEN_6;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case CS7:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 lcr_h =3D UART01x_LCRH_WLEN_7;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 lcr_h =3D UART01x_LCRH_WLEN_8;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (termios->c_cflag & CSTOPB)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 lcr_h |=3D UART01x_LCRH_STP2;
> + =A0 =A0 =A0 if (termios->c_cflag & PARENB) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 lcr_h |=3D UART01x_LCRH_PEN;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(termios->c_cflag & PARODD))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lcr_h |=3D UART01x_LCRH=
_EPS;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 /** Enable hardware flow control*/
> + =A0 =A0 =A0 if (termios->c_cflag & CRTSCTS) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (*(int *)(port->private_data) =3D=3D=
 PL011_HWFC) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lcr_h |=3D UART011_CR_C=
TSEN;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lcr_h |=3D UART011_CR_R=
TSEN;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (port->fifosize > 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 lcr_h |=3D UART01x_LCRH_FEN;
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&port->lock, flags);
> +
> + =A0 =A0 =A0 /**
> + =A0 =A0 =A0 =A0* Update the per-port timeout.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 uart_update_timeout(port, termios->c_cflag, baud);
> +
> + =A0 =A0 =A0 port->read_status_mask =3D UART011_DR_OE | 255;
> + =A0 =A0 =A0 if (termios->c_iflag & INPCK)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 port->read_status_mask |=3D UART011_DR_=
=46E | UART011_DR_PE;
> + =A0 =A0 =A0 if (termios->c_iflag & (BRKINT | PARMRK))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 port->read_status_mask |=3D UART011_DR_=
BE;
> +
> + =A0 =A0 =A0 /**
> + =A0 =A0 =A0 =A0* Characters to ignore
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 port->ignore_status_mask =3D 0;
> + =A0 =A0 =A0 if (termios->c_iflag & IGNPAR)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 port->ignore_status_mask |=3D UART011_D=
R_FE |
> UART011_DR_PE;
> + =A0 =A0 =A0 if (termios->c_iflag & IGNBRK) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 port->ignore_status_mask |=3D UART011_D=
R_BE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /**
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* If we're ignoring parity and break=
 indicators,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* ignore overruns too (for real raw =
support).
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (termios->c_iflag & IGNPAR)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 port->ignore_status_mas=
k |=3D UART011_DR_OE;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /**
> + =A0 =A0 =A0 =A0* Ignore all characters if CREAD is not set.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if ((termios->c_cflag & CREAD) =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 port->ignore_status_mask |=3D UART_DUMM=
Y_DR_RX;
> +
> + =A0 =A0 =A0 if (UART_ENABLE_MS(port, termios->c_cflag))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pl011_enable_ms(port);
> +
> + =A0 =A0 =A0 /** first, disable everything */
> + =A0 =A0 =A0 old_cr =3D readl(port->membase + UART011_CR);
> + =A0 =A0 =A0 writel(0, port->membase + UART011_CR);
> +
> + =A0 =A0 =A0 /** Set baud rate */
> + =A0 =A0 =A0 writel(quot & 0x3f, port->membase + UART011_FBRD);
> + =A0 =A0 =A0 writel(quot >> 6, port->membase + UART011_IBRD);
> +
> + =A0 =A0 =A0 /**
> + =A0 =A0 =A0 =A0* ----------v----------v----------v----------v-----
> + =A0 =A0 =A0 =A0* NOTE: MUST BE WRITTEN AFTER UARTLCR_M & UARTLCR_L
> + =A0 =A0 =A0 =A0* ----------^----------^----------^----------^-----
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 writel(lcr_h, port->membase + UART011_LCRH);
> + =A0 =A0 =A0 writel(lcr_h, port->membase + 0x1c);
> + =A0 =A0 =A0 writel(old_cr, port->membase + UART011_CR);
> +
> + =A0 =A0 =A0 spin_unlock_irqrestore(&port->lock, flags);
> +}
> +
> +static const char *pl011_type(struct uart_port *port)
> +{
> + =A0 =A0 =A0 return port->type =3D=3D PORT_AMBA ? "AMBA/PL011" : NUL=
L;
> +}
> +
> +/**
> + * Release the memory region(s) being used by 'port'
> + */
> +static void pl011_release_port(struct uart_port *port)
> +{
> + =A0 =A0 =A0 release_mem_region(port->mapbase, SZ_4K);
> +}
> +
> +/**
> + * Request the memory region(s) being used by 'port'
> + */
> +static int pl011_request_port(struct uart_port *port)
> +{
> + =A0 =A0 =A0 return request_mem_region(port->mapbase, SZ_4K, "uart-p=
l011")
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !=3D NULL ? 0 : -EBUSY;
> +}
> +
> +/**
> + * Configure/autoconfigure the port.
> + */
> +static void pl011_config_port(struct uart_port *port, int flags)
> +{
> + =A0 =A0 =A0 if (flags & UART_CONFIG_TYPE) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 port->type =3D PORT_AMBA;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pl011_request_port(port);
> + =A0 =A0 =A0 }
> +}
> +
> +/**
> + * verify the new serial_struct (for TIOCSSERIAL).
> + */
> +static int pl011_verify_port(struct uart_port *port, struct
> serial_struct *ser)
> +{
> + =A0 =A0 =A0 int ret =3D 0;
> + =A0 =A0 =A0 if (ser->type !=3D PORT_UNKNOWN && ser->type !=3D PORT_=
AMBA)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> + =A0 =A0 =A0 if (ser->irq < 0 || ser->irq >=3D nr_irqs)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> + =A0 =A0 =A0 if (ser->baud_base < 9600)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static struct uart_ops pci_pl011_pops =3D {
> + =A0 =A0 =A0 .tx_empty =A0 =A0 =A0 =3D pl011_tx_empty,
> + =A0 =A0 =A0 .set_mctrl =A0 =A0 =A0=3D pl011_set_mctrl,
> + =A0 =A0 =A0 .get_mctrl =A0 =A0 =A0=3D pl011_get_mctrl,
> + =A0 =A0 =A0 .stop_tx =A0 =A0 =A0 =A0=3D pl011_stop_tx,
> + =A0 =A0 =A0 .start_tx =A0 =A0 =A0 =3D pl011_start_tx,
> + =A0 =A0 =A0 .stop_rx =A0 =A0 =A0 =A0=3D pl011_stop_rx,
> + =A0 =A0 =A0 .enable_ms =A0 =A0 =A0=3D pl011_enable_ms,
> + =A0 =A0 =A0 .break_ctl =A0 =A0 =A0=3D pl011_break_ctl,
> + =A0 =A0 =A0 .startup =A0 =A0 =A0 =A0=3D pl011_startup,
> + =A0 =A0 =A0 .shutdown =A0 =A0 =A0 =3D pl011_shutdown,
> + =A0 =A0 =A0 .set_termios =A0 =A0=3D pl011_set_termios,
> + =A0 =A0 =A0 .type =A0 =A0 =A0 =A0 =A0 =3D pl011_type,
> + =A0 =A0 =A0 .release_port =A0 =3D pl011_release_port,
> + =A0 =A0 =A0 .request_port =A0 =3D pl011_request_port,
> + =A0 =A0 =A0 .config_port =A0 =A0=3D pl011_config_port,
> + =A0 =A0 =A0 .verify_port =A0 =A0=3D pl011_verify_port,
> +#ifdef CONFIG_CONSOLE_POLL
> + =A0 =A0 =A0 .poll_get_char =3D pl011_get_poll_char,
> + =A0 =A0 =A0 .poll_put_char =3D pl011_put_poll_char,
> +#endif
> +};
> +
> +static struct uart_amba_port *amba_ports[UART_NR];
> +
> +#ifdef CONFIG_SERIAL_PCI_PL011_CONSOLE
> +
> +static void pl011_console_putchar(struct uart_port *port, int ch)
> +{
> + =A0 =A0 =A0 struct uart_amba_port *uap =3D (struct uart_amba_port *=
)port;
> +
> + =A0 =A0 =A0 while (readl(uap->port.membase + UART01x_FR) & UART01x_=
=46R_TXFF)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 barrier();
> + =A0 =A0 =A0 writel(ch, uap->port.membase + UART01x_DR);
> +}
> +
> +static void
> +pl011_console_write(struct console *co, const char *s, unsigned int
> count)
> +{
> + =A0 =A0 =A0 struct uart_amba_port *uap =3D amba_ports[co->index];
> + =A0 =A0 =A0 unsigned int status, old_cr, new_cr;
> + =A0 =A0 =A0 /**
> + =A0 =A0 =A0 =A0* =A0 =A0 =A0First save the CR then disable the inte=
rrupts
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 old_cr =3D readl(uap->port.membase + UART011_CR);
> + =A0 =A0 =A0 new_cr =3D old_cr & ~UART011_CR_CTSEN;
> + =A0 =A0 =A0 new_cr |=3D UART01x_CR_UARTEN | UART011_CR_TXE;
> + =A0 =A0 =A0 writel(new_cr, uap->port.membase + UART011_CR);
> +
> + =A0 =A0 =A0 uart_console_write(&uap->port, s, count, pl011_console_=
putchar);
> +
> + =A0 =A0 =A0 /**
> + =A0 =A0 =A0 =A0* =A0 =A0 =A0Finally, wait for transmitter to become=
 empty
> + =A0 =A0 =A0 =A0* =A0 =A0 =A0and restore the TCR
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 do {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D readl(uap->port.membase + UA=
RT01x_FR);
> + =A0 =A0 =A0 } while (status & UART01x_FR_BUSY);
> + =A0 =A0 =A0 writel(old_cr, uap->port.membase + UART011_CR);
> +}
> +
> +static void __init
> +pl011_console_get_options(struct uart_amba_port *uap, int *baud,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int *parity,=
 int *bits)
> +{
> + =A0 =A0 =A0 if (readl(uap->port.membase + UART011_CR) & UART01x_CR_=
UARTEN) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int lcr_h, iadapter, fadapter;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 lcr_h =3D readl(uap->port.membase + UAR=
T011_LCRH);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *parity =3D 'n';
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (lcr_h & UART01x_LCRH_PEN) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (lcr_h & UART01x_LCR=
H_EPS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *parity=
 =3D 'e';
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *parity=
 =3D 'o';
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((lcr_h & 0x60) =3D=3D UART01x_LCRH_=
WLEN_7)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *bits =3D 7;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *bits =3D 8;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iadapter =3D readl(uap->port.membase + =
UART011_IBRD);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fadapter =3D readl(uap->port.membase + =
UART011_FBRD);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *baud =3D uap->port.uartclk * 4 / (64 *=
 iadapter +
> fadapter);
> + =A0 =A0 =A0 }
> +}
> +
> +static int __init pl011_console_setup(struct console *co, char
> *options)
> +{
> + =A0 =A0 =A0 struct uart_amba_port *uap;
> + =A0 =A0 =A0 int baud =3D 38400;
> + =A0 =A0 =A0 int bits =3D 8;
> + =A0 =A0 =A0 int parity =3D 'n';
> + =A0 =A0 =A0 int flow =3D 'n';
> +
> + =A0 =A0 =A0 /**
> + =A0 =A0 =A0 =A0* Check whether an invalid uart number has been spec=
ified, and
> + =A0 =A0 =A0 =A0* if so, search for the first available port that do=
es have
> + =A0 =A0 =A0 =A0* console support.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (co->index >=3D UART_NR)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 co->index =3D 0;
> + =A0 =A0 =A0 uap =3D amba_ports[co->index];
> + =A0 =A0 =A0 if (!uap)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> + =A0 =A0 =A0 uap->port.uartclk =3D UARTCLK;
> + =A0 =A0 =A0 if (options)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart_parse_options(options, &baud, &par=
ity, &bits,
> &flow);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pl011_console_get_options(uap, &baud, &=
parity, &bits);
> +
> + =A0 =A0 =A0 return uart_set_options(&uap->port, co, baud, parity, b=
its,
> flow);
> +}
> +
> +static struct uart_driver pci_pl011_uart_driver;
> +static struct console amba_console =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "ttyAM",
> + =A0 =A0 =A0 .write =A0 =A0 =A0 =A0 =A0=3D pl011_console_write,
> + =A0 =A0 =A0 .device =A0 =A0 =A0 =A0 =3D uart_console_device,
> + =A0 =A0 =A0 .setup =A0 =A0 =A0 =A0 =A0=3D pl011_console_setup,
> + =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D CON_PRINTBUFFER,
> + =A0 =A0 =A0 .index =A0 =A0 =A0 =A0 =A0=3D -1,
> + =A0 =A0 =A0 .data =A0 =A0 =A0 =A0 =A0 =3D &pci_pl011_uart_driver,
> +};
> +
> +#define AMBA_CONSOLE =A0 (&amba_console)
> +#else
> +#define AMBA_CONSOLE =A0 NULL
> +#endif
> +
> +
> +static struct uart_driver pci_pl011_uart_driver =3D {
> + =A0 =A0 =A0 .owner =A0 =A0 =A0 =A0 =A0=3D THIS_MODULE,
> + =A0 =A0 =A0 .driver_name =A0 =A0=3D PCI_PL011_DRIVER_NAME,
> + =A0 =A0 =A0 .dev_name =A0 =A0 =A0 =3D "ttyAM",
> + =A0 =A0 =A0 .major =A0 =A0 =A0 =A0 =A0=3D PCI_PL011_MAJOR,
> + =A0 =A0 =A0 .minor =A0 =A0 =A0 =A0 =A0=3D PCI_PL011_MINOR_START,
> + =A0 =A0 =A0 .nr =A0 =A0 =A0 =A0 =A0 =A0 =3D UART_NR,
> + =A0 =A0 =A0 .cons =A0 =A0 =A0 =A0 =A0 =3D AMBA_CONSOLE,
> +};
> +
> +static int __devinit
> +pci_pl011_probe(struct pci_dev *pdev, const struct pci_device_id *en=
t)
> +{
> + =A0 =A0 =A0 int index, rc =3D 0;
> + =A0 =A0 =A0 struct pci_pl011_adapter *adapter, *tmp_adapter;
> + =A0 =A0 =A0 struct uart_amba_port *uap;
> + =A0 =A0 =A0 struct list_head *tmp;
> + =A0 =A0 =A0 int =A0 =A0 pci_pl011_adapter_count =3D 0;
> +
> + =A0 =A0 =A0 rc =3D pci_enable_device(pdev);
> + =A0 =A0 =A0 if (rc) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Device enable FAIL=
ED\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 rc =3D pci_request_regions(pdev, "pci_pl011");
> + =A0 =A0 =A0 if (rc) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "pci_request_region=
 FAILED\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_disable_device;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 pci_set_master(pdev);
> +
> + =A0 =A0 =A0 adapter =3D kzalloc(sizeof(struct pci_pl011_adapter), G=
=46P_KERNEL);
> + =A0 =A0 =A0 if (!adapter) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "memory allocation for =
adapter structure
> failed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_release_regions;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 list_for_each(tmp, &pci_pl011_adapter_head) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp_adapter =3D list_entry(tmp, struct =
pci_pl011_adapter,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0pci_pl011_adapter_entry);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (tmp_adapter->index !=3D pci_pl011_a=
dapter_count)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_pl011_adapter_count++;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 adapter->index =3D pci_pl011_adapter_count;
> + =A0 =A0 =A0 list_add_tail(&adapter->pci_pl011_adapter_entry, tmp);
> +
> + =A0 =A0 =A0 adapter->pci_dev =3D pdev;
> + =A0 =A0 =A0 if (pdev->device =3D=3D PCI_DEVICE_ID_STMICRO_UART_HWFC=
)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 adapter->type =3D PL011_HWFC;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 adapter->type =3D PL011_NO_HWFC;
> + =A0 =A0 =A0 adapter->numb_ports =3D 1;
> +
> + =A0 =A0 =A0 spin_lock_init(&adapter->intr_lock);
> +
> + =A0 =A0 =A0 /** store which revision we have */
> + =A0 =A0 =A0 adapter->rev =3D pdev->revision;
> +
> + =A0 =A0 =A0 adapter->irq =3D pdev->irq;
> +
> + =A0 =A0 =A0 /** get the PCI Base Address Registers */
> + =A0 =A0 =A0 adapter->membase =A0 =A0 =A0 =A0=3D pci_resource_start(=
pdev, 0);
> + =A0 =A0 =A0 adapter->membase_end =3D pci_resource_end(pdev, 0);
> +
> + =A0 =A0 =A0 if (adapter->membase & 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 adapter->membase &=3D ~3;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 adapter->membase &=3D ~15;
> +
> +
> + =A0 =A0 =A0 adapter->re_map_membase =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ioremap(adapter->membase, pci_resource_=
len(pdev, 0));
> + =A0 =A0 =A0 if (!adapter->re_map_membase) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Device has no PCI Memo=
ry resources, "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "failing adapter.\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_kfree_adapter;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 for (index =3D 0; index < adapter->numb_ports; index++)=
 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uap =3D &adapter->port_info[index];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uap->port.uartclk =3D UARTCLK;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(uap->clk)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D PTR_ERR(uap->clk=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_iounmap;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uap->port.private_data =3D &adapter->ty=
pe;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uap->port.mapbase =3D adapter->membase;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uap->port.membase =3D adapter->re_map_m=
embase;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uap->port.iotype =3D UPIO_MEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uap->port.irq =3D adapter->irq;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uap->port.fifosize =3D vendor_st.fifosi=
ze;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uap->port.ops =3D &pci_pl011_pops;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uap->port.flags =3D UPF_BOOT_AUTOCONF;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uap->port.line =3D index + adapter->ind=
ex *
> adapter->numb_ports;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (uart_add_one_port(&pci_pl011_uart_d=
river,
> &uap->port))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "Added=
 uart port Failed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "Added=
 uart port \n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 amba_ports[uap->port.line] =3D uap;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /** Log the information about the adapter */
> + =A0 =A0 =A0 dev_info(&pdev->dev, "adapter %d: (rev %d), irq %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_pl011_adapter_count=
, adapter->rev,
> adapter->irq);
> +
> + =A0 =A0 =A0 pci_set_drvdata(pdev, adapter);
> +
> + =A0 =A0 =A0 return 0;
> +
> + out_iounmap:
> + =A0 =A0 =A0 iounmap(adapter->re_map_membase);
> + out_kfree_adapter:
> + =A0 =A0 =A0 kfree(adapter);
> + out_release_regions:
> + =A0 =A0 =A0 pci_release_regions(pdev);
> + out_disable_device:
> + =A0 =A0 =A0 pci_disable_device(pdev);
> + out:
> + =A0 =A0 =A0 return rc;
> +}
> +
> +static void __devexit pci_pl011_remove(struct pci_dev *pdev)
> +{
> + =A0 =A0 =A0 struct pci_pl011_adapter *adapter =3D pci_get_drvdata(p=
dev);
> + =A0 =A0 =A0 int i =3D 0;
> +
> +
> + =A0 =A0 =A0 for (i =3D 0; i < adapter->numb_ports; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart_remove_one_port(&pci_pl011_uart_dr=
iver,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &adapter->port_info[i].=
port);
> +
> + =A0 =A0 =A0 iounmap(adapter->re_map_membase);
> + =A0 =A0 =A0 pci_release_regions(pdev);
> + =A0 =A0 =A0 pci_disable_device(pdev);
> + =A0 =A0 =A0 list_del(&adapter->pci_pl011_adapter_entry);
> + =A0 =A0 =A0 kfree(adapter);
> +}
> +
> +static struct pci_device_id pci_pl011_pci_tbl[] =3D {
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .vendor =3D PCI_VENDOR_ID_STMICRO,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .device =3D PCI_DEVICE_ID_STMICRO_UART_=
HWFC,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .subvendor =3D PCI_ANY_ID,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .subdevice =3D PCI_ANY_ID,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .driver_data =3D 0,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .vendor =3D PCI_VENDOR_ID_STMICRO,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .device =3D PCI_DEVICE_ID_STMICRO_UART_=
NO_HWFC,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .subvendor =3D PCI_ANY_ID,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .subdevice =3D PCI_ANY_ID,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .driver_data =3D 0,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 { },
> +};
> +
> +static struct pci_driver pci_pl011_driver =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "pci_pl011",
> + =A0 =A0 =A0 .id_table =A0 =A0 =A0 =3D pci_pl011_pci_tbl,
> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D pci_pl011_probe,
> + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __devexit_p(pci_pl011_remov=
e),
> +};
> +
> +static int __init pci_pl011_init(void)
> +{
> + =A0 =A0 =A0 int rc;
> +
> + =A0 =A0 =A0 printk(KERN_INFO "Serial: PCI PL011 UART driver\n");
> +
> + =A0 =A0 =A0 rc =3D uart_register_driver(&pci_pl011_uart_driver);
> + =A0 =A0 =A0 if (!rc) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D pci_register_driver(&pci_pl011_d=
river);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (rc)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart_unregister_driver(=
&pci_pl011_uart_driver);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return rc;
> +}
> +
> +static void __exit pci_pl011_exit(void)
> +{
> + =A0 =A0 =A0 pci_unregister_driver(&pci_pl011_driver);
> + =A0 =A0 =A0 uart_unregister_driver(&pci_pl011_uart_driver);
> +}
> +
> +module_init(pci_pl011_init);
> +module_exit(pci_pl011_exit);
> +
> +MODULE_DESCRIPTION("Driver for the pl011 based on PCI");
> +MODULE_LICENSE("GPL");
> +MODULE_SUPPORTED_DEVICE("pl011-pci");
> +MODULE_VERSION(DRV_VERSION);
> --
> 1.6.0.4
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>
