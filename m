From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH v7 1/5] nvmem: core: add nvmem_device_find
Date: Mon, 7 Oct 2019 17:54:02 +0000
Message-ID: <MWHPR2201MB12773F2193BDE76C4A5E1A74C19B0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20191003095235.5158-2-tbogendoerfer@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191003095235.5158-2-tbogendoerfer@suse.de>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc: Jonathan Corbet <corbet@lwn.net>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <pburton@wavecomp.com>, James Hogan <jhogan@kernel.org>, Lee Jones <lee.jones@linaro.org>, "David S. Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-seri>
List-Id: linux-serial@vger.kernel.org

Hello,

Thomas Bogendoerfer wrote:
> nvmem_device_find provides a way to search for nvmem devices with
> the help of a match function simlair to bus_find_device.

Applied to mips-next.

> commit 8c2a2b8c2ff6
> https://git.kernel.org/mips/c/8c2a2b8c2ff6
>=20
> Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> Signed-off-by: Paul Burton <paul.burton@mips.com>

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
