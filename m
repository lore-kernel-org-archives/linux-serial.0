Return-Path: <SRS0=gEyB=IE=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCBBC433E0
	for <linux-serial@archiver.kernel.org>; Sat,  6 Mar 2021 20:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE08D650B1
	for <linux-serial@archiver.kernel.org>; Sat,  6 Mar 2021 20:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhCFUS5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 6 Mar 2021 15:18:57 -0500
Received: from beige.elm.relay.mailchannels.net ([23.83.212.16]:9683 "EHLO
        beige.elm.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230521AbhCFUSw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 6 Mar 2021 15:18:52 -0500
X-Sender-Id: dreamhost|x-authsender|smtp@contentfirst.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 0952392236A;
        Sat,  6 Mar 2021 20:18:50 +0000 (UTC)
Received: from pdx1-sub0-mail-a68.g.dreamhost.com (100-96-10-164.trex.outbound.svc.cluster.local [100.96.10.164])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 090059222C4;
        Sat,  6 Mar 2021 20:18:49 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|smtp@contentfirst.com
Received: from pdx1-sub0-mail-a68.g.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.96.10.164 (trex/6.0.2);
        Sat, 06 Mar 2021 20:18:49 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|smtp@contentfirst.com
X-MailChannels-Auth-Id: dreamhost
X-Illegal-Abortive: 289620ce064447ef_1615061929782_2774275084
X-MC-Loop-Signature: 1615061929782:3515771775
X-MC-Ingress-Time: 1615061929781
Received: from pdx1-sub0-mail-a68.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a68.g.dreamhost.com (Postfix) with ESMTP id BDB627E4B5;
        Sat,  6 Mar 2021 12:18:48 -0800 (PST)
Received: from industrynumbers.com (pool-100-15-209-187.washdc.fios.verizon.net [100.15.209.187])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: smtp@contentfirst.com)
        by pdx1-sub0-mail-a68.g.dreamhost.com (Postfix) with ESMTPSA id C672F7E457;
        Sat,  6 Mar 2021 12:18:46 -0800 (PST)
Received: from industrynumbers.com (localhost [127.0.0.1])
        by industrynumbers.com (Postfix) with ESMTP id 82050282D7A;
        Sat,  6 Mar 2021 15:18:45 -0500 (EST)
Subject: Re: non-standard baud rates with Prolific 2303 USB-serial
X-DH-BACKEND: pdx1-sub0-mail-a68
From:   "Michael G. Katzmann" <michaelk@IEEE.org>
To:     Johan Hovold <johan@kernel.org>,
        Charles Yeh <charlesyeh522@gmail.com>
Cc:     =?UTF-8?B?WWVoLkNoYXJsZXMgW+iRieamrumRq10=?= 
        <charles-yeh@prolific.com.tw>, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, Joe Abbott <jabbott@rollanet.org>
References: <YDPS3AP63/PwmwJU@hovoldconsulting.com>
 <780b9aa6-890d-47fd-d6b2-cd9a39f7634a@IEEE.org>
 <YDUiuLtwRkZ0D0Mi@hovoldconsulting.com>
 <f63df659-6cdf-bba6-f892-1012b98f82e2@IEEE.org>
 <YDUp0tIThOZSTHJt@hovoldconsulting.com>
 <93584ae4-665e-1e67-01e0-cc53f987bee4@IEEE.org>
 <YDUysZY90FfVhrHK@hovoldconsulting.com>
 <CAAZvQQ6F=cQ-EhC0kgeTVM3GrtBWR+HfM6UJWj2AEF1NYZ-vAQ@mail.gmail.com>
 <YDaGRRYrEO5BEJv0@hovoldconsulting.com>
 <CAAZvQQ7+b9=DKqPxgsXxS7Lhqj=QTzKHCMarSbsQkAnYqdO1GA@mail.gmail.com>
 <YEH7okblCx8+Odxn@hovoldconsulting.com>
Message-ID: <3c8b6bca-4f8f-f537-7f88-9815715a7b14@IEEE.org>
Date:   Sat, 6 Mar 2021 15:18:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YEH7okblCx8+Odxn@hovoldconsulting.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 3/5/21 4:36 AM, Johan Hovold wrote:
> On Fri, Mar 05, 2021 at 05:32:23PM +0800, Charles Yeh wrote:
>> 110 bps is not the standard Baud rate,
>> PL2303TA don't work with the current Linux driver (d5 0e 00 80), It
>> needs to "a8 a6 01 80"
> 
> Ok, thanks for confirming. Then we should be able to fix this up based
> on Michael's findings.
> 
>> Johan Hovold <johan@kernel.org> 於 2021年2月25日 週四 上午1:00寫道：
>>
>>> But can you confirm that your PL2303TA works with the current Linux
>>> driver at 110 Bd (and doesn't need the alternate divisor encoding)?
> 
> Johan
> 

How about... altering the call to pl2303_encode_baud_rate_divisor (adding 'port')
       baud = pl2303_encode_baud_rate_divisor(port, buf, baud);

and checking for model and altering algorithm as below.

I've tested this on the TA version.

Michael



static speed_t pl2303_encode_baud_rate_divisor(struct usb_serial_port *port, unsigned char buf[4],
                                speed_t baud)
{
    unsigned int baseline, mantissa, exponent;
        unsigned int bcdDevice = port->serial->dev->descriptor.bcdDevice;
        unsigned int bcdUSB = port->serial->dev->descriptor.bcdUSB;

        enum model { eUNKNOWN, eHXD, eHXA, eTA } model;

   if ( bcdUSB == 0x0110 ) {
       if( bcdDevice == 0x0400 )
           model = eHXD;
       else if ( bcdDevice == 0x0300 )
           model = eHXA; // PL2303HX(A)/XA ( EOL : PHASED OUT SINCE 2012 )
       else
          model = eUNKNOWN;
    } else if( bcdUSB == 0x200 && bcdDevice == 0x0300 ) {
        model = eTA;
    }
    /*
     * Apparently the formula is:
     *   baudrate = 12M * 32 / (mantissa * 4^exponent)
     * where
     *   mantissa = buf[8:0]
     *   exponent = buf[11:9]
         *
         * TA version has more precision
         *      uses mantissa = buf[bits 10:0 ]
     *           exponent = buf[bits 15:13]
     *  and x2 prescaler enable by buf[bit 16]
     */
    baseline = 12000000 * 32;
    mantissa = baseline / baud;
    if (mantissa == 0)
        mantissa = 1;    /* Avoid dividing by zero if baud > 32*12M. */
    exponent = 0;

    if ( model == eTA ) {
        while (mantissa >= 2048) {
            // n.b. below is speculative for the TA chip and is based on original code
            if (exponent < 15) {   // we are going to divide this by 2 later
                mantissa >>= 1;    // divide by 2
                exponent++;        // currently log2 ... will become log4
            } else {
                /* Exponent is maxed. Trim mantissa and leave. */
                mantissa = 2047 ;
                break;
            }
        }
        buf[2] = exponent & 0x01;  // activate x2 prescaler if needed
        exponent >>= 1;            // now log base 4 (losing LSB)
        buf[1] = (exponent << 5) | (mantissa >> 8);
    } else {
        while (mantissa >= 512) {
            if (exponent < 7) {
                mantissa >>= 2; /* divide by 4 */
                exponent++;
            } else {
                /* Exponent is maxed. Trim mantissa and leave. */
                mantissa = 511;
                break;
           }
        }
        buf[2] = 0;
        buf[1] = exponent << 1 | mantissa >> 8;
    }

    buf[3] = 0x80;
    buf[0] = mantissa & 0xff;

    /* Calculate and return the exact baud rate. */
    baud = (baseline / mantissa / (buf[2] == 0x01 ? 2:1)) >> (exponent << 1);
    return baud;
}



