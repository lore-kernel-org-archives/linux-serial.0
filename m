Return-Path: <SRS0=j4md=4Q=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D7BC3F2CD
	for <linux-serial@archiver.kernel.org>; Fri, 28 Feb 2020 21:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08F0A2469F
	for <linux-serial@archiver.kernel.org>; Fri, 28 Feb 2020 21:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgB1VyB (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 28 Feb 2020 16:54:01 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39130 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgB1VyB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 28 Feb 2020 16:54:01 -0500
Received: by mail-ot1-f67.google.com with SMTP id x97so4013725ota.6;
        Fri, 28 Feb 2020 13:54:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pDVNEc+emqEYhHMEI0BkQh8VuJ0zUAhAe+A2963SxX0=;
        b=BhqHVZ2BqQuaGPgq01e0uENA0LzH4IW4LbLEg18hF44ZhNSsjptFlWRf7mdSTrv2B5
         nyhE4QjOIO0Zi3bv7qvmF1y2mXU94UT2CkNn34mDw92FK1xO2hMc0OZYcrY/AvbuHF3O
         ytYJh3L3r4Zi+tADmEkHsCAJLiJ3+t3FHLMACuv45BEgMNUqPJ84ELsgwcprDfbgw+BF
         ZAjZFig4VPTAMbZf6PIp9O5gEYbnLHxo1iaxVJg7SbLxcGegBHLwE6PtwtxzMnRe9Goj
         0edfYjMIOe9+FRJVdnER342QK7GU0SbCekf1vxlYsLn6GvpJuJe35hz9jr4pGS+/2iNl
         gKdw==
X-Gm-Message-State: APjAAAXsFRSHRklY3pV+F9u7njfYAh/ObPNHX+JG6RZffDRJ4yRx9BTn
        N9cTgAT49QolC9W0Wbe82iUYtiYXITA=
X-Google-Smtp-Source: APXvYqwcD8KegygDg2uXmfGc0b5s3g2iOWW8QB+yGdhZqZT2cbFUJgwyKh2XZap9Gmfhgkl0wuZRrg==
X-Received: by 2002:a9d:7593:: with SMTP id s19mr4713096otk.219.1582926840159;
        Fri, 28 Feb 2020 13:54:00 -0800 (PST)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com. [209.85.210.51])
        by smtp.gmail.com with ESMTPSA id 17sm2358741oth.7.2020.02.28.13.53.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2020 13:53:59 -0800 (PST)
Received: by mail-ot1-f51.google.com with SMTP id x97so4013634ota.6;
        Fri, 28 Feb 2020 13:53:59 -0800 (PST)
X-Received: by 2002:a05:6830:1c8:: with SMTP id r8mr5033412ota.63.1582926839216;
 Fri, 28 Feb 2020 13:53:59 -0800 (PST)
MIME-Version: 1.0
References: <20200221174754.5295-1-michael@walle.cc> <20200221174754.5295-4-michael@walle.cc>
 <CAL_JsqL8QGKARtRAfjCMyk4Pp7EWhFMV8JQpveHoJ2OyH5kBPA@mail.gmail.com>
 <CADRPPNR1n1sviJnhq_zuUFJcMYqsVKy0O7NOF1pxF_4VH+dasg@mail.gmail.com>
 <CAL_JsqKMNFFG5H4gPQwRdcTpfHynqZWo2A2db-oL7EmvTNqNkQ@mail.gmail.com>
 <639a1df72fbeda77436b282a99f17995@walle.cc> <24b9a657a65f75a4f4f10baa17561451@walle.cc>
In-Reply-To: <24b9a657a65f75a4f4f10baa17561451@walle.cc>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Fri, 28 Feb 2020 15:53:47 -0600
X-Gmail-Original-Message-ID: <CADRPPNQong1bD83ncHTj1OHip9LEV9PFOnPN3Jo00aZT056eiw@mail.gmail.com>
Message-ID: <CADRPPNQong1bD83ncHTj1OHip9LEV9PFOnPN3Jo00aZT056eiw@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] tty: serial: fsl_lpuart: handle EPROBE_DEFER for DMA
To:     Michael Walle <michael@walle.cc>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
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

On Fri, Feb 28, 2020 at 3:51 PM Michael Walle <michael@walle.cc> wrote:
>
> Am 2020-02-28 12:46, schrieb Michael Walle:
> > Hi Rob, Hi Leo,
> >
> > Am 2020-02-28 00:03, schrieb Rob Herring:
> >> On Thu, Feb 27, 2020 at 4:49 PM Li Yang <leoyang.li@nxp.com> wrote:
> >>>
> >>> On Thu, Feb 27, 2020 at 4:35 PM Rob Herring <robh+dt@kernel.org>
> >>> wrote:
> >>> >
> >>> > On Fri, Feb 21, 2020 at 11:48 AM Michael Walle <michael@walle.cc> wrote:
> >>> > >
> >>> > > The DMA channel might not be available at the first probe time. This is
> >>> > > esp. the case if the DMA controller has an IOMMU mapping.
> >>> > >
> >>> > > Use the new dma_request_chan() API and handle EPROBE_DEFER errors. Also
> >>> > > reorder the code a bit, so that we don't prepare the whole UART just to
> >>> > > determine that the DMA channel is not ready yet and we have to undo all
> >>> > > the stuff. Try to map the DMA channels earlier.
> >>> >
> >>> > Changing this means you never probe successfully if you boot a kernel
> >>> > with the DMA driver disabled (or it's IOMMU disabled). Some other
> >>> > drivers request DMA in open() and can work either way.
> >
> > Oh, I see.
> >
> >>> We got this exact issue previously with another driver.  When the
> >
> > What driver is it? I've been working on the i2c-mxs.c driver which has
>
> whoops, i2c-imx.c, not i2c-mxs.c

Ya.  Same one.  I have added CONFIG_FSL_EDMA into the arm64/defconfig
as a workaround.

Regards,
Leo
