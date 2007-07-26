From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: serial flow control appears broken
Date: Thu, 26 Jul 2007 17:41:50 +0100
Message-ID: <20070726174150.4ffcabd4@the-village.bc.nu>
References: <46A7FE6A.4030309@howardsilvan.com>
	<20070726123420.GA14163@informatik.uni-freiburg.de>
	<46A8CB96.1010501@howardsilvan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53269 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S934316AbXGZQfH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 26 Jul 2007 12:35:07 -0400
In-Reply-To: <46A8CB96.1010501@howardsilvan.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Lee Howard <faxguy@howardsilvan.com>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@informatik.uni-freiburg.de>, linux-serial@vger.kernel.org, tytso@mit.edu, rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org

> The manufacturer is using a scope to look for RTS and they're not seeing 
> it, either.  I just use my eyes to look at the LED, but I can see the 
> CTS, DTR, DCD, RD, and TD lights blink, flicker, or dim... (and TD, RD, 
> and CTS tend to go on and off rather quickly).

And you have

1.	The port set up correctly for flow control options in the
kernel ?
2.	Verified that the board vendor remembered to wire it ?
