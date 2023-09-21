Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B155E7D0A2
	for <linux-serial@archiver.kernel.org>; Thu, 21 Sep 2023 20:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjIUUZ5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 Sep 2023 16:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjIUUZ2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Sep 2023 16:25:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E5F8ED5D
        for <linux-serial@vger.kernel.org>; Thu, 21 Sep 2023 10:45:10 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695309495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aMLuYDylYKwN7l6Zudwo7CAzPyqUpe33396ekJ2911g=;
        b=YEa76YVMEyzoO5RVKkzcmCnMuDm/444eDRwcaHRXOcPn4cpFmYYGA32rA3xFoGAKP4/xZ/
        05/Dl2b36W5w2g0Ntn2mUjzZmKBPM+v9/JLYP+Y2FGrnrZgeQfl0t6GjxOMSwgbwkw1m0v
        Tv5TUIwoVz1ogktv+gDOqcmYS9L1CsvuDSYu88YzqpWdCvqlq/LIdMLdKl75+avXP+ulZM
        VgXmO13UlT45EkoEEyXWyPSX89E/ynR2l1iNpF+if/nQWEvsoPL7iPX3pc4QpnQ0WP/1Mh
        VSP3CMqasodLr6Iu8pusuvgfr1NaswMprU6GvaCzRl+O/iD5gxwXx+qSdtx+xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695309495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aMLuYDylYKwN7l6Zudwo7CAzPyqUpe33396ekJ2911g=;
        b=3sWBMq6+JGr3fQK3t7Jneg7MMej+YfOwOVgma2s/wyroFp+u9wkU5A9bncXUZBAUIuPYEg
        XLycOEc9nJrmklDQ==
To:     Lukas Wunner <lukas@wunner.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH tty-linus] serial: Reduce spinlocked portion of
 uart_rs485_config()
In-Reply-To: <f3a35967c28b32f3c6432d0aa5936e6a9908282d.1695307688.git.lukas@wunner.de>
References: <f3a35967c28b32f3c6432d0aa5936e6a9908282d.1695307688.git.lukas@wunner.de>
Date:   Thu, 21 Sep 2023 17:24:04 +0206
Message-ID: <87zg1fees3.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2023-09-21, Lukas Wunner <lukas@wunner.de> wrote:
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 7bdc21d5e13b..ca26a8aef2cb 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1404,12 +1404,18 @@ static void uart_set_rs485_termination(struct uart_port *port,
>  static int uart_rs485_config(struct uart_port *port)
>  {
>  	struct serial_rs485 *rs485 = &port->rs485;
> +	unsigned long flags;
>  	int ret;
>  
> +	if (!(rs485->flags & SER_RS485_ENABLED))
> +		return 0;
> +
>  	uart_sanitize_serial_rs485(port, rs485);
>  	uart_set_rs485_termination(port, rs485);
>  
> +	spin_lock_irqsave(&port->lock, flags);
>  	ret = port->rs485_config(port, NULL, rs485);
> +	spin_unlock_irqrestore(&port->lock, flags);
>  	if (ret)
>  		memset(rs485, 0, sizeof(*rs485));

Is there some kind of guarantee that 2 CPUs cannot go into
uart_rs485_config() simultaneously? Otherwise it seems dangerous to be
using and clearing @port->rs485 outside of the spin_lock.

John Ogness
