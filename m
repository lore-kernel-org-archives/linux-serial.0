Return-Path: <SRS0=qe7h=EL=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C7FC00A89
	for <linux-serial@archiver.kernel.org>; Thu,  5 Nov 2020 08:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE83F2072E
	for <linux-serial@archiver.kernel.org>; Thu,  5 Nov 2020 08:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n9Gsyc5z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgKEIgb (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 5 Nov 2020 03:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgKEIgb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 5 Nov 2020 03:36:31 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5448C0613D2
        for <linux-serial@vger.kernel.org>; Thu,  5 Nov 2020 00:36:30 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id w1so713529wrm.4
        for <linux-serial@vger.kernel.org>; Thu, 05 Nov 2020 00:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=fVjcjfrrmXORahZp/hVfTr8m+lXVmFllNiKKjDMWxII=;
        b=n9Gsyc5zxdSKZ/TXEy7Q1nx0i1xElsOyId6HnuuHMzeVeqN9iSVzatw05vGO7/5K5m
         ecn+0SclYkXIFCNHBHmiQPvqp3o1KfVg+9wX7/Ap9yfDp/7ZiSu4G80c0x9MX7cINAcD
         Z4WBcZGVgXXuQSkfrmZZmcuFCkOtVHCVT4oleIgD22cVRVECpWH7ri2rjNeYagsqKZy5
         gS9edt1U92OFeICdQ4olSaflYMshl5zfYrietGxMgb3+kfGzsWNtpwZgFpUtnHBJB4sc
         pLwSML8QcLiVydeeQPpfwmAcQ6OPTm0W+PjsOYKGIrRfUxiXYeHdsvYTzismMOnLcRjN
         W7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fVjcjfrrmXORahZp/hVfTr8m+lXVmFllNiKKjDMWxII=;
        b=Cu+9wV/5yPwSOfgZpTuIBtwgkrpDgyy9Kqe1wOEHMHmbK1dVtOqAMFpJSTC+iSr3d6
         MHpZLEzSS5T1k/usvcMVxaw3wHFq7f8ZhNmI8jYXY9IwDixV+9t6HhUYCllg2aQcsUvz
         5RYqxmjR7uu6IvcEYbNK/EYkeBvzeRmFZU6xdeGwUKTTIx/hY3QHVyDIXgst+QwWB6la
         x2BnclK+dZkNZsNJGOmqwGPwQIS0oX8OSh3C1TCp49UkX89ChFEweF62YQlVBCZ0L2fY
         CVdkkuY3XM849+oi4BRSObUC5KuYDWJKtCAgCyBwpolbfQNvazALnyLlHnaa+k8sug7x
         zb+Q==
X-Gm-Message-State: AOAM531l17sZ6SuvP0390as3nlbEIC6a1UtIQZgVGxK1QpPM78H1K07Y
        +/ndylHJiWK1yv8w0vED0LwqIQ==
X-Google-Smtp-Source: ABdhPJywWSiq38BqbSd7YukFXshDJiCN4Em7tr9zBcurHrSuOGtYsiYwTQM9YCvQ5PvPaKd8VwAPwA==
X-Received: by 2002:a5d:55c8:: with SMTP id i8mr1461048wrw.194.1604565389496;
        Thu, 05 Nov 2020 00:36:29 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id u16sm1337124wrn.55.2020.11.05.00.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 00:36:28 -0800 (PST)
Date:   Thu, 5 Nov 2020 08:36:26 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>, linux-serial@vger.kernel.org
Subject: Re: [PATCH 34/36] tty: serial: pmac_zilog: Make disposable variable
 __always_unused
Message-ID: <20201105083626.GW4488@dell>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
 <20201104193549.4026187-35-lee.jones@linaro.org>
 <445a6440-b4c8-4536-891b-0cefc78e5f57@csgroup.eu>
 <e027b620-56f8-7d8b-84ff-54839f94a4c7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e027b620-56f8-7d8b-84ff-54839f94a4c7@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, 05 Nov 2020, Jiri Slaby wrote:

> On 05. 11. 20, 8:04, Christophe Leroy wrote:
> > 
> > 
> > Le 04/11/2020 à 20:35, Lee Jones a écrit :
> > > Fixes the following W=1 kernel build warning(s):
> > > 
> > >   drivers/tty/serial/pmac_zilog.h:365:58: warning: variable
> > > ‘garbage’ set but not used [-Wunused-but-set-variable]
> > 
> > Explain how you are fixing this warning.
> > 
> > Setting  __always_unused is usually not the good solution for fixing
> > this warning, but here I guess this is likely the good solution. But it
> > should be explained why.

There are normally 3 ways to fix this warning;

 - Start using/checking the variable/result
 - Remove the variable
 - Mark it as __{always,maybe}_unused

The later just tells the compiler that not checking the resultant
value is intentional.  There are some functions (as Jiri mentions
below) which are marked as '__must_check' which *require* a dummy
(garbage) variable to be used.

> Or, why is the "garbage =" needed in the first place? read_zsdata is not
> defined with __warn_unused_result__.

I used '__always_used' here for fear of breaking something.

However, if it's safe to remove it, then all the better.

> And even if it was, would (void)!read_zsdata(port) fix it?

That's hideous. :D

*Much* better to just use '__always_used' in that use-case.

> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: Jiri Slaby <jirislaby@kernel.org>
> > > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > Cc: Paul Mackerras <paulus@samba.org>
> > > Cc: linux-serial@vger.kernel.org
> > > Cc: linuxppc-dev@lists.ozlabs.org
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >   drivers/tty/serial/pmac_zilog.h | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/tty/serial/pmac_zilog.h
> > > b/drivers/tty/serial/pmac_zilog.h
> > > index bb874e76810e0..968aec7c1cf82 100644
> > > --- a/drivers/tty/serial/pmac_zilog.h
> > > +++ b/drivers/tty/serial/pmac_zilog.h
> > > @@ -362,7 +362,7 @@ static inline void zssync(struct uart_pmac_port
> > > *port)
> > >   /* Misc macros */
> > >   #define ZS_CLEARERR(port)    (write_zsreg(port, 0, ERR_RES))
> > > -#define ZS_CLEARFIFO(port)   do { volatile unsigned char garbage; \
> > > +#define ZS_CLEARFIFO(port)   do { volatile unsigned char
> > > __always_unused garbage; \
> > >                        garbage = read_zsdata(port); \
> > >                        garbage = read_zsdata(port); \
> > >                        garbage = read_zsdata(port); \
> > > 
> 
> thanks,

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
