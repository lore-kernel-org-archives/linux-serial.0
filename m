From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH v2 0/5] minitty: a minimal TTY layer alternative for
 embedded systems
Date: Mon, 03 Apr 2017 19:05:19 +0100
Message-ID: <1491242719.3704.33.camel@linux.intel.com>
References: <20170401222119.25106-1-nicolas.pitre@linaro.org>
         <CAHp75VdGm2uVPBhfAge4Wx6WW2y52oddpOSfJgdYAfTUQPN7TQ@mail.gmail.com>
         <alpine.LFD.2.20.1704021149550.1847@knanqh.ubzr>
         <1491224186.3704.11.camel@linux.intel.com>
         <alpine.LFD.2.20.1704031121520.1847@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.20.1704031121520.1847@knanqh.ubzr>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Rob Herring <robh@kernel.org>, Peter Hurley <peter@hurleysoftware.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

> evertheless very convenient to be able to use a standard
> shell 
> with it.

A standard shell will work over things other than a tty device. It
really doesn't care so long as it gets a stream of data punctuated by
end of statement symbols. It'll work over pipes, sockets, from files.

> I beg to disagree here.  First, before you call my code "totally 
> unmaintainable" I'd politely ask you to have a look at it first.

I said the combination makes it more unmaintainable. If you have two
tty layers one of them faking the API of the other at various interface
points then if the core tty layer wants to make a major change it no
longer can - because it'll break the other tty layer. In addition I
worry it won't be long before someone wants kgdb, gdbstubs and sysrq
over the cut down console and on it will go.

The uart layer is also known broken as an API - it is itself bloated
and over-locking (for example if it was being written today kfifo would
be used). What happens if we want to abolish it or encourage people to
move away from it (as we IMHO should be) ?

The serio code started with exactly the same problem, but now at least
talks tty layer. In your case you are tying it to something we
eventually ought to get rid of.

I also find the large scale need for it hard to believe. If you are
within 64K of running out of memory on your debug/devel device how are
you going to have space to fix security holes and do upgrades as they
occur in production (where presumably you don't need the tty driver) ?
The kernel doesn't exactly get smaller each release.

Alan
