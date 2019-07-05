From: Je Yen Tam <je.yen.tam@ni.com>
Subject: RE: Re: [PATCH v3] serial/8250: Add support for NI-Serial PXI/PXIe+485
 devices
Date: Fri, 5 Jul 2019 09:24:31 +0000
Message-ID: <MN2PR04MB592075355D90BC59B79DFCF8B7F50@MN2PR04MB5920.namprd04.prod.outlook.com>
References: <20190705083349.44047-1-je.yen.tam@ni.com>
 <20190705090422.GA32289@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190705090422.GA32289@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

> On Fri, Jul 05, 2019 at 01:33:49AM -0700, jeyentam wrote:
> > Add support for NI-Serial PXIe-RS232, PXI-RS485 and PXIe-RS485 devices.
> >
> > Signed-off-by: Je Yen Tam <je.yen.tam@ni.com>
> > ---
> >  drivers/tty/serial/8250/8250_pci.c | 298 ++++++++++++++++++++++++++++-
> >  1 file changed, 294 insertions(+), 4 deletions(-)
>=20
> What changed from the previous versions?
>=20
> Always put that below the --- line.
>=20
> Please fix up and send a v4 with that information.

Ok, will do so.

>=20
> thanks,
>=20
> greg k-h
