Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A025C28CF5
	for <linux-serial@archiver.kernel.org>; Wed, 26 Jan 2022 14:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242074AbiAZOVd (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 26 Jan 2022 09:21:33 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43800 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242054AbiAZOVd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 26 Jan 2022 09:21:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 097C46177B
        for <linux-serial@vger.kernel.org>; Wed, 26 Jan 2022 14:21:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E827FC340E3;
        Wed, 26 Jan 2022 14:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643206892;
        bh=BEKs0amCBZ8FKWSZzZbMslZLMGWAQzMDUuKdFRaGXjU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kB1tEL6/FrDUcPJvr4ouR5Nak3i96uQAswg1y6e8PVVanCh5GRd28oALYefQzMdQD
         DjgPgWnTRt8TRuvAWkf1ui54NSwj4mGkL8x0pYHWIiY5JCa3NtNHIsLyEbyzxDfxEA
         GxIXGz2SfTDT3esExxzSpD/ctMS+Zg5tcmSd02iI=
Date:   Wed, 26 Jan 2022 15:21:29 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Phil Elwell <phil@raspberrypi.com>
Cc:     Wander Lairson Costa <wander@redhat.com>,
        Johan Hovold <johan@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Lukas Wunner <lukas@wunner.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-serial@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH] serial: 8250: Fix ...console_fifo_write on BCM283x
Message-ID: <YfFY6Rnor85CE9yH@kroah.com>
References: <20220126141124.4086065-1-phil@raspberrypi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126141124.4086065-1-phil@raspberrypi.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jan 26, 2022 at 02:11:24PM +0000, Phil Elwell wrote:
> The mini-UART on BCM283x is doubly crippled - it has 8-byte FIFOs and
> the THRE bit indicates that the TX FIFO is not-full rather than empty.
> 
> The optimisation to enable the use of the FIFO assumes that it is safe
> to write fifosize bytes whenever THRE is set, but the BCM283x quirk
> (indicated by the presence of UART_CAP_MINI) makes it necessary to
> check the FIFO state after each byte.
> 
> See: https://github.com/raspberrypi/linux/issues/4849
> 
> Fixes: 5021d709b31b ("tty: serial: Use fifo in 8250 console driver")

I have just reverted this commit, it's broken for many platforms now,
not just yours.

So there shouldn't be a need for this change now, right?

thanks,

greg k-h
