From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 4/9] tty: move TTY_IO_ERROR flag to tty_port iflags
Date: Sun, 11 Sep 2016 22:18:05 +0100
Message-ID: <20160911221805.36c8a954@lxorguk.ukuu.org.uk>
References: <20160909223711.26238-1-robh@kernel.org>
        <20160909223711.26238-5-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160909223711.26238-5-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri,  9 Sep 2016 17:37:05 -0500
Rob Herring <robh@kernel.org> wrote:

> TTY_IO_ERROR is a property of the tty port rather than the tty, so move
> it to tty_port struct and remove another dependency on tty_struct from
> drivers.
> 
> Partially converted with coccinelle:
> 
> @@
> identifier t;
> identifier func;
> @@
> - func(TTY_IO_ERROR, &t->flags)
> + func(TTY_PORT_IO_ERROR, &t->port->iflags)
> 
> @@
> expression port;
> identifier func;
> @@
> - func(TTY_IO_ERROR, &port.tty->flags)
> + func(TTY_PORT_IO_ERROR, &port.iflags)

Again this makes sense to move the object to the right structure.

I'm not convinced your recipe is a correct and reliable translation
because you don't capture the flag being cleared if the tty object is
freed and then a new one allocated. That needs further review IMHO

Alan
