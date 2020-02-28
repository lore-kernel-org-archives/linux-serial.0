Return-Path: <SRS0=j4md=4Q=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABF0C3F2D4
	for <linux-serial@archiver.kernel.org>; Fri, 28 Feb 2020 10:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22392246A8
	for <linux-serial@archiver.kernel.org>; Fri, 28 Feb 2020 10:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="SToHZC4O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgB1K0j (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 28 Feb 2020 05:26:39 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:41257 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgB1K0j (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 28 Feb 2020 05:26:39 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id B719023EC4;
        Fri, 28 Feb 2020 11:26:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1582885596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JD2GcxRcyRHyxJNPoNSaMvwCSde4eO14BTyUP9NZW6w=;
        b=SToHZC4OE6rvse39oPJXX2Q9inJgFheKTK5P+jjZYtrWoqBplO97oBYw7O3csPrOuXuIEN
        0aUtunNDkM7fZwg4F86/l8vEE+e/YXW2eTnA9ZzR3KFZNlQwgxNg/DL/TsvmjF0kFKR/Cx
        NqxUCp95i52VS0OVn/dMrfSnJ0UR81A=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 28 Feb 2020 11:26:36 +0100
From:   Michael Walle <michael@walle.cc>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: earlycon: prefer EARLYCON_DECLARE() variant
In-Reply-To: <20200220174607.24285-1-michael@walle.cc>
References: <20200220174607.24285-1-michael@walle.cc>
Message-ID: <ba54e9c14d4e0947df964964c020bc71@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: /
X-Rspamd-Server: web
X-Rspamd-Queue-Id: B719023EC4
X-Spamd-Result: default: False [-0.10 / 15.00];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[4];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[]
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Greg,


Am 2020-02-20 18:46, schrieb Michael Walle:
> If a driver exposes early consoles with EARLYCON_DECLARE() and
> OF_EARLYCON_DECLARE(), pefer the non-OF variant if the user specifies 
> it
> by
>   earlycon=<driver>,<options>
> 
> The rationale behind this is that some drivers register multiple setup
> functions under the same driver name. Eg.
> 
> OF_EARLYCON_DECLARE(lpuart, "fsl,vf610-lpuart", 
> lpuart_early_console_setup);
> OF_EARLYCON_DECLARE(lpuart32, "fsl,ls1021a-lpuart",
> lpuart32_early_console_setup);
> OF_EARLYCON_DECLARE(lpuart32, "fsl,imx7ulp-lpuart",
> lpuart32_imx_early_console_setup);
> EARLYCON_DECLARE(lpuart, lpuart_early_console_setup);
> EARLYCON_DECLARE(lpuart32, lpuart32_early_console_setup);
> 
> It depends on the order of the entries which console_setup() actually
> gets called. To make things worse, I guess it also depends on the
> compiler how these are ordered. Thus always prefer the 
> EARLYCON_DECLARE()
> ones.

Do you have an opinon on this proposal?

-michael

> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  drivers/tty/serial/earlycon.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/tty/serial/earlycon.c 
> b/drivers/tty/serial/earlycon.c
> index c14873b67803..2ae9190b64bb 100644
> --- a/drivers/tty/serial/earlycon.c
> +++ b/drivers/tty/serial/earlycon.c
> @@ -170,6 +170,7 @@ static int __init register_earlycon(char *buf,
> const struct earlycon_id *match)
>  int __init setup_earlycon(char *buf)
>  {
>  	const struct earlycon_id **p_match;
> +	bool empty_compatible = true;
> 
>  	if (!buf || !buf[0])
>  		return -EINVAL;
> @@ -177,6 +178,7 @@ int __init setup_earlycon(char *buf)
>  	if (early_con.flags & CON_ENABLED)
>  		return -EALREADY;
> 
> +again:
>  	for (p_match = __earlycon_table; p_match < __earlycon_table_end;
>  	     p_match++) {
>  		const struct earlycon_id *match = *p_match;
> @@ -185,6 +187,10 @@ int __init setup_earlycon(char *buf)
>  		if (strncmp(buf, match->name, len))
>  			continue;
> 
> +		/* prefer entries with empty compatible */
> +		if (empty_compatible && *match->compatible)
> +			continue;
> +
>  		if (buf[len]) {
>  			if (buf[len] != ',')
>  				continue;
> @@ -195,6 +201,11 @@ int __init setup_earlycon(char *buf)
>  		return register_earlycon(buf, match);
>  	}
> 
> +	if (empty_compatible) {
> +		empty_compatible = false;
> +		goto again;
> +	}
> +
>  	return -ENOENT;
>  }
