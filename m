Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793870060;
	b=v99tgczDoSW3/V/4fJxjiELMBlXH/tlNeX88L/d+riG850HrVSEpZ7X89hCxN0KjifsJ
	 WRjCzyrV7GxYT7PAX+OBg71eWMGk8HyP/z+oK4jVgu/edw9+tfSG3eDkCP2fOXUNeXyvP
	 wuu5LqwQzO25+0YG9xOlIPWn2WmOmwAV3qfVkpHkWmxZiz/r5JDaifciqEUfZwJwF5wSV
	 ymMvvcOT8R8vl6boFAjWiIgz7mHF8K9bjY9uQhYUbq1xWKjwUPUcDe9jMWslDuEHelE4r
	 yl3LazjcC5HklHfgY6bEXPDgGmqcCiNqo5CwLbwLhZOC6RO1Qzsau6DwoRgQqqT8Olw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793870060;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=szpNfl+GjhJRGxd5gIdXT6EIIa0n90qEKCnRhD5COi8=;
	b=im/un20HXJt+EWpxmew/WnIQ4tGuGH+aRwFiwUJT1EE/IxZQ/9tYWQLQwntKiop2s7JH
	 cPfvci+5olzXvOMFDn0RB3GHdELZwMe2KZCgme1XA+m3+325nShw+Z0PT7NddEMWab1iE
	 nVX/UeSO9/wjSXQzqPbQMo7xeE3Fl65uU9WdfHSYcJS6iCaBtdg3JFkhvB2NqFDjYFGGW
	 GAdZR2j/7LSws/vphX+oXCKqSXQFnpvdM6RPeBpVxaITudZFqzS/yCKLubc0EdF4i5co8
	 041XpjaiMq/WfjudAH3Hj5UpvBpEc3uPgpxdqfgX0JL6qMB87RIi795evOtlqAR3DzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.217.49
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DB3606A329
	for <linux-serial@vger.kernel.org>; Thu,  5 Nov 2026 09:14:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78DB3606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-7bec5112765so1008371137.1
        for <linux-serial@vger.kernel.org>; Thu, 05 Nov 2026 01:14:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793870059; x=1794474859;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=szpNfl+GjhJRGxd5gIdXT6EIIa0n90qEKCnRhD5COi8=;
        b=aTohnW/s+v8wqRV/GdX3NSfpW54b/8nQvtvuRxdd34sA1N0Ug0eCFl6IQH+T0zCpoO
         lc+Ey60Nr0mKAI1Lp74r3C843Udj7wAP7pqRcMO2mWgxbqQbVLYLBiFR9Yt6DswXeYFy
         sqmpSaFNPdUT03N5bjj1fzaiRWj+KetpSTmwyqU4NBBzC6gUN+oGcn3Q+42rL9ricNJP
         vbjx6bQG7TFf8BfoMguEex6EARmLoz9VvkyCswoT3gE6Ebu2BWtezVPdXU0l1ZQEiMmK
         SR7iR1ESYq83oTjmgBt5WjSX23B/GyHd4sJ0UsWrsr2g9XMhmHAwu0eAA6bpbmS0PF2W
         hQhw==
X-Forwarded-Encrypted: i=1; AKwUvBymBdrqbR5JwBSlidPpCQ783zyxt9BEr/bpIcDG37yGZSVssFiFz71GxKX/FQe7KmL77wPRCxDLY+Qs7yA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9JFtNc8L45a2XBKnERcjbd4YdScgapoy9Xekm3bItpQx74mK44
	82rpnXrBIkqF/0vyA0k0+A73TpSA4DfnYxd7fqQWDlBcbseNzmu29cvRVt0YXTLjQGc=
X-Gm-Gg: AYBFou39pjUVEfNnH/gCjHhHfkUuG3LfXjwwdvVsdIU8K8H/GYObhYF/vG1tliluy98
	r4IepXcFOURlOqR0aCUxrUh9CEb/sWQNMJ+wVRkJ79XYLnqsi4jT51s5ZwXSQMrVQVQFRE4c14Q
	NyYVzTMlwZwac1LDdOntIQT44Q+ptzQqLUvs/LcN8GcRQGEqVRv7APrzDoFX3ydP4JtfTJS3Gnn
	pp0wxsi8969nRn64LpkwkfhAvyRV60EKLYm3RUBXjCmJyVZmxJpUgsyGlOM/O2K2ijGEk2BHPye
	nf+i2lAVt5n5IKY9w1yc2xzYevREUNoU/nUP60DiRqdE6slC0p3HbRh+t6hIS4Q8muFa9sc+u8J
	ZxkHmqbvFA3Lm00Qqs1AyxO5R1LBO3NJiPxFMt01ZDVSIA2A6qYxfgTdKZtNIcBFCFyzPjjpTfl
	4oNePB9F6HnzFfmgC9woOQSQN4ysd2S0krqUsjPsO411e77qkPuFcA0Hv2AEmGm5qczCZ7V8oIU
	guynwN+6KSZNYyCPyEEzH6xjuUgGhosYBcu4FHZ3Gy0SlwbvOcFMV27fP6xSZ9vuS3GeyS4WJs5
	HUfPH1XRF3f4AS36cuVAjAm8hGJ6VoKwByWN4eDxDWtCFBrWW1r12BEAiZp6kbHk8VJkDg==
X-Received: by 2002:a67:e109:0:b0:7d0:6cf3:d8f6 with SMTP id ada2fe7eead31-7d072ce1bbemr7093675137.28.1793870059513;
        Thu, 05 Nov 2026 01:14:19 -0800 (PST)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998d91d2693sm3977395241.7.2026.11.05.01.14.19
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 01:14:19 -0800 (PST)
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5eaaa9b1591so1144254e0c.3
        for <linux-serial@vger.kernel.org>; Thu, 05 Nov 2026 01:14:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBx+Ta45US42mqqRJq7Qc7XLrr7G7XwC9rojG35cjckg1QKoGyGHCDs/yMMtgF9W8f1idCJvZU40hj3pTZw=@vger.kernel.org
X-Received: by 2002:a05:6102:a206:10b0:7d2:8610:3223 with SMTP id
 ada2fe7eead31-7d286103264mr1300643137.34.1793869578105; Thu, 05 Nov 2026
 01:06:18 -0800 (PST)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102175527.3957740-1-Frank.Li@oss.nxp.com> <a2d5ea00-bfa1-4883-923d-0a6a7eaa556d@kernel.org>
In-Reply-To: <a2d5ea00-bfa1-4883-923d-0a6a7eaa556d@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 10:06:06 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUHf14DpLfk16qZ6YWtJKm8VDWEFA0Wqk22ysqnUFHoHQ@mail.gmail.com>
X-Gm-Features: AclHuK_EWQ4VeHP65pJfIPjcWj5wVVyn8PWm9OHeuqD-F_-a-ZgbZgStzpLwqQc
Message-ID: <CAMuHMdUHf14DpLfk16qZ6YWtJKm8VDWEFA0Wqk22ysqnUFHoHQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] tty: serial: use dmaengine_desc_set_callback()
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Frank.Li@oss.nxp.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Russell King <linux@armlinux.org.uk>, Richard Genoud <richard.genoud@bootlin.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Peter Griffin <peter.griffin@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Laxman Dewangan <ldewangan@nvidia.com>, Thierry Reding <thierry.reding@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Cunhao Lu <1579567540@qq.com>, Raul E Rangel <rrangel@chromium.org>, 
	Yenchia Chen <yenchia.chen@mediatek.com>, Zhiyong Tao <zhiyong.tao@mediatek.com>, 
	Carlo Caione <ccaione@baylibre.com>, Moteen Shah <m-shah@ti.com>, Kendall Willis <k-willis@ti.com>, 
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

Hi Kezysztof,

On Wed, 4 Nov 2026 at 18:41, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 02/11/2026 18:54, Frank.Li@oss.nxp.com wrote:
> > From: Frank Li <Frank.Li@nxp.com>
> >
> > Replace open-coded assignments to callback and callback_param fields
> > of struct dma_async_tx_descriptor with calls to the
> > dmaengine_desc_set_callback() helper across serial drivers.
> >
> > No functional change intended. Prepare to make struct
> > dma_async_tx_descriptor private to the DMA engine.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/tty/serial/8250/8250_dma.c  | 6 ++----
> >  drivers/tty/serial/8250/8250_mtk.c  | 3 +--
> >  drivers/tty/serial/8250/8250_omap.c | 6 ++----
> >  drivers/tty/serial/amba-pl011.c     | 6 ++----
> >  drivers/tty/serial/atmel_serial.c   | 6 ++----
> >  drivers/tty/serial/fsl_lpuart.c     | 6 ++----
> >  drivers/tty/serial/imx.c            | 6 ++----
> >  drivers/tty/serial/msm_serial.c     | 6 ++----
> >  drivers/tty/serial/mxs-auart.c      | 6 ++----
> >  drivers/tty/serial/pch_uart.c       | 6 ++----
> >  drivers/tty/serial/samsung_tty.c    | 6 ++----
> >  drivers/tty/serial/serial-tegra.c   | 6 ++----
> >  drivers/tty/serial/sh-sci.c         | 9 +++------
> >  drivers/tty/serial/sprd_serial.c    | 3 +--
> >  drivers/tty/serial/stm32-usart.c    | 6 ++----
> >  15 files changed, 29 insertions(+), 58 deletions(-)
>
> ...
> I did not look at this code at all...

[...]

> Therefore:
>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Then please add "# samsung", to make it clear and obvious.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
