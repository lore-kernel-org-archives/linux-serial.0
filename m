Return-Path: <SRS0=mq3J=B4=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B21C433E4
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 16:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1218F2067C
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 16:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqWclZAr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgHRQ2s (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 18 Aug 2020 12:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbgHRQ2F (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 Aug 2020 12:28:05 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF13C061389;
        Tue, 18 Aug 2020 09:28:04 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id v6so21670171iow.11;
        Tue, 18 Aug 2020 09:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uRFxHU+sCcIrDbdnNz1Ff4SJxMC8NnHQO31521UTxdw=;
        b=JqWclZArGkhIB1X2Y6hG/JZZxOW+hCcbwCo4uxHSeYFhfX5XPNy99cXnVGWiA1WpX2
         N1GZen2gUVAwSS3Sw1h1dzjJFPkNpxftzgpvAptrw6dkv4vH/VX+1SjfGy3113J28AsJ
         dBGAX79jQK7Q/NB684rd42FUKtFZoC4Ob2jJ2XixWtMXZWQSIVVTCJJW+T9iCn7Wy7/0
         pDrKisOhpeopnDdXpG2ajOOz9LqAor6MtvRC+ZDjB9pHh9euZNt47/gDCGYZIQ/K+Rhi
         bqNy9I8QWT2iRBnnb9541NBM18JeYBUClfEh4I15b/1mDh9212yHAP7x1axWAIVsUIvQ
         rC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uRFxHU+sCcIrDbdnNz1Ff4SJxMC8NnHQO31521UTxdw=;
        b=EmpH++ljaDMmrUoXOUC9bMCJAKMuwpscGD0ZyQ47Y6BkEaaA5y8LHRyJ/lFi8qkjQ1
         IYRbaTYp9onbJup9KkqIlnCfktgia4TVnAF22cjXeu+vRaYqjXHIFoF1JQP3qhCyHG0i
         51JlgtYjRFsJTXEkHJa8NyKhM/Q1Au78rR+PwBqChs4FGlwGkxJEg9kj9/YvhA3TsjBa
         wOa+eDZhjUTGu52RhuMvUUe6WCpG/hNQWbvgomZUWprNfdg/0M9h0YvWtaIOtSVsZjYX
         kr8w7KbJDOHGFufWsqVcmcb5OvyxEr0Y4KV65wK6UIw9IKqVnJETIdoY5Z+O6UrV+cey
         RyEQ==
X-Gm-Message-State: AOAM530Ofv2zPZUEomVKYeFOP10V0zX5yQgVFnl/iK+ylaov5NL4SHZs
        b95bfbf4Xjv+1IFOu9zdX8otj9MMmm4guXeK4hY=
X-Google-Smtp-Source: ABdhPJzgE7utaYe/bTL9/F7xJj4+WD6PvLhQORWJG0lo/Am3PJzrfgOU+i6LiGoeAvf2qE4fjXDmta//OBSKaE+rfUs=
X-Received: by 2002:a6b:c88f:: with SMTP id y137mr17088532iof.55.1597768083556;
 Tue, 18 Aug 2020 09:28:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200817170038.GA725471@kroah.com> <20200817185419.1133596-1-ztong0001@gmail.com>
 <20200818111954.GA283417@kroah.com>
In-Reply-To: <20200818111954.GA283417@kroah.com>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Tue, 18 Aug 2020 12:27:52 -0400
Message-ID: <CAA5qM4CUzJszm_kYfRMAEhA6_t81j1wJ8yWi0Jtjgyt4zTojZA@mail.gmail.com>
Subject: Re: [PATCH v2] Fixes: tty: serial: earlycon dependency
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Thanks Greg and Jiri for your suggestion!
I made another attempt to fix those problems. Hope it will work this time.
Thank you!

On Tue, Aug 18, 2020 at 7:19 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Aug 17, 2020 at 02:54:19PM -0400, Tong Zhang wrote:
> > parse_options() in drivers/tty/serial/earlycon.c calls uart_parse_earlycon
> > in drivers/tty/serial/serial_core.c therefore selecting SERIAL_EARLYCON
> > should automatically select SERIAL_CORE, otherwise will result in symbol
> > not found error during linking if SERIAL_CORE is not configured as builtin
> >
> > Signed-off-by: Tong Zhang <ztong0001@gmail.com>
>
> As Jiri pointed out, the Fixes: line goes down here, not in your subject
> line :)
>
> Please fix up, thanks.
>
> > ---
> >  drivers/tty/serial/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
>
> What changed from v1?  Also always list that below the --- line so we
> know.
>
> thanks,
>
> greg k-h
