Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782E9C433EF
	for <linux-serial@archiver.kernel.org>; Thu, 30 Sep 2021 13:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F09F611C7
	for <linux-serial@archiver.kernel.org>; Thu, 30 Sep 2021 13:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349490AbhI3NrR (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 30 Sep 2021 09:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348238AbhI3NrR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 30 Sep 2021 09:47:17 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB01BC06176A
        for <linux-serial@vger.kernel.org>; Thu, 30 Sep 2021 06:45:34 -0700 (PDT)
Received: from mail.denx.de (unknown [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: festevam@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 9598481EE5;
        Thu, 30 Sep 2021 15:45:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1633009531;
        bh=k7j1XPRIW3fFkLBj24ZVOay+lfANmnhIp5FO37Re3tM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0A3TmU+QcYfKHwR+7s3dPisaMq5uEEZG8R7vVJK9xXrHMc1/oYy3Dko29qQbsVRNG
         9leAK7It8ivNWQ1DZnh4k9I4tbcXDLJkcBCLzwilFYl19A4ZA5O896rnTf5VSVX+KE
         UGgmzSYDaeEgPQ8a2q2M1e9yc/92btjjeJqqriAWgCltLv5Y/BO7cJftjPvAOz4/Gc
         HJte+x9ywm5eHtiFjrLBkjh3C2MjbQeR6pRQzUWNUKAJK5DAXl/yCuwDcudqidaw8m
         RIiwV6V0ea4G+QZF9YM7PUsYipGOVT/9d3EYW3Tt9YsSdnhIVY3Ev9RJixj/Ry6Bju
         97tyF3/aWngCQ==
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 30 Sep 2021 10:45:31 -0300
From:   Fabio Estevam <festevam@denx.de>
To:     Johan Hovold <johan@kernel.org>
Cc:     gregkh@linuxfoundation.org, michael@walle.cc,
        linux-serial@vger.kernel.org, marex@denx.de,
        u.kleine-koenig@pengutronix.de
Subject: Re: [PATCH v2] serial: imx: Fix sysrq deadlock
In-Reply-To: <YVVtRw/JlUzn4H54@hovoldconsulting.com>
References: <20210929214324.44910-1-festevam@denx.de>
 <YVVtRw/JlUzn4H54@hovoldconsulting.com>
Message-ID: <bae11ec74a0515841ad36403b9f5a47b@denx.de>
X-Sender: festevam@denx.de
User-Agent: Roundcube Webmail/1.3.6
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Johan,

On 30/09/2021 04:54, Johan Hovold wrote:

> This is just so broken; you can't just drop the lock. And you clearly
> haven't even tried to understand how uart_unlock_and_check_sysrq()
> works.
> 
> Please take a closer look at the commit you're trying to mimic.

Thanks for the feedback.

I have changed it to:


diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 8b121cd869e9..b7cda50602d5 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -803,7 +803,7 @@ static irqreturn_t __imx_uart_rxint(int irq, void 
*dev_id)
  				continue;
  		}

-		if (uart_handle_sysrq_char(&sport->port, (unsigned char)rx))
+		if (uart_prepare_sysrq_char(&sport->port, rx))
  			continue;

  		if (unlikely(rx & URXD_ERR)) {
@@ -844,6 +844,7 @@ static irqreturn_t __imx_uart_rxint(int irq, void 
*dev_id)
  	}

  out:
+	uart_unlock_and_check_sysrq(&sport->port);
  	tty_flip_buffer_push(port);

  	return IRQ_HANDLED;
@@ -959,6 +960,7 @@ static irqreturn_t imx_uart_int(int irq, void 
*dev_id)
  		imx_uart_writel(sport, USR1_AGTIM, USR1);

  		__imx_uart_rxint(irq, dev_id);
+		spin_lock(&sport->port.lock);
  		ret = IRQ_HANDLED;
  	}

@@ -1977,9 +1979,7 @@ imx_uart_console_write(struct console *co, const 
char *s, unsigned int count)
  	unsigned int ucr1;
  	int locked = 1;

-	if (sport->port.sysrq)
-		locked = 0;
-	else if (oops_in_progress)
+	if (oops_in_progress)
  		locked = spin_trylock_irqsave(&sport->port.lock, flags);
  	else
  		spin_lock_irqsave(&sport->port.lock, flags);

This makes the deadlock not happen after running:
echo t > /proc/sysrq-trigger

, but entering <break> + t via the console does not work anymore.


It returns the sysrq help instead:

sysrq: HELP : loglevel(0-9) reboot(b) crash(c) show-all-locks(d) 
terminate-all-tasks(e) memory-full-oom-kill(f) kill-all-tasks(i) 
thaw-filesystems(j) sak(k) show-backtrace-all-active-cpu
s(l) show-memory-usage(m) nice-all-RT-tasks(n) poweroff(o) 
show-registers(p) show-all-timers(q) unraw(r) sync(s) 
show-task-states(t) unmount(u) show-blocked-tasks(w) 
dump-ftrace-buffer(z)

Thanks
