Return-Path: <SRS0=r4Ma=EM=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45413C55178
	for <linux-serial@archiver.kernel.org>; Fri,  6 Nov 2020 10:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8D7421D46
	for <linux-serial@archiver.kernel.org>; Fri,  6 Nov 2020 10:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SIg/BQUZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgKFKF5 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 6 Nov 2020 05:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbgKFKF5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 6 Nov 2020 05:05:57 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8201C0613D2
        for <linux-serial@vger.kernel.org>; Fri,  6 Nov 2020 02:05:56 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id n15so702583wrq.2
        for <linux-serial@vger.kernel.org>; Fri, 06 Nov 2020 02:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DkOMBYzaOwwm2Jd4/IVOn7Fh7gujV7pgKKL98OyiWYQ=;
        b=SIg/BQUZz5FWQOLNcgKYKq8fHjskRqU7XPO/fP2fxTZwsuJh0ch/jlPnZ6hheJLqwy
         Dmm7yN3XvMGy9mu+m6z2DRvZU20NwkyGtgBCOa17nu3GzLrBmaTRokbGuH66HA2jBD/X
         fXD8ZnV8Y/YHMCsfiwBOvgtILfozV5Lc/m55z+af8AGZqsaZ8HyGT4SV69HblhlL0wmL
         6LjsSlf9OFJdEfYgGy7HB9iDaXvLtM06c2I5XP48pfEvrlUYU1Wch92TvZNof9cx3q/D
         7ySUv7YTWauTe6pud2LchDntLSP+sAfjtSmyS4CngaXzRFmJzCXofqjjQ9ROiZ32bNh9
         sqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DkOMBYzaOwwm2Jd4/IVOn7Fh7gujV7pgKKL98OyiWYQ=;
        b=VwWFBd4y+7Pxd7EQj7te+Q6+o7Zl8gkX2Q0bYfvEaV3V4Dt2IdXtgJaVS7S77xmXMr
         q3J5oCdwU0O7XI0wkXSS7JBixUpn9uru0rBgQS6FfUadr89VkUdtPMFnLyARs3eR78Ol
         nusKFJHL1+6q3drFfOqsT4U5d7+GJk/OBtZEL16CJcGxxZLjpW6NEbtwHKREXOG5emHq
         l1exsnSByUvrmOTSuBJ7INltx2kFyaqR3VVHF3w+nIkmkjzd6SJQLxfSKKNzUEodQZM8
         +EY900QL0LvevFDw5c2rwjlDUFWu6/7+3Y8REB92H3BHWudtZbnWAGRY3fDsug997ev8
         S0uw==
X-Gm-Message-State: AOAM532jG/wlWAGbnlv2pzwjgtSA8VHm+dGs2mY7jy68nvcAOOnkcGvb
        qQA5kctuXwSg0Yw3Nr8gBww2ag==
X-Google-Smtp-Source: ABdhPJwHj2fg//pEOyB/buDzK/+24CtEz7dehCHNHqpW2EFLPtIMEVfH+fNlHdz4nZTPs4eXP0yofw==
X-Received: by 2002:adf:f644:: with SMTP id x4mr1793072wrp.5.1604657155384;
        Fri, 06 Nov 2020 02:05:55 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id n9sm1542082wmd.4.2020.11.06.02.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 02:05:54 -0800 (PST)
Date:   Fri, 6 Nov 2020 10:05:52 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Mike Hudson <Exoray@isys.ca>, linux-serial@vger.kernel.org
Subject: Re: [PATCH 13/36] tty: serial: 8250: 8250_port: Staticify functions
 referenced by pointers
Message-ID: <20201106100552.GA2063125@dell>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
 <20201104193549.4026187-14-lee.jones@linaro.org>
 <20201106095326.GA2652562@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201106095326.GA2652562@kroah.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, 06 Nov 2020, Greg Kroah-Hartman wrote:

> On Wed, Nov 04, 2020 at 07:35:26PM +0000, Lee Jones wrote:
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/tty/serial/8250/8250_port.c:349:14: warning: no previous prototype for ‘au_serial_in’ [-Wmissing-prototypes]
> >  drivers/tty/serial/8250/8250_port.c:359:6: warning: no previous prototype for ‘au_serial_out’ [-Wmissing-prototypes]
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Jiri Slaby <jirislaby@kernel.org>
> > Cc: Mike Hudson <Exoray@isys.ca>
> > Cc: linux-serial@vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/tty/serial/8250/8250_port.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> And now I get build errors of:
> 	ld: drivers/tty/serial/8250/8250_early.o: in function `early_au_setup':
> 	8250_early.c:(.init.text+0x7): undefined reference to `au_serial_in'
> 	ld: 8250_early.c:(.init.text+0xf): undefined reference to `au_serial_out'
> 	make: *** [Makefile:1164: vmlinux] Error 1
> 
> Always test-build your patches, perhaps W=1 was wrong here...

I *always* test build my sets before posting.

/investigating

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
