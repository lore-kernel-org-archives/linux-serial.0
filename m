Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5645C433EF
	for <linux-serial@archiver.kernel.org>; Fri, 13 May 2022 22:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384836AbiEMWmV (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 13 May 2022 18:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384840AbiEMWmQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 13 May 2022 18:42:16 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7C1B60D82;
        Fri, 13 May 2022 15:42:13 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 319889200B3; Sat, 14 May 2022 00:42:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 2BB6192009B;
        Fri, 13 May 2022 23:42:13 +0100 (BST)
Date:   Fri, 13 May 2022 23:42:13 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
Subject: [PATCH 3/3] Documentation: Wire Oxford Semiconductor PCIe (Tornado)
 950
In-Reply-To: <alpine.DEB.2.21.2205131712410.10656@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2205131727070.10656@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2205131712410.10656@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Wire Oxford Semiconductor PCIe (Tornado) 950 description as a chapter 
into the misc-devices document.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 Documentation/misc-devices/index.rst |    1 +
 1 file changed, 1 insertion(+)

linux-doc-oxsemi-tornado-wire.diff
Index: linux-macro/Documentation/misc-devices/index.rst
===================================================================
--- linux-macro.orig/Documentation/misc-devices/index.rst
+++ linux-macro/Documentation/misc-devices/index.rst
@@ -25,6 +25,7 @@ fit into other categories.
    isl29003
    lis3lv02d
    max6875
+   oxsemi-tornado
    pci-endpoint-test
    spear-pcie-gadget
    uacce
