Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50974C433B4
	for <linux-serial@archiver.kernel.org>; Thu, 13 May 2021 01:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 233A7613E9
	for <linux-serial@archiver.kernel.org>; Thu, 13 May 2021 01:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhEMBfj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 12 May 2021 21:35:39 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:60195 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230097AbhEMBfi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 12 May 2021 21:35:38 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 7E1A01FDC;
        Wed, 12 May 2021 21:34:28 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Wed, 12 May 2021 21:34:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=SWVR8Emae5xp73d7j3kk9BUVMAV+TJP
        pcPLvVYttHEI=; b=QYAPy4NFRvDeoipjFKZtMfKy7SsQAQAdE1qgEDJXLKBP1u6
        4kWpDvtUQgvtcN4I9v1YpdLFW36cLnrUZij45Pf5J9CzXAZ2si7rGkDAbaBN4zAV
        8zm/LJ6KJodfkRYB8qK9VRGjKmnYmSG7QrbEMaHF8RnQc8t13dxz0wHXHNnch+RF
        aHa6u7WLlq68BdFIehVaGSDXSHTzION+Ve+4rZ3DOJV3Ael5nbqHDfF6sayl7FZO
        rOkmKXt5nbRnZrog4uXLLI46L+WA/t+2enI0YBA0d43IY+OVpMg3V/XWHOOzw9/4
        XLD3A7kgySSTlMHohjN6Gn16/WBQ4aENriPZ1ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=SWVR8E
        mae5xp73d7j3kk9BUVMAV+TJPpcPLvVYttHEI=; b=r3b7d7XKm3AEANfyaa0MPq
        oTUBY1VA3eRDIwVUQFHjdizMuFd0fQc6xHCqzkA31DX/ufrEr5ZYb0sMYcbhfPPh
        23u8qUe1lm4udWmxpkQBJeUw1OE++AG7uXHtjfLX8VkAD6gXvBxAF6yptIToSmSR
        lHsOtSsOC0iGaXvU3nuHbOQgqXGWUKV+pM+5L6Cu0PxPsGzfXIxotlvdjZnMtOzK
        aDGYo8gDNq2yoHCBEHq8FjH4MAf9zvZJXjBLjtowVlqyQoTWPQ/C/T0ZvKe2oO3I
        NLbwuykJWcgAO+Sxbh+ow1cZ7p0ZXH2mh76OdfqTZqiQ/p1eWVfA25k+kIQt6mRA
        ==
X-ME-Sender: <xms:IoKcYPYAcrA-ektTVMh_s0FTU3GrHaivuPK3XWTiLdQEctQu0w76ww>
    <xme:IoKcYOaIJQy8BucmVvwV2BEO6a5gxXvSGIlWHLx_ojnKzMbrwVUB1_-y_MHUHd0mS
    hDPPCU9u5OYowhF-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdehfedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
    grthhtvghrnhepudehtddtleektedvfeeitdeljeekveelkeegvdfhtdejhefgfedtfedv
    jeejledtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:IoKcYB9GYoSK00WkYVTCKhz42FvY_-lFtGbytKYkGVm7tV9fcZZ5AQ>
    <xmx:IoKcYFohT3SBwuvlr9DhIgfSl9Haddig_rBDsj-OLjMJh-goJz0Hvg>
    <xmx:IoKcYKrT46SoI-qphwnsTaVVRyGzodsqutHI3MDInuWqqzN71d_kKg>
    <xmx:JIKcYGf0Ov-KiUGmAOFbQfNwr5X29TGoLSA5oaleTqS0llwFYlJdfJWbs9Q>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B0692A00079; Wed, 12 May 2021 21:34:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-448-gae190416c7-fm-20210505.004-gae190416
Mime-Version: 1.0
Message-Id: <6d4338e2-d9be-411a-aeb7-7d46121b73d4@www.fastmail.com>
In-Reply-To: <20210510014231.647-3-zev@bewilderbeest.net>
References: <20210510014231.647-1-zev@bewilderbeest.net>
 <20210510014231.647-3-zev@bewilderbeest.net>
Date:   Thu, 13 May 2021 11:04:06 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Zev Weiss" <zev@bewilderbeest.net>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jeremy Kerr" <jk@ozlabs.org>
Cc:     openbmc@lists.ozlabs.org, "Jiri Slaby" <jirislaby@kernel.org>,
        "Joel Stanley" <joel@jms.id.au>, "Johan Hovold" <johan@kernel.org>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: =?UTF-8?Q?Re:_[PATCH_2/3]_serial:_8250=5Faspeed=5Fvuart:_initialize_vuar?=
 =?UTF-8?Q?t->port_in_aspeed=5Fvuart=5Fprobe()?=
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On Mon, 10 May 2021, at 11:12, Zev Weiss wrote:
> Previously this had only been initialized if we hit the throttling path
> in aspeed_vuart_handle_irq(); moving it to the probe function is a
> slight consistency improvement and avoids redundant reinitialization in
> the interrupt handler.  It also serves as preparation for converting the
> driver's I/O accesses to use port->port.membase instead of its own
> vuart->regs.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---
>  drivers/tty/serial/8250/8250_aspeed_vuart.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c 
> b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> index 9e8b2e8e32b6..249164dc397b 100644
> --- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
> +++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> @@ -349,11 +349,9 @@ static int aspeed_vuart_handle_irq(struct 
> uart_port *port)
>  			struct aspeed_vuart *vuart = port->private_data;
>  			__aspeed_vuart_set_throttle(up, true);
>  
> -			if (!timer_pending(&vuart->unthrottle_timer)) {
> -				vuart->port = up;
> +			if (!timer_pending(&vuart->unthrottle_timer))
>  				mod_timer(&vuart->unthrottle_timer,
>  					  jiffies + unthrottle_timeout);
> -			}
>  
>  		} else {
>  			count = min(space, 256);
> @@ -511,6 +509,7 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
>  		goto err_clk_disable;
>  
>  	vuart->line = rc;
> +	vuart->port = serial8250_get_port(vuart->line);

The documentation of serial8250_get_port() is somewhat concerning wrt 
the use:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/tty/serial/8250/8250_core.c?h=v5.13-rc1#n399

However, given the existing behaviour it shouldn't be problematic?

Andrew
