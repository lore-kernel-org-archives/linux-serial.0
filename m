From: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Subject: Re: [PATCH v3] tty: serial: 8250: add MOXA Smartio MUE boards support
Date: Sat, 14 Jan 2017 21:38:02 +0300
Message-ID: <CAJs94EaztHrH1WD7RurYhzjavj=21_wSTwJzm+fF8Hs22YZ6ew@mail.gmail.com>
References: <1456341022-8897-1-git-send-email-m.othacehe@gmail.com>
 <56E68636.8000002@gmail.com> <20160319090723.GA8678@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160319090723.GA8678@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu OTHACEHE <m.othacehe@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, anton.wuerfel@fau.de, phillip.raffeck@fau.de, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Peter H <hpeter@gmail.com>, Soeren Grunewald <soeren.grunewald@desy.de>, Wang YanQing <udknight@gmail.com>, Jan Beulich <JBeulich@suse.com>, linux-serial@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi,

I am currently reading misc stuff in serial/8250/.
What is the reason why 8250_moxa ever exists? I mean, it seems that
8250_pci module does the same as 8250_moxa does.

2016-03-19 12:07 GMT+03:00 Mathieu OTHACEHE <m.othacehe@gmail.com>:
> Hi,
>
> Sorry about late reply.
>
> No I haven't planned to do it soon. Your board is supported by mxser driver (drivers/tty/mxser.c).
> I think it would be nice to move everything from mxser.c to 8250_moxa.c.
>
> The problem is mxser supports ISA and PCI boards and I don't have the hardware to test it.
>
> Mathieu



-- 
With best regards,
Matwey V. Kornilov
http://blog.matwey.name
xmpp://0x2207@jabber.ru
