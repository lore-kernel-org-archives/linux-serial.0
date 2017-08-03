From: Oleksandr Shamray <oleksandrs-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>
Subject: RE: [patch v1 0/2] JTAG driver introduction
Date: Thu, 3 Aug 2017 15:26:08 +0000
Message-ID: <AM4PR0501MB2194E6B8D14EC15356C1C0BFB1B10@AM4PR0501MB2194.eurprd05.prod.outlook.com>
References: <1501679918-20486-1-git-send-email-oleksandrs@mellanox.com>
 <20170802141209.GB25781@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170802141209.GB25781-g2DYL2Zd6BY@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Cc: "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "jiri-rHqAuBHg3fBzbRFIqnYvSA@public.gmane.org" <jiri-rHqAuBHg3fBzbRFIqnYvSA@public.gmane.org>, system-sw-low-level <system-sw-low-level-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>, "openbmc-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <openbmc-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "mec-WqBc5aa1uDFeoWH0uzbU5w@public.gmane.org" <mec-WqBc5aa1uDFeoWH0uzbU5w@public.gmane.org>, "joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org" <joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "vadimp-45czdsxZ+A5DPfheJLI6IQ@public.gmane.org" <vadimp-45czdsxZ+A5DPfheJLI6IQ@public.gmane.org>, "tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org" <tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

> -----Original Message-----
> From: Andrew Lunn [mailto:andrew-g2DYL2Zd6BY@public.gmane.org]
> Sent: Wednesday, August 2, 2017 5:12 PM
> To: Oleksandr Shamray <oleksandrs-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>
> Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org; arnd-r2nGTMty4D4@public.gmane.org; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org=
;
> jiri-rHqAuBHg3fBzbRFIqnYvSA@public.gmane.org; system-sw-low-level <system-sw-low-level-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>;
> openbmc-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; mec-WqBc5aa1uDFeoWH0uzbU5w@public.gmane.org;
> joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org; linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; vadimp-45czdsxZ+A5DPfheJLI6IQ@public.gmane.org;
> tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> Subject: Re: [patch v1 0/2] JTAG driver introduction
>=20
> On Wed, Aug 02, 2017 at 04:18:36PM +0300, Oleksandr Shamray wrote:
> > When a need raise up to use JTAG interface for system's devices
> > programming or CPU debugging, it could be done from the external JTAG
> > master controller.
> >
> > For such purpose, usually the user layer application implements jtag
> > protocol or using a proprietary connection to vendor hardware.
> > This method is slow and not generic.
> >
> > We propose to implement general JTAG interface and infrastructure to
> > communicate with user layer application. In such way, we can have the
> > standard JTAG interface core part and separation from specific HW
> > implementation.
> > This allow new capability to debug the CPU or program system's device
> > via BMC without additional devices nor cost.
>=20
> Hi Oleksandr
>=20
> Do you have patches for OpenOCD? Or maybe i should ask it another way, wh=
at
> user space tools are you using?
>=20
> Thanks
> 	Andrew

Hi Andrew

Thanks a lot for review.

We used user space tool for that, which is an adaptation of some Lattice to=
ols, which allows programming of SVF files. We are using it for Lattice CPL=
D burning, since we have for such devices on our system, but this tool coul=
d be used for programming other devices from other vendors as well.

https://github.com/mellanoxbmc/mellanox-bmc-tools

Thanks
Oleksandr


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
