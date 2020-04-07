Return-Path: <SRS0=8eBw=5X=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB980C2BA16
	for <linux-serial@archiver.kernel.org>; Tue,  7 Apr 2020 07:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D874206F5
	for <linux-serial@archiver.kernel.org>; Tue,  7 Apr 2020 07:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgDGHjB (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 7 Apr 2020 03:39:01 -0400
Received: from submit-4.e-mind.com ([188.94.192.50]:45684 "EHLO
        submit-4.e-mind.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgDGHjB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 7 Apr 2020 03:39:01 -0400
X-Greylist: delayed 512 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Apr 2020 03:39:00 EDT
Received: from localhost (unknown [127.0.0.1])
        by submit-4.e-mind.com (Postfix) with ESMTP id 7A032840AC4
        for <linux-serial@vger.kernel.org>; Tue,  7 Apr 2020 07:30:26 +0000 (UTC)
Received: from submit-4.e-mind.com ([127.0.0.1])
        by localhost (submit-4.e-mind.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id m2tNJ87xH7yo for <linux-serial@vger.kernel.org>;
        Tue,  7 Apr 2020 09:30:26 +0200 (CEST)
Received: from qmail.e-mind.com (qmail34.e-mind.com [188.94.192.34])
        by submit-4.e-mind.com (Postfix) with SMTP id 806F2840ACE
        for <linux-serial@vger.kernel.org>; Tue,  7 Apr 2020 09:30:20 +0200 (CEST)
Received: (qmail 3614 invoked by uid 0); 7 Apr 2020 07:30:20 -0000
Received: from unknown (HELO ?192.168.143.6?) (185.53.252.165)
  by 0 with SMTP; 7 Apr 2020 07:30:20 -0000
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jslaby@suse.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gianluca Renzi <icjtqr@gmail.com>, dimka@embeddedalley.com,
        linux@rempel-privat.de
From:   gianluca <gianlucarenzi@eurek.it>
Subject: Serial data loss
Message-ID: <960c5054-48b0-fedc-4f3a-7246d84da832@eurek.it>
Date:   Tue, 7 Apr 2020 09:30:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello everybody!

I hope you are keeping safe against Covid-19 a.k.a. Coronavirus!

Now my issue:

I have a BIG trouble having dataloss when using two internal serial 
ports of my boards based on NXP/FreeScale iMX28 SoC ARMv5Te ARM920ej-s 
architecture.

It runs at 454Mhz.

Kernel used 4.9.x

When using my test case unit software between two serial ports connect 
each other by a null modem cable, it fails when the speed rate are 
different, and dataloss is increasing higher the speed rate.

I suppose to have overruns (now I am modifying my software to check them 
too), but I think it is due the way the ISR is called and all data are 
passed to the uart circular buffer within the interrupt routine.

I am talking about the high latency from the IRQ up to the service 
routine when flushing the FIFO and another IRQ is called by another uart 
in the same time at different speed.

The code I was looking is: drivers/tty/serial/mxs-auart.c __but__ all 
other serial drivers are acting in the same way: they are reading one 
character at time from the FIFO (if it exists) and put it into the 
circular buffer so serial/tty driver can pass them to the user read routine.

Each function call has some overhead and it is time-consuming, and if 
another interrupt is invoked by the same UART Core but from another 
serial port (different context) the continuos insertion done by hardware 
UART into the FIFO cannot be served fast enough to have an overrun. I 
think this can be applied __almost__ to every serial driver as they are 
written in the same way.

And it is __NOT__ an issue because of the CPU and its speed! Using two 
serial converter (FTDI and Prolific PL2303 based) on each board, the 
problem does not appear at all even after 24 hours running at more than 
115200!!!

It does work fine if I am using two different serial devices: one 
internal uart (mxs-auart) and an external uart (ttyUSB).

So I can say it is related on how the harwdare is managing the interrupt 
context and the FIFO/buffer small size.

Are those correct assuptions?

Will a shared FIQ driver over the UART solve the issue?

Regards,
-- 
Eurek s.r.l.                          |
Electronic Engineering                | http://www.eurek.it
via Celletta 8/B, 40026 Imola, Italy  | Phone: +39-(0)542-609120
p.iva 00690621206 - c.f. 04020030377  | Fax:   +39-(0)542-609212
