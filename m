Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892858;
	b=g1ZXPGKqKp3PvHsMqcddNW49oHmjkfU/BkJkNLhI6MsJNn5dqwNZj0szl8ErpRHBFcVa
	 yrGiK5UsqgzJ4N9jCKsGpVIqVL+MVTD5ixC+m4JRrgWZImYYz0VhTY1how4d0E+FrUDia
	 Hcaxntpcj8RkOY4l/ztLXcQewcEQMBKOUU5nMld/LC4eHqTMOYMZrRUmdXDaXLP3Mz7w7
	 qrcjT9dS6WHELugMIvBkJ14Dv2WiACQQ5NuQBIZdU+tcw0kkou+Wnhya+t+jFmjHgxvIq
	 /3tKno2rh5+qyS83f5ckvOR/ug9ayYBhIZiMvz08QHOeCkcFZ+LUx8zWfLnx9mODODA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892858;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=YNB1Wit5xYUO191VIQdW8ACPoY/mVp3oInWQ1K0PfQA=;
	b=cdh9RoAXiJVi0ef0/R+mxfzfSUCXcojqHNxotbYxs0dRsVw6XMFMvj4RkSlG3/iiAYZi
	 xuWqoXoI8a5tAUf0msXAnUKvs+zvZkb8dnc5yYMNNli/Qib9XwmF1RqKEYgl5rFfuF/1G
	 O2+bkl6+P4tVCiLxMVclfwn/4xfeAvA55JMA0E304esxd84y/o9IJKBBWOCtewHFRafhe
	 pcG0VbLQSV8+69mS6VtvlXfRkGKtOkjeSAbhOYdfv51YFA3IGMSUzWrswPU6mJ8AyPZnG
	 rUvtx5NiMqSD/FpU4ctkk8QWbbHjPCLIlobJuin8zx+nm6C20MZHnvsasNgJJgmqjaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DvVbVPQc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DCC606A31B;
	Thu,  5 Nov 2026 15:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DvVbVPQc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C92D61F000C1;
	Thu,  5 Nov 2026 15:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793892857;
	bh=YNB1Wit5xYUO191VIQdW8ACPoY/mVp3oInWQ1K0PfQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DvVbVPQc+2LQL+Wy17aVp5lNEAcdRdvX03FQSm3E+382FSh2QqDX+EPcpIBR7M1W7
	 v+57Kfl08brn4YYhpNdfIplE6yTwK2O0vgx+RW/H9Jky6OcBcL4opKPoLoCR+uelE2
	 SjQKeM/0l/KyNLFt7glHiPGGNbh5AozzmAwKv+y2u7+s0BZnC3OmC2y0T2a4xEdJot
	 g25SKkeTr4hDDPiMcg/M0lFrCEpe41NxzODTK28SdLgucqCsG1RKMjkeXWPsNi+RNf
	 463H7bwuw1L01v2FwGULXf/JNollrCeo3gHgbIcojdvfX8GYEY+IXovf3gsr6rvKG/
	 K3Cyuwo5Uhabg==
Date: Thu, 5 Nov 2026 16:34:15 +0100
From: Thierry Reding <thierry.reding@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Frank.Li@oss.nxp.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
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
Message-ID: <auygwakavp_Uk52V@orome>
References: <20261102175527.3957740-1-Frank.Li@oss.nxp.com>
 <aux2VKHnVLwq_wzi@orome>
 <auyQEVmA2KeGu9DL@ashevche-desk.local>
 <2e12316d-d079-471f-9c29-ef5fb765216a@kernel.org>
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
	protocol="application/pgp-signature"; boundary="ve7gdihn6fud63vw"
Content-Disposition: inline
In-Reply-To: <2e12316d-d079-471f-9c29-ef5fb765216a@kernel.org>


--ve7gdihn6fud63vw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/1] tty: serial: use dmaengine_desc_set_callback()
MIME-Version: 1.0

On Thu, Nov 05, 2026 at 03:35:20PM +0100, Krzysztof Kozlowski wrote:
> On 05/11/2026 15:17, Andy Shevchenko wrote:
> >>> ---
> >>>  drivers/tty/serial/8250/8250_dma.c  | 6 ++----
> >>>  drivers/tty/serial/8250/8250_mtk.c  | 3 +--
> >>>  drivers/tty/serial/8250/8250_omap.c | 6 ++----
> >>>  drivers/tty/serial/amba-pl011.c     | 6 ++----
> >>>  drivers/tty/serial/atmel_serial.c   | 6 ++----
> >>>  drivers/tty/serial/fsl_lpuart.c     | 6 ++----
> >>>  drivers/tty/serial/imx.c            | 6 ++----
> >>>  drivers/tty/serial/msm_serial.c     | 6 ++----
> >>>  drivers/tty/serial/mxs-auart.c      | 6 ++----
> >>>  drivers/tty/serial/pch_uart.c       | 6 ++----
> >>>  drivers/tty/serial/samsung_tty.c    | 6 ++----
> >>>  drivers/tty/serial/serial-tegra.c   | 6 ++----
> >>>  drivers/tty/serial/sh-sci.c         | 9 +++------
> >>>  drivers/tty/serial/sprd_serial.c    | 3 +--
> >>>  drivers/tty/serial/stm32-usart.c    | 6 ++----
> >>>  15 files changed, 29 insertions(+), 58 deletions(-)
> >>
> >> Reviewed-by: Thierry Reding <treding@nvidia.com>
> >=20
> > Krzysztof, now look at this case. I would argue that this is even less =
fit than
> > # subpart(s) case, because it might imply anything. Again the problem i=
s the
> > bundle, and for such a case (when tons of independent changes are bundl=
ed in
> > the same stuff, *every* Rb tag has to be explained on what has been rev=
iewed!
>=20
> I think this case is obvious - Thierry reviewed this patch and gives Rb
> tag, according to reviewer's statement of oversight. I don't see a
> problem here or what is questionable.

Correct. I looked at this whole thing and approve of it. If I review
only parts of something at most I'll give an Acked-by. I don't think
I've ever done partial reviews. I don't think you can reasonably do that
because if you don't know what other parts of a patch are doing, how can
you say that a specific hunk does what it's supposed to.

Patches are an atomic set of changes, so I don't think it makes sense to
review only parts of it. If you can't be bothered to look at the
entirety, that's absolutely fine of course, but in that case don't
provide a Reviewed-by.

Or, I suppose, you do and then you bear the consequences of lending
credibility to something that you haven't looked at or understood.

Thierry

--ve7gdihn6fud63vw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmrsofQACgkQ3SOs138+
s6H8Qw//cGBQstXaV/wKkkacAC3cWNFTL8+yZFsZNlz+TH8ENXGRirTUfKBfzoOF
HtimCa5VVbkXs0qyUKXvTM/A5pF1Fq2cdpdO//TpEZnhwVfT6rv7KzsWuUyZVPNK
DkLnxAMcceY7D6zjvtkqsLTUVikBBl+aXcI0ChSBy2Zug88hQpxxwJ/ux+kLs8xE
WDuvRgyUhiJyTGdKru/8NhXKBOVAJnicYfBrndG9ZXG/4aIhpNNRXMQOelAfvhOT
3o6rWWLdXnTZapbimMPSVV8FTihEjQm7QszF0DUJha4h4c0O4gqgnP2FzUzj85u/
S8s2Mh4RRTlyx00NGsoZaoGTnoBhqnIYGXPd7cYgow4ClVf8j0H/dL6jfHwqXm6y
+V9/F1fZcCWoaJp15qo3LQIfEkZuh6sFLJOCHP44fGS/c9y2fKniPUOKVgWUTvAr
u/QrbShhYMlIVPV1vQOdgwum/0NQJacsHqfwJOEy9F73o3evJkdyhP/PBx1Za+Ho
Gah9elyAWQ7TKJxB7yhxe9V8JfZyABe3VyDejZmjd7JRPshTe3gypOsRyAvU7gaX
0s2NAZsjTd97X6CDzlIrIGAy38HWlEa9F8GCeT+EcqlFpw8cuH3+15MUhkDxFHnf
2bYzFtnSkuEdOP+cgYjsukuXCuGEIvSWkZbAjHAuuQFu2PCn0l0=
=lEfV
-----END PGP SIGNATURE-----

--ve7gdihn6fud63vw--
