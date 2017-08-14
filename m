From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: Race between release_tty() and vt_disallocate()
Date: Mon, 14 Aug 2017 13:39:47 +0100
Message-ID: <20170814133947.37ad1855@alans-desktop>
References: <CAK8P3a2Pok0Mpmj+DZG3gi13F9bWrK_u7M0hC4kHKuUzSuH1Ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a2Pok0Mpmj+DZG3gi13F9bWrK_u7M0hC4kHKuUzSuH1Ng@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adam Borowski <kilobyte@angband.pl>, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, jun.he@linaro.org, graeme.gregory@linaro.org, gema.gomez-solano@linaro.org
List-Id: linux-serial@vger.kernel.org

> non-pointer value 0x00000028fecaedff. The tty_port belongs to
> a vc_data structure, which gets freed after we find that
> console_driver->ttys[i]->count is zero in the VT_DISALLOCATE
> ioctl. Apparently at the same time, the agetty process owning

That wouldn't actually be a safe check. tty->count isn't a simple
reference count even if the locking were right.

> the tty closes and that leads to  tty->count dropping to zero
> before we call tty_buffer_cancel_work() on the tty_port that
> has now been freed.
> 
> Apparently the locking and/or reference counting between the
> two code paths is insufficient, but I don't understand enough
> about tty locking to come up with a fix that doesn't break other
> things. Please have a look.

I'm actually not sure how we can fix this within the current API. The tty
port is refcounted (see tty_port_put() and tty_port_tty_get()) so
any ioctl would end up returning but the console port resources would not
disappear until that tty finally closed down.

Calling tty_hangup on the tty for the port will close the tty down, but
that in itself is also asynchronous.

The only easy way I can think to keep the current semantics would instead
be to keep the tty port resources around and indexed somewhere but
blackhole input to/output from that port or switching to it and also call
tty_hangup if the port has a tty.

Alan
