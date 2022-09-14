Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9D2ECAAD8
	for <linux-serial@archiver.kernel.org>; Wed, 14 Sep 2022 00:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiINAA1 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 13 Sep 2022 20:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiINAA0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 13 Sep 2022 20:00:26 -0400
X-Greylist: delayed 27650 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 13 Sep 2022 17:00:24 PDT
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B0F525F113
        for <linux-serial@vger.kernel.org>; Tue, 13 Sep 2022 17:00:24 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 908C292009C; Wed, 14 Sep 2022 02:00:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 8244892009B;
        Wed, 14 Sep 2022 01:00:23 +0100 (BST)
Date:   Wed, 14 Sep 2022 01:00:23 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Anders Blomdell <anders.blomdell@control.lth.se>,
        Pavel Machek <pavel@ucw.cz>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Subject: Re: kernel 5.19.8: "Oxford Semiconductor Ltd OXPCIe952 Dual Native
 950 UART" gets wrong baudrate (PCI ID 1415:c158)
In-Reply-To: <3f2d2863-96dd-05d2-4d88-55666fe37bf8@control.lth.se>
Message-ID: <alpine.DEB.2.21.2209132254150.60554@angie.orcam.me.uk>
References: <ef8fd762-88cf-548a-0599-17d939ad3a57@control.lth.se> <YyA9maUOlPIExIUd@kroah.com> <ff41c70a-767a-45b8-f993-1f70ad3d9254@control.lth.se> <YyB4AtFJx++PeA6S@kroah.com> <7a99a59e-838d-c9da-6ead-167398642c07@control.lth.se> <YyCNOV9no9NPwv8m@kroah.com>
 <e9ca9267-dfee-c7b0-f1ec-4d2b76a05991@control.lth.se> <alpine.DEB.2.21.2209131638550.60554@angie.orcam.me.uk> <3f2d2863-96dd-05d2-4d88-55666fe37bf8@control.lth.se>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, 13 Sep 2022, Anders Blomdell wrote:

> Seems like CPR/CPR2 does not affect baudrate, so maybe EFR bit 4 (enhance
> mode) is not set?

 Thanks for assessing the problem.  I've thought already it could be 
misconfiguration.

> If CPR is stuck at 8 (1.0 scaling), it all makes sense, these corresponds to
> what the oscilloscope gives:
> 
> 2400 ->  tcr: 9, cpr: 18, quot: 1286
>          62500000/9/(8*.125)/1286 -> 5400
> 4800 -> tcr: 7, cpr: 23, quot: 647
> 	2500000/7/(8*.125)/647 -> 13799
> 9600 -> tcr: 9, cpr: 9, quot: 643
>         62500000/9/(8*.125)/643 -> 10800.
> 19200 -> tcr: 8, cpr: 31, quot: 105
>         62500000/7/(8*.125)/105 -> 85034
> 38400 -> 62500000/14/(8*.125)/30 -> 148809

 Agreed.

 As the first debug aid could you please enable DEBUG_AUTOCONF at the top 
of drivers/tty/serial/8250/8250_port.c and paste the relevant piece of 
8250 initialisation recorded in the kernel log?  This will confirm (or 
contradict) correct operation of the port configuration sequence.

 Also I have identified a code piece that handles the EFR in a destructive 
manner, which I must have previously missed, namely a conditional block 
guarded by UART_CAP_EFR in `serial8250_do_set_termios'.  It should likely 
be fixed, however it is supposed not to matter for OxSemi chips due to:

		/* UART_CAP_EFR breaks billionon CF bluetooth card. */
		.flags		= UART_CAP_FIFO | UART_CAP_SLEEP,

which then leads to:

serial 0000:07:00.3: detected caps 00000700 should be 00000500

and consequently UART_CAP_EFR gets cleared and this code block isn't 
supposed to be reached.  Can you confirm the presence of a similar message 
in your log?

 NB it seems to me too big a hammer to have a generic serial port feature 
globally disabled to work around an unidentified problem with an attached 
particular serial device.  Pavel, as the originator of commit d0694e2aeb81 
("serial: unbreak billionton CF card") can you please explain what the 
motivation was here?

 I could only track down two message threads related to the problem:

<https://lore.kernel.org/lkml/20110106134254.68fa27ac@lxorguk.ukuu.org.uk/>

and:

<https://lore.kernel.org/linux-serial/4D001AF1.80902@mainpine.com/>

but no attempt to actually narrow the issue down (also ISTM like a feature 
such as flow control ought to be controlled via a termios call rather than 
globally disabled).  Also could the corruption of the EFR in what is now 
`serial8250_do_set_termios' (and used to be `serial8250_set_termios' then) 
mentioned above be the culprit?

  Maciej
