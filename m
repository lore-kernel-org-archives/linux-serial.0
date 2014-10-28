From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 1/4] serial: imx: Fix the reporting of interrupts
Date: Tue, 28 Oct 2014 09:27:35 -0200
Message-ID: <CAOMZO5CvM6V9LCUEuDshVzRQoELcQPQVC40dm0Pzw7DQYiJbFQ@mail.gmail.com>
References: <1414428580-29534-1-git-send-email-fabio.estevam@freescale.com>
	<8e4a991e46474daa8bc40b96e8042ef2@BLUPR03MB373.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:58332 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754428AbaJ1L1h (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 28 Oct 2014 07:27:37 -0400
Received: by mail-lb0-f172.google.com with SMTP id n15so393957lbi.17
        for <linux-serial@vger.kernel.org>; Tue, 28 Oct 2014 04:27:35 -0700 (PDT)
In-Reply-To: <8e4a991e46474daa8bc40b96e8042ef2@BLUPR03MB373.namprd03.prod.outlook.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "fugang.duan@freescale.com" <fugang.duan@freescale.com>
Cc: "Fabio.Estevam@freescale.com" <Fabio.Estevam@freescale.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

Hi Andy,

On Tue, Oct 28, 2014 at 12:10 AM, fugang.duan@freescale.com
<fugang.duan@freescale.com> wrote:

> Hi, Fabio,
>
> After the patch, uart wake up feature may be break. (So I always don't do like this.)
>
> Since the current driver enable AWAKE before system suspend in default, after suspend, if user click console keys, it generates AWAKE interrupt,
> in the irq handler, there have register access that cause system hang since uart module/ipg clocks are disabled, and system cannot resume back.

I have tested suspend/resume on a mx6qsabresd with this patch applied:

root@freescale /$ echo enabled > /sys/class/tty/ttymxc0/power/wakeup
root@freescale /$ echo mem > /sys/power/state
[   61.322648] PM: Syncing filesystems ... done.
[   61.342263] Freezing user space processes ... (elapsed 0.001 seconds) done.
[   61.351159] Freezing remaining freezable tasks ... (elapsed 0.002 seconds) d.
[   61.360875] Suspending console(s) (use no_console_suspend to debug)

(then sent a char in console)

[   61.416329] PM: suspend of devices complete after 45.778 msecs
[   61.416337] PM: suspend devices took 0.050 seconds
[   61.420745] PM: late suspend of devices complete after 4.393 msecs
[   61.425547] PM: noirq suspend of devices complete after 4.787 msecs
[   61.425555] Disabling non-boot CPUs ...
[   61.426971] CPU1: shutdown
[   61.429095] CPU2: shutdown
[   61.431190] CPU3: shutdown
[   61.431992] Enabling non-boot CPUs ...
[   61.432635] CPU1: Booted secondary processor
[   61.433006] CPU1 is up
[   61.433627] CPU2: Booted secondary processor
[   61.433998] CPU2 is up
[   61.434622] CPU3: Booted secondary processor
[   61.435021] CPU3 is up
[   61.437511] PM: noirq resume of devices complete after 2.472 msecs
[   61.441288] PM: early resume of devices complete after 2.909 msecs
[   61.602251] PM: resume of devices complete after 160.946 msecs
[   61.606860] PM: resume devices took 0.170 seconds
[   61.688676] Restarting tasks ... done.
[   61.795155] ata1: SATA link down (SStatus 0 SControl 300)

and the system wakes up normally.

This patch does not change anything regarding enabling/disabling of wakeup irqs.

Instead of requesting the irqs everytime when the uart port will
transmit (inside imx_startup() ) it allocates the irq only once in the
probe function, so the suspend/resume behaviour is unchanged.
