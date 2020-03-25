Return-Path: <SRS0=EpC2=5K=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A39C1975A
	for <linux-serial@archiver.kernel.org>; Wed, 25 Mar 2020 07:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0756E2051A
	for <linux-serial@archiver.kernel.org>; Wed, 25 Mar 2020 07:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8lwRTfX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbgCYHkt (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 25 Mar 2020 03:40:49 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51518 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgCYHkt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 25 Mar 2020 03:40:49 -0400
Received: by mail-wm1-f65.google.com with SMTP id c187so1215962wme.1;
        Wed, 25 Mar 2020 00:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZcQgCOpSSyjnd65LhvyIe5bWwwVaaCzAPGBmKNF1bDQ=;
        b=h8lwRTfXzV2oqe7qHp2URobi2R5ylKe2mWfL1uqQcm2g2Y10hh4e6X5chXMfdZlZwQ
         SlSjlH2u13D2u/pJ5nHMKHmyg4OPYlu16Yw/TxrI9gBsIxdZCpm2GWAROMxV3voJ04Fy
         qpCAjD5SCy1k1l47T+L3LGUK1p8lrVnqXXNIylAUF8ow1hmO8u8c1w4Gid+T1IuPeye+
         20x8tQxzHXf2EkdErfX+nmmFfYA4whvFhHaez/I3/ihfoyaCC74IIxmtPdPN7xx2SPA0
         AmQ6j4PPyVLbYBb/9luQzbtkYzQmtD8eDzu8S3adBue7XlQzsUkAzwQtEvxbjLAWIZ25
         r46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZcQgCOpSSyjnd65LhvyIe5bWwwVaaCzAPGBmKNF1bDQ=;
        b=AJXUojDXZTpQHWxzIArJ5UgdWvE+rU0zVL0BHEX+HoPJqCMnp8gqBt0Gvb5sH4B41p
         xsU9bNC6wR5RFIq/WUce/nl/LZkxnpm59YBx4tQsnYWs8xKwiApzwtCBzuqsIwAOciF3
         IfK0NPw4hA4h9v7Ka/CNs7TeLHwguy+hI4TadOgSPxkoLXtMYuk+9dkqj0qkYSaZKCAH
         nOW93cU8lsLB1C+ALKF9mDhmKH6H+5UrXdSV2yzd1xvuSM5ssf3CPguD3lAcb9jYDpMP
         DJfjxeQbuyMekmMJA9oXc8mtt8ctCDMOPjh1B3R4ol9ZnPvjX1LAHgS1piH8ebBnI2Vc
         jfbQ==
X-Gm-Message-State: ANhLgQ2Wvczj/+HVwcNSJdHcHGKKhEQ2WYy88ib4HzXsmRvHxnPhwx2s
        dpxrnn737QZ8oamyqBJh1zqxjnlMEvqNc1FzlN0=
X-Google-Smtp-Source: ADFU+vsNqnvE2a0viE+fnvE1KflPLYIGSA3wX2vTPxdCyoAJSZ7SdTXUQpK0j03qSW75lJcYBWCkKqx552CE4NWkxw8=
X-Received: by 2002:a7b:cd02:: with SMTP id f2mr1999535wmj.97.1585122047718;
 Wed, 25 Mar 2020 00:40:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200324064949.23697-1-zhang.lyra@gmail.com> <20200324112115.GA10018@lakrids.cambridge.arm.com>
 <CAAfSe-u7SjWr7VK37OFrFDfm1o-6VwEoUMLctP61us+iQ1emTw@mail.gmail.com> <20200325070127.GA2960703@kroah.com>
In-Reply-To: <20200325070127.GA2960703@kroah.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Wed, 25 Mar 2020 15:40:11 +0800
Message-ID: <CAAfSe-u8B387i5w0eFatGvJFE2c4TqjsAA=9mYvqiknQhBsUuQ@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: make SERIAL_SPRD depends on ARM or ARM64
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, Jiri Slaby <jslaby@suse.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, 25 Mar 2020 at 15:02, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Mar 25, 2020 at 09:37:00AM +0800, Chunyan Zhang wrote:
> > Hi Mark, Greg,
> >
> > Pleas see my answer below.
> >
> > On Tue, 24 Mar 2020 at 19:21, Mark Rutland <mark.rutland@arm.com> wrote:
> > >
> > > On Tue, Mar 24, 2020 at 02:49:49PM +0800, Chunyan Zhang wrote:
> > > > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > >
> > > > kbuild-test reported an error:
> > > >
> > > >   config: mips-randconfig-a001-20200321 ...
> > > >   >> drivers/tty/serial/sprd_serial.c:1175: undefined reference
> > > >   to `clk_set_parent'
> > > >
> > > > Because some mips Kconfig-s select CONFIG_HAVE_CLK but not CONFIG_COMMON_CLK,
> > > > so it's probably that clk_set_parent is missed for those configs.
> > > >
> > > > To fix this error, this patch adds dependence on ARM || ARM64
> > > > for SERIAL_SPRD.
> > >
> > > From the above, isn't the real dependency COMMON_CLOCK?
> >
> > Some arch can implement its own clock APIs, for example AR7 [1].
>
> That's fine, then they can not select this option.
>
> > The sprd serial driver is used on ARM and ARM64 platforms only for
> > now, which uses clock functions provided by COMMON_CLK, but it has the
> > possibility of being used on other architecture platforms, that was my
> > thought.
> >
> > I should revise this commit message to:
> > "
> > Because some mips Kconfig-s select CONFIG_HAVE_CLK but not define
> > clk_set_parent which is used by the sprd serial driver.
> > ...
> > "
> >
> > Does it make sense?
>
> The arch is not the issue here, the clock framework is, so properly
> depend on that, not an arbitrary CPU type.

Ok, I will address it.

Thanks,
Chunyan
