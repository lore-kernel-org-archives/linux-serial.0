From: Martin Kaiser <martin@kaiser.cx>
Subject: Re: [PATCH 2/2] serial: imx: fix endless loop during suspend
Date: Tue, 2 Jan 2018 17:15:55 +0100
Message-ID: <20180102161555.GA4503@botnar.kaiser.cx>
References: <1514395632-15390-1-git-send-email-martin@kaiser.cx>
 <1514395632-15390-2-git-send-email-martin@kaiser.cx>
 <CAOMZO5AvFePCoKYQe7bt9bzFmdLYrgDyPLkepz99bJk7BTB0Lg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOMZO5AvFePCoKYQe7bt9bzFmdLYrgDyPLkepz99bJk7BTB0Lg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Sascha Hauer <kernel@pengutronix.de>, Philipp Zabel <p.zabel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, linux-serial@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Fabio,

thanks for testing my patch. Sorry for breaking suspend on your board.

Thus wrote Fabio Estevam (festevam@gmail.com):

> Which i.MX SoC did you use to test this patch?

I tested on an imx258.

> On a imx6q-cuboxi I am no longer able to enter in suspend with this
> path applied:

> # echo enabled > /sys/class/tty/ttymxc0/power/wakeup
> # echo mem > /sys/power/state
> [    9.766903] PM: suspend entry (deep)
> [    9.770658] PM: Syncing filesystems ... done.
> [    9.815312] Freezing user space processes ... (elapsed 0.001 seconds) done.
> [    9.824744] OOM killer disabled.
> [    9.827998] Freezing remaining freezable tasks ... (elapsed 0.001
> seconds) done.
> [    9.837351] Suspending console(s) (use no_console_suspend to debug)
> [    9.915495] PM: suspend devices took 0.080 seconds
> [    9.928746] PM: noirq suspend of devices failed
> [   10.196232] mmc0: queuing unknown CIS tuple 0x80 (2 bytes)
> [   10.198148] mmc0: queuing unknown CIS tuple 0x80 (3 bytes)
> [   10.200042] mmc0: queuing unknown CIS tuple 0x80 (3 bytes)
> [   10.203420] mmc0: queuing unknown CIS tuple 0x80 (7 bytes)
> [   10.206812] mmc0: queuing unknown CIS tuple 0x80 (7 bytes)
> [   10.263097] PM: resume devices took 0.330 seconds
> [   10.266639] ata1: SATA link down (SStatus 0 SControl 300)
> [   10.310305] OOM killer enabled.
> [   10.313458] Restarting tasks ... done.
> [   10.319568] PM: suspend exit
> sh: write error: Device or resource busy

> Even if I do not press anything in the console the system gets out of
> suspend automatically.

So the suspend_noirq step failed with -EBUSY.

My guess is that the following code path is taken

suspend_devices_and_enter()
   suspend_enter()
      dpm_suspend_noirq()
         dpm_noirq_suspend_devices()
            device_suspend_noirq()
               __device_suspend_noirq()
                  pm_wakeup_pending()

and pm_wakeup_pending() returns true. We'd then have an async_error
-EBUSY.

If that's the case, I don't understand why it happens for imx6q.
We should only have a pending wakeup event if wakeup_source_activate()
or ..._deactivate() has been called.

Seeing this kind of problem, I wonder if it's ok to move setting AWAKEN
from the suspend to the suspend_noirq step. The imx uart's interrupt is
now re-enabled and IRQD_WAKEUP_ARMED is set before we configure the uart
to generate such interrupts (by setting AWAKEN), whereas before, it was
the other way around. I'd be grateful if anyone could shed some light
on this. (Or more generally: When must the hardware be configured to
generate wakeup interrupts? Is it ok to do this in supend_noirq or must
it be done before?)

Fabio, could you post the output of

cat /sys/kernel/debug/suspend_stats

after supend failed, to confirm that we're failing below
device_suspend_noirq()?

Thanks,

   Martin
