Return-Path: <SRS0=j4md=4Q=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BADC3F2D2
	for <linux-serial@archiver.kernel.org>; Fri, 28 Feb 2020 11:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9E33246AA
	for <linux-serial@archiver.kernel.org>; Fri, 28 Feb 2020 11:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="Kd02hTbE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725730AbgB1LqI (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 28 Feb 2020 06:46:08 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:39989 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgB1LqI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 28 Feb 2020 06:46:08 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 077EF23EC2;
        Fri, 28 Feb 2020 12:46:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1582890365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gSy0XB2/CLQYbsHikr4Odo8LY3KqR1/kjbGBzsGZ6ic=;
        b=Kd02hTbELCQ1B3UuerkL4Fc7b2vovsKQPdSO+4+x6U6aQrJ160U9Cwu+LP/T0ECtCy7M8Z
        efZDHvUU6S+hoLWqWkcaZxzDQu+dawGFfW0f7VuUOXoAYP8G6jIdloAu7B8slL0xdRyvXF
        8Eje0iN6yqyS0otRzEpRo7ob+v+7o3M=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 28 Feb 2020 12:46:01 +0100
From:   Michael Walle <michael@walle.cc>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Li Yang <leoyang.li@nxp.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-kernel@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Peng Fan <peng.fan@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: Re: [PATCH v2 3/9] tty: serial: fsl_lpuart: handle EPROBE_DEFER for
 DMA
In-Reply-To: <CAL_JsqKMNFFG5H4gPQwRdcTpfHynqZWo2A2db-oL7EmvTNqNkQ@mail.gmail.com>
References: <20200221174754.5295-1-michael@walle.cc>
 <20200221174754.5295-4-michael@walle.cc>
 <CAL_JsqL8QGKARtRAfjCMyk4Pp7EWhFMV8JQpveHoJ2OyH5kBPA@mail.gmail.com>
 <CADRPPNR1n1sviJnhq_zuUFJcMYqsVKy0O7NOF1pxF_4VH+dasg@mail.gmail.com>
 <CAL_JsqKMNFFG5H4gPQwRdcTpfHynqZWo2A2db-oL7EmvTNqNkQ@mail.gmail.com>
Message-ID: <639a1df72fbeda77436b282a99f17995@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: +
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 077EF23EC2
X-Spamd-Result: default: False [1.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[12];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Rob, Hi Leo,

Am 2020-02-28 00:03, schrieb Rob Herring:
> On Thu, Feb 27, 2020 at 4:49 PM Li Yang <leoyang.li@nxp.com> wrote:
>> 
>> On Thu, Feb 27, 2020 at 4:35 PM Rob Herring <robh+dt@kernel.org> 
>> wrote:
>> >
>> > On Fri, Feb 21, 2020 at 11:48 AM Michael Walle <michael@walle.cc> wrote:
>> > >
>> > > The DMA channel might not be available at the first probe time. This is
>> > > esp. the case if the DMA controller has an IOMMU mapping.
>> > >
>> > > Use the new dma_request_chan() API and handle EPROBE_DEFER errors. Also
>> > > reorder the code a bit, so that we don't prepare the whole UART just to
>> > > determine that the DMA channel is not ready yet and we have to undo all
>> > > the stuff. Try to map the DMA channels earlier.
>> >
>> > Changing this means you never probe successfully if you boot a kernel
>> > with the DMA driver disabled (or it's IOMMU disabled). Some other
>> > drivers request DMA in open() and can work either way.

Oh, I see.

>> We got this exact issue previously with another driver.  When the

What driver is it? I've been working on the i2c-mxs.c driver which has
the same problem. Ie. its not working with DMA when the IOMMU is 
enabled.
Now that I've learned that dma_request_chan() will return EPROBE_DEFER
if the actual DMA driver is not available, I don't think there is any
trick like this there. There is no function which would be called late
except you'd do something like on the first master_xfer() try to request
the DMA channels. But I don't think that would be the way to go.

-michael

>> required DMA driver is disabled, the DMA framework cannot figure out
>> this situation and keeps returning EPROBE_DEFER.  I'm wondering if we
>> should update the DMA framework to use your deferred probe timeout
>> mechanism.  Is it still only used for debug purpose?
> 
> It's undergoing some rework ATM to not just be for debug. However,
> it's not really going to help you if you care about the console
> because waiting for the timeout will be too late to register the
> console.

