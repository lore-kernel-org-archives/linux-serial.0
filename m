Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071B5ECAAD8
	for <linux-serial@archiver.kernel.org>; Wed, 14 Sep 2022 11:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiINLlU (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 14 Sep 2022 07:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiINLlT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Sep 2022 07:41:19 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1BC9145F53
        for <linux-serial@vger.kernel.org>; Wed, 14 Sep 2022 04:41:18 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 43F4D92009C; Wed, 14 Sep 2022 13:41:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 3C75592009B;
        Wed, 14 Sep 2022 12:41:17 +0100 (BST)
Date:   Wed, 14 Sep 2022 12:41:17 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Anders Blomdell <anders.blomdell@control.lth.se>
cc:     Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Subject: Re: kernel 5.19.8: "Oxford Semiconductor Ltd OXPCIe952 Dual Native
 950 UART" gets wrong baudrate (PCI ID 1415:c158)
In-Reply-To: <5921dfd6-384e-b663-f0f7-8471b9e88c29@control.lth.se>
Message-ID: <alpine.DEB.2.21.2209141224370.60554@angie.orcam.me.uk>
References: <ef8fd762-88cf-548a-0599-17d939ad3a57@control.lth.se> <YyA9maUOlPIExIUd@kroah.com> <ff41c70a-767a-45b8-f993-1f70ad3d9254@control.lth.se> <YyB4AtFJx++PeA6S@kroah.com> <7a99a59e-838d-c9da-6ead-167398642c07@control.lth.se> <YyCNOV9no9NPwv8m@kroah.com>
 <e9ca9267-dfee-c7b0-f1ec-4d2b76a05991@control.lth.se> <alpine.DEB.2.21.2209131638550.60554@angie.orcam.me.uk> <3f2d2863-96dd-05d2-4d88-55666fe37bf8@control.lth.se> <alpine.DEB.2.21.2209132254150.60554@angie.orcam.me.uk>
 <5921dfd6-384e-b663-f0f7-8471b9e88c29@control.lth.se>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, 14 Sep 2022, Anders Blomdell wrote:

> [    3.837914] ttyS5: autoconf (0x0000, 0x(____ptrval____)):
> [    3.837918] serial_in(ffffffffb6b98380, 0x01) -> 0x00
> [    3.838041] serial_out(ffffffffb6b98380, 0x01, 0x00)
> [    3.838104] serial_in(ffffffffb6b98380, 0x01) -> 0x00
> [    3.838165] serial_out(ffffffffb6b98380, 0x01, 0x0f)
> [    3.838229] serial_in(ffffffffb6b98380, 0x01) -> 0x0f
> [    3.838290] serial_out(ffffffffb6b98380, 0x01, 0x00)
> [    3.838353] serial_in(ffffffffb6b98380, 0x04) -> 0x00
> [    3.838417] serial_in(ffffffffb6b98380, 0x03) -> 0x00
> [    3.838479] serial_out(ffffffffb6b98380, 0x03, 0xbf)
> [    3.838541] serial_out(ffffffffb6b98380, 0x02, 0x00)
> [    3.838602] serial_out(ffffffffb6b98380, 0x03, 0x00)
> [    3.838667] serial_out(ffffffffb6b98380, 0x02, 0x01)
> [    3.838731] serial_in(ffffffffb6b98380, 0x02) -> 0xc1
> [    3.838791] serial_out(ffffffffb6b98380, 0x03, 0x00)
> [    3.838853] serial_out(ffffffffb6b98380, 0x04, 0x00)
> [    3.838891] serial_out(ffffffffb6b98380, 0x02, 0x01)
> [    3.838891] serial_out(ffffffffb6b98380, 0x02, 0x07)
> [    3.838891] serial_out(ffffffffb6b98380, 0x02, 0x00)
> [    3.838891] serial_in(ffffffffb6b98380, 0x00) -> 0x1d
> [    3.838891] serial_out(ffffffffb6b98380, 0x01, 0x00)
> [    3.839232] iir=193
> [    3.839233] type=16550A
> [    3.839347] 0000:07:00.0: ttyS5 at MMIO 0xe3601200 (irq = 17, base_baud =
> 15625000) is a 16550A
> [    3.839424] serial_out(ffffffffb6b98380, 0x04, 0x80)

 Thank you.  I gather your OxSemi devices are ttyS4 and ttyS5, right?  So 
probing doesn't work for some reason and the port isn't even recognised as 
a 950 device, e.g. I have this for mine:

ttyS0: autoconf (0x0000, 0x(____ptrval____)):
EFRv2
950id=16:c9:50:0d
serial 0000:07:00.3: detected caps 00000700 should be 00000500
iir=193
type=16C950/954
0000:07:00.3: ttyS0 at MMIO 0x60301000 (irq = 26, base_baud = 15625000) is a 16C950/954

I'll examine your I/O conversation log in detail and will see if I can 
come up with a possible explanation.

 NB I'm at the GNU Tools Cauldron conference from tomorrow through this 
coming Monday, so I may not be able to get to the bottom of this issue 
right away.

  Maciej
