Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4524AC433EF
	for <linux-serial@archiver.kernel.org>; Tue, 19 Jul 2022 08:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235828AbiGSIGB (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 19 Jul 2022 04:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbiGSIGA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 19 Jul 2022 04:06:00 -0400
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C70DB7;
        Tue, 19 Jul 2022 01:05:56 -0700 (PDT)
Received: from marvin.atrad.com.au (marvin.atrad.com.au [192.168.0.2])
        by server.atrad.com.au (8.17.1/8.17.1) with ESMTPS id 26J85KEU018512
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 19 Jul 2022 17:35:22 +0930
Date:   Tue, 19 Jul 2022 17:35:20 +0930
From:   Jonathan Woithe <jwoithe@just42.net>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, Aidan Thornton <makosoft@gmail.com>,
        Grigori Goronzy <greg@chown.ath.cx>,
        Michael Hanselmann <public@hansmi.ch>
Subject: Re: [Regression] CH341 USB-serial converter passes data in 32 byte
 chunks
Message-ID: <YtZlwLoDO9CVt9RO@marvin.atrad.com.au>
References: <Ys1iPTfiZRWj2gXs@marvin.atrad.com.au>
 <Ys1sfRyL6El7go94@kroah.com>
 <Ys2nEmkvz2dfAKkU@hovoldconsulting.com>
 <Ys4QOgNF0pJDwRCJ@marvin.atrad.com.au>
 <YtUfcSOTl/ia+ahL@hovoldconsulting.com>
 <YtYsFVCShDeVCeis@marvin.atrad.com.au>
 <YtZG5vFNpXCXIMf0@hovoldconsulting.com>
 <YtZQjcUMYZEky+Ta@marvin.atrad.com.au>
 <YtZbWhGx/nqgAIX7@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtZbWhGx/nqgAIX7@hovoldconsulting.com>
X-MIMEDefang-action: accept
X-Scanned-By: MIMEDefang 2.86 on 192.168.0.1
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jul 19, 2022 at 09:20:58AM +0200, Johan Hovold wrote:
> On Tue, Jul 19, 2022 at 04:04:53PM +0930, Jonathan Woithe wrote:
> > On Tue, Jul 19, 2022 at 07:53:42AM +0200, Johan Hovold wrote:
> 
> > > I noticed one register write which was removed during 4.10 and we also
> > > added support for setting the LCR register which wasn't there before.
> > > 
> > > Can you try the below patch which adds a register write that should
> > > match what the old driver did at 115200 baud?
> > 
> > I applied this patch to 672c0c5.  With the patch as supplied there was no
> > change: the first character was lost but all others were delivered as
> > expected.
> > 
> > > If that doesn't help, can you try just ifdeffing out the LCR update?
> > 
> > I changed the second of the added "#if -0" directives to "#if 1" (thus
> > removing the LCR update).  This made things work: all characters were echoed
> > back to minicom as they were pressed.
> 
> Perfect, thanks for confirming.
> 
> > As a final test I changed the first of the added "#if 1" directives to
> > "#if 0", effectively removing the extra register write you added earlier.
> > The resulting kernel still worked.  It appears that this extra register
> > write doesn't have any effect as far as the missing first character is
> > concerned.
> 
> Thanks for checking.
> 
> > On the basis of this, it seems the LCR update causes the loss of the first
> > character on version 0x27 hardware.
> 
> Right, so it seems we have two issues here:
> 
> First, the disabled rx timer, which we can fix.
> 
> And second, the lost character after updating LCR, which we may be able
> to work around, for example, by disabling LCR control for older devices
> (i.e. pre-4.10 behaviour) or by not updating LCR unless the settings
> have changed (but that would still likely cause a lost character when we
> do). A third option may be to experiment with using the INIT command to
> set the line-speed and LCR, but that also has some side-effects like
> toggling the modem-control lines on termios changes, which I wanted to
> avoid.
> 
> And we still need to set LCR on probe, which may trigger the lost
> character unless we do this using the INIT command and that turns out
> to work.
> 
> Can you try the below patch and see if that still triggers the lost
> character after probe and line settings changes? Please also try to
> confirm that LCR can be updated this way at all.

Using the patch below, the device appears to function correctly: characters
are echoed back to minicom as soon as they are sent and the first characater
is not lost.  Changing line speed in minicom does not result in a lost
character either.

Of course all testing to this point has been with a loopback adapter which
means there's no indication whether line speed (or any other LCR parameters)
have really changed.  For complicated reasons I can't easily test using the
programmer hardware right now.  I will see if I can work out a way to verify
speed and LCR changes with the hardware I have available.  Hacking up a
null-modem cable and connecting to a PC which happens to have a real
hardware serial port may be the easiest.

Regards
  jonathan

> >From 1c937d58f83df00a7879ff82a2b980d11b3faf7b Mon Sep 17 00:00:00 2001
> From: Johan Hovold <johan@kernel.org>
> Date: Mon, 18 Jul 2022 10:21:41 +0200
> Subject: [PATCH] USB: serial: ch341: fix disabled rx timer on older devices
> 
> At least one older CH341 appears to have the RX timer enable bit
> inverted so that setting it disables the RX timer and prevents the FIFO
> from emptying until it is full.
> 
> Only set the RX timer enable bit for devices with version newer than
> 0x27.
> 
> Also try using the INIT command to update LCR to work around a separate
> issue with lost characters after LCR updates on older devices. Note that
> using INIT like this triggers a similar problem on newer CH341A.
> 
> Reported-by: Jonathan Woithe <jwoithe@just42.net>
> Link: https://lore.kernel.org/r/Ys1iPTfiZRWj2gXs@marvin.atrad.com.au
> Not-Signed-off-yet-by: Johan Hovold <johan@kernel.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/usb/serial/ch341.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/serial/ch341.c b/drivers/usb/serial/ch341.c
> index 2798fca71261..d6a4b2572c9c 100644
> --- a/drivers/usb/serial/ch341.c
> +++ b/drivers/usb/serial/ch341.c
> @@ -97,7 +97,10 @@ struct ch341_private {
>  	u8 mcr;
>  	u8 msr;
>  	u8 lcr;
> +
>  	unsigned long quirks;
> +	u8 version;
> +
>  	unsigned long break_end;
>  };
>  
> @@ -250,8 +253,24 @@ static int ch341_set_baudrate_lcr(struct usb_device *dev,
>  	/*
>  	 * CH341A buffers data until a full endpoint-size packet (32 bytes)
>  	 * has been received unless bit 7 is set.
> +	 *
> +	 * At least one device with version 0x27 appears to have this bit
> +	 * inverted.
> +	 */
> +	if (priv->version > 0x27)
> +		val |= BIT(7);
> +
> +	/*
> +	 * At least one device with version 0x27 loses characters after
> +	 * updating LCR directly, try using INIT for that.
> +	 *
> +	 * Note that this appears to cause lost characters on newer CH341A.
>  	 */
> -	val |= BIT(7);
> +	if (priv->version <= 0x27) {
> +		r = ch341_control_out(dev, CH341_REQ_SERIAL_INIT,
> +				lcr << 8 | 0x9c, val);
> +		return r;
> +	}
>  
>  	r = ch341_control_out(dev, CH341_REQ_WRITE_REG,
>  			      CH341_REG_DIVISOR << 8 | CH341_REG_PRESCALER,
> @@ -308,7 +327,9 @@ static int ch341_configure(struct usb_device *dev, struct ch341_private *priv)
>  	r = ch341_control_in(dev, CH341_REQ_READ_VERSION, 0, 0, buffer, size);
>  	if (r)
>  		return r;
> -	dev_dbg(&dev->dev, "Chip version: 0x%02x\n", buffer[0]);
> +
> +	priv->version = buffer[0];
> +	dev_dbg(&dev->dev, "Chip version: 0x%02x\n", priv->version);
>  
>  	r = ch341_control_out(dev, CH341_REQ_SERIAL_INIT, 0, 0);
>  	if (r < 0)
> -- 
> 2.35.1

-- 
