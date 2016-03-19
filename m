From: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Subject: Re: [PATCH v3] tty: serial: 8250: add MOXA Smartio MUE boards support
Date: Sat, 19 Mar 2016 12:13:39 +0300
Message-ID: <CAJs94Eah9uXVMuXDb-Upd=v-ZTGkXivBD8c0Zbzg5UWDcU9r_g@mail.gmail.com>
References: <1456341022-8897-1-git-send-email-m.othacehe@gmail.com>
 <56E68636.8000002@gmail.com> <20160319090723.GA8678@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160319090723.GA8678@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu OTHACEHE <m.othacehe@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, andriy.shevchenko@linux.intel.com, anton.wuerfel@fau.de, phillip.raffeck@fau.de, heikki.krogerus@linux.intel.com, Peter H <hpeter@gmail.com>, Soeren Grunewald <soeren.grunewald@desy.de>, Wang YanQing <udknight@gmail.com>, Jan Beulich <JBeulich@suse.com>, linux-serial@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

2016-03-19 12:07 GMT+03:00 Mathieu OTHACEHE <m.othacehe@gmail.com>:
> Hi,
>
> Sorry about late reply.
>
> No I haven't planned to do it soon. Your board is supported by mxser driver (drivers/tty/mxser.c).
> I think it would be nice to move everything from mxser.c to 8250_moxa.c.

Last time when I tried to run my moxa PCI board with 3.1(?) and mxser
it deadlocked my PC from time to time.
8250_moxa implementation is much more cleaner.

>
> The problem is mxser supports ISA and PCI boards and I don't have the hardware to test it.
>
> Mathieu



-- 
With best regards,
Matwey V. Kornilov
http://blog.matwey.name
xmpp://0x2207@jabber.ru
