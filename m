Return-Path: <SRS0=7071=4A=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6622BC2BA83
	for <linux-serial@archiver.kernel.org>; Wed, 12 Feb 2020 13:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 389C220661
	for <linux-serial@archiver.kernel.org>; Wed, 12 Feb 2020 13:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbgBLN2g (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 12 Feb 2020 08:28:36 -0500
Received: from bmailout1.hostsharing.net ([83.223.95.100]:57467 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgBLN2g (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 12 Feb 2020 08:28:36 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 6F31430008F11;
        Wed, 12 Feb 2020 14:28:34 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 43BB3154292; Wed, 12 Feb 2020 14:28:34 +0100 (CET)
Date:   Wed, 12 Feb 2020 14:28:34 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>, matthias.bgg@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <mbrugger@suse.com>,
        Scott Branden <sbranden@broadcom.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        jslaby@suse.com
Subject: Re: [PATCH] serial: 8250_early: Add earlycon for BCM2835 aux uart
Message-ID: <20200212132834.c63354wynhmrg6hz@wunner.de>
References: <20200128141958.vwbxoqglt5gw4xj5@wunner.de>
 <C099APQHQAHB.3Q9UVYJYT98TN@linux-9qgx>
 <20200131152414.73tgwsfhzgu4apkx@wunner.de>
 <dfbe2c94dd52a31826be751f8dd9afc4ed08ec6d.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfbe2c94dd52a31826be751f8dd9afc4ed08ec6d.camel@suse.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Feb 03, 2020 at 08:10:21PM +0100, Nicolas Saenz Julienne wrote:
> On Fri, 2020-01-31 at 16:24 +0100, Lukas Wunner wrote:
> > On Thu, Jan 30, 2020 at 05:11:55PM +0100, Nicolas Saenz Julienne wrote:
> > > BTW did you had the oportunity to have a go at the patch?
> > 
> > I've just performed a quick test and it doesn't work for me.
> > If I add stdout-path = "serial1:115200n8"; to the chosen node,
> > I only get a regular console with this patch, not an earlycon.
> 
> That's surprising, you're using u-boot isn't it? and the upstream device tree?

My apologies for the delay.

We boot the kernel directly from the Foundation's bootloader without
U-Boot as intermediary, and we use the downstream DT and kernel
(with RT & custom patches).

As far as I could see, the 8250_bcm2835aux UART wasn't even found
when the kernel searched for available earlycons.  The compatible
string in the DT does match the one in Matthias' patch.

I notice that Greg has already applied the patch to tty/next.
I'm currently stretched a little thin but I'll debug this further
once the dust has settled here.

Thanks,

Lukas
