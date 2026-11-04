Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793814090;
	b=s3KJ/HLX/ZhJwaI/B5Ifalpd+M/JuKhzhWJbO7gJoCJPGx4LhiczACqzFdWkkpeeZL5J
	 oKdpxSi9eqXOjF8HET/4pMX60n82sVsKEr/ZhLVP4RCoWkux6RofCeO3EqFnd8UsrDlUi
	 T5ehZIlltmbfTASqVZ52Ckp9PGY+CvaXArLdCzA+Z7UkSV27b8Z/CnPrbaXanQ5Hgtlf4
	 Df6ZF12nr7DRSeYd20vmU8xg/X6IlqKffxS2FBmiNCUML7XN7vOsAaQfL0LtPhsPESmYO
	 W4utj0CrKJl5WdhoM5ufNNIbw9lCxMLR8WaNg0NQ91eqC4ltdAxd3o4SUMfW6bmcdOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793814090;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=vAcmQL9E5wHFBIFgN/rx51LVAyFInnPlCaXD1KnpG7M=;
	b=sHvZJZ1EpTGm5JkxVw+YKwYAjWI4LkGLaaroLMG7b5cv5204c21KqdNCumbaaVficxS3
	 /lCrbWZ/DLg7dWl9he0kYJQV5CDeqUFU1ukb6Dq6zoydqd3n4KYMjVQ825Fj14aqlNYM0
	 hCF7P4LhZ/bZiTBykDFztwysyuwLdnXsbRNX9AYygkz//PuV6xLlYERIRA+/rZWjW2g2Z
	 z5RxZC6ny3uj5+jhRjC1/T11dpRxvD2wUA/0BTUIOJ38ZMYolHR/QzZMi16WzEr4A2qn+
	 4sX97JnKb2Y8fJ0CPkCMpo3UTiCDrAmrbUuIgkZqMFO71gsZlmsenJ0HljcB786lkAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ajz4ZozR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91993606A32E;
	Wed,  4 Nov 2026 17:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ajz4ZozR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14CE1F000C1;
	Wed,  4 Nov 2026 17:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793814090;
	bh=vAcmQL9E5wHFBIFgN/rx51LVAyFInnPlCaXD1KnpG7M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Ajz4ZozRnrFd2AX4APN0O8qxmiVZEXiSBBBCjR9fGe9GI8Y4kblS2iVKdDhsWyYXH
	 1dVMopXagUrbyxQK2RtyhpUlod2bfepH3YC9/4P1/E9Ai9iLZgqBbN7YSYTIFnzl4O
	 Y4hqXzWvMlQ/HtjH2T8Q4a2WZaGkOKGE/Bpg8UrpLOULGYYvXciKTnnlmMPbFVsZNw
	 Q80Ele6GM6AJl4I9SsLlIfT/Ndlynth4ZHN8wn+caMxWS8lB0YeedN08w/YodZFUFC
	 IHuGLtnJf2T7MrjhPmIABtU7Gx9m2UNJ6y9Ogsoc11d/hsR7HvY588sinHOhCJd9FJ
	 diAj7uXzbZalA==
Message-ID: <a2d5ea00-bfa1-4883-923d-0a6a7eaa556d@kernel.org>
Date: Wed, 4 Nov 2026 18:41:08 +0100
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
To: Frank.Li@oss.nxp.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, Orson Zhai <orsonzhai@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Cunhao Lu <1579567540@qq.com>, Raul E Rangel <rrangel@chromium.org>,
 Yenchia Chen <yenchia.chen@mediatek.com>,
 Zhiyong Tao <zhiyong.tao@mediatek.com>, Carlo Caione <ccaione@baylibre.com>,
 Moteen Shah <m-shah@ti.com>, Kendall Willis <k-willis@ti.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
 <linux-stm32@st-md-mailman.stormreply.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: vkoul@kernel.org
References: <20261102175527.3957740-1-Frank.Li@oss.nxp.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20261102175527.3957740-1-Frank.Li@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/11/2026 18:54, Frank.Li@oss.nxp.com wrote:
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

...
I did not look at this code at all...

> index 640f85e2d636b..3f82a83998e1c 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -447,8 +447,7 @@ static int s3c24xx_serial_start_tx_dma(struct s3c24xx_uart_port *ourport,
>  		return -EIO;
>  	}
>  
> -	dma->tx_desc->callback = s3c24xx_serial_tx_dma_complete;
> -	dma->tx_desc->callback_param = ourport;
> +	dmaengine_desc_set_callback(dma->tx_desc, s3c24xx_serial_tx_dma_complete, NULL, ourport);
>  	dma->tx_bytes_requested = dma->tx_size;
>  
>  	ourport->tx_in_progress = S3C24XX_TX_DMA;
> @@ -642,8 +641,7 @@ static void s3c64xx_start_rx_dma(struct s3c24xx_uart_port *ourport)
>  		return;
>  	}
>  
> -	dma->rx_desc->callback = s3c24xx_serial_rx_dma_complete;
> -	dma->rx_desc->callback_param = ourport;
> +	dmaengine_desc_set_callback(dma->rx_desc, s3c24xx_serial_rx_dma_complete, NULL, ourport);
>  	dma->rx_bytes_requested = dma->rx_size;
>  


... but apparently reviewing only a few lines out of 400 is still reviewing:

https://lore.kernel.org/all/9e39502a-dd17-4fa2-98a3-9019523cb5e8@kernel.org/

Therefore:

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>


Best regards,
Krzysztof
