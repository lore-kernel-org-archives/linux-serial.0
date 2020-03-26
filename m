Return-Path: <SRS0=p7su=5L=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66412C2D0E8
	for <linux-serial@archiver.kernel.org>; Thu, 26 Mar 2020 15:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ACBD20775
	for <linux-serial@archiver.kernel.org>; Thu, 26 Mar 2020 15:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgCZPFH (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 26 Mar 2020 11:05:07 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:36561 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbgCZPFG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 26 Mar 2020 11:05:06 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 666051003D021;
        Thu, 26 Mar 2020 16:05:04 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id ED8224389C4; Thu, 26 Mar 2020 16:05:03 +0100 (CET)
Date:   Thu, 26 Mar 2020 16:05:03 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        Heiko Schocher <hs@denx.de>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
        Stefan Wahren <wahrenst@gmx.net>,
        Martin Sperl <kernel@martin.sperl.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-serial@vger.kernel.org
Subject: Re: [PATCH tty-next 1/2] serial: 8250: Fix rs485 delay after console
 write
Message-ID: <20200326150503.2azfdqbuvjgyrqij@wunner.de>
References: <b420d9c3b1c8b0492db55cc6f62076bfd9968b2f.1585224378.git.lukas@wunner.de>
 <20200326144047.GA1403361@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326144047.GA1403361@kroah.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Mar 26, 2020 at 03:40:47PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Mar 26, 2020 at 01:20:15PM +0100, Lukas Wunner wrote:
> > Due to a silly copy-paste mistake, commit 6194c38fc20d ("serial: 8250:
> > Support console on software emulated rs485 ports") erroneously pauses
> > for the duration of delay_rts_before_send after writing to the console,
> > instead of delay_rts_after_send.  Mea culpa.
> > 
> > Fixes: 6194c38fc20d ("serial: 8250: Support console on software emulated rs485 ports")
> 
> Where did this commit id come from?

Stupid me, it came from my downstream branch. :-(
Thanks a lot for double-checking this, will resend.
Sorry for the noise.

Lukas
