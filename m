From: Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH 0/4] pch_uart: Cleanups, board quirks, and user uartclk
 parameter
Date: Wed, 22 Feb 2012 17:25:40 +0800
Message-ID: <20120222092540.GA27282@feng-i7>
References: <cover.1329875301.git.dvhart@linux.intel.com>
 <CANKRQni9E6NO39MFSak6MjQ0DtmQeviGo966Ex9ZUvai56wCjg@mail.gmail.com>
 <4F4462B8.6030607@linux.intel.com>
 <CANKRQnhckD5Dt+0PbD3h=Ggz+U8RoDs0qUn5CgVnsYcH08tRkw@mail.gmail.com>
 <4F448DAA.6000207@linux.intel.com>
 <CANKRQngnFhTY3-YxhDH3oufbqUu5pe36Fi58DjKWm=9uTigr-A@mail.gmail.com>
 <4F44AE57.10302@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4F44AE57.10302@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Darren Hart <dvhart@linux.intel.com>
Cc: Tomoya MORINAGA <tomoya.rohm@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Feb 22, 2012 at 12:59:03AM -0800, Darren Hart wrote:
>=20
>=20
> On 02/22/2012 12:16 AM, Tomoya MORINAGA wrote:
> > 2012=E5=B9=B42=E6=9C=8822=E6=97=A515:39 Darren Hart <dvhart@linux.i=
ntel.com>:
> >> We can add a patch to this series that sets the
> >> default to 192MHz, drops the CM-iTC quirk, and does nothing in pch=
_phub
> >> probe for the FRI2.
> >=20
> > If you set  the clock of pch_uart as 64MHz,
> > do you need to add quirk for FRI2 to pch_phub so as to provide 64MH=
z clock?
>=20
> I admit the value of pch_phub eludes me a bit. In my case, the firmwa=
re
> sets up the CLKCFG register, so there is no need to set it manually
> after boot. Instead, I'm making sure the pch_uart driver defaults to
> what the firmware sets up.

I think long term wise, we should suggest BIOS vendor to set the UART c=
lk
to 192MHz in chipset's release notes, since 192MHz works on Darren's,
Tomoya's and my boards.

Thanks,
=46eng

>=20
> --=20
> Darren Hart
> Intel Open Source Technology Center
> Yocto Project - Linux Kernel
