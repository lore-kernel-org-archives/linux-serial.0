From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 9/9] tty: serial_core: add tty NULL check in
 uart_port_startup
Date: Sun, 11 Sep 2016 22:20:43 +0100
Message-ID: <20160911222043.50848f95@lxorguk.ukuu.org.uk>
References: <20160909223711.26238-1-robh@kernel.org>
        <20160909223711.26238-10-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160909223711.26238-10-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri,  9 Sep 2016 17:37:10 -0500
Rob Herring <robh@kernel.org> wrote:

> If we don't have a tty when calling uart_port_startup, skip the baudrate
> and modem control setup which depend on tty->termios struct. Either
> tty_port clients will configure the line in a separate call or we'll
> move termios into the tty_port.

I don't think getting rid of the tty object makes any sense whatsoever
just create a kernel one.

Either way the giant churny patch and this hack should be deferred in
favour of moving the termios structure into the tty port (and the locks
for it) and doing the right job once.

The termios does I agree belong in the tty_port so irrespective of final
direction fixing that is a right move.

Alan
