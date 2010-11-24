From: Michael Haardt <michael@moria.de>
Subject: Re: How to disable the transmit FIFO?
Date: Wed, 24 Nov 2010 13:47:01 +0100
Message-ID: <E1PLEkX-0000u5-SZ@palantir.moria.de>
References: <E1PJ0al-0000hs-Kb@palantir.moria.de>
 <20101118164122.GB2855@kroah.com> <E1PJAfx-0000gW-8e@palantir.moria.de>
 <ic40v4$ghm$1@dough.gmane.org> <20101119012523.GT3290@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ti-gw.moria.de ([85.116.193.48]:41294 "EHLO gandalf.moria.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753707Ab0KXMrL (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 24 Nov 2010 07:47:11 -0500
In-Reply-To: <20101119012523.GT3290@thunk.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: tytso@mit.edu, grant.b.edwards@gmail.com
Cc: linux-serial@vger.kernel.org

> Specifically, if you use setserial to configure a serial port so that
> its UART is a 16450, it will force the transmit FIFO to be unused.

I tried that, but no change.  Sending a line of 21 characters to the port,
I see only two trailing edges of CTS, which is consistent with receiving
three characters by the SBC.  The other characters are sent and lost.

The SBC on the other end clears RTS immediatly after receiving a
character.  Linux may send one character at this moment, but that would
be stored in the receiver buffer and the SBC only asserts RTS if the
receiver buffer is empty.  Instead it sends multiple characters, flooding
the SBC.

Michael
