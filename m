Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2D6C433B4
	for <linux-serial@archiver.kernel.org>; Tue,  6 Apr 2021 07:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 691066124B
	for <linux-serial@archiver.kernel.org>; Tue,  6 Apr 2021 07:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239524AbhDFHNS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 6 Apr 2021 03:13:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:49078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238014AbhDFHNQ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 6 Apr 2021 03:13:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A9C20601FF;
        Tue,  6 Apr 2021 07:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617693188;
        bh=+ROOemzsL6HXsZmP2A3hvzMlxx6Hg/qSe+z95RovJrE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dGIH4E+/yxdmOTsrr3g4opHziIW4u1+TkjbuGcE4E+xz7Pmoqa0E9G46vlIAIiY6Y
         upsWtt12hPD4zpPsXJoJBoCGf9Pra6q0AFXksKI767Fzno5NiebBBL8agKY+SkufQU
         KgWPDjZpBIcwvEQbUl2xSUdRnprmS5pyAdn+kRuQ=
Date:   Tue, 6 Apr 2021 09:13:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, Ian Ray <ian.ray@ge.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCHv4] serial: imx: Add DMA buffer configuration via sysfs
Message-ID: <YGwKAOmlHRgEVh20@kroah.com>
References: <20210305115058.92284-1-sebastian.reichel@collabora.com>
 <YEIetFdcuYZU98s/@kroah.com>
 <20210305124252.c3ffgca6wjqpkn45@earth.universe>
 <20210405214446.zhidvtvahcfp4wxa@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210405214446.zhidvtvahcfp4wxa@earth.universe>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Apr 05, 2021 at 11:44:46PM +0200, Sebastian Reichel wrote:
> Hi,
> 
> On Fri, Mar 05, 2021 at 01:42:52PM +0100, Sebastian Reichel wrote:
> > On Fri, Mar 05, 2021 at 01:06:12PM +0100, Greg Kroah-Hartman wrote:
> > > On Fri, Mar 05, 2021 at 12:50:58PM +0100, Sebastian Reichel wrote:
> > > > From: Fabien Lahoudere <fabien.lahoudere@collabora.com>
> > > > 
> > > > In order to optimize serial communication (performance/throughput VS
> > > > latency), we may need to tweak DMA period number and size. This adds
> > > > sysfs attributes to configure those values before initialising DMA.
> > > > The defaults will stay the same as before (16 buffers with a size of
> > > > 1024 bytes). Afterwards the values can be read/write with the
> > > > following sysfs files:
> > > > 
> > > > /sys/class/tty/ttymxc*/dma_buffer_size
> > > > /sys/class/tty/ttymxc*/dma_buffer_count
> > > 
> > > Ick no.  Custom sysfs attributes for things like serial ports are crazy.
> > > 
> > > > This is mainly needed for GEHC CS ONE (arch/arm/boot/dts/imx53-ppd.dts),
> > > > which has multiple microcontrollers connected via UART controlling. One
> > > > of the UARTs is connected to an on-board microcontroller at 19200 baud,
> > > > which constantly pushes critical data (so aging character detect
> > > > interrupt will never trigger). This data must be processed at 50-200 Hz,
> > > > so UART should return data in less than 5-20ms. With 1024 byte DMA
> > > > buffer (and a constant data stream) the read operation instead needs
> > > > 1024 byte / 19200 baud = 53.333ms, which is way too long (note: Worst
> > > > Case would be remote processor sending data with short pauses <= 7
> > > > characters, which would further increase this number). The current
> > > > downstream kernel instead configures 24 bytes resulting in 1.25ms,
> > > > but that is obviously not sensible for normal UART use cases and cannot
> > > > be used as new default.
> > > 
> > > Why can't this be a device tree attribute? Why does this have to be a
> > > sysfs thing that no one will know how to tune and set over time.  This
> > > hardware should not force a user to manually tune it to get it to work
> > > properly, this isn't the 1990's anymore :(
> > > 
> > > Please never force a user to choose stuff like this, they never will
> > > know what to do.
> > 
> > This used to be a DT attribute in PATCHv1. It has been moved over to
> > sysfs since PATCHv2, since it does not describe the hardware, but
> > configuration. Unfortunately lore.kernel.org does not have the full
> > thread, but this is the discussion:
> > 
> > https://lore.kernel.org/linux-serial/20170629182618.jpahpmuq364ldcv2@pengutronix.de/
> > 
> > From downstream POV this can be done either by adding a DT property
> > to the UART node, or by adding a udev rule.
> > 
> > From my POV there is not a huge difference. In both cases we will
> > be bound by an ABI afterwards, in both cases people will usually
> > stick to the default value and in both cases people that do deviate
> > from the default probably ran into problems and started to look
> > for a solution.
> 
> ping? It's not very nice to get a rejected in cycles :(

I recommend working with the DT people here, as custom sysfs attributes
for things like this that are really just describing the hardware is
crazy.

thanks,

greg k-h
