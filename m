Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A87CA0FF8
	for <linux-serial@archiver.kernel.org>; Sat,  2 Sep 2023 04:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbjIBEeb (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 2 Sep 2023 00:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbjIBEea (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 2 Sep 2023 00:34:30 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 46F841702
        for <linux-serial@vger.kernel.org>; Fri,  1 Sep 2023 21:34:27 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 53BEA809C;
        Sat,  2 Sep 2023 04:34:26 +0000 (UTC)
Date:   Sat, 2 Sep 2023 07:34:24 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Matthew Howell <matthew.howell@sealevel.com>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        ryan.wenglarz@sealevel.com, james.olson@sealevel.com
Subject: Re: [PATCH] serial: Revert serial: core: Fix serial core port id to
 not use port->line
Message-ID: <20230902043424.GM11662@atomide.com>
References: <98a891fd-5a1f-6568-a12c-28577126a42@sealevel.com>
 <20230829035245.GF11662@atomide.com>
 <511f2dcf-f637-695-8e81-8eaa3735ba88@sealevel.com>
 <20230829201557.GK11662@atomide.com>
 <472581f-e7f6-6cc-c749-5be16e4fe9af@sealevel.com>
 <20230901044730.GL11662@atomide.com>
 <e8579280-2f44-a585-a3b8-98fad29e6a2d@sealevel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8579280-2f44-a585-a3b8-98fad29e6a2d@sealevel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

* Matthew Howell <matthew.howell@sealevel.com> [230901 18:48]:
> On Fri, 1 Sep 2023, Tony Lindgren wrote:
> > * Matthew Howell <matthew.howell@sealevel.com> [230831 14:58]:
> > > On Tue, 29 Aug 2023, Tony Lindgren wrote:
> > > > If it is a port_id conflict I'm not sure why commit 3d9e6f556e23 is not
> > > > working for your as it has commit a4a79e03bab5 ("serial: core: Revert
> > > > port_id use"). Care to check that again, or maybe try with v6.5 with just
> > > > the commit below reverted?
> > > >
> > > > 04c7f60ca477 ("serial: core: Fix serial core port id, including multiport devices")
> > >
> > > Just tried that, but no difference. Same error.
> > 
> > OK thanks to testing it. So it's starting to look like the issue is
> > somehow related to the serial8250_setup_port() change in commit d962de6ae51f
> > ("serial: core: Fix serial core port id to not use port->line").
> > 
> > The experimental patch below should confirm if the issue is related to the
> > port_id usage or serial8250_setup_port(). Care to give this a try against
> > v6.5 without other patches?
> 
> For some reason I am unable to apply the patch using either git apply or 
> the patch command. I made the change manually though and the issue still 
> occurs.

OK. If the patch did not apply against v6.5, can you please verify you don't
have other patches applied like your revert? I don't think the patch I sent
is white space damanged or anything. Doing git diff v6.5.. should show you
what might be different :)

> > > > Dmesg output might help also to figure out if this happens on the first
> > > > port or the second port.
> > >
> > > The full error in dmesg is:
> > > [Aug30 15:48] exar_serial 0000:04:00.0: Couldn't register serial port 0, irq 24, type 2, error -22
> > >
> > > This is on a 2-port adapter. I don't see any indication in dmesg that it
> > > attempted to register the other port.
> > 
> > OK. Are there other 8520 related uarts probing before that?
> 
> Not that I can see. The only earlier entries I see are from before I load 
> the patched driver. If I add another card in I can see that both are 
> probed, but both have the error:
> 
> [  +0.005929] exar_serial 0000:01:00.0: Couldn't register serial port 0, 
> irq 24, type 2, error -22
> [  +0.003431] exar_serial 0000:04:00.0: Couldn't register serial port 0, 
> irq 25, type 2, error -22
> 
> 04:00.0 is a Sealevel card and the other is a reference Exar XR17V352.

Not sure what you mean with the 8250 entries from before loading the
patched driver..

Maybe things go wrong already somewhere earlier if the integrated 8250
port(s) don't show up either? If so, maybe this issue is somehow machine
specific rather than 8250_exar specific.

Can you please post or email me your full working dmesg output, failing
dmesg output, the kernel .config used, and kernel command line?

Also, do you have any suggestions for a commonly available pcie 8250_exar
card I could try to reproduce this issue with?

Regards,

Tony

