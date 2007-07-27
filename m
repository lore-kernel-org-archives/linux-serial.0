From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: serial flow control appears broken
Date: Fri, 27 Jul 2007 18:41:38 +0100
Message-ID: <20070727184138.0490bf89@the-village.bc.nu>
References: <fa.Z6O0xFRT69zes0Mg+agt3Uiwux4@ifi.uio.no>
	<46A84B4A.6070902@shaw.ca>
	<46A8C6F1.4080309@howardsilvan.com>
	<Pine.LNX.4.64N.0707271216410.425@blysk.ds.pg.gda.pl>
	<46AA2748.80703@howardsilvan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:32963 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757080AbXG0RgL (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 27 Jul 2007 13:36:11 -0400
In-Reply-To: <46AA2748.80703@howardsilvan.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Lee Howard <faxguy@howardsilvan.com>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>, Robert Hancock <hancockr@shaw.ca>, linux-serial@vger.kernel.org, tytso@mit.edu, rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org

> I had previously thought that the control of RTS was something that the 
> serial/tty driver was supposed to do independently based on the buffer 
> fill.  Was I wrong?

If the kernel is asked to do CRTSCTS then the kernel handles the flow
control. It uses it when the internal buffers are nearly full.

The direct access to the lines is normally only used by special drivers
such as half duplex radio modem drivers.
