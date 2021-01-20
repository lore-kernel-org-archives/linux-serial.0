Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDEDC433E0
	for <linux-serial@archiver.kernel.org>; Wed, 20 Jan 2021 17:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05AA5233F7
	for <linux-serial@archiver.kernel.org>; Wed, 20 Jan 2021 17:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403795AbhATRKZ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 20 Jan 2021 12:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390851AbhATRJi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 20 Jan 2021 12:09:38 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F2CC061575;
        Wed, 20 Jan 2021 09:08:57 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d4so12850413plh.5;
        Wed, 20 Jan 2021 09:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ptEn4M/4h5MW2qLMCPiuNB3Z51Vfz0q0JdsXATxLpEM=;
        b=c2hYlVq98Chql/KXUc9uAOGLV/73KgjxyJXzz0kDS1RB9OAE7lluf/CP3+r+kQstjB
         7m7EKSUS/P6wpk72hMavSemdDA3XB6oItn9KTtM1pP3GH7KcwxQ3gzeZnC36X+m1BWYW
         gpz3X3O6QNoWLeriGkxcBWlTnGnuCfEhvYqgvV+1GigdUupve08u/nSJLpGYzn82lfA+
         KCC9XP/pmKwL87w2UYPN8Fl8jCrX+Jl7e6846JD+4gV2wJ6PaYtrOhlpmbepo+EBEKGg
         NOSvf8kAh2GjvyaovvWc26OBKTM3JbZhNTEYFLWT6JntRvm1wQnc//WyyU/tv4GKW4Et
         rqfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ptEn4M/4h5MW2qLMCPiuNB3Z51Vfz0q0JdsXATxLpEM=;
        b=uY2awQFB6kLWE1HVFTaep1nbpfQ5ghgBCc2ozUX2193/HlboGZ0MEwcIYPnBDJj6L9
         arhMUzG2iTzUdZKLS2QR25fCctBs+Vx2fJf78nnJlGzxBKcWIFs6cwJVKuBkvUOqHCbC
         FWuvCYDxJbI1OpY6eL510q+AKzv98Czj1Ad7ls8eLmSdZQT2pdtS/3yVD/Ex64OSZRKG
         /DGqsqhnAISB3Yrxq8O+2FJPF6srbf5wO9W9RTl9lr+5zY+flZu/2BqK/mPQCbNrTb5O
         Xh2An8mCjePWIEqwhTEv65n6/Z3L7EakUPhBPfXZOh8AjB92i4B6u2QykIenjdEDMI+/
         s6xA==
X-Gm-Message-State: AOAM533IW14/+7l+rQEFaLRIbaEn0HWb9lBsTycUBoNrkvKyrZV1YBc9
        nWoCFV+HpKXuwQGIRZHO2dYMrt6kukBoqiocZz4=
X-Google-Smtp-Source: ABdhPJwYti8YPHWOXLYtaMeAapgAALfqTD5H6Up/eShdPNst1ffO+zrAYs43yfMRfH7gknDvlFqOMB43ovExCJI4ypI=
X-Received: by 2002:a17:902:7b96:b029:de:7ae6:b8db with SMTP id
 w22-20020a1709027b96b02900de7ae6b8dbmr10782173pll.0.1611162537358; Wed, 20
 Jan 2021 09:08:57 -0800 (PST)
MIME-Version: 1.0
References: <20210115211543.33563-1-alcooperx@gmail.com> <20210115211543.33563-3-alcooperx@gmail.com>
 <CAHp75VdQPQK8jTF3QDKx6mF1QzOg-qiuHrTiojnWn7GskokfoA@mail.gmail.com>
 <71d58a3e-2707-69d7-8074-c67235912e06@gmail.com> <CAHp75VfNumFBwbytCuA_YK1w-+kN20vRF+GhogtU+DDG3EB_7g@mail.gmail.com>
 <YAhiw+6UiUplNcLq@kroah.com>
In-Reply-To: <YAhiw+6UiUplNcLq@kroah.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 20 Jan 2021 19:09:46 +0200
Message-ID: <CAHp75Vf-ZmPuOjRYwNbURJXP3g_-m1LUDbsWtKHMvP49jseprw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] serial: 8250: Add new 8250-core based Broadcom STB driver
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        devicetree <devicetree@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jan 20, 2021 at 7:05 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Wed, Jan 20, 2021 at 06:47:52PM +0200, Andy Shevchenko wrote:
> > On Tue, Jan 19, 2021 at 8:16 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> > > On 1/19/2021 7:21 AM, Andy Shevchenko wrote:
> > > > On Fri, Jan 15, 2021 at 11:19 PM Al Cooper <alcooperx@gmail.com> wrote:

...

> > > Not sure this makes sense, given that the DMA hardware that was added to
> > > this UART block is only used by the UART block and no other pieces of HW
> > > in the system, nor will they ever be. Not sure it makes sense to pay the
> > > cost of an extra indirection and subsystem unless there are at least two
> > > consumers of that DMA hardware to warrant modeling it after a dmaengine
> > > driver. I also remember that Al researched before whether 8250_dma.c
> > > could work, and came to the conclusion that it would not, but I will let
> > > him comment on the specifics.
> >
> > I see. In any case I still believe that the driver can be shrinked by
> > a notable amount of lines.
>
> Patches always gladly accepted :)

Or a good review... :-)

-- 
With Best Regards,
Andy Shevchenko
