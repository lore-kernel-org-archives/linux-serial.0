Return-Path: <SRS0=ll96=5D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E734C5ACD9
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 15:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F2720724
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 15:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgCRPh4 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 Mar 2020 11:37:56 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:59691 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgCRPh4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Mar 2020 11:37:56 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 9A356100DEC95;
        Wed, 18 Mar 2020 16:37:54 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 1CCF56052; Wed, 18 Mar 2020 16:37:54 +0100 (CET)
Date:   Wed, 18 Mar 2020 16:37:54 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        matwey.kornilov@gmail.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] serial: 8250: Add rs485 emulation to 8250_dw
Message-ID: <20200318153754.dctd4q7e2fodeqsw@wunner.de>
References: <20200318142640.982763-1-heiko@sntech.de>
 <20200318144320.GL1922688@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318144320.GL1922688@smile.fi.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Mar 18, 2020 at 04:43:20PM +0200, Andy Shevchenko wrote:
> On Wed, Mar 18, 2020 at 03:26:33PM +0100, Heiko Stuebner wrote:
> > This series tries to revive the work of Giulio Benetti from 2018 [0]
> > which seemed to have stalled at that time.

Oh dear. :-(  This needs a rebase on current tty-next.

Patch [7/7] is already in tty-next as commit fe7f0fa43cef ("serial:
8250: Support rs485 devicetree properties").

Patch [4/7] likewise.  Note that it's not safe to call ->rs485_config()
already in serial8250_register_8250_port() if the driver uses UPF_IOREMAP
because ioremapping happens later via serial8250_config_port() ->
serial8250_request_std_resource(), so you'll get an oops for those
drivers when deasserting RTS early on.  Been there... :-(

Patch [6/7]:  Ugh, another duplication of the ->rs485_config() callback.
Just use the generic one introduced by commit 283e096ffb70 ("serial:
8250: Deduplicate ->rs485_config() callback") if possible.

The other patches appear to handle chip-specific needs.  It's now
possible to implement these in ->rs485_start_tx() and ->rs485_stop_tx()
hooks, as introduced by commit 058bc104f7ca ("serial: 8250: Generalize
rs485 software emulation").  Refer to commit f93bf7589114 ("serial:
8250_bcm2835aux: Support rs485 software emulation") for an example.

The DTR-for-RE thing seems a bit nonstandard, I'm not sure if this is
eligible for mainline or if it's something that should be kept in your
downstream tree.  But no harm in submitting it to the list.

Thanks,

Lukas
