Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3B7C54FB9
	for <linux-serial@archiver.kernel.org>; Mon, 20 Nov 2023 07:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjKTHVg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 20 Nov 2023 02:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjKTHVg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 20 Nov 2023 02:21:36 -0500
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E45AA
        for <linux-serial@vger.kernel.org>; Sun, 19 Nov 2023 23:21:31 -0800 (PST)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=07029f9a86=fe@dev.tdt.de>)
        id 1r4yb2-001fXJ-Ou
        for linux-serial@vger.kernel.org; Mon, 20 Nov 2023 08:21:28 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1r4yb2-00BiIv-DW
        for linux-serial@vger.kernel.org; Mon, 20 Nov 2023 08:21:28 +0100
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id 20DBB240049
        for <linux-serial@vger.kernel.org>; Mon, 20 Nov 2023 08:21:28 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id CED55240040;
        Mon, 20 Nov 2023 08:21:27 +0100 (CET)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
        by mail.dev.tdt.de (Postfix) with ESMTP id 45E06224A7;
        Mon, 20 Nov 2023 08:21:27 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 20 Nov 2023 08:21:27 +0100
From:   Florian Eckert <fe@dev.tdt.de>
To:     Lee Jones <lee@kernel.org>
Cc:     m.brock@vanmierlo.com, Eckert.Florian@googlemail.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org, pavel@ucw.cz,
        kabel@kernel.org, u.kleine-koenig@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [Patch v8 6/6] leds: ledtrig-tty: add additional line state
 evaluation
In-Reply-To: <20231117121253.GB137434@google.com>
References: <20231109085038.371977-1-fe@dev.tdt.de>
 <20231109085038.371977-7-fe@dev.tdt.de>
 <39e7c892299c74821b1105a0967063ca@vanmierlo.com>
 <20231117121253.GB137434@google.com>
Message-ID: <bc369f8759778c2c3b8be3a5d755064a@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate: clean
X-purgate-type: clean
X-purgate-ID: 151534::1700464888-4E731C7C-0DC7C91F/0/0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 2023-11-17 13:12, Lee Jones wrote:
> On Thu, 09 Nov 2023, m.brock@vanmierlo.com wrote:
> 
>> Florian Eckert schreef op 2023-11-09 09:50:
>> > The serial tty interface also supports additional input signals, that
>> > can also be evaluated within this trigger. This change is adding the
>> > following additional input sources, which could be controlled
>> > via the '/sys/class/<leds>/' sysfs interface.
>> >
>> > Explanation:
>> > DCE = Data Communication Equipment (Modem)
>> > DTE = Data Terminal Equipment (Computer)
>> >
>> > - cts:
>> >   DCE is ready to accept data from the DTE (CTS = Clear To Send). If
>> >   the line state is detected, the LED is switched on.
>> >   If set to 0 (default), the LED will not evaluate CTS.
>> >   If set to 1, the LED will evaluate CTS.
>> >
>> > - dsr:
>> >   DCE is ready to receive and send data (DSR = Data Set Ready). If the
>> >   line state is detected, the LED is switched on.
>> >   If set to 0 (default), the LED will not evaluate DSR.
>> >   If set to 1, the LED will evaluate DSR.
>> >
>> > - dcd:
>> >   DTE is receiving a carrier from the DCE (DCD = Data Carrier Detect).
>> >   If the line state is detected, the LED is switched on.
>> >   If set to 0 (default), the LED will not evaluate DCD.
>> >   If set to 1, the LED will evaluate DCD.
>> >
>> > - rng:
>> >   DCE has detected an incoming ring signal on the telephone line
>> >   (RNG = Ring Indicator). If the line state is detected, the LED is
>> >   switched on.
>> >   If set to 0 (default), the LED will not evaluate RNG.
>> >   If set to 1, the LED will evaluate RNG.
>> >
>> > Also add an invert flag on LED blink, so that the LED blinks in the
>> > correct order.
>> >
>> > * If one off the new enabled input signals are evaluatet as 'enabled',
>> >   and data are transmitted, then the LED should first blink 'off' and
>> >   then 'on' (invert).
>> > * If all the new enabled input signals are evaluatet as 'disabled',
>> >   and data are transmitted, then the LED should first blink 'on' and
>> >   then 'off'.
>> >
>> > Signed-off-by: Florian Eckert <fe@dev.tdt.de>
>> > ---
>> >  .../ABI/testing/sysfs-class-led-trigger-tty   | 40 ++++++++++
>> >  drivers/leds/trigger/ledtrig-tty.c            | 77 ++++++++++++++++++-
>> >  2 files changed, 116 insertions(+), 1 deletion(-)
> 
> [...]
> 
>> Reviewed-by: Maarten Brock <m.brock@vanmierlo.com>
> 
> Please snip your replies.

Is there anything I can do? Or do I have to do something? Please give me 
more detailed instructions
