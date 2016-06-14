From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RFC RESEND] serial: 8250: fix regression in 8250 uart driver
Date: Tue, 14 Jun 2016 12:40:20 +0300
Message-ID: <1465897220.30123.26.camel@linux.intel.com>
References: <575F7325.3030907@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <575F7325.3030907@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dinh Nguyen <dinguyen@kernel.org>
Cc: heikki.krogerus@linux.intel.com, peter@hurleysoftware.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, 2016-06-13 at 21:59 -0500, Dinh Nguyen wrote:
> Apologies, but my original email bounced for Andy and Heikki,
> resending.
> ----

I suppose this one, i.e. commit dd4e91d538b3 ("dmaengine: slave means a=
t
least one of DMA_SLAVE, DMA_CYCLIC"), solves the issue.

>=20
> Hi Andy,
>=20
> I saw that you have discovered that commit ec5a11a91eec ("serial:
> 8250:
> Validate dmaengine rx chan meets requirements") introduced a
> regression
> in the 8250 uart driver. For SoCFPGA platform, I am seeing this error=
:
>=20
> [=C2=A0=C2=A0=C2=A0=C2=A05.541751] ttyS0 - failed to request DMA
>=20
> Reverting the commit ec5a11a91eec removes the error.
>=20
> I saw that you started the discussion, but I didn't see that a patch
> was
> included[1].
>=20
> The following patch seems to fix the error, but I'm not sure if it's
> the
> same fix that you had in mind.
>=20
> Thanks,
> Dinh
>=20
> [1] http://marc.info/?l=3Dlinux-serial&m=3D146254187602862&w=3D2
>=20
> ---------------8<------------
> diff --git a/drivers/tty/serial/8250/8250_dma.c
> b/drivers/tty/serial/8250/8250_dma.c
> index 7f33d1c..847a203 100644
> --- a/drivers/tty/serial/8250/8250_dma.c
> +++ b/drivers/tty/serial/8250/8250_dma.c
> @@ -176,7 +176,7 @@ int serial8250_request_dma(struct uart_8250_port
> *p)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D dma_get_slave=
_caps(dma->rxchan, &caps);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0goto release_rx;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!caps.cmd_pause || !ca=
ps.cmd_terminate ||
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if ((!caps.cmd_pause || !c=
aps.cmd_terminate) &&
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0caps.residue_granularity =3D=3D
> DMA_RESIDUE_GRANULARITY_DESCRIPTOR) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D -EINVAL;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0goto release_rx;

--=20

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
