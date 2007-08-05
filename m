From: Paul Fulghum <paulkf@microgate.com>
Subject: Re: serial flow control appears broken
Date: Sun, 05 Aug 2007 09:52:06 -0500
Message-ID: <1186325526.3209.5.camel@x2>
References: <fa.Z6O0xFRT69zes0Mg+agt3Uiwux4@ifi.uio.no>
	 <46A84B4A.6070902@shaw.ca> <46A8C6F1.4080309@howardsilvan.com>
	 <20070726173121.70088a92@the-village.bc.nu>
	 <46A98845.8010806@howardsilvan.com> <46A9F712.70706@imap.cc>
	 <46D33636.7070200@microgate.com> <46AA5A0E.1050600@howardsilvan.com>
	 <1185578908.2989.15.camel@x2> <46AACB4D.7080004@howardsilvan.com>
	 <2c0942db0707280941n1b9e1f7i9c0de332286e8aac@mail.gmail.com>
	 <46B4C393.4020506@howardsilvan.com> <46B4F8AD.3000405@microgate.com>
	 <46B51308.4010402@howardsilvan.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:57307
	"EHLO gw.microgate.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751658AbXHEOyG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 5 Aug 2007 10:54:06 -0400
In-Reply-To: <46B51308.4010402@howardsilvan.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Lee Howard <faxguy@howardsilvan.com>
Cc: Ray Lee <ray-lk@madrabbit.org>, Tilman Schmidt <tilman@imap.cc>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Robert Hancock <hancockr@shaw.ca>, linux-serial@vger.kernel.org, tytso@mit.edu, rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org

2.2.5 is using the same UART setup (trigger level of 8) as
the current code. There is no obvious difference in the
interrupt setup (same devices on the same interrupts).

So I have no helpful suggestions :-(

--
Paul


