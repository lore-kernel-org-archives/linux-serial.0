Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881730;
	b=R2Dxk+jsMTJxnnE/CUAujzZznwn1dpbqnOGOJB6COFSk8suRrRWzUHzoNKOmXu1MPP0Q
	 zTILGLj2433DvL1MGlqQscXXpFttY6ujk4Zk1wK28yE2RcEgPYS8StuNlXP2yN+k9llPA
	 LTdxwNhTxm6bojEU3PS2aeFg1uZUrH8nr44JhzRIK0vDAr7gt3iEUQmOlan9zJ+WvDxqd
	 /HCko26xjTCFKXdqa4eWirrBkfvIDgkaSnRRf6TS/La4aDQ4u7ZXEHBnyPP9+uNkhhAaR
	 yYyDuIR0oMPyj40wi2WsxFhOfK9aRWjSLb/MpdaEizCbyDeYPT0CYXPvbPhtC3BGbIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881730;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=FsZqO5FR4mq2gQTlk44IBTsOMir2UzDLRvKhXJMYJ80=;
	b=MwkADVsrD8ehGzlUvpNFSIxdAtD5tPooiZzXTsJT6BzQtovEweXVf6XbvhdPZpvbv5GF
	 rJqfZsmQvWt5LolWpVOQjarJGWoybBxhxokv6v+H/JMbSBU2cQcK8j3VkHseYvHJQ5/7T
	 QbiLb9Dh0o6lAds/jp8jnxOekQAtGl37m+QVfzCGWrnobP5JloUUbB/hv4Xh4v7IwJFB2
	 FPDL5dts64MwCv8DTve83ETz70Rimr2F1oHFepAH/ESTBHvDHBBB58hfrqnygdH7PizPw
	 jduI/iVRcJIIyimXARet2aCzdvbDsc0Y3g1k5EFQsCF6oCmpDOrcthAAGANZ9H1Y+Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yz82hJKk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F01606A331;
	Thu,  5 Nov 2026 12:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yz82hJKk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE90C1F00919;
	Thu,  5 Nov 2026 12:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793881729;
	bh=FsZqO5FR4mq2gQTlk44IBTsOMir2UzDLRvKhXJMYJ80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Yz82hJKkMymEJOScjv8sYjss2OQ1kINPiDdkaHg5ad9RyZEWOiGaO7o1lbpp8pQ4e
	 9epzUzeGty9sRCXEfCTqC0fJFd/C1ie8YzBRyCUTfi3SMPvSHQFrQ9bQAMK8nD9/Kl
	 myWGH8iuE8WJEibwJzc39kqDQnnaTND68Xynk1OcHrcs7ZIA4JjiJ8NbRuvXOf4gub
	 c+dgetCSx67SZN1w9wXrmlf5ohPmNlEByvteNCZFdHa2+C65WPzFbhCkmz0/GXWZHr
	 5XPvRBgsUc9cyKC805nfy5Nxa7Lc6dyz6auCKc3CEq1uAfCdSwc7NkApLxKvWmzHAh
	 Ni5TNSAsINLPg==
Date: Thu, 5 Nov 2026 13:28:46 +0100
From: Thierry Reding <thierry.reding@kernel.org>
To: Frank.Li@oss.nxp.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Russell King <linux@armlinux.org.uk>, 
	Richard Genoud <richard.genoud@bootlin.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Laxman Dewangan <ldewangan@nvidia.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Cunhao Lu <1579567540@qq.com>, Raul E Rangel <rrangel@chromium.org>, 
	Yenchia Chen <yenchia.chen@mediatek.com>, Zhiyong Tao <zhiyong.tao@mediatek.com>, 
	Carlo Caione <ccaione@baylibre.com>, Moteen Shah <m-shah@ti.com>, Kendall Willis <k-willis@ti.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Kartik Rajput <kkartik@nvidia.com>, Fan Wu <fanwu01@zju.edu.cn>, 
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
Message-ID: <aux2VKHnVLwq_wzi@orome>
References: <20261102175527.3957740-1-Frank.Li@oss.nxp.com>
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
	protocol="application/pgp-signature"; boundary="i6ogfjkah26q6ktw"
Content-Disposition: inline
In-Reply-To: <20261102175527.3957740-1-Frank.Li@oss.nxp.com>


--i6ogfjkah26q6ktw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/1] tty: serial: use dmaengine_desc_set_callback()
MIME-Version: 1.0

On Mon, Nov 02, 2026 at 12:54:48PM -0500, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
>=20
> Replace open-coded assignments to callback and callback_param fields
> of struct dma_async_tx_descriptor with calls to the
> dmaengine_desc_set_callback() helper across serial drivers.
>=20
> No functional change intended. Prepare to make struct
> dma_async_tx_descriptor private to the DMA engine.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/tty/serial/8250/8250_dma.c  | 6 ++----
>  drivers/tty/serial/8250/8250_mtk.c  | 3 +--
>  drivers/tty/serial/8250/8250_omap.c | 6 ++----
>  drivers/tty/serial/amba-pl011.c     | 6 ++----
>  drivers/tty/serial/atmel_serial.c   | 6 ++----
>  drivers/tty/serial/fsl_lpuart.c     | 6 ++----
>  drivers/tty/serial/imx.c            | 6 ++----
>  drivers/tty/serial/msm_serial.c     | 6 ++----
>  drivers/tty/serial/mxs-auart.c      | 6 ++----
>  drivers/tty/serial/pch_uart.c       | 6 ++----
>  drivers/tty/serial/samsung_tty.c    | 6 ++----
>  drivers/tty/serial/serial-tegra.c   | 6 ++----
>  drivers/tty/serial/sh-sci.c         | 9 +++------
>  drivers/tty/serial/sprd_serial.c    | 3 +--
>  drivers/tty/serial/stm32-usart.c    | 6 ++----
>  15 files changed, 29 insertions(+), 58 deletions(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--i6ogfjkah26q6ktw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmrsdnwACgkQ3SOs138+
s6FFLRAAsArTl7ZnP2uWe8E8No/HaZXTw2qwzanL18HSrQ99Y5LTIiGMUG2lNlh4
g4SVAB5ZpAe1Ji8Irltia/BRsUboLVvofPgbGh8AvBrhByWtDx75pNBJGwlxzDsn
/oYyAQ6U+6BZob6VZ/1hVv5xt6UtjqRjcOQGM/Eebu+IsJ1bXUzcfwOt+p6oJuDe
bipFPggDf4w54a/AdsicEctD3BZABAPpOkemtHUrKCZ0pq/Qcws/7tPdpV2NU6SD
p3j35THe6Jr8VUMni10amNN28l476GcajsPWb53gIjQaxKdbNaiJunTLw3lbjuIw
jH3LKXaKXy0mxXm70YGNdZfOKwsVxEClwBuxV3s+TD6hhCkf6Xi9GizuqgdtqLEZ
AMAjAOH+7VKVIqAFeKXPlABN6RR7TVhJf1knWwm8FzFmFdfstBFjFIeeSptCQ+To
r9+rxI4r4O6hD2u6IKFLHYBU4iZVd0x7osDD59Cjkwi1CQgp07bK+WcFtf4rjV+6
oaROTq/FTtv1JlpaJ/LPiV97e0OxAs4aVGYO/PFsfVDFHPaeJAYdM2ZbwbOyNNZp
mn8EhmbQatX8t4zSy4bCo46/VdBeOAIJYs+nCZBq/yZrxziIWbjxg6dKPrwre0Co
iBi6BCt/mumt4uPdViNg3N5fwgBmPT/t1IxjJuOjXCR9B17XeKg=
=NGc/
-----END PGP SIGNATURE-----

--i6ogfjkah26q6ktw--
