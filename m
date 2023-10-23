Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA6ECDB474
	for <linux-serial@archiver.kernel.org>; Mon, 23 Oct 2023 12:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjJWMqC (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 23 Oct 2023 08:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjJWMqB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 Oct 2023 08:46:01 -0400
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C5FCC
        for <linux-serial@vger.kernel.org>; Mon, 23 Oct 2023 05:45:58 -0700 (PDT)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=9674b5d38b=fe@dev.tdt.de>)
        id 1quuJg-005dVm-Dp
        for linux-serial@vger.kernel.org; Mon, 23 Oct 2023 14:45:56 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1quuJg-001WBm-2G
        for linux-serial@vger.kernel.org; Mon, 23 Oct 2023 14:45:56 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id C1665240049
        for <linux-serial@vger.kernel.org>; Mon, 23 Oct 2023 14:45:55 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id 822CD240040;
        Mon, 23 Oct 2023 14:45:55 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
        by mail.dev.tdt.de (Postfix) with ESMTP id 19EB221272;
        Mon, 23 Oct 2023 14:45:55 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 23 Oct 2023 14:45:55 +0200
From:   Florian Eckert <fe@dev.tdt.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Eckert.Florian@googlemail.com, jirislaby@kernel.org, pavel@ucw.cz,
        lee@kernel.org, kabel@kernel.org, u.kleine-koenig@pengutronix.de,
        m.brock@vanmierlo.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v5 2/2] leds: ledtrig-tty: add new line mode evaluation
In-Reply-To: <2023102320-princess-issuing-be13@gregkh>
References: <20231023094205.2706812-1-fe@dev.tdt.de>
 <20231023094205.2706812-3-fe@dev.tdt.de>
 <2023102341-jogger-matching-dded@gregkh>
 <7e8860574413505c314bdfd0f3e10188@dev.tdt.de>
 <2023102320-princess-issuing-be13@gregkh>
Message-ID: <c4398f09d5a07672ad77f2100ccae0f4@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate: clean
X-purgate-type: clean
X-purgate-ID: 151534::1698065156-DE7BE1F7-B34D0755/0/0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 2023-10-23 14:27, Greg KH wrote:
> On Mon, Oct 23, 2023 at 02:15:55PM +0200, Florian Eckert wrote:
>> > Again, I thought we had rx/tx already?  If not, how was that controlled
>> > today?
>> 
>> It could not be controlled! The LED flashed when data where 
>> transferred.
>> This was the only function that the trigger supported.
> 
> Ok, then maybe this needs to be a bit longer of a series.  One that 
> does
> the "tx/rx" feature, as that is needed today, and will be the more
> complex one, and then one-per-line-setting that you want to apply.
> 
> That should make it much easier to review overall, right?

Sorry for asking, but why should I split the change.
What is the added value? But if it is necessary, then I will do it.

Before my change, the trigger could not be configured.
The LED always flashed when data was transferred.
Now I can configure for which tty event the LED should flash or be 
on/off.
So that the trigger behaves the same as before (flash on rx/tx 
transmission),
I set the rx/tx bits in the function ledtrig_tty_activate() with the
following code. Nothing changes for the user of the trigger.

/* Enable default rx/tx LED blink */
set_bit(TRIGGER_TTY_TX, &trigger_data->ttytrigger);
set_bit(TRIGGER_TTY_RX, &trigger_data->ttytrigger);

---
Florian
