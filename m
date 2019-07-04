From: Je Yen Tam <je.yen.tam@ni.com>
Subject: RE: Re: Re: [PATCH V2 1/2] serial/8250: Add support for NI-Serial
 PXI/PXIe+485 devices
Date: Thu, 4 Jul 2019 08:20:44 +0000
Message-ID: <MN2PR04MB59200003FF168C024B90C3F0B7FA0@MN2PR04MB5920.namprd04.prod.outlook.com>
References: <20190703072435.34152-1-je.yen.tam@ni.com>
 <20190703084220.GD8996@kroah.com>
 <MN2PR04MB59207BEC9DBAB5E69656DD42B7FA0@MN2PR04MB5920.namprd04.prod.outlook.com>
 <20190704081500.GA6438@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190704081500.GA6438@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Thursday, July 4, 2019 4:15 PM
> To: Je Yen Tam <je.yen.tam@ni.com>
> Cc: linux-serial@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [EXTERNAL] Re: Re: [PATCH V2 1/2] serial/8250: Add support for N=
I-Serial
> PXI/PXIe+485 devices
>=20
> On Thu, Jul 04, 2019 at 07:55:33AM +0000, Je Yen Tam wrote:
> > > On Wed, Jul 03, 2019 at 12:24:35AM -0700, jeyentam wrote:
> > > > Add support for NI-Serial PXIe-RS232, PXI-RS485 and PXIe-RS485 devi=
ces.
> > > >
> > > > Signed-off-by: jeyentam <je.yen.tam@ni.com>
> > >
> > > I need a "full" name here please.
> >
> > Ok, will do so.
> >
> > >
> > > Also, this patch breaks the build, which is not allowed, and makes me=
 wonder
> how
> > > you tested it :(
> >
> > I've tested my changes with the steps as follows, it did not break.
> >
> > 1. Clone the Linux repo, check out the source and work on my project.
> > 2. Compile the kernel source with "make j4".
> > 3. Build the kernel modules with "make modules_install".
> > 4. Install the kernel with "make install".
> > 5. Reboot into the newly built kernel.
> > 6. The kernel worked well and able to fit my needs.
> >
> > Noted that my source is checked out from the latest Linux kernel 5.2.0-=
rc6.
> >
> > Also, I checked my patch using checkpatch.pl, it did not show any error=
s and
> > warnings too.
> >
> > May I know what do you mean by breaking the build?
>=20
> If you only apply patch 1/2, the build breaks as you add new device ids
> in the second patch.  At every individual patch, you can not break the
> build.

Understood, will move the #defines into this file which needed it.

>=20
> thanks,
>=20
> greg k-h
