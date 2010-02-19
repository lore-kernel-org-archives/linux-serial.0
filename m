From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 2/2] Add DMA support for the sh-sci.c serial driver
Date: Fri, 19 Feb 2010 10:56:11 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1002191053220.4594@axis700.grange>
References: <Pine.LNX.4.64.1002181624190.4373@axis700.grange>
 <Pine.LNX.4.64.1002181726230.4373@axis700.grange>
 <d6a0f7aa1002190147u57a4d88g42b376eb8891e44d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <d6a0f7aa1002190147u57a4d88g42b376eb8891e44d@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Magnus Damm <damm@opensource.se>, Dan Williams <dan.j.williams@intel.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, 19 Feb 2010, Govindraj wrote:

> > + =A0 =A0 =A0 chan =3D dma_request_channel(mask, filter, param);
> > + =A0 =A0 =A0 dev_dbg(port->dev, "%s: RX: got channel %p\n", __func=
__, chan);
>=20
>=20
> If dma channel allocation fails how this scenario will be handled,
> There is an possibility of dma_request_channel returning -EBUSY,

Really? How? I thought it could only return a pointer to a channel or a=
=20
NULL? And if it fails, i.e., chan =3D=3D NULL, the whole code just stay=
s=20
inactive and the driver falls back to normal PIO.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
=46reelance Open-Source Software Developer
http://www.open-technology.de/
