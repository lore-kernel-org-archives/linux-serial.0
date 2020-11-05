Return-Path: <SRS0=qe7h=EL=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50920C00A89
	for <linux-serial@archiver.kernel.org>; Thu,  5 Nov 2020 09:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8DEA2068D
	for <linux-serial@archiver.kernel.org>; Thu,  5 Nov 2020 09:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iet3rID4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730685AbgKEJAN (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 5 Nov 2020 04:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730559AbgKEJAL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 5 Nov 2020 04:00:11 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6E3C0613CF
        for <linux-serial@vger.kernel.org>; Thu,  5 Nov 2020 01:00:10 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id p1so766361wrf.12
        for <linux-serial@vger.kernel.org>; Thu, 05 Nov 2020 01:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=OC9aACGGqpKEo7MnuaDGqRBy9T/1FYSfYU5LJ+QJCl8=;
        b=iet3rID42HqMn/ztHv9eczOUGQRszWGQ4gTxGQMciIqMK+4ZPQwPczqI+p4wnA/cls
         3KMpzJRDwZTGeHEAeQVc7BwEYhYUIfRfgnb+QwIxCfjpzgRfhgcyu4G7eAawtxEQrieT
         I7q/vTtpaF+Y+FefNaVDFIGfJ5CUMcwQgjKNB1eY/YlQtu6cVWya4DsiQakJEJxQjlfG
         +0UUkxOV2E7+IlHLR4NPuAESrUTjFXcofSoMWk3L1njZdLJ1bmt9NX1bNEjCmWtPVjN1
         3UBHONZSsQ3NQv9FyTFCvxkK0ZjfbtpubblFmrhhGCgdn9Sj1TqFUfzZTRiTbzbBhD8q
         B0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OC9aACGGqpKEo7MnuaDGqRBy9T/1FYSfYU5LJ+QJCl8=;
        b=X3jPibIiv15/jTRswDyXUsBdO2a2pILOV65L7VfSGk0c90i2OTt4RE43VzBSpaoH/s
         nALEr1GheTGhIFUhZABUTh/8ilDx9mQUjHNYUdQL1et8fzEPaTt4OYL1JHJsGYDjI9s6
         5VvbIFewB+l9zQASUvXh3r79pbM2JA3LhrCti7Zw043vWgsKRaF2kyo3JkDkutJhsbVY
         AZ3XIU23KfDopksDRwmLeFoAd6FTtKwm2qg8N4t5LOcUwGDBcyIp5j2YkDmTzVWw3GFX
         ZvLkidzXiKF7Pdcvb/oVfD6StCG8Tj0P6hID/wsTguW1ETkt/9y16gDQ4p3VAf4N5s68
         YlsQ==
X-Gm-Message-State: AOAM530AChAUOqrJZSRcLtq/tdetS2w7AL0LCZszdkoDpwS0E6PpGxFg
        ytq82r/wGl9PH0n79cQZX50rOg==
X-Google-Smtp-Source: ABdhPJz5YH+O3f4r5/BhYEyIUJbNVI13RXq1//82HKWKaWy7iY9wQSpO1aKBSoydNPOzuoqt70Vkcw==
X-Received: by 2002:adf:f185:: with SMTP id h5mr1679324wro.10.1604566809726;
        Thu, 05 Nov 2020 01:00:09 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id g23sm1567257wmh.21.2020.11.05.01.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 01:00:09 -0800 (PST)
Date:   Thu, 5 Nov 2020 09:00:07 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>, linux-serial@vger.kernel.org
Subject: Re: [PATCH 34/36] tty: serial: pmac_zilog: Make disposable variable
 __always_unused
Message-ID: <20201105090007.GE4488@dell>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
 <20201104193549.4026187-35-lee.jones@linaro.org>
 <445a6440-b4c8-4536-891b-0cefc78e5f57@csgroup.eu>
 <e027b620-56f8-7d8b-84ff-54839f94a4c7@kernel.org>
 <20201105083626.GW4488@dell>
 <a6b63789-1315-cec1-9575-0d858a6da1d5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a6b63789-1315-cec1-9575-0d858a6da1d5@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, 05 Nov 2020, Jiri Slaby wrote:

> On 05. 11. 20, 9:36, Lee Jones wrote:
> > On Thu, 05 Nov 2020, Jiri Slaby wrote:
> > 
> > > On 05. 11. 20, 8:04, Christophe Leroy wrote:
> > > > 
> > > > 
> > > > Le 04/11/2020 à 20:35, Lee Jones a écrit :
> > > > > Fixes the following W=1 kernel build warning(s):
> > > > > 
> > > > >    drivers/tty/serial/pmac_zilog.h:365:58: warning: variable
> > > > > ‘garbage’ set but not used [-Wunused-but-set-variable]
> > > > 
> > > > Explain how you are fixing this warning.
> > > > 
> > > > Setting  __always_unused is usually not the good solution for fixing
> > > > this warning, but here I guess this is likely the good solution. But it
> > > > should be explained why.
> > 
> > There are normally 3 ways to fix this warning;
> > 
> >   - Start using/checking the variable/result
> >   - Remove the variable
> >   - Mark it as __{always,maybe}_unused
> > 
> > The later just tells the compiler that not checking the resultant
> > value is intentional.  There are some functions (as Jiri mentions
> > below) which are marked as '__must_check' which *require* a dummy
> > (garbage) variable to be used.
> > 
> > > Or, why is the "garbage =" needed in the first place? read_zsdata is not
> > > defined with __warn_unused_result__.
> > 
> > I used '__always_used' here for fear of breaking something.
> > 
> > However, if it's safe to remove it, then all the better.
> 
> Yes please -- this "garbage" is one of the examples of volatile misuses. If
> readb didn't work on volatile pointer, marking the return variable as
> volatile wouldn't save it.
> 
> > > And even if it was, would (void)!read_zsdata(port) fix it?
> > 
> > That's hideous. :D
> 
> Sure, marking reads as must_check would be insane.
> 
> > *Much* better to just use '__always_used' in that use-case.
> 
> Then using a dummy variable to fool must_check must mean must_check is used
> incorrectly, no :)? But there are always exceptions…

Agreed on all points.

Will fix.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
