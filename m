From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH v2 4/5] serial: split generic UART driver helper functions
 into a separate file
Date: Sun, 2 Apr 2017 11:44:45 -0400 (EDT)
Message-ID: <alpine.LFD.2.20.1704021116250.1847@knanqh.ubzr>
References: <20170401222119.25106-1-nicolas.pitre@linaro.org> <20170401222119.25106-5-nicolas.pitre@linaro.org> <CAHp75Ve_O03CQQErkaHPyAbxrQFe=uWf7mmmZuJ+rVNJysqGSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Ve_O03CQQErkaHPyAbxrQFe=uWf7mmmZuJ+rVNJysqGSg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Sun, 2 Apr 2017, Andy Shevchenko wrote:

> On Sun, Apr 2, 2017 at 1:21 AM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > This contains code that is common between serial_core.c and the
> > minitty code to come. Mainly helper functions used by UART drivers.
> 
> 
> I have two questions:
> - why minitty (what is that by the way?) can't use serial_core.c as a library?

See patch 5/5. It is a compatible replacement for serial_core.c and the 
entire TTY layer collapsed into the smallest code possible, and the 
result is itself smaller than serial_core.c alone.

> - does -M -C help to make this diff shorter?

No it doesn't. Maybe I should have mentioned that there is no functional 
change resulting from this patch.


Nicolas
