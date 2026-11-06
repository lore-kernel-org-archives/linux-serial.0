Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793949808;
	b=wAIgicZBXTZIe2PiA4nQBcyBOL7Hqyw9peysIxSbIaSwMySYRlycUnOq2e2TX8949lWg
	 t3G6cazWVEvoJRdfDRBaqJsPjdf9TU236Pdkcm3decA74KUqPDSwwkiaMV62Xr1cWSqos
	 R++wB2HMWKBuWr8eBM8VSYe6MrASpsZS91r4hdBaNcc1b0zPn5rMQaif7/CgGe3YpQtEv
	 HHkJ7HM44/yvXtw3MOxAwuZhjF3UhFYP1USC/CSsF9smQlYXM1wXENy2fDdSwdOB2CW5a
	 SLPWLjX0StO7bGaXH5Vl3wjlHtvrsMn2ShAPrdLixDK4frOb+0BS1LI29Hb8cv72Htw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793949808;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=AsDZKqqDajMBUIC7cMkctVE7Ylj5bg3zvbe3cPAhv1Y=;
	b=wKRhbskBFQPrwv31VCsWJtC8O4Jp6LOUspm/T44WxV7qSU2VTFjNWO3QjBZ17LJycJpZ
	 IKFh5RKxM9cvVJAJqzDZJ3rD5VyIKwXxJ0vXXjeC+9tSkYVZfsCcQHiQcNJ9f5vEt5j+e
	 XAlE0q+aYmV3i8K4alhm1IcPf6auzKMhub6+OhfBuFf8/Ijb+4OvBsWIPVbSk48UpMnOc
	 2P3V6eR+BTTUM3y2ADEgrCKcWwr9W3dZe358algSTPCawxFS2eLhIGBsGTN4NOnyQx4s9
	 luGEwCkPG8+HTylrWVE0Ddx5JTAvxmx9/aWM3dKSvsFj0brlGDowUDCOI61RvrH92Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kgJBzU0N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73825606A326;
	Fri,  6 Nov 2026 07:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kgJBzU0N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41CB01F0089F;
	Fri,  6 Nov 2026 07:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793949808;
	bh=AsDZKqqDajMBUIC7cMkctVE7Ylj5bg3zvbe3cPAhv1Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=kgJBzU0N1n5nt2hHMVInzjEkXlwGE6VDOyj1Kv2Wbr8H7oSFuLDXVEVt+UnrReaRP
	 K+dR5cN2F2vuH+ZGr0wq29U05XpPWMIKBkujPMbrU3GboHvPTdLsN4Xh7GGh8bch1G
	 1QlngknOWDBzQxm1/nB+l6SNB8ndDegWthwes9LVigF+Vg8eU9xjI+FYqlRHN7t/VI
	 LYS8uWMP7UzAs4VANdjyMy6/SJ65AdiRt6H1/hbMSO9mAoh/Z/L63BxDEyV6C40Iih
	 m9q8W2sK7lZi4s7mmdEy+rg4NrcxbKPa+1ocf/betMbpiQMCdfnFLhaifzKFo/HWAY
	 0aPZMgVdHBL3A==
Message-ID: <b413ede5-3b18-4743-8e4b-6f44de6bf871@kernel.org>
Date: Fri, 6 Nov 2026 08:23:04 +0100
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] tty: serial: use dmaengine_desc_set_callback()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Thierry Reding <thierry.reding@kernel.org>, Frank.Li@oss.nxp.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Russell King <linux@armlinux.org.uk>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Peter Griffin
 <peter.griffin@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Laxman Dewangan <ldewangan@nvidia.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Orson Zhai <orsonzhai@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Cunhao Lu <1579567540@qq.com>, Raul E Rangel <rrangel@chromium.org>,
 Yenchia Chen <yenchia.chen@mediatek.com>,
 Zhiyong Tao <zhiyong.tao@mediatek.com>, Carlo Caione <ccaione@baylibre.com>,
 Moteen Shah <m-shah@ti.com>, Kendall Willis <k-willis@ti.com>,
 Kartik Rajput <kkartik@nvidia.com>, Fan Wu <fanwu01@zju.edu.cn>,
 Nicolai Buchwitz <nb@tipi-net.de>, Karl Mehltretter
 <kmehltretter@gmail.com>, =?UTF-8?Q?Stefan_D=C3=B6singer?=
 <stefandoesinger@gmail.com>, Shitalkumar Gandhi <shital.gandhi45@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Sherry Sun <sherry.sun@nxp.com>,
 John Ogness <john.ogness@linutronix.de>, Pan Chuang <panchuang@vivo.com>,
 Petr Mladek <pmladek@suse.com>, Robin Gong <yibin.gong@nxp.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Stephan Gerhold <stephan.gerhold@linaro.org>, Zhaoyang Yu
 <2426767509@qq.com>, "Nikola Z. Ivanov" <zlatistiv@gmail.com>,
 Haoxiang Li <haoxiang_li2024@163.com>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Myeonghun Pak <mhun512@gmail.com>, Wenhua Lin <Wenhua.Lin@unisoc.com>,
 Cixi Geng <cixi.geng@linux.dev>,
 "open list:TTY LAYER AND SERIAL DRIVERS" <linux-kernel@vger.kernel.org>,
 "open list:TTY LAYER AND SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-mediatek@lists.infradead.org>,
 "open list:ARM/FREESCALE IMX / MXC / LAYERSCAPE ARM ARCHIT..."
 <imx@lists.linux.dev>,
 "open list:ARM/QUALCOMM MAILING LIST" <linux-arm-msm@vger.kernel.org>,
 "open list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES"
 <linux-samsung-soc@vger.kernel.org>,
 "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
 "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-stm32@st-md-mailman.stormreply.com>, vkoul@kernel.org
References: <20261102175527.3957740-1-Frank.Li@oss.nxp.com>
 <aux2VKHnVLwq_wzi@orome> <auyQEVmA2KeGu9DL@ashevche-desk.local>
 <2e12316d-d079-471f-9c29-ef5fb765216a@kernel.org>
 <auys4Yg-qAr4Rt5w@ashevche-desk.local>
 <e515960d-18fb-4d61-8842-beb6a73fbc27@kernel.org>
 <auzEEOL4vLgt4z5I@ashevche-desk.local>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <auzEEOL4vLgt4z5I@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/11/2026 18:59, Andy Shevchenko wrote:
> On Thu, Nov 05, 2026 at 05:26:18PM +0100, Krzysztof Kozlowski wrote:
>> On 05/11/2026 17:20, Andy Shevchenko wrote:
>>> On Thu, Nov 05, 2026 at 03:35:20PM +0100, Krzysztof Kozlowski wrote:
>>>> On 05/11/2026 15:17, Andy Shevchenko wrote:
>>>>>>> ---
>>>>>>>  drivers/tty/serial/8250/8250_dma.c  | 6 ++----
>>>>>>>  drivers/tty/serial/8250/8250_mtk.c  | 3 +--
>>>>>>>  drivers/tty/serial/8250/8250_omap.c | 6 ++----
>>>>>>>  drivers/tty/serial/amba-pl011.c     | 6 ++----
>>>>>>>  drivers/tty/serial/atmel_serial.c   | 6 ++----
>>>>>>>  drivers/tty/serial/fsl_lpuart.c     | 6 ++----
>>>>>>>  drivers/tty/serial/imx.c            | 6 ++----
>>>>>>>  drivers/tty/serial/msm_serial.c     | 6 ++----
>>>>>>>  drivers/tty/serial/mxs-auart.c      | 6 ++----
>>>>>>>  drivers/tty/serial/pch_uart.c       | 6 ++----
>>>>>>>  drivers/tty/serial/samsung_tty.c    | 6 ++----
>>>>>>>  drivers/tty/serial/serial-tegra.c   | 6 ++----
>>>>>>>  drivers/tty/serial/sh-sci.c         | 9 +++------
>>>>>>>  drivers/tty/serial/sprd_serial.c    | 3 +--
>>>>>>>  drivers/tty/serial/stm32-usart.c    | 6 ++----
>>>>>>>  15 files changed, 29 insertions(+), 58 deletions(-)
>>>>>>
>>>>>> Reviewed-by: Thierry Reding <treding@nvidia.com>
>>>>>
>>>>> Krzysztof, now look at this case. I would argue that this is even less fit than
>>>>> # subpart(s) case, because it might imply anything. Again the problem is the
>>>>> bundle, and for such a case (when tons of independent changes are bundled in
>>>>> the same stuff, *every* Rb tag has to be explained on what has been reviewed!
>>>>
>>>> I think this case is obvious - Thierry reviewed this patch and gives Rb
>>>> tag, according to reviewer's statement of oversight.
>>>
>>> It's unclear from a bare tag, It misses that kind of information. Documentation
>>> is also unclear to me as it does *not* describe the case what should I do when
>>
>> Documentation is clear and I quote to you multiple times, to which you
>> did not respond.
>>
>> "Reviewed-by:, instead, indicates that *the patch* has been reviewed and
>> found acceptable according to the Reviewer's Statement:"
>>
>> Important: "THE PATCH"
>>
>> Further:
>>
>> "I state that:
>> (a) I have carried out a technical review of *this patch* to evaluate
>> its appropriateness and readiness for inclusion into  the mainline kernel."
>>
>> And further:
>>
>> "A Reviewed-by tag is a statement of opinion that *the patch* is an"
>>
>> All of these are exhaustive (as in complete) statements leaving no
>> interpretation whether this is part of patch or entire patch. It is THE
>> patch, meaning entire patch.
>>
>> You do not drive your car, as only a wheel. You driver *the car*.
>>
>> You live in some apartment. *The apartment* is your home, not "piece of
>> your apartment is your home".
> 
> And I'm trying to explain my point: "the car" in this case is actually "the cars"!
> I drive mine, you driver yours. "The PATCH" is wrong term when it's bundled.

It is still the patch being reviewed on the list, regardless how much
you dislike bundling or how much you would like to call it. And in my
example from the commit to workflows (not here), the patch COULD NOT be
split. The patch was consisting of main part and drivers update, so
skipping the main part invalidates entire review from statement of
oversight point of view.

Reviewer's statement of oversight does not allow you to add Rb tag for
partial reviews.

Best regards,
Krzysztof
