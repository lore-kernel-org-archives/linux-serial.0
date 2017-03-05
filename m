From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] serial: 8250_dw: Fix breakage when HAVE_CLK=n
Date: Sun, 05 Mar 2017 01:44:33 +0100
Message-ID: <3772321.GSmxWtfp6p@phil>
References: <CAHp75Ved2h2WyWBokEOsDmAyB3w3iM=uh-9Bq01mU1ST4FapWQ@mail.gmail.com> <20170304130958.23655-1-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170304130958.23655-1-james.hogan@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: James Hogan <james.hogan@imgtec.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jason Uy <jason.uy@broadcom.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, David Daney <david.daney@cavium.com>, Russell King <linux@armlinux.org.uk>, linux-serial@vger.kernel.org, linux-clk@vger.kernel.org, linux-mips@linux-mips.org, bcm-kernel-feedback-list@broadcom.com
List-Id: linux-serial@vger.kernel.org

Am Samstag, 4. März 2017, 13:09:58 CET schrieb James Hogan:
> Commit 6a171b299379 ("serial: 8250_dw: Allow hardware flow control to be
> used") recently broke the 8250_dw driver on platforms which don't select
> HAVE_CLK, as dw8250_set_termios() gets confused by the behaviour of the
> fallback HAVE_CLK=n clock API in linux/clk.h which pretends everything
> is fine but returns (valid) NULL clocks and 0 HZ clock rates.
> 
> That 0 rate is written into the uartclk resulting in a crash at boot,
> e.g. on Cavium Octeon III based UTM-8 we get something like this:
> 
> 1180000000800.serial: ttyS0 at MMIO 0x1180000000800 (irq = 41, base_baud =
> 25000000) is a OCTEON ------------[ cut here ]------------
> WARNING: CPU: 2 PID: 1 at drivers/tty/serial/serial_core.c:441
> uart_get_baud_rate+0xfc/0x1f0 ...
> Call Trace:
> ...
> [<ffffffff8149c2e4>] uart_get_baud_rate+0xfc/0x1f0
> [<ffffffff814a5098>] serial8250_do_set_termios+0xb0/0x440
> [<ffffffff8149c710>] uart_set_options+0xe8/0x190
> [<ffffffff814a6cdc>] serial8250_console_setup+0x84/0x158
> [<ffffffff814a11ec>] univ8250_console_setup+0x54/0x70
> [<ffffffff811901a0>] register_console+0x1c8/0x418
> [<ffffffff8149f004>] uart_add_one_port+0x434/0x4b0
> [<ffffffff814a1af8>] serial8250_register_8250_port+0x2d8/0x440
> [<ffffffff814aa620>] dw8250_probe+0x388/0x5e8
> ...
> 
> The clock API is defined such that NULL is a valid clock handle so it
> wouldn't be right to check explicitly for NULL. Instead treat a
> clk_round_rate() return value of 0 as an error which prevents uartclk
> being overwritten.
> 
> Fixes: 6a171b299379 ("serial: 8250_dw: Allow hardware flow control to be
> used") Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Jason Uy <jason.uy@broadcom.com>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: David Daney <david.daney@cavium.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-serial@vger.kernel.org
> Cc: linux-clk@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: bcm-kernel-feedback-list@broadcom.com
> ---
>  drivers/tty/serial/8250/8250_dw.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c
> b/drivers/tty/serial/8250/8250_dw.c index 223ac234ddb2..e65808c482f1 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -267,6 +267,8 @@ static void dw8250_set_termios(struct uart_port *p,
> struct ktermios *termios, rate = clk_round_rate(d->clk, baud * 16);
>  	if (rate < 0)
>  		ret = rate;
> +	else if (rate == 0)
> +		ret = -ENOENT;
>  	else
>  		ret = clk_set_rate(d->clk, rate);
>  	clk_prepare_enable(d->clk);

Looks good
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
