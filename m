From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Thu, 18 Aug 2016 12:54:15 +0200
Message-ID: <1ED14975-FC0C-44AB-8F05-782DBC9E98F8@goldelico.com>
References: <20160818011445.22726-1-robh@kernel.org> <118926C8-F4D0-41F5-B6A8-690E0312F3FB@goldelico.com> <20160818104749.GB7427@amd>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160818104749.GB7427@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Pavel,

> Am 18.08.2016 um 12:47 schrieb Pavel Machek <pavel@ucw.cz>:
>=20
>=20
>>=20
>> Thereof 4 files, ~260 changes w/o gps demo and =
documentation/bindings.
>=20
> So what do you use for the serial devices? platform_device was vetoed
> for that purpose by Greg.

device tree?

This adds code of course - but only for the slave drivers. So you =
shouldn't count
them for a fair comparison of what it means for implementing a new API.
