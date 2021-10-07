Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF23FC433F5
	for <linux-serial@archiver.kernel.org>; Thu,  7 Oct 2021 14:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A20AA610EA
	for <linux-serial@archiver.kernel.org>; Thu,  7 Oct 2021 14:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241664AbhJGOX0 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 7 Oct 2021 10:23:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:40484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241042AbhJGOX0 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 7 Oct 2021 10:23:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA10F610CC;
        Thu,  7 Oct 2021 14:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633616492;
        bh=xTguGxb+pvfpaW8x929jVClMOsoXSvmHcgRLD9+ZJIk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FFLspULtvPRf6zffVeQl4pF5v3TsK9H33qbffAfhUHTtRE7+N3w5yENNsIMH7xUlz
         ANAEhsEb5S+yVA9TmCVyuOpcttIqjWm7cZCMcRjBJJh7tMCyn/HYWD5zyT68lIqRQ4
         38ypdOnelP0+T3knnMsp9mBKTlx683lZ+t9gA3zI=
Date:   Thu, 7 Oct 2021 16:21:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject: Re: [PATCH] Revert "serial: 8250: Fix reporting real baudrate value
 in c_ospeed field"
Message-ID: <YV8CavX93a8XCSJP@kroah.com>
References: <20211007133146.28949-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211007133146.28949-1-johan@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Oct 07, 2021 at 03:31:46PM +0200, Johan Hovold wrote:
> This reverts commit 32262e2e429cdb31f9e957e997d53458762931b7.
> 
> The commit in question claims to determine the inverse of
> serial8250_get_divisor() but failed to notice that some drivers override
> the default implementation using a get_divisor() callback.
> 
> This means that the computed line-speed values can be completely wrong
> and results in regular TCSETS requests failing (the incorrect values
> would also be passed to any overridden set_divisor() callback).
> 
> Similarly, it also failed to honour the old (deprecated) ASYNC_SPD_FLAGS
> and would break applications relying on those when re-encoding the
> actual line speed.
> 
> There are also at least two quirks, UART_BUG_QUOT and an OMAP1510
> workaround, which were happily ignored and that are now broken.
> 
> Finally, even if the offending commit were to be implemented correctly,
> this is a new feature and not something which should be backported to
> stable.
> 
> Cc: Pali Rohár <pali@kernel.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/tty/serial/8250/8250_port.c | 17 -----------------
>  1 file changed, 17 deletions(-)

Argh, sorry I missed this, good catch.  I'll go queue this up now,
thanks.

greg k-h
