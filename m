Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CB739021A;
	Mon, 27 Apr 2026 06:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777272813; cv=none; b=ktI2QwDKWs7T1qqWu4EjCzIVpXFrnvaUMIkA7T3yfhCzdtMp4qVQJXEQaVn6N1LcOrNJk5lqakr6igvri/96+2JHlgaeYK6ma3xuLL+deh/h4tnpPiVZBZZW2VH/LiScEtXHgbyQRVhOzjuEfOWur0QMQ4RfFvEWS9Ji7AfiA5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777272813; c=relaxed/simple;
	bh=890ee2WIAhjqI3oDPRvaOKgFzFUsMQwVAfSk0a+FCeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DRmCsDJHjATt809tevTIwaYqqMadjyCEDtP+LZCx8gOuPo0LEMcA7HA3T4sH4BfpCa8drKFSrJ89Gd8z6SUqJEYS/kmGrvJxIyeEz9goFvlVmLMVwuLF+kmOMB+lxjvCtCDTEVd9ujxh4NBpGVEetNgoOsvrRzR2Ocmb0jKFLxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSDvVByU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSDvVByU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C16C19425;
	Mon, 27 Apr 2026 06:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777272812;
	bh=890ee2WIAhjqI3oDPRvaOKgFzFUsMQwVAfSk0a+FCeo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TSDvVByUmBtWQJpIPY32dgpRtW5XlQveXSPXq0PKU59u2zyBASZfQ8kbuUfA99met
	 XPVou/62YnE1y8bb3yguoGGUxykrUFsXBwgEjEQnJiwI3iG1NPT+JzQEw0FQ72Ek66
	 PIyP8uYkplDbtY4NlBr/pPZdLHewuI/wTdE+l3WM8naJoRtfRMrxgHxpOxjyCncUGX
	 sPPzrGBpIavCk6/bnrAxZ7KnTIjZOH2Vb5agkOzia00N+d6un3lFnXPqlxRVlUR3T2
	 /buSSa09RVO0D5okIQxkKHIZQjfmT4IM2nzM/uVV/g+sqv5fO+kLnDnRc2FWToA3Xf
	 Fkmd72n/xXj6w==
Date: Mon, 27 Apr 2026 08:53:29 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Stefan =?utf-8?B?RMO2c2luZ2Vy?= <stefandoesinger@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Russell King <linux@armlinux.org.uk>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Linus Walleij <linusw@kernel.org>, 
	Drew Fustini <fustini@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, soc@lists.linux.dev, 
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v6 2/6] ARM: zte: Add zx297520v3 platform support
Message-ID: <20260427-married-overjoyed-panther-c773c1@quoll>
References: <20260426-send-v6-0-d49efa72bb09@gmail.com>
 <20260426-send-v6-2-d49efa72bb09@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260426-send-v6-2-d49efa72bb09@gmail.com>

On Sun, Apr 26, 2026 at 02:54:15PM +0300, Stefan D=C3=B6singer wrote:
> diff --git a/arch/arm/mach-zte/Kconfig b/arch/arm/mach-zte/Kconfig
> new file mode 100644
> index 000000000000..2e3abee94994
> --- /dev/null
> +++ b/arch/arm/mach-zte/Kconfig
> @@ -0,0 +1,26 @@
> +# SPDX-License-Identifier: GPL-2.0-only
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
> +	bool "zx297520v3"

"bool" should be the first line in the entry.

Also say something a bit more useful, e.g. "zx297520v3 SoC" becuase
unfortunately the model number looks too close to random set of
characters.

Rest seems fine:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

