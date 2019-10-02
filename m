From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH v6 1/4] nvmem: core: add nvmem_device_find
Date: Wed, 2 Oct 2019 18:33:28 +0000
Message-ID: <20191002183327.grhkxlbyu65vvhr4@pburton-laptop>
References: <20190923114636.6748-1-tbogendoerfer@suse.de>
 <20190923114636.6748-2-tbogendoerfer@suse.de>
 <ce44c762-f9a6-b4ef-fa8a-19ee4a6d391f@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ce44c762-f9a6-b4ef-fa8a-19ee4a6d391f@linaro.org>
Content-Language: en-US
Content-ID: <F75C05FC784E8D4589A7A23C018BBA8C@namprd22.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Thomas Bogendoerfer <tbogendoerfer@suse.de>, Jonathan Corbet <corbet@lwn.net>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, Lee Jones <lee.jones@linaro.org>, "David S. Miller" <davem@davemloft.net>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hello,

On Tue, Oct 01, 2019 at 11:11:58AM +0100, Srinivas Kandagatla wrote:
> On 23/09/2019 12:46, Thomas Bogendoerfer wrote:
> > nvmem_device_find provides a way to search for nvmem devices with
> > the help of a match function simlair to bus_find_device.
> >=20
> > Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> > ---
>=20
> Thanks for the patch,
> This patch looks good for me.
>=20
> Do you know which tree is going to pick this series up?
>=20
> I can either apply this patch to nvmem tree
>=20
> or here is my Ack for this patch to take it via other trees.
>=20
> Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Thanks - if you don't mind I'll take this through mips-next along with
the following patch that depends on it.

Thomas: I see patch 3 has an issue reported by the kbuild test robot,
        and still needs acks from the MFD & network maintainers. Can I
	presume it's safe to apply patches 1 & 2 without 3 & 4 in the
	meantime?

Paul
