Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEAAC433E6
	for <linux-serial@archiver.kernel.org>; Wed, 20 Jan 2021 16:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65474233F7
	for <linux-serial@archiver.kernel.org>; Wed, 20 Jan 2021 16:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391611AbhATQsC (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 20 Jan 2021 11:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391641AbhATQrs (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 20 Jan 2021 11:47:48 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D497C0613C1;
        Wed, 20 Jan 2021 08:47:04 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id m6so14857964pfk.1;
        Wed, 20 Jan 2021 08:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rI55C5R2Ib+0Rd7/giiUezyr291JCSLEI1Z384+KvVY=;
        b=s1zHKUfXoRjGrKTJJxaYl7s7Ha8O7YCs7O1775EhIt7rVEMQ78+MGJysUShJ8Qo+31
         uFfp8GS6DUZt2xQcl7//37wP3jc2S2aUNachb9KtLvr7GgLTq/UNr9fJGqomPIUS/URP
         EsGWzAnWDz9a7K3T1z+9+oGHCs8r6ZmoWnDXYfCuU/b8yIrX2YI/osDfpM1Aed5CDBwt
         yIpQPmWnRoK//R9/1bG+PR/EhMmrpH29k29Mp1wj5mn0Iw4xd2p/NpJBG5snV0ZRsvmc
         X/YyeCPdm9K7BBUWuMTeBf/x9SWyHOZV2LvVX8SthGkkMmJERPKWHa69v8yxL+j6cskv
         5+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rI55C5R2Ib+0Rd7/giiUezyr291JCSLEI1Z384+KvVY=;
        b=OOCmXKRsFQPjauS7I89IN/ApLiNXgen2ojAmYqTtbLfmiGzW8o69J04QKHhcdTpz8m
         ke/t2Lv6PgfjGT1C21b/iTpUTtLwwoDmKafsO7hSBjc/YemfbNWPecaRFrwqTOjqfOXP
         0cj7Jiu6iRIzcoNLzyqDWewL/YvAYHFCJq5bRbFCdcGmeze/0qnbzDsRJGVgcOzLOJhx
         3+tIWYTruE2eF8NzkMmoFV/j6qpIorzekEqWXQ9yeJndlax+VmzyDipTqo7195YsIOUU
         SBY9cPzhux0Eo3UfxX5eEhI11qZcx4HNWqutYUl/aj30awoo/7Z0eg5Mz7EUsovcROn9
         HtGg==
X-Gm-Message-State: AOAM530XT0veDwLw3uW79gQXm/ErqsC75HZdj92BbeO2JuzwsBefLN2X
        VEtZ3o7NP6CuS0lGBQTutUrqjPx759KuMP8bQKw=
X-Google-Smtp-Source: ABdhPJyrMn3IRyo0TyefSx6BpNfLQtd9Ybt6FKSJMpt+UY+Cd3SudbChqJoPM1x0xgoyhDn+KIm2H6Ni6STKEp89b1c=
X-Received: by 2002:a62:445:0:b029:19c:162b:bbef with SMTP id
 66-20020a6204450000b029019c162bbbefmr9882734pfe.40.1611161223528; Wed, 20 Jan
 2021 08:47:03 -0800 (PST)
MIME-Version: 1.0
References: <20210115211543.33563-1-alcooperx@gmail.com> <20210115211543.33563-3-alcooperx@gmail.com>
 <CAHp75VdQPQK8jTF3QDKx6mF1QzOg-qiuHrTiojnWn7GskokfoA@mail.gmail.com> <71d58a3e-2707-69d7-8074-c67235912e06@gmail.com>
In-Reply-To: <71d58a3e-2707-69d7-8074-c67235912e06@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 20 Jan 2021 18:47:52 +0200
Message-ID: <CAHp75VfNumFBwbytCuA_YK1w-+kN20vRF+GhogtU+DDG3EB_7g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] serial: 8250: Add new 8250-core based Broadcom STB driver
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Al Cooper <alcooperx@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        devicetree <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jan 19, 2021 at 8:16 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 1/19/2021 7:21 AM, Andy Shevchenko wrote:
> > On Fri, Jan 15, 2021 at 11:19 PM Al Cooper <alcooperx@gmail.com> wrote:
> >>
> >> Add a UART driver for the new Broadcom 8250 based STB UART. The new
> >> UART is backward compatible with the standard 8250, but has some
> >> additional features. The new features include a high accuracy baud
> >> rate clock system and DMA support.
> >>
> >> The driver will use the new optional BAUD MUX clock to select the best
> >> one of the four master clocks (81MHz, 108MHz, 64MHz and 48MHz) to feed
> >> the baud rate selection logic for any requested baud rate.  This allows
> >> for more accurate BAUD rates when high speed baud rates are selected.
> >>
> >> The driver will use the new UART DMA hardware if the UART DMA registers
> >> are specified in Device Tree "reg" property. The DMA functionality can
> >> be disabled on kernel boot with the argument:
> >> "8250_bcm7271.disable_dma=Y".
> >>
> >> The driver also set the UPSTAT_AUTOCTS flag when hardware flow control
> >> is enabled. This flag is needed for UARTs that don't assert a CTS
> >> changed interrupt when CTS changes and AFE (Hardware Flow Control) is
> >> enabled.
> >>
> >> The driver also contains a workaround for a bug in the Synopsis 8250
> >> core. The problem is that at high baud rates, the RX partial FIFO
> >> timeout interrupt can occur but there is no RX data (DR not set in
> >> the LSR register). In this case the driver will not read the Receive
> >> Buffer Register, which clears the interrupt, and the system will get
> >> continuous UART interrupts until the next RX character arrives. The
> >> fix originally suggested by Synopsis was to read the Receive Buffer
> >> Register and discard the character when the DR bit in the LSR was
> >> not set, to clear the interrupt. The problem was that occasionally
> >> a character would arrive just after the DR bit check and a valid
> >> character would be discarded. The fix that was added will clear
> >> receive interrupts to stop the interrupt, deassert RTS to insure
> >> that no new data can arrive, wait for 1.5 character times for the
> >> sender to react to RTS and then check for data and either do a dummy
> >> read or a valid read. Sysfs error counters were also added and were
> >> used to help create test software that would cause the error condition.
> >> The counters can be found at:
> >> /sys/devices/platform/rdb/*serial/rx_bad_timeout_late_char
> >> /sys/devices/platform/rdb/*serial/rx_bad_timeout_no_char
> >
> > Brief looking into the code raises several questions:
> >  - is it driver from the last decade?
>
> Work on this driver started back in 2018, that was indeed the last decade.
>
> >  - why it's not using what kernel provides?
> >  - we have a lot of nice helpers:
> >    - DMA Engine API
>
> Not sure this makes sense, given that the DMA hardware that was added to
> this UART block is only used by the UART block and no other pieces of HW
> in the system, nor will they ever be. Not sure it makes sense to pay the
> cost of an extra indirection and subsystem unless there are at least two
> consumers of that DMA hardware to warrant modeling it after a dmaengine
> driver. I also remember that Al researched before whether 8250_dma.c
> could work, and came to the conclusion that it would not, but I will let
> him comment on the specifics.

I see. In any case I still believe that the driver can be shrinked by
a notable amount of lines.

> >    - BIT() and GENMASK() macros
> >    - tons of different helpers like regmap API (if you wish to dump
> > registers via debugfs)
> >
> > Can you shrink this driver by 20-30% (I truly believe it's possible)
> > and split DMA driver to drivers/dma (which may already have something
> > similar there)?
>
> See previous response.


-- 
With Best Regards,
Andy Shevchenko
