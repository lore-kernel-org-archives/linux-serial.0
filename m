Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69B0C433FE
	for <linux-serial@archiver.kernel.org>; Tue,  8 Dec 2020 15:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 993F123A7B
	for <linux-serial@archiver.kernel.org>; Tue,  8 Dec 2020 15:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729619AbgLHPbu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 8 Dec 2020 10:31:50 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37407 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729386AbgLHPbu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 8 Dec 2020 10:31:50 -0500
Received: by mail-ot1-f65.google.com with SMTP id o11so13440701ote.4
        for <linux-serial@vger.kernel.org>; Tue, 08 Dec 2020 07:31:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=93g+Ol6Ot1+Wqz2qR0mY6H3PF8b97iQ3cDYJ4vzcDIM=;
        b=IWPvSK7KSC9guB1mdTant/5UPKe1dRdA9qNqca0ybRnqhsdQaNOAVO38geXlD6XB2a
         26KqrL48b8HFUpfzhkGGJEn8GMhWqe5NoWKK2IKgzmLiGn/U+KbyotaiQW24qiLPXsCu
         lGFiqW4j/e2irzh3I9a6CuGNaNtR4CB9H1f5KgoWnls7bNFMzfoQ2giZyrpILWu8KENo
         lBXZQKsBDLTYcE/7v9hWj4I8mOg5fm/PxOnN0yIU3cWgiMAVTHDGspFO3F8/0hv/pDJa
         slAxBIk9RpPCWlPdhLTg21Oq4DLbvrJYNrOZeaYzPdgyt6XIGcw+JDChfrEZtikmdALj
         cDOw==
X-Gm-Message-State: AOAM530LOPU6VRQuZ/6qW72Vb+1CmDBJTLwKdqHBu7FvT5636ezfUjec
        nECuwPFtr4/US61lbe9E13HGA3bSoiZs0Ia0er4=
X-Google-Smtp-Source: ABdhPJwMJ12/HVj/+z4M6MTJQDnJv9cMD+A33Wzwf3d81Ntqr2LpDOnWwWjoP7zZK/BjqIHQpUdAzuCEn3E3T/cnd6Q=
X-Received: by 2002:a05:6830:210a:: with SMTP id i10mr17136911otc.145.1607441469137;
 Tue, 08 Dec 2020 07:31:09 -0800 (PST)
MIME-Version: 1.0
References: <20201125081352.25409-1-zajec5@gmail.com> <X74Uanu26sx4Hait@kroah.com>
 <6b107933-9ab1-7c46-c383-ed39b71b4ecb@gmail.com> <X74bxfji0uTZV8y9@kroah.com>
 <CAMuHMdXA+B_=abXAzCt5m3djjhLpzuDEtEhF_8UYkm95hu_4PA@mail.gmail.com> <805a393a-73c2-6016-da65-681ddbebebb3@gmail.com>
In-Reply-To: <805a393a-73c2-6016-da65-681ddbebebb3@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Dec 2020 16:30:58 +0100
Message-ID: <CAMuHMdX9rz1_7QQiBvn-vL_dj3YxVpksznkz4a2T6mBgajUxGA@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: bcm63xx: allow building on ARM64
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Rafał,

On Tue, Dec 8, 2020 at 11:59 AM Rafał Miłecki <zajec5@gmail.com> wrote:
> Could you suggest & send some Documentation on that so we have a global rule
> instead of per-tree / per-maintainer preferences, please? I'd really
> appreciate that.

Thanks, good idea!

[PATCH 0/2] Documentation/kbuild: Document COMPILE_TEST and platform
dependencies
https://lore.kernel.org/r/20201208152857.2162093-1-geert+renesas@glider.be

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
