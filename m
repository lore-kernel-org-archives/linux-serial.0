Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B52C433EF
	for <linux-serial@archiver.kernel.org>; Tue, 19 Jul 2022 06:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235161AbiGSGfb (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 19 Jul 2022 02:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234732AbiGSGfb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 19 Jul 2022 02:35:31 -0400
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C740331;
        Mon, 18 Jul 2022 23:35:28 -0700 (PDT)
Received: from marvin.atrad.com.au (marvin.atrad.com.au [192.168.0.2])
        by server.atrad.com.au (8.17.1/8.17.1) with ESMTPS id 26J6Yruo030560
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 19 Jul 2022 16:04:54 +0930
Date:   Tue, 19 Jul 2022 16:04:53 +0930
From:   Jonathan Woithe <jwoithe@just42.net>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, Aidan Thornton <makosoft@gmail.com>,
        Grigori Goronzy <greg@chown.ath.cx>,
        Michael Hanselmann <public@hansmi.ch>
Subject: Re: [Regression] CH341 USB-serial converter passes data in 32 byte
 chunks
Message-ID: <YtZQjcUMYZEky+Ta@marvin.atrad.com.au>
References: <Ys1iPTfiZRWj2gXs@marvin.atrad.com.au>
 <Ys1sfRyL6El7go94@kroah.com>
 <Ys2nEmkvz2dfAKkU@hovoldconsulting.com>
 <Ys4QOgNF0pJDwRCJ@marvin.atrad.com.au>
 <YtUfcSOTl/ia+ahL@hovoldconsulting.com>
 <YtYsFVCShDeVCeis@marvin.atrad.com.au>
 <YtZG5vFNpXCXIMf0@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtZG5vFNpXCXIMf0@hovoldconsulting.com>
X-MIMEDefang-action: accept
X-Scanned-By: MIMEDefang 2.86 on 192.168.0.1
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jul 19, 2022 at 07:53:42AM +0200, Johan Hovold wrote:
> On Tue, Jul 19, 2022 at 01:29:17PM +0930, Jonathan Woithe wrote:
> > On Mon, Jul 18, 2022 at 10:53:05AM +0200, Johan Hovold wrote:
> > > [ +CC: Aidan, Grigori and Michael ]
> > > 
> > > On Wed, Jul 13, 2022 at 09:52:18AM +0930, Jonathan Woithe wrote:
> > > > On Tue, Jul 12, 2022 at 06:53:38PM +0200, Johan Hovold wrote:
> > > 
> > > > > Simply reverting the commit blamed by the bisection should only makes
> > > > > things worse, at least for some device types.
> > > > > 
> > > > > Perhaps we need to set that bit 7 based on the type, even if the bit
> > > > > meaning having been inverted seems a bit far-fetched.
> > > > > 
> > > > > Jonathan, could you try simply commenting out the
> > > > > 	
> > > > > 	val |= BIT(7);
> > > > > 
> > > > > statement in ch341_set_baudrate_lcr()?
> > > > 
> > > > Commenting out the above line brought some improvement.  In minicom with a
> > > > loopback connector in place, the first byte sent does not get echoed
> > > > back at all.  However, all other bytes are echoed as soon as they are sent.
> > > 
> > > Ok, so at least that addresses the disabled TX timer.
> > > 
> > > What happens if you change the line speed? Does the first character
> > > after changing speed also get dropped?
> > 
> > Yes it does.  Starting out at 115200 in minicom I confirmed the loss of the
> > first character.  I changed the line speed to 38400 in minicom and the next
> > character to be pressed was dropped.  All others after it were fine.  I then
> > returned to 115200 in minicom and the pattern repeated: the first character
> > after the speed change was lost, but all others came through.  All these
> > tests were done in the same minicom session under kernel 672c0c5 with the
> > 
> >   val |= BIT(7);
> > 
> > line still commented out.
> 
> Thanks for confirming.
> 
> I noticed one register write which was removed during 4.10 and we also
> added support for setting the LCR register which wasn't there before.
> 
> Can you try the below patch which adds a register write that should
> match what the old driver did at 115200 baud?

I applied this patch to 672c0c5.  With the patch as supplied there was no
change: the first character was lost but all others were delivered as
expected.

> If that doesn't help, can you try just ifdeffing out the LCR update?

I changed the second of the added "#if -0" directives to "#if 1" (thus
removing the LCR update).  This made things work: all characters were echoed
back to minicom as they were pressed.

As a final test I changed the first of the added "#if 1" directives to
"#if 0", effectively removing the extra register write you added earlier.
The resulting kernel still worked.  It appears that this extra register
write doesn't have any effect as far as the missing first character is
concerned.

On the basis of this, it seems the LCR update causes the loss of the first
character on version 0x27 hardware.

Regards
  jonathan

> >From d384f68dfda4eaf5b0065bdab236800d65ffb71d Mon Sep 17 00:00:00 2001
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
> Also try restoring a pre-4.10 register write when updating the line
> settings to see if it has any effect on a lost first byte after
> changing speed.
> 
> Another thing to try is to disable the LCR update, which wasn't
> supported pre-4.10.
> 
> Reported-by: Jonathan Woithe <jwoithe@just42.net>
> Link: https://lore.kernel.org/r/Ys1iPTfiZRWj2gXs@marvin.atrad.com.au
> Not-Signed-off-yet-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/usb/serial/ch341.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/serial/ch341.c b/drivers/usb/serial/ch341.c
> index 2798fca71261..bd27847ece2c 100644
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
> @@ -250,8 +253,12 @@ static int ch341_set_baudrate_lcr(struct usb_device *dev,
>  	/*
>  	 * CH341A buffers data until a full endpoint-size packet (32 bytes)
>  	 * has been received unless bit 7 is set.
> +	 *
> +	 * At least one device with version 0x27 appears to have this bit
> +	 * inverted.
>  	 */
> -	val |= BIT(7);
> +	if (priv->version > 0x27)
> +		val |= BIT(7);
>  
>  	r = ch341_control_out(dev, CH341_REQ_WRITE_REG,
>  			      CH341_REG_DIVISOR << 8 | CH341_REG_PRESCALER,
> @@ -259,6 +266,12 @@ static int ch341_set_baudrate_lcr(struct usb_device *dev,
>  	if (r)
>  		return r;
>  
> +#if 1
> +	r = ch341_control_out(dev, CH341_REQ_WRITE_REG, 0x0f2c, 0x08);
> +	if (r)
> +		return r;
> +#endif
> +#if 1
>  	/*
>  	 * Chip versions before version 0x30 as read using
>  	 * CH341_REQ_READ_VERSION used separate registers for line control
> @@ -269,7 +282,7 @@ static int ch341_set_baudrate_lcr(struct usb_device *dev,
>  			      CH341_REG_LCR2 << 8 | CH341_REG_LCR, lcr);
>  	if (r)
>  		return r;
> -
> +#endif
>  	return r;
>  }
>  
> @@ -308,7 +321,9 @@ static int ch341_configure(struct usb_device *dev, struct ch341_private *priv)
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
