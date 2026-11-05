Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793888290;
	b=nDnqHveOsjlBZDODRCALpmTiyKTvoTC+6Z8aosDRLv3QoWaJ5QgNAu8RdtHZ4cwjejxK
	 gV+eVfW+dpF+h9B39C+1D86M1SQexK06URcPe8GA/LWMENnfWj1PudjCZ1zItDnQFWQNQ
	 pSTXM4eKcScK9YyyppS+ci4oF9lcOJu41q6xeguvq4w7ZwP9IGe37Mq1YMsPPpRt8V76G
	 ROrYVPDBusjNkMS5Zfk6aCtfUiJeO1Va+yarmhzP0+S6B7/ovJHmKNBmrTo14yBMKvAQa
	 3QkAuexYHogHbxU5UYIIaA2xZbki3WhfOOQ9/q3Mm1Fl52xBOR0wNc9E+DHjvunspZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793888290;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=Dc/gnzAhwg9JcaLHyi5L3qyrYdSroOdQcEWvzqqzxB4=;
	b=B+K4s+1nn2UO0izeuZ7SBhSb+77qdT5zQDjpoBwXV+ZU8PfrWp11dhr8czPy/GBOmBpc
	 sQufj9j2bWrutxT2Fglj1GXvgOI11hAXuJsggk8lFVwqWYrmRzVHWhDsIkkQOegbubeYJ
	 Hbbi62u8Ts+ETZ/2E9ejsSa+gQxhjahi6jnsSTp7f8IEs1pYFeaHIyDoPyvwHwsqcbpzF
	 1oeRlbPnt6uSl6fP2EmdGQQv1Bs3HW+/iwHQ17Kup12SXW8S//BqaxZ5IuSRyOxTStQl9
	 ORbQ+7oWd6KSAIjkQsZG49dMPkDgSq76mbJEAtb3LgFeXCWT5G/xerK+gWQ0n8z525Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HjvAsSod;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A54606EEA8;
	Thu,  5 Nov 2026 14:18:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3A54606EEA8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HjvAsSod
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793888290; x=1825424290;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jvXrPTiATIoJywZObtDdCqNKWv1neRVMfk5S5z0aV5g=;
  b=HjvAsSodMEqWhD7xQ9duFtX/Y1TBzcUbetEUmkLaenCOulNLjZKi85mj
   CiXkyK0aZ6cZVBaWa0sZSZYSbnL3LnJ/EYQSudIbYGK/RR4pY1BofoN3u
   zkp7Z66Qeg6fKclSX1RTyuAXvo/8kSEwFpOp8QXWCKT0Hd8+g2t/eJFJX
   IHtZQbxYI0Ry812C9CKwBVyiv8i135sWsqf0gtagoke9rXfhWMDJUb4hY
   KeGgNAnddNmHq1NGOvwJkbpU17J0ffeIuGd4u4hg5nZhjTe27N7w51fL/
   NYx3Z8D6z2iYwfSV+vm9vXxoseN8GM7mAlMs1eUnyq+ovyUk080GKj7/7
   Q==;
X-CSE-ConnectionGUID: 5Zpy6bAHSfKBFOkgHxTgDg==
X-CSE-MsgGUID: YeQ0L+iMSeqizzuppIQENg==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2565223"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2565223"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 06:18:09 -0800
X-CSE-ConnectionGUID: pKCe4sF8RMqbCGGokzbkvg==
X-CSE-MsgGUID: G6AFEUqaSR+cIDxjk7O9OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7359195"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 06:17:56 -0800
Date: Thu, 5 Nov 2026 16:17:53 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thierry Reding <thierry.reding@kernel.org>
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
	Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
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
Message-ID: <auyQEVmA2KeGu9DL@ashevche-desk.local>
References: <20261102175527.3957740-1-Frank.Li@oss.nxp.com>
 <aux2VKHnVLwq_wzi@orome>
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
In-Reply-To: <aux2VKHnVLwq_wzi@orome>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 05, 2026 at 01:28:46PM +0100, Thierry Reding wrote:
> On Mon, Nov 02, 2026 at 12:54:48PM -0500, Frank.Li@oss.nxp.com wrote:
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
> Reviewed-by: Thierry Reding <treding@nvidia.com>

Krzysztof, now look at this case. I would argue that this is even less fit than
# subpart(s) case, because it might imply anything. Again the problem is the
bundle, and for such a case (when tons of independent changes are bundled in
the same stuff, *every* Rb tag has to be explained on what has been reviewed!

-- 
With Best Regards,
Andy Shevchenko


