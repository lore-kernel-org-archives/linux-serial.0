Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00B1C433EF
	for <linux-serial@archiver.kernel.org>; Mon, 18 Jul 2022 08:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbiGRIxP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 18 Jul 2022 04:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiGRIxP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 Jul 2022 04:53:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F8D62DF;
        Mon, 18 Jul 2022 01:53:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A97DD614A1;
        Mon, 18 Jul 2022 08:53:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09FB7C341C0;
        Mon, 18 Jul 2022 08:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658134393;
        bh=LbLuYT3GxhcNEQW6HRRHRR3dST7TzBmJlF6ixRxMJYw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ja4IOLZJ3rRiqqFqktY8bLnTp30cUgq0wVfclFLqoyuc4xW+HANRQsiIc3WaE9tCw
         FsSw8JxdfB9yp7VhHLKZQNEwTlWY/V0D7W3UFidZ8ppx+235kzf7926lpr47XQLYAs
         zjkVXljjkz3MXTr8Mm3EMVlUOioQn4K5sBd/A29JUZk0Gmmtz0wAh7byJzs83DWDll
         9cpCSahb3UIIakoJchOCImiKDuymqJ6GVBw8n+RE9cRLqdULm3Nv3QaGcEJfOGq03q
         xcgbYtkDu4WNK+O2DJG0SQmDUZQQbat5BSKna/AK3zF2yVfyIhBECIChQqKKC+je6o
         dtb72BkgJycPw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oDMUz-0000RU-Tl; Mon, 18 Jul 2022 10:53:06 +0200
Date:   Mon, 18 Jul 2022 10:53:05 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Jonathan Woithe <jwoithe@just42.net>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, Aidan Thornton <makosoft@gmail.com>,
        Grigori Goronzy <greg@chown.ath.cx>,
        Michael Hanselmann <public@hansmi.ch>
Subject: Re: [Regression] CH341 USB-serial converter passes data in 32 byte
 chunks
Message-ID: <YtUfcSOTl/ia+ahL@hovoldconsulting.com>
References: <Ys1iPTfiZRWj2gXs@marvin.atrad.com.au>
 <Ys1sfRyL6El7go94@kroah.com>
 <Ys2nEmkvz2dfAKkU@hovoldconsulting.com>
 <Ys4QOgNF0pJDwRCJ@marvin.atrad.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys4QOgNF0pJDwRCJ@marvin.atrad.com.au>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

[ +CC: Aidan, Grigori and Michael ]

On Wed, Jul 13, 2022 at 09:52:18AM +0930, Jonathan Woithe wrote:
> On Tue, Jul 12, 2022 at 06:53:38PM +0200, Johan Hovold wrote:

> > Simply reverting the commit blamed by the bisection should only makes
> > things worse, at least for some device types.
> > 
> > Perhaps we need to set that bit 7 based on the type, even if the bit
> > meaning having been inverted seems a bit far-fetched.
> > 
> > Jonathan, could you try simply commenting out the
> > 	
> > 	val |= BIT(7);
> > 
> > statement in ch341_set_baudrate_lcr()?
> 
> Commenting out the above line brought some improvement.  In minicom with a
> loopback connector in place, the first byte sent does not get echoed
> back at all.  However, all other bytes are echoed as soon as they are sent.

Ok, so at least that addresses the disabled TX timer.

What happens if you change the line speed? Does the first character
after changing speed also get dropped?

There were a few more changes done to the initialisation sequence at
that time and more changes in this area has followed since.

Could you try the patch below which addresses the disabled tx timer and
restores one of the init commands that were removed in 4.10.

If that doesn't help, we'll keep digging. One more thing to try then
could be to comment out the above line on a 4.10 kernel to rule the
impact of any later changes on the first lost character.

> The kernel used for the above test was 672c0c5 (5.18-rc5), which is the most
> recent I can conveniently get onto the test machine at present.  I tested
> the unmodified kernel before commenting out the line and confirmed that it
> exhibited the full fault condition (bytes come back in blocks of 32).

> > Also, what chip version do you have (see debug statement in
> > ch341_configure())?
> 
> Chip revision is 0x27.

Interesting. The devices I have here both have version 0x30. While the
tx-timer bit has no effect on the CH340G it must be set on the CH341A in
order for the FIFO to empty before it is full.

Michael Hanselmann posted a patch mentioning that devices before 0x30
has never been supported by the mainline driver:

	2c509d1cc86d ("USB: serial: ch341: name prescaler, divisor registers")

but your programmer seems to suggest otherwise, even if there may be
other differences here left to account for.

The joys of reverse-engineering...

Johan


From 82faf260d13c9f01e4af664f31231e5d88d7e4f1 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Mon, 18 Jul 2022 10:21:41 +0200
Subject: [PATCH] USB: serial: ch341: fix disabled tx timer on older devices

At least one older CH341 appears to have the TX timer enable bit
inverted so that setting it disables the TX timer and prevents the FIFO
from emptying until it is full.

Only set the TX timer enable bit for devices with version newer than
0x27.

Also try restoring an older init command before updating the line
settings to see if it has any effect on a lost first byte after
initialisation.

Reported-by: Jonathan Woithe <jwoithe@just42.net>
Link: https://lore.kernel.org/r/Ys1iPTfiZRWj2gXs@marvin.atrad.com.au
Not-Signed-off-yet-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/ch341.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/serial/ch341.c b/drivers/usb/serial/ch341.c
index 2798fca71261..748724ab6b04 100644
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
@@ -308,12 +315,18 @@ static int ch341_configure(struct usb_device *dev, struct ch341_private *priv)
 	r = ch341_control_in(dev, CH341_REQ_READ_VERSION, 0, 0, buffer, size);
 	if (r)
 		return r;
-	dev_dbg(&dev->dev, "Chip version: 0x%02x\n", buffer[0]);
+
+	priv->version = buffer[0];
+	dev_dbg(&dev->dev, "Chip version: 0x%02x\n", priv->version);
 
 	r = ch341_control_out(dev, CH341_REQ_SERIAL_INIT, 0, 0);
 	if (r < 0)
 		return r;
 
+	r = ch341_control_out(dev, CH341_REQ_SERIAL_INIT, 0x501f, 0xd90a);
+	if (r < 0)
+               return r;
+
 	r = ch341_set_baudrate_lcr(dev, priv, priv->baud_rate, priv->lcr);
 	if (r < 0)
 		return r;
-- 
2.35.1

