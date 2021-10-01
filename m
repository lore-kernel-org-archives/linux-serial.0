Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A2FC433F5
	for <linux-serial@archiver.kernel.org>; Fri,  1 Oct 2021 14:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03A1E61A6F
	for <linux-serial@archiver.kernel.org>; Fri,  1 Oct 2021 14:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbhJAOuj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 1 Oct 2021 10:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbhJAOui (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 1 Oct 2021 10:50:38 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8AAC061775
        for <linux-serial@vger.kernel.org>; Fri,  1 Oct 2021 07:48:54 -0700 (PDT)
Received: from mail.denx.de (unknown [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: festevam@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id AF07B8020E;
        Fri,  1 Oct 2021 16:48:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1633099731;
        bh=YQ81XSZ5+U0+taGhqQoL9JlunFEMRNppkUi8cjBULgA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZYvEbc1PZu/rqffk2aqAmfb0lAO0NA/68AlEKunlK7TZWdC67KvzUUci82IUpmLXa
         IzO2smAejqL5PeQ3jergRQC8JNkO1NZ0K85hZEpQkF9Djsn6dB/B1QZb1yFQoxBVFi
         xqUwzK4PrfwEXkRb27OnQJ2ba/hzRTlor2mO9gR0JZqDQHCPutrrNzsE815E7jSIVY
         6BLUwiNQuxuJETApTJgNqZB+EqoFjHR1gpxjLjXbNXUCFke7VgJzuIRuHtSQ14dWV7
         i2INwExJbymzzwDdP3HWQNZWJfQZgZeHgsrgCXNQnabka9s3y3hv0uQrpWhq56ANSI
         6IXU81TI1Jx3Q==
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 01 Oct 2021 11:48:51 -0300
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
Message-ID: <cc2ed9d348136bf7bc7bf3d810d1a4a3@denx.de>
X-Sender: festevam@denx.de
User-Agent: Roundcube Webmail/1.3.6
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Johan,

On 01/10/2021 10:56, Johan Hovold wrote:

>> @@ -852,15 +853,10 @@ static irqreturn_t __imx_uart_rxint(int irq, 
>> void *dev_id)
>>  static irqreturn_t imx_uart_rxint(int irq, void *dev_id)
>>  {
>>  	struct imx_port *sport = dev_id;
>> -	irqreturn_t ret;
>> 
>>  	spin_lock(&sport->port.lock);
>> 
>> -	ret = __imx_uart_rxint(irq, dev_id);
>> -
>> -	spin_unlock(&sport->port.lock);
> 
> No, no, no.
> 
> Just replace this unlock with uart_unlock_and_check_sysrq() and do the

This does not work as uart_unlock_and_check_sysrq() needs to be
called inside __imx_uart_rxint() prior to tty_flip_buffer_push().

> corresponding change in imx_uart_int(). The result is an even smaller
> diff than what you're currently proposing and without any performance
> penalty from dropping and reacquiring the lock.

Yes, I can avoid the unnecessary reacquiring of the lock as you
suggested:

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 8b121cd869e9..5e38bf8fb7b8 100644
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
@@ -844,6 +844,7 @@ static irqreturn_t __imx_uart_rxint(int irq, void 
*dev_id)
  	}

  out:
+	uart_unlock_and_check_sysrq(&sport->port);
  	tty_flip_buffer_push(port);

  	return IRQ_HANDLED;
@@ -852,15 +853,10 @@ static irqreturn_t __imx_uart_rxint(int irq, void 
*dev_id)
  static irqreturn_t imx_uart_rxint(int irq, void *dev_id)
  {
  	struct imx_port *sport = dev_id;
-	irqreturn_t ret;

  	spin_lock(&sport->port.lock);

-	ret = __imx_uart_rxint(irq, dev_id);
-
-	spin_unlock(&sport->port.lock);
-
-	return ret;
+	return __imx_uart_rxint(irq, dev_id);
  }

  static void imx_uart_clear_rx_errors(struct imx_port *sport);
@@ -955,13 +951,6 @@ static irqreturn_t imx_uart_int(int irq, void 
*dev_id)
  	if ((ucr4 & UCR4_OREN) == 0)
  		usr2 &= ~USR2_ORE;

-	if (usr1 & (USR1_RRDY | USR1_AGTIM)) {
-		imx_uart_writel(sport, USR1_AGTIM, USR1);
-
-		__imx_uart_rxint(irq, dev_id);
-		ret = IRQ_HANDLED;
-	}
-
  	if ((usr1 & USR1_TRDY) || (usr2 & USR2_TXDC)) {
  		imx_uart_transmit_buffer(sport);
  		ret = IRQ_HANDLED;
@@ -991,8 +980,17 @@ static irqreturn_t imx_uart_int(int irq, void 
*dev_id)
  		ret = IRQ_HANDLED;
  	}

+	if (usr1 & (USR1_RRDY | USR1_AGTIM)) {
+		imx_uart_writel(sport, USR1_AGTIM, USR1);
+
+		__imx_uart_rxint(irq, dev_id);
+		ret = IRQ_HANDLED;
+		goto out;
+	}
+
  	spin_unlock(&sport->port.lock);

+out:
  	return ret;
  }

@@ -1977,9 +1975,7 @@ imx_uart_console_write(struct console *co, const 
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
