From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 6/7] serial/8250: sanitize fourport handling
Date: Tue, 28 Jun 2011 14:07:40 +0200
Message-ID: <201106281407.40446.arnd@arndb.de>
References: <1309211120-2803-1-git-send-email-arnd@arndb.de> <1309211120-2803-7-git-send-email-arnd@arndb.de> <20110628111035.7bd69c0d@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110628111035.7bd69c0d@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tuesday 28 June 2011, Alan Cox wrote:
> On Mon, 27 Jun 2011 23:45:19 +0200
> Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > Support for AST fourport cards is always built into
> > the 8250 driver, even if CONFIG_SERIAL_8250_FOURPORT
> > is disabled. This introduces a set of macros for
> > accessing the special interrupt control register on
> > the fourport card, so that support is left out
> > when the option is disabled, without adding more #ifdef
> > lines to the driver itself.
> 
> Why not just leave it in - it seems to take almost no code and your
> changes mean people setting the fourport flag are going to get strange
> behaviour when it isn't compiled in.

Mostly to avoid the inb/outb when fourport is disabled. The regular
I/O can be handled using the indirect serial_in/out functions, but
the fourport handling requires some address calculations.

Also, now that you mention users toggling the fourport flag, I can't
see where that would ever do something good. On anything but a real
fourport card, it will lead to writing to ports you shouldn't write
to (0x1f on mmio based uarts, 18 bytes after the requested region
for regular ports).

If you have an actual AST fourport card, you won't be able to use
it unless you load the 8250_fourport driver that registers the correct
addresses, and disabling the fourport flag will then cause the
uart to stop getting interrupts.

	Arnd
