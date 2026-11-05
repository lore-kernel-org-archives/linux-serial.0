Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793870156;
	b=zLfObopN8RT0fUENIhHLN9hiP6SQ+KhZH8qguJprwfe/8NDVKy6jkRUeFUNXM4/4fvVO
	 gQpnFb2Q2Sg0ZKR/9K/ddGM/yCkXQXfGKYzOXuqmN4A9+Rlt2tARKnb7m5y46FPPviIbz
	 kW8I6/wRr1gs9Nke16QXF4VsUdNd06HLzKgMf4JPFpC6oukddz+WTeH6iK8tbtqOKchAV
	 xJhvpYDMtZeIWvslealaKhis6anv41Cz/syRfODPCMwQxKjK6xW5k5FgIBWizrJGfZ2vR
	 yo8A1xMHGQGKc5abhAl477ofl+p8wRXDFF0RAxlRg/oqM9w6ihAipOhhdo1ykaFrvwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793870156;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=gp+XvZ8u5ZE7X4dajdQ+NYbiZBnTVLgwCjJL4l80lxA=;
	b=xqTjWhrjwoZQo1+qv1WqwBr+d1BuK/6BYWUz0eZkcro7V28YWgI4xY8YEwPA/khEktY2
	 ec5GFzKwtYfCNWC7Ah0XNHrx2JXBZGvGTLe+N6WPGkDXPoFzs50YH87kTHOMoHQHY/fYr
	 1LGYVFBk7B+usABFgfjz3fwux7PQZWUESNOyQfTq8uH0Ph5nEKwHj3LYLJWFfbAl4kORc
	 C4KoIIVBno/huac2Lv7RDHYxhYlc4zlTUV2ZSVxRIQlVM2852FR15N2/jcyCAtHeOWTv/
	 jJoJjDFW5YUqd/TIG3WIAoKJ2XXPi+OtDi0QbL0cWxw4j6Ss5K8tj9zSzR6gYSHFX4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.219.53
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098C4606A328
	for <linux-serial@vger.kernel.org>; Thu,  5 Nov 2026 09:15:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 098C4606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-91c5e31bea9so22589506d6.1
        for <linux-serial@vger.kernel.org>; Thu, 05 Nov 2026 01:15:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793870155; x=1794474955;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gp+XvZ8u5ZE7X4dajdQ+NYbiZBnTVLgwCjJL4l80lxA=;
        b=g+8GfPQpM2vRAAtw99n6hQVL9ZtNz2VCPelUOJPQywfwlHY6Ctkm5cCBYE20YIE+Ab
         NXYArjkpotvvcsR1Y3or/OCEJmFwhqpTI/COoT/e4qgzU7AVgdaeh5VJfBu+TDnTkoMF
         914dRJoRZvKk38U/lH8bcIWkdfSFVLjzEVXs60WqrSld3OZJSkUT4/zKAS9tr3bvs0o+
         QvYNvlts7WXhnSSyhf9LYaVXgNudqMlqMgP7BO2VQA+bXkWj5cYMaAu7+w04rohiKWGc
         OgOUxpVwchEyuJWlt4LPKvFz6YgSJz9XzqF9qFrUdC+uCW6VcBGm7gif2pUy4vWt1344
         SBnQ==
X-Forwarded-Encrypted: i=1; AKwUvBwGhlGl/MkjOuuEnPNqpE2r8XfRPXw7N+DDO1lwuHTTMwTT8zZGqo1LcBHFptaEhiiEoQ2dy8vVjsZ5fqY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/zNnfZ7I/+Zj8xol4rWOtmmBl2BdqEs7iS5GVI7WexVcv/mzRv
	6d3PfdQYLZqRgoF6cvCGKnhyYysmOa9TtLmwOs8fA05fNnFW6o3EBpKPgokt6kkLBvs=
X-Gm-Gg: AYBFou3KHPVCMWdznWRTADrf/ZwQMLAvtIllmDA5JBtApfiA1HRzYi3b6hUz5VdQhli
	a+2fd9xSruge2hJNk0P3Mo736rlQMiP+NfTmgohNPArcIr/Ibv6u+f5SnRJaw3TaXMNsDXwzEVJ
	/tL3WI6epurytW493lOjxdWO9b6nmhanzNPlhOqoTkLQ0pjz6/frNjBm37d49Ri902lTWINSv3q
	YbO3GA60SzsZ+ZRv6j6JUj/7aot5U9gp1fSd3Pdt1ZTdo/VntOuhbRCwC7K+cx3eSkk/x+pkAYB
	Qs6CRR942HR9RX9eO8fYRtkJABehUwrLyX8G4ISNIbWnIWxbl0n8OaB/V7hyEmsDk48XlYnYfar
	DdxiUChrsYUxzGtaxNpJo+VDz2jDepHg82Rp3571d4l7OKg9dMiVp/AFEtSRAoTQ554O/HNB0KL
	toTp2PHvd4ay2xeg4q3sBafKY6LzFQkV3+CgUnhaXcv8FczchHDxGcBDlJGgI/GCveA4PriXeRA
	JTh36Pre2FIkQMgux67ROESsJUNpgfpN7uXv8Sjc1DtNSyZN9eIas969h/XpzOxIqEvTs1Kmyxl
	t7vYiTJiixQofnslhn3YH6zcw4m+gVMgNzG0Hq7WcSaJVfnjh2omY9hdIqaXe3IbUIoN/Q==
X-Received: by 2002:a05:6214:da4:b0:91e:8ee1:9307 with SMTP id 6a1803df08f44-91e8ee1b1d1mr52624866d6.1.1793870154911;
        Thu, 05 Nov 2026 01:15:54 -0800 (PST)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com. [209.85.222.170])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e8dac2a3esm27005086d6.1.2026.11.05.01.15.54
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 01:15:54 -0800 (PST)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-93e7ad9f78dso196067385a.1
        for <linux-serial@vger.kernel.org>; Thu, 05 Nov 2026 01:15:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBylCgSc85wsLmyHiq0YfQIHspmSJyMyNMHJ9jsGs0u+yTx48h0pJ9iFfDXa+2JTe5ISyDMKknouPlecCss=@vger.kernel.org
X-Received: by 2002:a05:6102:c4f:b0:7cc:3eb0:6ece with SMTP id
 ada2fe7eead31-7d072d53fa3mr9146730137.33.1793869733877; Thu, 05 Nov 2026
 01:08:53 -0800 (PST)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102175527.3957740-1-Frank.Li@oss.nxp.com>
In-Reply-To: <20261102175527.3957740-1-Frank.Li@oss.nxp.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 10:08:40 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWHyQhJwFHd5dguORb0=KTeQPT8AwMr0Uo6UAJRcn-fsg@mail.gmail.com>
X-Gm-Features: AclHuK-Joxo1A4dnmlO7hQLoxC6QCg3Be9nelvt7mgpbpsg01EIWZ9Dok6aJ4CQ
Message-ID: <CAMuHMdWHyQhJwFHd5dguORb0=KTeQPT8AwMr0Uo6UAJRcn-fsg@mail.gmail.com>
Subject: Re: [PATCH 1/1] tty: serial: use dmaengine_desc_set_callback()
To: Frank.Li@oss.nxp.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Russell King <linux@armlinux.org.uk>, Richard Genoud <richard.genoud@bootlin.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Laxman Dewangan <ldewangan@nvidia.com>, 
	Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Cunhao Lu <1579567540@qq.com>, 
	Raul E Rangel <rrangel@chromium.org>, Yenchia Chen <yenchia.chen@mediatek.com>, 
	Zhiyong Tao <zhiyong.tao@mediatek.com>, Carlo Caione <ccaione@baylibre.com>, 
	Moteen Shah <m-shah@ti.com>, Kendall Willis <k-willis@ti.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Kartik Rajput <kkartik@nvidia.com>, 
	Fan Wu <fanwu01@zju.edu.cn>, Nicolai Buchwitz <nb@tipi-net.de>, 
	Karl Mehltretter <kmehltretter@gmail.com>, =?UTF-8?Q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>, 
	Shitalkumar Gandhi <shital.gandhi45@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
	Sherry Sun <sherry.sun@nxp.com>, John Ogness <john.ogness@linutronix.de>, 
	Pan Chuang <panchuang@vivo.com>, Petr Mladek <pmladek@suse.com>, Robin Gong <yibin.gong@nxp.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
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
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Nov 2026 at 18:56, <Frank.Li@oss.nxp.com> wrote:
> From: Frank Li <Frank.Li@nxp.com>
>
> Replace open-coded assignments to callback and callback_param fields
> of struct dma_async_tx_descriptor with calls to the
> dmaengine_desc_set_callback() helper across serial drivers.
>
> No functional change intended. Prepare to make struct
> dma_async_tx_descriptor private to the DMA engine.
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

>  drivers/tty/serial/sh-sci.c         | 9 +++------

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be> # sh-sci

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
