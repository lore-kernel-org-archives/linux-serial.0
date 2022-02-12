Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3C5C433EF
	for <linux-serial@archiver.kernel.org>; Sat, 12 Feb 2022 08:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbiBLImC (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 12 Feb 2022 03:42:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbiBLImA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 12 Feb 2022 03:42:00 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 840A82657B;
        Sat, 12 Feb 2022 00:41:50 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id B90FE92009D; Sat, 12 Feb 2022 09:41:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id B50CD92009C;
        Sat, 12 Feb 2022 08:41:48 +0000 (GMT)
Date:   Sat, 12 Feb 2022 08:41:48 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mike Skoog <mskoog@endruntechnologies.com>,
        Mike Korreng <mkorreng@endruntechnologies.com>,
        info@endruntechnologies.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] serial: 8250: Fixes for Oxford Semiconductor 950
 UARTs
Message-ID: <alpine.DEB.2.21.2202100424280.34636@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

 Cc-ing the general contact point at EndRun for 1/2 of this series in case 
the original submitters of the affected code are not there anymore after 
those 7 years.

 Here's v3 of the outstanding fixes for Oxford Semiconductor 950 UARTs.  
As the change for the default FIFO rx trigger level has been already 
merged with commit d7aff291d069 ("serial: 8250: Define RX trigger levels 
for OxSemi 950 devices") only one patch of the original series remains.  

 However in the course of preparing v3 of that change I have noticed that 
the EndRun device is actually also an OxSemi 952 device in disguise (note 
that the OxSemi chips have fully customer-programmable PCI vendor:device 
ID values).  Therefore it requires a similar fix to the base baud rate as 
with commit 6cbe45d8ac93 ("serial: 8250: Correct the clock for OxSemi 
PCIe devices"), and also duplicate code can be removed.

 I have therefore added a fix for the EndRun device as 1/2 in this version 
and the original outstanding change is now 2/2, updated accordingly, also 
for a change in the handling of the MCR made with commit b4a29b94804c 
("serial: 8250: Move Alpha-specific quirk out of the core").

 As noted in the course of v2 review I don't believe the Linux kernel has 
a policy for any of its subsystems to require rewriting parts of existing 
code to fix bugs or internal API deficiencies as a prerequisite for bug 
fix (or even functional improvement) acceptance.  Therefore I consider 
this v3 of the series final and I am not going to continue pursuing this 
submission any further unless there is an actual technical defect (a bug, 
a coding style issue, etc.) within this series itself.

 Please apply.

  Maciej
