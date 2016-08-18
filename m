From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Thu, 18 Aug 2016 13:14:08 +0200
Message-ID: <23B59EBB-DD4E-4F79-8294-BCE1BE7B9888@goldelico.com>
References: <20160818011445.22726-1-robh@kernel.org> <118926C8-F4D0-41F5-B6A8-690E0312F3FB@goldelico.com> <20160818104749.GB7427@amd> <1ED14975-FC0C-44AB-8F05-782DBC9E98F8@goldelico.com> <20160818105759.GA642@kroah.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160818105759.GA642-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hi Greg,

> Am 18.08.2016 um 12:57 schrieb Greg Kroah-Hartman =
<gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>:
>=20
> On Thu, Aug 18, 2016 at 12:54:15PM +0200, H. Nikolaus Schaller wrote:
>> Hi Pavel,
>>=20
>>> Am 18.08.2016 um 12:47 schrieb Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>:
>>>=20
>>>=20
>>>>=20
>>>> Thereof 4 files, ~260 changes w/o gps demo and =
documentation/bindings.
>>>=20
>>> So what do you use for the serial devices? platform_device was =
vetoed
>>> for that purpose by Greg.
>>=20
>> device tree?
>=20
> No.

? Sorry, but each time Pavel jumps in, he just copies half of a =
statement and
any reply gets misunderstood.

I did not even mention platform_device, still you disagree to device =
tree for the
*slave driver*?

>=20
> This patchset from Rob is the way I have been saying it should be done
> for years now.  Yes, a "bus" takes up more boilerplate code (blame me
> for that), but overall, it makes the drivers simpler,

Sorry, but I don't see how Rob's approach makes it simpler to write a =
device driver
than our original proposal, which btw is also sort of a bus and I see =
only some implementation
differences.

Except that IMHO Rob's approach lacks functions we need (which maybe can =
added).

> and fits into the
> rest of the kernel driver/device model much better.

BR and thanks,
Nikolaus=
