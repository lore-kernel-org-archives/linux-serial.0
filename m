From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: serial flow control appears broken
Date: Thu, 2 Aug 2007 18:13:49 +0100
Message-ID: <20070802181349.40ca474f@the-village.bc.nu>
References: <fa.Z6O0xFRT69zes0Mg+agt3Uiwux4@ifi.uio.no>
	<46A84B4A.6070902@shaw.ca>
	<46A8C6F1.4080309@howardsilvan.com>
	<Pine.LNX.4.64N.0707271216410.425@blysk.ds.pg.gda.pl>
	<46AA2748.80703@howardsilvan.com>
	<Pine.LNX.4.64N.0707271825220.425@blysk.ds.pg.gda.pl>
	<46AA3801.7090204@shaw.ca>
	<20070728092842.GC26443@flint.arm.linux.org.uk>
	<Pine.LNX.4.64N.0707301040320.12082@blysk.ds.pg.gda.pl>
	<46B1F0CB.9060106@rtr.ca>
	<46B202DE.5000709@shaw.ca>
	<46B20662.6080606@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48056 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751297AbXHBRGn (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 2 Aug 2007 13:06:43 -0400
In-Reply-To: <46B20662.6080606@rtr.ca>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: Robert Hancock <hancockr@shaw.ca>, "Maciej W. Rozycki" <macro@linux-mips.org>, Russell King <rmk+lkml@arm.linux.org.uk>, Lee Howard <faxguy@howardsilvan.com>, linux-serial@vger.kernel.org, tytso@mit.edu, linux-kernel@vger.kernel.org

> That's what "hdparm -u1" (or -u0) controls.

Only some of the time.

> Ingo's RT patches would probably fix all of this.

The worst case IDE times we've seen for executing a single indivisible
un-interruptible I/O cycle with a drive are around 1mS. Thats a hardware
limit.

Alan
