Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A30ECAAD8
	for <linux-serial@archiver.kernel.org>; Tue, 13 Sep 2022 17:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbiIMRbQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 13 Sep 2022 13:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbiIMRal (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 13 Sep 2022 13:30:41 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C97CEB858
        for <linux-serial@vger.kernel.org>; Tue, 13 Sep 2022 09:19:37 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id AD37392009D; Tue, 13 Sep 2022 18:19:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id AA09E92009C;
        Tue, 13 Sep 2022 17:19:27 +0100 (BST)
Date:   Tue, 13 Sep 2022 17:19:27 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Anders Blomdell <anders.blomdell@control.lth.se>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Subject: Re: kernel 5.19.8: "Oxford Semiconductor Ltd OXPCIe952 Dual Native
 950 UART" gets wrong baudrate (PCI ID 1415:c158)
In-Reply-To: <e9ca9267-dfee-c7b0-f1ec-4d2b76a05991@control.lth.se>
Message-ID: <alpine.DEB.2.21.2209131638550.60554@angie.orcam.me.uk>
References: <ef8fd762-88cf-548a-0599-17d939ad3a57@control.lth.se> <YyA9maUOlPIExIUd@kroah.com> <ff41c70a-767a-45b8-f993-1f70ad3d9254@control.lth.se> <YyB4AtFJx++PeA6S@kroah.com> <7a99a59e-838d-c9da-6ead-167398642c07@control.lth.se> <YyCNOV9no9NPwv8m@kroah.com>
 <e9ca9267-dfee-c7b0-f1ec-4d2b76a05991@control.lth.se>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Anders,

 Sorry to cause you trouble.

> > I really don't know what to do here, sorry.  Are you saying a specific
> > commit has broken this?  If so, did you test if you made a change it
> > fixed the issue?
> 
> Yes, commit 366f6c955d4d1a5125ffcd6875ead26a3c7a2a1c broke the one to one
> correspondence
> between programmed and actual baudrate; reverting it (and
> 9c5c8aaed50bf3478073ab51b8b1f3f5327d3cfa
> that builds on that patch) restores the expected functionality (i.e. you get
> the baudrate you ask for)
> on 5.19.8.

 I have implemented the calculation using parameters from original OxSemi 
datasheets and verified this code across three architectures available to 
me (POWER9, RISC-V, 32-bit x86) and a couple of cards made by different 
manufacturers connected to a non-OxSemi serial device each at the other 
end.  I have checked the usual baud rates of up to 460800bps.  Higher baud 
rates work too, though I could only try them between OxSemi devices, so 
actual rates were not verified for correctness.

 And offhand I can say it works just fine at 230400bps with 6.0.0-rc2 as 
at commit 10d4879f9ef0 and my RISC-V machine (using an EXSYS EX-44171 
1S+1P port PCIe option card, built around the OXPCIe952 too) talking to a 
remote console server in my lab.  I don't have an oscilloscope available 
to check actual waveforms produced.

> > What do you suggest happen here?
> Either there is a bug in the code, or the chipset on my card (a Delock 2xRS232
> card) is not a true oxford
> chipset (the package and PCI id's says that they are).

 A bug can never be ruled out.  I doubt that Delock would use a fake chip 
or indeed that anyone would choose to clone an OxSemi part, which seems 
fairly complex to me for a serial port.

> Since the chip seems to be discontinued since 2014 (see
> https://www.mouser.com/PCN/PLX_Technology_2013_8.pdf),
> I think a revert would not be uncalled for.

 The problem is the original calculation is inaccurate enough for the 
serial interface not to communicate correctly at higher baud rates.  I 
found setting two stop bits while talking to a remote end that has one 
stop bit set a possible workaround for some cases, but why not do the 
calculation correctly in the first place?

 If you're willing to debug it, then I'll be more than happy to supply you 
with diagnostic patches, some of which I made in the development of the 
fix.  Also what processor architecture do you use the interface with?

  Maciej
