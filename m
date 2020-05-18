Return-Path: <SRS0=kmSd=7A=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443D6C433DF
	for <linux-serial@archiver.kernel.org>; Mon, 18 May 2020 16:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A400207D8
	for <linux-serial@archiver.kernel.org>; Mon, 18 May 2020 16:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgERQN7 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 18 May 2020 12:13:59 -0400
Received: from fieber.vanmierlo.com ([84.243.197.177]:48069 "EHLO
        kerio9.vanmierlo.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727006AbgERQN7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 May 2020 12:13:59 -0400
X-Footer: dmFubWllcmxvLmNvbQ==
Received: from roundcube.vanmierlo.com ([192.168.37.37])
        (authenticated user m.brock@vanmierlo.com)
        by kerio9.vanmierlo.com (Kerio Connect 9.2.12 patch 1) with ESMTPA;
        Mon, 18 May 2020 18:13:16 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 18 May 2020 18:13:16 +0200
From:   Maarten Brock <m.brock@vanmierlo.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heiko Stuebner <heiko@sntech.de>, gregkh@linuxfoundation.org,
        jslaby@suse.com, matwey.kornilov@gmail.com,
        giulio.benetti@micronovasrl.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        linux-serial-owner@vger.kernel.org
Subject: Re: [PATCH v3 3/5] serial: 8250: Support separate rs485 rx-enable
 GPIO
In-Reply-To: <20200518152247.slenjeiiplps7mcd@wunner.de>
References: <20200517215610.2131618-1-heiko@sntech.de>
 <20200517215610.2131618-4-heiko@sntech.de>
 <20200518151241.GG1634618@smile.fi.intel.com>
 <20200518152247.slenjeiiplps7mcd@wunner.de>
Message-ID: <33547f6a596df2ca2ee8e647111e5fa1@vanmierlo.com>
X-Sender: m.brock@vanmierlo.com
User-Agent: Roundcube Webmail/1.3.3
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2020-05-18 17:22, Lukas Wunner wrote:
> On Mon, May 18, 2020 at 06:12:41PM +0300, Andy Shevchenko wrote:
>> On Sun, May 17, 2020 at 11:56:08PM +0200, Heiko Stuebner wrote:
>> > From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
>> >
>> > The RE signal is used to control the duplex mode of transmissions,
>> > aka receiving data while sending in full duplex mode, while stopping
>> > receiving data in half-duplex mode.
>> >
>> > On a number of boards the !RE signal is tied to ground so reception
>> > is always enabled except if the UART allows disabling the receiver.
>> > This can be taken advantage of to implement half-duplex mode - like
>> > done on 8250_bcm2835aux.
>> >
>> > Another solution is to tie !RE to RTS always forcing half-duplex mode.
>> >
>> > And finally there is the option to control the RE signal separately,
>> > like done here by introducing a new rs485-specific gpio that can be
>> > set depending on the RX_DURING_TX setting in the common em485 callbacks.
>> 
>> ...
>> 
>> > +	port->rs485_re_gpio = devm_gpiod_get_optional(dev, "rs485-rx-enable",
>> > +						      GPIOD_OUT_HIGH);
>> 
>> While reviewing some other patch I realized that people are missing 
>> the
>> point of these GPIO flags when pin is declared to be output.
>> 
>> HIGH here means "asserted" (consider active-high vs. active-low in
>> general). Is that the intention here?
>> 
>> Lukas, same question to your patch.
> 
> Yes.  "High", i.e. asserted, means "termination enabled" in the case of
> my patch and "receiver enabled" in the case of Heiko's patch.

But "High" on a gpio would disable the receiver when connected to !RE.

Maarten

