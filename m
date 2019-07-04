From: Je Yen Tam <je.yen.tam@ni.com>
Subject: RE: Re: Re: [PATCH V2 2/2] PCI: Add NI-Serial PXI/PXIe+485 device IDs
Date: Thu, 4 Jul 2019 08:17:38 +0000
Message-ID: <MN2PR04MB5920DFD232850F4F2CB28C47B7FA0@MN2PR04MB5920.namprd04.prod.outlook.com>
References: <20190703072516.34199-1-je.yen.tam@ni.com>
 <20190703083605.GA8996@kroah.com>
 <MN2PR04MB5920BB86A99B1ABF946B2373B7FA0@MN2PR04MB5920.namprd04.prod.outlook.com>
 <20190704081615.GB6438@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190704081615.GB6438@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Thursday, July 4, 2019 4:16 PM
> To: Je Yen Tam <je.yen.tam@ni.com>
> Cc: linux-serial@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [EXTERNAL] Re: Re: [PATCH V2 2/2] PCI: Add NI-Serial PXI/PXIe+48=
5 device
> IDs
>=20
> On Thu, Jul 04, 2019 at 06:58:39AM +0000, Je Yen Tam wrote:
> > > On Wed, Jul 03, 2019 at 12:25:16AM -0700, jeyentam wrote:
> > > > Add NI PXIe-RS232, PXI-RS485 and PXIe-RS485 device IDs.
> > > >
> > > > Signed-off-by: jeyentam <je.yen.tam@ni.com>
> > > > ---
> > > >  include/linux/pci_ids.h | 12 ++++++++++++
> > > >  1 file changed, 12 insertions(+)
> > >
> > > You have read the comment at the top of this file, right?  If so, why
> > > are you adding these entries?
> >
> > Yes, but I think these entries should be added in because the NI-Serial=
 PXI
> > (RS232) device IDs already been defined in this file originally, so now=
 I'm
> > adding the newly supported NI-Serial PXI (RS485), PXIe (RS232) and PXIe
> > (RS485) device IDs into here as they are the same product.
>=20
> No, do not add new device ids to this file, only put them in the single
> file that needs it.  This file is for device ids that are shared across
> multiple drivers/files.
>=20
> You should not need to touch this file at all.

Ok, understood. Will do so.

>=20
> thanks,
>=20
> greg k-h

Thank you,
Je Yen
