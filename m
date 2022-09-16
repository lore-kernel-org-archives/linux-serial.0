Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A1AECAAD8
	for <linux-serial@archiver.kernel.org>; Fri, 16 Sep 2022 21:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiIPVur (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 16 Sep 2022 17:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiIPVur (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 16 Sep 2022 17:50:47 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EBC51B4418
        for <linux-serial@vger.kernel.org>; Fri, 16 Sep 2022 14:50:45 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 3BA2692009C; Fri, 16 Sep 2022 23:50:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 3444892009B;
        Fri, 16 Sep 2022 22:50:45 +0100 (BST)
Date:   Fri, 16 Sep 2022 22:50:45 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Anders Blomdell <anders.blomdell@control.lth.se>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Subject: Re: kernel 5.19.8: "Oxford Semiconductor Ltd OXPCIe952 Dual Native
 950 UART" gets wrong baudrate (PCI ID 1415:c158)
In-Reply-To: <9d57caa6-e3af-2e22-bdf0-2af42d91d3a3@control.lth.se>
Message-ID: <alpine.DEB.2.21.2209162240140.19473@angie.orcam.me.uk>
References: <ef8fd762-88cf-548a-0599-17d939ad3a57@control.lth.se> <YyA9maUOlPIExIUd@kroah.com> <ff41c70a-767a-45b8-f993-1f70ad3d9254@control.lth.se> <YyB4AtFJx++PeA6S@kroah.com> <7a99a59e-838d-c9da-6ead-167398642c07@control.lth.se> <YyCNOV9no9NPwv8m@kroah.com>
 <e9ca9267-dfee-c7b0-f1ec-4d2b76a05991@control.lth.se> <alpine.DEB.2.21.2209131638550.60554@angie.orcam.me.uk> <9d57caa6-e3af-2e22-bdf0-2af42d91d3a3@control.lth.se>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, 13 Sep 2022, Anders Blomdell wrote:

> The delock card is in an x86 machine, and it communicates with various RS232
> devices
> (hence speeds above 230400 usually works badly with a few meters of cabling)

 FWIW I was able to get reliable communication between a pair of OXPCIe952 
devices over a ~1.5m connection (a flat Cisco console cable) using rates 
of up to 3500000bps despite the cards having line transceivers specified 
for up to 1MHz operation only (cards marketed for 921600bps operation).  
The only issue with rates above 576000bps were input overruns, asking for 
DMA operation really (which the OXPCIe952 does support; only we don't!).

 Cf.: 
<https://lore.kernel.org/linux-serial/alpine.DEB.2.21.2106071700090.1601@angie.orcam.me.uk/>.

  Maciej
