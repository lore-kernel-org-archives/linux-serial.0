From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] 8250: option 'force_polling' for buggy IRQs
Date: Wed, 27 Jul 2016 21:01:02 +0100
Message-ID: <20160727210102.01847d77@lxorguk.ukuu.org.uk>
References: <1469468175-15704-1-git-send-email-mstaudt@suse.de>
	<20160725174712.GA5752@kroah.com>
	<b7ed014e-c6be-01ab-d601-08830d72f8cb@suse.de>
	<20160726150856.GA15676@kroah.com>
	<b383129f-b20b-32e3-41d1-e2c4a68665a2@suse.de>
	<20160727130923.4c20524b@lxorguk.ukuu.org.uk>
	<2b140616-c210-e754-a854-cd6a5675277d@suse.de>
	<20160727133348.GB20032@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160727133348.GB20032@thunk.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: Max Staudt <mstaudt@suse.de>, Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

> I wonder if it would just be simpler to make it be a CONFIG option
> which causes the irq value to zero in arch/x86/include/asm/serial.h?

That assumes x86 and legacy ports.

For modern boxes its data from elsewhere Devicetree folks can just set
up their devicetree that way, the ACPI afflicted can't force the IRQ at
the boot line just the port.

Alan
