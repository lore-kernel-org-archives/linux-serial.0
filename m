Return-Path: <SRS0=jHyV=6T=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCDCC47254
	for <linux-serial@archiver.kernel.org>; Tue,  5 May 2020 16:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 267EA20746
	for <linux-serial@archiver.kernel.org>; Tue,  5 May 2020 16:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbgEEQjh (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 5 May 2020 12:39:37 -0400
Received: from fieber.vanmierlo.com ([84.243.197.177]:51738 "EHLO
        kerio9.vanmierlo.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729488AbgEEQjh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 5 May 2020 12:39:37 -0400
X-Footer: dmFubWllcmxvLmNvbQ==
Received: from roundcube.vanmierlo.com ([192.168.37.37])
        (authenticated user m.brock@vanmierlo.com)
        by kerio9.vanmierlo.com (Kerio Connect 9.2.12 patch 1) with ESMTPA;
        Tue, 5 May 2020 18:38:54 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 05 May 2020 18:38:54 +0200
From:   Maarten Brock <m.brock@vanmierlo.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Heiko Stuebner <heiko@sntech.de>, gregkh@linuxfoundation.org,
        jslaby@suse.com, andriy.shevchenko@linux.intel.com,
        matwey.kornilov@gmail.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com,
        giulio.benetti@micronovasrl.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        linux-serial-owner@vger.kernel.org
Subject: Re: [PATCH v2 4/7] serial: 8250: Handle implementations not having
 TEMT interrupt using em485
In-Reply-To: <20200502134927.6sb7f3na3ff3rpoa@wunner.de>
References: <20200325231422.1502366-1-heiko@sntech.de>
 <20200325231422.1502366-5-heiko@sntech.de>
 <20200502134927.6sb7f3na3ff3rpoa@wunner.de>
Message-ID: <523d8e3fa0215f34532b7990a31b0c17@vanmierlo.com>
X-Sender: m.brock@vanmierlo.com
User-Agent: Roundcube Webmail/1.3.3
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2020-05-02 15:49, Lukas Wunner wrote:
> On Thu, Mar 26, 2020 at 12:14:19AM +0100, Heiko Stuebner wrote:
>> Some 8250 ports have a TEMT interrupt but it's not a part of the 8250
>> standard, instead only available on some implementations.
>> 
>> The current em485 implementation does not work on ports without it.
>> The only chance to make it work is to loop-read on LSR register.
>> 
>> So add UART_CAP_TEMT to mark 8250 uarts having this interrupt,
>> update all current em485 users with that capability and make
>> the stop_tx function loop-read on uarts not having it.
> 
> Just to get a better understanding:  According to the 
> Dw_apb_uart_db.pdf
> databook I've found, the UART does have a "THR empty" interrupt.  So 
> you
> get an interrupt once the Transmit Holding Register (and by consequence
> the FIFO) has been drained.  Then what do you need a TEMT interrupt 
> for?
> Why is the THR interrupt not sufficient?

When the Transmit Holding Register is empty, the Transmitter can still 
be
transmitting. And the Driver Enable must be held active during 
transmission.
I would even say it needs to held active during transmission of the stop 
bit,
but I don't believe there is any uart that has an interrupt flag for 
that.
And since the default state for RS485 is '1' anyway it's not that bad.

Maarten

