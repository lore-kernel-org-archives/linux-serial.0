From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 7/7] serial/8250: make PIO support optional
Date: Tue, 28 Jun 2011 13:22:55 +0100
Message-ID: <20110628132255.71dcb72a@lxorguk.ukuu.org.uk>
References: <1309211120-2803-1-git-send-email-arnd@arndb.de>
	<1309211120-2803-8-git-send-email-arnd@arndb.de>
	<20110628110500.1cf60104@lxorguk.ukuu.org.uk>
	<201106281352.01459.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201106281352.01459.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

> I got this done for all the obscure ones in patches 1-6, leaving
> only the common UPIO_PORT and UPIO_MEM ones. Changing those would
> mean a lot more churn, and also solving a few other problems:

Yes I like 1-5 ...

> I would much prefer getting a build error on inb/outb for the latter
> kind than having to provide bogus definitions in a lot of architectures.
> For request_region, it's probably better to stub out the macro than
> the users.

Agreed but that can be done by io_serial_in/io_serial_out out of the
8250.c file. Really we need p->ops or a function in another file which
provides the ioport 8250 interface and then all you'd have in the core
code would be

	uart8250_set_ioport_ops(p);

which would live in 8250_ioport.c or be a "return -EINVAL' for anything
else. 

That leaves request/release_std resources depending how such platforms
handle request_region attempts, and the other fourport bits which want
pushing into the 8250f_fourport driver perhaps as extra p-> ops.

	if (p->startup)
		p->startup(p);

etc

(Or indeed probably a p->ops-> for the lot is even saner)



Thoughts ?
