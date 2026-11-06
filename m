Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793976969;
	b=TUzhy6lm5B9aMeSMT7u5J4mr331toK42ghSUwTNsmJiKvC93qKOJ75ZApxn/wLx49GPD
	 yWY6NtEe/TNfktamPNgtPoErpSwFOuwAIRT9dfwPrdBSphBx5ks8vYpU0L4w3io8QKeZ2
	 hw6qvKYMlD05j01IyDfc66lI8GQXSXbjtj54YTlEsZ+QctzpLyAJIY3hG7vgmuR9RTnuP
	 c4TkS6jRvaDRDgxORbjbMvLWyINaZRfrQHeuXxHvx662sXVxRUIU4tJ5C2oNqdUBjLRmz
	 8IumtMEj+FVrkuPnOi0Fjkoxdefo2OANrGzEKg1nkGlZ1bF0aaYm7djj7HTXsNBkybw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793976969;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=OZO2+7G4k6RkoglmAS6YzLo/PJ0QFmsDlFGqO/wIKqU=;
	b=nSY7RnORv1S3MfATLwSd7G3bsYMDebSwS07morBbn9ksgO5oOUFNkk3QUY1cXHIMIi/s
	 pPQm0lCPkcQdhOGQmSqJqWi5IJUC4X3/FkQqEkxXF4PxFUpjUw3+PobmWHHoTcII8rc91
	 U+LCHAirf4FuxFe2tuDlSurwsY8ZckARoLJB8M+CKQvKPTJUM5gBlgP+K4d3A9NGTT/Mr
	 J/5kd21H9Nd1iDsoV0IFqcml7IjdHeRyShvzcESk0RkTiGfIszPRl5dktXc/xAfsyA7f8
	 vUxKic+mleax+mQSX8fySHURmmVIKZ0UlptOh1DnZuWRxVtpP5TfnqDN/fE/Q3n7xkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FL3b2pjP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96DC606A32E;
	Fri,  6 Nov 2026 14:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FL3b2pjP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93AA21F0089F;
	Fri,  6 Nov 2026 14:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793976968;
	bh=OZO2+7G4k6RkoglmAS6YzLo/PJ0QFmsDlFGqO/wIKqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FL3b2pjP4eHV1sse1FCUItCjs7WSyqKVQlm1eN2jCUmHu0R9vI4R5catcSy55jdyJ
	 JOUKfCl2j58V/ngp7J5DauX+QE/lEYXrvqts2JBOm7zCiE1X3LgkaKAE4hwBf//qMh
	 dMWv5mavfztWIVeEzCj2sM9tYiuUon4hwvojwAJ07py/MpMYaIBA5Abkkz7U6FYXMR
	 kaIIcwxbF+YfCiXG0Us9PryUlZddR4DitWpuhShM//KfOmihsx7KrjcX2AOetsROPv
	 9k2ftDAZJ4aZaUcuhuECQ2WHN4fMepu+0d3lVLCbAX/MLhswgxSzLpi2Pgypz/jY8z
	 Go2SN7cDi4krA==
Date: Fri, 6 Nov 2026 15:56:05 +0100
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
Message-ID: <au3nMfg8QzGtaH-i@orome>
References: <20261102175527.3957740-1-Frank.Li@oss.nxp.com>
 <aux2VKHnVLwq_wzi@orome>
 <auyQEVmA2KeGu9DL@ashevche-desk.local>
 <2e12316d-d079-471f-9c29-ef5fb765216a@kernel.org>
 <auygwakavp_Uk52V@orome>
 <auyr2lqlSegIXFnc@ashevche-desk.local>
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
	protocol="application/pgp-signature"; boundary="hyjsm6c5ofwknahy"
Content-Disposition: inline
In-Reply-To: <auyr2lqlSegIXFnc@ashevche-desk.local>


--hyjsm6c5ofwknahy
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/1] tty: serial: use dmaengine_desc_set_callback()
MIME-Version: 1.0

On Thu, Nov 05, 2026 at 06:16:26PM +0200, Andy Shevchenko wrote:
> On Thu, Nov 05, 2026 at 04:34:15PM +0100, Thierry Reding wrote:
> > On Thu, Nov 05, 2026 at 03:35:20PM +0100, Krzysztof Kozlowski wrote:
> > > On 05/11/2026 15:17, Andy Shevchenko wrote:
> > > >>> ---
> > > >>>  drivers/tty/serial/8250/8250_dma.c  | 6 ++----
> > > >>>  drivers/tty/serial/8250/8250_mtk.c  | 3 +--
> > > >>>  drivers/tty/serial/8250/8250_omap.c | 6 ++----
> > > >>>  drivers/tty/serial/amba-pl011.c     | 6 ++----
> > > >>>  drivers/tty/serial/atmel_serial.c   | 6 ++----
> > > >>>  drivers/tty/serial/fsl_lpuart.c     | 6 ++----
> > > >>>  drivers/tty/serial/imx.c            | 6 ++----
> > > >>>  drivers/tty/serial/msm_serial.c     | 6 ++----
> > > >>>  drivers/tty/serial/mxs-auart.c      | 6 ++----
> > > >>>  drivers/tty/serial/pch_uart.c       | 6 ++----
> > > >>>  drivers/tty/serial/samsung_tty.c    | 6 ++----
> > > >>>  drivers/tty/serial/serial-tegra.c   | 6 ++----
> > > >>>  drivers/tty/serial/sh-sci.c         | 9 +++------
> > > >>>  drivers/tty/serial/sprd_serial.c    | 3 +--
> > > >>>  drivers/tty/serial/stm32-usart.c    | 6 ++----
> > > >>>  15 files changed, 29 insertions(+), 58 deletions(-)
> > > >>
> > > >> Reviewed-by: Thierry Reding <treding@nvidia.com>
> > > >=20
> > > > Krzysztof, now look at this case. I would argue that this is even l=
ess fit than
> > > > # subpart(s) case, because it might imply anything. Again the probl=
em is the
> > > > bundle, and for such a case (when tons of independent changes are b=
undled in
> > > > the same stuff, *every* Rb tag has to be explained on what has been=
 reviewed!
> > >=20
> > > I think this case is obvious - Thierry reviewed this patch and gives =
Rb
> > > tag, according to reviewer's statement of oversight. I don't see a
> > > problem here or what is questionable.
> >=20
> > Correct. I looked at this whole thing and approve of it.
>=20
> for this type of bundles it's not obvious.

I think it's obvious if you interpret the tag the way it's described in
the process documentation. If everyone has their own interpretation of
what it means we have a whole other set of problems.

> > If I review only parts of something at most I'll give an Acked-by.
>=20
> Which is strange, don't you find it? The review is not an acknowledgement.
> These are two different operations.

I think review is a stronger form of acknowledgement.

> > I don't think I've ever done partial reviews. I don't think you can rea=
sonably do
> > that
> > because if you don't know what other parts of a patch are doing, how can
> > you say that a specific hunk does what it's supposed to.
> >=20
> > Patches are an atomic set of changes,
>=20
> Of course, not always the case. This patch is a bundle of atomic changes
> in a single drop.

That seems like a slippery slope. It means we now need to interpret what
atomic means. If a commit is not atomic, that to me is grounds for
rejection. Maybe atomic is the wrong term here. The patch to me is still
one logical change because it applies the same transformation to all
these different drivers, and therefore it doesn't require to be split up
explicitly.

> > so I don't think it makes sense to review only parts of it. If you can'=
t be
> > bothered to look at the entirety, that's absolutely fine of course, but=
 in
> > that case don't provide a Reviewed-by.
> >=20
> > Or, I suppose, you do and then you bear the consequences of lending
> > credibility to something that you haven't looked at or understood.
>=20
> No, I review *my* part, that I understand and I confirm.

I think we need to distinguish between various levels of complexity. For
this particular case there's not much to understand, it's purely a
transformation, so you could very well review all the patch hunks
without needing more context as to the drivers.

If there were more complexity to this, then I would also argue that it'd
be better to have separate patches per driver. Most of the time
submitters tend to do that all by themselves because it's almost common
sense. But like I said, I don't think that applies here.

Also, I'd like to remind everyone that this is a community project and
if everyone is only ever going to review *their* part, it's all going to
deteriorate over time. Again, I sympathize with people not having time
to extensively review everything. However, for cases like this once you
already load enough context to review *your* part, you might as well
spend the extra minute or two reviewing the other parts, which is all
that's necessary to make this a full review.

Of course it's a bit questionable that a full review is really needed
here, in which case an Acked-by is really all you need.

Thierry

--hyjsm6c5ofwknahy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmrt6oIACgkQ3SOs138+
s6FcVxAAv0rp5SLtEPRjUT//i58IZP/aVR/4ZYrRNo0F1Y3ECYjFQ94qa1m8tvTg
X2/GMdlycFs5dgwdbVVhbHB8wK89n1ABMjH9gnkWFCvpDk6VJ4ux8FuzyI08tukU
l6sfyAptqb6O97trV6Rzj1UYvvampY6H//QbmE1GAnMiujp5mx7qabeoL0dbrJjE
WGY+IBsyqimxNJ/6A6ZcIzj53KzzqDnJQeMkiEFWjCZTjWk5CSOpKi/DFryfdatD
O7mSJzUp0NYWzs9KPEYHxuiAlTBf4SD9tjiEGU5poqnwUqyWoinTCJJRGH5np4tM
f1zGTtGY3XFKA9nBY3i7wODHqGdZNmn7G4+d60LV3C5uS96ooYS6T55asYun1vLO
rpTeLmAC7ClIp2hVDTLziEFwayuQlz30TGVAPDJQr0ViyE5VIgNZQXHaYfqqMh8T
vXBMJH6255KbTCjsv6Kc7fvGxoCOWZ6SSMWuOFakVKJkbgaDDBunkckjNJQh4lCk
g4c8fwM+4J859WhpjGafYnSor+zhfOU6YRZWCcNOEXJqPof567IlKShI56Wt9tgr
UzHb3L6+OzTEd+MKeNWdvD8RqSAAt1yv5Fks2TM69qH/rxD81y6ewIqQE3GryhmZ
w5jNiIbDq4g1IsBNqnS0LXMC1pPNTZMY8IF0l//XMWnNwl0Z8Vg=
=xdRj
-----END PGP SIGNATURE-----

--hyjsm6c5ofwknahy--
