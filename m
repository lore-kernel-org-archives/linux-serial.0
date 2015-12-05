From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH LINUX v3 00/10] tty: xuartps: Fix lock ups
Date: Sat, 5 Dec 2015 14:02:36 -0800
Message-ID: <20151205220236.GO4900@xsjsorenbubuntu>
References: <1448161172-19717-1-git-send-email-soren.brinkmann@xilinx.com>
 <56632393.8090809@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56632393.8090809@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Michal Simek <michal.simek@xilinx.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sat, 2015-12-05 at 12:49PM -0500, Peter Hurley wrote:
> On 11/21/2015 09:59 PM, Soren Brinkmann wrote:
> > Hi,
> >=20
> > here is v3 of this series. It's largely the same as before, but I
> > adjusted 'tty: xuartps: Don't consider circular buffer when enablin=
g
> > transmitter' according to Peter's suggestions.
>=20
> In reviewing this series, I thought the _OFFSET suffix for every regi=
ster
> address to be excessive. I would refactor all that out; IOW,
>=20
> -	isrstatus =3D readl(port->membase + CDNS_UART_ISR_OFFSET);
> +	isrstatus =3D readl(port->membase + CDNS_UART_ISR);

I'll add that as a patch on top of everything.

>=20
>=20
> > I also spent some time trying to get Peter's test for flow control =
and
> > xchar running. The xchar thing fails and will need some more work, =
but I
> > think in general it should be possible to get it to work.
> > The flow control test passes:
> >=20
> > root@Xilinx-ZC1751-DC1:~# ./flow /dev/ttyPS0
> > Test flow control on /dev/ttyPS0
> > begin test1
> > patterns sent: 223  recvd: 208
> > read distribution: 1   =3D 0
> >                    2+  =3D 0
> >                    4+  =3D 0
> >                    8+  =3D 0
> >                   16+  =3D 0
> >                   32+  =3D 643
> >                   64+  =3D 0
> >                  128+  =3D 0
> >                  256+  =3D 0
> >                  512+  =3D 0
> > PASSED
>=20
> This distribution looks like this exactly because the xchar test is
> failing. IOW, this driver isn't performing soft flow control (^S,^Q)
> like it should.

I tried to the your xchar test working, but so far that failed. I'll tr=
y
to spend some more time on this.

	Thanks,
	S=C3=B6ren
