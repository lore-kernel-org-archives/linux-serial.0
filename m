Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7C8C433DB
	for <linux-serial@archiver.kernel.org>; Fri,  5 Mar 2021 12:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9304F64FEB
	for <linux-serial@archiver.kernel.org>; Fri,  5 Mar 2021 12:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbhCEMGQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 5 Mar 2021 07:06:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:54820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229493AbhCEMGQ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 5 Mar 2021 07:06:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 05F9564E60;
        Fri,  5 Mar 2021 12:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614945975;
        bh=seIgEFW9DLtQzQlaeFxbhm+QRr5e0pQ/jgFuY8NjaGI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=perRWwrnJeslMC1hKprDhNXjUI7bveE5t87LFC3/uVP4/0R1nBqJivBtjShEhub1e
         DtkoeyhmamPYWa2lGkzVn1WLBVe+RHIWNuLFhi7quOGr8AAITTBfsM4CKWiYic0jd6
         8Ew7aWuj6leNJP78kmnyRSmezX4xJjtpC1Qjbmss=
Date:   Fri, 5 Mar 2021 13:06:12 +0100
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
Message-ID: <YEIetFdcuYZU98s/@kroah.com>
References: <20210305115058.92284-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305115058.92284-1-sebastian.reichel@collabora.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Mar 05, 2021 at 12:50:58PM +0100, Sebastian Reichel wrote:
> From: Fabien Lahoudere <fabien.lahoudere@collabora.com>
> 
> In order to optimize serial communication (performance/throughput VS
> latency), we may need to tweak DMA period number and size. This adds
> sysfs attributes to configure those values before initialising DMA.
> The defaults will stay the same as before (16 buffers with a size of
> 1024 bytes). Afterwards the values can be read/write with the
> following sysfs files:
> 
> /sys/class/tty/ttymxc*/dma_buffer_size
> /sys/class/tty/ttymxc*/dma_buffer_count

Ick no.  Custom sysfs attributes for things like serial ports are crazy.

> This is mainly needed for GEHC CS ONE (arch/arm/boot/dts/imx53-ppd.dts),
> which has multiple microcontrollers connected via UART controlling. One
> of the UARTs is connected to an on-board microcontroller at 19200 baud,
> which constantly pushes critical data (so aging character detect
> interrupt will never trigger). This data must be processed at 50-200 Hz,
> so UART should return data in less than 5-20ms. With 1024 byte DMA
> buffer (and a constant data stream) the read operation instead needs
> 1024 byte / 19200 baud = 53.333ms, which is way too long (note: Worst
> Case would be remote processor sending data with short pauses <= 7
> characters, which would further increase this number). The current
> downstream kernel instead configures 24 bytes resulting in 1.25ms,
> but that is obviously not sensible for normal UART use cases and cannot
> be used as new default.

Why can't this be a device tree attribute?  Why does this have to be a
sysfs thing that no one will know how to tune and set over time.  This
hardware should not force a user to manually tune it to get it to work
properly, this isn't the 1990's anymore :(

Please never force a user to choose stuff like this, they never will
know what to do.

thanks,

greg k-h
