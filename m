Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1923203710;
	Fri, 16 Jan 2026 13:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768569422; cv=none; b=WRk380kHs3YCEa/DbOoLmqwrukLYetJOGL97IczW1gPKG4XuQ7C8/mgK2QnAIHu6r7M0EQCLjyyqzu++PcTDdf8IgK+F3n/3Cpd8709E9NwNUA/0oE7FVdFO00r1JsFrjKOiHZJN2XZbEWtxTNTOcSAtVlKq0SeUGN+fTH2I0tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768569422; c=relaxed/simple;
	bh=VhcPAvQlEcLJklcEK5Dhimhl8GLTT6H6Ue8wNwJ89Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iydJZCxFiGESax0wxBewnXdLHRq25RQY1zowq07ZRL/LB7YS6MGDXBgXjciuf1+9h+jCAJbVFsOeNoYnJ9FSG9sXT9g5EY2mWwMrti8m3on9uMx8rH9Mo9EGuvX8kE6fFHlQEzB0AUaEPRuIO3RjuJ35KoPGQHmakgYiraiAXH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U8w/3XHe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U8w/3XHe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6158AC116C6;
	Fri, 16 Jan 2026 13:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768569421;
	bh=VhcPAvQlEcLJklcEK5Dhimhl8GLTT6H6Ue8wNwJ89Dg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U8w/3XHe56mPmx4CBHWGrPV41evWwHuRivC1U6fRymPYC4xmmQ6eZizVbE6WXHaHM
	 IIv8Xz9JukVIS9pGCFDiAshxTK1ZhNI6ncuKBMXeLshuDvXIcoK6diUlOvG48lCnld
	 bHvZ4sIVRIWZK/IHyTo3MROSXmTKW9feyNC1YZh4=
Date: Fri, 16 Jan 2026 14:16:59 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kendall Willis <k-willis@ti.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, d-gole@ti.com, vishalm@ti.com,
	sebin.francis@ti.com, msp@baylibre.com, khilman@baylibre.com,
	a-kaur@ti.com, s-kochidanadu@ti.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: omap: set out-of-band wakeup if wakeup
 pinctrl exists
Message-ID: <2026011620-clause-gecko-2cb0@gregkh>
References: <20251230-uart-wakeup-v1-1-13f1bb905f14@ti.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251230-uart-wakeup-v1-1-13f1bb905f14@ti.com>

On Tue, Dec 30, 2025 at 03:24:51PM -0600, Kendall Willis wrote:
> In TI K3 SoCs, I/O daisy chaining is used to allow wakeup from UART when
> the UART controller is off. Set UART device as wakeup capable using
> out-of-band wakeup if the 'wakeup' pinctrl state exists and the device may
> wakeup.
> 
> Signed-off-by: Kendall Willis <k-willis@ti.com>
> ---
> Implementation
> --------------
> This patch is intended to be implemented along with the following
> series. This patch has no dependencies on any of the other series:
> 
> 1. "pmdomain: ti_sci: handle wakeup constraint for out-of-band wakeup":
>    Skips setting constraints for wakeup sources that have out-of-band
>    wakeup capability.
>    https://github.com/kwillis01/linux/commits/v6.19/uart-daisy-chain/pmdomain
> 
> 2. "serial: 8250: omap: set out-of-band wakeup if wakeup pinctrl exists"
>    (this patch): Implements out-of-band wakeup from the UARTs for TI K3
>    SoCs
>    https://github.com/kwillis01/linux/tree/v6.19/uart-daisy-chain/uart-wakeup
> 
> 3. "arm64: dts: ti: k3-am62: Support Main UART wakeup": Implements the
>    functionality to wakeup the system from the Main UART
>    https://github.com/kwillis01/linux/tree/b4/uart-daisy-chain-dts

How am I to pull any of this into the mainline kernel tree?  If this is
dependant on those out-of-tree stuff, there's no need for me to take
this now, please submit this all together properly.

thanks,

greg k-h
