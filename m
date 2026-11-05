Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793895688;
	b=JWx7TM+t95RSat3O33LuoObrKvp8tm+iAo9LWXm4vZ3oD2oHBL7ctUiHxXMLvBcTtyBT
	 MFOwse1wT+JUPopibtNmvVlhItKAvxXZOOsVKDVvU38g+QRt09LIx6KNyhw2YdLB1knw/
	 JARGo7lKxpdGXjicbHVCIexa1GWz5RV/3xHBtku0c5xWpWHqLo8XvbpIpF1bem2CCJI+P
	 VKKot8u+XAlKo2Btnpr6u6B3Ipm5HTc/s2ml4r2RLdHGiOael84GI/1huE9X0suIYING6
	 SA9jgSl8TETVfybt11Kv0L/EXhdZbRicrQHkUmwYF0DtkccHy06tXqsiJImcQW/z8jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793895688;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=WUVt2LLMVvHrNVw+qO0iuw2IcgYL/66FVrlB6ieRXfY=;
	b=YennwqdRKDIdvayZxrRzMFxUgbkUh7ymacDh1duV/oA62MKGfG8vv/sepkFodUYOwRcb
	 Sc/lJalVQl8mrERycVKSxe9jc7aMFAgNd/8BKgclHpJbXShTgUdTZ/tcp3XwSpy9C6ynK
	 EcRspbbOPtb3QRHMIbrQIVoTPNTuodTdG+n4VxxKiihL5a1KZgrSvzcO6//8dqhYCeSJU
	 Ha206dn3FFIy84FZqRxtIpGwedviifZDg3N2D9NXx1otJ1GVqLGBXE6HZGKxJkas5DLME
	 8d83tO1vC3S64pjfDQC0ytpLppBfrUAHSbWap8bVXdUR7jw79aNs/X6jKywiPWX33Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ty9eJlmk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBB2606A32D;
	Thu,  5 Nov 2026 16:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ty9eJlmk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1551F000C1;
	Thu,  5 Nov 2026 16:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793895687;
	bh=WUVt2LLMVvHrNVw+qO0iuw2IcgYL/66FVrlB6ieRXfY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Ty9eJlmkotAQ6H6RDI7/0eVAKDXXnes1pK0lQ3RumbfCwKMIJeqBvFe4HvKhAav0c
	 CqYmSfTJbt/uLP9MGVIT+OooHc1GpQ0bcKNjlI1afclFWUMByQEUS4zcJ4F3Jpqz5Z
	 39yvn3megrKcZ5j+odLqNetZDaaRldsiamjkz+tsrPL6wXBeYmyQEHtYtFNUamfHeC
	 EccCYUxsl7PQSGZMk9jaYMq+x+2yiRiWz8c7MiGrDxJrjbIi/v/ntFJQ6gi5NVg5lM
	 6MN8HQ1Pr96sOQh+zbD8BguuHCtip2OK+FlaSqb0rkNQU9CGEh2LBr4SB5OJWxDanK
	 YPBuOUkq3NdfQ==
Message-ID: <2209947d-0b9b-417f-9ffb-1c81790af9db@kernel.org>
Date: Thu, 5 Nov 2026 17:21:06 +0100
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
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Thierry Reding <thierry.reding@kernel.org>
Cc: Frank.Li@oss.nxp.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
 <auyiAE3lhnFahBK2@orome> <auysTnqWgz2kE7e9@ashevche-desk.local>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <auysTnqWgz2kE7e9@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/11/2026 17:18, Andy Shevchenko wrote:
> On Thu, Nov 05, 2026 at 04:36:38PM +0100, Thierry Reding wrote:
>> On Thu, Nov 05, 2026 at 04:17:53PM +0200, Andy Shevchenko wrote:
>>> On Thu, Nov 05, 2026 at 01:28:46PM +0100, Thierry Reding wrote:
>>>> On Mon, Nov 02, 2026 at 12:54:48PM -0500, Frank.Li@oss.nxp.com wrote:
>>>>>
>>>>> Replace open-coded assignments to callback and callback_param fields
>>>>> of struct dma_async_tx_descriptor with calls to the
>>>>> dmaengine_desc_set_callback() helper across serial drivers.
>>>>>
>>>>> No functional change intended. Prepare to make struct
>>>>> dma_async_tx_descriptor private to the DMA engine.
>>>>>
>>>>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
>>>>> ---
>>>>>  drivers/tty/serial/8250/8250_dma.c  | 6 ++----
>>>>>  drivers/tty/serial/8250/8250_mtk.c  | 3 +--
>>>>>  drivers/tty/serial/8250/8250_omap.c | 6 ++----
>>>>>  drivers/tty/serial/amba-pl011.c     | 6 ++----
>>>>>  drivers/tty/serial/atmel_serial.c   | 6 ++----
>>>>>  drivers/tty/serial/fsl_lpuart.c     | 6 ++----
>>>>>  drivers/tty/serial/imx.c            | 6 ++----
>>>>>  drivers/tty/serial/msm_serial.c     | 6 ++----
>>>>>  drivers/tty/serial/mxs-auart.c      | 6 ++----
>>>>>  drivers/tty/serial/pch_uart.c       | 6 ++----
>>>>>  drivers/tty/serial/samsung_tty.c    | 6 ++----
>>>>>  drivers/tty/serial/serial-tegra.c   | 6 ++----
>>>>>  drivers/tty/serial/sh-sci.c         | 9 +++------
>>>>>  drivers/tty/serial/sprd_serial.c    | 3 +--
>>>>>  drivers/tty/serial/stm32-usart.c    | 6 ++----
>>>>>  15 files changed, 29 insertions(+), 58 deletions(-)
>>>>
>>>> Reviewed-by: Thierry Reding <treding@nvidia.com>
>>>
>>> Krzysztof, now look at this case. I would argue that this is even less fit than
>>> # subpart(s) case, because it might imply anything. Again the problem is the
>>> bundle, and for such a case (when tons of independent changes are bundled in
>>> the same stuff, *every* Rb tag has to be explained on what has been reviewed!
>>
>> It may be a bit subtle, but the placement of the tag indicates that it
>> applies to the entirety of the changes. I didn't crop the list of
>> changed files, nor did I omit the summary.
> 
> This doesn't clarify the question. Wordless Rb tag on a bundles is an oddity.

No, it's perfectly normal and typical. I would not expect anything else,
because writing "LGTM" is pointless. We are experienced reviewers and we
do understand what Reviewer's statement of oversight means, thus giving
the tag is obvious, explicit and not odd.

> 
>> That bit of meta-data obviously isn't picked up into the tag line, but
>> I think the default meaning of Reviewed-by is that it applies to the
>> entire thing.
> 
> And I interpret it otherwise, because this is a set of independent changes
> bundled into a single patch!

It's not set of independent changes, but even if it was then it would
not matter. We review the code regardless how we actually judge the
atomicity of a patch.

Best regards,
Krzysztof
