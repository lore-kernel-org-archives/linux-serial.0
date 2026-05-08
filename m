Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFE21397
	for <linux-serial@vger.kernel.org>; Fri,  8 May 2026 00:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778199297; cv=none; b=YK5sl08DdsX1WG8n2UiqtURmFxSQA4P9slnzV68VOGMKfQ4r0g+1VzBevkuiVueHSaKn3Qujuf+tkxqhqjZ+xD1pbe72leNdPD3BhaNMB00IzFo0Vk6d9IdD6qrgUjCjkqkRCza/0qT2AJ4Ns6IzJ8eExeLA88lUDXmYCV54gTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778199297; c=relaxed/simple;
	bh=4Dymq0aHXKstQfNw3MMgrRZ40676wieOk4z72GZ551Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nDYQpQcFY7XomkDbNVkhfWcnJ1LcZVIM7ShVq9Qn32QkhX0+DpDu6ymMIXnZODJGt6GkAxaOtSv7QOPxfT8g7m7jM4u6kT+4JDUNeTzWBPx6g7j7XfWzulmhN9lW6+M8pCqlriINDlzhsg+OotyHOznPUuaN6xJKt3wRsPKlKFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BRle0ws4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BRle0ws4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=m9JpZUwZ5ByUKtcAnZrL3/UwLFRZOXKeDj3ktlYy7sk=; b=BRle0ws4rVKhwgEpIRCMaEab0s
	9adOL8a6xtbGXp+/iD4wqLI9I/sDHlwyxUfdoncSXQ6Kr3KPTBhi6Hk/lDfFLFtx+JZSf5/Qvd4gH
	QIJHBzK6vS36VV3sTCqu9xl+8vIZ8neyGmYnul9CzssXcG/gUxe5ku0YdnF3DxVwJ/FneST8a/LGF
	oIF/fy4Gk4Aj4EhK/JlNHa8Kx52kHeu1bwQCz9P7VTBxOx13ThguR/aTJ/C1SEaub0UQ72gMnUtFp
	5rXtOOF1K790IsnAupSr8U4AzUvTJd0F3FeetVEgXzFTQ39JgrzSaXYSkgZofU0HeaUK54MO5VaEv
	5AlmdlyQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wL8rd-00000005CiA-21t3;
	Fri, 08 May 2026 00:14:45 +0000
Message-ID: <7aeadaf3-3b0a-4a19-904e-26d5aaf9b76e@infradead.org>
Date: Thu, 7 May 2026 17:14:44 -0700
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] tty: remove unnecessary SERIAL_NONSTANDARD config
 option
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>, linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <cover.1777943090.git.enelsonmoore@gmail.com>
 <2cefa6ee9b6bf13d367e15dd74093a0ef9ad81db.1777943090.git.enelsonmoore@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <2cefa6ee9b6bf13d367e15dd74093a0ef9ad81db.1777943090.git.enelsonmoore@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/4/26 6:20 PM, Ethan Nelson-Moore wrote:
> The SERIAL_NONSTANDARD config option currently only guards the
> selection of two Moxa multiport serial card drivers and the HDLC line
> discipline, so it does not significantly simplify configuration. Make
> the configuration process more straightforward by dropping this option
> and dependencies on it.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> ---
>  arch/arm/configs/footbridge_defconfig       |  1 -
>  arch/arm/configs/lpc18xx_defconfig          |  1 -
>  arch/arm/configs/mps2_defconfig             |  1 -
>  arch/arm/configs/neponset_defconfig         |  1 -
>  arch/arm/configs/stm32_defconfig            |  1 -
>  arch/csky/configs/defconfig                 |  1 -
>  arch/loongarch/configs/loongson32_defconfig |  1 -
>  arch/loongarch/configs/loongson64_defconfig |  1 -
>  arch/mips/configs/bigsur_defconfig          |  1 -
>  arch/mips/configs/lemote2f_defconfig        |  1 -
>  arch/mips/configs/loongson2k_defconfig      |  1 -
>  arch/mips/configs/loongson3_defconfig       |  1 -
>  arch/powerpc/configs/cell_defconfig         |  1 -
>  arch/powerpc/configs/microwatt_defconfig    |  1 -
>  arch/powerpc/configs/ppc6xx_defconfig       |  1 -
>  arch/sh/configs/polaris_defconfig           |  1 -
>  arch/x86/configs/i386_defconfig             |  1 -
>  arch/x86/configs/x86_64_defconfig           |  1 -
>  drivers/tty/Kconfig                         | 18 ------------------
>  drivers/tty/serial/Kconfig                  |  4 ++--
>  tools/testing/selftests/bpf/config.x86_64   |  1 -
>  tools/testing/selftests/hid/config.common   |  1 -
>  22 files changed, 2 insertions(+), 40 deletions(-)
> 


> diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
> index 63b378e44a59..a9ade8bc88b2 100644
> --- a/drivers/tty/Kconfig
> +++ b/drivers/tty/Kconfig
> @@ -191,26 +191,8 @@ config LDISC_AUTOLOAD
>  
>  source "drivers/tty/serial/Kconfig"
>  
> -config SERIAL_NONSTANDARD
> -	bool "Non-standard serial port support"
> -	depends on HAS_IOMEM
> -	help
> -	  Say Y here if you have any non-standard serial boards -- boards
> -	  which aren't supported using the standard "dumb" serial driver.
> -	  This includes intelligent serial boards such as
> -	  Digiboards, etc. These are usually used for systems that need many
> -	  serial ports because they serve many terminals or dial-in
> -	  connections.
> -
> -	  Note that the answer to this question won't directly affect the
> -	  kernel: saying N will just cause the configurator to skip all
> -	  the questions about non-standard serial boards.
> -
> -	  Most people can say N here.
> -
>  config N_HDLC
>  	tristate "HDLC line discipline support"
> -	depends on SERIAL_NONSTANDARD

Here, N_HDLC used to depend on HAS_IOMEM (due to SERIAL_NONSTANDARD).
It no longer depends on HAS_IOMEM so it can be built for ARCH=um with
no build errors.

Just FYI/FWIW. Maybe add that to the commit message.

-- 
~Randy

