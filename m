Return-Path: <SRS0=NQQO=5E=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BC4C4332D
	for <linux-serial@archiver.kernel.org>; Thu, 19 Mar 2020 05:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B411920714
	for <linux-serial@archiver.kernel.org>; Thu, 19 Mar 2020 05:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgCSFkh (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 19 Mar 2020 01:40:37 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:32963 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgCSFkh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 19 Mar 2020 01:40:37 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id D53B7100B0350;
        Thu, 19 Mar 2020 06:40:34 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 66B0F22429; Thu, 19 Mar 2020 06:40:34 +0100 (CET)
Date:   Thu, 19 Mar 2020 06:40:34 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        matwey.kornilov@gmail.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] serial: 8250: Add rs485 emulation to 8250_dw
Message-ID: <20200319054034.dyq7yydqi6yg7jhf@wunner.de>
References: <20200318142640.982763-1-heiko@sntech.de>
 <20200318144320.GL1922688@smile.fi.intel.com>
 <20200318153754.dctd4q7e2fodeqsw@wunner.de>
 <5640842.EtOnNDtpGh@diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5640842.EtOnNDtpGh@diego>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Mar 18, 2020 at 07:49:08PM +0100, Heiko Stübner wrote:
> Looking at tty-next I notice that you're right. When I started working
> on this I only found the stuff from 2018 I linked to but didn't imagine
> that in that exact moment someone else would also work on that area.

There are some more patches in the pipeline for the next cycle
to add support for an rs485 bus termination GPIO.  They're on
the tip of this branch:

https://github.com/RevolutionPi/linux/commits/revpi-4.19

Just so you know in advance and duplicate work is avoided.


> > The DTR-for-RE thing seems a bit nonstandard, I'm not sure if this is
> > eligible for mainline or if it's something that should be kept in your
> > downstream tree.  But no harm in submitting it to the list.
> 
> I'm fine either way - maybe I also get a pointer on what may be a better
> approach ;-)
> 
> At least DTR as "Data Terminal Ready" did sound somewhat matching for
> the "Receive Enable" of RS485 (and it's also the only other output pin
> in the mctrl gpio list).

Some UARTs allow disabling the receiver, this can be taken advantage of
to implement half-duplex mode.  It's what I did in 8250_bcm2835aux.c.

On the Revolution Pi devices, !RE is usually connected to ground, so
reception is always enabled and it cannot be disabled in software
except by turning off the UART receiver.

There are also boards out there which connect !RE to RTS.  Then only
half-duplex mode is supported by the hardware and there's no way for
software to work around it.

Thanks,

Lukas
