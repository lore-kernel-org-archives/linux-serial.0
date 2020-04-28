Return-Path: <SRS0=KIft=6M=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949D8C83000
	for <linux-serial@archiver.kernel.org>; Tue, 28 Apr 2020 22:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75A202072A
	for <linux-serial@archiver.kernel.org>; Tue, 28 Apr 2020 22:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgD1WST (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 28 Apr 2020 18:18:19 -0400
Received: from foss.arm.com ([217.140.110.172]:59982 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbgD1WSS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 28 Apr 2020 18:18:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F1811FB;
        Tue, 28 Apr 2020 15:18:18 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E8A73F305;
        Tue, 28 Apr 2020 15:18:16 -0700 (PDT)
References: <20200428184050.6501-1-john.stultz@linaro.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2] serial: amba-pl011: Make sure we initialize the port.lock spinlock
In-reply-to: <20200428184050.6501-1-john.stultz@linaro.org>
Date:   Tue, 28 Apr 2020 23:18:14 +0100
Message-ID: <jhjd07rs195.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


On 28/04/20 19:40, John Stultz wrote:
> Valentine reported seeing:
>
> [    3.626638] INFO: trying to register non-static key.
> [    3.626639] the code is fine but needs lockdep annotation.
> [    3.626640] turning off the locking correctness validator.
> [    3.626644] CPU: 7 PID: 51 Comm: kworker/7:1 Not tainted 5.7.0-rc2-00115-g8c2e9790f196 #116
> [    3.626646] Hardware name: HiKey960 (DT)
> [    3.626656] Workqueue: events deferred_probe_work_func
> [    3.632476] sd 0:0:0:0: [sda] Optimal transfer size 8192 bytes not a multiple of physical block size (16384 bytes)
> [    3.640220] Call trace:
> [    3.640225]  dump_backtrace+0x0/0x1b8
> [    3.640227]  show_stack+0x20/0x30
> [    3.640230]  dump_stack+0xec/0x158
> [    3.640234]  register_lock_class+0x598/0x5c0
> [    3.640235]  __lock_acquire+0x80/0x16c0
> [    3.640236]  lock_acquire+0xf4/0x4a0
> [    3.640241]  _raw_spin_lock_irqsave+0x70/0xa8
> [    3.640245]  uart_add_one_port+0x388/0x4b8
> [    3.640248]  pl011_register_port+0x70/0xf0
> [    3.640250]  pl011_probe+0x184/0x1b8
> [    3.640254]  amba_probe+0xdc/0x180
> [    3.640256]  really_probe+0xe0/0x338
> [    3.640257]  driver_probe_device+0x60/0xf8
> [    3.640259]  __device_attach_driver+0x8c/0xd0
> [    3.640260]  bus_for_each_drv+0x84/0xd8
> [    3.640261]  __device_attach+0xe4/0x140
> [    3.640263]  device_initial_probe+0x1c/0x28
> [    3.640265]  bus_probe_device+0xa4/0xb0
> [    3.640266]  deferred_probe_work_func+0x7c/0xb8
> [    3.640269]  process_one_work+0x2c0/0x768
> [    3.640271]  worker_thread+0x4c/0x498
> [    3.640272]  kthread+0x14c/0x158
> [    3.640275]  ret_from_fork+0x10/0x1c
>
> Which seems to be due to the fact that after allocating the uap
> structure, nothing initializes the spinlock.
>
> Its a little confusing, as uart_port_spin_lock_init() is one
> place where the lock is supposed to be initialized, but it has
> an exception for the case where the port is a console.
>
> This makes it seem like a deeper fix is needed to properly
> register the console, but I'm not sure what that entails, and
> Andy suggested that this approach is less invasive.
>
> Thus, this patch resolves the issue by initializing the spinlock
> in the driver, and resolves the resulting warning.
>

Agreed with all of the above!

Reviewed-and-tested-by: Valentin Schneider <valentin.schneider@arm.com>

Thanks to both of you, John & Andy.

> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: linux-serial@vger.kernel.org
> Reported-by: Valentin Schneider <valentin.schneider@arm.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
> v2: Added extra context in the commit message
> ---
>  drivers/tty/serial/amba-pl011.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 2296bb0f9578..458fc3d9d48c 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -2575,6 +2575,7 @@ static int pl011_setup_port(struct device *dev, struct uart_amba_port *uap,
>       uap->port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_AMBA_PL011_CONSOLE);
>       uap->port.flags = UPF_BOOT_AUTOCONF;
>       uap->port.line = index;
> +	spin_lock_init(&uap->port.lock);
>
>       amba_ports[index] = uap;
