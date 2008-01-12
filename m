From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial: remove "too much work for irq" printk
Date: Sat, 12 Jan 2008 21:42:30 +0000
Message-ID: <20080112214230.241018d4@lxorguk.ukuu.org.uk>
References: <20080112201543.GB12775@kvack.org>
	<20080112212457.3bf534af@lxorguk.ukuu.org.uk>
	<47893374.4080102@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37108 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756023AbYALVpD (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 12 Jan 2008 16:45:03 -0500
In-Reply-To: <47893374.4080102@zytor.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Benjamin LaHaise <bcrl@kvack.org>, akpm@osdl.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

> This is going to put trouble in other places unless, at least, it can be 
> turned off.  The UART serial interface is heavily emulated as a console 
> interface without an actual serial port behind it, both in hardware and 
> software.  Rates will typically vastly exceed real serial port rates, 

Yes Dell do it, HP do it, IBM do it. Have done for years, never caused us
a problem. Its only KVM tripping it.

As to bit rate we support up to about 1 to 1.5 Mbit.

Alan
