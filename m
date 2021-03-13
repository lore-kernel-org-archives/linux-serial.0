Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EE9C433E0
	for <linux-serial@archiver.kernel.org>; Sat, 13 Mar 2021 01:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3182C64E5F
	for <linux-serial@archiver.kernel.org>; Sat, 13 Mar 2021 01:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbhCMB2d convert rfc822-to-8bit (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 12 Mar 2021 20:28:33 -0500
Received: from bee.birch.relay.mailchannels.net ([23.83.209.14]:50321 "EHLO
        bee.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229959AbhCMB2L (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 12 Mar 2021 20:28:11 -0500
X-Sender-Id: dreamhost|x-authsender|smtp@contentfirst.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 17D1C702870;
        Sat, 13 Mar 2021 01:28:10 +0000 (UTC)
Received: from pdx1-sub0-mail-a11.g.dreamhost.com (100-101-162-6.trex.outbound.svc.cluster.local [100.101.162.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 9E2BC702986;
        Sat, 13 Mar 2021 01:28:09 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|smtp@contentfirst.com
Received: from pdx1-sub0-mail-a11.g.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.101.162.6 (trex/6.1.1);
        Sat, 13 Mar 2021 01:28:10 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|smtp@contentfirst.com
X-MailChannels-Auth-Id: dreamhost
X-Abortive-Lonely: 6e0e460a7ebd2ce6_1615598889926_1974979722
X-MC-Loop-Signature: 1615598889926:1069352381
X-MC-Ingress-Time: 1615598889926
Received: from pdx1-sub0-mail-a11.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a11.g.dreamhost.com (Postfix) with ESMTP id 5D31D7E582;
        Fri, 12 Mar 2021 17:28:09 -0800 (PST)
Received: from industrynumbers.com (pool-100-15-209-187.washdc.fios.verizon.net [100.15.209.187])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: smtp@contentfirst.com)
        by pdx1-sub0-mail-a11.g.dreamhost.com (Postfix) with ESMTPSA id 9EE917E665;
        Fri, 12 Mar 2021 17:28:05 -0800 (PST)
Received: from industrynumbers.com (localhost [127.0.0.1])
        by industrynumbers.com (Postfix) with ESMTP id 6ABA1282A07;
        Fri, 12 Mar 2021 20:28:04 -0500 (EST)
Subject: Re: non-standard baud rates with Prolific 2303 USB-serial
To:     Johan Hovold <johan@kernel.org>
Cc:     Charles Yeh <charlesyeh522@gmail.com>,
        =?UTF-8?B?WWVoLkNoYXJsZXMgW+iRieamrumRq10=?= 
        <charles-yeh@prolific.com.tw>, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, Joe Abbott <jabbott@rollanet.org>
References: <YDUp0tIThOZSTHJt@hovoldconsulting.com>
 <93584ae4-665e-1e67-01e0-cc53f987bee4@IEEE.org>
 <YDUysZY90FfVhrHK@hovoldconsulting.com>
 <CAAZvQQ6F=cQ-EhC0kgeTVM3GrtBWR+HfM6UJWj2AEF1NYZ-vAQ@mail.gmail.com>
 <YDaGRRYrEO5BEJv0@hovoldconsulting.com>
 <CAAZvQQ7+b9=DKqPxgsXxS7Lhqj=QTzKHCMarSbsQkAnYqdO1GA@mail.gmail.com>
 <YEH7okblCx8+Odxn@hovoldconsulting.com>
 <ddc0e424-21c2-b8f4-1b00-f589267d2b51@IEEE.org>
 <YEpAaL9QtVMduEpi@hovoldconsulting.com>
 <9d02257d-cca1-116e-634a-6ac952362c5d@IEEE.org>
 <YEtwNzhCmvyKhRto@hovoldconsulting.com>
X-DH-BACKEND: pdx1-sub0-mail-a11
From:   "Michael G. Katzmann" <michaelk@IEEE.org>
Message-ID: <a475110e-2f44-eeca-3cd2-dd946e5abfe7@IEEE.org>
Date:   Fri, 12 Mar 2021 20:28:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YEtwNzhCmvyKhRto@hovoldconsulting.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 3/12/21 8:44 AM, Johan Hovold wrote:


Let me try that patch in the right format 8-)


--- a/drivers/usb/serial/pl2303.c    2021-03-12 09:30:22.963992109 -0500
+++ b/drivers/usb/serial/pl2303.c    2021-03-12 20:00:20.003526891 -0500
@@ -188,6 +188,7 @@
     unsigned long quirks;
     unsigned int no_autoxonxoff:1;
     unsigned int no_divisors:1;
+    unsigned int alt_divisors:1;
 };
 
 struct pl2303_serial_private {
@@ -217,10 +218,12 @@
     [TYPE_TA] = {
         .name            = "TA",
         .max_baud_rate        = 6000000,
+        .alt_divisors        = true,
     },
     [TYPE_TB] = {
         .name            = "TB",
         .max_baud_rate        = 12000000,
+        .alt_divisors        = true,
     },
     [TYPE_HXD] = {
         .name            = "HXD",
@@ -618,6 +621,46 @@
     return baud;
 }
 
+static speed_t pl2303_encode_baud_rate_divisor_alt(unsigned char buf[4],
+                                                                speed_t baud)
+{
+        unsigned int baseline, mantissa, exponent;
+
+        /*
+         * Apparently, for the TA version the formula is:
+         *   baudrate = 12M * 32 / (mantissa * 2^exponent)
+         * where
+         *   mantissa = buf[10:0]
+         *   exponent = buf[15:13 16]
+         */
+        baseline = 12000000 * 32;
+        mantissa = baseline / baud;
+        if (mantissa == 0)
+                mantissa = 1;   /* Avoid dividing by zero if baud > 32*12M. */
+        exponent = 0;
+        while (mantissa >= 2048) {
+                if (exponent < 15) {
+                        mantissa >>= 1; /* divide by 2 */
+                        exponent++;
+                } else {
+                        /* Exponent is maxed. Trim mantissa and leave. */
+                        mantissa = 2047;
+                        break;
+                }
+        }
+
+        buf[3] = 0x80;
+        buf[2] = exponent & 0x01; // LS bit of exponent
+        buf[1] = (exponent & ~0x01) << 4 | mantissa >> 8; // 3 bits of the exponent and MS 3 bits of the mantissa
+        buf[0] = mantissa & 0xff; // LS 8 bits of the mantissa
+
+        /* Calculate and return the exact baud rate. */
+        baud = (baseline / mantissa) >> exponent;
+
+        return baud;
+}
+
+
 static void pl2303_encode_baud_rate(struct tty_struct *tty,
                     struct usb_serial_port *port,
                     u8 buf[4])
@@ -645,6 +688,8 @@
 
     if (baud == baud_sup)
         baud = pl2303_encode_baud_rate_direct(buf, baud);
+    else if (spriv->type->alt_divisors)
+                baud = pl2303_encode_baud_rate_divisor_alt(buf, baud);
     else
         baud = pl2303_encode_baud_rate_divisor(buf, baud);

