Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D59BC433B4
	for <linux-serial@archiver.kernel.org>; Fri, 23 Apr 2021 10:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E6606145F
	for <linux-serial@archiver.kernel.org>; Fri, 23 Apr 2021 10:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241889AbhDWKPE (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 23 Apr 2021 06:15:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230502AbhDWKPE (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Apr 2021 06:15:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0ECB761445;
        Fri, 23 Apr 2021 10:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619172867;
        bh=lGPwUSMb5Bj8plk1+Wyt4jWP6VdYdw5HtTjMPfSlBEw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=reWGkWty+85gnfxO/Llz8nV1wqS2NNLqK9yfZ4OTfa3qkDQN3nwy7YxVqJZMvXnyW
         ITPulOdvVo7ejcc4bsPamSiKXIKEl/BBbe0wzCm4bBgUADCgXoywqBEq0F7jNPIul5
         WsBdLUtLR4Y6EXQVXRjjWUFxq0Bw4pleA6uRBi5I=
Date:   Fri, 23 Apr 2021 12:14:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "tiantao (H)" <tiantao6@huawei.com>
Cc:     Tian Tao <tiantao6@hisilicon.com>, jirislaby@kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: serial: samsung_tty: remove set but not used
 variables
Message-ID: <YIKeAFbqyl00tHXH@kroah.com>
References: <1619170740-63717-1-git-send-email-tiantao6@hisilicon.com>
 <YIKXs7WCF2zI3uvI@kroah.com>
 <660e8905-6c5c-e076-5211-a87a62ea5c87@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <660e8905-6c5c-e076-5211-a87a62ea5c87@huawei.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Apr 23, 2021 at 05:54:16PM +0800, tiantao (H) wrote:
> 
> 在 2021/4/23 17:47, Greg KH 写道:
> > On Fri, Apr 23, 2021 at 05:39:00PM +0800, Tian Tao wrote:
> > > The value of 'ret' is not used, so just delete it.
> > > 
> > > Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> > > ---
> > >   drivers/tty/serial/samsung_tty.c | 1 -
> > >   1 file changed, 1 deletion(-)
> > > 
> > > diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> > > index d9e4b67..d269d75 100644
> > > --- a/drivers/tty/serial/samsung_tty.c
> > > +++ b/drivers/tty/serial/samsung_tty.c
> > > @@ -2220,7 +2220,6 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
> > >   			default:
> > >   				dev_warn(&pdev->dev, "unsupported reg-io-width (%d)\n",
> > >   						prop);
> > > -				ret = -EINVAL;
> > That looks odd, shouldn't you do something with this instead of ignoring
> > it???
> 
> How about this ？
> 
> diff --git a/drivers/tty/serial/samsung_tty.c
> b/drivers/tty/serial/samsung_tty.c
> index d9e4b67..9fbc611 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -2220,8 +2220,7 @@ static int s3c24xx_serial_probe(struct platform_device
> *pdev)
>                         default:
>                                 dev_warn(&pdev->dev, "unsupported
> reg-io-width (%d)\n",
>                                                 prop);
> -                               ret = -EINVAL;
> -                               break;
> +                               return -EINVAL;
> 

You tell me, does the patch work for you?

Is this really a "hard error" and did you now just break devices that
used to work properly?  Are you correctly unwinding any previously
allocated state when you return here?

Please do some research on this, and ideally, lots of testing, before
submitting it as a real solution.

thanks,

greg k-h
