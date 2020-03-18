Return-Path: <SRS0=ll96=5D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7C1C10F29
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 18:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0960D20754
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 18:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgCRStR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 Mar 2020 14:49:17 -0400
Received: from gloria.sntech.de ([185.11.138.130]:39054 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbgCRStR (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Mar 2020 14:49:17 -0400
Received: from ip5f5a5d2f.dynamic.kabel-deutschland.de ([95.90.93.47] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1jEdkb-0005cf-6S; Wed, 18 Mar 2020 19:49:09 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        matwey.kornilov@gmail.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] serial: 8250: Add rs485 emulation to 8250_dw
Date:   Wed, 18 Mar 2020 19:49:08 +0100
Message-ID: <5640842.EtOnNDtpGh@diego>
In-Reply-To: <20200318153754.dctd4q7e2fodeqsw@wunner.de>
References: <20200318142640.982763-1-heiko@sntech.de> <20200318144320.GL1922688@smile.fi.intel.com> <20200318153754.dctd4q7e2fodeqsw@wunner.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

Am Mittwoch, 18. März 2020, 16:37:54 CET schrieb Lukas Wunner:
> On Wed, Mar 18, 2020 at 04:43:20PM +0200, Andy Shevchenko wrote:
> > On Wed, Mar 18, 2020 at 03:26:33PM +0100, Heiko Stuebner wrote:
> > > This series tries to revive the work of Giulio Benetti from 2018 [0]
> > > which seemed to have stalled at that time.
> 
> Oh dear. :-(  This needs a rebase on current tty-next.

Looking at tty-next I notice that you're right. When I started working
on this I only found the stuff from 2018 I linked to but didn't imagine
that in that exact moment someone else would also work on that area.

So no worries, I'll adapt my code ;-)


> Patch [7/7] is already in tty-next as commit fe7f0fa43cef ("serial:
> 8250: Support rs485 devicetree properties").
>
> Patch [4/7] likewise.  Note that it's not safe to call ->rs485_config()
> already in serial8250_register_8250_port() if the driver uses UPF_IOREMAP
> because ioremapping happens later via serial8250_config_port() ->
> serial8250_request_std_resource(), so you'll get an oops for those
> drivers when deasserting RTS early on.  Been there... :-(
> 
> Patch [6/7]:  Ugh, another duplication of the ->rs485_config() callback.
> Just use the generic one introduced by commit 283e096ffb70 ("serial:
> 8250: Deduplicate ->rs485_config() callback") if possible.
> 
> The other patches appear to handle chip-specific needs.  It's now
> possible to implement these in ->rs485_start_tx() and ->rs485_stop_tx()
> hooks, as introduced by commit 058bc104f7ca ("serial: 8250: Generalize
> rs485 software emulation").  Refer to commit f93bf7589114 ("serial:
> 8250_bcm2835aux: Support rs485 software emulation") for an example.

Thanks for the pointers and also doing all that ground work :-)


> The DTR-for-RE thing seems a bit nonstandard, I'm not sure if this is
> eligible for mainline or if it's something that should be kept in your
> downstream tree.  But no harm in submitting it to the list.

I'm fine either way - maybe I also get a pointer on what may be a better
approach ;-)

At least DTR as "Data Terminal Ready" did sound somewhat matching for
the "Receive Enable" of RS485 (and it's also the only other output pin
in the mctrl gpio list).


Heiko


