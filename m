From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PULL REQUEST] Tweak to support 1Mbaud and similar baudrates
 that require Mode16 instead of Mode13
Date: Tue, 27 Nov 2012 23:00:13 +0000
Message-ID: <20121127230013.6904e8d3@pyramind.ukuu.org.uk>
References: <CAOmKuSpRJhBibSDxTFCH157-XokhaFhvQ-gYxKZe+PfzokaBoA@mail.gmail.com>
	<CAOmKuSpjitfTeeXz6VKQbhe+iUFb8wYy4n3tAzbjr9g_GOAn4g@mail.gmail.com>
	<CAOmKuSrQW1j_tmQNbXMO-GUH7zrUR0WR3K4rJNok=2LZmRKVYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:43092 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899Ab2K0Wyy (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 27 Nov 2012 17:54:54 -0500
In-Reply-To: <CAOmKuSrQW1j_tmQNbXMO-GUH7zrUR0WR3K4rJNok=2LZmRKVYg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alexey Pelykh <alexey.pelykh@gmail.com>
Cc: linux-serial@vger.kernel.org

> In old driver that served UART devices (8250.c and serial_core.c) this
> divisor could have been configured by user-space program, but in
> omap_serial.c driver implementation this ability was not implemented
> (afaik, by design) thus disallowing proper usage of MODE16-compatible
> baudrates.

Yes in the ideal case the kernel should manage should things.

Looks fine to me from a tty perspective (style wise one might quibble
about baudAbsDiff but I really don;t care 8))

Acked-by: Alan Cox <alan@linux.intel.com>
