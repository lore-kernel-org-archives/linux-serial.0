Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9BACDB470
	for <linux-serial@archiver.kernel.org>; Wed, 11 Oct 2023 17:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbjJKRmY (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 11 Oct 2023 13:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbjJKRmX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 11 Oct 2023 13:42:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401CD98;
        Wed, 11 Oct 2023 10:42:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 263AAC433C7;
        Wed, 11 Oct 2023 17:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697046141;
        bh=ilPzWHSKr/k4ojmat8OtcVIHiZnxQJcbxdttpM49+Rk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SIw9+stKgFmfc8PCbUMMCkxUWX4CuPb8tQoh78LWNM9jOXv96D6hkqL6L3ZHxOXur
         Z1sMz5QF8/qjcu+0di8CAVTbsDcyUY3s/BaVplQUfJ7ZBiUqlD8N5PBhHhfizzext7
         0AYsnBf8Xt4K+ZuRl64Kx14UbF/sQF3zDWLtjttw=
Date:   Wed, 11 Oct 2023 19:42:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lino Sanfilippo <l.sanfilippo@kunbus.com>
Cc:     jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        cniedermaier@dh-electronics.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, LinoSanfilippo@gmx.de,
        lukas@wunner.de, p.rosenberger@kunbus.com
Subject: Re: [PATCH v2 2/7] serial: amba-pl011: get rid of useless wrapper
 pl011_get_rs485_mode()
Message-ID: <2023101134-theater-oversleep-a58b@gregkh>
References: <20231011173829.10508-1-l.sanfilippo@kunbus.com>
 <20231011173829.10508-3-l.sanfilippo@kunbus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011173829.10508-3-l.sanfilippo@kunbus.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Oct 11, 2023 at 07:38:24PM +0200, Lino Sanfilippo wrote:
> Due to earlier code changes function pl011_get_rs485_mode() is now merely
> a wrapper for uart_get_rs485_mode() which does not add any further
> functionality. So remove it and instead call uart_get_rs485_mode()
> directly.
> 
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---
>  drivers/tty/serial/amba-pl011.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)

Why is patch 2/7 not cc: stable, when patches 3-7 are?  Either this
patch isn't needed in this series, and can go later (or to a different
branch), or it also needs to be marked for stable as the later patches
depend on it?

thanks,

greg k-h
