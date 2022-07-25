Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19385C43334
	for <linux-serial@archiver.kernel.org>; Mon, 25 Jul 2022 23:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiGYXqg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 25 Jul 2022 19:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiGYXqg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 25 Jul 2022 19:46:36 -0400
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2502275C2;
        Mon, 25 Jul 2022 16:46:31 -0700 (PDT)
Received: from marvin.atrad.com.au (marvin.atrad.com.au [192.168.0.2])
        by server.atrad.com.au (8.17.1/8.17.1) with ESMTPS id 26PNjfdS023134
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 26 Jul 2022 09:15:43 +0930
Date:   Tue, 26 Jul 2022 09:15:41 +0930
From:   Jonathan Woithe <jwoithe@just42.net>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, Aidan Thornton <makosoft@gmail.com>,
        Grigori Goronzy <greg@chown.ath.cx>,
        Michael Hanselmann <public@hansmi.ch>
Subject: Re: [Regression] CH341 USB-serial converter passes data in 32 byte
 chunks
Message-ID: <Yt8rJWGKdfhkIBBY@marvin.atrad.com.au>
References: <Ys2nEmkvz2dfAKkU@hovoldconsulting.com>
 <Ys4QOgNF0pJDwRCJ@marvin.atrad.com.au>
 <YtUfcSOTl/ia+ahL@hovoldconsulting.com>
 <YtYsFVCShDeVCeis@marvin.atrad.com.au>
 <YtZG5vFNpXCXIMf0@hovoldconsulting.com>
 <YtZQjcUMYZEky+Ta@marvin.atrad.com.au>
 <YtZbWhGx/nqgAIX7@hovoldconsulting.com>
 <YtZlwLoDO9CVt9RO@marvin.atrad.com.au>
 <YtahM9hyrPVATchX@marvin.atrad.com.au>
 <YtvT/6DqPjUumpsl@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtvT/6DqPjUumpsl@hovoldconsulting.com>
X-MIMEDefang-action: accept
X-Scanned-By: MIMEDefang 2.86 on 192.168.0.1
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, Jul 23, 2022 at 12:57:03PM +0200, Johan Hovold wrote:
> > I have done further testing with the patch below in place.  Unfortunately
> > the PC with the real serial port decided not to boot, so instead I'm testing
> > with a 3-wire null modem cable into a PL2303-based USB-serial converter on
> > another box running a 5.15.38 kernel.  Flow control was turned off since the
> > cable wasn't wired for that.
> > 
> > Tests done in minicom:
> > :
> 
> Thanks for testing this. The above observations appear consistent with
> LCR updates for your CH341 not taking effect (e.g. stuck at 8N1 unlike
> the PL2303).
> 
> An easy way to test this is to send the letter 'q' (0x71) from CH341 to
> PL2303 (in 8N1 mode). This should be received as 0xf1 if the CH341 is in
> 7N1 mode as the stop bit is interpreted as MSB, or as 0x71 if still in
> 8N1 mode.

Apologies for the delayed response to your requests.

The result of the above test:

 1. With both the PL2303 and CH341 in 8N1, "q" is received correctly by
    both ends.

 2. With the CH341 configured for 7N1 in minicom and the PL2303 left in
    8N1, a "q" sent by the CH341 system is received as "q" by the PL2303.

Thus your suspicion seems to be correct: the LCR changes are not taking
effect on the CH341.

> > The behaviour of the LCR setting on version 0x27 may not be a new thing: all
> > my applications use 8N1, so if any of the other combinations were faulty
> > under 4.4.14 I wouldn't know.  I may look into testing the LCR settings
> > under 4.4.14 if you think there's value in it.  I expect it will show that
> > the patch below restores the 4.4.14 behaviour for hardware version 0x27, and
> > that the LCR issues were present in 4.4.14 but masked due to the almost
> > universal use of 8N1).  I can also try to work out an alternative way to
> > get a real hardware serial port if that would help: I'm thinking it would
> > remove any doubt about the LCR setting at one end of the link.
> 
> Actually, LCR configuration wasn't supported before 4.10 either so the
> only question would be if LCR control works at all with your chip
> (except for the lost character).
> 
> I found this thread where Micahel provides some details after apparently
> having disassembled the vendor driver:
> 
> 	https://lore.kernel.org/all/2e80916d-1be8-dc0f-abf9-adc0feea1803@msgid.hansmi.ch/
> 
> Based on that (and the comment that made it into the driver), chips
> before version 0x30 uses a different protocol for updating LCR so that
> anything but 8N1 has indeed likely never worked for these chips. 
> 
> Could you try the patch below, which simply disables LCR updates for
> older chips and which I believe you already confirmed works.

A you expected, I can confirm that with the most recent patch in place as
sent:

 1. There are no delays sending or receiving characters on the CH341.

 2. There is no loss of the first character sent or received by the CH341.

 3. With both the PL2303 and CH341 in 8N1, "q" is received correctly by
    both ends.

 4. With the CH341 configured for 7N1 in minicom and the PL2303 left in
    8N1, a "q" sent by the CH341 system is received as "q" by the PL2303.

That is, it seems to work (notwithstanding the LCR issue).

> And then as a follow up, see if enabling the LCR update again has any
> effect on the word size (e.g. rerun the test you did above, or the "q"
> test I mentioned).

I commented out the "priv->version < 0x30" conditional to re-enable the LCR
update and repeated the above test.  The result was the same: with the
PL2303 in 8N1 and the CH341 supposedly in 7N1, both ends received a "q" as
"q".

> This may give an indication of how far we are from being able to support
> LCR updates on older chips even this is not something we need to
> implement now.

It seems there are still some mysteries left to solve surrounding the
earlier chips.  At least they seem to work in 8N1 through, which is what
most things would be using these days.

Regards
  jonathan

> >From 4d12bb8ba4fe760cd5893b7c5f981524e16536fc Mon Sep 17 00:00:00 2001
> From: Johan Hovold <johan@kernel.org>
> Date: Mon, 18 Jul 2022 10:21:41 +0200
> Subject: [PATCH] USB: serial: ch341: fix disabled rx timer on older devices
> 
> At least one older CH341 appears to have the RX timer enable bit
> inverted so that setting it disables the RX timer and prevents the FIFO
> from emptying until it is full.
> 
> Only set the RX timer enable bit for devices with version newer than
> 0x27 (even though this probably affects all pre-0x30 devices).
> 
> Also disable LCR updates for pre-0x30 devices which use a different
> protocol and where the current register write causes the next received
> character to be lost.
> 
> FIXME: split in two patches
> 
> Reported-by: Jonathan Woithe <jwoithe@just42.net>
> Link: https://lore.kernel.org/r/Ys1iPTfiZRWj2gXs@marvin.atrad.com.au
> Fixes: 4e46c410e050 ("USB: serial: ch341: reinitialize chip on reconfiguration")
> Fixes: 55fa15b5987d ("USB: serial: ch341: fix baud rate and line-control handling")
> Not-Signed-off-yet-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/usb/serial/ch341.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/serial/ch341.c b/drivers/usb/serial/ch341.c
> index 2798fca71261..af01a462cc43 100644
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
> @@ -265,6 +272,9 @@ static int ch341_set_baudrate_lcr(struct usb_device *dev,
>  	 * (stop bits, parity and word length). Version 0x30 and above use
>  	 * CH341_REG_LCR only and CH341_REG_LCR2 is always set to zero.
>  	 */
> +	if (priv->version < 0x30)
> +		return 0;
> +
>  	r = ch341_control_out(dev, CH341_REQ_WRITE_REG,
>  			      CH341_REG_LCR2 << 8 | CH341_REG_LCR, lcr);
>  	if (r)
> @@ -308,7 +318,9 @@ static int ch341_configure(struct usb_device *dev, struct ch341_private *priv)
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
> 
> 
