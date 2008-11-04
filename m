From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [BUG] serial base baud misdetected in 2.6.27
Date: Tue, 4 Nov 2008 19:22:53 +0000
Message-ID: <20081104192253.151d6ef3@lxorguk.ukuu.org.uk>
References: <4910936D.4030605@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:43006 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751651AbYKDTWr (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 4 Nov 2008 14:22:47 -0500
In-Reply-To: <4910936D.4030605@nortel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Chris Friesen <cfriesen@nortel.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Tue, 04 Nov 2008 12:24:45 -0600
"Chris Friesen" <cfriesen@nortel.com> wrote:

> 
> I'm running an ATCA7101 board.  This board has two 16550 ports that get 
> detected as ttyS4 and ttyS5.
> 
> With a much earlier kernel (2.6.14) the serial port base speed is 
> correctly detected as 230400, which gives the desired 115200 when I 
> specify that on the kernel commandline.
> 
> With 2.6.16 and 2.6.27 (not sure about the intervening kernels) the 
> serial port base speed is detected as 921600, which means that I need to 
> specify 460800 on the commandline to get a real speed of 115200 (as 
> verified by an external terminal server).
> 
> Any ideas what could be causing this misdetection?  I'm having lab 
> issues right now so I can't track it down, but I'll have a go at it 
> eventually.

If this is a PCI card it may be matching against a PCI entry for a
similar card with different crystals and need the right svid/sdid adding.
