Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B1BC433FE
	for <linux-serial@archiver.kernel.org>; Thu,  7 Oct 2021 14:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3515961130
	for <linux-serial@archiver.kernel.org>; Thu,  7 Oct 2021 14:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242129AbhJGOm3 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 7 Oct 2021 10:42:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:48482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242126AbhJGOm0 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 7 Oct 2021 10:42:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A0A0961130;
        Thu,  7 Oct 2021 14:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633617632;
        bh=xnGFwBZeQ8OHbEv6X3Q2k8hAF489Nb/IpKH7cHZG2rM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pJKm+NZqIIQxzlyMSE6cW00cFTEkix6tRD3/1FuZMvIsNcbp4pif0LtaGoz2JBg5t
         tawlK/ERnOXXmcbqASTCm41wQijxBZruXRTLezeOZyMRVhkL++9vfyuzzadTiFJdsL
         mG/1v0H/4QDy1m6C6I/5wf/cSeVaUB/EDRs+uH3XQV+E8mrBLsG160uFSicGq3GTMF
         zjpYI9/0x7C1tTcfefiCORJRUNIF0/XdZidSefw176c+g2I1Q0nIddVV/C6OZDmQ2Q
         rpeY5QM0UAJBRF0/ZHlOQY/LK6eHFJuNiGTVlZ4JdEZgbFt6KoUm7lVbOGiqOZYnQH
         Ei2nEzQy5hqCA==
Received: by pali.im (Postfix)
        id 4DD7781A; Thu,  7 Oct 2021 16:40:30 +0200 (CEST)
Date:   Thu, 7 Oct 2021 16:40:30 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "serial: 8250: Fix reporting real baudrate value
 in c_ospeed field"
Message-ID: <20211007144030.naxrzbjkrq7nmhjo@pali>
References: <20211007133146.28949-1-johan@kernel.org>
 <YV8CavX93a8XCSJP@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YV8CavX93a8XCSJP@kroah.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thursday 07 October 2021 16:21:30 Greg Kroah-Hartman wrote:
> On Thu, Oct 07, 2021 at 03:31:46PM +0200, Johan Hovold wrote:
> > This reverts commit 32262e2e429cdb31f9e957e997d53458762931b7.
> > 
> > The commit in question claims to determine the inverse of
> > serial8250_get_divisor() but failed to notice that some drivers override
> > the default implementation using a get_divisor() callback.
> > 
> > This means that the computed line-speed values can be completely wrong
> > and results in regular TCSETS requests failing (the incorrect values
> > would also be passed to any overridden set_divisor() callback).
> > 
> > Similarly, it also failed to honour the old (deprecated) ASYNC_SPD_FLAGS
> > and would break applications relying on those when re-encoding the
> > actual line speed.
> > 
> > There are also at least two quirks, UART_BUG_QUOT and an OMAP1510
> > workaround, which were happily ignored and that are now broken.
> > 
> > Finally, even if the offending commit were to be implemented correctly,
> > this is a new feature and not something which should be backported to
> > stable.
> > 
> > Cc: Pali Rohár <pali@kernel.org>
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > ---
> >  drivers/tty/serial/8250/8250_port.c | 17 -----------------
> >  1 file changed, 17 deletions(-)
> 
> Argh, sorry I missed this, good catch.  I'll go queue this up now,
> thanks.
> 
> greg k-h

I was waiting for a reply in discussion for this patch...
https://lore.kernel.org/linux-serial/20210927093704.19768-1-pali@kernel.org/t/#u

There was no reply, so I was surprised it was taken without any
reaction. I was really in impression that patch is waiting.

So sorry for that.

Johan, could you write comments below original patch, so discussion is
not on two places? I would really like to fix this issue because
c_ospeed contains incorrect value.
