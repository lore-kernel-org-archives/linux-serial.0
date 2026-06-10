Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A1531282C;
	Wed, 10 Jun 2026 22:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781131776; cv=none; b=mW3gv1CeKQS6p1hEzDMpnHJce2YQTnECVq2te4LsrYyd1Qa8SHr31lJUeDgSM6k+8h676+LBE5wtCvQFgrmk2rl1LYjfB4ts5JyRKbRMEKLw+OclY8Ys2MlGHx8EfaoHOa8bHlm+WhNYlBzu2HcbRjTf2s0UVP40imkP/C4CnE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781131776; c=relaxed/simple;
	bh=XGZQwfm3Zw/+L+OsXTadXn5Irim5PMFROfL3UWOfN70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GgWeWsYnd5z3pGGO/wtMM+MUraMj8bP5uulWgFRXK+r1q1GFSi4DUagYeTKP4058HHRaUhNYkIfoYPjYm5oS8daLliUrKKDipTCZobDoPGmVLcEXHs2kIU1JJq3BjBUvh28vfvJJ9d+1HI3/rCyRFbctWp1f5wP9SIb+KBnL7kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=z0z2sCNY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="z0z2sCNY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=epk83XHTGPqCs40eb3YUi50QD9q370QPRDNXcn99T0k=; b=z0z2sCNY8au5G0VMfBG8AmWZYB
	MVF9wp40ED74oFu7+XAAhFM1uZckqdKg+45ABqBKHLH8tRPldJtSlPyTXRfL7UESbvt8c5ZNSQ5lk
	Q7chlG3IaiWzh/dBoq5eAYqTuqGqSKkFvDYvaAn9QPjATC5pzTZQpPhSqA0yj5FUGku4AgH2tA2Yb
	Boa2XeiCUAO4v/dqKtbYY807d2ulR8bwQSsJwnIyajdhCq04msbs5yammMZpPHBzYsJu9c8R9w4YA
	rthGDqbmrbVAzNeECz1l+8a+PoQiBhSi2mK6p2R2L6jyum9Idr7s7RypFbklRiahF6x29ZJlbbyVt
	fQ1tY58w==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXRjl-00000008QUp-3nom;
	Wed, 10 Jun 2026 22:49:29 +0000
Message-ID: <30ecb791-a9dd-4146-8d8c-b77f1fb31dde@infradead.org>
Date: Wed, 10 Jun 2026 15:49:29 -0700
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] tty: serial: Add UART driver for Cortina-Access
 platform
To: Jason Li <jason.lee651024@gmail.com>, jason.li@cortina-access.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-serial@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260610112821.3030099-1-jason.li@cortina-access.com>
 <20260610112821.3030099-4-jason.li@cortina-access.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260610112821.3030099-4-jason.li@cortina-access.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/10/26 4:28 AM, Jason Li wrote:
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index cf7dba473b20..99a1c9308395 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1592,6 +1592,27 @@ config SERIAL_NUVOTON_MA35D1_CONSOLE
>  	  but you can alter that using a kernel command line option such as
>  	  "console=ttyNVTx".
>  
> +config SERIAL_CORTINA_ACCESS
> +	tristate "Cortina-Access serial port support"
> +	depends on OF
> +	select SERIAL_CORE
> +	help
> +	  This driver is for the Cortina-Access SoC UART, present in the
> +	  CA8289 (Venus) and related CAXXXX family of SoCs. If you have a
> +	  machine based on the Cortina-Access SoC and wish to use the serial
> +	  port, say 'Y' here. Otherwise, say 'N'.

It could also be 'm' since the kconfig symbol is tristate.

> +
> +config SERIAL_CORTINA_ACCESS_CONSOLE
> +	bool "Console on Cortina-Access serial port"
> +	depends on SERIAL_CORTINA_ACCESS=y
> +	select SERIAL_CORE_CONSOLE
> +	select SERIAL_EARLYCON
> +	help
> +	  Say 'Y' here if you wish to use the Cortina-Access UART as the system
> +	  console (the device which receives all kernel messages and warnings
> +	  and which allows logins in single user mode).
> +	  /dev/ttyS* is the default device node.
> +
>  endmenu

-- 
~Randy

