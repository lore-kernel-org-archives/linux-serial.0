Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FF6C433F5
	for <linux-serial@archiver.kernel.org>; Sat,  2 Oct 2021 02:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0308E61A7A
	for <linux-serial@archiver.kernel.org>; Sat,  2 Oct 2021 02:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbhJBCRU (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 1 Oct 2021 22:17:20 -0400
Received: from phobos.denx.de ([85.214.62.61]:44392 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232278AbhJBCRU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 1 Oct 2021 22:17:20 -0400
Received: from mail.denx.de (unknown [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: festevam@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 0B65F81725;
        Sat,  2 Oct 2021 04:15:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1633140934;
        bh=nZ/+rPTWx8Ojfp+TFk51m1WEj0OxwPnb2GkmY8fR/04=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dQdFOThFICvcA3WJp/1Bguq4evPYZzF+n9UgMac4wiRfWjfxoOvfUAtlUJEdAmMvy
         lGpAySDe5YzgDKLpgzSZFVJc3RF0jk+21037FdTwYUuy6+tYg611XKfWNE+YodS2gb
         S+7ujN0ZUF1c82fFS175D8TarfqbY31ienjHFeql4nxoeSCSnfo02LWKN/MZgkqIaz
         oir/nqK4B+0QKtzt/5xLhybY/CjKsjm/2cHETQ9sBZTMmYEQSVBxrFgVXcn8z8AD0A
         sfkfafLNU1JQsQE69zvmcLB67Y3u/4XFPJCetV1gYOxMrVU+WHm87hpBGna84B41BJ
         M4sSp4HIRkCMQ==
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 01 Oct 2021 23:15:33 -0300
From:   Fabio Estevam <festevam@denx.de>
To:     Johan Hovold <johan@kernel.org>
Cc:     gregkh@linuxfoundation.org, michael@walle.cc,
        linux-serial@vger.kernel.org, marex@denx.de,
        u.kleine-koenig@pengutronix.de
Subject: Re: [PATCH v3]  serial: imx: Suppress false positive sysrq lockdep
 warning
In-Reply-To: <YVcTluYb6XOiOXZn@hovoldconsulting.com>
References: <20211001101815.729648-1-festevam@denx.de>
 <YVcTluYb6XOiOXZn@hovoldconsulting.com>
Message-ID: <0bbe2832eb2dc3a7c32f3d484ab42208@denx.de>
X-Sender: festevam@denx.de
User-Agent: Roundcube Webmail/1.3.6
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 01/10/2021 10:56, Johan Hovold wrote:

> No, no, no.
> 
> Just replace this unlock with uart_unlock_and_check_sysrq() and do the
> corresponding change in imx_uart_int(). The result is an even smaller
> diff than what you're currently proposing and without any performance
> penalty from dropping and reacquiring the lock.

Just to be clear, this is something that I have also tried:

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 8b121cd869e9..b652908f0bf1 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -803,7 +803,7 @@ static irqreturn_t __imx_uart_rxint(int irq, void 
*dev_id)
  				continue;
  		}

-		if (uart_handle_sysrq_char(&sport->port, (unsigned char)rx))
+		if (uart_prepare_sysrq_char(&sport->port, (unsigned char)rx))
  			continue;

  		if (unlikely(rx & URXD_ERR)) {
@@ -858,7 +858,7 @@ static irqreturn_t imx_uart_rxint(int irq, void 
*dev_id)

  	ret = __imx_uart_rxint(irq, dev_id);

-	spin_unlock(&sport->port.lock);
+	uart_unlock_and_check_sysrq(&sport->port);

  	return ret;
  }
@@ -991,7 +991,7 @@ static irqreturn_t imx_uart_int(int irq, void 
*dev_id)
  		ret = IRQ_HANDLED;
  	}

-	spin_unlock(&sport->port.lock);
+	uart_unlock_and_check_sysrq(&sport->port);

  	return ret;
  }
@@ -1977,9 +1977,7 @@ imx_uart_console_write(struct console *co, const 
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

, but still get the lockdep warning in this case.

Thanks

