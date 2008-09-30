From: Aristeu Rozanski <aris@ruivo.org>
Subject: [PATCH RFC 0/6] serial: make hardware flow control more flexible
Date: Tue, 30 Sep 2008 14:41:55 -0400
Message-ID: <20080930184155.944902515@ruivo.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lobo.ruivo.org ([66.92.68.119]:54566 "EHLO lobo.ruivo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753069AbYI3SmR (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 30 Sep 2008 14:42:17 -0400
Received: from jake.ruivo.org (gw.qemu.cathedral [192.168.72.1])
	by lobo.ruivo.org (Postfix) with ESMTP id EEC65526D0
	for <linux-serial@vger.kernel.org>; Tue, 30 Sep 2008 14:41:54 -0400 (EDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

This series of patches begins the changes in the serial code to allow more
flexible hardware flow control rules. Instead of having fixed models like
RTS/CTS or DSR/DTR, the new termiox structure will instead allow to specify
which pins will be used.

Currently, termiox has four flags: RTSXOFF, CTSXON, DTRXOFF and DSRXON. This
is not yet enough to fully specify Linux' CRTSCTS since it uses the DTR always
on while the serial port is available (and RTS to signal if the system is ready
or not to receive data). The plan is add RTSON and DTRON to termiox to allow
the user to specify that those pins will be always set while the serial port
is available.

These patches are not intended for inclusion, just to continue the discussion.

-- 
Aristeu

