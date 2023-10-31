Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91E7C4332F
	for <linux-serial@archiver.kernel.org>; Tue, 31 Oct 2023 06:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235687AbjJaGMV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 31 Oct 2023 02:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235409AbjJaGMU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 31 Oct 2023 02:12:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB4B122;
        Mon, 30 Oct 2023 23:12:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A26C433CD;
        Tue, 31 Oct 2023 06:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698732363;
        bh=DwYhFxPr9b/VXj2JiyRqdz0UfnNGH08F8Q/fCx7bSzA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0I7ufmMSFzzwe8BTghiUBtMi0oxHk7khrkX1XXz5xjK83B5o1iWejwXbPxe5an2Xq
         dBe/fPGm6/vYIEdygI1j0D4kl0X2c09dZhoj9LSxSBXzoqlvpnfEOPmN+03C4/qPmY
         KgZzPFYQa+ugsEGBrk6PsLBD28OGOzpweTVHgTg0=
Date:   Tue, 31 Oct 2023 07:06:00 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ronald Wahl <rwahl@gmx.de>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Ronald Wahl <ronald.wahl@raritan.com>
Subject: Re: [PATCH] serial: 8250: 8250_omap: Do not start RX DMA on THRI
 interrupt
Message-ID: <2023103150-esteemed-deputize-66a0@gregkh>
References: <20231030183951.15331-1-rwahl@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030183951.15331-1-rwahl@gmx.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Oct 30, 2023 at 07:39:51PM +0100, Ronald Wahl wrote:
> Starting RX DMA on THRI interrupt is too early because TX may not have
> finished yet.
> 
> This change is inspired by commit 90b8596ac460 ("serial: 8250: Prevent
> starting up DMA Rx on THRI interrupt") and fixes DMA issues I had with
> an AM62 SoC that is using the 8250 OMAP variant.
> 
> Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>
> ---
>  drivers/tty/serial/8250/8250_omap.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

What commit id does this fix?

thanks,

greg k-h
