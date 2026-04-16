Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B0437186F;
	Thu, 16 Apr 2026 21:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776374247; cv=none; b=eS4tMiVvSou6PcM59X/lQKyVm35X14cHRMYBDwNW3DnEitmtSuA4mT0IW8rknP+QTAMIKRZcr1MwX1A+N+nFG1eyfORj4PyhaI71fxcMmW3cvpgox7L4VymbecTq64Jl79Nw/7QBDm3ndnPwyQQUpWUrbLfdOtQNmq8xRG6bXfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776374247; c=relaxed/simple;
	bh=8+qp5AVliBOoLA+ApAN6ukgLp/FCzJny3hVHvc7k+N0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EVtaGuEbBMIgaJ2lwYHw42mTBlnpqugKmxyxdRIpR6yyZvdLdQm4ZRzmgT0/kcbRG51OEqVayHYz0+a02KSCJhSLGMkjVpdwZTfz3ETmfFYfmWy/FsVCR9YvS3RjAAcjcqOO3YESF+IiXkY5t3Z1K2s9xiu5cltZ2eCJLKd3O3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=chpSMJwr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="chpSMJwr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=XYKSSik4iHJGZXHi+q1kyedEjJZTQZpwWje/LXfezkA=; b=chpSMJwredwsoI3Yi8M5yfY51T
	B+5zIliu0vYvhoSSPeOhRLeQW46v2KveAKLVWDqcK4IoNQ84PS1MVs5GM2VEroYW0PTICev+qA5t5
	diBBayH0ttChXfk/gm16CvXBpc6PX7QTXgsc7gC/Y40lGfgGJGkbNVx5algepyMPdUU+iSJjHSMHW
	QNGd5UA/1gqx08V08ZAXPvo3lPAS1TpVZ0ZdwPid72nRz3AuBPWPTrNCaf/u29xDeyE28C0e2mGUB
	t76FXrSV7EYbTN1O4M1b/EQFa8lf4dFQg2pKG0lpM1MJepMTk6cdYWhiRG+K5K4zL/cnIRcVLwbzP
	kB+kWe9A==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDU5Q-000000033kd-45gm;
	Thu, 16 Apr 2026 21:17:21 +0000
Message-ID: <e7a15679-07f8-49e3-8818-3d4005c085d3@infradead.org>
Date: Thu, 16 Apr 2026 14:17:19 -0700
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/8] ARM: zte: Add zx297520v3 platform support
To: =?UTF-8?Q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Linus Walleij <linusw@kernel.org>, Drew Fustini <fustini@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 soc@lists.linux.dev, linux-serial@vger.kernel.org
References: <20260416-send-v4-0-e19d02b944ec@gmail.com>
 <20260416-send-v4-1-e19d02b944ec@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260416-send-v4-1-e19d02b944ec@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/16/26 1:19 PM, Stefan Dösinger wrote:
> diff --git a/arch/arm/mach-zte/Kconfig b/arch/arm/mach-zte/Kconfig
> new file mode 100644
> index 000000000000..24699256863b
> --- /dev/null
> +++ b/arch/arm/mach-zte/Kconfig
> @@ -0,0 +1,24 @@
> +# SPDX-License-Identifier: GPL-2.0
> +menuconfig ARCH_ZTE
> +	bool "ZTE zx family"
> +	depends on ARCH_MULTI_V7
> +	help
> +	  Support for ZTE zx-based family of processors.
> +
> +if ARCH_ZTE
> +
> +config SOC_ZX297520V3
> +	default y if ARCH_ZTE
> +	bool "ZX297520v3"
> +	select ARM_GIC_V3
> +	select ARM_AMBA
> +	select HAVE_ARM_ARCH_TIMER
> +	select PM_GENERIC_DOMAINS if PM
> +	help
> +	  Support for ZTE zx297520v3 SoC. It a single core SoC used in cheap LTE to WiFi routers.

	                                  It is

> +	  These devices can be Identified by the occurrence of the string "zx297520v3" in the boot

	                       identified

> +	  output and /proc/cpuinfo of their stock firmware.
> +
> +	  Please read Documentation/arch/arm/zte/zx297520v3.rst on how to boot the kernel.

-- 
~Randy

