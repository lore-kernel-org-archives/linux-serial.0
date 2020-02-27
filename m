Return-Path: <SRS0=sDBB=4P=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25A0C3F2C6
	for <linux-serial@archiver.kernel.org>; Thu, 27 Feb 2020 23:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62D06246B9
	for <linux-serial@archiver.kernel.org>; Thu, 27 Feb 2020 23:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582844638;
	bh=ujUq05vTwgp4zfCZVaURWqd3tAcJ6/JW0KDXhNHLdnM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zXc+VhLVl5OGy0zD844izqS7L44tCM6h1q/tDHXFgyBYDtckEo32GAMAANczwZPzu
	 oFtaSi00AS7QOW9atrqoZ0xiTXe7/tidTkmQ8KkFYq4ALfZUio+VA3qAgIQFttSh58
	 EdX7nGKaanGAEYW/SmZvg03KOLloj6j/w+tqgwh4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbgB0XDz (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 27 Feb 2020 18:03:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:55674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729738AbgB0XDz (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 27 Feb 2020 18:03:55 -0500
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E5212469F;
        Thu, 27 Feb 2020 23:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582844634;
        bh=ujUq05vTwgp4zfCZVaURWqd3tAcJ6/JW0KDXhNHLdnM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oEH/uiuZrTAbwGQzcL4TRZqtyLXCPzURXZ7AHmOcxlmfYjQxq8rjuEdMVllcYhdBA
         r7vHN9Gx+mjeyXpcJvnCi/j/XpUPPTDYDDhBIhlPMPTNLSwWLfJpKrxBmJMnUuslRN
         E9StyYr4S9lGrNRtvAcH59YGWPIVrmUjaPMsrTaM=
Received: by mail-qk1-f176.google.com with SMTP id e16so1232157qkl.6;
        Thu, 27 Feb 2020 15:03:54 -0800 (PST)
X-Gm-Message-State: APjAAAXCRJrWYKKXHXKqmcqE0vZ6ANB+mUlRpcinZqSAvLp879oV+p5q
        ArJEtsOC1WWAEwr9m94WSnVeLbslAeHF2PKsaQ==
X-Google-Smtp-Source: APXvYqw/laX46RozAEZMxyINIQG8FYK9/JT0+//1/HbN8AUu5jHbA+IM4E9RvA5ctlGhNnas4Rvy8UDtCHXj2DZ9xA4=
X-Received: by 2002:a05:620a:12a3:: with SMTP id x3mr1989416qki.254.1582844633702;
 Thu, 27 Feb 2020 15:03:53 -0800 (PST)
MIME-Version: 1.0
References: <20200221174754.5295-1-michael@walle.cc> <20200221174754.5295-4-michael@walle.cc>
 <CAL_JsqL8QGKARtRAfjCMyk4Pp7EWhFMV8JQpveHoJ2OyH5kBPA@mail.gmail.com> <CADRPPNR1n1sviJnhq_zuUFJcMYqsVKy0O7NOF1pxF_4VH+dasg@mail.gmail.com>
In-Reply-To: <CADRPPNR1n1sviJnhq_zuUFJcMYqsVKy0O7NOF1pxF_4VH+dasg@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 27 Feb 2020 17:03:42 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKMNFFG5H4gPQwRdcTpfHynqZWo2A2db-oL7EmvTNqNkQ@mail.gmail.com>
Message-ID: <CAL_JsqKMNFFG5H4gPQwRdcTpfHynqZWo2A2db-oL7EmvTNqNkQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] tty: serial: fsl_lpuart: handle EPROBE_DEFER for DMA
To:     Li Yang <leoyang.li@nxp.com>
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

On Thu, Feb 27, 2020 at 4:49 PM Li Yang <leoyang.li@nxp.com> wrote:
>
> On Thu, Feb 27, 2020 at 4:35 PM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Fri, Feb 21, 2020 at 11:48 AM Michael Walle <michael@walle.cc> wrote:
> > >
> > > The DMA channel might not be available at the first probe time. This is
> > > esp. the case if the DMA controller has an IOMMU mapping.
> > >
> > > Use the new dma_request_chan() API and handle EPROBE_DEFER errors. Also
> > > reorder the code a bit, so that we don't prepare the whole UART just to
> > > determine that the DMA channel is not ready yet and we have to undo all
> > > the stuff. Try to map the DMA channels earlier.
> >
> > Changing this means you never probe successfully if you boot a kernel
> > with the DMA driver disabled (or it's IOMMU disabled). Some other
> > drivers request DMA in open() and can work either way.
>
> We got this exact issue previously with another driver.  When the
> required DMA driver is disabled, the DMA framework cannot figure out
> this situation and keeps returning EPROBE_DEFER.  I'm wondering if we
> should update the DMA framework to use your deferred probe timeout
> mechanism.  Is it still only used for debug purpose?

It's undergoing some rework ATM to not just be for debug. However,
it's not really going to help you if you care about the console
because waiting for the timeout will be too late to register the
console.

Rob
