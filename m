From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH v7 2/5] MIPS: PCI: use information from 1-wire PROM for
 IOC3  detection
Date: Mon, 7 Oct 2019 17:54:07 +0000
Message-ID: <MWHPR2201MB1277380FCFDEB8F78DD7742AC19B0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20191003095235.5158-3-tbogendoerfer@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191003095235.5158-3-tbogendoerfer@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc: Jonathan Corbet <corbet@lwn.net>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <pburton@wavecomp.com>, James Hogan <jhogan@kernel.org>, Lee Jones <lee.jones@linaro.org>, "David S. Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-seri>
List-Id: linux-serial@vger.kernel.org

Hello,

Thomas Bogendoerfer wrote:
> IOC3 chips in SGI system are conntected to a bridge ASIC, which has
> a 1-wire prom attached with part number information. This changeset
> uses this information to create PCI subsystem information, which
> the MFD driver uses for further platform device setup.

Applied to mips-next.

> commit 5dc76a96e95a
> https://git.kernel.org/mips/c/5dc76a96e95a
>=20
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> Signed-off-by: Paul Burton <paul.burton@mips.com>

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
