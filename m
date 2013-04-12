From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] tty/serial: add MVF uart driver support
Date: Fri, 12 Apr 2013 14:30:54 +0200
Message-ID: <20130412123054.GE10373@pengutronix.de>
References: <1365750655-3530-1-git-send-email-b35083@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35868 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756369Ab3DLMa4 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 12 Apr 2013 08:30:56 -0400
Content-Disposition: inline
In-Reply-To: <1365750655-3530-1-git-send-email-b35083@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jingchang Lu <b35083@freescale.com>
Cc: linux-serial@vger.kernel.org, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org

On Fri, Apr 12, 2013 at 03:10:55PM +0800, Jingchang Lu wrote:
> It adds Freescale Vybrid Family uart driver support
> 
> Signed-off-by: Jingchang Lu <b35083@freescale.com>
> ---
> +++ b/drivers/tty/serial/mvf.c
> @@ -0,0 +1,1246 @@
> +/*
> + *  Driver for Freescale Vybrid Family serial ports
> + *
> + *  Based on drivers/tty/serial/imx.c
> + *
> + *  Copyright 2012-2013 Freescale Semiconductor, Inc.
> + *
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

Another FSF address. Please remove.

> + *
> + */
> +
> +#if defined(CONFIG_SERIAL_MVF_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
> +#define SUPPORT_SYSRQ
> +#endif
> +
> +#include <linux/module.h>
> +#include <linux/ioport.h>
> +#include <linux/init.h>
> +#include <linux/console.h>
> +#include <linux/sysrq.h>
> +#include <linux/platform_device.h>
> +#include <linux/tty.h>
> +#include <linux/tty_flip.h>
> +#include <linux/serial_core.h>
> +#include <linux/serial.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/rational.h>
> +#include <linux/slab.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/pinctrl/consumer.h>
> +#include <linux/io.h>
> +#include <asm/irq.h>
> +#include <linux/platform_data/serial-imx.h>
> +#include <linux/platform_data/dma-imx.h>
> +
> +/* All uart module registers for MVF is 8-bit width */
> +#define MXC_UARTBDH		0x00 /* Baud rate reg: high */
> +#define MXC_UARTBDL		0x01 /* Baud rate reg: low */
> +#define MXC_UARTCR1		0x02 /* Control reg 1 */
> +#define MXC_UARTCR2		0x03 /* Control reg 2 */
> +#define MXC_UARTSR1		0x04 /* Status reg 1 */
> +#define MXC_UARTSR2		0x05 /* Status reg 2 */
> +#define MXC_UARTCR3		0x06 /* Control reg 3 */
> +#define MXC_UARTDR		0x07 /* Data reg */
> +#define MXC_UARTMAR1		0x08 /* Match address reg 1 */
> +#define MXC_UARTMAR2		0x09 /* Match address reg 2 */
> +#define MXC_UARTCR4		0x0A /* Control reg 4 */
> +#define MXC_UARTCR5		0x0B /* Control reg 5 */
> +#define MXC_UARTEDR		0x0C /* Extended data reg */
> +#define MXC_UARTMODEM		0x0D /* Modem reg */
> +#define MXC_UARTIR		0x0E /* Infrared reg */
> +#define MXC_UARTPFIFO		0x10 /* FIFO parameter reg */
> +#define MXC_UARTCFIFO		0x11 /* FIFO control reg */
> +#define MXC_UARTSFIFO		0x12 /* FIFO status reg */
> +#define MXC_UARTTWFIFO		0x13 /* FIFO transmit watermark reg */
> +#define MXC_UARTTCFIFO		0x14 /* FIFO transmit count reg */
> +#define MXC_UARTRWFIFO		0x15 /* FIFO receive watermark reg */
> +#define MXC_UARTRCFIFO		0x16 /* FIFO receive count reg */
> +#define MXC_UARTC7816		0x18 /* 7816 control reg */
> +#define MXC_UARTIE7816		0x19 /* 7816 interrupt enable reg */
> +#define MXC_UARTIS7816		0x1A /* 7816 interrupt status reg */
> +#define MXC_UARTWP7816T0	0x1B /* 7816 wait parameter reg */
> +#define MXC_UARTWP7816T1	0x1B /* 7816 wait parameter reg */
> +#define MXC_UARTWN7816		0x1C /* 7816 wait N reg */
> +#define MXC_UARTWF7816		0x1D /* 7816 wait FD reg */
> +#define MXC_UARTET7816		0x1E /* 7816 error threshold reg */
> +#define MXC_UARTTL7816		0x1F /* 7816 transmit length reg */
> +#define MXC_UARTCR6		0x21 /* CEA709.1-B contrl reg */
> +#define MXC_UARTPCTH		0x22 /* CEA709.1-B packet cycle counter high */
> +#define MXC_UARTPCTL		0x23 /* CEA709.1-B packet cycle counter low */
> +#define MXC_UARTB1T		0x24 /* CEA709.1-B beta 1 time */
> +#define MXC_UARTSDTH		0x25 /* CEA709.1-B secondary delay timer high */
> +#define MXC_UARTSDTL		0x26 /* CEA709.1-B secondary delay timer low */
> +#define MXC_UARTPRE		0x27 /* CEA709.1-B preamble */
> +#define MXC_UARTTPL		0x28 /* CEA709.1-B transmit packet length */
> +#define MXC_UARTIE		0x29 /* CEA709.1-B transmit interrupt enable */
> +#define MXC_UARTSR3		0x2B /* CEA709.1-B status reg */
> +#define MXC_UARTSR4		0x2C /* CEA709.1-B status reg */
> +#define MXC_UARTRPL		0x2D /* CEA709.1-B received packet length */
> +#define MXC_UARTRPREL		0x2E /* CEA709.1-B received preamble length */
> +#define MXC_UARTCPW		0x2F /* CEA709.1-B collision pulse width */
> +#define MXC_UARTRIDT		0x30 /* CEA709.1-B receive indeterminate time */
> +#define MXC_UARTTIDT		0x31 /* CEA709.1-B transmit indeterminate time*/
> +
> +/* Bit definations of BDH */
> +#define MXC_UARTBDH_LBKDIE	0x80 /* LIN break detect interrupt enable */
> +#define MXC_UARTBDH_RXEDGIE	0x40 /* RxD input Active edge interrupt enable*/
> +#define MXC_UARTBDH_SBR_MASK	0x1f /* Uart baud rate high 5-bits */
> +/* Bit definations of CR1 */
> +#define MXC_UARTCR1_LOOPS	0x80 /* Loop mode select */
> +#define MXC_UARTCR1_RSRC	0x20 /* Receiver source select */
> +#define MXC_UARTCR1_M		0x10 /* 9-bit 8-bit mode select */
> +#define MXC_UARTCR1_WAKE	0x08 /* Receiver wakeup method */
> +#define MXC_UARTCR1_ILT		0x04 /* Idle line type */
> +#define MXC_UARTCR1_PE		0x02 /* Parity enable */
> +#define MXC_UARTCR1_PT		0x01 /* Parity type */
> +/* Bit definations of CR2 */
> +#define MXC_UARTCR2_TIE		0x80 /* Tx interrupt or DMA request enable */
> +#define MXC_UARTCR2_TCIE	0x40 /* Transmission complete int enable */
> +#define MXC_UARTCR2_RIE		0x20 /* Rx full int or DMA request enable */
> +#define MXC_UARTCR2_ILIE	0x10 /* Idle line interrupt enable */
> +#define MXC_UARTCR2_TE		0x08 /* Transmitter enable */
> +#define MXC_UARTCR2_RE		0x04 /* Receiver enable */
> +#define MXC_UARTCR2_RWU		0x02 /* Receiver wakeup control */
> +#define MXC_UARTCR2_SBK		0x01 /* Send break */
> +/* Bit definations of SR1 */
> +#define MXC_UARTSR1_TDRE	0x80 /* Tx data reg empty */
> +#define MXC_UARTSR1_TC		0x40 /* Transmit complete */
> +#define MXC_UARTSR1_RDRF	0x20 /* Rx data reg full */
> +#define MXC_UARTSR1_IDLE	0x10 /* Idle line flag */
> +#define MXC_UARTSR1_OR		0x08 /* Receiver overrun */
> +#define MXC_UARTSR1_NF		0x04 /* Noise flag */
> +#define MXC_UARTSR1_FE		0x02 /* Frame error */
> +#define MXC_UARTSR1_PE		0x01 /* Parity error */
> +/* Bit definations of SR2 */
> +#define MXC_UARTSR2_LBKDIF	0x80 /* LIN brk detect interrupt flag */
> +#define MXC_UARTSR2_RXEDGIF	0x40 /* RxD pin active edge interrupt flag */
> +#define MXC_UARTSR2_MSBF	0x20 /* MSB first */
> +#define MXC_UARTSR2_RXINV	0x10 /* Receive data inverted */
> +#define MXC_UARTSR2_RWUID	0x08 /* Receive wakeup idle detect */
> +#define MXC_UARTSR2_BRK13	0x04 /* Break transmit character length */
> +#define MXC_UARTSR2_LBKDE	0x02 /* LIN break detection enable */
> +#define MXC_UARTSR2_RAF		0x01 /* Receiver active flag */
> +/* Bit definations of CR3 */
> +#define MXC_UARTCR3_R8		0x80 /* Received bit8, for 9-bit data format */
> +#define MXC_UARTCR3_T8		0x40 /* transmit bit8, for 9-bit data format */
> +#define MXC_UARTCR3_TXDIR	0x20 /* Tx pin direction in single-wire mode */
> +#define MXC_UARTCR3_TXINV	0x10 /* Transmit data inversion */
> +#define MXC_UARTCR3_ORIE	0x08 /* Overrun error interrupt enable */
> +#define MXC_UARTCR3_NEIE	0x04 /* Noise error interrupt enable */
> +#define MXC_UARTCR3_FEIE	0x02 /* Framing error interrupt enable */
> +#define MXC_UARTCR3_PEIE	0x01 /* Parity errror interrupt enable */
> +/* Bit definations of CR4 */
> +#define MXC_UARTCR4_MAEN1	0x80 /* Match address mode enable 1 */
> +#define MXC_UARTCR4_MAEN2	0x40 /* Match address mode enable 2 */
> +#define MXC_UARTCR4_M10		0x20 /* 10-bit mode select */
> +#define MXC_UARTCR4_BRFA_MASK	0x1F /* Baud rate fine adjust */
> +#define MXC_UARTCR4_BRFA_OFF	0
> +/* Bit definations of CR5 */
> +#define MXC_UARTCR5_TDMAS	0x80 /* Transmitter DMA select */
> +#define MXC_UARTCR5_RDMAS	0x20 /* Receiver DMA select */
> +/* Bit definations of Modem */
> +#define MXC_UARTMODEM_RXRTSE	0x08 /* Enable receiver request-to-send */
> +#define MXC_UARTMODEM_TXRTSPOL	0x04 /* Select transmitter RTS polarity */
> +#define MXC_UARTMODEM_TXRTSE	0x02 /* Enable transmitter request-to-send */
> +#define MXC_UARTMODEM_TXCTSE	0x01 /* Enable transmitter CTS clear-to-send */
> +/* Bit definations of EDR */
> +#define MXC_UARTEDR_NOISY	0x80 /* Current dataword received with noise */
> +#define MXC_UARTEDR_PARITYE	0x40 /* Dataword received with parity error */
> +/* Bit definations of Infrared reg(IR) */
> +#define MXC_UARTIR_IREN		0x04 /* Infrared enable */
> +#define MXC_UARTIR_TNP_MASK	0x03 /* Transmitter narrow pluse */
> +#define MXC_UARTIR_TNP_OFF	0
> +/* Bit definations of FIFO parameter reg */
> +#define MXC_UARTPFIFO_TXFE	0x80 /* Transmit fifo enable */
> +#define MXC_UARTPFIFO_TXFIFOSIZE_MASK	0x7
> +#define MXC_UARTPFIFO_TXFIFOSIZE_OFF	4
> +#define MXC_UARTPFIFO_RXFE	0x08 /* Receiver fifo enable */
> +#define MXC_UARTPFIFO_RXFIFOSIZE_MASK	0x7
> +#define MXC_UARTPFIFO_RXFIFOSIZE_OFF	0
> +/* Bit definations of FIFO control reg */
> +#define MXC_UARTCFIFO_TXFLUSH	0x80 /* Transmit FIFO/buffer flush */
> +#define MXC_UARTCFIFO_RXFLUSH	0x40 /* Receive FIFO/buffer flush */
> +#define MXC_UARTCFIFO_RXOFE	0x04 /* Receive fifo overflow INT enable */
> +#define MXC_UARTCFIFO_TXOFE	0x02 /* Transmit fifo overflow INT enable */
> +#define MXC_UARTCFIFO_RXUFE	0x01 /* Receive fifo underflow INT enable */
> +/* Bit definations of FIFO status reg */
> +#define MXC_UARTSFIFO_TXEMPT	0x80 /* Transmit fifo/buffer empty */
> +#define MXC_UARTSFIFO_RXEMPT	0x40 /* Receive fifo/buffer empty */
> +#define MXC_UARTSFIFO_RXOF	0x04 /* Rx buffer overflow flag */
> +#define MXC_UARTSFIFO_TXOF	0x02 /* Tx buffer overflow flag */
> +#define MXC_UARTSFIFO_RXUF	0x01 /* Rx buffer underflow flag */
> +
> +
> +
> +#undef CONFIG_MVF_SERIAL_DMA

Please remove.

> +/* follow IMX dev node number */
> +#define SERIAL_IMX_MAJOR	207
> +#define MINOR_START		24
> +#define DEV_NAME	"ttymxc"
> +#define MAX_INTERNAL_IRQ	MXC_INTERNAL_IRQS
> +
> +/*
> + * This determines how often we check the modem status signals
> + * for any change.  They generally aren't connected to an IRQ
> + * so we have to poll them.  We also check immediately before
> + * filling the TX fifo incase CTS has been dropped.
> + */
> +#define MCTRL_TIMEOUT	(250*HZ/1000)

Add whitespaces left and right to operators:

	(250 * HZ / 1000)

> +
> +#define DRIVER_NAME "MVF-uart"
> +
> +#define UART_NR 6
> +
> +struct mvf_port {
> +	struct uart_port	port;
> +	unsigned int		old_status;
> +	int			txirq, rxirq, rtsirq;
> +	unsigned int		have_rtscts:1;
> +	unsigned int		use_dcedte:1;
> +	unsigned int		use_irda:1;
> +	unsigned int		irda_inv_rx:1;
> +	unsigned int		irda_inv_tx:1;
> +	unsigned int		fifo_en:1; /* enable FIFO mode */
> +	unsigned int		mark_en:1; /* enable Mark address match */
> +	unsigned int		format_9bits:1; /* 9bits data format */
> +	unsigned short		trcv_delay; /* transceiver delay */
> +	unsigned char		ma_addr; /* Match address */
> +	struct clk		*clk;
> +
> +	unsigned int		tx_fifo_size, rx_fifo_size;
> +
> +	/* DMA fields */
> +	int			enable_dma;

enable_dma is unused. Either implement it or remove it.

> +	unsigned long		dma_tx_ch; /* configured eDMA channel */
> +	struct imx_dma_data	dma_data;
> +	struct dma_chan		*dma_chan_rx, *dma_chan_tx;
> +	struct scatterlist	rx_sgl, tx_sgl;
> +	void			*rx_buf;
> +	unsigned char		*tx_buf;
> +	unsigned int		rx_bytes, tx_bytes;
> +	struct work_struct	tsk_dma_rx, tsk_dma_tx;
> +	unsigned int		dma_tx_nents;
> +	bool			dma_is_rxing, dma_is_txing;
> +	wait_queue_head_t	dma_wait;
> +};
> +
> +#ifdef CONFIG_IRDA
> +#define USE_IRDA(sport)	((sport)->use_irda)
> +#else
> +#define USE_IRDA(sport)	(0)
> +#endif

This is unused. Remove. also rtsirq and use_irda

> +enum mvf_uart_type {
> +	MVF600_UART,
> +};
> +
> +struct mvf_uart_data {
> +	unsigned uts_reg;
> +	enum mvf_uart_type devtype;
> +};
> +
> +static struct mvf_uart_data mvf_uart_devdata[] = {
> +	[MVF600_UART] = {
> +		.devtype = MVF600_UART,
> +	},
> +};
> +
> +static struct platform_device_id mvf_uart_devtype[] = {
> +	{
> +		.name = "mvf600-uart",
> +		.driver_data = (kernel_ulong_t) &mvf_uart_devdata[MVF600_UART],
> +	}, {
> +		/* sentinel */
> +	}
> +};
> +MODULE_DEVICE_TABLE(platform, mvf_uart_devtype);
> +
> +static struct of_device_id mvf_uart_dt_ids[] = {
> +	{
> +		.compatible = "fsl,mvf-uart",
> +		.data = &mvf_uart_devdata[MVF600_UART],
> +	},
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, mvf_uart_dt_ids);
> +
> +/*
> + * interrupts disabled on entry
> + */
> +static void mvf_stop_tx(struct uart_port *port)
> +{
> +	struct mvf_port *sport = (struct mvf_port *)port;
> +	unsigned char temp;
> +
> +	temp = readb(sport->port.membase + MXC_UARTCR2);
> +	writeb(temp & ~(MXC_UARTCR2_TIE | MXC_UARTCR2_TCIE),
> +			sport->port.membase + MXC_UARTCR2);

I find it more readable to do a:

	temp = readl(adr);
	temp &= ~(bla);
	writel(temp, adr);

But that's just my 2 cents.

> +}
> +
> +/*
> + * interrupts disabled on entry
> + */
> +static void mvf_stop_rx(struct uart_port *port)
> +{
> +	struct mvf_port *sport = (struct mvf_port *)port;
> +	unsigned char temp;
> +
> +	/* if the DMA RX thread is running, wait for it to finish. */
> +	if (sport->enable_dma && sport->dma_is_rxing)
> +		return;
> +
> +	temp = readb(sport->port.membase + MXC_UARTCR2);
> +	writeb(temp & ~MXC_UARTCR2_RE, sport->port.membase + MXC_UARTCR2);
> +}
> +
> + /* modem status update function */
> +static void mvf_enable_ms(struct uart_port *port)
> +{
> +}
> +
> +static inline void mvf_transmit_buffer(struct mvf_port *sport)
> +{
> +	struct circ_buf *xmit = &sport->port.state->xmit;
> +
> +	while (!uart_circ_empty(xmit) && (sport->fifo_en == 1 ?
> +	(readb(sport->port.membase + MXC_UARTTCFIFO) < sport->tx_fifo_size) :
> +		(readb(sport->port.membase + MXC_UARTSR1) & MXC_UARTSR1_TDRE)
> +		)) {

Can you make this more readable?

> +		/* send out xmit->buf[xmit->tail] */
> +		writeb(xmit->buf[xmit->tail], sport->port.membase + MXC_UARTDR);
> +		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
> +		sport->port.icount.tx++;
> +	}
> +
> +	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +		uart_write_wakeup(&sport->port);
> +
> +	if (uart_circ_empty(xmit))
> +		mvf_stop_tx(&sport->port);
> +}
> +
> +/*
> + * interrupts disabled on entry
> + */
> +static void mvf_start_tx(struct uart_port *port)
> +{
> +	struct mvf_port *sport = (struct mvf_port *)port;
> +	unsigned char temp;
> +
> +	if (!sport->enable_dma) {
> +		temp = readb(sport->port.membase + MXC_UARTCR2);
> +		writeb(temp | MXC_UARTCR2_TIE,
> +				sport->port.membase + MXC_UARTCR2);
> +	}
> +
> +	if (sport->enable_dma) {
> +		schedule_work(&sport->tsk_dma_tx);
> +		return;
> +	}
> +
> +	if (readb(sport->port.membase + MXC_UARTSR1) & MXC_UARTSR1_TDRE)
> +		mvf_transmit_buffer(sport);
> +}
> +
> +
> +static irqreturn_t mvf_txint(int irq, void *dev_id)
> +{
> +	struct mvf_port *sport = dev_id;
> +	struct circ_buf *xmit = &sport->port.state->xmit;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&sport->port.lock, flags);
> +	if (sport->port.x_char) {
> +		/* Send next char */
> +		writeb(sport->port.x_char, sport->port.membase + MXC_UARTDR);
> +		goto out;
> +	}
> +
> +	if (uart_circ_empty(xmit) || uart_tx_stopped(&sport->port)) {
> +		mvf_stop_tx(&sport->port);
> +		goto out;
> +	}
> +
> +	mvf_transmit_buffer(sport);
> +
> +	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +		uart_write_wakeup(&sport->port);
> +
> +out:
> +	spin_unlock_irqrestore(&sport->port.lock, flags);
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t mvf_rxint(int irq, void *dev_id)
> +{
> +	struct mvf_port *sport = dev_id;
> +	unsigned int flg, ignored = 0;
> +	struct tty_port *port = &sport->port.state->port;
> +	unsigned long flags;
> +	unsigned char r8, rx, sr;
> +
> +	spin_lock_irqsave(&sport->port.lock, flags);
> +
> +	while (!(readb(sport->port.membase + MXC_UARTSFIFO) &
> +				MXC_UARTSFIFO_RXEMPT)) {
> +		flg = TTY_NORMAL;
> +		sport->port.icount.rx++;
> +
> +		/*  To clear the FE, OR, NF, FE, PE flags when set,
> +		 *  read SR1 then read DR
> +		 */
> +		sr = readb(sport->port.membase + MXC_UARTSR1);
> +
> +		r8 = readb(sport->port.membase + MXC_UARTCR3) & MXC_UARTCR3_R8;
> +		rx = readb(sport->port.membase + MXC_UARTDR);
> +
> +		if (sport->mark_en &&
> +			(sport->format_9bits ? r8 : (rx == sport->ma_addr)))
> +				continue;
> +
> +		if (uart_handle_sysrq_char(&sport->port, (unsigned char)rx))
> +			continue;
> +		if (sr & (MXC_UARTSR1_PE | MXC_UARTSR1_OR | MXC_UARTSR1_FE)) {
> +			if (sr & MXC_UARTSR1_PE)
> +				sport->port.icount.parity++;
> +			else if (sr & MXC_UARTSR1_FE)
> +				sport->port.icount.frame++;
> +			if (sr & MXC_UARTSR1_OR)
> +				sport->port.icount.overrun++;
> +
> +			if (sr & sport->port.ignore_status_mask) {
> +				if (++ignored > 100)
> +					goto out;
> +				continue;
> +			}
> +
> +			sr &= sport->port.read_status_mask;
> +
> +			if (sr & MXC_UARTSR1_PE)
> +				flg = TTY_PARITY;
> +			else if (sr & MXC_UARTSR1_FE)
> +				flg = TTY_FRAME;
> +			if (sr & MXC_UARTSR1_OR)
> +				flg = TTY_OVERRUN;
> +
> +#ifdef SUPPORT_SYSRQ
> +			sport->port.sysrq = 0;
> +#endif
> +		}
> +
> +		tty_insert_flip_char(port, rx, flg);
> +	}
> +
> +out:
> +	spin_unlock_irqrestore(&sport->port.lock, flags);
> +
> +	tty_flip_buffer_push(port);
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t mvf_int(int irq, void *dev_id)
> +{
> +	struct mvf_port *sport = dev_id;
> +	unsigned int sts;
> +
> +	sts = readb(sport->port.membase + MXC_UARTSR1);
> +
> +	if (sts & MXC_UARTSR1_RDRF)
> +			mvf_rxint(irq, dev_id);

Wrong indention.

> +
> +	if (sts & MXC_UARTSR1_TDRE &&
> +		!(readb(sport->port.membase + MXC_UARTCR5) &
> +			MXC_UARTCR5_TDMAS))
> +		mvf_txint(irq, dev_id);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/*
> + * Return TIOCSER_TEMT when transmitter is not busy.
> + */
> +static unsigned int mvf_tx_empty(struct uart_port *port)
> +{
> +	struct mvf_port *sport = (struct mvf_port *)port;
> +
> +	return (readb(sport->port.membase + MXC_UARTSR1) & MXC_UARTSR1_TC) ?
> +		TIOCSER_TEMT : 0;
> +}
> +
> +static unsigned int mvf_get_mctrl(struct uart_port *port)
> +{
> +	struct mvf_port *sport = (struct mvf_port *)port;
> +	unsigned int tmp = 0;
> +	unsigned char reg;
> +
> +	reg = readb(sport->port.membase + MXC_UARTMODEM);
> +	if (reg & MXC_UARTMODEM_TXCTSE)
> +		tmp |= TIOCM_CTS;
> +
> +	if (reg & MXC_UARTMODEM_RXRTSE)
> +		tmp |= TIOCM_RTS;
> +
> +	return tmp;
> +}
> +
> +static void mvf_set_mctrl(struct uart_port *port, unsigned int mctrl)
> +{
> +	struct mvf_port *sport = (struct mvf_port *)port;

Do not cast to different struct typed. Use container_of instead.

> +	unsigned long temp;
> +
> +	temp = readb(sport->port.membase + MXC_UARTMODEM) &
> +			~(MXC_UARTMODEM_RXRTSE | MXC_UARTMODEM_TXCTSE);
> +
> +	if (mctrl & TIOCM_RTS)
> +		temp |= MXC_UARTMODEM_RXRTSE;
> +	if (mctrl & TIOCM_CTS)
> +		temp |= MXC_UARTMODEM_TXCTSE;
> +
> +	writeb(temp, sport->port.membase + MXC_UARTMODEM);
> +}
> +
> +/*
> + * Interrupts always disabled.
> + */
> +static void mvf_break_ctl(struct uart_port *port, int break_state)
> +{
> +	struct mvf_port *sport = (struct mvf_port *)port;
> +	unsigned long flags;
> +	unsigned char temp;
> +
> +	spin_lock_irqsave(&sport->port.lock, flags);
> +
> +	temp = readb(sport->port.membase + MXC_UARTCR2) & ~MXC_UARTCR2_SBK;
> +
> +	if (break_state != 0)
> +		temp |= MXC_UARTCR2_SBK;
> +
> +	writeb(temp, sport->port.membase + MXC_UARTCR2);
> +
> +	spin_unlock_irqrestore(&sport->port.lock, flags);
> +}
> +
> +#define TXTL 2
> +#define RXTL 1
> +
> +static int mvf_setup_watermark(struct mvf_port *sport, unsigned int mode)

The mode argument is unused.

> +{
> +	unsigned char val, old_cr2, cr2;
> +
> +	/* set receiver/transmitter trigger level. */
> +	old_cr2 = cr2 = readb(sport->port.membase + MXC_UARTCR2);
> +	cr2 &= ~(MXC_UARTCR2_TIE | MXC_UARTCR2_TCIE | MXC_UARTCR2_TE |
> +			MXC_UARTCR2_RIE | MXC_UARTCR2_RE);
> +	writeb(cr2, sport->port.membase + MXC_UARTCR2);
> +
> +	val = TXTL;
> +	writeb(val, sport->port.membase + MXC_UARTTWFIFO);
> +	val = RXTL;
> +	writeb(val, sport->port.membase + MXC_UARTRWFIFO);

Please drop this additional 'val =' hoop.

> +
> +	/* Enable Tx and Rx FIFO */
> +	val = readb(sport->port.membase + MXC_UARTPFIFO);
> +	sport->tx_fifo_size = 0x1 << (((val >> MXC_UARTPFIFO_TXFIFOSIZE_OFF) &
> +		MXC_UARTPFIFO_TXFIFOSIZE_MASK) + 1);
> +	sport->rx_fifo_size = 0x1 << (((val >> MXC_UARTPFIFO_RXFIFOSIZE_OFF) &
> +		MXC_UARTPFIFO_RXFIFOSIZE_MASK) + 1);

During init you hardcode the FIFO size to 32 byte. Can't you use these
values instead?

> +	writeb(val | MXC_UARTPFIFO_TXFE | MXC_UARTPFIFO_RXFE,
> +			sport->port.membase + MXC_UARTPFIFO);
> +
> +	/* Flush the Tx and Rx FIFO to a known state */
> +	writeb(MXC_UARTCFIFO_TXFLUSH | MXC_UARTCFIFO_RXFLUSH,
> +			sport->port.membase + MXC_UARTCFIFO);
> +
> +	/* restore CR2 */
> +	writeb(old_cr2, sport->port.membase + MXC_UARTCR2);
> +
> +	return 0;
> +}

The function always returns 0 and the return value is never checked, so
make it return void.

> +
> +
> +static int mvf_startup(struct uart_port *port)
> +{
> +	struct mvf_port *sport = (struct mvf_port *)port;
> +	int retval;
> +	unsigned long flags, temp;
> +
> +	if (sport->fifo_en)
> +		mvf_setup_watermark(sport, 0);
> +
> +	temp = readb(sport->port.membase + MXC_UARTCR2);
> +
> +	writeb(temp & ~MXC_UARTCR2_RIE, sport->port.membase + MXC_UARTCR2);
> +
> +	/*
> +	 * Allocate the IRQ(s)
> +	 * Vybrid chips only have one interrupt.
> +	 */
> +	retval = request_irq(sport->port.irq, mvf_int, 0,
> +				DRIVER_NAME, sport);

Request you interrupt in the probe function so that you can use a devm_*
function.

> +	if (retval)
> +		goto error_out1;
> +
> +	/* Enable the DMA ops for uart. */
> +	if (sport->enable_dma) {
> +		sport->dma_is_txing = 0;
> +
> +		/* enable DMA request generation */
> +		temp = readb(sport->port.membase + MXC_UARTCR5);
> +		temp |= MXC_UARTCR5_TDMAS;
> +		writeb(temp, sport->port.membase + MXC_UARTCR5);
> +
> +		init_waitqueue_head(&sport->dma_wait);
> +	}
> +
> +	spin_lock_irqsave(&sport->port.lock, flags);
> +
> +	/* Finally, clear and enable interrupts */
> +	temp = readb(sport->port.membase + MXC_UARTCR2);
> +	temp |= MXC_UARTCR2_RIE | MXC_UARTCR2_TIE;
> +	writeb(temp, sport->port.membase + MXC_UARTCR2);
> +
> +	spin_unlock_irqrestore(&sport->port.lock, flags);
> +
> +	return 0;
> +
> +error_out1:
> +	return retval;
> +}
> +
> +static void mvf_shutdown(struct uart_port *port)
> +{
> +	struct mvf_port *sport = (struct mvf_port *)port;
> +	unsigned char temp;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&sport->port.lock, flags);
> +	temp = readb(sport->port.membase + MXC_UARTCR2);
> +	temp &= ~(MXC_UARTCR2_TE | MXC_UARTCR2_RE);
> +	writeb(temp, sport->port.membase + MXC_UARTCR2);
> +	spin_unlock_irqrestore(&sport->port.lock, flags);
> +
> +	/*
> +	 * Free the interrupts
> +	 */
> +	if (sport->txirq > 0) {
> +		if (!USE_IRDA(sport))
> +			free_irq(sport->rtsirq, sport);
> +		free_irq(sport->txirq, sport);
> +		free_irq(sport->rxirq, sport);
> +	} else
> +		free_irq(sport->port.irq, sport);

If one branch of a conditional statement needs braces add them to the
other aswell.

> +
> +	/*
> +	 * Disable all interrupts, port and break condition.
> +	 */
> +
> +	spin_lock_irqsave(&sport->port.lock, flags);
> +	temp = readb(sport->port.membase + MXC_UARTCR2);
> +	temp &= ~(MXC_UARTCR2_TIE | MXC_UARTCR2_TCIE | MXC_UARTCR2_RIE);
> +	writeb(temp, sport->port.membase + MXC_UARTCR2);
> +
> +	spin_unlock_irqrestore(&sport->port.lock, flags);
> +}
> +
> +static void
> +mvf_set_termios(struct uart_port *port, struct ktermios *termios,
> +		   struct ktermios *old)
> +{
> +	struct mvf_port *sport = (struct mvf_port *)port;
> +	unsigned long flags;
> +	unsigned char cr1, old_cr1, old_cr2, cr4, bdh, modem;
> +	unsigned int  baud;
> +	unsigned int old_csize = old ? old->c_cflag & CSIZE : CS8;
> +	unsigned int sbr, brfa;
> +
> +	cr1 = old_cr1 = readb(sport->port.membase + MXC_UARTCR1);
> +	old_cr2 = readb(sport->port.membase + MXC_UARTCR2);
> +	cr4 = readb(sport->port.membase + MXC_UARTCR4);
> +	bdh = readb(sport->port.membase + MXC_UARTBDH);
> +	modem = readb(sport->port.membase + MXC_UARTMODEM);
> +	/*
> +	 * If we don't support modem control lines, don't allow
> +	 * these to be set.
> +	 */
> +	if (0) {
> +		termios->c_cflag &= ~(HUPCL | CRTSCTS | CMSPAR);
> +		termios->c_cflag |= CLOCAL;
> +	}

Dead code. Please remove.

> +
> +	/*
> +	 * We only support CS8 and CS7,but CS7 must enable PE.
> +	 * supported mode:
> +	 *  - (7,e/o,1)
> +	 *  - (8,n,1)
> +	 *  - (8,m/s,1)
> +	 *  - (8,e/o,1)
> +	 */
> +	while ((termios->c_cflag & CSIZE) != CS8 &&
> +		(termios->c_cflag & CSIZE) != CS7) {
> +		termios->c_cflag &= ~CSIZE;
> +		termios->c_cflag |= old_csize;
> +		old_csize = CS8;
> +	}
> +
> +	if ((termios->c_cflag & CSIZE) == CS8 ||
> +		(termios->c_cflag & CSIZE) == CS7)
> +		cr1 = old_cr1 & ~MXC_UARTCR1_M;
> +
> +	if (termios->c_cflag & CMSPAR) {
> +		if ((termios->c_cflag & CSIZE) != CS8) {
> +			termios->c_cflag &= ~CSIZE;
> +			termios->c_cflag |= CS8;
> +		}
> +		cr1 |= MXC_UARTCR1_M;
> +	}
> +
> +	if (termios->c_cflag & CRTSCTS) {
> +		if (sport->have_rtscts)
> +			modem |= (MXC_UARTMODEM_RXRTSE | MXC_UARTMODEM_TXCTSE);
> +
> +	} else {
> +		termios->c_cflag &= ~CRTSCTS;
> +		modem &= ~(MXC_UARTMODEM_RXRTSE | MXC_UARTMODEM_TXCTSE);
> +	}
> +
> +	if (termios->c_cflag & CSTOPB)
> +		termios->c_cflag &= ~CSTOPB;
> +
> +	/* parity must enable when CS7 to match 8-bits format */
> +	if ((termios->c_cflag & CSIZE) == CS7)
> +		termios->c_cflag |= PARENB;
> +
> +	if ((termios->c_cflag & PARENB)) {
> +		if (termios->c_cflag & CMSPAR) {
> +			cr1 &= ~MXC_UARTCR1_PE;
> +			cr1 |= MXC_UARTCR1_M;
> +			sport->format_9bits = 1;
> +		} else {
> +			cr1 |= MXC_UARTCR1_PE;
> +			if ((termios->c_cflag & CSIZE) == CS8)
> +				cr1 |= MXC_UARTCR1_M;
> +			if (termios->c_cflag & PARODD)
> +				cr1 |= MXC_UARTCR1_PT;
> +			else
> +				cr1 &= ~MXC_UARTCR1_PT;
> +		}
> +	}
> +
> +	/*
> +	 * Ask the core to calculate the divisor for us.
> +	 */
> +	baud = uart_get_baud_rate(port, termios, old, 50, port->uartclk / 16);
> +
> +	spin_lock_irqsave(&sport->port.lock, flags);
> +
> +	sport->port.read_status_mask = 0;
> +	if (termios->c_iflag & INPCK)
> +		sport->port.read_status_mask |=
> +					(MXC_UARTSR1_FE | MXC_UARTSR1_PE);
> +	if (termios->c_iflag & (BRKINT | PARMRK))
> +		sport->port.read_status_mask |= MXC_UARTSR1_FE;
> +
> +	/*
> +	 * Characters to ignore
> +	 */
> +	sport->port.ignore_status_mask = 0;
> +	if (termios->c_iflag & IGNPAR)
> +		sport->port.ignore_status_mask |= MXC_UARTSR1_PE;
> +	if (termios->c_iflag & IGNBRK) {
> +		sport->port.ignore_status_mask |= MXC_UARTSR1_FE;
> +		/*
> +		 * If we're ignoring parity and break indicators,
> +		 * ignore overruns too (for real raw support).
> +		 */
> +		if (termios->c_iflag & IGNPAR)
> +			sport->port.ignore_status_mask |= MXC_UARTSR1_OR;
> +	}
> +
> +	/*
> +	 * Update the per-port timeout.
> +	 */
> +	uart_update_timeout(port, termios->c_cflag, baud);
> +
> +	/* wait transmit engin complete */
> +	while (!(readb(sport->port.membase + MXC_UARTSR1) & MXC_UARTSR1_TC))
> +		barrier();
> +
> +	writeb(old_cr2 & ~(MXC_UARTCR2_TE | MXC_UARTCR2_RE),
> +			sport->port.membase + MXC_UARTCR2);
> +
> +	/* disable transmit and receive */
> +	sbr = sport->port.uartclk / (16 * baud);
> +	brfa = ((sport->port.uartclk - (16 * sbr * baud)) * 2)/baud;
> +
> +	bdh &= ~MXC_UARTBDH_SBR_MASK;
> +	bdh |= (sbr >> 8) & 0x1F;
> +
> +	cr4 &= ~MXC_UARTCR4_BRFA_MASK;
> +	brfa &= MXC_UARTCR4_BRFA_MASK;
> +	writeb(cr4 | brfa, sport->port.membase + MXC_UARTCR4);
> +	writeb(bdh, sport->port.membase + MXC_UARTBDH);
> +	writeb(sbr & 0xFF, sport->port.membase + MXC_UARTBDL);
> +	writeb(cr1, sport->port.membase + MXC_UARTCR1);
> +	writeb(modem, sport->port.membase + MXC_UARTMODEM);
> +
> +	/* restore control register */
> +	writeb(old_cr2, sport->port.membase + MXC_UARTCR2);
> +
> +	spin_unlock_irqrestore(&sport->port.lock, flags);
> +}
> +
> +static const char *mvf_type(struct uart_port *port)
> +{
> +	struct mvf_port *sport = (struct mvf_port *)port;
> +
> +	return sport->port.type == PORT_MVF ? "MVF" : NULL;
> +}
> +
> +/*
> + * Release the memory region(s) being used by 'port'.
> + */
> +static void mvf_release_port(struct uart_port *port)
> +{
> +	struct platform_device *pdev = to_platform_device(port->dev);
> +	struct resource *mmres;
> +
> +	mmres = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	release_mem_region(mmres->start, mmres->end - mmres->start + 1);
> +}
> +
> +/*
> + * Request the memory region(s) being used by 'port'.
> + */
> +static int mvf_request_port(struct uart_port *port)
> +{
> +	struct platform_device *pdev = to_platform_device(port->dev);
> +	struct resource *mmres;
> +	void *ret;
> +
> +	mmres = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!mmres)
> +		return -ENODEV;
> +
> +	ret = request_mem_region(mmres->start, mmres->end - mmres->start + 1,
> +			"imx-uart");

Use resource_size()

> +
> +	return  ret ? 0 : -EBUSY;
> +}
> +
> +/*
> + * Configure/autoconfigure the port.
> + */
> +static void mvf_config_port(struct uart_port *port, int flags)
> +{
> +	struct mvf_port *sport = (struct mvf_port *)port;
> +
> +	if (flags & UART_CONFIG_TYPE &&
> +	    mvf_request_port(&sport->port) == 0)
> +		sport->port.type = PORT_MVF;
> +}
> +
> +/*
> + * Verify the new serial_struct (for TIOCSSERIAL).
> + * The only change we allow are to the flags and type, and
> + * even then only between PORT_MVF and PORT_UNKNOWN
> + */
> +static int
> +mvf_verify_port(struct uart_port *port, struct serial_struct *ser)
> +{
> +	struct mvf_port *sport = (struct mvf_port *)port;
> +	int ret = 0;
> +
> +	if (ser->type != PORT_UNKNOWN && ser->type != PORT_MVF)
> +		ret = -EINVAL;
> +	if (sport->port.irq != ser->irq)
> +		ret = -EINVAL;
> +	if (ser->io_type != UPIO_MEM)
> +		ret = -EINVAL;
> +	if (sport->port.uartclk / 16 != ser->baud_base)
> +		ret = -EINVAL;
> +	if (sport->port.iobase != ser->port)
> +		ret = -EINVAL;
> +	if (ser->hub6 != 0)
> +		ret = -EINVAL;
> +	return ret;
> +}
> +
> +
> +static struct uart_ops mvf_pops = {
> +	.tx_empty	= mvf_tx_empty,
> +	.set_mctrl	= mvf_set_mctrl,
> +	.get_mctrl	= mvf_get_mctrl,
> +	.stop_tx	= mvf_stop_tx,
> +	.start_tx	= mvf_start_tx,
> +	.stop_rx	= mvf_stop_rx,
> +	.enable_ms	= mvf_enable_ms,
> +	.break_ctl	= mvf_break_ctl,
> +	.startup	= mvf_startup,
> +	.shutdown	= mvf_shutdown,
> +	.set_termios	= mvf_set_termios,
> +	.type		= mvf_type,
> +	.release_port	= mvf_release_port,
> +	.request_port	= mvf_request_port,
> +	.config_port	= mvf_config_port,
> +	.verify_port	= mvf_verify_port,
> +};
> +
> +static struct mvf_port *mvf_ports[UART_NR];
> +
> +#ifdef CONFIG_SERIAL_MVF_CONSOLE
> +static void mvf_console_putchar(struct uart_port *port, int ch)
> +{
> +	struct mvf_port *sport = (struct mvf_port *)port;
> +
> +	while (!(readb(sport->port.membase + MXC_UARTSR1) & MXC_UARTSR1_TDRE))
> +		barrier();
> +
> +	writeb(ch, sport->port.membase + MXC_UARTDR);
> +}
> +
> +/*
> + * Interrupts are disabled on entering
> + */

You don't care since you are locking the device anyway.

> +static void
> +mvf_console_write(struct console *co, const char *s, unsigned int count)
> +{
> +	struct mvf_port *sport = mvf_ports[co->index];
> +	unsigned int  old_cr2, cr2;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&sport->port.lock, flags);
> +	/*
> +	 * First, save UCR1/2 and then disable interrupts
> +	 */

The comment seems wrong.

> +	cr2 = old_cr2 = readb(sport->port.membase + MXC_UARTCR2);
> +
> +	cr2 |= (MXC_UARTCR2_TE |  MXC_UARTCR2_RE);
> +	cr2 &= ~(MXC_UARTCR2_TIE | MXC_UARTCR2_TCIE | MXC_UARTCR2_RIE);
> +
> +	writeb(cr2, sport->port.membase + MXC_UARTCR2);
> +
> +	uart_console_write(&sport->port, s, count, mvf_console_putchar);
> +
> +	/*
> +	 * wait for transmitter finish complete and restore CR2
> +	 */
> +	while (!(readb(sport->port.membase + MXC_UARTSR1) & MXC_UARTSR1_TC))
> +		;
> +
> +	writeb(old_cr2, sport->port.membase + MXC_UARTCR2);
> +	spin_unlock_irqrestore(&sport->port.lock, flags);
> +}
> +
> +/*
> + * If the port was already initialised (eg, by a boot loader),
> + * try to determine the current setup.
> + */
> +static void __init
> +mvf_console_get_options(struct mvf_port *sport, int *baud,
> +			   int *parity, int *bits)
> +{
> +
> +	if (readb(sport->port.membase + MXC_UARTCR2) &
> +			(MXC_UARTCR2_TE | MXC_UARTCR2)) {

Bail out early here by testing for the opposite. You'll save an
indention level below.

> +		/* ok, the port was enabled */
> +		unsigned char cr1, bdh, bdl, brfa;
> +		unsigned int sbr, uartclk;
> +		unsigned int baud_raw;
> +
> +		cr1 = readb(sport->port.membase + MXC_UARTCR1);
> +
> +		*parity = 'n';
> +		if (cr1 & MXC_UARTCR1_PE) {
> +			if (cr1 & MXC_UARTCR1_PT)
> +				*parity = 'o';
> +			else
> +				*parity = 'e';
> +		}
> +
> +		if (cr1 & MXC_UARTCR1_M)
> +			*bits = 9;
> +		else
> +			*bits = 8;
> +
> +		bdh = readb(sport->port.membase + MXC_UARTBDH) &
> +						MXC_UARTBDH_SBR_MASK;
> +		bdl = readb(sport->port.membase + MXC_UARTBDL);
> +		sbr = bdh;
> +		sbr <<= 8;
> +		sbr |= bdl;
> +		brfa = readb(sport->port.membase + MXC_UARTCR4) &
> +						MXC_UARTCR4_BRFA_MASK;
> +		uartclk = clk_get_rate(sport->clk);
> +		/*
> +		 * Baud = mod_clk/(16*(sbr[13]+(brfa)/32)
> +		 */
> +		baud_raw = uartclk/(16 * (sbr + brfa/32));

Add whitespaces left and right to operators.

> +
> +		if (*baud != baud_raw)
> +			printk(KERN_INFO "Serial: Console IMX "
> +					"rounded baud rate from %d to %d\n",

IMX?

> +				baud_raw, *baud);
> +	}
> +}
> +
> +static int __init
> +mvf_console_setup(struct console *co, char *options)
> +{
> +	struct mvf_port *sport;
> +	int baud = 115200;
> +	int bits = 8;
> +	int parity = 'n';
> +	int flow = 'n';
> +
> +	/*
> +	 * Check whether an invalid uart number has been specified, and
> +	 * if so, search for the first available port that does have
> +	 * console support.
> +	 */
> +	if (co->index == -1 || co->index >= ARRAY_SIZE(mvf_ports))
> +		co->index = 0;
> +	sport = mvf_ports[co->index];
> +
> +	if (sport == NULL)
> +		return -ENODEV;
> +
> +	if (options)
> +		uart_parse_options(options, &baud, &parity, &bits, &flow);
> +	else
> +		mvf_console_get_options(sport, &baud, &parity, &bits);
> +
> +	if (sport->fifo_en == 1)
> +		mvf_setup_watermark(sport, 0);
> +
> +	return uart_set_options(&sport->port, co, baud, parity, bits, flow);
> +}
> +
> +static struct uart_driver mvf_reg;
> +static struct console mvf_console = {
> +	.name		= DEV_NAME,
> +	.write		= mvf_console_write,
> +	.device		= uart_console_device,
> +	.setup		= mvf_console_setup,
> +	.flags		= CON_PRINTBUFFER,
> +	.index		= -1,
> +	.data		= &mvf_reg,
> +};
> +
> +#define MVF_CONSOLE	(&mvf_console)
> +#else
> +#define MVF_CONSOLE	NULL
> +#endif
> +
> +static struct uart_driver mvf_reg = {
> +	.owner          = THIS_MODULE,
> +	.driver_name    = DRIVER_NAME,
> +	.dev_name       = DEV_NAME,
> +	.major          = SERIAL_IMX_MAJOR,
> +	.minor          = MINOR_START,
> +	.nr             = ARRAY_SIZE(mvf_ports),
> +	.cons           = MVF_CONSOLE,
> +};
> +
> +static int serial_mvf_suspend(struct platform_device *dev, pm_message_t state)
> +{
> +	struct mvf_port *sport = platform_get_drvdata(dev);
> +
> +	/* Enable UART wakeup */
> +
> +	if (sport)
> +		uart_suspend_port(&mvf_reg, &sport->port);

unnecessary test.

> +
> +	return 0;
> +}
> +
> +static int serial_mvf_resume(struct platform_device *dev)
> +{
> +	struct mvf_port *sport = platform_get_drvdata(dev);
> +
> +	if (sport)
> +		uart_resume_port(&mvf_reg, &sport->port);

ditto.

> +
> +	/* Disable UART wakeup */
> +
> +	return 0;
> +}
> +
> +static int serial_mvf_probe_dt(struct mvf_port *sport,
> +		struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	int ret;
> +
> +	if (!np)
> +		/* no device tree device */
> +		return 1;
> +
> +	ret = of_alias_get_id(np, "serial");
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to get alias id, errno %d\n", ret);
> +		return ret;
> +	}
> +	sport->port.line = ret;
> +
> +	if (of_get_property(np, "fsl,uart-fifo-mode", NULL))
> +		sport->fifo_en = 1;

Why is this configurable? Everybody wants FIFO support, right?

> +
> +	return 0;
> +}
> +
> +static int serial_mvf_probe(struct platform_device *pdev)
> +{
> +	struct mvf_port *sport;
> +	struct imxuart_platform_data *pdata;
> +	void __iomem *base;
> +	int ret = 0;
> +	struct resource *res;
> +
> +	sport = devm_kzalloc(&pdev->dev, sizeof(*sport), GFP_KERNEL);
> +	if (!sport)
> +		return -ENOMEM;
> +
> +	pdev->dev.coherent_dma_mask = 0;
> +
> +	ret = serial_mvf_probe_dt(sport, pdev);
> +	if (ret < 0)
> +		return ret ;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENODEV;
> +
> +	base = devm_ioremap(&pdev->dev, res->start, PAGE_SIZE);
> +	if (!base)
> +		return -ENOMEM;

devm_request_and_ioremap?

> +
> +	sport->port.dev = &pdev->dev;
> +	sport->port.mapbase = res->start;
> +	sport->port.membase = base;
> +	sport->port.type = PORT_MVF,
> +	sport->port.iotype = UPIO_MEM;
> +	sport->port.irq = platform_get_irq(pdev, 0);
> +	sport->port.fifosize = 32;
> +	sport->port.ops = &mvf_pops;
> +	sport->port.flags = UPF_BOOT_AUTOCONF;
> +	if (pdev->id >= 0)
> +		sport->port.line = pdev->id;
> +
> +	sport->clk = devm_clk_get(&pdev->dev, "ipg");
> +	if (IS_ERR(sport->clk)) {
> +		ret = PTR_ERR(sport->clk);
> +		dev_err(&pdev->dev, "failed to uart clk: %d\n", ret);
> +		return ret;
> +	}
> +
> +	clk_prepare_enable(sport->clk);
> +
> +	sport->port.uartclk = clk_get_rate(sport->clk);
> +
> +	mvf_ports[sport->port.line] = sport;
> +
> +	pdata = pdev->dev.platform_data;
> +
> +	/* all uarts support hardware RTS/CTS */
> +	sport->have_rtscts = 1;

This should either be configurable from the devicetree since not all
UARTs on all boards have routed the rts/cts pins out, or you should
not even have this variable.

> +
> +	if (pdata && pdata->init) {
> +		ret = pdata->init(pdev);
> +		if (ret)
> +			goto clkput;
> +	}

No. Drop this.

> +
> +	ret = uart_add_one_port(&mvf_reg, &sport->port);
> +
> +	if (ret)
> +		goto deinit;
> +	platform_set_drvdata(pdev, &sport->port);

This should be done *before* registering the device.

> +
> +	return 0;
> +deinit:
> +	if (pdata && pdata->exit)
> +		pdata->exit(pdev);
> +clkput:
> +	clk_disable_unprepare(sport->clk);
> +
> +	return ret;
> +}
> +
> +static int serial_mvf_remove(struct platform_device *pdev)
> +{
> +	struct imxuart_platform_data *pdata;
> +	struct mvf_port *sport = platform_get_drvdata(pdev);
> +
> +	pdata = pdev->dev.platform_data;
> +
> +	platform_set_drvdata(pdev, NULL);
> +
> +	if (sport)
> +		uart_remove_one_port(&mvf_reg, &sport->port);
> +
> +	clk_disable_unprepare(sport->clk);
> +
> +	if (pdata && pdata->exit)
> +		pdata->exit(pdev);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver serial_mvf_driver = {
> +	.probe		= serial_mvf_probe,
> +	.remove		= serial_mvf_remove,
> +
> +	.suspend	= serial_mvf_suspend,
> +	.resume		= serial_mvf_resume,
> +	.id_table       = mvf_uart_devtype,
> +	.driver		= {
> +		.name	= "mvf-uart",
> +		.owner	= THIS_MODULE,
> +		.of_match_table = mvf_uart_dt_ids,
> +	},
> +};
> +
> +static int __init mvf_serial_init(void)
> +{
> +	int ret;
> +
> +	pr_info("Serial: Vybrid Family driver\n");
> +
> +	ret = uart_register_driver(&mvf_reg);
> +	if (ret)
> +		return ret;
> +
> +	ret = platform_driver_register(&serial_mvf_driver);
> +	if (ret != 0)
> +		uart_unregister_driver(&mvf_reg);
> +
> +	return 0;
> +}
> +
> +static void __exit mvf_serial_exit(void)
> +{
> +	platform_driver_unregister(&serial_mvf_driver);
> +	uart_unregister_driver(&mvf_reg);
> +}
> +
> +module_init(mvf_serial_init);
> +module_exit(mvf_serial_exit);
> +
> +MODULE_DESCRIPTION("Vybrid Family serial port driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
> index 74c2bf7..ffb7192 100644
> --- a/include/uapi/linux/serial_core.h
> +++ b/include/uapi/linux/serial_core.h
> @@ -226,4 +226,7 @@
>  /* Rocketport EXPRESS/INFINITY */
>  #define PORT_RP2	102
>  
> +/* Freescale Vybrid uart */
> +#define PORT_MVF	103
> +
>  #endif /* _UAPILINUX_SERIAL_CORE_H */
> -- 
> 1.8.0
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
