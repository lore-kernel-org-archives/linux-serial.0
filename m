From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH LINUX v3 00/10] tty: xuartps: Fix lock ups
Date: Sat, 5 Dec 2015 12:49:07 -0500
Message-ID: <56632393.8090809@hurleysoftware.com>
References: <1448161172-19717-1-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448161172-19717-1-git-send-email-soren.brinkmann@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Soren Brinkmann <soren.brinkmann@xilinx.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Michal Simek <michal.simek@xilinx.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 11/21/2015 09:59 PM, Soren Brinkmann wrote:
> Hi,
>=20
> here is v3 of this series. It's largely the same as before, but I
> adjusted 'tty: xuartps: Don't consider circular buffer when enabling
> transmitter' according to Peter's suggestions.

In reviewing this series, I thought the _OFFSET suffix for every regist=
er
address to be excessive. I would refactor all that out; IOW,

-	isrstatus =3D readl(port->membase + CDNS_UART_ISR_OFFSET);
+	isrstatus =3D readl(port->membase + CDNS_UART_ISR);


> I also spent some time trying to get Peter's test for flow control an=
d
> xchar running. The xchar thing fails and will need some more work, bu=
t I
> think in general it should be possible to get it to work.
> The flow control test passes:
>=20
> root@Xilinx-ZC1751-DC1:~# ./flow /dev/ttyPS0
> Test flow control on /dev/ttyPS0
> begin test1
> patterns sent: 223  recvd: 208
> read distribution: 1   =3D 0
>                    2+  =3D 0
>                    4+  =3D 0
>                    8+  =3D 0
>                   16+  =3D 0
>                   32+  =3D 643
>                   64+  =3D 0
>                  128+  =3D 0
>                  256+  =3D 0
>                  512+  =3D 0
> PASSED

This distribution looks like this exactly because the xchar test is
failing. IOW, this driver isn't performing soft flow control (^S,^Q)
like it should.

Regards,
Peter Hurley

> root@Xilinx-ZC1751-DC1:~# ./flow /dev/ttyPS1
> Test flow control on /dev/ttyPS1
> begin test1
> patterns sent: 223  recvd: 208
> read distribution: 1   =3D 0
>                    2+  =3D 0
>                    4+  =3D 0
>                    8+  =3D 0
>                   16+  =3D 0
>                   32+  =3D 643
>                   64+  =3D 0
>                  128+  =3D 0
>                  256+  =3D 0
>                  512+  =3D 0
> PASSED
>=20
> 	S=C3=B6ren
>=20
> S=C3=B6ren Brinkmann (10):
>   tty: xuartps: Beautify read-modify writes
>   tty: xuartps: Use spinlock to serialize HW access
>   tty: xuartps: Don't consider circular buffer when enabling transmit=
ter
>   tty: xuartps: Clear interrupt status register in shutdown
>   tty: xuartps: Improve startup function
>   tty: xuartps: Keep lock for whole ISR
>   tty: xuartps: Acquire port lock for shutdown
>   tty: xuartps: Move RX path into helper function
>   tty: xuartps: Only handle RX IRQs when RX is enabled
>   tty: xuartps: Cleanup: Reformat if-else
>=20
>  drivers/tty/serial/xilinx_uartps.c | 246 +++++++++++++++++++++------=
----------
>  1 file changed, 137 insertions(+), 109 deletions(-)
>=20
