Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7F4C433E6
	for <linux-serial@archiver.kernel.org>; Thu, 11 Mar 2021 16:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5DF964FF6
	for <linux-serial@archiver.kernel.org>; Thu, 11 Mar 2021 16:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbhCKQIM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 11 Mar 2021 11:08:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:49668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234341AbhCKQH6 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 11 Mar 2021 11:07:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6528664FE0;
        Thu, 11 Mar 2021 16:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615478878;
        bh=yQO2qA6ynCpFOZDqh7h1C+h3mQy2cJ0rnqM4e3ve240=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VnF4G6sGNVWtPWVzFozfHr7JU4dSVAxi+FajS5uTcPe1Ff6mnjkLAGnoxw5tV2Wsh
         zXn2v6sgpdu+h1w404MTEiJMNPi9PpKIclqqronbohbRRHVrArWANpnuLisdx1d58p
         K6CwHX2s66kuEV2p32klm9mYS/VG6G7uibqlYPwGxMrbkULInd6qrfkI7AtmCoMSUT
         yO9ubRxHzCob9ZN4P8pn6a6ErEw9DZk5t00QdXvPM5nuHan+P2iB4H+xzyHlHQO0i3
         jZnTjUWHKEmXSbD4JLFDiY+JLbI6PNZr+VDcOreZHAByQPtGdZsNEzsuToe21pvmwW
         RSwRMvq/z9bHg==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lKNr6-0000I2-VL; Thu, 11 Mar 2021 17:08:09 +0100
Date:   Thu, 11 Mar 2021 17:08:08 +0100
From:   Johan Hovold <johan@kernel.org>
To:     "Michael G. Katzmann" <michaelk@IEEE.org>
Cc:     Charles Yeh <charlesyeh522@gmail.com>,
        =?utf-8?B?WWVoLkNoYXJsZXMgW+iRieamrumRq10=?= 
        <charles-yeh@prolific.com.tw>, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, Joe Abbott <jabbott@rollanet.org>
Subject: Re: non-standard baud rates with Prolific 2303 USB-serial
Message-ID: <YEpAaL9QtVMduEpi@hovoldconsulting.com>
References: <YDUiuLtwRkZ0D0Mi@hovoldconsulting.com>
 <f63df659-6cdf-bba6-f892-1012b98f82e2@IEEE.org>
 <YDUp0tIThOZSTHJt@hovoldconsulting.com>
 <93584ae4-665e-1e67-01e0-cc53f987bee4@IEEE.org>
 <YDUysZY90FfVhrHK@hovoldconsulting.com>
 <CAAZvQQ6F=cQ-EhC0kgeTVM3GrtBWR+HfM6UJWj2AEF1NYZ-vAQ@mail.gmail.com>
 <YDaGRRYrEO5BEJv0@hovoldconsulting.com>
 <CAAZvQQ7+b9=DKqPxgsXxS7Lhqj=QTzKHCMarSbsQkAnYqdO1GA@mail.gmail.com>
 <YEH7okblCx8+Odxn@hovoldconsulting.com>
 <ddc0e424-21c2-b8f4-1b00-f589267d2b51@IEEE.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddc0e424-21c2-b8f4-1b00-f589267d2b51@IEEE.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, Mar 06, 2021 at 11:15:52PM -0500, Michael G. Katzmann wrote:
> 
> On 3/5/21 4:36 AM, Johan Hovold wrote:
> 
> oops I should have looked at the previous code determining variants...
> 
> take 2...
>
> #define PL2303_QUIRK_DIVISOR_TA                 BIT(3)
> 
> enum pl2303_type {
> 	TYPE_01,	/* Type 0 and 1 (difference unknown) */
> 	TYPE_HX,	/* HX version of the pl2303 chip */
> 	TYPE_HXN,	/* HXN version of the pl2303 chip */
> 	TYPE_TA,	/* TA version of the pl2303 chip */
> 	TYPE_COUNT
> };
> 
> 
> static const struct pl2303_type_data pl2303_type_data[TYPE_COUNT] =
> ....
>         [TYPE_TA] = {
>                 .max_baud_rate          = 6000000,
>                 .quirks                 = PL2303_QUIRK_DIVISOR_TA,

I think we should just a new flag for the alternate divisor encoding
named "alt_divisors" (cf. no_divisors).

Chances are this encoding is used for other types as well.

>         },
> };
> 
> static int pl2303_startup(struct usb_serial *serial)
> {
> ....
> 	if ( serial->dev->descriptor.bcdDevice == 0x0300 && serial->dev->descriptor.bcdUSB == 0x0200 )
> 		type = TYPE_TA;

This needs to go after the bDeviceClass == 0x02 check, and the 
descriptor fields need to be accessed using le16_to_cpu().

I've prepared a patch series that clean up and tighten the type
detection which I suggest you built upon instead.

I'll post the series after replying here.

> 	else if (serial->dev->descriptor.bDeviceClass == 0x02)
> ....
> }
> 
> static speed_t pl2303_encode_baud_rate_divisor( struct usb_serial_port *port,
> 							unsigned char buf[4],
> 								speed_t baud)
> {
> 	unsigned int baseline, mantissa, exponent;
> 	struct usb_serial *serial = port->serial;
> 	struct pl2303_serial_private *spriv = usb_get_serial_data(serial);
> 
> 	/*
> 	 * Apparently the formula is:
> 	 * baudrate = 12M * 32 / (mantissa * 4^exponent)
> 	 * where
> 	 *   mantissa = buf[8:0]
> 	 *   exponent = buf[11:9]
> 	 *
> 	 * TA version has more precision
> 	 *      uses mantissa = buf[bits 10:0 ]

So you discovered that there were even more bits here? Your first
version used ten bits, I believe.

I got an offline mail from a third person having problems with the TA
and who had also verified eleven bits here.

> 	 *           exponent = buf[bits 15:13]
> 	 *  and x2 prescaler enable by buf[bit 16]
> 	 */
> 	baseline = 12000000 * 32;
> 	mantissa = baseline / baud;
> 	if (mantissa == 0)
> 		mantissa = 1;    /* Avoid dividing by zero if baud > 32*12M. */
> 	exponent = 0;
> 
> 	if (spriv->quirks & PL2303_QUIRK_DIVISOR_TA) {
> 		while (mantissa >= 2048) {
> 			// exponent is three bits (after shifting right)
> 			if (exponent < 15) {   // we are going to divide this by 2 later
> 				mantissa >>= 1;    // divide by 2
> 				exponent++;        // currently log2 ... will become log4
> 			} else {
> 				/* Exponent is maxed. Trim mantissa and leave. */
> 				mantissa = 2047 ;
> 				break;
> 			}
> 		}
> 		buf[2] = exponent & 0x01;  // activate x2 prescaler if needed
> 		exponent >>= 1;            // now log base 4 (losing LSB)
> 		buf[1] = (exponent << 5) | (mantissa >> 8);

Again, this is really nice work.

But it seems to me that we should simply think about the encoding as
using base-2 with the LSB of the exponent in bit 16. That should make it
easier to follow what's going on here.

I've been thinking about ways of merging the two schemes (both using
base 2), and I even checked if my HXD happened to have a 2-prescaler bit
somewhere as well but I couldn't find one.

It's probably not worth it at this point (and may not end up being more
readable anyway) so I therefore suggest adding a separate function for
the alternate scheme for now. You can just call it at the start of the
"default" function:

	if (spriv->type->alt_divisors)
		return pl2303_encode_baud_rate_divisor_alt(buf, baud);

> 	} else {
> 		while (mantissa >= 512) {
> 			if (exponent < 7) {
> 				mantissa >>= 2; /* divide by 4 */
> 				exponent++;
> 			} else {
> 				/* Exponent is maxed. Trim mantissa and leave. */
> 				mantissa = 511;
> 				break;
> 			}
> 		}
> 		buf[2] = 0;
> 		buf[1] = exponent << 1 | mantissa >> 8;
> 	}
> 
> 	buf[3] = 0x80;
> 	buf[0] = mantissa & 0xff;
> 
> 	/* Calculate and return the exact baud rate. */
> 	baud = (baseline / mantissa / (buf[2] == 0x01 ? 2:1)) >> (exponent << 1);
> 	return baud;
> }
> 
> static void pl2303_encode_baud_rate(struct tty_struct *tty,
> 					struct usb_serial_port *port,
> 					u8 buf[4])
> {
> ....
> 	else
> 		baud = pl2303_encode_baud_rate_divisor(port, buf, baud);
> ....
> }

Johan
