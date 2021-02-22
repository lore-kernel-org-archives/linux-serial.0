Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDCFC433E9
	for <linux-serial@archiver.kernel.org>; Mon, 22 Feb 2021 08:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB22F64E77
	for <linux-serial@archiver.kernel.org>; Mon, 22 Feb 2021 08:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhBVIwu (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 22 Feb 2021 03:52:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:42290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229987AbhBVIwt (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Feb 2021 03:52:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D7A3E64E61;
        Mon, 22 Feb 2021 08:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613983928;
        bh=cJx7sjeugxiS1sTrBbus/KCu4bc4qQgQDDhs1zj1V2M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fmQT4K8ay59bCkmT4RBqVmuNrM59MZD/LvFpTLtCz7y44H98tOwevTwO/BERrH91d
         fx+1ku8D5pINr9iWkNZNkW1hucpyx1s66bnPdmj4aOyDb7fmTAPv3TY0l/DBD4bwCu
         w2N8S0+hCp5nyTGw8rXCiTtD2Lwu1W/kUONfieuths5uCexoPubL3JE85PIySHcxLV
         UEdAeDLsP0a80DFBQ0auOEPVxtdJz2HF+iz1cf/mCrWt/Oiu8xt/iDVhCnWxhbrBgU
         snk1caZC5zMvomyODFnCJqJTbBh5JaRjNrAZNmiYTRozKQVE+oerbjMt0GQU50zBg3
         Eg9X3LBMLN59g==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lE6x4-0001Sd-4v; Mon, 22 Feb 2021 09:52:23 +0100
Date:   Mon, 22 Feb 2021 09:52:22 +0100
From:   Johan Hovold <johan@kernel.org>
To:     "Michael G. Katzmann" <michaelk@IEEE.org>,
        charles-yeh@prolific.com.tw
Cc:     linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        Charles Yeh <charlesyeh522@gmail.com>,
        Joe Abbott <jabbott@rollanet.org>
Subject: Re: non-standard baud rates with Prolific 2303 USB-serial
Message-ID: <YDNwxtDxd7JntAXt@hovoldconsulting.com>
References: <3aee5708-7961-f464-8c5f-6685d96920d6@IEEE.org>
 <dc3458f1-830b-284b-3464-20124dc3900a@IEEE.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc3458f1-830b-284b-3464-20124dc3900a@IEEE.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Feb 21, 2021 at 09:15:06PM -0500, Michael G. Katzmann wrote:
> 
> So on more investigation and many hours of trial and error I have
> determined the correct formua for the non-standard rates with this
> Prolific 2303.
>
> There are four bytes used to send the baud rate. When not using the
> 'standard' rates, the Linus driver sets byte 3 to 0x80 and bytes 1 and
> 0 hold the divisor of the clock (12MHz * 32).
> This divisor is encoded in a special way. The 'exponent' (log 4) and
> the mantissa. This is calculated by dividing the divisor by 4 until it
> is less than 512 (the number of times you can do this is the
> exponent). e then goes in bits 1,2 and 3 of byte 1 with the MSBit of
> the mantissa in bit 0 of byte 1. Byte 0 holds the lower 8 bits of the
> mantissa.
> 
> This does not work on the device I have USB PID/VID/REV is 0673 /
> 2303/3.00. Instead...the calculation uses 1024 instead of 512 in the
> method above and the exponent is in byte 1 bits 7,6&5 (the top 2 bits
> of the mantissa are in bits 0 and 1).  I tested this on all baud rates
> that stty will allow that are not 'standard' and it works. (50, 110
> .... 3000000).
> 
> The changed routine is below. I presume the original driver worked so
> perhaps this device is a new variant with the same USB VID/PID.

Nice work!

Joe Abbott reported a similar issue (incidentally also when trying to
use an ASR33) a few weeks ago and concluded that the Windows driver
uses a different encoding:

	https://lore.kernel.org/r/CADuz4ONmN299aw460r4wXCEK5F1v9kt_cewCCrdg2hb5nJV9uQ@mail.gmail.com

His device also had a bcdDevice of 0x0300 as yours (even if I believe
his fell back to 9600 baud).

Does your updated algorithm also result in 110 baud (8n1) being encoded
as:

	a8 a6 01 80 00 02 07

And are you using some official Prolific Windows driver or something
that came with the device?

I tried asking Prolific about this but I'm still not sure whether these
are official chips or counterfeit. 0x0300 is supposed to be a PL2303TA
and Prolific claims that the current driver is working fine with these
so we'd need to key off something more than just bcdDevice.

Charles, here's another device that appears to use a different baudrate
encoding. Does this mean it's not one of your devices or how can we
detect when to use the alternate encoding?

> static speed_t pl2303_encode_baud_rate_divisor(unsigned char buf[4],
>                                 speed_t baud)
> {
>     unsigned int baseline, mantissa, exponent;
>     /*
>      * Apparently the formula is:
>      *   baudrate = 12M * 32 / (mantissa * 4^exponent)
>      * where
>      *   mantissa = buf[8:0]
>      *   exponent = buf[11:9]
>          *
>          * Michael Katzmann: At least versions of the chip VID 0x067b PID 0x2303 bcdDevice 3.00
>          *                   uses mantissa = buf[9:0]
>      *                        exponent = buf[15:13]
>      */
>     baseline = 12000000 * 32;
>     mantissa = baseline / baud;
>     if (mantissa == 0)
>         mantissa = 1;    /* Avoid dividing by zero if baud > 32*12M. */
>     exponent = 0;
> #undef ORIGINAL
> #ifdef ORIGINAL
>     while (mantissa >= 512) {
>         if (exponent < 7) {
>             mantissa >>= 2;    /* divide by 4 */
>             exponent++;
>         } else {
>             /* Exponent is maxed. Trim mantissa and leave. */
>             mantissa = 511;
>             break;
>         }
>     }
>     buf[3] = 0x80;
>     buf[2] = 0;
>     buf[1] = exponent << 1 | mantissa >> 8;
>     buf[0] = mantissa & 0xff;
> #else
>     while (mantissa >= 1024) {
>         if (exponent < 7) {
>             mantissa >>= 2;    /* divide by 4 */
>             exponent++;
>         } else {
>             // This is an logical modification of the original code
>                         // but I do not know if this an actual limitation
>             /* Exponent is maxed. Trim mantissa and leave. */
>             mantissa = 1023 ;
>             break;
>         }
>     }
>     buf[3] = 0x80;
>     buf[2] = 0;
>     buf[1] = exponent << 5 | (mantissa >> 8);
>     buf[0] = mantissa & 0xff;
> #endif
>     /* Calculate and return the exact baud rate. */
>     baud = (baseline / mantissa) >> (exponent << 1);
> 
>     return baud;
> }
> 
> 
> On 2/21/21 10:37 AM, Michael G. Katzmann wrote:
> > The Linux driver does not seem to produce sensible baud rated for
> > other than the 'supported' rates.
> >
> > stty to 110 bd results in ~95,000 bd (that's not a typo but 95
> > thousand). Other rates like 200 also produce odd speeds although not
> > in a logical manner.
> >
> > The data sheets don't describe the formula used for deriving the
> > four bytes used to set the speed.
> >
> > I tried adding 110 to the supported rates but this did not produce
> > the correct baud rate so I presume the Windows driver is using a
> > formula different than the one in the Linux driver for 'non
> > standard' baud rates.
> >

Johan
