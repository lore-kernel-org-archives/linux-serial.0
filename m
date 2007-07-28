From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: serial flow control appears broken
Date: Sat, 28 Jul 2007 13:00:09 +0100
Message-ID: <20070728130009.43ea9e14@the-village.bc.nu>
References: <fa.Z6O0xFRT69zes0Mg+agt3Uiwux4@ifi.uio.no>
	<46A84B4A.6070902@shaw.ca>
	<46A8C6F1.4080309@howardsilvan.com>
	<20070726173121.70088a92@the-village.bc.nu>
	<46A98845.8010806@howardsilvan.com>
	<46A9F712.70706@imap.cc>
	<46D33636.7070200@microgate.com>
	<46AA5A0E.1050600@howardsilvan.com>
	<1185578908.2989.15.camel@x2>
	<46AACB4D.7080004@howardsilvan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44243 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755460AbXG1Lx2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 28 Jul 2007 07:53:28 -0400
In-Reply-To: <46AACB4D.7080004@howardsilvan.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Lee Howard <faxguy@howardsilvan.com>
Cc: Paul Fulghum <paulkf@microgate.com>, Tilman Schmidt <tilman@imap.cc>, Robert Hancock <hancockr@shaw.ca>, linux-serial@vger.kernel.org, tytso@mit.edu, rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org

> Curiously, the session at 38400 bps that skipped 858 bytes... coincided, 
> not just in sequence but also in precice timing within the session, with 
> a small but noticeable disk load that I caused by grepping through a 
> hundred session logs.  (I can't reproduce it easily, though, because of 
> disk caching.)

Can you send me a dmesg, there are some cases when high disk load can
cause high interrupt latency in both 2.2 and 2.6 depending upon what is
configured. I don't think thats related to the main problem but it is
worth knowing about hdparm -u1

> as it leaves the DCE.  I mention this in case there is any limitation to 
> how the 8250 driver performs when two modems are being run simultaneously.

It means more load but that shouldn't matter much, and the transmit side
if under load with asynchronous traffic will not lose bytes sending.

Alan
