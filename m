Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9D0449B13;
	Fri,  7 Aug 2026 06:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786083502; cv=none; b=HHi2MQK8+cNpNQrobZst0UNNKkXf2feeyo2z1i+PBHCfR1bh3rgAxsw4FIa81g0h9aBGSGNUrFu3rI+F+Ej5AG8OvmWT0aku84dNrWxn68PIzAYrUe1MyMTs14vXB9X1EY0lW3Tqt/CmTigA+OwdxU8wNq5SnHhpnAmqT3u0Ohk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786083502; c=relaxed/simple;
	bh=DAVl52DZz+iA4aC67Cg5p2xAocjOlnw839TM5l0F7c0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M96mK67thxTYLdGpgMP/+4qfFcOIZnbIg44Yzs9sRZZ37Zoa+c54jMVZ9EEdoUoKN0Nx1VJ7837LUSzR7gdvaRIght29nfmvedwcCxzJxtXE8ifkJ2oSDhHy/ElLifG4Hzp175GmVqvHP7xTMYVh8q9u5FZF2VRQHmlWG9TqLaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AAjddBdw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AAjddBdw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30AEB1F000E9;
	Fri,  7 Aug 2026 06:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786083500;
	bh=T7RiCq+OixB24tXy0yphDXTtbdvli+hcqFP6djSgmvU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=AAjddBdwih7jzkRKgEJcu7DARh1MVbeOQNKcoffAaCBuKnw4SIH57C78S9sVVb6hs
	 yy6ZhtY9idnh8WipcExuyqCB4EavxAJKgAKMloPEN59oJ+yBKTMjZadrTKO94N1Ywb
	 FiBkrg4GWlkAT/gWp/aCIDWFiyZkkVvebNqShFaqQx61xdmuBWuuGtykT5j1PNliwk
	 uYOEKQkXTVfPOHw8fYIPeewicBEEvh1XGvtEBSiUTMVtdQ0cZOHzWT7c0PXIjhfz+h
	 3wkk+QZcWzCQCyGfO/Rji/wdr2xlvMZ9SdkV477scbq0VBv6U4HRgh9VF1qh9OD4Kg
	 8fqhNT7YP7WCQ==
Message-ID: <13ad992e-c9e1-4fed-af45-32907def6516@kernel.org>
Date: Fri, 7 Aug 2026 08:18:14 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/10] serial: ambarella: add Ambarella UART driver
To: longzhao@ambarella.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, soc@lists.linux.dev
References: <20260806-longzhao-upstream-cv75-v2-v2-0-6b09707c5fe9@ambarella.com>
 <20260806-longzhao-upstream-cv75-v2-v2-8-6b09707c5fe9@ambarella.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20260806-longzhao-upstream-cv75-v2-v2-8-6b09707c5fe9@ambarella.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 06. 08. 26, 11:34, Long Zhao via B4 Relay wrote:
> Add an Ambarella UART driver with console support for early boot
> bring-up on CV75. Keep udelay() in wait_for_tx(); it runs under
> console/poll paths that may hold the port lock with IRQs disabled.
...
> diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
> index bba7b21a4a1d..5c951719528b 100644
> --- a/drivers/tty/serial/Makefile
> +++ b/drivers/tty/serial/Makefile
> @@ -26,6 +26,7 @@ obj-y += 8250/
>   
>   obj-$(CONFIG_SERIAL_ALTERA_JTAGUART)	+= altera_jtaguart.o
>   obj-$(CONFIG_SERIAL_ALTERA_UART)	+= altera_uart.o
> +obj-$(CONFIG_SERIAL_AMBARELLA)		+= ambarella_uart.o

I would put it after AMBA_*. That should be also the ascii order, right?

>   obj-$(CONFIG_SERIAL_AMBA_PL010)		+= amba-pl010.o
>   obj-$(CONFIG_SERIAL_AMBA_PL011)		+= amba-pl011.o
>   obj-$(CONFIG_SERIAL_GRLIB_GAISLER_APBUART) += apbuart.o
> diff --git a/drivers/tty/serial/ambarella_uart.c b/drivers/tty/serial/ambarella_uart.c
> new file mode 100644
> index 000000000000..7356b242f0ef
> --- /dev/null
> +++ b/drivers/tty/serial/ambarella_uart.c
> @@ -0,0 +1,1001 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include <linux/clk.h>
> +#include <linux/console.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/pinctrl/consumer.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm.h>
> +#include <linux/serial_reg.h>
> +#include <linux/serial_core.h>
> +#include <linux/sysrq.h>
> +#include <linux/tty.h>
> +#include <linux/tty_flip.h>
> +
> +#define UART_RB_OFFSET			0x00
> +#define UART_TH_OFFSET			0x00
> +#define UART_DLL_OFFSET			0x00
> +#define UART_IE_OFFSET			0x04
> +#define UART_DLH_OFFSET			0x04
> +#define UART_II_OFFSET			0x08
> +#define UART_FC_OFFSET			0x08
> +#define UART_LC_OFFSET			0x0c
> +#define UART_MC_OFFSET			0x10
> +#define UART_LS_OFFSET			0x14
> +#define UART_MS_OFFSET			0x18
> +#define UART_US_OFFSET			0x7c
> +#define UART_SRR_OFFSET			0x88

For me, this would be more understadable:
#define UART_IE		0x4
# define UART_IE_ERBFI		BIT(0)
...
# define UART_IE_ETOI		BIT(6)
# define UART_IE_ERETOI		BIT(7)
and so on.

That is:
  * define the bits near the offset
  * no _OFFSET suffix
  * use BIT()

...
> +#define UART_FIFO_SIZE			64
> +
> +#define DEFAULT_AMBARELLA_UART_MCR	0
> +#define DEFAULT_AMBARELLA_UART_IER	(UART_IE_ELSI | UART_IE_ERBFI | \
> +					 UART_IE_ETOI)
> +
> +#define AMBA_UART_MAX_NUM		8
> +
> +#define AMBA_UART_RESET_FLAG		0 /* bit 0 */

Perhaps convert this one to an enum?

> +/* Poll timeout in microseconds (atomic helpers use udelay). */
> +#define AMBARELLA_UART_TIMEOUT_US	1000000

USEC_PER_SEC


> +static inline void wait_for_tx(struct uart_port *port)
> +{
> +	u32 ls;
> +	int ret;
> +
> +	ret = readl_poll_timeout_atomic(port->membase + UART_LS_OFFSET, ls,
> +					ls & UART_LS_TEMT, 1,
> +					AMBARELLA_UART_TIMEOUT_US);
> +	if (likely(!ret))

How did you measure this "likely" matters?

> +		return;
> +
> +	/* Recover a stuck TX path so console/poll can continue. */
> +	writel_relaxed(UART_FC_RX_2_TO_FULL | UART_FC_TX_EMPTY |
> +			UART_FC_XMITR | UART_FC_RCVRR,
> +			port->membase + UART_FC_OFFSET);
> +	udelay(100);
> +	writel_relaxed(UART_FC_FIFOE | UART_FC_RX_2_TO_FULL |
> +			UART_FC_TX_EMPTY | UART_FC_XMITR |
> +			UART_FC_RCVRR,
> +			port->membase + UART_FC_OFFSET);
> +}
...
> +static void serial_ambarella_hw_setup(struct uart_port *port)
> +{
> +	struct ambarella_uart_port *amb_port = to_ambarella_uart_port(port);
> +
> +	if (!test_and_set_bit(AMBA_UART_RESET_FLAG, &amb_port->flags)) {
> +		if (amb_port->uart_pll)
> +			port->uartclk = clk_get_rate(amb_port->uart_pll);
> +		/* reset the whole UART only once */
> +		writel_relaxed(0x01, port->membase + UART_SRR_OFFSET);

Could you document also this bit in SRR (by a macro)?

> +		mdelay(1);

1 ms of spinning? That's very bad. Why this cannot be a sleep instead?

> +		writel_relaxed(0x00, port->membase + UART_SRR_OFFSET);
> +	}
> +
> +	writel_relaxed(UART_FC_FIFOE | UART_FC_RX_2_TO_FULL | UART_FC_TX_EMPTY |
> +			UART_FC_XMITR | UART_FC_RCVRR, port->membase + UART_FC_OFFSET);
> +	/* Keep interrupts disabled until the IRQ handler is registered. */
> +	serial_ambarella_ier_write(port, 0);
> +}
...> +static void serial_ambarella_transmit_chars(struct uart_port *port)

Any reason not to use uart_port_tx_limited()?

> +{
> +	struct tty_port *tport = &port->state->port;
> +	int count;
> +
> +	if (port->x_char) {
> +		writel_relaxed(port->x_char, port->membase + UART_TH_OFFSET);
> +		port->icount.tx++;
> +		port->x_char = 0;
> +		return;
> +	}
> +
> +	if (uart_tx_stopped(port) || kfifo_is_empty(&tport->xmit_fifo)) {
> +		__serial_ambarella_stop_tx(port);
> +		return;
> +	}
> +
> +	count = port->fifosize;
> +	while (count-- > 0) {
> +		unsigned char c;
> +
> +		if (tx_fifo_is_full(port))
> +			break;
> +
> +		if (!kfifo_peek(&tport->xmit_fifo, &c))
> +			break;
> +
> +		writel_relaxed(c, port->membase + UART_TH_OFFSET);
> +		kfifo_skip(&tport->xmit_fifo);
> +		port->icount.tx++;
> +		if (kfifo_is_empty(&tport->xmit_fifo))
> +			break;
> +	}
> +
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
> +		uart_write_wakeup(port);
> +	if (kfifo_is_empty(&tport->xmit_fifo))
> +		__serial_ambarella_stop_tx(port);
> +}
> +
> +static inline void serial_ambarella_check_modem_status(struct uart_port *port)
> +{
> +	u32 ms;
> +
> +	ms = __serial_ambarella_read_ms(port);
> +
> +	if (ms & UART_MS_RI)
> +		port->icount.rng++;
> +	if (ms & UART_MS_DSR)
> +		port->icount.dsr++;
> +	if (ms & UART_MS_DCTS)
> +		uart_handle_cts_change(port, (ms & UART_MS_CTS));
> +	if (ms & UART_MS_DDCD)
> +		uart_handle_dcd_change(port, (ms & UART_MS_DCD));
> +
> +	wake_up_interruptible(&port->state->port.delta_msr_wait);
> +}
> +
> +static irqreturn_t serial_ambarella_irq(int irq, void *dev_id)
> +{
> +	struct uart_port *port = dev_id;
> +	u32 ii;
> +
> +	scoped_guard(uart_port_lock_irqsave, port) {

This needs not to be scoped. Just guard().

> +		ii = readl_relaxed(port->membase + UART_II_OFFSET);
> +		switch (ii & 0x0F) {
> +		case UART_II_MODEM_STATUS_CHANGED:
> +			serial_ambarella_check_modem_status(port);
> +			break;
> +		case UART_II_THR_EMPTY:
> +			serial_ambarella_transmit_chars(port);
> +			break;
> +		case UART_II_RCV_STATUS:
> +		case UART_II_RCV_DATA_AVAIL:
> +			serial_ambarella_receive_chars(port, 0);
> +			break;
> +		case UART_II_CHAR_TIMEOUT_FIFO_EMPTY:
> +			/* Clear ERETOI to dismiss timeout-with-empty-FIFO IRQ */
> +			serial_ambarella_ier_toggle(port, UART_IE_ERETOI);
> +			fallthrough;
> +		case UART_II_CHAR_TIMEOUT:
> +			serial_ambarella_receive_chars(port, 1);

Hmm, the last param looks like a bool. Why do you have tmo declared as u32?

> +			break;
> +		case UART_II_NO_INT_PENDING:
> +			break;
> +		default:
> +			pr_debug("%s: 0x%x\n", __func__, ii);

Are you sure you want to dump the unknown irq for every interrupt (on 
DEBUG)?

> +			break;
> +		}
> +	}
> +
> +	return IRQ_HANDLED;
> +}
...> +static unsigned int serial_ambarella_tx_empty(struct uart_port *port)
> +{
> +	unsigned int lsr;
> +
> +	guard(uart_port_lock_irqsave)(port);
> +	lsr = readl_relaxed(port->membase + UART_LS_OFFSET);

u32 lsr = ...

No need for the previous declaration.

> +
> +	return ((lsr & (UART_LS_TEMT | UART_LS_THRE)) ==
> +		(UART_LS_TEMT | UART_LS_THRE)) ? TIOCSER_TEMT : 0;
> +}
...
> +static void serial_ambarella_set_termios(struct uart_port *port,
> +					 struct ktermios *termios,
> +					 const struct ktermios *old)
> +{
> +	struct ambarella_uart_port *amb_port = to_ambarella_uart_port(port);
> +	unsigned int baud, quot;
> +	u32 lc = 0x0;
> +
> +	port->uartclk = clk_get_rate(amb_port->uart_pll);
> +	switch (termios->c_cflag & CSIZE) {
> +	case CS5:
> +		lc |= UART_LC_CLS_5_BITS;
> +		break;
> +	case CS6:
> +		lc |= UART_LC_CLS_6_BITS;
> +		break;
> +	case CS7:
> +		lc |= UART_LC_CLS_7_BITS;
> +		break;
> +	case CS8:
> +	default:
> +		lc |= UART_LC_CLS_8_BITS;
> +		break;
> +	}
> +
> +	if (termios->c_cflag & CSTOPB)
> +		lc |= UART_LC_STOP_2BIT;
> +	else
> +		lc |= UART_LC_STOP_1BIT;
> +
> +	if (termios->c_cflag & PARENB) {
> +		if (termios->c_cflag & PARODD)
> +			lc |= (UART_LC_PEN | UART_LC_ODD_PARITY);
> +		else
> +			lc |= (UART_LC_PEN | UART_LC_EVEN_PARITY);
> +	}
> +
> +	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk / 16);
> +	quot = uart_get_divisor(port, baud);
> +
> +	scoped_guard(uart_port_lock_irqsave, port) {

No need for scoped.

> +		uart_update_timeout(port, termios->c_cflag, baud);
> +
> +		port->read_status_mask = UART_LSR_OE | UART_LSR_THRE | UART_LSR_DR;
> +		if (termios->c_iflag & INPCK)
> +			port->read_status_mask |= UART_LSR_FE | UART_LSR_PE;
> +		if (termios->c_iflag & (BRKINT | PARMRK))
> +			port->read_status_mask |= UART_LSR_BI;
> +
> +		port->ignore_status_mask = 0;
> +		if (termios->c_iflag & IGNPAR)
> +			port->ignore_status_mask |= UART_LSR_PE | UART_LSR_FE;
> +		if (termios->c_iflag & IGNBRK) {
> +			port->ignore_status_mask |= UART_LSR_BI;
> +			if (termios->c_iflag & IGNPAR)
> +				port->ignore_status_mask |= UART_LSR_OE;
> +		}
> +		if ((termios->c_cflag & CREAD) == 0)
> +			port->ignore_status_mask |= UART_LSR_DR;
> +
> +		if ((termios->c_cflag & CRTSCTS) == 0) {
> +			amb_port->mcr &= ~UART_MC_AFCE;
> +			port->status &= ~UPSTAT_AUTOCTS;
> +		} else {
> +			amb_port->mcr |= UART_MC_AFCE;
> +			port->status |= UPSTAT_AUTOCTS;
> +		}
> +
> +		writel_relaxed(UART_LC_DLAB, port->membase + UART_LC_OFFSET);
> +		writel_relaxed(quot & 0xff, port->membase + UART_DLL_OFFSET);
> +		writel_relaxed((quot >> 8) & 0xff, port->membase + UART_DLH_OFFSET);
> +		writel_relaxed(lc, port->membase + UART_LC_OFFSET);
> +		if (UART_ENABLE_MS(port, termios->c_cflag))
> +			__serial_ambarella_enable_ms(port);
> +		else
> +			__serial_ambarella_disable_ms(port);
> +		serial_ambarella_set_mctrl(port, port->mctrl);
> +	}
> +}
> +
> +static void serial_ambarella_pm(struct uart_port *port,
> +				unsigned int state, unsigned int oldstate)
> +{
> +}
> +
> +static void serial_ambarella_release_port(struct uart_port *port)
> +{
> +}
> +
> +static int serial_ambarella_request_port(struct uart_port *port)
> +{
> +	return 0;
> +}
> +
> +static void serial_ambarella_config_port(struct uart_port *port, int flags)
> +{
> +}

No need for empty definitions. The hooks are optional. We should 
document this, likely.

> +static int serial_ambarella_verify_port(struct uart_port *port,
> +					struct serial_struct *ser)
> +{
> +	int rval = 0;

You can return immediately, without the need for this variable, right?

> +
> +	if (ser->type != PORT_UNKNOWN && ser->type != PORT_UART00)
> +		rval = -EINVAL;
> +	if (port->irq != ser->irq)
> +		rval = -EINVAL;
> +	if (ser->io_type != SERIAL_IO_MEM)
> +		rval = -EINVAL;
> +
> +	return rval;
> +}
...
> +static int serial_ambarella_probe(struct platform_device *pdev)
> +{
> +	struct ambarella_uart_port *amb_port;
> +	struct resource *mem;
> +	struct pinctrl *pinctrl;
> +	int irq, id, rval;
> +
> +	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!mem) {
> +		dev_err(&pdev->dev, "no mem resource!\n");
> +		return -ENODEV;
> +	}
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(&pdev->dev, "no irq resource!\n");
> +		return -ENODEV;
> +	}
> +
> +	id = of_alias_get_id(pdev->dev.of_node, "serial");
> +	if (id < 0 || id >= serial_ambarella_reg.nr) {
> +		dev_err(&pdev->dev, "Invalid uart ID %d!\n", id);
> +		return -ENXIO;
> +	}
> +
> +	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> +	if (IS_ERR(pinctrl)) {
> +		dev_err(&pdev->dev, "Failed to request pinctrl\n");
> +		return PTR_ERR(pinctrl);
> +	}
> +
> +	amb_port = &ambarella_port[id];
> +
> +	amb_port->uart_pll = devm_clk_get_enabled(&pdev->dev, NULL);
> +	if (IS_ERR(amb_port->uart_pll)) {
> +		dev_err(&pdev->dev, "Get uart clk failed!\n");
> +		return PTR_ERR(amb_port->uart_pll);
> +	}
> +
> +	amb_port->mcr = DEFAULT_AMBARELLA_UART_MCR;
> +
> +	amb_port->port.dev = &pdev->dev;
> +	amb_port->port.type = PORT_UART00;
> +	amb_port->port.iotype = UPIO_MEM;
> +	amb_port->port.fifosize = UART_FIFO_SIZE;
> +	amb_port->port.uartclk = clk_get_rate(amb_port->uart_pll);
> +	amb_port->port.ops = &serial_ambarella_pops;
> +	amb_port->port.irq = irq;
> +	amb_port->port.line = id;
> +	amb_port->port.mapbase = mem->start;
> +	amb_port->port.membase = devm_ioremap_resource(&pdev->dev, mem);
> +	if (IS_ERR(amb_port->port.membase))
> +		return PTR_ERR(amb_port->port.membase);
> +
> +	rval = uart_add_one_port(&serial_ambarella_reg, &amb_port->port);
> +	if (rval < 0)
> +		dev_err(&pdev->dev, "failed to add port: %d, %d!\n", id, rval);
> +
> +	platform_set_drvdata(pdev, amb_port);

You set this even on failure. Does it matter? I don't know.

> +
> +	return rval;
> +}
> +
> +static void serial_ambarella_remove(struct platform_device *pdev)
> +{
> +	struct ambarella_uart_port *amb_port;
> +
> +	amb_port = platform_get_drvdata(pdev);

This can be amended to the declaration.

> +	uart_remove_one_port(&serial_ambarella_reg, &amb_port->port);
> +}
> +

thanks,
-- 
js
suse labs
