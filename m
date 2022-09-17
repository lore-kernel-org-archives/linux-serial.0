Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A0BECAAD3
	for <linux-serial@archiver.kernel.org>; Sat, 17 Sep 2022 10:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbiIQKHW (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 17 Sep 2022 06:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiIQKHV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 17 Sep 2022 06:07:21 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1ACD1186E7
        for <linux-serial@vger.kernel.org>; Sat, 17 Sep 2022 03:07:19 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 9379592009C; Sat, 17 Sep 2022 12:07:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 843B192009B;
        Sat, 17 Sep 2022 11:07:18 +0100 (BST)
Date:   Sat, 17 Sep 2022 11:07:18 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
cc:     Josh Triplett <josh@joshtriplett.org>,
        Anders Blomdell <anders.blomdell@control.lth.se>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH 0/2] serial: 8250: Let drivers request full 16550A feature
 probing
Message-ID: <alpine.DEB.2.21.2209162317180.19473@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

 A recent change has added a SERIAL_8250_16550A_VARIANTS option, which 
lets one request the 8250 driver not to probe for 16550A device features 
so as to reduce the driver's device startup time in virtual machines.  
This has turned out problematic to a more recent update for the OxSemi 
Tornado series PCIe devices, whose new baud rate generator handling code 
actually requires switching hardware into the enhanced mode for correct 
operation, which actually requires 16550A device features to have been 
probed for.

 This small patch series fixes the issue by letting individual device 
subdrivers to request full 16550A device feature probing by means of a 
flag regardless of the SERIAL_8250_16550A_VARIANTS setting chosen.

 The changes have been verified with an OXPCIe952 device, in the native 
UART mode and a 64-bit RISC-V system as well as in the legacy UART mode 
and a 32-bit x86 system.

 Credit to Anders for reporting this issue and then working through the 
resolution.

  Maciej
