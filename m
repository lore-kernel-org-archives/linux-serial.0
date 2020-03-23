Return-Path: <SRS0=3mQv=5I=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97663C3F2CD
	for <linux-serial@archiver.kernel.org>; Mon, 23 Mar 2020 13:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76CD420735
	for <linux-serial@archiver.kernel.org>; Mon, 23 Mar 2020 13:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbgCWNRS (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 23 Mar 2020 09:17:18 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:53087 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbgCWNRR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 Mar 2020 09:17:17 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 6AD1F100EF4DC;
        Mon, 23 Mar 2020 14:17:15 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id F291875F0B; Mon, 23 Mar 2020 14:17:14 +0100 (CET)
Date:   Mon, 23 Mar 2020 14:17:14 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        matwey.kornilov@gmail.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] serial: 8250: Add rs485 emulation to 8250_dw
Message-ID: <20200323131714.vmhjws5xpj6yf536@wunner.de>
References: <20200318142640.982763-1-heiko@sntech.de>
 <5640842.EtOnNDtpGh@diego>
 <20200319054034.dyq7yydqi6yg7jhf@wunner.de>
 <6241816.LpgjcNKrfa@diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6241816.LpgjcNKrfa@diego>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Mar 23, 2020 at 09:25:57AM +0100, Heiko Stübner wrote:
> Am Donnerstag, 19. März 2020, 06:40:34 CET schrieb Lukas Wunner:
> > There are some more patches in the pipeline for the next cycle
> > to add support for an rs485 bus termination GPIO.  They're on
> > the tip of this branch:
> > 
> > https://github.com/RevolutionPi/linux/commits/revpi-4.19
> > 
> > Just so you know in advance and duplicate work is avoided.
> 
> do you plan on submitting these soonish? Because looking at your
> termination-gpio change makes me want to do something similar for
> my RE-gpio ... instead of trying to mangle this into the DTR thingy.
[...]
> So I guess having that as rs485-re-gpios property might be the best way.

I plan to submit them once the 5.7 merge window closes, I'll probably
have to go over them at least one more time to apply some polish.

On UARTs capable of disabling and enabling the receiver in software,
it's best to leverage that to enable full-duplex or half-duplex mode.
However after having a brief look at the DW UART databook, it seems
it's not capable of doing that.  For such UARTs, a separate GPIO indeed
seems like a legitimate approach to allow switching between full-duplex
and half-duplex.

"rs485-re-gpios" seems a bit cryptic, how about "rs485-rx-enable-gpios"
or "rs485-full-duplex-gpios"?

Thanks,

Lukas
