Return-Path: <SRS0=r4Ma=EM=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8178AC388F2
	for <linux-serial@archiver.kernel.org>; Fri,  6 Nov 2020 10:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22779206DC
	for <linux-serial@archiver.kernel.org>; Fri,  6 Nov 2020 10:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uprwfviy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgKFKQu (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 6 Nov 2020 05:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgKFKQu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 6 Nov 2020 05:16:50 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E12C0613D2
        for <linux-serial@vger.kernel.org>; Fri,  6 Nov 2020 02:16:49 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id y12so721850wrp.6
        for <linux-serial@vger.kernel.org>; Fri, 06 Nov 2020 02:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6L9JeUWoNBxsQ2u2fgHHCXdFZ5MPFmvxZ5BNcxlrU7o=;
        b=UprwfviyhKGM+WUYM4NtgdofoWC4MVHl4C94PV8WzSvNXpdd9CZrPxgU+JAK5O0QWq
         zJvLDksgV4S7PsxJ0dp5p5Vv5GPFjWKebfqtwFk0SrMpnwOR3JNZLfF0Z9j4sAHM84Fs
         bqsEi2PQuvEfr9cMbhzpYTQSwRuMIoMY2YUSDKsgYwKe/118yLk1APbOp8oMw7cRDXGS
         Ke6Yf+/QRMduaYF4WZIEFEeE1VG4IDc7Z8kXIeWVX/p6L9d99mVASaBFbcBR6+Rriz3R
         oV+qbQsdS0AsjSymj7Xecgg9DPIeKtosi3znZSAaQDCQLDbxJPqxD5AFe1yGnSIB9OTS
         cQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6L9JeUWoNBxsQ2u2fgHHCXdFZ5MPFmvxZ5BNcxlrU7o=;
        b=aMDMyF7xXDr/RKiik3x5hwT+cPBA5MBjFSHK5yio32TtZHiCEhFhQSH0kwi0EgXJV9
         9FnY7MwDNTLX4WhQh0hvZrKYbcdtHsxxOXJrmdFvNYmaP6BHjYCI6yTSMWB4Nq9MEryJ
         Xr2vYiHN+g/xBKd0uHXgRgLVLdtg97pDzF0RjuHhlLske/i4CfCVrv0q29NmWWyjcfNI
         2Aj7rVV8VUMsR45moSmZPjOxK7At8VAOU4mvSkKdn5uMWYcCoN4iaFgaMrfNjIBRdvPe
         +QeCSpvQudRczE9rhy8voEfdepwzDX1Tuvx6WI7yEGAJm/QHNtabDkNJlf8OUuvbweTA
         wIVg==
X-Gm-Message-State: AOAM531yDna8YPZF1tX+EOzbAP4qD9Ei/rGDzQ2lA8LEN3QDIKRJzoPj
        7kfNc+8GbHM9JXJW1qquZek+iw==
X-Google-Smtp-Source: ABdhPJwzSuIyg5V4IAhY/mFu4HPoQAojaX/su37Vjkq++11CyG43w4nmRwNFqKQyqhOoGIHqyeWyjQ==
X-Received: by 2002:adf:e412:: with SMTP id g18mr1787350wrm.211.1604657808370;
        Fri, 06 Nov 2020 02:16:48 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id y185sm1567104wmb.29.2020.11.06.02.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 02:16:47 -0800 (PST)
Date:   Fri, 6 Nov 2020 10:16:46 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Mike Hudson <Exoray@isys.ca>, linux-serial@vger.kernel.org
Subject: Re: [PATCH 13/36] tty: serial: 8250: 8250_port: Staticify functions
 referenced by pointers
Message-ID: <20201106101646.GB2063125@dell>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
 <20201104193549.4026187-14-lee.jones@linaro.org>
 <20201106095326.GA2652562@kroah.com>
 <20201106100552.GA2063125@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201106100552.GA2063125@dell>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, 06 Nov 2020, Lee Jones wrote:

> On Fri, 06 Nov 2020, Greg Kroah-Hartman wrote:
> 
> > On Wed, Nov 04, 2020 at 07:35:26PM +0000, Lee Jones wrote:
> > > Fixes the following W=1 kernel build warning(s):
> > > 
> > >  drivers/tty/serial/8250/8250_port.c:349:14: warning: no previous prototype for ‘au_serial_in’ [-Wmissing-prototypes]
> > >  drivers/tty/serial/8250/8250_port.c:359:6: warning: no previous prototype for ‘au_serial_out’ [-Wmissing-prototypes]
> > > 
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: Jiri Slaby <jirislaby@kernel.org>
> > > Cc: Mike Hudson <Exoray@isys.ca>
> > > Cc: linux-serial@vger.kernel.org
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >  drivers/tty/serial/8250/8250_port.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > And now I get build errors of:
> > 	ld: drivers/tty/serial/8250/8250_early.o: in function `early_au_setup':
> > 	8250_early.c:(.init.text+0x7): undefined reference to `au_serial_in'
> > 	ld: 8250_early.c:(.init.text+0xf): undefined reference to `au_serial_out'
> > 	make: *** [Makefile:1164: vmlinux] Error 1
> > 
> 
> I *always* test build my sets before posting.
> 
> /investigating

What config failed for you?

It looks as though SERIAL_8250_CONSOLE is a bool and doesn't appear to
be compiled with allmodconfig builds for any architecture that I test
against (Arm, Arm64, MIPS, PPC, x86).

> > perhaps W=1 was wrong here...

NEVER! ;)

The prototype just needs moving is all.

I'll fix the issue and re-post an alternative patch.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
