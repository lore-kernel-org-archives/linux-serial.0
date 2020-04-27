Return-Path: <SRS0=JuT/=6L=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0326AC54FD0
	for <linux-serial@archiver.kernel.org>; Mon, 27 Apr 2020 09:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0CC62064A
	for <linux-serial@archiver.kernel.org>; Mon, 27 Apr 2020 09:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgsnJHSr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgD0JFw (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 27 Apr 2020 05:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgD0JFw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 Apr 2020 05:05:52 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1EEC061A41;
        Mon, 27 Apr 2020 02:05:52 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t9so7278590pjw.0;
        Mon, 27 Apr 2020 02:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AAu8Sq4/5McjYuCwBT1hE70l2wE5SUtDRX9Y3ARd6Jk=;
        b=CgsnJHSrH7MRlBBa5tlez6yUVTzBIR8H+G7fkCjBDsk+Kkp44wlBWtYkmC1AiIO4jW
         1jW/B64H4M9Lm347ba4c75uTWs7CBU3vQYMZS6Odm6XIkdHDB6Y9sPqaMH6Hxv4hi4tl
         zVu7pbAsgtVjevxo9FDRRHOj9OjAu7I/MSIHbkTjE60/62NrwZ3GwWGH3DzqvO4qv1a8
         hIIRXYYa0fW1RaAG6jKvtAqBptZrQoYV9fUIHM2qj0yRuQbsQmw6AoJbj8nUVX0Q4Pjw
         C6pF5YqCH6nEDfHwTuYNmVbBspFR6mETHdKT+3+LUML7mSDrfXUgP2d8BArQemj0P6JV
         w5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AAu8Sq4/5McjYuCwBT1hE70l2wE5SUtDRX9Y3ARd6Jk=;
        b=FZ4v4JuL6Ulpl6awa3FHio4FF+tlBVJx5eaYJHuJ7ZK3i0E3MjVfqrlEZdwJfRf2rI
         oqFvW5060o7fRgi7vuH6og/mrLJ9Yfh6uw4N4i6ORYNhz6GPrd9NkYFcQUDtxoX9P0B2
         /VvwhywOoyKGBS1XuCsdhJSzqtJ79zC1rjjXElmg/SYeqrZty69ZtUQXttQYs8HZh6B9
         eqAwgvEto3tsEYlIzIdT9+JHFhs297jQSYIJquOIenfRxsO7eH+4joxQhzB8MKKE8gO1
         RFNBoCb8vhnzD6xlkhS8RxsACQqtebrz4cOkMPoe7QpPip+JIyDRBE920N8tZPw3QtZ4
         7u7w==
X-Gm-Message-State: AGi0Pubd20B7LyOWXgM+NBIGdb0Ls9SJ9+FxaROVG+e3HQmYkvYUbvdi
        kuXBA+rjp5qD5btacJtECqQPeN8GOvBUMr79CJKjX55h
X-Google-Smtp-Source: APiQypLBxRTk2Zxhi8fpwaJijSMau1KFYz5TeZjOP6DOGR9HIFCmYXzMFCmFp8mKBx8XErSYOePmav3JZypTswlqcSA=
X-Received: by 2002:a17:902:9306:: with SMTP id bc6mr22051008plb.255.1587978351678;
 Mon, 27 Apr 2020 02:05:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200423220056.29450-1-john.stultz@linaro.org>
In-Reply-To: <20200423220056.29450-1-john.stultz@linaro.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 27 Apr 2020 12:05:45 +0300
Message-ID: <CAHp75Vemw6UKZRK7A9AiOwgbvWLCD2VzOkdGw688Nmc=gVsQYw@mail.gmail.com>
Subject: Re: [RFC][PATCH] serial: amba-pl011: Make sure we initialize the
 port.lock spinlock
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Apr 24, 2020 at 1:06 AM John Stultz <john.stultz@linaro.org> wrote:
>
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
> structure, the pl011 code doesn't initialize the spinlock.
>
> This patch fixes it by initializing the spinlock and the warning
> has gone away.
>

I think it's step to the right direction. FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> CC: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: linux-serial@vger.kernel.org
> Reported-by: Valentin Schneider <valentin.schneider@arm.com>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>  drivers/tty/serial/amba-pl011.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 2296bb0f9578..458fc3d9d48c 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -2575,6 +2575,7 @@ static int pl011_setup_port(struct device *dev, struct uart_amba_port *uap,
>         uap->port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_AMBA_PL011_CONSOLE);
>         uap->port.flags = UPF_BOOT_AUTOCONF;
>         uap->port.line = index;
> +       spin_lock_init(&uap->port.lock);
>
>         amba_ports[index] = uap;
>
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
