From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2] serial: imx: fix endless loop during suspend
Date: Fri, 5 Jan 2018 15:31:07 -0200
Message-ID: <CAOMZO5BZZs3j24_5LoKFz8Juz3xKS3aTxbpOb82zwoKHZJum9w@mail.gmail.com>
References: <1514395632-15390-1-git-send-email-martin@kaiser.cx> <1515170803-31662-1-git-send-email-martin@kaiser.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1515170803-31662-1-git-send-email-martin@kaiser.cx>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Kaiser <martin@kaiser.cx>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sascha Hauer <kernel@pengutronix.de>, Jiri Slaby <jslaby@suse.com>, Philipp Zabel <p.zabel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Martin,

On Fri, Jan 5, 2018 at 2:46 PM, Martin Kaiser <martin@kaiser.cx> wrote:

> Hi Fabio and all,
>
> here's a different approach for fixing the awake issue that I see on my
> board. I tried to stick as much as possible to the original order in
> which the operations were done. Could you do a quick check on imx6q?

suspend_stats looks better now:

#  cat /sys/kernel/debug/suspend_stats
success: 8
fail: 0
failed_freeze: 0
failed_prepare: 0
failed_suspend: 0
failed_suspend_late: 0
failed_suspend_noirq: 0
failed_resume: 0
failed_resume_early: 0
failed_resume_noirq: 0
failures:
  last_failed_dev:

  last_failed_errno:    0
                        0
  last_failed_step:

However the board is still automatically returning from resume (I
haven't entered any char in the console)

# echo mem > /sys/power/state
[  186.723470] PM: suspend entry (deep)
[  186.727107] PM: Syncing filesystems ... done.
[  186.735016] Freezing user space processes ... (elapsed 0.001 seconds) done.
[  186.743640] OOM killer disabled.
[  186.746888] Freezing remaining freezable tasks ... (elapsed 0.001
seconds) done.
[  186.756174] Suspending console(s) (use no_console_suspend to debug)
[  186.828645] PM: suspend devices took 0.060 seconds
[  186.837771] Disabling non-boot CPUs ...
[  187.014044] Enabling non-boot CPUs ...
[  187.015057] CPU1 is up
[  187.016003] CPU2 is up
[  187.016988] CPU3 is up
[  187.294341] mmc0: queuing unknown CIS tuple 0x80 (2 bytes)
[  187.296228] mmc0: queuing unknown CIS tuple 0x80 (3 bytes)
[  187.298111] mmc0: queuing unknown CIS tuple 0x80 (3 bytes)
[  187.301490] mmc0: queuing unknown CIS tuple 0x80 (7 bytes)
[  187.304873] mmc0: queuing unknown CIS tuple 0x80 (7 bytes)
[  187.354759] ata1: SATA link down (SStatus 0 SControl 300)
[  187.359840] PM: resume devices took 0.340 seconds
[  187.417332] OOM killer enabled.
[  187.420487] Restarting tasks ... done.
[  187.425435] PM: suspend exit
