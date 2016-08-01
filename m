From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] 8250: option 'force_polling' for buggy IRQs
Date: Mon, 1 Aug 2016 16:27:31 +0100
Message-ID: <20160801162731.2a3e2a8a@lxorguk.ukuu.org.uk>
References: <1469468175-15704-1-git-send-email-mstaudt@suse.de>
	<20160725174712.GA5752@kroah.com>
	<b7ed014e-c6be-01ab-d601-08830d72f8cb@suse.de>
	<20160726150856.GA15676@kroah.com>
	<b383129f-b20b-32e3-41d1-e2c4a68665a2@suse.de>
	<20160727130923.4c20524b@lxorguk.ukuu.org.uk>
	<2b140616-c210-e754-a854-cd6a5675277d@suse.de>
	<20160727133348.GB20032@thunk.org>
	<f02610c6-5607-9fdf-23af-5b05d604f473@suse.de>
	<87mvl1hahu.fsf@x220.int.ebiederm.org>
	<20160729102335.2dbe3cad@lxorguk.ukuu.org.uk>
	<8e37ca98-23a5-9eb7-1317-760bbebcd8bb@suse.de>
	<871t2cgxa6.fsf@x220.int.ebiederm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <871t2cgxa6.fsf@x220.int.ebiederm.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Max Staudt <mstaudt@suse.de>, Theodore Ts'o <tytso@mit.edu>, Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

> It might make sense to filter non-shared edge triggered interrupts out
> of irqpoll for that reason.  Anything that supports a level triggered
> interrupt should be fine.

That would also break some platforms that use it today 8(. We'd need
another irqpoll mode - at which point being able to force the serial port
IRQ to 0 would be useful for ACPI boxes (devicetree people just mod the
devicetree!)

Alan
