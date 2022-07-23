Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8E4C43334
	for <linux-serial@archiver.kernel.org>; Sat, 23 Jul 2022 10:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237121AbiGWK5B (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 23 Jul 2022 06:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbiGWK5A (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 23 Jul 2022 06:57:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910C61CFC0;
        Sat, 23 Jul 2022 03:56:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BFB761452;
        Sat, 23 Jul 2022 10:56:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE6FC341C0;
        Sat, 23 Jul 2022 10:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658573818;
        bh=Bof95L078ymoWmkaWti13lIBN2DjIGWgHlz5Uvmuf8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YSCdXmENcBYjWdlf6e3lSWyuhQyVpj/FgD6aBYnwoVj4mzB/dA7mZddKv5Q+mjlMk
         Plh4QNQ4/Stw/FPgXz6IEQnGGH4iu2NdIyzXhJmfoJhUV+azg1hJC/E5pAlDRXjo5L
         h/lqJ84fDG4ycfy7eJ4azb0TfaCNzQGU89eGptoWrs174UxFsb1fqPyuG44HeTMQTY
         8fjxNUwWofjVww9fBCVafM/YRiZOM8AqY1kd3pe7sL6X3bJkOylfpAXNbDaTLdugtf
         4jSp5F3TlUjKm3uOlzEYOo3wJBaS082jVGTg7lwoOTd3u6wVBWKYZY503j8fi0+JIT
         cOYPHDG/GkfzA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oFCoh-0001Mf-Qe; Sat, 23 Jul 2022 12:57:03 +0200
Date:   Sat, 23 Jul 2022 12:57:03 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Jonathan Woithe <jwoithe@just42.net>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, Aidan Thornton <makosoft@gmail.com>,
        Grigori Goronzy <greg@chown.ath.cx>,
        Michael Hanselmann <public@hansmi.ch>
Subject: Re: [Regression] CH341 USB-serial converter passes data in 32 byte
 chunks
Message-ID: <YtvT/6DqPjUumpsl@hovoldconsulting.com>
References: <Ys1sfRyL6El7go94@kroah.com>
 <Ys2nEmkvz2dfAKkU@hovoldconsulting.com>
 <Ys4QOgNF0pJDwRCJ@marvin.atrad.com.au>
 <YtUfcSOTl/ia+ahL@hovoldconsulting.com>
 <YtYsFVCShDeVCeis@marvin.atrad.com.au>
 <YtZG5vFNpXCXIMf0@hovoldconsulting.com>
 <YtZQjcUMYZEky+Ta@marvin.atrad.com.au>
 <YtZbWhGx/nqgAIX7@hovoldconsulting.com>
 <YtZlwLoDO9CVt9RO@marvin.atrad.com.au>
 <YtahM9hyrPVATchX@marvin.atrad.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtahM9hyrPVATchX@marvin.atrad.com.au>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jul 19, 2022 at 09:48:59PM +0930, Jonathan Woithe wrote:
> On Tue, Jul 19, 2022 at 05:35:22PM +0930, Jonathan Woithe wrote:
> > > Can you try the below patch and see if that still triggers the lost
> > > character after probe and line settings changes? Please also try to
> > > confirm that LCR can be updated this way at all.
> > 
> > :
> > Of course all testing to this point has been with a loopback adapter which
> > means there's no indication whether line speed (or any other LCR parameters)
> > have really changed.  For complicated reasons I can't easily test using the
> > programmer hardware right now.  I will see if I can work out a way to verify
> > speed and LCR changes with the hardware I have available.  Hacking up a
> > null-modem cable and connecting to a PC which happens to have a real
> > hardware serial port may be the easiest.
> 
> I have done further testing with the patch below in place.  Unfortunately
> the PC with the real serial port decided not to boot, so instead I'm testing
> with a 3-wire null modem cable into a PL2303-based USB-serial converter on
> another box running a 5.15.38 kernel.  Flow control was turned off since the
> cable wasn't wired for that.
> 
> Tests done in minicom:
> 
>  * Speed: change from 115200 to 38400 and back again.
> 
>    The speed setting of the CH341 appears to work correctly.
> 
>  * Data length: change from 8 to 7 bits in minicom on both adapters
> 
>    CH341 = 8 bits, PL2303 = 8 bits
>     - Data delivered correctly in both directions.
> 
>    CH341 = 8 bits, PL2303 = 7 bits
>     - Data sent by the CH341 received correctly by the PL2303
>     - Data sent by the PL2303 not received correctly by the CH341
> 
>    CH341 = 7 bits, PL2303 = 7 bits
>     - Data sent by the CH341 received correctly by the PL2303
>     - Data sent by the PL2303 not received correctly by the CH341
> 
>    CH341 = 7 bits, PL2303 = 8 bits
>     - Data delivered correctly in both directions.
>
>    There are too many variables in play to know what to make of this given
>    that the response of the PL2303 driver to these changes is unknown.  At
>    first glance the results appear to be rather inconsistent.  Maybe the
>    data length setting is not always affecting tx and rx on one or both of
>    the adapters.

Thanks for testing this. The above observations appear consistent with
LCR updates for your CH341 not taking effect (e.g. stuck at 8N1 unlike
the PL2303).

An easy way to test this is to send the letter 'q' (0x71) from CH341 to
PL2303 (in 8N1 mode). This should be received as 0xf1 if the CH341 is in
7N1 mode as the stop bit is interpreted as MSB, or as 0x71 if still in
8N1 mode.

> I'm not sure what this proves: most of these settings don't appear to be
> having any effect on either adapter.  In the end, 8N1 works and this is,
> after all, what most people would be using.  The situation with the patch is
> clearly better than it was without the patch because the CH341 is now
> delivering data in a timely manner - just like it did under 4.4.14.
> 
> The behaviour of the LCR setting on version 0x27 may not be a new thing: all
> my applications use 8N1, so if any of the other combinations were faulty
> under 4.4.14 I wouldn't know.  I may look into testing the LCR settings
> under 4.4.14 if you think there's value in it.  I expect it will show that
> the patch below restores the 4.4.14 behaviour for hardware version 0x27, and
> that the LCR issues were present in 4.4.14 but masked due to the almost
> universal use of 8N1).  I can also try to work out an alternative way to
> get a real hardware serial port if that would help: I'm thinking it would
> remove any doubt about the LCR setting at one end of the link.

Actually, LCR configuration wasn't supported before 4.10 either so the
only question would be if LCR control works at all with your chip
(except for the lost character).

I found this thread where Micahel provides some details after apparently
having disassembled the vendor driver:

	https://lore.kernel.org/all/2e80916d-1be8-dc0f-abf9-adc0feea1803@msgid.hansmi.ch/

Based on that (and the comment that made it into the driver), chips
before version 0x30 uses a different protocol for updating LCR so that
anything but 8N1 has indeed likely never worked for these chips. 

Could you try the patch below, which simply disables LCR updates for
older chips and which I believe you already confirmed works.

And then as a follow up, see if enabling the LCR update again has any
effect on the word size (e.g. rerun the test you did above, or the "q"
test I mentioned).

This may give an indication of how far we are from being able to support
LCR updates on older chips even this is not something we need to
implement now.

Johan


From 4d12bb8ba4fe760cd5893b7c5f981524e16536fc Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Mon, 18 Jul 2022 10:21:41 +0200
Subject: [PATCH] USB: serial: ch341: fix disabled rx timer on older devices

At least one older CH341 appears to have the RX timer enable bit
inverted so that setting it disables the RX timer and prevents the FIFO
from emptying until it is full.

Only set the RX timer enable bit for devices with version newer than
0x27 (even though this probably affects all pre-0x30 devices).

Also disable LCR updates for pre-0x30 devices which use a different
protocol and where the current register write causes the next received
character to be lost.

FIXME: split in two patches

Reported-by: Jonathan Woithe <jwoithe@just42.net>
Link: https://lore.kernel.org/r/Ys1iPTfiZRWj2gXs@marvin.atrad.com.au
Fixes: 4e46c410e050 ("USB: serial: ch341: reinitialize chip on reconfiguration")
Fixes: 55fa15b5987d ("USB: serial: ch341: fix baud rate and line-control handling")
Not-Signed-off-yet-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/ch341.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/serial/ch341.c b/drivers/usb/serial/ch341.c
index 2798fca71261..af01a462cc43 100644
--- a/drivers/usb/serial/ch341.c
+++ b/drivers/usb/serial/ch341.c
@@ -97,7 +97,10 @@ struct ch341_private {
 	u8 mcr;
 	u8 msr;
 	u8 lcr;
+
 	unsigned long quirks;
+	u8 version;
+
 	unsigned long break_end;
 };
 
@@ -250,8 +253,12 @@ static int ch341_set_baudrate_lcr(struct usb_device *dev,
 	/*
 	 * CH341A buffers data until a full endpoint-size packet (32 bytes)
 	 * has been received unless bit 7 is set.
+	 *
+	 * At least one device with version 0x27 appears to have this bit
+	 * inverted.
 	 */
-	val |= BIT(7);
+	if (priv->version > 0x27)
+		val |= BIT(7);
 
 	r = ch341_control_out(dev, CH341_REQ_WRITE_REG,
 			      CH341_REG_DIVISOR << 8 | CH341_REG_PRESCALER,
@@ -265,6 +272,9 @@ static int ch341_set_baudrate_lcr(struct usb_device *dev,
 	 * (stop bits, parity and word length). Version 0x30 and above use
 	 * CH341_REG_LCR only and CH341_REG_LCR2 is always set to zero.
 	 */
+	if (priv->version < 0x30)
+		return 0;
+
 	r = ch341_control_out(dev, CH341_REQ_WRITE_REG,
 			      CH341_REG_LCR2 << 8 | CH341_REG_LCR, lcr);
 	if (r)
@@ -308,7 +318,9 @@ static int ch341_configure(struct usb_device *dev, struct ch341_private *priv)
 	r = ch341_control_in(dev, CH341_REQ_READ_VERSION, 0, 0, buffer, size);
 	if (r)
 		return r;
-	dev_dbg(&dev->dev, "Chip version: 0x%02x\n", buffer[0]);
+
+	priv->version = buffer[0];
+	dev_dbg(&dev->dev, "Chip version: 0x%02x\n", priv->version);
 
 	r = ch341_control_out(dev, CH341_REQ_SERIAL_INIT, 0, 0);
 	if (r < 0)
-- 
2.35.1



