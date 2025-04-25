Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F49B242D77;
	Fri, 25 Apr 2025 11:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745581507; cv=none; b=Z8ND4Pb5B2lzpUldU1qv8jQzFpOujIULAhWyQQz2GkcEAr2L7/djhPIk7Osr7KyMigCsqs1DZB7eUFm35AIC0Ir9bFzhUSNjvNPzsCtTJkpQ7qS91DZORGL2BasNbzSH5lMuy+Ev7ftuCWXWKAKLO3ACPBcmgLzHUx7ccCCSYqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745581507; c=relaxed/simple;
	bh=/GNrQRcYdTquEmQsosrnAxEdwu90m8TRYhjlh8bYbhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BkzxtwhbRSfD1aJLwMnio8olfJcc8LIg7YnCfk2cdsbdNsG5sfKWYRhH63SRsr+QuEiLQLXbI9N9ilPjazUwZyaXQi0U/cTR49H9K78AQdG8zp2Gi5Tja3YD5qkJ/CKy0I6PS/eu8BnYLllHaSNzNCyQ/tJWeyOHvkBNLVY5ju0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sblzbFqx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sblzbFqx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E4EC4CEEB;
	Fri, 25 Apr 2025 11:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745581506;
	bh=/GNrQRcYdTquEmQsosrnAxEdwu90m8TRYhjlh8bYbhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sblzbFqxpOLKdo1CrWTSjLaak/NWDPnAQp81JSxEJyP0SVygEtjMHAtm8jEzSfktq
	 /J0kzIUdFrwU60gNsS9JUJW40m1L6nMyU/iz5Q41q1SSqsyZmErG0twk10yhcRKJyJ
	 ZUJKDJqfVUKdVObeDkiEYOMfaZMPyqpq3dsWWmxw=
Date: Fri, 25 Apr 2025 13:45:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Rengarajan S <rengarajan.s@microchip.com>
Cc: kumaravel.thiagarajan@microchip.com,
	tharunkumar.pasumarthi@microchip.com, jirislaby@kernel.org,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	unglinuxdriver@microchip.com
Subject: Re: [PATCH v2 tty-next] 8250: microchip: pci1xxxx: Add PCIe Hot
 reset disable support for Rev C0 and later devices
Message-ID: <2025042553-skinless-magazine-6cb9@gregkh>
References: <20250424035913.7673-1-rengarajan.s@microchip.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424035913.7673-1-rengarajan.s@microchip.com>

On Thu, Apr 24, 2025 at 09:29:13AM +0530, Rengarajan S wrote:
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
> v2
> Retained the original writel and simplified the hot reset condition
> v1
> Initial Commit.
> 
> Signed-off-by: Rengarajan S <rengarajan.s@microchip.com>
> ---
>  drivers/tty/serial/8250/8250_pci1xxxx.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_pci1xxxx.c b/drivers/tty/serial/8250/8250_pci1xxxx.c
> index e9c51d4e447d..61849312393b 100644
> --- a/drivers/tty/serial/8250/8250_pci1xxxx.c
> +++ b/drivers/tty/serial/8250/8250_pci1xxxx.c
> @@ -115,6 +115,7 @@
>  
>  #define UART_RESET_REG				0x94
>  #define UART_RESET_D3_RESET_DISABLE		BIT(16)
> +#define UART_RESET_HOT_RESET_DISABLE            BIT(17)

You forgot to use tabs here :(

