Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FA2C4332F
	for <linux-serial@archiver.kernel.org>; Thu,  8 Dec 2022 07:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiLHHw2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 8 Dec 2022 02:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLHHw1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 8 Dec 2022 02:52:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680353E097
        for <linux-serial@vger.kernel.org>; Wed,  7 Dec 2022 23:52:26 -0800 (PST)
Date:   Thu, 8 Dec 2022 08:52:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670485944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+xIQHUv5/3WeGfuuR2KGHZySpMyBf9GZ66WaBaNvos8=;
        b=z58K1hQb59PXMR3szIMc1vcHX4pqCjgCuMH1p9edP+XCJgtIXbRUd00bMK2NhdcWr2MD7L
        prwBEsgf/+MWendfnOVE/LuTCY1zfm9WraRYePV6PD6tP9b4tO0TyKt1Q5zG7GVkWRoX6n
        /PiGtm4ATE9ngfHkpkEA9dXmww4JVG65YbPrCTsKZEfZmq5QgIILKGRvM3I1r29j0Y/j+9
        MpGyshMt3qOAmXGRFvP1Q5Vh4rg6Hv1javeYHEx3zb3Rqv0GwAxXHG5xZFDT1TgSLycLXa
        o6YuOBy486k34/86TCxuT7ijQ0ReBgL47oQOhOJVeMZTfkbg0lkbYJNiNIJYJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670485944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+xIQHUv5/3WeGfuuR2KGHZySpMyBf9GZ66WaBaNvos8=;
        b=n6hd3evh580/6UFQlWbuCrmN8vOSyaswC11TwX4VnbDUBWRLGj22S0q2aKEuEkwTzrriTH
        LOuRmaG6la8tU3DA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-serial@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Erwan Le Ray <erwan.leray@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Caron <valentin.caron@foss.st.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] serial: stm32: Move hard IRQ handling to threaded
 interrupt context
Message-ID: <Y5GXt/NHCrODZ32S@linutronix.de>
References: <20221207195929.160267-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221207195929.160267-1-marex@denx.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

- Jean Philippe Romain <jean-philippe.romain@foss.st.com>

Could you please drop that email address in future post as I did? It
comes back here with:
| Remote-MTA: dns; mxb-00178001.gslb.pphosted.com
| Diagnostic-Code: smtp; 550 5.1.1 User Unknown

On 2022-12-07 20:59:29 [+0100], Marek Vasut wrote:
> diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
> index a1490033aa164..f5bce0be02676 100644
> --- a/drivers/tty/serial/stm32-usart.c
> +++ b/drivers/tty/serial/stm32-usart.c
> @@ -1015,7 +1002,7 @@ static int stm32_usart_startup(struct uart_port *port)
>  	u32 val;
>  	int ret;
>  
> -	ret = request_threaded_irq(port->irq, stm32_usart_interrupt,
> +	ret = request_threaded_irq(port->irq, NULL,
>  				   stm32_usart_threaded_interrupt,
>  				   IRQF_ONESHOT | IRQF_NO_SUSPEND,
>  				   name, port);

So why don't you just
	request_irq(port->irq, stm32_usart_interrupt, IRQF_NO_SUSPEND,
		    name, port)
? If there is a requirement to always run in threaded mode please
document it by at least making it part of the commit description.

Sebastian
