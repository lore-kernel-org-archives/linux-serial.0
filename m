From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH v2 0/5] minitty: a minimal TTY layer alternative for
 embedded systems
Date: Tue, 4 Apr 2017 15:26:00 -0400 (EDT)
Message-ID: <alpine.LFD.2.20.1704041454450.1847@knanqh.ubzr>
References: <20170401222119.25106-1-nicolas.pitre@linaro.org> <CAHp75VdGm2uVPBhfAge4Wx6WW2y52oddpOSfJgdYAfTUQPN7TQ@mail.gmail.com> <alpine.LFD.2.20.1704021149550.1847@knanqh.ubzr> <1491224186.3704.11.camel@linux.intel.com> <alpine.LFD.2.20.1704031121520.1847@knanqh.ubzr>
 <1491242719.3704.33.camel@linux.intel.com> <alpine.LFD.2.20.1704031433480.1847@knanqh.ubzr> <1491313228.3704.42.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-944314857-1491333890=:1847"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1491313228.3704.42.camel@linux.intel.com>
Content-ID: <alpine.LFD.2.20.1704041525290.1847@knanqh.ubzr>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Rob Herring <robh@kernel.org>, Peter Hurley <peter@hurleysoftware.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-944314857-1491333890=:1847
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.LFD.2.20.1704041525291.1847@knanqh.ubzr>

On Tue, 4 Apr 2017, Alan Cox wrote:

> > we're down to 5.6K. At which point there's only a raw device
> > interface 
> > to serial hardware.
> 
> Which if you did a simple plain chardev without trying to fake the
> rather out of date uart layer would come down way further still.

Oh absolutely. I don't dispute that. Given infinite time as you said.

But I gained a 5x reduction already. I would prefer moving to some other 
part of the kernel where another 5x reduction could be achieved now 
rather than postponing that after I'm done rewriting the interface for 
all UART drivers.  Maybe someone else will feel inspired and take on 
this UART driver modernizing task (that could be a nice mentorred 
project for example).

PS: FUZIX is a real piece of art  ;-)


Nicolas
--8323328-944314857-1491333890=:1847--
