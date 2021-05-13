Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BABEC433ED
	for <linux-serial@archiver.kernel.org>; Thu, 13 May 2021 19:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 164C3613F1
	for <linux-serial@archiver.kernel.org>; Thu, 13 May 2021 19:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbhEMT0y (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 13 May 2021 15:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhEMT0u (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 13 May 2021 15:26:50 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EBFC061574;
        Thu, 13 May 2021 12:25:36 -0700 (PDT)
Received: from hatter.bewilderbeest.net (unknown [IPv6:2600:6c44:7f:ba20::7c6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id D83633E8;
        Thu, 13 May 2021 12:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1620933935;
        bh=3xQm+9LMy8PS8L08QfP0aJgsWgjlYVW/AhLSsoPmF+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X+/8f3XPl1MQ5nQMw8qPZnMaUJqFty0feSXspBZolV9TeFRlqoYfvtYa5IKATp38X
         4TFaKvGcf6yM41p+AZ8gYwMbpBcXiNL8FkbkH+VZxz94d/8/Egi9pZ6IgQZjzL2yDY
         glVjqPZqP/oMRupIjQ/bZVwR6Ty0+DctvMp925dU=
Date:   Thu, 13 May 2021 14:25:32 -0500
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@ozlabs.org>, openbmc@lists.ozlabs.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Joel Stanley <joel@jms.id.au>, Johan Hovold <johan@kernel.org>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] serial: 8250_aspeed_vuart: initialize vuart->port in
 aspeed_vuart_probe()
Message-ID: <YJ19LMLV1HXk6BMf@hatter.bewilderbeest.net>
References: <20210510014231.647-1-zev@bewilderbeest.net>
 <20210510014231.647-3-zev@bewilderbeest.net>
 <6d4338e2-d9be-411a-aeb7-7d46121b73d4@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6d4338e2-d9be-411a-aeb7-7d46121b73d4@www.fastmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, May 12, 2021 at 08:34:06PM CDT, Andrew Jeffery wrote:
>
>
>On Mon, 10 May 2021, at 11:12, Zev Weiss wrote:
>> Previously this had only been initialized if we hit the throttling path
>> in aspeed_vuart_handle_irq(); moving it to the probe function is a
>> slight consistency improvement and avoids redundant reinitialization in
>> the interrupt handler.  It also serves as preparation for converting the
>> driver's I/O accesses to use port->port.membase instead of its own
>> vuart->regs.
>>
>> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
>> ---
>>  drivers/tty/serial/8250/8250_aspeed_vuart.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c
>> b/drivers/tty/serial/8250/8250_aspeed_vuart.c
>> index 9e8b2e8e32b6..249164dc397b 100644
>> --- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
>> +++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
>> @@ -349,11 +349,9 @@ static int aspeed_vuart_handle_irq(struct
>> uart_port *port)
>>  			struct aspeed_vuart *vuart = port->private_data;
>>  			__aspeed_vuart_set_throttle(up, true);
>>
>> -			if (!timer_pending(&vuart->unthrottle_timer)) {
>> -				vuart->port = up;
>> +			if (!timer_pending(&vuart->unthrottle_timer))
>>  				mod_timer(&vuart->unthrottle_timer,
>>  					  jiffies + unthrottle_timeout);
>> -			}
>>
>>  		} else {
>>  			count = min(space, 256);
>> @@ -511,6 +509,7 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
>>  		goto err_clk_disable;
>>
>>  	vuart->line = rc;
>> +	vuart->port = serial8250_get_port(vuart->line);
>
>The documentation of serial8250_get_port() is somewhat concerning wrt
>the use:
>
>https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/tty/serial/8250/8250_core.c?h=v5.13-rc1#n399

Hmm, good point -- though despite that comment it looks like there is 
some existing code using it outside of suspend/resume callbacks (in 
8250_pci.c and 8250_pnp.c).  I'm not certain if those would necessarily 
be considered good precedent to follow for this, but I don't see any 
obvious better way of getting hold of the corresponding uart_8250_port 
(or its port.membase).

I did receive a notification that Greg had added this series to his 
tty-testing branch; not sure if that means he thinks it's OK or if it 
just kind of slipped by unnoticed though.

>
>However, given the existing behaviour it shouldn't be problematic?
>

"existing behaviour" referring to what here?


Thanks,
Zev

