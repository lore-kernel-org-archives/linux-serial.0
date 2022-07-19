Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A149CC43334
	for <linux-serial@archiver.kernel.org>; Tue, 19 Jul 2022 05:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236104AbiGSFxy (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 19 Jul 2022 01:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235755AbiGSFxw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 19 Jul 2022 01:53:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E60B3AB1E;
        Mon, 18 Jul 2022 22:53:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DFD95B81980;
        Tue, 19 Jul 2022 05:53:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC49C341C6;
        Tue, 19 Jul 2022 05:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658210028;
        bh=HEQudCsEwmQj6DCpoae+8sY3HOaZP492SJNMdQFnCmk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r3NUzQL5N1EOQK5TehdwC14toRrZEGm5/Se3fsDcbzWCA6OYvPLBd7eQbb6pqHwly
         z3PJ9HVCbKB6EtPTBCOEqV15R7vcGEjI2aG+xmrnQ+AIINches38S7FN4eA2of7kYQ
         6I1QjBIm1gjBjuwNKK4eOISbtqHRZZhRKhd8xZqUjjakS/0PDktIbkr5ClDuTDZpSH
         vqtJUR2wJ6glgGaXJCuYyVtyOs9cdTDJQtymyRaWYeMNopKbqChU9l57w8QUIyC9oD
         EevJyV6eHPyf1lBuB9sTPG8RA+Zf0Y+P3H1h6XLM/61JQoboK89yty1LP19bggZFtE
         tiIs7BYRhtmnQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oDgAw-0001Kq-49; Tue, 19 Jul 2022 07:53:42 +0200
Date:   Tue, 19 Jul 2022 07:53:42 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Jonathan Woithe <jwoithe@just42.net>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, Aidan Thornton <makosoft@gmail.com>,
        Grigori Goronzy <greg@chown.ath.cx>,
        Michael Hanselmann <public@hansmi.ch>
Subject: Re: [Regression] CH341 USB-serial converter passes data in 32 byte
 chunks
Message-ID: <YtZG5vFNpXCXIMf0@hovoldconsulting.com>
References: <Ys1iPTfiZRWj2gXs@marvin.atrad.com.au>
 <Ys1sfRyL6El7go94@kroah.com>
 <Ys2nEmkvz2dfAKkU@hovoldconsulting.com>
 <Ys4QOgNF0pJDwRCJ@marvin.atrad.com.au>
 <YtUfcSOTl/ia+ahL@hovoldconsulting.com>
 <YtYsFVCShDeVCeis@marvin.atrad.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtYsFVCShDeVCeis@marvin.atrad.com.au>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jul 19, 2022 at 01:29:17PM +0930, Jonathan Woithe wrote:
> On Mon, Jul 18, 2022 at 10:53:05AM +0200, Johan Hovold wrote:
> > [ +CC: Aidan, Grigori and Michael ]
> > 
> > On Wed, Jul 13, 2022 at 09:52:18AM +0930, Jonathan Woithe wrote:
> > > On Tue, Jul 12, 2022 at 06:53:38PM +0200, Johan Hovold wrote:
> > 
> > > > Simply reverting the commit blamed by the bisection should only makes
> > > > things worse, at least for some device types.
> > > > 
> > > > Perhaps we need to set that bit 7 based on the type, even if the bit
> > > > meaning having been inverted seems a bit far-fetched.
> > > > 
> > > > Jonathan, could you try simply commenting out the
> > > > 	
> > > > 	val |= BIT(7);
> > > > 
> > > > statement in ch341_set_baudrate_lcr()?
> > > 
> > > Commenting out the above line brought some improvement.  In minicom with a
> > > loopback connector in place, the first byte sent does not get echoed
> > > back at all.  However, all other bytes are echoed as soon as they are sent.
> > 
> > Ok, so at least that addresses the disabled TX timer.
> > 
> > What happens if you change the line speed? Does the first character
> > after changing speed also get dropped?
> 
> Yes it does.  Starting out at 115200 in minicom I confirmed the loss of the
> first character.  I changed the line speed to 38400 in minicom and the next
> character to be pressed was dropped.  All others after it were fine.  I then
> returned to 115200 in minicom and the pattern repeated: the first character
> after the speed change was lost, but all others came through.  All these
> tests were done in the same minicom session under kernel 672c0c5 with the
> 
>   val |= BIT(7);
> 
> line still commented out.

Thanks for confirming.

I noticed one register write which was removed during 4.10 and we also
added support for setting the LCR register which wasn't there before.

Can you try the below patch which adds a register write that should
match what the old driver did at 115200 baud?

If that doesn't help, can you try just ifdeffing out the LCR update?

> > If that doesn't help, we'll keep digging. One more thing to try then
> > could be to comment out the above line on a 4.10 kernel to rule the
> > impact of any later changes on the first lost character.
> 
> I assume the "above line" is the
> 
>   val |= BIT(7);
> 
> statement in ch341_set_baudrate_lcr().  With this line commented out in the
> "v4.10" tag (c470abd), the first character is lost but all others are
> send/received as expected.  As you suggested, this appears to rule out
> later changes as the source of the lost first character.

Ok, good.

Johan


From d384f68dfda4eaf5b0065bdab236800d65ffb71d Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Mon, 18 Jul 2022 10:21:41 +0200
Subject: [PATCH] USB: serial: ch341: fix disabled rx timer on older devices

At least one older CH341 appears to have the RX timer enable bit
inverted so that setting it disables the RX timer and prevents the FIFO
from emptying until it is full.

Only set the RX timer enable bit for devices with version newer than
0x27.

Also try restoring a pre-4.10 register write when updating the line
settings to see if it has any effect on a lost first byte after
changing speed.

Another thing to try is to disable the LCR update, which wasn't
supported pre-4.10.

Reported-by: Jonathan Woithe <jwoithe@just42.net>
Link: https://lore.kernel.org/r/Ys1iPTfiZRWj2gXs@marvin.atrad.com.au
Not-Signed-off-yet-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/ch341.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/serial/ch341.c b/drivers/usb/serial/ch341.c
index 2798fca71261..bd27847ece2c 100644
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
@@ -259,6 +266,12 @@ static int ch341_set_baudrate_lcr(struct usb_device *dev,
 	if (r)
 		return r;
 
+#if 1
+	r = ch341_control_out(dev, CH341_REQ_WRITE_REG, 0x0f2c, 0x08);
+	if (r)
+		return r;
+#endif
+#if 1
 	/*
 	 * Chip versions before version 0x30 as read using
 	 * CH341_REQ_READ_VERSION used separate registers for line control
@@ -269,7 +282,7 @@ static int ch341_set_baudrate_lcr(struct usb_device *dev,
 			      CH341_REG_LCR2 << 8 | CH341_REG_LCR, lcr);
 	if (r)
 		return r;
-
+#endif
 	return r;
 }
 
@@ -308,7 +321,9 @@ static int ch341_configure(struct usb_device *dev, struct ch341_private *priv)
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

