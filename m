Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD292ECAAD3
	for <linux-serial@archiver.kernel.org>; Wed, 14 Sep 2022 14:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiINOQQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 14 Sep 2022 10:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiINOQA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Sep 2022 10:16:00 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0D2D69F57
        for <linux-serial@vger.kernel.org>; Wed, 14 Sep 2022 07:15:53 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 8234492009D; Wed, 14 Sep 2022 16:15:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 7D2B192009C;
        Wed, 14 Sep 2022 15:15:52 +0100 (BST)
Date:   Wed, 14 Sep 2022 15:15:52 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Anders Blomdell <anders.blomdell@control.lth.se>
cc:     Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Subject: Re: kernel 5.19.8: "Oxford Semiconductor Ltd OXPCIe952 Dual Native
 950 UART" gets wrong baudrate (PCI ID 1415:c158)
In-Reply-To: <alpine.DEB.2.21.2209141224370.60554@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2209141456460.60554@angie.orcam.me.uk>
References: <ef8fd762-88cf-548a-0599-17d939ad3a57@control.lth.se> <YyA9maUOlPIExIUd@kroah.com> <ff41c70a-767a-45b8-f993-1f70ad3d9254@control.lth.se> <YyB4AtFJx++PeA6S@kroah.com> <7a99a59e-838d-c9da-6ead-167398642c07@control.lth.se> <YyCNOV9no9NPwv8m@kroah.com>
 <e9ca9267-dfee-c7b0-f1ec-4d2b76a05991@control.lth.se> <alpine.DEB.2.21.2209131638550.60554@angie.orcam.me.uk> <3f2d2863-96dd-05d2-4d88-55666fe37bf8@control.lth.se> <alpine.DEB.2.21.2209132254150.60554@angie.orcam.me.uk> <5921dfd6-384e-b663-f0f7-8471b9e88c29@control.lth.se>
 <alpine.DEB.2.21.2209141224370.60554@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, 14 Sep 2022, Maciej W. Rozycki wrote:

> I'll examine your I/O conversation log in detail and will see if I can 
> come up with a possible explanation.

 I think I know what is going on here.  Can you please confirm that you 
have the CONFIG_SERIAL_8250_16550A_VARIANTS option disabled (default to 
"off" for x86 only)?  That would explain things.

 Offhand I am not sure what to do here.  There are several options to 
choose from I can think of right now:

1. Disable new OxSemi Tornado clock code iff !SERIAL_8250_16550A_VARIANTS, 
   bringing back buggy calculation for rates above 115200bps and coarse 
   BOTHER granularity.

2. Same as above, but additionally limit the baud rates to 115200bps to 
   avoid buggy rates.

3. Force SERIAL_8250_16550A_VARIANTS to "y" if SERIAL_8250_PCI != "n". 

4. Remove SERIAL_8250_16550A_VARIANTS altogether and execute code it 
   guards unconditionally (does it still matter nowadays?).

5. Something else not yet determined.

 Greg, do you have any opinion?

  Maciej
