Return-Path: <SRS0=aY4b=7G=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1065EC433DF
	for <linux-serial@archiver.kernel.org>; Sun, 24 May 2020 17:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8EBF207D8
	for <linux-serial@archiver.kernel.org>; Sun, 24 May 2020 17:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LD5Qjird"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbgEXRKf (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 24 May 2020 13:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728888AbgEXRKe (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 24 May 2020 13:10:34 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13C2C061A0E
        for <linux-serial@vger.kernel.org>; Sun, 24 May 2020 10:10:34 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x13so7837742pfn.11
        for <linux-serial@vger.kernel.org>; Sun, 24 May 2020 10:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=co/4klAdLIpfol6JsjrwmZlS2TfGgUtSd92RcjjczQM=;
        b=LD5QjirdklZXf0cKs1IdCoR97h02dMl6Vor5ylCavNftyRgHN2XO/5sQ6EnYwLYv/S
         8wQvfVqHYxqAu3hxJokFGekzMMrVr5jG/bDZDsnl+ZQAnu3bqCHLLp1/KCil+7SJRB1K
         1U+8s/Xm4aDjOgiNVVzA2jzb5TqtY0iuGokbd5foqDi07oMECu/P7V51sqMNY5Ax3Rt5
         jMUDQSIijhDYzLZQG+SN/zpmX8LqCo949l7pukrV0g63oOM/xLYBhyWYXuh1tJG7UaNr
         IPzpXzsG4m5beNvC5FVovdMITL0s5rdyVKQcnca99k1kwtZsXgsOAFbjTM6Q4Yy3sE+v
         P25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=co/4klAdLIpfol6JsjrwmZlS2TfGgUtSd92RcjjczQM=;
        b=L5BDTZpPsgEW5uvF36zveqM5sAxy+db/Ap/4VNiJkhPHwQFsN5/QS9zOWQLhW0R4Af
         OyBsJhA8C8txSQSTwBOZNkNrDvIE/DSmwZ9c8J1x4n6WTJMu459d0YclChA0Z3HVyHOL
         VmUnhVsar03kEmZtITJUPlck6ypA2Ryt4wEx/iGNXpIVBff/u3x+Djzkj4ClUVoyn5+m
         Q2PpuSp5YBtVa2ojDfEqJxvTfXCZzFmIVCdP7SSHzg+hP8yn2cBRMMsVRSuJKexG3y8p
         YeYQV8AENJnfuI2Ic104QldIk7Ctpv3XyyvtS89E0amAS4XCL38At/k7ADgWa/dXQP7S
         C8kw==
X-Gm-Message-State: AOAM531egGgYxwNJwZ6uSGA4hU1EG5S6Do/h5qAmPXhCz5dFznnJuI+R
        re0vLQPgSGzk7vxTJHqC/P8=
X-Google-Smtp-Source: ABdhPJzzg3i/LDOxWjhwQkoBePvyh2jiQBEAM4ronTuNrTHrAHv7YsOHHYpKCVGElq3eJfh05WXupA==
X-Received: by 2002:a05:6a00:843:: with SMTP id q3mr13027986pfk.107.1590340233922;
        Sun, 24 May 2020 10:10:33 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 2sm1335840pfd.163.2020.05.24.10.10.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 May 2020 10:10:33 -0700 (PDT)
Date:   Sun, 24 May 2020 10:10:32 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 2/6] serial: core: Allow detach and attach serial
 device for console
Message-ID: <20200524171032.GA218301@roeck-us.net>
References: <20200217114016.49856-1-andriy.shevchenko@linux.intel.com>
 <20200217114016.49856-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217114016.49856-3-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On Mon, Feb 17, 2020 at 01:40:12PM +0200, Andy Shevchenko wrote:
> In the future we would like to disable power management on the serial devices
> used as kernel consoles to avoid weird behaviour in some cases. However,
> disabling PM may prevent system to go to deep sleep states, which in its turn
> leads to the higher power consumption.
> 
> Tony Lindgren proposed a work around, i.e. allow user to detach such consoles
> to make PM working again. In case user wants to see what's going on, it also
> provides a mechanism to attach console back.
> 
> Link: https://lists.openwall.net/linux-kernel/2018/09/29/65
> Suggested-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  Documentation/ABI/testing/sysfs-tty |  7 ++++
>  drivers/tty/serial/serial_core.c    | 60 +++++++++++++++++++++++++++--
>  2 files changed, 63 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-tty b/Documentation/ABI/testing/sysfs-tty
> index 9eb3c2b6b040..e157130a6792 100644
> --- a/Documentation/ABI/testing/sysfs-tty
> +++ b/Documentation/ABI/testing/sysfs-tty
> @@ -154,3 +154,10 @@ Description:
>  		 device specification. For example, when user sets 7bytes on
>  		 16550A, which has 1/4/8/14 bytes trigger, the RX trigger is
>  		 automatically changed to 4 bytes.
> +
> +What:		/sys/class/tty/ttyS0/console
> +Date:		February 2020
> +Contact:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> +Description:
> +		 Allows user to detach or attach back the given device as
> +		 kernel console. It shows and accepts a boolean variable.
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 5444293fe2e8..20ab89300a98 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1919,7 +1919,7 @@ static inline bool uart_console_enabled(struct uart_port *port)
>   */
>  static inline void uart_port_spin_lock_init(struct uart_port *port)
>  {
> -	if (uart_console_enabled(port))
> +	if (uart_console(port))

This results in lockdep splashes such as the one attached below. Is there
any special reason for this change ? It is not really explained in the
commit description.

Thanks,
Guenter

---
[   15.439094] INFO: trying to register non-static key.
[   15.439146] the code is fine but needs lockdep annotation.
[   15.439196] turning off the locking correctness validator.
[   15.439392] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.7.0-rc6-00244-gcaffb99b6929 #1
[   15.439469] Hardware name: Freescale i.MX6 Ultralite (Device Tree)
[   15.439887] [<c0112578>] (unwind_backtrace) from [<c010c4f4>] (show_stack+0x10/0x14)
[   15.439982] [<c010c4f4>] (show_stack) from [<c06dfcb0>] (dump_stack+0xe4/0x11c)
[   15.440053] [<c06dfcb0>] (dump_stack) from [<c01883e4>] (register_lock_class+0x8a0/0x924)
[   15.440127] [<c01883e4>] (register_lock_class) from [<c01884d4>] (__lock_acquire+0x6c/0x2e80)
[   15.440202] [<c01884d4>] (__lock_acquire) from [<c018756c>] (lock_acquire+0xf8/0x4f4)
[   15.440274] [<c018756c>] (lock_acquire) from [<c0ddf02c>] (_raw_spin_lock_irqsave+0x50/0x64)
[   15.440350] [<c0ddf02c>] (_raw_spin_lock_irqsave) from [<c07af5d8>] (uart_add_one_port+0x3a4/0x504)
[   15.440431] [<c07af5d8>] (uart_add_one_port) from [<c089c990>] (platform_drv_probe+0x48/0x98)
[   15.440506] [<c089c990>] (platform_drv_probe) from [<c089a708>] (really_probe+0x214/0x344)
[   15.440578] [<c089a708>] (really_probe) from [<c089a948>] (driver_probe_device+0x5c/0x16c)
[   15.440650] [<c089a948>] (driver_probe_device) from [<c089ac00>] (device_driver_attach+0x58/0x60)
[   15.440727] [<c089ac00>] (device_driver_attach) from [<c089ac8c>] (__driver_attach+0x84/0xc0)
[   15.440800] [<c089ac8c>] (__driver_attach) from [<c08987e8>] (bus_for_each_dev+0x70/0xb4)
[   15.440874] [<c08987e8>] (bus_for_each_dev) from [<c08999a4>] (bus_add_driver+0x154/0x1e0)
[   15.440946] [<c08999a4>] (bus_add_driver) from [<c089ba38>] (driver_register+0x74/0x108)
[   15.441020] [<c089ba38>] (driver_register) from [<c144edb8>] (imx_uart_init+0x20/0x40)
[   15.441090] [<c144edb8>] (imx_uart_init) from [<c010232c>] (do_one_initcall+0x80/0x3ac)
[   15.441162] [<c010232c>] (do_one_initcall) from [<c1400ff0>] (kernel_init_freeable+0x170/0x204)
[   15.441241] [<c1400ff0>] (kernel_init_freeable) from [<c0dd5c48>] (kernel_init+0x8/0x118)
[   15.441313] [<c0dd5c48>] (kernel_init) from [<c0100134>] (ret_from_fork+0x14/0x20)
[   15.441414] Exception stack(0xc609ffb0 to 0xc609fff8)
[   15.441571] ffa0:                                     00000000 00000000 00000000 00000000
[   15.441738] ffc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[   15.441872] ffe0: 00000000 00000000 00000000 00000000 00000013 00000000
