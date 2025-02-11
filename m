Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C023B1EB192;
	Tue, 11 Feb 2025 07:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739258633; cv=none; b=n4Xqa6gtxPum9lGVwr+LsE55oSpqJLEy1zNiBML4ygqdlIkB1SOg3JGU8iAReRHES53HmudvJFqFIiTpt8xHPu/zj4ZLeGVKQYm5/cDm1byKCkx7NKYEiwHVdJDuG7K4n7PZgxDPPrgW4KsSEhDz0QbDee01g1p6a7mNVeBdFY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739258633; c=relaxed/simple;
	bh=MGiceWLlaLzE/pZooghjDJCOhsa08q6pMK1rpKL5oqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PIFUoQGus8WOwu2jUJsC9WW9EzSCY4ckvjd4r+FHRC2KyiZ0od41HM3jzDtETiK4I5XRtR3RM/xolYySi3hlO/XbXP3wqWZuBJX6HM5RDNGzf0d41DU1FP8XLPlr/PGyJdbRN1F0LpiDKsMbjJZP4UxksmgY6+hJTubSAZqrnmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7k4IGqE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7k4IGqE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FAD4C4CEDD;
	Tue, 11 Feb 2025 07:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739258633;
	bh=MGiceWLlaLzE/pZooghjDJCOhsa08q6pMK1rpKL5oqY=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=T7k4IGqEmcIHCc3YXHGzvLGhVCTXzKGjXqZ8ndpaM0A0UzA/WNcxtObioCdVLCsYr
	 +YWbxNaa8c3V01qLWtERv+MlGHDYE1pIV7NYil8w1qPLWHA1bAnmVlv+8h6xtOzbX6
	 qVkm9saILn/twMASjmkArnkxyd0cKqa6d05fnHHHYgzMVoSh/owqMEyjTrzw/HYiFX
	 osD9G9JAKYGdW49qSq76AmZ64AV05rph6gUi1CEFhFu/qw1Z/6AnssnSusGfpryuEO
	 oRl3jGopbJYKGKjzwAGYNogZ4QOAQIbiNG+2Q6XRbwas4qELQUp38iCwuOrzMrqW47
	 vFEkF6ZFmfWqA==
Message-ID: <974ae61f-6883-40fb-b5b1-27139c0f07df@kernel.org>
Date: Tue, 11 Feb 2025 08:23:47 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] serial: tegra-utc: Add driver for Tegra UART Trace
 Controller (UTC)
To: Kartik Rajput <kkartik@nvidia.com>, gregkh@linuxfoundation.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 thierry.reding@gmail.com, jonathanh@nvidia.com, hvilleneuve@dimonoff.com,
 arnd@kernel.org, geert+renesas@glider.be, robert.marko@sartura.hr,
 schnelle@linux.ibm.com, andriy.shevchenko@linux.intel.com,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20250211061945.18836-1-kkartik@nvidia.com>
 <20250211061945.18836-3-kkartik@nvidia.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20250211061945.18836-3-kkartik@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11. 02. 25, 7:19, Kartik Rajput wrote:
> The Tegra264 SoC supports the UTC (UART Trace Controller), which allows
> multiple firmware clients (up to 16) to share a single physical UART.
> Each client is provided with its own interrupt and has access to a
> 128-character wide FIFO for both transmit (TX) and receive (RX)
> operations.
> 
> Add tegra-utc driver to support Tegra UART Trace Controller (UTC)
> client.
> 
> Signed-off-by: Kartik Rajput <kkartik@nvidia.com>

> --- /dev/null
> +++ b/drivers/tty/serial/tegra-utc.c
> @@ -0,0 +1,622 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// SPDX-FileCopyrightText: Copyright (c) 2025 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
> +/*
> + * NVIDIA Tegra UTC (UART Trace Controller) driver.
> + */
> +
> +#include <linux/console.h>
> +#include <linux/kthread.h>

Do you really use kthread somewhere?

> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/serial.h>
> +#include <linux/serial_core.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>

What's the reason for string.h?

> +#include <linux/tty.h>
> +#include <linux/tty_flip.h>
> +
> +#define TEGRA_UTC_ENABLE			0x0
> +#define TEGRA_UTC_ENABLE_CLIENT_ENABLE		BIT(0)
> +
> +#define TEGRA_UTC_FIFO_THRESHOLD		0x8
> +
> +#define TEGRA_UTC_COMMAND			0xc
> +#define TEGRA_UTC_COMMAND_FLUSH			BIT(1)
> +#define TEGRA_UTC_COMMAND_RESET			BIT(0)
> +
> +#define TEGRA_UTC_DATA				0x20
> +
> +#define TEGRA_UTC_FIFO_STATUS			0x100
> +#define TEGRA_UTC_FIFO_TIMEOUT			BIT(4)
> +#define TEGRA_UTC_FIFO_OVERFLOW			BIT(3)
> +#define TEGRA_UTC_FIFO_REQ			BIT(2)
> +#define TEGRA_UTC_FIFO_FULL			BIT(1)
> +#define TEGRA_UTC_FIFO_EMPTY			BIT(0)

It looks a bit weird to order bits from MSB to LSB.

> +#define TEGRA_UTC_FIFO_OCCUPANCY		0x104
> +
> +#define TEGRA_UTC_INTR_STATUS			0x108
> +#define TEGRA_UTC_INTR_SET			0x10c
> +#define TEGRA_UTC_INTR_MASK			0x110
> +#define TEGRA_UTC_INTR_CLEAR			0x114
> +#define TEGRA_UTC_INTR_TIMEOUT			BIT(4)
> +#define TEGRA_UTC_INTR_OVERFLOW			BIT(3)
> +#define TEGRA_UTC_INTR_REQ			BIT(2)
> +#define TEGRA_UTC_INTR_FULL			BIT(1)
> +#define TEGRA_UTC_INTR_EMPTY			BIT(0)
> +
> +#define UART_NR					16
> +
> +struct tegra_utc_soc {
> +	unsigned int fifosize;

What is this struct good for, given you use a single value?

> +struct tegra_utc_port {
> +	const struct tegra_utc_soc *soc;
> +#if IS_ENABLED(CONFIG_SERIAL_TEGRA_UTC_CONSOLE)
> +	struct console console;
> +#endif
> +	struct uart_port port;
> +
> +	void __iomem *rx_base;
> +	void __iomem *tx_base;
> +
> +	u32 tx_irqmask;
> +	u32 rx_irqmask;
> +
> +	u32 tx_threshold;
> +	u32 rx_threshold;
> +	int irq;

Why can't uart_port::irq be used instead?

> +static bool tegra_utc_tx_char(struct tegra_utc_port *tup, u8 c)
> +{
> +	if (tegra_utc_tx_readl(tup, TEGRA_UTC_FIFO_STATUS) & TEGRA_UTC_FIFO_FULL)
> +		return false;
> +
> +	tegra_utc_tx_writel(tup, c, TEGRA_UTC_DATA);
> +
> +	return true;
> +}
> +
> +static bool tegra_utc_tx_chars(struct tegra_utc_port *tup)

To the least, you do not account TX stats. Why not to use uart_port_tx()?

> +{
> +	struct tty_port *tport = &tup->port.state->port;
> +	u8 c;
> +
> +	if (tup->port.x_char) {
> +		if (!tegra_utc_tx_char(tup, tup->port.x_char))
> +			return true;
> +
> +		tup->port.x_char = 0;
> +	}
> +
> +	if (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(&tup->port)) {
> +		tegra_utc_stop_tx(&tup->port);
> +		return false;
> +	}
> +
> +	while (kfifo_peek(&tport->xmit_fifo, &c)) {
> +		if (!tegra_utc_tx_char(tup, c))
> +			break;
> +
> +		kfifo_skip(&tport->xmit_fifo);
> +	}
> +
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
> +		uart_write_wakeup(&tup->port);
> +
> +	if (kfifo_is_empty(&tport->xmit_fifo)) {
> +		tegra_utc_stop_tx(&tup->port);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +static void tegra_utc_rx_chars(struct tegra_utc_port *tup)
> +{
> +	struct tty_port *port = &tup->port.state->port;
> +	unsigned int max_chars = 256;
> +	unsigned int flag;

Useless variable.

> +	u32 status;
> +	int sysrq;
> +	u32 ch;
> +
> +	while (--max_chars) {
> +		status = tegra_utc_rx_readl(tup, TEGRA_UTC_FIFO_STATUS);
> +		if (status & TEGRA_UTC_FIFO_EMPTY)
> +			break;
> +
> +		ch = tegra_utc_rx_readl(tup, TEGRA_UTC_DATA);
> +		flag = TTY_NORMAL;
> +		tup->port.icount.rx++;
> +
> +		if (status & TEGRA_UTC_FIFO_OVERFLOW)
> +			tup->port.icount.overrun++;
> +
> +		uart_port_unlock(&tup->port);
> +		sysrq = uart_handle_sysrq_char(&tup->port, ch & 0xff);

No need for "& 0xff".

> +		uart_port_lock(&tup->port);
> +
> +		if (!sysrq)
> +			tty_insert_flip_char(port, ch, flag);

You do not mask 'ch' here either. Both functions take 'u8'.

> +	}
> +
> +	tty_flip_buffer_push(port);
> +}
> +
> +static irqreturn_t tegra_utc_isr(int irq, void *dev_id)
> +{
> +	struct tegra_utc_port *tup = dev_id;
> +	unsigned long flags;
> +	u32 status;
> +
> +	uart_port_lock_irqsave(&tup->port, &flags);
> +
> +	/* Process RX_REQ and RX_TIMEOUT interrupts. */
> +	do {
> +		status = tegra_utc_rx_readl(tup, TEGRA_UTC_INTR_STATUS) & tup->rx_irqmask;
> +		if (status) {
> +			tegra_utc_rx_writel(tup, tup->rx_irqmask, TEGRA_UTC_INTR_CLEAR);
> +			tegra_utc_rx_chars(tup);
> +		}
> +	} while (status);
> +
> +	/* Process TX_REQ interrupt. */
> +	do {
> +		status = tegra_utc_tx_readl(tup, TEGRA_UTC_INTR_STATUS) & tup->tx_irqmask;
> +		if (status) {
> +			tegra_utc_tx_writel(tup, tup->tx_irqmask, TEGRA_UTC_INTR_CLEAR);
> +			tegra_utc_tx_chars(tup);
> +		}
> +	} while (status);
> +
> +	uart_port_unlock_irqrestore(&tup->port, flags);
> +
> +	return IRQ_HANDLED;

You do not let the irq subsystem to kill this IRQ if you do not handle 
it above (in case HW gets mad, triggers IRQ, but does not set rx/tx 
flags). That is, return IRQ_HANDLED only when you really handled it 
(some status above was nonzero).

> +}

> +static int tegra_utc_startup(struct uart_port *port)
> +{
> +	struct tegra_utc_port *tup = container_of(port, struct tegra_utc_port, port);
> +	int ret;
> +
> +	tegra_utc_hw_init(tup);
> +
> +	ret = request_irq(tup->irq, tegra_utc_isr, 0, dev_name(port->dev), tup);

Just asking: so it can never be shared, right?

> +	if (ret < 0) {
> +		dev_err(port->dev, "failed to register interrupt handler\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void tegra_utc_shutdown(struct uart_port *port)
> +{
> +	struct tegra_utc_port *tup = container_of(port, struct tegra_utc_port, port);
> +
> +	tegra_utc_rx_writel(tup, 0x0, TEGRA_UTC_ENABLE);

Writes cannot be posted on this bus, right?

> +	free_irq(tup->irq, tup);
> +}
...
> +static int tegra_utc_get_poll_char(struct uart_port *port)
> +{
> +	struct tegra_utc_port *tup = container_of(port, struct tegra_utc_port, port);
> +
> +	while (tegra_utc_rx_readl(tup, TEGRA_UTC_FIFO_STATUS) & TEGRA_UTC_FIFO_EMPTY)
> +		cpu_relax();

Hmm, there should be a timeout. Can't you use read_poll_timeout_atomic()?

> +	return tegra_utc_rx_readl(tup, TEGRA_UTC_DATA);
> +}
> +
> +static void tegra_utc_put_poll_char(struct uart_port *port, unsigned char ch)
> +{
> +	struct tegra_utc_port *tup = container_of(port, struct tegra_utc_port, port);
> +
> +	while (tegra_utc_tx_readl(tup, TEGRA_UTC_FIFO_STATUS) & TEGRA_UTC_FIFO_FULL)
> +		cpu_relax();

Detto.

> +	tegra_utc_tx_writel(tup, ch, TEGRA_UTC_DATA);
> +}
> +
> +#endif


> +static void tegra_utc_console_write(struct console *cons, const char *s, unsigned int count)
> +{
> +	struct tegra_utc_port *tup = container_of(cons, struct tegra_utc_port, console);
> +	unsigned long flags;
> +	int locked = 1;
> +
> +	if (tup->port.sysrq || oops_in_progress)
> +		locked = uart_port_trylock_irqsave(&tup->port, &flags);
> +	else
> +		uart_port_lock_irqsave(&tup->port, &flags);
> +
> +	while (count) {
> +		u32 burst_size = tup->soc->fifosize;
> +
> +		burst_size -= tegra_utc_tx_readl(tup, TEGRA_UTC_FIFO_OCCUPANCY);
> +		if (count < burst_size)
> +			burst_size = count;
> +
> +		uart_console_write(&tup->port, s, burst_size, tegra_utc_console_putchar);
> +
> +		count -= burst_size;
> +		s += burst_size;
> +	};
> +
> +	if (locked)
> +		uart_port_unlock_irqrestore(&tup->port, flags);
> +}
> +
> +static int tegra_utc_console_setup(struct console *cons, char *options)
> +{
> +	struct tegra_utc_port *tup = container_of(cons, struct tegra_utc_port, console);
> +
> +	tegra_utc_init_tx(tup);
> +
> +	return 0;
> +}
> +#endif
> +
> +static struct uart_driver tegra_utc_driver = {
> +	.driver_name	= "tegra-utc",
> +	.dev_name	= "ttyUTC",
> +	.nr		= UART_NR
> +};
> +
> +static void tegra_utc_setup_port(struct device *dev, struct tegra_utc_port *tup)
> +{
> +	tup->port.dev		= dev;
> +	tup->port.fifosize	= tup->soc->fifosize;
> +	tup->port.flags		= UPF_BOOT_AUTOCONF;
> +	tup->port.iotype	= UPIO_MEM;
> +	tup->port.ops		= &tegra_utc_uart_ops;
> +	tup->port.type		= PORT_TEGRA_TCU;
> +	tup->port.private_data	= tup;
> +
> +#if IS_ENABLED(CONFIG_SERIAL_TEGRA_UTC_CONSOLE)
> +	strscpy(tup->console.name, "ttyUTC", sizeof(tup->console.name));
> +	tup->console.write	= tegra_utc_console_write;
> +	tup->console.device	= uart_console_device;
> +	tup->console.setup	= tegra_utc_console_setup;
> +	tup->console.flags	= CON_PRINTBUFFER | CON_CONSDEV | CON_ANYTIME;

New code shall be CON_NBCON compatible. You should implement 
::write_atomic/thread et al. instead of bare ::write.

> +	tup->console.data	= &tegra_utc_driver;
> +#endif
> +
> +	uart_read_port_properties(&tup->port);
> +}

> +static void tegra_utc_remove(struct platform_device *pdev)
> +{
> +	struct tegra_utc_port *tup = platform_get_drvdata(pdev);
> +

No unregister_console()?

> +	uart_remove_one_port(&tegra_utc_driver, &tup->port);
> +}

thanks,
-- 
js
suse labs
