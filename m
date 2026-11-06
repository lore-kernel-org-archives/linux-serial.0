Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793968818;
	b=hIGG+3nxwXJBc9wJU34AWH+DVNU4jck7g8lKBP2ttSWaM9tqTQBsEl6yui0lxzrPkzra
	 yRrXekml2zZ2E8Etstp1xz+dE3oU7N93JwHkesaUy6wHRnVA0bmM8nFprkwvk7fN2gSG4
	 PZuXYfU1uvc3RsBmmCK5vzlxLZp1xcP1Q8jj6baPh4xmux7loL0foHyzPFxM+21GCcEeK
	 AMYo8qkMd3PU2LGFtCri9Lw5JkML4BzFUKhmcLOX9ryWNnMV2B2JAReYCbdmjiFD1NqLR
	 CmL5NSqLCcmBUIrLpUimG6FY2l3IAr5GTB117zi+6Mpkl9Z0wtqZDRUX0zAyQEJStIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793968818;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=I7rpnBx9YoXkP8aLjecj2KvEgsGyzrkFXLzcIf+WpQs=;
	b=tjwfW5ZjMhz/fZkH23sHOIErQBrB/TgBAoZbdfaKAlw4vblVwvw+MpKbHMnGf1jVVCsp
	 FbJYF14oftGdvaza21jB1Yw/dYsI77zT1BBPf4rxPCje2/ELTZBrrxI+JAGXCzQUjSvkP
	 uZtl+2Kf25J1B/YAj9/uCXZDRK2P8/Ua0he52PQCGbekJCIDfKa+PvFaDbW6W+PjIbGdg
	 Q0xSwwaMI022i2k/VLZsQj+XrbJQIEf5yFqHbvVtoWthssq4bzt4LmaeH2NkRbPEFcEg7
	 XALqGQ6mnu1tma7yqLEPJ0s+MtRePD28AXPiH8VJi3DKlJK6Oh36LlcUYIWm3V+B3Hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="cv0gq7//";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D630606A326;
	Fri,  6 Nov 2026 12:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cv0gq7//
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744301F0089F;
	Fri,  6 Nov 2026 12:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793968818;
	bh=I7rpnBx9YoXkP8aLjecj2KvEgsGyzrkFXLzcIf+WpQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cv0gq7//oTp0dAwoAY2P60tkzG7qOXixypboCv6somxbv4RJe5y516ibiIt9yil0y
	 6Xus26S5S7CjxFEgzJ6hZni98dpD8Y/omMUtCqA4qji8MxkiTaYplwOOW48zZztgn9
	 biJBA8ky84yjfhdUFX9fRCe+oS8D893fUM9AYufhLCP12MMbLUTZ8mXNG/OPBCvc1G
	 DIevwtEp6pl4GRQg1cF62xWNKe0C2Oa7ePx8fTta9k3W+1zeQkAVQDl44kBiPO2/LG
	 dx8EhOOPaR6wOfy/YLyX01VcjVuebpZVFEllgtNJqAQKSVIn+yFsCLndqNWCvS3rdQ
	 Fk78GnOIw8FXg==
Date: Fri, 6 Nov 2026 13:40:15 +0100
From: Thierry Reding <thierry.reding@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Frank.Li@oss.nxp.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Russell King <linux@armlinux.org.uk>, 
	Richard Genoud <richard.genoud@bootlin.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Peter Griffin <peter.griffin@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Laxman Dewangan <ldewangan@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Cunhao Lu <1579567540@qq.com>, 
	Raul E Rangel <rrangel@chromium.org>, Yenchia Chen <yenchia.chen@mediatek.com>, 
	Zhiyong Tao <zhiyong.tao@mediatek.com>, Carlo Caione <ccaione@baylibre.com>, Moteen Shah <m-shah@ti.com>, 
	Kendall Willis <k-willis@ti.com>, Kartik Rajput <kkartik@nvidia.com>, Fan Wu <fanwu01@zju.edu.cn>, 
	Nicolai Buchwitz <nb@tipi-net.de>, Karl Mehltretter <kmehltretter@gmail.com>, 
	Stefan =?utf-8?B?RMO2c2luZ2Vy?= <stefandoesinger@gmail.com>, Shitalkumar Gandhi <shital.gandhi45@gmail.com>, 
	Peng Fan <peng.fan@nxp.com>, Sherry Sun <sherry.sun@nxp.com>, 
	John Ogness <john.ogness@linutronix.de>, Pan Chuang <panchuang@vivo.com>, Petr Mladek <pmladek@suse.com>, 
	Robin Gong <yibin.gong@nxp.com>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, Zhaoyang Yu <2426767509@qq.com>, 
	"Nikola Z. Ivanov" <zlatistiv@gmail.com>, Haoxiang Li <haoxiang_li2024@163.com>, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Myeonghun Pak <mhun512@gmail.com>, 
	Wenhua Lin <Wenhua.Lin@unisoc.com>, Cixi Geng <cixi.geng@linux.dev>, 
	"open list:TTY LAYER AND SERIAL DRIVERS" <linux-kernel@vger.kernel.org>, 
	"open list:TTY LAYER AND SERIAL DRIVERS" <linux-serial@vger.kernel.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, 
	"open list:ARM/FREESCALE IMX / MXC / LAYERSCAPE ARM ARCHIT..." <imx@lists.linux.dev>, 
	"open list:ARM/QUALCOMM MAILING LIST" <linux-arm-msm@vger.kernel.org>, 
	"open list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" <linux-samsung-soc@vger.kernel.org>, 
	"open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>, 
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>, vkoul@kernel.org
Subject: Re: [PATCH 1/1] tty: serial: use dmaengine_desc_set_callback()
Message-ID: <au3GYOP5P7B90-bX@orome>
References: <20261102175527.3957740-1-Frank.Li@oss.nxp.com>
 <aux2VKHnVLwq_wzi@orome>
 <auyQEVmA2KeGu9DL@ashevche-desk.local>
 <auyiAE3lhnFahBK2@orome>
 <auysTnqWgz2kE7e9@ashevche-desk.local>
 <2209947d-0b9b-417f-9ffb-1c81790af9db@kernel.org>
 <auzEupFd_Ek2HpLG@ashevche-desk.local>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bfkiplbygfje4qbi"
Content-Disposition: inline
In-Reply-To: <auzEupFd_Ek2HpLG@ashevche-desk.local>


--bfkiplbygfje4qbi
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/1] tty: serial: use dmaengine_desc_set_callback()
MIME-Version: 1.0

On Thu, Nov 05, 2026 at 08:02:34PM +0200, Andy Shevchenko wrote:
> On Thu, Nov 05, 2026 at 05:21:06PM +0100, Krzysztof Kozlowski wrote:
> > On 05/11/2026 17:18, Andy Shevchenko wrote:
> > > On Thu, Nov 05, 2026 at 04:36:38PM +0100, Thierry Reding wrote:
> > >> On Thu, Nov 05, 2026 at 04:17:53PM +0200, Andy Shevchenko wrote:
> > >>> On Thu, Nov 05, 2026 at 01:28:46PM +0100, Thierry Reding wrote:
> > >>>> On Mon, Nov 02, 2026 at 12:54:48PM -0500, Frank.Li@oss.nxp.com wro=
te:
> > >>>>>
> > >>>>> Replace open-coded assignments to callback and callback_param fie=
lds
> > >>>>> of struct dma_async_tx_descriptor with calls to the
> > >>>>> dmaengine_desc_set_callback() helper across serial drivers.
> > >>>>>
> > >>>>> No functional change intended. Prepare to make struct
> > >>>>> dma_async_tx_descriptor private to the DMA engine.
> > >>>>>
> > >>>>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > >>>>> ---
> > >>>>>  drivers/tty/serial/8250/8250_dma.c  | 6 ++----
> > >>>>>  drivers/tty/serial/8250/8250_mtk.c  | 3 +--
> > >>>>>  drivers/tty/serial/8250/8250_omap.c | 6 ++----
> > >>>>>  drivers/tty/serial/amba-pl011.c     | 6 ++----
> > >>>>>  drivers/tty/serial/atmel_serial.c   | 6 ++----
> > >>>>>  drivers/tty/serial/fsl_lpuart.c     | 6 ++----
> > >>>>>  drivers/tty/serial/imx.c            | 6 ++----
> > >>>>>  drivers/tty/serial/msm_serial.c     | 6 ++----
> > >>>>>  drivers/tty/serial/mxs-auart.c      | 6 ++----
> > >>>>>  drivers/tty/serial/pch_uart.c       | 6 ++----
> > >>>>>  drivers/tty/serial/samsung_tty.c    | 6 ++----
> > >>>>>  drivers/tty/serial/serial-tegra.c   | 6 ++----
> > >>>>>  drivers/tty/serial/sh-sci.c         | 9 +++------
> > >>>>>  drivers/tty/serial/sprd_serial.c    | 3 +--
> > >>>>>  drivers/tty/serial/stm32-usart.c    | 6 ++----
> > >>>>>  15 files changed, 29 insertions(+), 58 deletions(-)
> > >>>>
> > >>>> Reviewed-by: Thierry Reding <treding@nvidia.com>
> > >>>
> > >>> Krzysztof, now look at this case. I would argue that this is even l=
ess fit than
> > >>> # subpart(s) case, because it might imply anything. Again the probl=
em is the
> > >>> bundle, and for such a case (when tons of independent changes are b=
undled in
> > >>> the same stuff, *every* Rb tag has to be explained on what has been=
 reviewed!
> > >>
> > >> It may be a bit subtle, but the placement of the tag indicates that =
it
> > >> applies to the entirety of the changes. I didn't crop the list of
> > >> changed files, nor did I omit the summary.
> > >=20
> > > This doesn't clarify the question. Wordless Rb tag on a bundles is an=
 oddity.
> >=20
> > No, it's perfectly normal and typical. I would not expect anything else,
> > because writing "LGTM" is pointless. We are experienced reviewers and we
> > do understand what Reviewer's statement of oversight means, thus giving
> > the tag is obvious, explicit and not odd.
> >=20
> > >=20
> > >> That bit of meta-data obviously isn't picked up into the tag line, b=
ut
> > >> I think the default meaning of Reviewed-by is that it applies to the
> > >> entire thing.
> > >=20
> > > And I interpret it otherwise, because this is a set of independent ch=
anges
> > > bundled into a single patch!
> >=20
> > It's not set of independent changes, but even if it was then it would
> > not matter. We review the code regardless how we actually judge the
> > atomicity of a patch.
>=20
> And I confront exactly that! When the patch may be split it has to. This =
is
> seems the outcome of this discussion to me. From now on I think I will NAK
> any bundle patch until piece that I in charge to is split from the bundle.

I'd like to caution against this. There's effectively one change in this
patch and it converts all the drivers in the same way. This was probably
generated using a script or semantic patch. Requiring this to be split
up is going to make the author spend a lot of time creating 15 patches
instead of just one. They will have to write the same commit message
with tiny variations, which they'll most likely just use a script for
because it's tedious. Or they don't use a script and likely get at least
one commit message wrong. And then we're not reviewing a patch for
technical correctness anymore but waste a lot of time on nit-picking on
a subject or commit message. Each of these commit messages is not going
to add any new information either, so the only thing you really achieve
is to increase the signal-to-noise ratio.

That's completely absurd.

Also, reviewing 15 miniature patches is going to take much more time
that reviewing this monolithic one, so I suspect potential reviewers are
more likely to just stay away from it to begin with.

In the end you make life miserable for everyone. Well, except for
individual driver maintainers that want a quick and easy way to slap
their approval onto only the one driver change that they really care
about.

But there's already a way that they can do that. Acked-by can just mean
"I maintain this driver and I agree with the direction, but I haven't
bothered to do a full technical review". That's what most of these
"partial" Reviewed-bys are, so why not just use that existing tool?

And I'm saying all of this without judgement, because sometimes you do
not have the time to do a full review but you still want to lend your
support to ongoing work. I do that quite often myself.

But at other times I do want to look at something in more detail, or
just ended up looking thoroughly enough for it to count as a full review
and when I do I'll let people know with a Reviewed-by.

Thierry

--bfkiplbygfje4qbi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmrtyq0ACgkQ3SOs138+
s6Fr4A/9FKItEmEcI7D1clbCnePcAJeqtYQ0rYq/qZQPbKo0mPQbeN5qKa1XDgHO
o3ylZ3Piqsnzv+NNOe6cmtCjzv4Bb82/Z9g8metI4jz4gOraKos+oVhk2EIMFv7f
yrPVGwcvgtlSnx6MO/kFoS+1JYbWlZ9JA7jJCTcXBUF28R780a2elyHAnxamdAQZ
TrzhhmaRmsdt2TLYxJRPlrKWjfzhl/2HKGfFTTROXgaiaj8oQeCNcBGC1TKKtGls
g4MQJ6AZ1Ke58gd3O1sYh3QUlOUewNawK+LOsDoGjooF6zg2loLypU6twHl7cBdH
GoFRsLUImQvYXNUYhDxGCxNZ3OvMyIM+8X3G2xIJuHY8MEbJY5ukp/rPKi/4CQyK
VxwvkHMoAX705PtVMKdY2ddQt9ceif+v7ohWDmce8B3NOopq0itUXxcU8Z2MWw99
qEl1IoIYVXBYiJeaIcLzjSPmJeFPAJ49cJhNeqpH190C5hIqxPK75Jyh7+Pokx+y
yWFEIla8n0+o14XOP9M2wnrvJ34EQI4aW8Ia/nFn3b1oONvBu+q8h8wMH5hH2fvJ
O3QCmMyze7y03zKMQL2w8jE7qniSfi+wUNb318xOlXRqBKHTSGv7IEu5try/XdKo
L8B242zIrUhLZ8MWwNSUfjq9qIT7PSG50W3uNxTv0hduJXFO13c=
=a1fc
-----END PGP SIGNATURE-----

--bfkiplbygfje4qbi--
