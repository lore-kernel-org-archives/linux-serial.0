From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 00/11] serial: 8250: split LPSS to 8250_lpss, enable
 DMA on Quark
Date: Mon, 13 Jun 2016 14:16:17 +0300
Message-ID: <1465816577.30123.8.camel@linux.intel.com>
References: <1462547840-14091-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1463065601.17131.319.camel@linux.intel.com>
	 <1463620733.4224.75.camel@nexus-software.ie>
	 <1464111448.31269.67.camel@linux.intel.com>
	 <1464113301.31269.79.camel@linux.intel.com>
	 <1464280589.2351.19.camel@nexus-software.ie>
	 <CAHp75VczbhPEvp6gn-5hPFdSGscNeyZMzPQWeeB1Xza1mHD8dw@mail.gmail.com>
	 <1465751587.15050.23.camel@nexus-software.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465751587.15050.23.camel@nexus-software.ie>
Sender: linux-kernel-owner@vger.kernel.org
To: Bryan O'Donoghue <pure.logic@nexus-software.ie>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Peter Hurley <peter@hurleysoftware.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Vinod Koul <vinod.koul@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine <dmaengine@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Puustinen, Ismo" <ismo.puustinen@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On Sun, 2016-06-12 at 18:13 +0100, Bryan O'Donoghue wrote:
> On Tue, 2016-06-07 at 13:04 +0300, Andy Shevchenko wrote:
> > > I'll find some time to look at both a short stream and a long
> > stream,
> > > based on the branch you've indicated and maybe against the latest
> > > stable kernel.
> >=20
> > Please, do. I'm planning to resend new version soon (this week or
> > lately beginning of the next one).
>=20
> So.
>=20
> Generally DMA appears to make little-to-no difference here.

Yes, because your test shows the speed of the serial data line.

What we are trying to measure here?

If you would like to measure CPU load it will require threaded
application and some load task to see the difference. Another metric
which may help is interrupt counters. I'm wondering if perf can help
here as well.

> One thing I have noticed is that the following never completes and
> can't be reset back to mode=3D0 or mode=3D3 to restore functionality =
-
> definitely worth looking at if you are spinning another patch.
>=20
> ### never completes ####
> root@galileo:~# echo 1 > /sys/class/tty/ttyS0/dma_mode
> root@galileo:~# stty -F /dev/ttyS0 921600
> root@galileo:~# time cat tester.txt > /dev/ttyS0
> ### never completes ####

Thanks for that test, I will try to reproduce on my side.

--=C2=A0
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
