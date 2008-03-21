From: Grant Edwards <grante@visi.com>
Subject: Enhancing pty driver to act like a serial port?
Date: Fri, 21 Mar 2008 16:49:56 +0000 (UTC)
Message-ID: <fs0ovk$oii$1@ger.gmane.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:35622 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760826AbYCUSPF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 21 Mar 2008 14:15:05 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Jclle-0007lX-D4
	for linux-serial@vger.kernel.org; Fri, 21 Mar 2008 18:15:02 +0000
Received: from 65.111.170.175 ([65.111.170.175])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Fri, 21 Mar 2008 18:15:02 +0000
Received: from grante by 65.111.170.175 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Fri, 21 Mar 2008 18:15:02 +0000
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

The question of emulating a serial port in user-space has come
up a number of times in various contexts during the past few
years.  

The current pty driver isn't really sufficient when the
application actually expects to be connected to a physical
serial port: you can't set parity or word length, and the modem
control/status ioctl() calls fail.

That means that many applications just won't run when told to
use a pty instead of a normal serial port.

If one were to enhance the pty driver to support the same
operations as a serial port, would the "powers that be" be
amenable to accepting such changes into the main pty driver
sources?

Or is this even the right place to discuss the pty driver?

-- 
Grant

