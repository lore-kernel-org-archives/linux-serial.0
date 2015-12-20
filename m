From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v3] serial: 8250: add gpio support to exar
Date: Sun, 20 Dec 2015 17:28:51 +0000
Message-ID: <20151220172851.1b560da8@lxorguk.ukuu.org.uk>
References: <1450617891-26167-1-git-send-email-sudipm.mukherjee@gmail.com>
	<CAHp75Vfn_mr0hW71xsTCvDGX87ktPaN2E1TVTNjdbxR83-nxcg@mail.gmail.com>
	<20151220144722.GA26499@sudip-pc>
	<20151220164131.46fb25ee@lxorguk.ukuu.org.uk>
	<20151220171104.GA8471@sudip-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151220171104.GA8471@sudip-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

> > If you are linking it into the driver you don't need the module_init/exit
> > gpio_init/exit methods. Your Kconfig becomes a bool and you combine the
> > file into the driver based upon that bool.
> 
> But isn't it better to have the gpio code separete from the 8250 code?
> But how do i combine a file? is it like:
> 
> #ifdef SERIAL_8250_EXAR_GPIO
> #include "8250_gpio.c"
> #endif
> 
> or should it be:
> 
> #ifdef SERIAL_8250_EXAR_GPIO
> 
> all c code
> 
> #endif

Neither of the above. Take a look how other parts of the kernel combine
multiple files into a single module. It's supported by the
Kconfig/Makefile system, and they will get linked together as a single
binary while being separate sources.

For an example look at drivers/tty/ipwireless



Alan
