From: Jason Uy <jason.uy@broadcom.com>
Subject: RE: [PATCH] serial: 8250_dw: Fix breakage when HAVE_CLK=n
Date: Mon, 6 Mar 2017 15:38:47 -0800
Message-ID: <18720dd546d32a1455fb17ad46ee73e4@mail.gmail.com>
References: <CAHp75Ved2h2WyWBokEOsDmAyB3w3iM=uh-9Bq01mU1ST4FapWQ@mail.gmail.com>
 <20170304130958.23655-1-james.hogan@imgtec.com> <CAHp75Vc=VmxvkqjP7nY6K4CKXBJC-NND0CUMbzwjV2nmQ-5OTw@mail.gmail.com>
 <20170306101603.GW996@jhogan-linux.le.imgtec.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20170306101603.GW996@jhogan-linux.le.imgtec.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: James Hogan <james.hogan@imgtec.com>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Heiko Stuebner <heiko@sntech.de>, David Daney <david.daney@cavium.com>, Russell King <linux@armlinux.org.uk>, linux-serial@vger.kernel.org, linux-clk@vger.kernel.org, linux-mips@linux-mips.org, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>
List-Id: linux-serial@vger.kernel.org

Looks good
Reviewed-by: Jason Uy <jason.uy@broadcom.com>

-----Original Message-----
From: James Hogan [mailto:james.hogan@imgtec.com]
Sent: March-06-17 2:16 AM
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel@vger.kernel.org; Greg Kroah-Hartman
<gregkh@linuxfoundation.org>; Andy Shevchenko
<andriy.shevchenko@linux.intel.com>; Jason Uy <jason.uy@broadcom.com>;
Kefeng Wang <wangkefeng.wang@huawei.com>; Heiko Stuebner <heiko@sntech.de>;
David Daney <david.daney@cavium.com>; Russell King <linux@armlinux.org.uk>;
linux-serial@vger.kernel.org; linux-clk@vger.kernel.org;
linux-mips@linux-mips.org; bcm-kernel-feedback-list
<bcm-kernel-feedback-list@broadcom.com>
Subject: Re: [PATCH] serial: 8250_dw: Fix breakage when HAVE_CLK=n

On Sat, Mar 04, 2017 at 04:37:17PM +0200, Andy Shevchenko wrote:
> On Sat, Mar 4, 2017 at 3:09 PM, James Hogan <james.hogan@imgtec.com>
> wrote:
> > Commit 6a171b299379 ("serial: 8250_dw: Allow hardware flow control
> > to be
> > used") recently broke the 8250_dw driver on platforms which don't
> > select HAVE_CLK, as dw8250_set_termios() gets confused by the
> > behaviour of the fallback HAVE_CLK=n clock API in linux/clk.h which
> > pretends everything is fine but returns (valid) NULL clocks and 0 HZ
> > clock rates.
> >
> > That 0 rate is written into the uartclk resulting in a crash at
> > boot, e.g. on Cavium Octeon III based UTM-8 we get something like this:
> >
> > 1180000000800.serial: ttyS0 at MMIO 0x1180000000800 (irq = 41,
> > base_baud = 25000000) is a OCTEON ------------[ cut here
> > ]------------
> > WARNING: CPU: 2 PID: 1 at drivers/tty/serial/serial_core.c:441
> > uart_get_baud_rate+0xfc/0x1f0 ...
> > Call Trace:
> > ...
> > [<ffffffff8149c2e4>] uart_get_baud_rate+0xfc/0x1f0
> > [<ffffffff814a5098>] serial8250_do_set_termios+0xb0/0x440
> > [<ffffffff8149c710>] uart_set_options+0xe8/0x190
> > [<ffffffff814a6cdc>] serial8250_console_setup+0x84/0x158
> > [<ffffffff814a11ec>] univ8250_console_setup+0x54/0x70
> > [<ffffffff811901a0>] register_console+0x1c8/0x418
> > [<ffffffff8149f004>] uart_add_one_port+0x434/0x4b0
> > [<ffffffff814a1af8>] serial8250_register_8250_port+0x2d8/0x440
> > [<ffffffff814aa620>] dw8250_probe+0x388/0x5e8 ...
> >
> > The clock API is defined such that NULL is a valid clock handle so
> > it wouldn't be right to check explicitly for NULL. Instead treat a
> > clk_round_rate() return value of 0 as an error which prevents
> > uartclk being overwritten.
> >
>
> You forgot to add that it is dependent to Heiko's patch
> http://www.spinics.net/lists/linux-serial/msg25314.html

Indeed I did. Sorry about that.

>
> Patch looks good to me and shouldn't bring any regression to Intel
> hardware (x86 is using clock framework).
>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Thanks
James
