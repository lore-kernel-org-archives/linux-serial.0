From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 7/7] serial/8250: make PIO support optional
Date: Mon, 4 Jul 2011 20:53:36 +0100
Message-ID: <20110704205336.09547e1f@lxorguk.ukuu.org.uk>
References: <1309211120-2803-1-git-send-email-arnd@arndb.de>
	<201107041835.22660.arnd@arndb.de>
	<20110704180216.4dc9c79d@lxorguk.ukuu.org.uk>
	<201107042127.31649.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201107042127.31649.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

> Ok, makes sense. If I split this out to the ISA driver, I would
> probably also disallow changing io_type, as ISA 8250 ports are
> all based on PIO mode.

Alas not, they also come in MMIO form now and then, not often but just
enough to be annoyingly unignorable. However the ISA driver can handle
that 'in-house' and I've never seen anything but PIO or simple MMIO.

Alan
