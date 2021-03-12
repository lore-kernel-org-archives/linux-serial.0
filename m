Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AD9C433E6
	for <linux-serial@archiver.kernel.org>; Fri, 12 Mar 2021 13:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19B9964F9F
	for <linux-serial@archiver.kernel.org>; Fri, 12 Mar 2021 13:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbhCLNSj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 12 Mar 2021 08:18:39 -0500
Received: from bee.birch.relay.mailchannels.net ([23.83.209.14]:43426 "EHLO
        bee.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230302AbhCLNSH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 12 Mar 2021 08:18:07 -0500
X-Sender-Id: dreamhost|x-authsender|smtp@contentfirst.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 342F0362A65;
        Fri, 12 Mar 2021 13:18:01 +0000 (UTC)
Received: from pdx1-sub0-mail-a6.g.dreamhost.com (100-96-10-172.trex.outbound.svc.cluster.local [100.96.10.172])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id B2489362A51;
        Fri, 12 Mar 2021 13:18:00 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|smtp@contentfirst.com
Received: from pdx1-sub0-mail-a6.g.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.96.10.172 (trex/6.1.1);
        Fri, 12 Mar 2021 13:18:01 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|smtp@contentfirst.com
X-MailChannels-Auth-Id: dreamhost
X-Eyes-Wiry: 72d2acb9119ca2d8_1615555081019_1656673343
X-MC-Loop-Signature: 1615555081019:3164887426
X-MC-Ingress-Time: 1615555081018
Received: from pdx1-sub0-mail-a6.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a6.g.dreamhost.com (Postfix) with ESMTP id 764AB7E467;
        Fri, 12 Mar 2021 05:18:00 -0800 (PST)
Received: from industrynumbers.com (pool-100-15-209-187.washdc.fios.verizon.net [100.15.209.187])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: smtp@contentfirst.com)
        by pdx1-sub0-mail-a6.g.dreamhost.com (Postfix) with ESMTPSA id DFFAB7FFC7;
        Fri, 12 Mar 2021 05:17:56 -0800 (PST)
Received: from industrynumbers.com (localhost [127.0.0.1])
        by industrynumbers.com (Postfix) with ESMTP id C04C8282A07;
        Fri, 12 Mar 2021 08:17:55 -0500 (EST)
To:     Johan Hovold <johan@kernel.org>
Cc:     Charles Yeh <charlesyeh522@gmail.com>,
        =?UTF-8?B?WWVoLkNoYXJsZXMgW+iRieamrumRq10=?= 
        <charles-yeh@prolific.com.tw>, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, Joe Abbott <jabbott@rollanet.org>
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
 <YEpAaL9QtVMduEpi@hovoldconsulting.com>
X-DH-BACKEND: pdx1-sub0-mail-a6
From:   "Michael G. Katzmann" <michaelk@IEEE.org>
Subject: Re: non-standard baud rates with Prolific 2303 USB-serial
Message-ID: <9d02257d-cca1-116e-634a-6ac952362c5d@IEEE.org>
Date:   Fri, 12 Mar 2021 08:17:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YEpAaL9QtVMduEpi@hovoldconsulting.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 3/11/21 11:08 AM, Johan Hovold wrote:
> I think we should just a new flag for the alternate divisor encoding
> named "alt_divisors" (cf. no_divisors).
>
> Chances are this encoding is used for other types as well.
>
>>         },
>> };
>>
>> static int pl2303_startup(struct usb_serial *serial)
>> {
>> ....
>> 	if ( serial->dev->descriptor.bcdDevice == 0x0300 && serial->dev->descriptor.bcdUSB == 0x0200 )
>> 		type = TYPE_TA;
> This needs to go after the bDeviceClass == 0x02 check, and the 
> descriptor fields need to be accessed using le16_to_cpu().
>
> I've prepared a patch series that clean up and tighten the type
> detection which I suggest you built upon instead.
>
> I'll post the series after replying here.
>
>> 	else if (serial->dev->descriptor.bDeviceClass == 0x02)
>> ....
>> }
>>
>> static speed_t pl2303_encode_baud_rate_divisor( struct usb_serial_port *port,
>> 							unsigned char buf[4],
>> 								speed_t baud)
>> {
>> 	unsigned int baseline, mantissa, exponent;
>> 	struct usb_serial *serial = port->serial;
>> 	struct pl2303_serial_private *spriv = usb_get_serial_data(serial);
>>
>> 	/*
>> 	 * Apparently the formula is:
>> 	 * baudrate = 12M * 32 / (mantissa * 4^exponent)
>> 	 * where
>> 	 *   mantissa = buf[8:0]
>> 	 *   exponent = buf[11:9]
>> 	 *
>> 	 * TA version has more precision
>> 	 *      uses mantissa = buf[bits 10:0 ]
> So you discovered that there were even more bits here? Your first
> version used ten bits, I believe.
>
> I got an offline mail from a third person having problems with the TA
> and who had also verified eleven bits here.

I was basing this on Joe's discovery of the value used for 110 bd by the windows driver (confirmed by Charles). The sequence 80 01 a6 a8 implies that the mantissa is 0x6a8 (i.e. 11 bits). The tests that I did seemed to confirm this.

>> 	 *           exponent = buf[bits 15:13]
>> 	 *  and x2 prescaler enable by buf[bit 16]
>> 	 */
>> 	baseline = 12000000 * 32;
>> 	mantissa = baseline / baud;
>> 	if (mantissa == 0)
>> 		mantissa = 1;    /* Avoid dividing by zero if baud > 32*12M. */
>> 	exponent = 0;
>>
>> 	if (spriv->quirks & PL2303_QUIRK_DIVISOR_TA) {
>> 		while (mantissa >= 2048) {
>> 			// exponent is three bits (after shifting right)
>> 			if (exponent < 15) {   // we are going to divide this by 2 later
>> 				mantissa >>= 1;    // divide by 2
>> 				exponent++;        // currently log2 ... will become log4
>> 			} else {
>> 				/* Exponent is maxed. Trim mantissa and leave. */
>> 				mantissa = 2047 ;
>> 				break;
>> 			}
>> 		}
>> 		buf[2] = exponent & 0x01;  // activate x2 prescaler if needed
>> 		exponent >>= 1;            // now log base 4 (losing LSB)
>> 		buf[1] = (exponent << 5) | (mantissa >> 8);
> Again, this is really nice work.
>
> But it seems to me that we should simply think about the encoding as
> using base-2 with the LSB of the exponent in bit 16. That should make it
> easier to follow what's going on here.

I quite agree. It would be cleaner.


>
> I've been thinking about ways of merging the two schemes (both using
> base 2), and I even checked if my HXD happened to have a 2-prescaler bit
> somewhere as well but I couldn't find one.
>
> It's probably not worth it at this point (and may not end up being more
> readable anyway) so I therefore suggest adding a separate function for
> the alternate scheme for now. You can just call it at the start of the
> "default" function:
>
> 	if (spriv->type->alt_divisors)
> 		return pl2303_encode_baud_rate_divisor_alt(buf, baud);


Pardon my ignorance of the process but where is the git repo for this development branch?

Michael


