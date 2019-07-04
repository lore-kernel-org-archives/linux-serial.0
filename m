From: Je Yen Tam <je.yen.tam@ni.com>
Subject: RE: Re: [PATCH V2 2/2] PCI: Add NI-Serial PXI/PXIe+485 device IDs
Date: Thu, 4 Jul 2019 06:58:39 +0000
Message-ID: <MN2PR04MB5920BB86A99B1ABF946B2373B7FA0@MN2PR04MB5920.namprd04.prod.outlook.com>
References: <20190703072516.34199-1-je.yen.tam@ni.com>
 <20190703083605.GA8996@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190703083605.GA8996@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

> On Wed, Jul 03, 2019 at 12:25:16AM -0700, jeyentam wrote:
> > Add NI PXIe-RS232, PXI-RS485 and PXIe-RS485 device IDs.
> >
> > Signed-off-by: jeyentam <je.yen.tam@ni.com>
> > ---
> >  include/linux/pci_ids.h | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
>=20
> You have read the comment at the top of this file, right?  If so, why=20
> are you adding these entries?

Yes, but I think these entries should be added in because the NI-Serial PXI=
=20
(RS232) device IDs already been defined in this file originally, so now I'm=
=20
adding the newly supported NI-Serial PXI (RS485), PXIe (RS232) and PXIe=20
(RS485) device IDs into here as they are the same product.

>=20
> > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h index=20
> > 70e86148cb1e..7fad4794789f 100644
> > --- a/include/linux/pci_ids.h
> > +++ b/include/linux/pci_ids.h
> > @@ -1027,7 +1027,9 @@
> >  #define PCI_DEVICE_ID_SUN_TOMATILLO	0xa801
> >  #define PCI_DEVICE_ID_SUN_CASSINI	0xabba
> >
> > +/* NI-Serial Device IDs */
> >  #define PCI_VENDOR_ID_NI		0x1093
>=20
> That's a vendor id, not a serial device id.

Yes, will change it to vendor id.

>=20
> thanks,
>=20
> greg k-h


Thank you.
Regards,
Je Yen Tam
Staff Software Engineer
National Instruments=A0
o=A0=A0 604-3776397
e=A0=A0 je.yen.tam@ni.com
