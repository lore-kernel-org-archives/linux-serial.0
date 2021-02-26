Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9827C433E0
	for <linux-serial@archiver.kernel.org>; Fri, 26 Feb 2021 21:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71A2A64F0E
	for <linux-serial@archiver.kernel.org>; Fri, 26 Feb 2021 21:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhBZVQe (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 Feb 2021 16:16:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbhBZVQb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Feb 2021 16:16:31 -0500
X-Greylist: delayed 395 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 26 Feb 2021 13:15:51 PST
Received: from orac.theglitchworks.net (orac.theglitchworks.net [IPv6:2607:f058:186:1::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FB4C061756
        for <linux-serial@vger.kernel.org>; Fri, 26 Feb 2021 13:15:51 -0800 (PST)
Received: from z420.bv.theglitchworks.net (z420.bv.theglitchworks.net [IPv6:2001:470:1f07:b75:7646:a0ff:feba:d1d3])
        by orac.theglitchworks.net (OpenSMTPD) with ESMTPSA id b0132eda (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO)
        for <linux-serial@vger.kernel.org>;
        Fri, 26 Feb 2021 16:09:07 -0500 (EST)
Date:   Fri, 26 Feb 2021 16:09:05 -0500
From:   Jonathan Chapman <glitch@glitchwrks.com>
To:     linux-serial@vger.kernel.org
Subject: Sealevel Systems 7202 PCI Serial Card
Message-Id: <20210226160905.4809b6eef1b515b6790953cc@glitchwrks.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Below is the information for a PCI dual-port serial card I use:

Manufacturer: Sealevel Systems INC.
Name/Model: 7202 Dual Port RS-232 Interface

Output of `lspci -vv`:

00:11.0 Serial controller: Sealevel Systems Inc Dual Port RS-232 Interface (rev 01) (prog-if 02 [16550])
        Subsystem: Sealevel Systems Inc Dual Port RS-232 Interface
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 12
        Region 0: Memory at e9100000 (32-bit, non-prefetchable) [size=128]
        Region 1: I/O ports at d800 [size=128]
        Region 2: I/O ports at dc00 [size=8]
        Region 3: I/O ports at e000 [size=8]
        Kernel driver in use: serial

Lines from `dmesg`:

[    0.981647] serial 0000:00:11.0: found PCI INT A -> IRQ 12
[    0.982022] serial 0000:00:11.0: 0000:00:11.0: Redundant entry in serial pci_table.
               Please send the output of lspci -vv, this
               message (0x135e,0x7202,0x135e,0x7202), the
               manufacturer and name of serial board or
               modem board to <linux-serial@vger.kernel.org>.

Thanks,

Jonathan Chapman
Glitch Works, LLC
http://www.glitchwrks.com/
