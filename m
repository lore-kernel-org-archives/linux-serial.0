Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546FFC433ED
	for <linux-serial@archiver.kernel.org>; Thu,  1 Apr 2021 04:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 265D36101A
	for <linux-serial@archiver.kernel.org>; Thu,  1 Apr 2021 04:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbhDAEQa (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 1 Apr 2021 00:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhDAEP7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 1 Apr 2021 00:15:59 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEDAC0613E6;
        Wed, 31 Mar 2021 21:15:58 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id c6so643506qtc.1;
        Wed, 31 Mar 2021 21:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DnLOo/zKFvvfvZUcx+JWPM+sG45h5ZMlE6pfJth5bZA=;
        b=FSY9bK6EqVMbAvbJjmaAGvWT2YTq6+22I+ohI8uL+Jxqutw0a+tqk250xv6oUWfebr
         iFDBj2m6RXqdKKIZUF/n11GKeruzHnFE3MO6xrVts8a6ok9yoI1b4nQhrQDqOLBkXTsT
         tCrCGmieznBTNltFiXw3Tg+lgg7a57GYS1SkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DnLOo/zKFvvfvZUcx+JWPM+sG45h5ZMlE6pfJth5bZA=;
        b=rhr5TFtpJKBt+YCMGlCmPFwc2yiev7EdluRVxe/tieZGsOn37X671/anFQGt2Wsrl/
         Em5b4sHlJwY+TXSMwSrftNUwkbIIdW7MZ3D27y8BwCukJpkdAvBrByhpph1TsS6pizbk
         gMZ2Ta/8sena+1SR7MDJGx8VVAaWEbPrqKSoyc1oYPS3tvXoQBRbtINWeih6qii/Xc/o
         uBS2hkYu0fRe5CMNd8I/TSzLLrIlc6xWcAxoR8YJ2yZGtWgf6p6VAAIIICq1ilg1NgeW
         SOV4IE3TVdin7Md3e3v5nKMK4GPJLBi8hk5ywpAmXHtNlnSJOOOXI9m+YTIZ0X4jgPew
         ql5Q==
X-Gm-Message-State: AOAM533UEHX6QrSE6G4J3hnwxOOIsX8TFaAFjqDoLCYG4R+fTIpXb7mk
        j+PjXtsaNxYnTF7xjOctJG+wxe9ws89bRV0ZS4Q=
X-Google-Smtp-Source: ABdhPJypEX2gUYtGWHMsAT0fUIon/Gl9d1HFtws1V67C6FeeuxcqVZPapwQ22BWZprgSEoafxfPm3vIDhv8+xFHtLcQ=
X-Received: by 2002:ac8:7547:: with SMTP id b7mr5684873qtr.176.1617250557473;
 Wed, 31 Mar 2021 21:15:57 -0700 (PDT)
MIME-Version: 1.0
References: <YGOuhjD19SmjmQou@hatter.bewilderbeest.net> <20210401005702.28271-1-zev@bewilderbeest.net>
 <20210401005702.28271-3-zev@bewilderbeest.net>
In-Reply-To: <20210401005702.28271-3-zev@bewilderbeest.net>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 1 Apr 2021 04:15:44 +0000
Message-ID: <CACPK8XdPVf1WMmo8C8RJtd-1cH5qV9odEDhDUHWRiMOk=dQNtg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] drivers/tty/serial/8250: add DT property for
 aspeed vuart sirq polarity
To:     Zev Weiss <zev@bewilderbeest.net>, Jeremy Kerr <jk@ozlabs.org>
Cc:     OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, 1 Apr 2021 at 00:57, Zev Weiss <zev@bewilderbeest.net> wrote:
>
> This provides a simple boolean to use instead of the deprecated
> aspeed,sirq-polarity-sense property.
>
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---
>  drivers/tty/serial/8250/8250_aspeed_vuart.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> index c33e02cbde93..e5ef9f957f9a 100644
> --- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
> +++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> @@ -482,6 +482,9 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
>                 of_node_put(sirq_polarity_sense_args.np);
>         }
>
> +       if (of_property_read_bool(np, "aspeed,sirq-active-high"))
> +               aspeed_vuart_set_sirq_polarity(vuart, 1);

This assumes the default is always low, so we don't need a property to
set it to that state?

Would it make more sense to have the property describe if it's high or
low? (I'm happy for the answer to be "no", as we've gotten by for the
past few years without it).

This brings up another point. We already have the sysfs file for
setting the lpc address, from userspace. In OpenBMC land this can be
set with obmc-console-client (/etc/obmc-console.conf). Should we add
support to that application for setting the irq polarity too, and do
away with device tree descriptions?

> +
>         aspeed_vuart_set_enabled(vuart, true);
>         aspeed_vuart_set_host_tx_discard(vuart, true);
>         platform_set_drvdata(pdev, vuart);
> --
> 2.31.1
>
