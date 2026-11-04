Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793824204;
	b=nKbFJosFItIOxKS1Kjv2VcU7IlW3G3/kmB4D8y76M/5HLHBCUO83MAmEpG9tmL7fqEbc
	 fxGLpUXbDtyIJ2MJgu9PZ+lZKUHGXzKyuTvfrr6Cz/A725WOwmSTmGdHFaTNCEJft/zRL
	 0Tej3Qs8SwSn+HZBTbLCL1xYhoRvqShwYMrX7Dvhu+HW9tGgNX3vWhHdAOB7K0EXcujVi
	 zmQV8vJpbi8vW+qp/VEIxmKUlKtJtSqEzEfONL/dgeyajqdkyVAwRyxaLTQgrbvNsRSFC
	 d2Fd/zzkqSM6gZDHr9UhOqUNi+z2CdRRNjModJ01prEi8IDbPqTMlBjd/DLrL0B38/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793824204;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=Eecn0Ygaf7mft5z9aYz9Ro3xQK3/iLvYEIUNIgo48NA=;
	b=BFrucB80/IRC799zMYZ5VnkycmqAnjqCHXUpdfsFTW110BoTV0lQDVdwLk3PyyA6xALt
	 iIAgL6ZJu/Njl78V8/XatX0z0qVsNl2U3KXN+dTrptW+owS6cpr/dRkDTrhhffp5S2k0X
	 3V3EeGmJf5TuhmvZJW7m+QGRMLPUpvoBBoHpuXrggxX3Y8OBQaHRQuOJxBwR1lVJJTEwY
	 5IyNaa+doo1rtmOHD/A+IbannhOTaLgjPkxo7ed9KwW1ZBzwgQKJKKKm6mEkRWKu1LdV4
	 WH8SdfrfGW5Je+BuK6B4mC7/fPb5ga5w5qn8PJ59IDdWH1yT+9M9+nm72tYWAs2OzgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ervWPU05;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62483606A85B;
	Wed,  4 Nov 2026 20:30:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62483606A85B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ervWPU05
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793824204; x=1825360204;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h9DF1vrSe2ymxSVWOc4qaehYKUBrcFML5wxNEDR44VM=;
  b=ervWPU054MxM3yD7NhPWqzKv2KHLA1wIuk4zpWzWXYUKEbbIzygd/UYe
   iY+Mer79NV7PEcw8u86DwK79JroTgXOMuJa2mt468Umda/r1cZ2p3Jmdw
   9hxal88IPd0UFKyE9GZKVlSxq+9bfAM3QMbv1VdJxB/BxV569I+YPD5kb
   UjqSts3mV9XvgqMX/tjuOzvY496br1GHApZOdYNBsAT+vmk11QsIp6KRj
   KLQTEOuttfWgoziMrKP1hRCZT8UUm9Hm/osC0Fy6tIKaHyEBy3Avfzb0o
   +1jr+3gfLJ2pB3EcZW+A5F97q4l/JYPQMyIjPzqJ43FBwulbV/quyegt6
   g==;
X-CSE-ConnectionGUID: pEu2zE5RTBSgUgsFbdSrmA==
X-CSE-MsgGUID: MdG0BsAoR9GYaL3kmgGE+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2602484"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2602484"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 12:30:02 -0800
X-CSE-ConnectionGUID: 4s+PIBaTRcCfJB/9Fu/CBQ==
X-CSE-MsgGUID: W8xphM45RZOPK4ny68SHrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6825384"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 12:29:49 -0800
Date: Wed, 4 Nov 2026 22:29:46 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Frank.Li@oss.nxp.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Cunhao Lu <1579567540@qq.com>, Raul E Rangel <rrangel@chromium.org>,
	Yenchia Chen <yenchia.chen@mediatek.com>,
	Zhiyong Tao <zhiyong.tao@mediatek.com>,
	Carlo Caione <ccaione@baylibre.com>, Moteen Shah <m-shah@ti.com>,
	Kendall Willis <k-willis@ti.com>,
	Kartik Rajput <kkartik@nvidia.com>, Fan Wu <fanwu01@zju.edu.cn>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	Stefan =?iso-8859-1?Q?D=F6singer?= <stefandoesinger@gmail.com>,
	Shitalkumar Gandhi <shital.gandhi45@gmail.com>,
	Peng Fan <peng.fan@nxp.com>, Sherry Sun <sherry.sun@nxp.com>,
	John Ogness <john.ogness@linutronix.de>,
	Pan Chuang <panchuang@vivo.com>, Petr Mladek <pmladek@suse.com>,
	Robin Gong <yibin.gong@nxp.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Zhaoyang Yu <2426767509@qq.com>,
	"Nikola Z. Ivanov" <zlatistiv@gmail.com>,
	Haoxiang Li <haoxiang_li2024@163.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Myeonghun Pak <mhun512@gmail.com>,
	Wenhua Lin <Wenhua.Lin@unisoc.com>, Cixi Geng <cixi.geng@linux.dev>,
	"open list:TTY LAYER AND SERIAL DRIVERS" <linux-kernel@vger.kernel.org>,
	"open list:TTY LAYER AND SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
	"open list:ARM/FREESCALE IMX / MXC / LAYERSCAPE ARM ARCHIT..." <imx@lists.linux.dev>,
	"open list:ARM/QUALCOMM MAILING LIST" <linux-arm-msm@vger.kernel.org>,
	"open list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" <linux-samsung-soc@vger.kernel.org>,
	"open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>,
	vkoul@kernel.org
Subject: Re: [PATCH 1/1] tty: serial: use dmaengine_desc_set_callback()
Message-ID: <auuVum_cd7MgGDUq@ashevche-desk.local>
References: <20261102175527.3957740-1-Frank.Li@oss.nxp.com>
 <a2d5ea00-bfa1-4883-923d-0a6a7eaa556d@kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2d5ea00-bfa1-4883-923d-0a6a7eaa556d@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 04, 2026 at 06:41:08PM +0100, Krzysztof Kozlowski wrote:
> On 02/11/2026 18:54, Frank.Li@oss.nxp.com wrote:
> > 
> > Replace open-coded assignments to callback and callback_param fields
> > of struct dma_async_tx_descriptor with calls to the
> > dmaengine_desc_set_callback() helper across serial drivers.
> > 
> > No functional change intended. Prepare to make struct
> > dma_async_tx_descriptor private to the DMA engine.

...

> I did not look at this code at all...
> 
> > index 640f85e2d636b..3f82a83998e1c 100644
> > --- a/drivers/tty/serial/samsung_tty.c
> > +++ b/drivers/tty/serial/samsung_tty.c
> > @@ -447,8 +447,7 @@ static int s3c24xx_serial_start_tx_dma(struct s3c24xx_uart_port *ourport,
> >  		return -EIO;
> >  	}
> >  
> > -	dma->tx_desc->callback = s3c24xx_serial_tx_dma_complete;
> > -	dma->tx_desc->callback_param = ourport;
> > +	dmaengine_desc_set_callback(dma->tx_desc, s3c24xx_serial_tx_dma_complete, NULL, ourport);
> >  	dma->tx_bytes_requested = dma->tx_size;
> >  
> >  	ourport->tx_in_progress = S3C24XX_TX_DMA;
> > @@ -642,8 +641,7 @@ static void s3c64xx_start_rx_dma(struct s3c24xx_uart_port *ourport)
> >  		return;
> >  	}
> >  
> > -	dma->rx_desc->callback = s3c24xx_serial_rx_dma_complete;
> > -	dma->rx_desc->callback_param = ourport;
> > +	dmaengine_desc_set_callback(dma->rx_desc, s3c24xx_serial_rx_dma_complete, NULL, ourport);
> >  	dma->rx_bytes_requested = dma->rx_size;

> ... but apparently reviewing only a few lines out of 400 is still reviewing:
> 
> https://lore.kernel.org/all/9e39502a-dd17-4fa2-98a3-9019523cb5e8@kernel.org/
> 
> Therefore:
> 
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

That's why I have added a trail to it to show what exactly I has reviewed,
this is a common practice, no?

Does this ring a bell 34d1e754155b ("dt-bindings: iio: drop unneeded quotes")?

-- 
With Best Regards,
Andy Shevchenko


