Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34D9C433F5
	for <linux-serial@archiver.kernel.org>; Wed, 16 Feb 2022 15:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbiBPPVS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 16 Feb 2022 10:21:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbiBPPVP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 16 Feb 2022 10:21:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4942A64E4
        for <linux-serial@vger.kernel.org>; Wed, 16 Feb 2022 07:21:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1463618FB
        for <linux-serial@vger.kernel.org>; Wed, 16 Feb 2022 15:21:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D79FC340EC;
        Wed, 16 Feb 2022 15:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645024862;
        bh=jsRl2Wt2izDVX+qzwpDMaROscx0+tEEkgOhTmmZkgRc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ShHGAEsf8G3BkXi5+4VZG0uiiaOzeZ1d1SGzQ8HFBSCOn5dEpWlHHWDhg2Vswvwww
         mPpvJTKX1XA9jgaZ4Wq1ZXxCeRwYQsbUPPl10GYZL40r6XRp+H6ugUQZt5Jow5LQey
         vUMFkcI5GyYsIgTVIxzU2Ff1AZUPV2DcxC/+2wvg=
Date:   Wed, 16 Feb 2022 16:20:58 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Phil Elwell <phil@raspberrypi.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: Re: [PATCH] sc16is7xx: Fix for incorrect data being transmitted
Message-ID: <Yg0WWr04G2yPo8TG@kroah.com>
References: <20220216150858.1016784-1-phil@raspberrypi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216150858.1016784-1-phil@raspberrypi.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Feb 16, 2022 at 03:08:58PM +0000, Phil Elwell wrote:
> UART drivers are meant to use the port spinlock within certain
> methods, to protect against reentrancy. The sc16is7xx driver does
> very little locking, presumably because when added it triggers
> "scheduling while atomic" errors. This is due to the use of mutexes
> within the regmap abstraction layer, and the mutex implementation's
> habit of sleeping the current thread while waiting for access.
> Unfortunately this lack of interlocking can lead to corruption of
> outbound data, which occurs when the buffer used for I2C transmission
> is used simultaneously by two threads - a work queue thread running
> sc16is7xx_tx_proc, and an IRQ thread in sc16is7xx_port_irq, both
> of which can call sc16is7xx_handle_tx.
> 
> An earlier patch added efr_lock, a mutex that controls access to the
> EFR register. This mutex is already claimed in the IRQ handler, and
> all that is required is to claim the same mutex in sc16is7xx_tx_proc.
> 
> See: https://github.com/raspberrypi/linux/issues/4885
> 
> Signed-off-by: Phil Elwell <phil@raspberrypi.com>
> ---
>  drivers/tty/serial/sc16is7xx.c | 3 +++
>  1 file changed, 3 insertions(+)

What commit id does this fix?

thanks,

greg k-h
