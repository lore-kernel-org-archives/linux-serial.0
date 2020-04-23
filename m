Return-Path: <SRS0=HBWv=6H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCB6C54FCB
	for <linux-serial@archiver.kernel.org>; Thu, 23 Apr 2020 23:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85B672077D
	for <linux-serial@archiver.kernel.org>; Thu, 23 Apr 2020 23:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbgDWXOy (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 23 Apr 2020 19:14:54 -0400
Received: from foss.arm.com ([217.140.110.172]:49276 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728441AbgDWXOy (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 23 Apr 2020 19:14:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DA7430E;
        Thu, 23 Apr 2020 16:14:53 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 57B033F68F;
        Thu, 23 Apr 2020 16:14:52 -0700 (PDT)
References: <20200423220056.29450-1-john.stultz@linaro.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Subject: Re: [RFC][PATCH] serial: amba-pl011: Make sure we initialize the port.lock spinlock
In-reply-to: <20200423220056.29450-1-john.stultz@linaro.org>
Date:   Fri, 24 Apr 2020 00:14:46 +0100
Message-ID: <jhj1rodyeu1.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


Hi John,

On 23/04/20 23:00, John Stultz wrote:
> Which seems to be due to the fact that after allocating the uap
> structure, the pl011 code doesn't initialize the spinlock.
>
> This patch fixes it by initializing the spinlock and the warning
> has gone away.
>

Thanks for having a look. It does seem like the reasonable thing to do, and
I no longer get the warning on h960.

That said, I got more curious as this doesn't show up on my Juno (same
Image). Digging into it I see that uart_add_one_port() has a call to
uart_port_spin_lock_init() a few lines before uart_configure_port() (in
which the above warning gets triggered). That thing says:

 * Ensure that the serial console lock is initialised early.
 * If this port is a console, then the spinlock is already initialised.

Which requires me to ask: are we doing the right thing here?

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
>       uap->port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_AMBA_PL011_CONSOLE);
>       uap->port.flags = UPF_BOOT_AUTOCONF;
>       uap->port.line = index;
> +	spin_lock_init(&uap->port.lock);
>
>       amba_ports[index] = uap;
