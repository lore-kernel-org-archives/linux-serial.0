From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 00/11] serial: 8250: split LPSS to 8250_lpss, enable
 DMA on Quark
Date: Tue, 24 May 2016 20:37:28 +0300
Message-ID: <1464111448.31269.67.camel@linux.intel.com>
References: <1462547840-14091-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1463065601.17131.319.camel@linux.intel.com>
	 <1463620733.4224.75.camel@nexus-software.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463620733.4224.75.camel@nexus-software.ie>
Sender: linux-kernel-owner@vger.kernel.org
To: Bryan O'Donoghue <pure.logic@nexus-software.ie>, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ismo.puustinen@intel.com, Heikki Krogerus <heikki.krogerus@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On Thu, 2016-05-19 at 02:18 +0100, Bryan O'Donoghue wrote:
> On Thu, 2016-05-12 at 18:06 +0300, Andy Shevchenko wrote:
> > On Fri, 2016-05-06 at 18:17 +0300, Andy Shevchenko wrote:
> > > This is combined series of two things:
> > > - split out the Intel LPSS specific driver from 8250_pci into
> > > 8250_lpss
> > > - enable DMA support on Intel Quark UART
> > >=20
> > > The patch has been tested on few Intel SoCs / platforms. In any
> > > case I
> > > would
> > > like to ask Bryan to do independent test.
>=20
> Andy.
>=20
> It looks as though there's a performance drop when enabling the DMA
> here (v) stock PIO mode with the 8250 driver.

Below results doesn't show DMA case (by the way, how did you disable DM=
A
in 3.8.7?) for stock kernel.

Anyway, I added preliminary support to change DMA mode run-time. Check
my today topic/dw/qrk branch. It would be nice to see all 4 cases: DMA
vs non-DMA on stock kernel (Yocto) and mine.

P.S. What is the point to test arbitrary tip branch?

>=20
> Test setup Galileo Gen1 transmitter - Galileo Gen2 receiver. TX/RX
> cross-wired between the Arduino UART headers respectively (pins 0 & 1
> on the "Digital PWM" header), GND pin14 similarly cross-wired.
>=20
> User-space:
> =C2=A0=C2=A0=C2=A0=C2=A0Receiver: Stock on-flash yocto-tiny kernel 3.=
8.7
> =C2=A0=C2=A0=C2=A0=C2=A0Transmitter: Galileo Debian image :
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0https://sourceforge.net/projects/galil=
eodebian/
> =C2=A0=C2=A0=C2=A0=C2=A03.8.7 kernel: On SPI-flash BSP kernel
> =C2=A0=C2=A0=C2=A0=C2=A0andy-v4: From your tree
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0d13ffcf ('serial: 8250: attempt to keep Kconfig and
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Ma=
kefile in order')
> =C2=A0=C2=A0=C2=A0=C2=A0tip-of-tree : 97f0090 ('Merge tag 'rproc-v4.7=
' of
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0git://github.com/andersson/remoteproc')
>=20
> Results:
>=20
> ### Test0 ###
>=20
> galileo dma andy-v4 9600 8n1=C2=A0
>=20
> root@galileo:~# time echo "abcdefghijklmnopqrstuvwxyz0123456789" >
> /dev/ttyS0
>=20
> real=C2=A0=C2=A0=C2=A0=C2=A00m0.060s
> user=C2=A0=C2=A0=C2=A0=C2=A00m0.000s
> sys=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00m0.000s
>=20
>=20
> galileo non-dma Linux 3.8.7 9600 8n1:
>=20
> 9600 8n1
> root@galileo:~# time echo "abcdefghijklmnopqrstuvwxyz0123456789" >
> /dev/ttyS0
>=20
> real=C2=A0=C2=A0=C2=A0=C2=A00m0.051s
> user=C2=A0=C2=A0=C2=A0=C2=A00m0.000s
> sys=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00m0.000s
>=20
> galileo non-dma tip-of-tree 9600 8n1:
>=20
> root@galileo:~# time echo "abcdefghijklmnopqrstuvwxyz0123456789" >
> /dev/ttyS0
>=20
> real=C2=A0=C2=A0=C2=A0=C2=A00m0.048s
> user=C2=A0=C2=A0=C2=A0=C2=A00m0.000s
> sys=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00m0.000s
>=20
>=20
> ### Test1 ###
>=20
> galileo dma andy-v4 9600 8n1:
>=20
> root@galileo:~# time echo
> "abcdefghijklmnopqrstuvwxyz0123456789abcdefghijklmnopqrstuvwxyz012345=
6
> 7
> 89abcdefghijklmnopqrstuvwxyz0123456789abcdefghijklmnopqrstuvwxyz01234=
5
> 6
> 789abcdefghijklmnopqrstuvwxyz0123456789" > /dev/ttyS0
>=20
> real=C2=A0=C2=A0=C2=A0=C2=A00m0.209s
> user=C2=A0=C2=A0=C2=A0=C2=A00m0.000s
> sys=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00m0.000s
>=20
> galileo non-dma Linux 3.8.7 9600 8n1:
>=20
> root@galileo:~# time echo
> "abcdefghijklmnopqrstuvwxyz0123456789abcdefghijklmnopqrstuvwxyz012345=
6
> 7
> 89abcdefghijklmnopqrstuvwxyz0123456789abcdefghijklmnopqrstuvwxyz01234=
5
> 6
> 789abcdefghijklmnopqrstuvwxyz0123456789" > /dev/ttyS0
>=20
> real=C2=A0=C2=A0=C2=A0=C2=A00m0.206s
> user=C2=A0=C2=A0=C2=A0=C2=A00m0.000s
> sys=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00m0.000s
>=20
>=20
> galileo non-dma tip-of-tree 9600 8n1:
>=20
> root@galileo:~# time echo
> "abcdefghijklmnopqrstuvwxyz0123456789abcdefghijklmnopqrstuvwxyz012345=
6
> 7
> 89abcdefghijklmnopqrstuvwxyz0123456789abcdefghijklmnopqrstuvwxyz01234=
5
> 6
> 789abcdefghijklmnopqrstuvwxyz0123456789" > /dev/ttyS0
>=20
> real=C2=A0=C2=A0=C2=A0=C2=A00m0.199s
> user=C2=A0=C2=A0=C2=A0=C2=A00m0.010s
> sys=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00m0.000s
>=20
>=20
> ---
> bod

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
