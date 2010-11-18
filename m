From: Michael Haardt <michael@moria.de>
Subject: How to disable the transmit FIFO?
Date: Thu, 18 Nov 2010 10:15:43 +0100
Message-ID: <E1PJ0al-0000hs-Kb@palantir.moria.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ti-gw.moria.de ([85.116.193.48]:57668 "EHLO gandalf.moria.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751210Ab0KRJY1 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 18 Nov 2010 04:24:27 -0500
Received: from palantir.moria.de ([2002:5574:c130:2::4]:34256)
	by gandalf.moria.de with esmtps (TLSv1:AES256-SHA:256) (Exim 4.72 #15)
	id 1PJ0ap-0002wA-Rf
	for linux-serial@vger.kernel.org; Thu, 18 Nov 2010 10:15:57 +0100
Received: from michael by palantir.moria.de with local (ID michael) (Exim 4.72 #15)
	id 1PJ0al-0000hs-Kb
	for linux-serial@vger.kernel.org; Thu, 18 Nov 2010 10:15:43 +0100
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hello,

I miss a way to disable the transmit FIFO.

UARTs that don't do hardware handshaking in hardware, but use a transmit
FIFO, can only be used if the peer can deal with the delayed handshaking
response.

If slow peers can not receive at line rate, hardware handshaking will
still cause overruns with Linux as sender, because Linux fills the
transmit FIFO and transmission continues at worst for 16 characters with
a 16550 after CTS was asserted.

So, how can I fix hardware flow control response to the non-delayed
behaviour as it worked with a 8250 or 16450 by disabling the transmit
FIFO?

Michael
