Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99589C71153
	for <linux-serial@archiver.kernel.org>; Tue, 29 Aug 2023 20:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239337AbjH2UQR (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 29 Aug 2023 16:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240488AbjH2UQD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 29 Aug 2023 16:16:03 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CFB30DB
        for <linux-serial@vger.kernel.org>; Tue, 29 Aug 2023 13:15:59 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id E0A6C809F;
        Tue, 29 Aug 2023 20:15:58 +0000 (UTC)
Date:   Tue, 29 Aug 2023 23:15:57 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Matthew Howell <matthew.howell@sealevel.com>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        ryan.wenglarz@sealevel.com, james.olson@sealevel.com
Subject: Re: [PATCH] serial: Revert serial: core: Fix serial core port id to
 not use port->line
Message-ID: <20230829201557.GK11662@atomide.com>
References: <98a891fd-5a1f-6568-a12c-28577126a42@sealevel.com>
 <20230829035245.GF11662@atomide.com>
 <511f2dcf-f637-695-8e81-8eaa3735ba88@sealevel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <511f2dcf-f637-695-8e81-8eaa3735ba88@sealevel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

* Matthew Howell <matthew.howell@sealevel.com> [230829 13:42]:
> On Tue, 29 Aug 2023, Tony Lindgren wrote:
> 
> > Hi,
> > 
> > * Matthew Howell <matthew.howell@sealevel.com> [230828 20:41]:
> > > From: Matthew Howell <matthew.howell@sealevel.com>
> > > XR17V35X cards seemingly unable to register serial port. Confirmed on
> > > Sealevel 7202C, 7204EC, and Exar XR17V352 reference board.
> > > dmesg states: "Couldn't register serial port 0, irq 24, type 2, error -22"
> > >
> > > I first identified the problem when I pulled down 6.6-rc1 and I was able
> > > to trace it to d962de6ae51f9b76ad736220077cda83084090b1. I understand that this
> > > commit is noted as being reverted in 1ef2c2df1199, but I was only able to
> > > resolve the issue by reverting d962de6ae51f myself using this patch.
> > 
> > Thanks for the report. Do you maybe mean 6.5-rc1 instead of 6.6-rc1 above?
> 
> Apologies, I meant 6.5, no RC. Specifically, I first found this issue on 
> the v6.5 tag (2dde18cd1d8f). I then rolled back until I traced the issue 
> down to the patch in question (d962de6ae51f). Even more specifically, 
> according to my test notes I tested the following commits, with results as 
> indicated:
> 
> 04c7f60ca477ffbf7b7910320482335050f0d23a -> Not working
> 3d9e6f556e235ddcdc9f73600fdd46fe1736b090 -> Not working
> 3c4f8333b582487a2d1e02171f1465531cde53e3 -> Not working
> a4a79e03bab57729bd8046d22bf3666912e586fb -> Not working
> 1ef2c2df11997b8135f34adcf2c200d3b4aacbe9 -> Not working
> d962de6ae51f9b76ad736220077cda83084090b1 -> Not working
> 282069845af388b08d622ad192b831dcd0549c62 -> Working
> e6d34ced01bc3aaad616b9446bbaa96cd04617c4 -> Working
> 748c5ea8b8796ae8ee80b8d3a3d940570b588d59 -> Working
> 868a9fd9480785952336e5f119e1f75877c423a8 -> Working

OK

> What I can say for certain is that of the commits I have tested: 
> 
> 1) Commits before d962de6ae51f work on the hardware I have tested 
> 2) Commits after d962de6ae51f don't work on the hardware I have tested
> 3) Pulling v6.5 and reverting d962de6ae51f with git revert resolves the 
> issue

OK. To me it seems uart.port.port_id should be always 0 in exar_pci_probe()
and get automatically allocated in serial_base_port_add(). Sounds like this
is not a duplicate port_id issue though but something else as it sounds
like you're not getting duplicate sysfs entry related errors.

If it is a port_id conflict I'm not sure why commit 3d9e6f556e23 is not
working for your as it has commit a4a79e03bab5 ("serial: core: Revert
port_id use"). Care to check that again, or maybe try with v6.5 with just
the commit below reverted?

04c7f60ca477 ("serial: core: Fix serial core port id, including multiport devices")

Dmesg output might help also to figure out if this happens on the first
port or the second port.

Not sure yet where the -22 error here comes from.

Regards,

Tony
