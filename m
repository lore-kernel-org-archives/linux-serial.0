Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D807C433F5
	for <linux-serial@archiver.kernel.org>; Sat, 12 Feb 2022 08:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbiBLIlf (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 12 Feb 2022 03:41:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbiBLIlf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 12 Feb 2022 03:41:35 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4FF8226553;
        Sat, 12 Feb 2022 00:41:32 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id B31B992009E; Sat, 12 Feb 2022 09:41:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id AF85E92009B;
        Sat, 12 Feb 2022 08:41:30 +0000 (GMT)
Date:   Sat, 12 Feb 2022 08:41:30 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] serial: 8250: Correct basic issues with the PCI
 blacklist
Message-ID: <alpine.DEB.2.21.2202052214360.34636@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

 In the course of investigating whether support code for OxSemi PCIe UARTs 
could be factored out from the common 8250 PCI UART driver, which has been 
previously requested by Andy (cc-ed), I have noticed that the Kconfig help 
text for several device-specific UART drivers previously factored out is 
incorrect in that it claims that those dedicated drivers are required for 
extra features of the respective devices, while actually the blacklist 
entries within the common driver make them require those dedicated drivers 
even for standard features, as the common driver now refuses to handle 
them.

 Also it may be unclear for the user from a specific PCI device ID of an 
affected PCI UART device which dedicated driver has to be configured in to 
handle it, so make the blacklist entries include that information to be 
printed if a device is encountered that cannot be handled because its 
dedicated driver has been excluded from configuration while the common 
driver refuses to handle it.

 See the respective change descriptions for further details.  Please 
apply.

  Maciej
