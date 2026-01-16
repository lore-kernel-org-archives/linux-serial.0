Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F14D33B94B;
	Fri, 16 Jan 2026 15:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768578428; cv=none; b=tWyNBdH9PuhCJf1b9dxmdnpXLNHRZCLqJ+HrAvChNLKXXt8A2N+YyQZXHUEiDdz+RRagq0+A2aq/gPfULLOD/HyafjTMtiKypMtMGw5D2mQh5+u6Bd0BCMu8FIBJsT4DBylBjBHWX5rttSBcnwpFmhreAuY4IoEZZ9b8DjAsJ5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768578428; c=relaxed/simple;
	bh=osUooFBPq4h0/sgNdRb67sExM3ACKQeH2uj0XU2OCZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndPhEinHna8eWHH5I5hy65/WTk1qt7AHrKuLSArf9gc5eyN+zV1EW1kYh0SIrNIyj4L7vZ/jxbiNfWBu/beERJjqiqvPhE9sY4RTal+K29e6SIvogUWB/DHP/yl4e67HZLWuf19I8Hlp1Ha6oRuASYUGTLfuxd+2ncEI4r1mT/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WFn2P4bz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WFn2P4bz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57825C19425;
	Fri, 16 Jan 2026 15:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768578427;
	bh=osUooFBPq4h0/sgNdRb67sExM3ACKQeH2uj0XU2OCZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WFn2P4bzpp2pjpgLFEcpU9lFHOl8Kjjgmy0VBdiQp1DaBcBZI82uxgSQP3gJLLBfj
	 W/gCMVk8DtimfNxq8s9DWESlx/iu61FiQsVgpAtQMERRg85nLLbRswKGZCIFFJTxeY
	 JUMYACa3cmoGfzedN6ag0L621EfSIfcS1IN7AmH8=
Date: Fri, 16 Jan 2026 16:47:05 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kendall Willis <k-willis@ti.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, d-gole@ti.com, vishalm@ti.com,
	sebin.francis@ti.com, msp@baylibre.com, khilman@baylibre.com,
	a-kaur@ti.com, s-kochidanadu@ti.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: omap: set out-of-band wakeup if wakeup
 pinctrl exists
Message-ID: <2026011648-eject-sanitizer-7e6d@gregkh>
References: <20251230-uart-wakeup-v1-1-13f1bb905f14@ti.com>
 <2026011620-clause-gecko-2cb0@gregkh>
 <f7a2e47b-a37e-4735-91ea-4fcac3217186@ti.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7a2e47b-a37e-4735-91ea-4fcac3217186@ti.com>

On Fri, Jan 16, 2026 at 09:37:44AM -0600, Kendall Willis wrote:
> On 1/16/26 07:16, Greg Kroah-Hartman wrote:
> > On Tue, Dec 30, 2025 at 03:24:51PM -0600, Kendall Willis wrote:
> > > In TI K3 SoCs, I/O daisy chaining is used to allow wakeup from UART when
> > > the UART controller is off. Set UART device as wakeup capable using
> > > out-of-band wakeup if the 'wakeup' pinctrl state exists and the device may
> > > wakeup.
> > > 
> > > Signed-off-by: Kendall Willis <k-willis@ti.com>
> > > ---
> > > Implementation
> > > --------------
> > > This patch is intended to be implemented along with the following
> > > series. This patch has no dependencies on any of the other series:
> > > 
> > > 1. "pmdomain: ti_sci: handle wakeup constraint for out-of-band wakeup":
> > >     Skips setting constraints for wakeup sources that have out-of-band
> > >     wakeup capability.
> > >     https://github.com/kwillis01/linux/commits/v6.19/uart-daisy-chain/pmdomain
> > > 
> > > 2. "serial: 8250: omap: set out-of-band wakeup if wakeup pinctrl exists"
> > >     (this patch): Implements out-of-band wakeup from the UARTs for TI K3
> > >     SoCs
> > >     https://github.com/kwillis01/linux/tree/v6.19/uart-daisy-chain/uart-wakeup
> > > 
> > > 3. "arm64: dts: ti: k3-am62: Support Main UART wakeup": Implements the
> > >     functionality to wakeup the system from the Main UART
> > >     https://github.com/kwillis01/linux/tree/b4/uart-daisy-chain-dts
> > 
> > How am I to pull any of this into the mainline kernel tree?  If this is
> > dependant on those out-of-tree stuff, there's no need for me to take
> > this now, please submit this all together properly.
> 
> This patch has no dependencies on the listed series. I listed them so that
> there was a full picture of the feature implementation. The "pmdomain:
> ti_sci: handle wakeup constraint for out-of-band wakeup" patch has been
> merged already [1]. The "arm64: dts: ti: k3-am62: Support Main UART wakeup"
> series is posted [2] and has a dependency on this patch. Sorry for the
> confusion with the GitHub links, in the future I either won't add them or
> will add lore links instead.
> 
> [1] https://lore.kernel.org/all/20251230-pmdomain-v1-1-3a009d1ff72e@ti.com/
> [2] https://lore.kernel.org/all/20260106-b4-uart-daisy-chain-dts-v3-0-398a66258f2c@ti.com/
> 
> Best,
> Kendall Willis <k-willis@ti.com>

Great, can you resend this then without that information to confuse me?
:)

thanks,

greg k-h
