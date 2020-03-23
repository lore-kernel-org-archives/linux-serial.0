Return-Path: <SRS0=3mQv=5I=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF24C4332B
	for <linux-serial@archiver.kernel.org>; Mon, 23 Mar 2020 08:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D2CB2072E
	for <linux-serial@archiver.kernel.org>; Mon, 23 Mar 2020 08:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbgCWI0P convert rfc822-to-8bit (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 23 Mar 2020 04:26:15 -0400
Received: from gloria.sntech.de ([185.11.138.130]:46924 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727451AbgCWI0P (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 Mar 2020 04:26:15 -0400
Received: from ip5f5a5d2f.dynamic.kabel-deutschland.de ([95.90.93.47] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1jGIPH-0001s8-19; Mon, 23 Mar 2020 09:25:59 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        matwey.kornilov@gmail.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] serial: 8250: Add rs485 emulation to 8250_dw
Date:   Mon, 23 Mar 2020 09:25:57 +0100
Message-ID: <6241816.LpgjcNKrfa@diego>
In-Reply-To: <20200319054034.dyq7yydqi6yg7jhf@wunner.de>
References: <20200318142640.982763-1-heiko@sntech.de> <5640842.EtOnNDtpGh@diego> <20200319054034.dyq7yydqi6yg7jhf@wunner.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

Am Donnerstag, 19. März 2020, 06:40:34 CET schrieb Lukas Wunner:
> On Wed, Mar 18, 2020 at 07:49:08PM +0100, Heiko Stübner wrote:
> > Looking at tty-next I notice that you're right. When I started working
> > on this I only found the stuff from 2018 I linked to but didn't imagine
> > that in that exact moment someone else would also work on that area.
> 
> There are some more patches in the pipeline for the next cycle
> to add support for an rs485 bus termination GPIO.  They're on
> the tip of this branch:
> 
> https://github.com/RevolutionPi/linux/commits/revpi-4.19
> 
> Just so you know in advance and duplicate work is avoided.

do you plan on submitting these soonish? Because looking at your
termination-gpio change makes me want to do something similar for
my RE-gpio ... instead of trying to mangle this into the DTR thingy.


> > > The DTR-for-RE thing seems a bit nonstandard, I'm not sure if this is
> > > eligible for mainline or if it's something that should be kept in your
> > > downstream tree.  But no harm in submitting it to the list.
> > 
> > I'm fine either way - maybe I also get a pointer on what may be a better
> > approach ;-)
> > 
> > At least DTR as "Data Terminal Ready" did sound somewhat matching for
> > the "Receive Enable" of RS485 (and it's also the only other output pin
> > in the mctrl gpio list).
> 
> Some UARTs allow disabling the receiver, this can be taken advantage of
> to implement half-duplex mode.  It's what I did in 8250_bcm2835aux.c.
> 
> On the Revolution Pi devices, !RE is usually connected to ground, so
> reception is always enabled and it cannot be disabled in software
> except by turning off the UART receiver.
> 
> There are also boards out there which connect !RE to RTS.  Then only
> half-duplex mode is supported by the hardware and there's no way for
> software to work around it.

yep and on our board we have DE and RE on separate gpios, so I guess
it makes sense to use that pin how it was intended ;-) .

So I guess having that as rs485-re-gpios property might be the best way.


Heiko



