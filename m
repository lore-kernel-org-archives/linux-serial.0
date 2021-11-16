Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B983C433F5
	for <linux-serial@archiver.kernel.org>; Tue, 16 Nov 2021 08:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6198C61B96
	for <linux-serial@archiver.kernel.org>; Tue, 16 Nov 2021 08:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbhKPIaB (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 16 Nov 2021 03:30:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:40058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232091AbhKPI36 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 16 Nov 2021 03:29:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B222261B96;
        Tue, 16 Nov 2021 08:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637051222;
        bh=djTFysoQJ6bSyzm4dLBDZqkJbsg9GxS/dMHzCjPZdDY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J5TkaA7u8wmcx1V/Fu0pHPdwN9GmjI0GjD4wEnqT4nZRifPK/bqUEDi5VeUAxjxOK
         p/E+L9r1MLbGv7WjC4euBHawdRdChV1AMCW0o2QUE4yJ3TOfHfkYMEGZi1aQfL5VQ3
         H/aBMw0Kbv5E9VmUIZCY7HjdG+Te8JQCDkUQh1pk=
Date:   Tue, 16 Nov 2021 09:26:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tudor.Ambarus@microchip.com
Cc:     richard.genoud@gmail.com, jirislaby@kernel.org,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Ludovic.Desroches@microchip.com, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: serial: atmel: Check return code of
 dmaengine_submit()
Message-ID: <YZNrU8au8SX3en+z@kroah.com>
References: <20211115143004.32743-1-tudor.ambarus@microchip.com>
 <YZKDmb/ZlYwtyX8j@kroah.com>
 <1910ee9a-19f8-e155-9cc9-4a67412f3402@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1910ee9a-19f8-e155-9cc9-4a67412f3402@microchip.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Nov 16, 2021 at 06:14:23AM +0000, Tudor.Ambarus@microchip.com wrote:
> On 11/15/21 5:58 PM, Greg KH wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On Mon, Nov 15, 2021 at 04:30:04PM +0200, Tudor Ambarus wrote:
> >> dma_cookie_t < 0 indicates an error code, check for it.
> > 
> > Very odd changelog text, please be more descriptive about what is
> > happening here.
> > 
> 
> The tx_submit() method of struct dma_async_tx_descriptor is entitled to do
> sanity checks and return errors if encountered. It's not the case for the
> DMA controller drivers that this client is using (at_h/xdmac), because they
> currently don't do sanity checks and always return a positive cookie at
> tx_submit() method. In case the controller drivers will implement sanity
> checks and return errors, print a message so that the client will be informed
> that something went wrong at tx_submit() level.
> 
> >>
> >> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> >> ---
> >>  drivers/tty/serial/atmel_serial.c | 10 ++++++++++
> >>  1 file changed, 10 insertions(+)
> >>
> >> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> >> index 2c99a47a2535..376f7a9c2868 100644
> >> --- a/drivers/tty/serial/atmel_serial.c
> >> +++ b/drivers/tty/serial/atmel_serial.c
> >> @@ -1004,6 +1004,11 @@ static void atmel_tx_dma(struct uart_port *port)
> >>               desc->callback = atmel_complete_tx_dma;
> >>               desc->callback_param = atmel_port;
> >>               atmel_port->cookie_tx = dmaengine_submit(desc);
> >> +             if (dma_submit_error(atmel_port->cookie_tx)) {
> >> +                     dev_err(port->dev, "dma_submit_error %d\n",
> >> +                             atmel_port->cookie_tx);
> >> +                     return;
> > 
> > What can a user do with this error message?
> > 
> will be informed that something went wrong at tx_submit() level.
> 
> > Have you seen this happen in real life?
> 
> No. I debugged a locking problem and I observed that dma_submit_error() is not called,
> so I thought to update this.
> 
> > 
> > What commit does this "fix"?
> 
> This is rather an improvement, but if you're looking for a fixes tag, I think
> we can use:
> Fixes: 08f738be88bb ("serial: at91: add tx dma support")
> 
> I'll send a v2 as part of a bigger series. If you find this patch does not worth it,
> I can as well drop it.

Please resend it because as-is, I can not take it.

thanks,

greg k-h
