Return-Path: <SRS0=sDBB=4P=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EC9C3F2C2
	for <linux-serial@archiver.kernel.org>; Thu, 27 Feb 2020 22:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2538246AA
	for <linux-serial@archiver.kernel.org>; Thu, 27 Feb 2020 22:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbgB0WtH (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 27 Feb 2020 17:49:07 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39296 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbgB0WtH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 27 Feb 2020 17:49:07 -0500
Received: by mail-oi1-f196.google.com with SMTP id r16so953578oie.6;
        Thu, 27 Feb 2020 14:49:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qrt5LAslHCMpZZk+1bFnZB1hkmKt9afE9QUzznOIIn4=;
        b=kkk5YPWWktEuu8H0UZD1PlKmpLPT1sBXpdkYPvE68ooL/mYn6bRUmkPCVuIcetMOjX
         qKgiUVbx8acQMRBrgABTPGK/rm9oiU9pgEVhny0ozfbcDIEPF6PSiTw/gnaMDifNMSxg
         QPqgiLPel/dMlCxGdecXStBIxkUUbLceXJLcwZfxTJQGCkwDurJ9YR4AVnwCBpALYHEV
         CJJoueBjkekD+dyOmEwnNXFLCg7EM/0FS7hZFFEc2SKMjIp9XaMkaoExY/B/Z3yZcbp2
         KLdE4oABAWA6K4ePyyoR6QU5swhUl4vXrmUfjKkd+BA9PuZtva9tZ686W4dWBPT7gPTP
         wc+A==
X-Gm-Message-State: APjAAAWyRaABHf3OYY8cuKaVwtKGu1wjpjQMnkXz8VhZ3IUwoNIb/Acp
        nT5JxjUOX+t7uyP9PwF+Q5FdWDeo
X-Google-Smtp-Source: APXvYqytrr7sXI8/ORwW3w1WJBltPaUj5Vk6Zc295697nPlBcBzHRpbBPGsqcCZ1z/giQlhX+C40zQ==
X-Received: by 2002:aca:d0a:: with SMTP id 10mr1009456oin.50.1582843745837;
        Thu, 27 Feb 2020 14:49:05 -0800 (PST)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com. [209.85.210.42])
        by smtp.gmail.com with ESMTPSA id g8sm2431795otq.19.2020.02.27.14.49.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2020 14:49:05 -0800 (PST)
Received: by mail-ot1-f42.google.com with SMTP id r16so844674otd.2;
        Thu, 27 Feb 2020 14:49:05 -0800 (PST)
X-Received: by 2002:a05:6830:1184:: with SMTP id u4mr892613otq.221.1582843745073;
 Thu, 27 Feb 2020 14:49:05 -0800 (PST)
MIME-Version: 1.0
References: <20200221174754.5295-1-michael@walle.cc> <20200221174754.5295-4-michael@walle.cc>
 <CAL_JsqL8QGKARtRAfjCMyk4Pp7EWhFMV8JQpveHoJ2OyH5kBPA@mail.gmail.com>
In-Reply-To: <CAL_JsqL8QGKARtRAfjCMyk4Pp7EWhFMV8JQpveHoJ2OyH5kBPA@mail.gmail.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Thu, 27 Feb 2020 16:48:54 -0600
X-Gmail-Original-Message-ID: <CADRPPNR1n1sviJnhq_zuUFJcMYqsVKy0O7NOF1pxF_4VH+dasg@mail.gmail.com>
Message-ID: <CADRPPNR1n1sviJnhq_zuUFJcMYqsVKy0O7NOF1pxF_4VH+dasg@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] tty: serial: fsl_lpuart: handle EPROBE_DEFER for DMA
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Michael Walle <michael@walle.cc>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Peng Fan <peng.fan@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Feb 27, 2020 at 4:35 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Fri, Feb 21, 2020 at 11:48 AM Michael Walle <michael@walle.cc> wrote:
> >
> > The DMA channel might not be available at the first probe time. This is
> > esp. the case if the DMA controller has an IOMMU mapping.
> >
> > Use the new dma_request_chan() API and handle EPROBE_DEFER errors. Also
> > reorder the code a bit, so that we don't prepare the whole UART just to
> > determine that the DMA channel is not ready yet and we have to undo all
> > the stuff. Try to map the DMA channels earlier.
>
> Changing this means you never probe successfully if you boot a kernel
> with the DMA driver disabled (or it's IOMMU disabled). Some other
> drivers request DMA in open() and can work either way.

We got this exact issue previously with another driver.  When the
required DMA driver is disabled, the DMA framework cannot figure out
this situation and keeps returning EPROBE_DEFER.  I'm wondering if we
should update the DMA framework to use your deferred probe timeout
mechanism.  Is it still only used for debug purpose?

Regards,
Leo
