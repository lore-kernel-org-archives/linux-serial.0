Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66910186A;
	Wed, 23 Apr 2025 05:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745385071; cv=none; b=RtJeDu6kBfX2l5AGA2MZURmfdDDKnjVIwb6nQOUKYQx7cPRDA1MNfrBc3kPraTguOhZwFjMuI8xV7e1P5KU/e0bempapLXg6um7L547kLCW0557D7+bUZBzo3T0z/x4NrwRinP/XBGcb/Ugz096FTJwiRZi+cXrCxAMDnwRSUiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745385071; c=relaxed/simple;
	bh=7keckhtABWhiyOtwpWQepxmD1/wWw9n3KVzmE5Vw61o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EqxhQlnLkQpGATmHs8cMtZQJ2B1YpZPEsnmvQmc8gYmdtw2KfQqqsAKHa9xvpxqcxBsnP2WVjt6dsSk1sJ74W1sWCzHoF5PWLjqA0j+ETrNx09TAm6ePOuADViaQr196B7PY0y9XwbHjU9BDFQbl8YXkITF1BPZNA8Q937eIiyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmoDNxAz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmoDNxAz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63ACDC4CEE2;
	Wed, 23 Apr 2025 05:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745385070;
	bh=7keckhtABWhiyOtwpWQepxmD1/wWw9n3KVzmE5Vw61o=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=ZmoDNxAzipeScZRwQ7T9skXTKQ82nLgKZU4wXvwdi6yicNTneoDKwqCu0gXVksvx3
	 VHGp/VaOp5DFR7TpUXoLA2WxWQzs+1KNnPpcaXspC01leRceHhGnwCDiGX/Y9YcywF
	 TtUc2dwUtLP4EBY0V2oWrFK+xoP5mNUp/TzsnVIi1xa2GRYtfN53HPS9/2FgI2FLEU
	 0i0HKN9rZv2+C7OqPPggRWeWy0DiZa7NA8zUrXqRx8Wx4YkgIlRJ7/LpPXMSJek1dK
	 5xNmZCjiWJcBs++Rjfm7IKD7iuyzhvfQ/GC9b81ri+PQwMBHNILBgNYiQUdMR2piNq
	 BwTB27au4bjpg==
Message-ID: <3292610b-acb0-4b72-8aa8-9eec491238c5@kernel.org>
Date: Wed, 23 Apr 2025 07:11:07 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 tty-next] 8250: microchip: pci1xxxx: Add PCIe Hot reset
 disable support for Rev C0 and later devices
To: Rengarajan S <rengarajan.s@microchip.com>,
 kumaravel.thiagarajan@microchip.com, tharunkumar.pasumarthi@microchip.com,
 gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org, unglinuxdriver@microchip.com
References: <20250423033841.33758-1-rengarajan.s@microchip.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20250423033841.33758-1-rengarajan.s@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23. 04. 25, 5:38, Rengarajan S wrote:
> Systems that issue PCIe hot reset requests during a suspend/resume
> cycle cause PCI1XXXX device revisions prior to C0 to get its UART
> configuration registers reset to hardware default values. This results
> in device inaccessibility and data transfer failures. Starting with
> Revision C0, support was added in the device hardware (via the Hot
> Reset Disable Bit) to allow resetting only the PCIe interface and its
> associated logic, but preserving the UART configuration during a hot
> reset. This patch enables the hot reset disable feature during suspend/
> resume for C0 and later revisions of the device.
> 
> Signed-off-by: Rengarajan S <rengarajan.s@microchip.com>
> ---
>   drivers/tty/serial/8250/8250_pci1xxxx.c | 18 ++++++++++++++++--
>   1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_pci1xxxx.c b/drivers/tty/serial/8250/8250_pci1xxxx.c
> index e9c51d4e447d..ec573327590f 100644
> --- a/drivers/tty/serial/8250/8250_pci1xxxx.c
> +++ b/drivers/tty/serial/8250/8250_pci1xxxx.c
> @@ -115,6 +115,7 @@
>   
>   #define UART_RESET_REG				0x94
>   #define UART_RESET_D3_RESET_DISABLE		BIT(16)
> +#define UART_RESET_HOT_RESET_DISABLE            BIT(17)
>   
>   #define UART_BURST_STATUS_REG			0x9C
>   #define UART_TX_BURST_FIFO			0xA0
> @@ -620,7 +621,13 @@ static int pci1xxxx_suspend(struct device *dev)
>   	}
>   
>   	data = readl(p + UART_RESET_REG);
> -	writel(data | UART_RESET_D3_RESET_DISABLE, p + UART_RESET_REG);
> +
> +	if (priv->dev_rev >= 0xC0)
> +		writel(data | (UART_RESET_D3_RESET_DISABLE |
> +		       UART_RESET_HOT_RESET_DISABLE), p + UART_RESET_REG);
> +	else
> +		writel(data | UART_RESET_D3_RESET_DISABLE,
> +		       p + UART_RESET_REG);

Instead of this overly long lines, could you just:
   data |= UART_RESET_HOT_RESET_DISABLE;
and keep the writel() as is?

thanks,
-- 
js
suse labs
