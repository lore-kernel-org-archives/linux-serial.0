From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 34/37] serial: 8250_ingenic: support for Ingenic SoC
 UARTs
Date: Mon, 1 Jun 2015 06:49:43 +0900
Message-ID: <20150531214943.GA17410@kroah.com>
References: <1432480307-23789-1-git-send-email-paul.burton@imgtec.com>
 <1432480307-23789-35-git-send-email-paul.burton@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1432480307-23789-35-git-send-email-paul.burton@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org, Jiri Slaby <jslaby@suse.cz>, Lars-Peter Clausen <lars@metafoo.de>, linux-serial@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Hurley <peter@hurleysoftware.com>, Alan Cox <alan@linux.intel.com>, linux-kernel@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Tony Lindgren <tony@atomide.com>, John Crispin <blogic@openwrt.org>
List-Id: linux-serial@vger.kernel.org

On Sun, May 24, 2015 at 04:11:44PM +0100, Paul Burton wrote:
> Introduce a driver suitable for use with the UARTs present in
> Ingenic SoCs such as the JZ4740 & JZ4780. These are described as being
> ns16550 compatible but aren't quite - they require the setting of an
> extra bit in the FCR register to enable the UART module. The serial_out
> implementation is the same as that in arch/mips/jz4740/serial.c - which
> will shortly be removed.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.cz>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: linux-serial@vger.kernel.org

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
