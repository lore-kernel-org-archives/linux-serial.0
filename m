From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Fwd: [PULL REQUEST] Tweak to support 1Mbaud and similar
 baudrates that require Mode16 instead of Mode13
Date: Tue, 27 Nov 2012 16:42:04 -0800
Message-ID: <20121128004204.GB3857@kroah.com>
References: <CAOmKuSpRJhBibSDxTFCH157-XokhaFhvQ-gYxKZe+PfzokaBoA@mail.gmail.com>
 <CAOmKuSpjitfTeeXz6VKQbhe+iUFb8wYy4n3tAzbjr9g_GOAn4g@mail.gmail.com>
 <CAOmKuSrQW1j_tmQNbXMO-GUH7zrUR0WR3K4rJNok=2LZmRKVYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:47381 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753625Ab2K1Akr (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 27 Nov 2012 19:40:47 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so9293741pbc.19
        for <linux-serial@vger.kernel.org>; Tue, 27 Nov 2012 16:40:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAOmKuSrQW1j_tmQNbXMO-GUH7zrUR0WR3K4rJNok=2LZmRKVYg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alexey Pelykh <alexey.pelykh@gmail.com>
Cc: linux-serial@vger.kernel.org

On Tue, Nov 27, 2012 at 11:56:06PM +0200, Alexey Pelykh wrote:
> Hello everyone,
> 
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
> Best regards,
> Alexey Pelykh
> 
> The following changes since commit 77b67063bb6bce6d475e910d3b886a606d0d91f7:
> 
>   Linux 3.7-rc5 (2012-11-11 13:44:33 +0100)
> 
> are available in the git repository at:
> 
>   git://github.com/alexey-pelykh/linux.git omap_serial_mode_fix
> 
> for you to fetch changes up to cf827bb4057fdcdaeac20b95b01c29c068109185:
> 
>   Tweak to support 1Mbaud and similar baudrates that require Mode16
> instead of Mode13 (2012-11-12 19:29:27 +0200)

Sorry, I can't take a git pull request for a single patch, please just
send it in an email (the patch that is), with the correct signed-off-by:
information, as described in Documentation/SubmittingPatches, and I will
be glad to queue it up.

thanks,

greg k-h
