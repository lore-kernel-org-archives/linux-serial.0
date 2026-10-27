Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793104749;
	b=FDYJpMp0n28Te50CDwbp4qYkCalsi/4/gbuM8KP7MVZjBa22MLgUSwHhebyQspj7W9Hx
	 DfKWdyDfWnc41RAGPEzCBymATk4eu+PK8GpsVSWJdfkEPVsVgwAyaPlqohVOjcRS/WSfq
	 Ao6aK478LXsGt7cZJkVyT4PSzp7HxVATKsgTB1vnY1Oz3HcDpjuB82QObwkSr3iKbngrw
	 odUACr45qrkD2zJKXjHjSEo8oZN3DmhDnsgWnQrh2Vs3gvPjbr14q1G3dVyblfftzhY9k
	 vi+bKD8h1RFT8n5zgzbGWZYVqknHEOHZc/scsvXoOVKwAN+6Pc6cdpUF4bYAwHdCrQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793104749;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=ngxtvqn0Y40jR8X2TpDz9o335dYqPGRIX7XElXBwEvI=;
	b=iPWhPCJsLixXIDGoFaIX+a3+Esb/uUhhQwdTq4ghbP5QEFiMW1FTZGm05YI4y2d2BD4Z
	 n2HXvuBLtjeP8qxWIiZU2W3oSELTfmx996FoNA+9BzBrIVTyX65oVbUZ446WLiVxeWrco
	 pE9KxlDMonabp+2hvSL6dTDqzoVkKnS0PPfQ3b+Jx9icuSwaIlb7WZlih/8hAiyKbkdUQ
	 A0LJh/GT9icGJGCeVR2ysuIDyr9r/z7ZxAA1iR7Mnoyd+OveQ55c2xkKt5/dQ0lRCAAfk
	 kbAIM9kYJkS6p/GnDXY7EW8/ZhpthvYRjPYiOnAb3nXZSJpaqaSCTDCHNuWly+H64YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cOqjg8rG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9930160A260D;
	Tue, 27 Oct 2026 12:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cOqjg8rG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8053F1F01828;
	Tue, 27 Oct 2026 12:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793104749;
	bh=ngxtvqn0Y40jR8X2TpDz9o335dYqPGRIX7XElXBwEvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cOqjg8rGqauNznKiqNp8LFEcqDa1B9iBwLPPJP/qU46cLbAO8/1RbWZSWAHfzgG5h
	 2XZwIPEkUVdBLnRPAEWinCvLCJqdQP2Ro5U/zh689EPvIU7z1/zL4NdxNXPDwd00OR
	 SwhFE2/Uk2VLNIe1unUXd4SpbD79sKZZJ1c06b+xopCjGH20NDWdGPxQHFfjUHf+/A
	 Ho6rLBwOsrf3kDCev9O+R0BSapMCn5j1x9tNdV0EWxlZB8E54rCd2yMYeGdng4SAxr
	 QaNG7MQrrpoR1/N1yIZfBhvaMnTsZNVSr7uD5ByXMRZk0INzgr8Q+K7Jh/Wyqk0P9E
	 XME+QAyniY8TQ==
Date: Tue, 27 Oct 2026 13:38:52 +0100
From: Manivannan Sadhasivam <mani@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Joshua Rogers <linux@joshua.hu>, 
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	Tony Lindgren <tony@atomide.com>, Rafael Gago Castano <rgc@hms.se>, 
	Florian Fainelli <f.fainelli@gmail.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Peter Hurley <peter@hurleysoftware.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Crescent Hsieh <crescentcy.hsieh@moxa.com>, 
	Frank Li <Frank.Li@nxp.com>, Sherry Sun <sherry.sun@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Olof Johansson <olof@lixom.net>, 
	Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, Arnd Bergmann <arnd@arndb.de>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Robert Baldyga <r.baldyga@samsung.com>, 
	Thomas Abraham <thomas.abraham@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, 
	Patrice Chotard <patrice.chotard@foss.st.com>, Srinivas Kandagatla <srini@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Andy Shevchenko <andy.shevchenko@gmail.com>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, 
	Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	stable <stable@kernel.org>
Subject: Re: [PATCH 20/24] serial: rda: free the interrupt on shutdown
Message-ID: <v465454jl6slmidbjcj6uskbwebo5arnl7tyxbca6cnuisp5vu@3lyelzpnc7fl>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
 <20261027-tty-llm-v1-20-99b0202ae546@linuxfoundation.org>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261027-tty-llm-v1-20-99b0202ae546@linuxfoundation.org>

On Tue, Oct 27, 2026 at 12:06:46PM +0100, Greg Kroah-Hartman wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> rda_uart_startup() requests the interrupt, and nothing ever frees it.
> It is not shared, so once the port has been closed, the next startup
> fails with -EBUSY and the port cannot be opened any more.
> 
> Free it in rda_uart_shutdown().
> 
> Fixes: c10b13325ced ("tty: serial: Add RDA8810PL UART driver")
> Cc: stable <stable@kernel.org>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: "Andreas Färber" <afaerber@suse.de>
> Cc: Olof Johansson <olof@lixom.net>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
