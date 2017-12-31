From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 2/2] serial: imx: fix endless loop during suspend
Date: Sun, 31 Dec 2017 09:53:41 -0200
Message-ID: <CAOMZO5AvFePCoKYQe7bt9bzFmdLYrgDyPLkepz99bJk7BTB0Lg@mail.gmail.com>
References: <1514395632-15390-1-git-send-email-martin@kaiser.cx> <1514395632-15390-2-git-send-email-martin@kaiser.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1514395632-15390-2-git-send-email-martin@kaiser.cx>
Sender: stable-owner@vger.kernel.org
To: Martin Kaiser <martin@kaiser.cx>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Sascha Hauer <kernel@pengutronix.de>, Philipp Zabel <p.zabel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, linux-serial@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Martin,

On Wed, Dec 27, 2017 at 3:27 PM, Martin Kaiser <martin@kaiser.cx> wrote:
> Before we go into suspend mode, we enable the imx uart's interrupt for
> the awake bit in the UART Status Register 1. If, for some reason, the
> awake bit is already set before we enter suspend mode, we get an
> interrupt immediately when we enable interrupts for awake. The uart's
> clk_ipg is already disabled at this point. We end up in the interrupt
> handler, which usually tries to clear the awake bit. This doesn't work
> with the clock disabled. Therefore, we keep getting interrupts forever,
> resulting in an endless loop.
>
> Move the calls to serial_imx_enable_wakeup() into the _noirq functions,
> where interrupts are disabled and clk_ipg is active. This way, we can
> safely clear the awake bit and enable the imx interrupt for awake.
>
> Now that we do the wakeup configuration in .suspend_noirq, we need
> separate functions for .suspend_noirq and .freeze_noirq. However,
> .resume_noirq and .restore_noirq can still be shared. We just disable
> the wakeup source there, this does not conflict with hibernation.
>
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> Cc: stable@vger.kernel.org

Which i.MX SoC did you use to test this patch?

On a imx6q-cuboxi I am no longer able to enter in suspend with this
path applied:

# echo enabled > /sys/class/tty/ttymxc0/power/wakeup
# echo mem > /sys/power/state
[    9.766903] PM: suspend entry (deep)
[    9.770658] PM: Syncing filesystems ... done.
[    9.815312] Freezing user space processes ... (elapsed 0.001 seconds) done.
[    9.824744] OOM killer disabled.
[    9.827998] Freezing remaining freezable tasks ... (elapsed 0.001
seconds) done.
[    9.837351] Suspending console(s) (use no_console_suspend to debug)
[    9.915495] PM: suspend devices took 0.080 seconds
[    9.928746] PM: noirq suspend of devices failed
[   10.196232] mmc0: queuing unknown CIS tuple 0x80 (2 bytes)
[   10.198148] mmc0: queuing unknown CIS tuple 0x80 (3 bytes)
[   10.200042] mmc0: queuing unknown CIS tuple 0x80 (3 bytes)
[   10.203420] mmc0: queuing unknown CIS tuple 0x80 (7 bytes)
[   10.206812] mmc0: queuing unknown CIS tuple 0x80 (7 bytes)
[   10.263097] PM: resume devices took 0.330 seconds
[   10.266639] ata1: SATA link down (SStatus 0 SControl 300)
[   10.310305] OOM killer enabled.
[   10.313458] Restarting tasks ... done.
[   10.319568] PM: suspend exit
sh: write error: Device or resource busy

Even if I do not press anything in the console the system gets out of
suspend automatically.

Thanks
