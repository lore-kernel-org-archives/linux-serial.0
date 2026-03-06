Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D81936D504;
	Fri,  6 Mar 2026 06:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772777503; cv=none; b=e5IWDg/7SD1dicgCEeIVnsAxj3PwCeiIYkaoglKPcZkMvojUhCpP8833rQZoaJLZh4ZGeUhN7OPgBkUfQilW7s3+SeP7H06DwGGs7HfDg2f/7lGraITX4zMmVY8A+SDcKEtCg7P8nu+jaEPKMbOr0xt6TJUBwVaph4lBUK8PHU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772777503; c=relaxed/simple;
	bh=k9HSx9Hv5fPZ75EWWMQnHqMUrdVA+JtEnMTXcrHpe2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LFeu5HiGxozcsM0kkgcUafCs6HpCgCdWvpkmF33ebxZFU3ovaFxqGn3sdkYqiSFF189aoooOdsi+P5Lw0Yvo+l0u8PshMVueJU8hwLApX1wBtMMPCvFxck36dMM9Npm0iF1X/8CkG+TZjwiPW9l6QX7+zWEF8axVJRbGFvIhO3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nciUqy0m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nciUqy0m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3315EC4CEF7;
	Fri,  6 Mar 2026 06:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772777503;
	bh=k9HSx9Hv5fPZ75EWWMQnHqMUrdVA+JtEnMTXcrHpe2Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nciUqy0mJ6EQGvbvtpk7OU4dBt8QWO7f/VCqBl/TpjJ8PrwUfpGBAW1o9NhNyQCSW
	 7XPsZKy8vRfjNBAsKoycuUWl/HIa/JXl5RBWvaSXi+f58J+97/HnFo7wi8tlVmZZz0
	 AKDVDIig/ALBZSan3cYPfmJsINReskms169DNx3BpESfn0cGdfu5cfRzWyLfv5pyft
	 McJusIccdgDL2IVxUL+51YVE4Gia/RE1O5y+HcDTNSSbOxYNFOwNw0iDfHYFFRZ1SK
	 XiC2rcCk8jFDfgZVLLy63OtJ3NJZz+f0uapGYDne5GpvXmXb8CpVk9vRbm6yAt+FGw
	 oWN4XWlILux2Q==
Message-ID: <d73206a1-cabc-4de4-b85b-90c13cc1e0d0@kernel.org>
Date: Fri, 6 Mar 2026 07:11:39 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: 8250: null ptr deref in has_acpi_companion
To: Filip Jensen <dev-Felipe.Jensen@duagon.com>, gregkh@linuxfoundation.org,
 ilpo.jarvinen@linux.intel.com, mingo@kernel.org, tglx@kernel.org,
 osama.abdelkader@gmail.com, kees@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>
References: <20260305163358.42599-1-dev-Felipe.Jensen@duagon.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20260305163358.42599-1-dev-Felipe.Jensen@duagon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

1) the subject says:
[PATCH] serial: 8250: null ptr deref in has_acpi_companion

I read it as you are *adding* a null ptr dereference.

2) do not cut&paste literally the ./scripts/get_maintainer.pl output. I 
doubt Ingo and Thomas or others will help you with tty :P.

On 05. 03. 26, 17:33, Filip Jensen wrote:
> uart->port.dev is set in serial8250_register_8250_port if the port number
> is under the initial CONFIG_SERIAL_8250_RUNTIME_UARTS. If unset, it will
> depend upon up->port.dev being set by the particular serial driver. A
> faulty driver might not set this value and this leads to null pointer
> dereferenced later in has_acpi_companion and later at uart_add_one_port
> call:
> 
> Oops: general protection fault, probably for non-canonical address
> KASAN: null-ptr-deref in range
> RIP: 0010:serial8250_register_8250_port+0xd34/0x2030
> drivers/tty/serial/8250/8250_core.c
> 
> Reviewed-by: Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>
> Signed-off-by: Filip Jensen <dev-Felipe.Jensen@duagon.com>
> ---
> 
> For a case of a low level driver not setting this, cf.
> Link: https://lore.kernel.org/linux-serial/20260305162815.41818-1-dev-Felipe.Jensen@duagon.com/
> 
>   drivers/tty/serial/8250/8250_core.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index d2e2c5dfef99..8ac3f4efa7fd 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -756,6 +756,8 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
>   		if (ret)
>   			goto err;
>   	}
> +	if (!uart->port.dev)
> +		goto err;

So ret actually can be unitialized, right?

thanks,
-- 
js
suse labs
