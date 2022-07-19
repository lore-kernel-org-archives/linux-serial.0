Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7EDCCA482
	for <linux-serial@archiver.kernel.org>; Tue, 19 Jul 2022 12:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241639AbiGSMuO (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 19 Jul 2022 08:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242181AbiGSMtv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 19 Jul 2022 08:49:51 -0400
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7979257E19;
        Tue, 19 Jul 2022 05:19:48 -0700 (PDT)
Received: from marvin.atrad.com.au (marvin.atrad.com.au [192.168.0.2])
        by server.atrad.com.au (8.17.1/8.17.1) with ESMTPS id 26JCIxdD008306
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 19 Jul 2022 21:49:00 +0930
Date:   Tue, 19 Jul 2022 21:48:59 +0930
From:   Jonathan Woithe <jwoithe@just42.net>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, Aidan Thornton <makosoft@gmail.com>,
        Grigori Goronzy <greg@chown.ath.cx>,
        Michael Hanselmann <public@hansmi.ch>
Subject: Re: [Regression] CH341 USB-serial converter passes data in 32 byte
 chunks
Message-ID: <YtahM9hyrPVATchX@marvin.atrad.com.au>
References: <Ys1iPTfiZRWj2gXs@marvin.atrad.com.au>
 <Ys1sfRyL6El7go94@kroah.com>
 <Ys2nEmkvz2dfAKkU@hovoldconsulting.com>
 <Ys4QOgNF0pJDwRCJ@marvin.atrad.com.au>
 <YtUfcSOTl/ia+ahL@hovoldconsulting.com>
 <YtYsFVCShDeVCeis@marvin.atrad.com.au>
 <YtZG5vFNpXCXIMf0@hovoldconsulting.com>
 <YtZQjcUMYZEky+Ta@marvin.atrad.com.au>
 <YtZbWhGx/nqgAIX7@hovoldconsulting.com>
 <YtZlwLoDO9CVt9RO@marvin.atrad.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtZlwLoDO9CVt9RO@marvin.atrad.com.au>
X-MIMEDefang-action: accept
X-Scanned-By: MIMEDefang 2.86 on 192.168.0.1
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jul 19, 2022 at 05:35:22PM +0930, Jonathan Woithe wrote:
> > Can you try the below patch and see if that still triggers the lost
> > character after probe and line settings changes? Please also try to
> > confirm that LCR can be updated this way at all.
> 
> :
> Of course all testing to this point has been with a loopback adapter which
> means there's no indication whether line speed (or any other LCR parameters)
> have really changed.  For complicated reasons I can't easily test using the
> programmer hardware right now.  I will see if I can work out a way to verify
> speed and LCR changes with the hardware I have available.  Hacking up a
> null-modem cable and connecting to a PC which happens to have a real
> hardware serial port may be the easiest.

I have done further testing with the patch below in place.  Unfortunately
the PC with the real serial port decided not to boot, so instead I'm testing
with a 3-wire null modem cable into a PL2303-based USB-serial converter on
another box running a 5.15.38 kernel.  Flow control was turned off since the
cable wasn't wired for that.

Tests done in minicom:

 * Speed: change from 115200 to 38400 and back again.

   The speed setting of the CH341 appears to work correctly.

 * Data length: change from 8 to 7 bits in minicom on both adapters

   CH341 = 8 bits, PL2303 = 8 bits
    - Data delivered correctly in both directions.

   CH341 = 8 bits, PL2303 = 7 bits
    - Data sent by the CH341 received correctly by the PL2303
    - Data sent by the PL2303 not received correctly by the CH341

   CH341 = 7 bits, PL2303 = 7 bits
    - Data sent by the CH341 received correctly by the PL2303
    - Data sent by the PL2303 not received correctly by the CH341

   CH341 = 7 bits, PL2303 = 8 bits
    - Data delivered correctly in both directions.

   There are too many variables in play to know what to make of this given
   that the response of the PL2303 driver to these changes is unknown.  At
   first glance the results appear to be rather inconsistent.  Maybe the
   data length setting is not always affecting tx and rx on one or both of
   the adapters.

 * Parity: change from None to Even.

   Changing only one adapter to Even parity did not prevent data being
   received correctly.  Data continued to be received correctly when both
   were set to even parity.

 * Stop bits: change from 1 to 2.

   All combinations of stop bit settings resulted in correct delivery of
   data in both directions.

I'm not sure what this proves: most of these settings don't appear to be
having any effect on either adapter.  In the end, 8N1 works and this is,
after all, what most people would be using.  The situation with the patch is
clearly better than it was without the patch because the CH341 is now
delivering data in a timely manner - just like it did under 4.4.14.

The behaviour of the LCR setting on version 0x27 may not be a new thing: all
my applications use 8N1, so if any of the other combinations were faulty
under 4.4.14 I wouldn't know.  I may look into testing the LCR settings
under 4.4.14 if you think there's value in it.  I expect it will show that
the patch below restores the 4.4.14 behaviour for hardware version 0x27, and
that the LCR issues were present in 4.4.14 but masked due to the almost
universal use of 8N1).  I can also try to work out an alternative way to
get a real hardware serial port if that would help: I'm thinking it would
remove any doubt about the LCR setting at one end of the link.

Regards
  jonathan

> > >From 1c937d58f83df00a7879ff82a2b980d11b3faf7b Mon Sep 17 00:00:00 2001
> > From: Johan Hovold <johan@kernel.org>
> > Date: Mon, 18 Jul 2022 10:21:41 +0200
> > Subject: [PATCH] USB: serial: ch341: fix disabled rx timer on older devices
> > 
> > At least one older CH341 appears to have the RX timer enable bit
> > inverted so that setting it disables the RX timer and prevents the FIFO
> > from emptying until it is full.
> > 
> > Only set the RX timer enable bit for devices with version newer than
> > 0x27.
> > 
> > Also try using the INIT command to update LCR to work around a separate
> > issue with lost characters after LCR updates on older devices. Note that
> > using INIT like this triggers a similar problem on newer CH341A.
> > 
> > Reported-by: Jonathan Woithe <jwoithe@just42.net>
> > Link: https://lore.kernel.org/r/Ys1iPTfiZRWj2gXs@marvin.atrad.com.au
> > Not-Signed-off-yet-by: Johan Hovold <johan@kernel.org>
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > ---
> >  drivers/usb/serial/ch341.c | 25 +++++++++++++++++++++++--
> >  1 file changed, 23 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/usb/serial/ch341.c b/drivers/usb/serial/ch341.c
> > index 2798fca71261..d6a4b2572c9c 100644
> > --- a/drivers/usb/serial/ch341.c
> > +++ b/drivers/usb/serial/ch341.c
> > @@ -97,7 +97,10 @@ struct ch341_private {
> >  	u8 mcr;
> >  	u8 msr;
> >  	u8 lcr;
> > +
> >  	unsigned long quirks;
> > +	u8 version;
> > +
> >  	unsigned long break_end;
> >  };
> >  
> > @@ -250,8 +253,24 @@ static int ch341_set_baudrate_lcr(struct usb_device *dev,
> >  	/*
> >  	 * CH341A buffers data until a full endpoint-size packet (32 bytes)
> >  	 * has been received unless bit 7 is set.
> > +	 *
> > +	 * At least one device with version 0x27 appears to have this bit
> > +	 * inverted.
> > +	 */
> > +	if (priv->version > 0x27)
> > +		val |= BIT(7);
> > +
> > +	/*
> > +	 * At least one device with version 0x27 loses characters after
> > +	 * updating LCR directly, try using INIT for that.
> > +	 *
> > +	 * Note that this appears to cause lost characters on newer CH341A.
> >  	 */
> > -	val |= BIT(7);
> > +	if (priv->version <= 0x27) {
> > +		r = ch341_control_out(dev, CH341_REQ_SERIAL_INIT,
> > +				lcr << 8 | 0x9c, val);
> > +		return r;
> > +	}
> >  
> >  	r = ch341_control_out(dev, CH341_REQ_WRITE_REG,
> >  			      CH341_REG_DIVISOR << 8 | CH341_REG_PRESCALER,
> > @@ -308,7 +327,9 @@ static int ch341_configure(struct usb_device *dev, struct ch341_private *priv)
> >  	r = ch341_control_in(dev, CH341_REQ_READ_VERSION, 0, 0, buffer, size);
> >  	if (r)
> >  		return r;
> > -	dev_dbg(&dev->dev, "Chip version: 0x%02x\n", buffer[0]);
> > +
> > +	priv->version = buffer[0];
> > +	dev_dbg(&dev->dev, "Chip version: 0x%02x\n", priv->version);
> >  
> >  	r = ch341_control_out(dev, CH341_REQ_SERIAL_INIT, 0, 0);
> >  	if (r < 0)
> > -- 
