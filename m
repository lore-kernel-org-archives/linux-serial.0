Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACDD23278D;
	Tue, 14 Jan 2025 07:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736839924; cv=none; b=FaWtjYvRVEkisX8G2xmnTNFSaAXTFNDMy4iQanUQHF8XUsMNKL7rPFlVWMQVFAHEXnVF7qckHbGvCAHeFmAHVdQK8WcdF3rq8r16RUe1/wTepFLszJDAFtbfUIwJMDqaUo8Xfsb6raDte4hsBmO8egD5gJQFJD4OApuA1klXL4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736839924; c=relaxed/simple;
	bh=6ZWmsJ98LtqBrmv5kenGU63vKf2MG1uFnfOYZD2zNO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R+jjwqQE1ug/aXdNbT4Nx7C62nFKxkNTomIlm8NcCa2vLqX9PfVQmvhiKAZGsTvKLW2ZWM4/4uSfH/cGQUQFZvt2GTOy9YQOvFP3AE9dKxkNj814/KKmVacxYFQ0DwYT8Dck2MEDiYkLZ/NE+E3DnwObsSrm5m+5B3nEt9W87sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpHZeMeX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpHZeMeX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 051B9C4CEDD;
	Tue, 14 Jan 2025 07:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736839924;
	bh=6ZWmsJ98LtqBrmv5kenGU63vKf2MG1uFnfOYZD2zNO0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RpHZeMeXxr4DhZpwEMuJceut6Au1JIrlqNV6kj/scPxpsTMPePNK1f7WPjziYfnUC
	 DhlgOTwqAapp9vQd4lPPa4E3KQKsDE5HtdJNu+CyaBw83L45brgV49YEYxf9PwAWh8
	 wW6TCZNpchdrbeRFFJq0qMyxBxR6Uma9fYy+aKPnTpgFSDvJlHIJVdJNSxk0Qlsz5g
	 rSHTi9sbaflsUAryRoNIbT49SRhEXKZrs9P3in3bQYp5y7TP0r99UmUlveZ0paTDD6
	 uWQB7vYSAz17YVldKigAP+H7tfCszV6gqDSd/vBP8WteByh8vGUqAy4SsHZPGb0Oet
	 DbDshwRciyExQ==
Message-ID: <79ad2e41-3d27-4dfd-9136-cb0867cb1a36@kernel.org>
Date: Tue, 14 Jan 2025 08:31:58 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: 8250_mtk: Add ACPI support
To: Yenchia Chen <yenchia.chen@mediatek.com>, gregkh@linuxfoundation.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com
Cc: yj.chiang@mediatek.com, tbergstrom@nvidia.com, yujiaoliang@vivo.com,
 u.kleine-koenig@baylibre.com, treapking@chromium.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20250114033324.3533292-1-yenchia.chen@mediatek.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20250114033324.3533292-1-yenchia.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14. 01. 25, 4:33, Yenchia Chen wrote:
> Add ACPI support to 8250_mtk driver. This makes it possible to
> use uart with edk2 UEFI firmware.

Could you mention what hardware this is in particular?

> Signed-off-by: Yenchia Chen <yenchia.chen@mediatek.com>
> ---
>   drivers/tty/serial/8250/8250_mtk.c | 31 ++++++++++++++++++++++++------
>   1 file changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
> index b44de2ed7413..a4f1c30f77b0 100644
> --- a/drivers/tty/serial/8250/8250_mtk.c
> +++ b/drivers/tty/serial/8250/8250_mtk.c
> @@ -19,6 +19,7 @@
>   #include <linux/dma-mapping.h>
>   #include <linux/tty.h>
>   #include <linux/tty_flip.h>
> +#include <linux/acpi.h>

Sort this properly.

>   #include "8250.h"
>   
> @@ -519,6 +520,7 @@ static int mtk8250_probe(struct platform_device *pdev)
>   	struct mtk8250_data *data;
>   	struct resource *regs;
>   	int irq, err;
> +	acpi_handle hdl = ACPI_HANDLE(&pdev->dev);

'hdl' sounds very weird and is not used in the tree for acpi_handles. 
I'd use 'acpi_handle' or 'acpi_dev_handle' in this case.

>   	irq = platform_get_irq(pdev, 0);
>   	if (irq < 0)
> @@ -545,8 +547,12 @@ static int mtk8250_probe(struct platform_device *pdev)
>   		err = mtk8250_probe_of(pdev, &uart.port, data);
>   		if (err)
>   			return err;
> -	} else
> -		return -ENODEV;
> +	} else {
> +		if (!hdl) {

so this should be:
   } else if () {

> +			dev_err(&pdev->dev, "no device\n");

Why this?

> +			return -ENODEV;

As this is self explanatory already, right?

> +		}
> +	}
>   
>   	spin_lock_init(&uart.port.lock);
>   	uart.port.mapbase = regs->start;
> @@ -560,16 +566,22 @@ static int mtk8250_probe(struct platform_device *pdev)
>   	uart.port.private_data = data;
>   	uart.port.shutdown = mtk8250_shutdown;
>   	uart.port.startup = mtk8250_startup;
> -	uart.port.set_termios = mtk8250_set_termios;
> -	uart.port.uartclk = clk_get_rate(data->uart_clk);
> +	if (hdl) {
> +		uart.port.uartclk = 26000000;

This is a magic constant. Define a macro for this. Hint: 26 * HZ_PER_MHZ.

Is it not/cannot it be part of the acpi table? What does MTKI0511 look like?

> +	} else {
> +		uart.port.set_termios = mtk8250_set_termios;
> +		uart.port.uartclk = clk_get_rate(data->uart_clk);
> +	}
>   #ifdef CONFIG_SERIAL_8250_DMA
>   	if (data->dma)
>   		uart.dma = data->dma;
>   #endif
>   
> -	/* Disable Rate Fix function */
> -	writel(0x0, uart.port.membase +
> +	if (!hdl) {
> +		/* Disable Rate Fix function */

Why is this only for non-ACPI devices?

> +		writel(0x0, uart.port.membase +
>   			(MTK_UART_RATE_FIX << uart.port.regshift));
> +	}
>   
>   	platform_set_drvdata(pdev, data);
>   
> @@ -647,11 +659,18 @@ static const struct of_device_id mtk8250_of_match[] = {
>   };
>   MODULE_DEVICE_TABLE(of, mtk8250_of_match);
>   
> +static const struct acpi_device_id mtk8250_acpi_match[] = {
> +	{ "MTKI0511", 0 },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(acpi, mtk8250_acpi_match);
> +
>   static struct platform_driver mtk8250_platform_driver = {
>   	.driver = {
>   		.name		= "mt6577-uart",
>   		.pm		= &mtk8250_pm_ops,
>   		.of_match_table	= mtk8250_of_match,
> +		.acpi_match_table = ACPI_PTR(mtk8250_acpi_match),
>   	},
>   	.probe			= mtk8250_probe,
>   	.remove			= mtk8250_remove,

thanks,
-- 
js
suse labs
