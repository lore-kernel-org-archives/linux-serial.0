From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 7/7] serial/8250: make PIO support optional
Date: Mon, 4 Jul 2011 22:55:20 +0100
Message-ID: <20110704225520.2d0004f3@lxorguk.ukuu.org.uk>
References: <1309211120-2803-1-git-send-email-arnd@arndb.de>
	<201107042127.31649.arnd@arndb.de>
	<20110704205336.09547e1f@lxorguk.ukuu.org.uk>
	<201107042237.05295.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201107042237.05295.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

> How are people using those ISA cards today? The version of setserial
> that I found is not able to set MMIO mode on those. I suppose you

Various ugly hacks, if its tricky we can drop support and see who screams

> are not talking about isapnp cards, right? Those should not need to
> be handled through the ISA driver at all.

ISAPnP will do it automatically so the ISAPnP case isn't a problem. I've
never sen an ISAPnP port that was anything but standard.
