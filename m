From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Fwd: [PULL REQUEST] Tweak to support 1Mbaud and similar
 baudrates that require Mode16 instead of Mode13
Date: Wed, 28 Nov 2012 09:25:05 -0800
Message-ID: <20121128172505.GB32286@kroah.com>
References: <CAOmKuSpRJhBibSDxTFCH157-XokhaFhvQ-gYxKZe+PfzokaBoA@mail.gmail.com>
 <CAOmKuSpjitfTeeXz6VKQbhe+iUFb8wYy4n3tAzbjr9g_GOAn4g@mail.gmail.com>
 <CAOmKuSrQW1j_tmQNbXMO-GUH7zrUR0WR3K4rJNok=2LZmRKVYg@mail.gmail.com>
 <20121128004204.GB3857@kroah.com>
 <CAOmKuSr+PYcs37DdiOj+h8wq0hjrdtHN4pCUvj-y97fr6-0DCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:54913 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751121Ab2K1RZH (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 28 Nov 2012 12:25:07 -0500
Content-Disposition: inline
In-Reply-To: <CAOmKuSr+PYcs37DdiOj+h8wq0hjrdtHN4pCUvj-y97fr6-0DCA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alexey Pelykh <alexey.pelykh@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org

On Wed, Nov 28, 2012 at 11:05:08AM +0200, Alexey Pelykh wrote:
> Original table in OMAP TRM named "UART Mode Baud Rates, Divisor
> Values, and Error Rates" determines modes not for all common baud
> rates. E.g. for 1000000 baud rate mode should be 16x, but according to
> that table it's determined as 13x. According to current implementation
> of mode
> divisor selection, after requesting 1000000 baudrate from driver,
> later one will configure chip to use MODE13 divisor. Assuming 48Mhz as
> common UART clock speed, MODE13 divisor will effectively give 1230769
> baudrate, what is quite far from desired 1000000 baudrate. While with
> MODE16 divisor, chip will produce exact 1000000 baudrate.
> 
> In old driver that served UART devices (8250.c and serial_core.c) this
> divisor could have been configured by user-space program, but in
> omap_serial.c driver implementation this ability was not implemented
> (afaik, by design) thus disallowing proper usage of MODE16-compatible
> baudrates.
> 
> Changes: I've fixed styling errors using ./scripts/checkpatch.pl
> 
> Signed-off-by: Alexey Pelykh <alexey.pelykh@gmail.com>
> 
> The following changes since commit 77b67063bb6bce6d475e910d3b886a606d0d91f7:

Again, I will not take a pull request, why do you keep on sending this?

Please just send your patch through mail, in a format that I can apply
it in (as described in Documentation/SubmittingPatches).

thanks,

greg k-h
