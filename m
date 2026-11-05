Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793895521;
	b=wwyiCfV0uZpB2Vin4jgvh8gwpGPw5wWaqvRwccVtUg0Lz5QjiCe8HOYbuzPbyF9T0lUA
	 XiTqISDxZ7OZKH1StT+s/yWHCEIM5gy1Pa2RXWDsQxs70PyoAXZHeDOWBPzX2hseOKIyC
	 TgC07I+vOPOac9Iii6VQN3G27TJ87W2GfzNsgPaGdpv1vCV6rZkxbykziH2uXvRKYjjHs
	 694lG5/z4/OeHMXKYnQTreU1Y6+I+FCujj+y7bA9tR8g1lA0gCXbq1dIeyyOmoB6IL1q3
	 nyvCgE6PT1cV0B3GyRDu/REZQ2DOWvobuThohYDqvER3eW2dxFOcqobUweJKgdBpCzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793895521;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=jjGITOFEbZVfMgIGnW+wZ1UcQbDHnChGWTS+tVJ4LPo=;
	b=bzZsp2uvxC8lmkqMbOoLpfKc9fl7EYupWAyqK/9UIqHDk7VZUdvsLX77YANE+bmGe0Td
	 eR7ibS5ncA3iPRbt3CobYANv0VM74EwQA2Qcxx4huoNfvSc+PqmKWtngIRAGzfcksM16d
	 nGkTIK10zSj/zmipsXxHWBm7h2OsVrIlvx1RNCPVEtIafwLi3+QadCwKM3t6Vc3j7yq+g
	 mMH9B0uXghjat6Uh69XKje3Z/NYKRV7zgUUqwqI5Srue0JVmBgoUJ22GSbryBVYPXB1Eu
	 zXMcev3bMLaLK78rEMVvNvwtK79c3P6ID1uXP4olSRlwpdBWfjureWR9utFfM5pQ93g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Fvq8NHo8;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F894606EE80;
	Thu,  5 Nov 2026 16:18:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F894606EE80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Fvq8NHo8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793895521; x=1825431521;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+tKMfQT08C0WHdhvauaJZ31Qu1iXJYv2JxCKBEvtIII=;
  b=Fvq8NHo8O1KWRnK+tcR4pj28wRwvPKHY3g43LZGr1Tn/eFLf8kIfJ695
   yN8MvlgKSV2c7Njx6WUPmWY9gSkqOeivfVaHByhlKy+hK1L1HV61qPeLh
   Wfue22cAW9oxNrV2a0UEMW2FVisFf6PLBsEVbCoT0TwxRHQNP+sz4b5rW
   CKrwjpqFUlvZyM/t2ipLebfaN+qvMviT67RQyzKwIid9Ru1mD+buyIVC3
   ikt9QJKZToP9ohu1HtA4N0StlWFN/lb+VMJvynMKC6MY8dV6AlSUY+DBv
   tCkD1VJlECeGGCTk8m+LHRNvdjl4IwByDemrQklHExCRuCGrV88rOZpGT
   w==;
X-CSE-ConnectionGUID: ls83FEblQSSfAZC/saqQRw==
X-CSE-MsgGUID: JGgR8LdoTc6GMBkiMjbs6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2716024"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2716024"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 08:18:39 -0800
X-CSE-ConnectionGUID: VPPaJ+9hRqqWnjtDTyPN5g==
X-CSE-MsgGUID: 2X+7AsqFSfaAFSLbFky6Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7368194"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 08:18:24 -0800
Date: Thu, 5 Nov 2026 18:18:22 +0200
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
Message-ID: <auysTnqWgz2kE7e9@ashevche-desk.local>
References: <20261102175527.3957740-1-Frank.Li@oss.nxp.com>
 <aux2VKHnVLwq_wzi@orome>
 <auyQEVmA2KeGu9DL@ashevche-desk.local>
 <auyiAE3lhnFahBK2@orome>
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
In-Reply-To: <auyiAE3lhnFahBK2@orome>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 05, 2026 at 04:36:38PM +0100, Thierry Reding wrote:
> On Thu, Nov 05, 2026 at 04:17:53PM +0200, Andy Shevchenko wrote:
> > On Thu, Nov 05, 2026 at 01:28:46PM +0100, Thierry Reding wrote:
> > > On Mon, Nov 02, 2026 at 12:54:48PM -0500, Frank.Li@oss.nxp.com wrote:
> > > > 
> > > > Replace open-coded assignments to callback and callback_param fields
> > > > of struct dma_async_tx_descriptor with calls to the
> > > > dmaengine_desc_set_callback() helper across serial drivers.
> > > > 
> > > > No functional change intended. Prepare to make struct
> > > > dma_async_tx_descriptor private to the DMA engine.
> > > > 
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > >  drivers/tty/serial/8250/8250_dma.c  | 6 ++----
> > > >  drivers/tty/serial/8250/8250_mtk.c  | 3 +--
> > > >  drivers/tty/serial/8250/8250_omap.c | 6 ++----
> > > >  drivers/tty/serial/amba-pl011.c     | 6 ++----
> > > >  drivers/tty/serial/atmel_serial.c   | 6 ++----
> > > >  drivers/tty/serial/fsl_lpuart.c     | 6 ++----
> > > >  drivers/tty/serial/imx.c            | 6 ++----
> > > >  drivers/tty/serial/msm_serial.c     | 6 ++----
> > > >  drivers/tty/serial/mxs-auart.c      | 6 ++----
> > > >  drivers/tty/serial/pch_uart.c       | 6 ++----
> > > >  drivers/tty/serial/samsung_tty.c    | 6 ++----
> > > >  drivers/tty/serial/serial-tegra.c   | 6 ++----
> > > >  drivers/tty/serial/sh-sci.c         | 9 +++------
> > > >  drivers/tty/serial/sprd_serial.c    | 3 +--
> > > >  drivers/tty/serial/stm32-usart.c    | 6 ++----
> > > >  15 files changed, 29 insertions(+), 58 deletions(-)
> > > 
> > > Reviewed-by: Thierry Reding <treding@nvidia.com>
> > 
> > Krzysztof, now look at this case. I would argue that this is even less fit than
> > # subpart(s) case, because it might imply anything. Again the problem is the
> > bundle, and for such a case (when tons of independent changes are bundled in
> > the same stuff, *every* Rb tag has to be explained on what has been reviewed!
> 
> It may be a bit subtle, but the placement of the tag indicates that it
> applies to the entirety of the changes. I didn't crop the list of
> changed files, nor did I omit the summary.

This doesn't clarify the question. Wordless Rb tag on a bundles is an oddity.

> That bit of meta-data obviously isn't picked up into the tag line, but
> I think the default meaning of Reviewed-by is that it applies to the
> entire thing.

And I interpret it otherwise, because this is a set of independent changes
bundled into a single patch!

-- 
With Best Regards,
Andy Shevchenko


