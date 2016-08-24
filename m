From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] tty: serial_core: convert uart_open to use
 tty_port_open
Date: Wed, 24 Aug 2016 14:46:44 +0100
Message-ID: <20160824144644.43543830@lxorguk.ukuu.org.uk>
References: <20160822223910.24453-1-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160822223910.24453-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

On Mon, 22 Aug 2016 17:39:09 -0500
Rob Herring <robh@kernel.org> wrote:

> tty_port_open handles much of the common parts of tty opening. Convert
> uart_open to use it and move the serial_core specific parts into
> tty_port.activate function. This will be needed to use tty_port functions
> directly from in kernel clients.
> 
> The tricky part is uart_port_startup can return positive values to allow
> setserial to configure the port. We now return the positive value to
> tty_port_open so that the tty is not marked as initialized and then set the
> return value in uart_open to 0.
> 
> Cc: Alan Cox <alan@linux.intel.com>
> Cc: Peter Hurley <peter@hurleysoftware.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> In looking at using tty_port for uart slaves, this is the first thing I 
> hit. serial_core doesn't even use the 2 functions that already exist for 
> tty_port and are needed.
> 
> I've tested this on QEMU with pl011 and 8250 UARTs using setserial, but 
> I'm not sure what are all the tricky cases to handle.
> 
> Greg, Don't apply these without comment from Alan and Peter.

Originally I didn't convert them because the lockign was incompatible.
That looks to have been fixed by other changes. This is definitely the
right direction irrespective of the uart slave discussion.

Acked-by: Alan Cox <alan@linux.intel.com>
