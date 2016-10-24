From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference at
 00000000000001e0
Date: Mon, 24 Oct 2016 17:19:20 +0200
Message-ID: <1477322360.24975.5.camel@gmail.com>
References: <20161024144831.a4ieul22jck4vwk3@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161024144831.a4ieul22jck4vwk3@pd.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, 2016-10-24 at 16:48 +0200, Borislav Petkov wrote:
> Hi people,
> 
> typing "reboot" splats the following on the serial console. Ideas?

Very familiar, I bisected that to 761ed4a94582.  Workaround for the
nonce is to comment out..

	port->console = uart_console(uport);

..in drivers/tty/serial/serial_core.c::uart_add_one_port().

	-Mike
