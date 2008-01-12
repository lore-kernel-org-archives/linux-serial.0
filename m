From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial: remove "too much work for irq" printk
Date: Sat, 12 Jan 2008 21:24:57 +0000
Message-ID: <20080112212457.3bf534af@lxorguk.ukuu.org.uk>
References: <20080112201543.GB12775@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44614 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756023AbYALV1e (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 12 Jan 2008 16:27:34 -0500
In-Reply-To: <20080112201543.GB12775@kvack.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: akpm@osdl.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, 12 Jan 2008 15:15:43 -0500
Benjamin LaHaise <bcrl@kvack.org> wrote:

> When using kvm with a serial console, the serial driver will print out 
> "too much work for irq4" on any heavy activity (ie vi on a file repainting 
> the terminal).  This message is entirely spurious, as output continues to 
> work fine.  Remove the message as it corrupts screen output and is far too 
> easy to trigger.

NAK. This is a qemu/kvm emulation bug. The real check is there to catched
jammed IRQs and combined with the IRQ bug handling nowdays does actually
do the intended job.

Our serial port code (correctly) interprets a continuous stream of bytes
at an impossible bit rate as an error. KVM should be emulating to some
extent at least the timing on serial interfaces or using a virtualised
interface.

Alan
