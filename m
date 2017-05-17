From: "A.S. Dong" <aisheng.dong@nxp.com>
Subject: RE: [V2, 2/6] tty: serial: lpuart: add little endian 32 bit register
 support
Date: Wed, 17 May 2017 06:01:37 +0000
Message-ID: <AM3PR04MB306D5C86AED120D15C4D46A80E70@AM3PR04MB306.eurprd04.prod.outlook.com>
References: <1494834539-17523-3-git-send-email-aisheng.dong@nxp.com>
 <b4a2ed13-c71f-c973-3b09-b632e083a88b@cogentembedded.com>
 <20170517033139.GB9913@b29396-OptiPlex-7040>
 <48819894-4943-7d14-ccf8-83cfd2195c9a@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <48819894-4943-7d14-ccf8-83cfd2195c9a@cogentembedded.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>, Dong Aisheng <dongas86@gmail.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Andy Duan <fugang.duan@nxp.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "Y.B. Lu" <yangbo.lu@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stefan@agner.ch" <stefan@agner.ch>, Mingkai Hu <mingkai.hu@nxp.com>, "jslaby@suse.com" <jslaby@suse.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

> -----Original Message-----
> From: Nikita Yushchenko [mailto:nikita.yoush@cogentembedded.com]
> Sent: Wednesday, May 17, 2017 1:44 PM
> To: Dong Aisheng
> Cc: A.S. Dong; linux-serial@vger.kernel.org; Andy Duan;
> gregkh@linuxfoundation.org; Y.B. Lu; linux-kernel@vger.kernel.org;
> stefan@agner.ch; Mingkai Hu; jslaby@suse.com; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [V2, 2/6] tty: serial: lpuart: add little endian 32 bit
> register support
>=20
> >>> @@ -2000,6 +2007,7 @@ static int lpuart_probe(struct platform_device
> *pdev)
> >>>  	}
> >>>  	sport->port.line =3D ret;
> >>>  	sport->lpuart32 =3D sdata->is_32;
> >>> +	lpuart_is_be =3D sdata->is_be;
> >>
> >> Setting a global variable in per-device routine is quite bad design.
> >>
> >
> > There is a reason for that we don't want to change the exist
> > lpuart32_read[write] API which is widely used in driver.
> > Making a global lpuart_is_be is the simplest way to do it.
> >
> > Any strong blocking reason?
>=20
> Code should be consistent.
>=20

Yes.

> There is no good reason to have sport->lpuart32 inside sport, but
> lpuart_is_be outside of it. Both these values describe properties of
> particular device, and thus should be in per-device structure.
>=20

That's for special case, normally we wouldn't do that.

> If that implies adding sport arg to lpuart32_(read|write), just do that.

There's another reason that we have to deal with earlycon which is
executed much early before driver probe.

And I need specificly align the endian data.
e.g.
static int __init lpuart32_early_console_setup(struct earlycon_device *devi=
ce,
                                          const char *opt)
{
        if (!device->port.membase)
                return -ENODEV;

        lpuart_is_be =3D true;
        device->con->write =3D lpuart32_early_write;
        return 0;
}

static int __init lpuart32_imx_early_console_setup(struct earlycon_device *=
device,
                                                   const char *opt)
{
        if (!device->port.membase)
                return -ENODEV;

        lpuart_is_be =3D false;
        device->port.membase +=3D IMX_REG_OFF;
        device->con->write =3D lpuart32_early_write;

        return 0;
}

Regards
Dong Aisheng
