Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901725;
	b=knxLPsgNH0xuxMvGr9rEA+LAnULCwuebYEbb8Tq0iE2SpVtoXPGmCZqi3Qt5FnRCg7eb
	 jlet7TjuMlBTzOOYsLZEvqQjy2KWERsZRA84Bde5Ii7PlhpnWWjtjJgOzMV05e+CXpNvP
	 ohhLkKmJMcas0smpoUPcwZoXSsv8alSrF4aFMjojK/q8dR3QX/73KEpnU5UGMjL5qzzxx
	 ZO2jC5dVOEf3kPBuVUGpTkZEDhEHHAtWnez40nwG7A6eetIxf+xTJSde8EW7Z9nSm+tfr
	 /SX8xcsgOyCG8UgMjEehfnyUmQTEd9MLUn6UiKJbyX1WIN5T7LuVyP9cCLXz1zg8KrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901725;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=t6PWC1eE/ypb4qPLQJ8oNFKL36rk1z0wUhJwubCVn0A=;
	b=OqdYXJthoEF6uCK7wKuk3ZWSRj8xOq63kL1dTA+JkgzqKEtLLD7JLm0R1cJg7eYchIgv
	 wc1sN/1zmFiWqTpCeUcQyMExg5tHbsNZLVCPtNyCKjkN8VfRWzMfu6fnqHiVD2KNtX5Bb
	 912U0L5r7v0y9RnyO0kJ31NhuCrIhs7adMrNTZIT8CxFBqd5BaWAb38kKCTFL58d/xWWG
	 wadS4OnP8XpuSR+L/0iwsIPzFD6mHo6QBXGPZRs76MEzAsIubkQS7+qq5JapQLgjizWBN
	 XdN1QBEhkD6WD3G/FlxNKh6C+2tTXPz7uVzxmlKdRPAqVsU9MmJFWOJCP0AVkEx3gdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="gkaO/+ln";
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9692D606D815;
	Thu,  5 Nov 2026 18:02:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9692D606D815
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gkaO/+ln
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793901725; x=1825437725;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wZcZ+09X62UsmqZYTYOPGpjxgnZfzRH+TDK05Cpt6Zc=;
  b=gkaO/+ln4JxoZS8xpRh4w6dTTzkfxqdqN8gm51Xswnxwx6A1NXM6JVhm
   VOFUaxqXXq3U1iAeCWBVzXsQmetF5nyvjYyMLzQ2o4KQ3ZMvu3aH91rk/
   EVNKCPVGpLYY3XoMyVFK4uwK+HuZRYQHZtsYlqPlODx9wsevO084ZIXz7
   RSX6TCrSHj4D5nWyoe9XwjjtLWjLxUxtxzj2gz/V9fyakqbJnMmVmeZwa
   1qyNlL+tTvX/+kqw8u795/r3V5ntN9db3ZIsIdCMBm4mn2YVbumGNszY4
   TlZzCtG/rfrnDBaQf4YcYD042kYbMImbRNbE+dTE3xEfYWaYNErbrgq5f
   Q==;
X-CSE-ConnectionGUID: aE780vfyT6WXYCYaCfHilA==
X-CSE-MsgGUID: APu4f+rJS86ciqQG3c31lQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2708927"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2708927"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 10:00:00 -0800
X-CSE-ConnectionGUID: p6BdeozpRwGA0VkthoS13A==
X-CSE-MsgGUID: L7eHp5OGTNyb9x3AbVTe5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7491841"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 09:59:46 -0800
Date: Thu, 5 Nov 2026 19:59:44 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Thierry Reding <thierry.reding@kernel.org>, Frank.Li@oss.nxp.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Message-ID: <auzEEOL4vLgt4z5I@ashevche-desk.local>
References: <20261102175527.3957740-1-Frank.Li@oss.nxp.com>
 <aux2VKHnVLwq_wzi@orome>
 <auyQEVmA2KeGu9DL@ashevche-desk.local>
 <2e12316d-d079-471f-9c29-ef5fb765216a@kernel.org>
 <auys4Yg-qAr4Rt5w@ashevche-desk.local>
 <e515960d-18fb-4d61-8842-beb6a73fbc27@kernel.org>
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
In-Reply-To: <e515960d-18fb-4d61-8842-beb6a73fbc27@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 05, 2026 at 05:26:18PM +0100, Krzysztof Kozlowski wrote:
> On 05/11/2026 17:20, Andy Shevchenko wrote:
> > On Thu, Nov 05, 2026 at 03:35:20PM +0100, Krzysztof Kozlowski wrote:
> >> On 05/11/2026 15:17, Andy Shevchenko wrote:
> >>>>> ---
> >>>>>  drivers/tty/serial/8250/8250_dma.c  | 6 ++----
> >>>>>  drivers/tty/serial/8250/8250_mtk.c  | 3 +--
> >>>>>  drivers/tty/serial/8250/8250_omap.c | 6 ++----
> >>>>>  drivers/tty/serial/amba-pl011.c     | 6 ++----
> >>>>>  drivers/tty/serial/atmel_serial.c   | 6 ++----
> >>>>>  drivers/tty/serial/fsl_lpuart.c     | 6 ++----
> >>>>>  drivers/tty/serial/imx.c            | 6 ++----
> >>>>>  drivers/tty/serial/msm_serial.c     | 6 ++----
> >>>>>  drivers/tty/serial/mxs-auart.c      | 6 ++----
> >>>>>  drivers/tty/serial/pch_uart.c       | 6 ++----
> >>>>>  drivers/tty/serial/samsung_tty.c    | 6 ++----
> >>>>>  drivers/tty/serial/serial-tegra.c   | 6 ++----
> >>>>>  drivers/tty/serial/sh-sci.c         | 9 +++------
> >>>>>  drivers/tty/serial/sprd_serial.c    | 3 +--
> >>>>>  drivers/tty/serial/stm32-usart.c    | 6 ++----
> >>>>>  15 files changed, 29 insertions(+), 58 deletions(-)
> >>>>
> >>>> Reviewed-by: Thierry Reding <treding@nvidia.com>
> >>>
> >>> Krzysztof, now look at this case. I would argue that this is even less fit than
> >>> # subpart(s) case, because it might imply anything. Again the problem is the
> >>> bundle, and for such a case (when tons of independent changes are bundled in
> >>> the same stuff, *every* Rb tag has to be explained on what has been reviewed!
> >>
> >> I think this case is obvious - Thierry reviewed this patch and gives Rb
> >> tag, according to reviewer's statement of oversight.
> > 
> > It's unclear from a bare tag, It misses that kind of information. Documentation
> > is also unclear to me as it does *not* describe the case what should I do when
> 
> Documentation is clear and I quote to you multiple times, to which you
> did not respond.
> 
> "Reviewed-by:, instead, indicates that *the patch* has been reviewed and
> found acceptable according to the Reviewer's Statement:"
> 
> Important: "THE PATCH"
> 
> Further:
> 
> "I state that:
> (a) I have carried out a technical review of *this patch* to evaluate
> its appropriateness and readiness for inclusion into  the mainline kernel."
> 
> And further:
> 
> "A Reviewed-by tag is a statement of opinion that *the patch* is an"
> 
> All of these are exhaustive (as in complete) statements leaving no
> interpretation whether this is part of patch or entire patch. It is THE
> patch, meaning entire patch.
> 
> You do not drive your car, as only a wheel. You driver *the car*.
> 
> You live in some apartment. *The apartment* is your home, not "piece of
> your apartment is your home".

And I'm trying to explain my point: "the car" in this case is actually "the cars"!
I drive mine, you driver yours. "The PATCH" is wrong term when it's bundled.

-- 
With Best Regards,
Andy Shevchenko


