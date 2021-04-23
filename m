Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C43C433B4
	for <linux-serial@archiver.kernel.org>; Fri, 23 Apr 2021 09:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0212E6128A
	for <linux-serial@archiver.kernel.org>; Fri, 23 Apr 2021 09:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241833AbhDWJsM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 23 Apr 2021 05:48:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230036AbhDWJsL (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Apr 2021 05:48:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ECCB161352;
        Fri, 23 Apr 2021 09:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619171255;
        bh=da3GizwNOrqX+2anZBhnKlrbaJr8dBNKs8pznv+Hjus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NMam6L7ZIFyfrvSxdSOMsrY51chAPmC5A/tGPSz8IG/JZDLbicgEDsLWz/bvewkNL
         Zy9zmKwx6hrRvwSTLVwr9clJb5OlP3Ykwa0k7ITN0TFK+a/b1q4qX2+NKp/GUGlJLJ
         f4K9rs7vvNGixk258jfbN/VIR4iIB1qYdi3faQJo=
Date:   Fri, 23 Apr 2021 11:47:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     jirislaby@kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: serial: samsung_tty: remove set but not used
 variables
Message-ID: <YIKXs7WCF2zI3uvI@kroah.com>
References: <1619170740-63717-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1619170740-63717-1-git-send-email-tiantao6@hisilicon.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Apr 23, 2021 at 05:39:00PM +0800, Tian Tao wrote:
> The value of 'ret' is not used, so just delete it.
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
>  drivers/tty/serial/samsung_tty.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index d9e4b67..d269d75 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -2220,7 +2220,6 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
>  			default:
>  				dev_warn(&pdev->dev, "unsupported reg-io-width (%d)\n",
>  						prop);
> -				ret = -EINVAL;

That looks odd, shouldn't you do something with this instead of ignoring
it???

