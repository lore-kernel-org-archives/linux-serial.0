Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C09379C3C;
	Sun, 31 May 2026 07:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780213973; cv=none; b=AVkd8hjqXokAVuTKYkX5nBnSD5YaN2klCgNKiAfUZ2HKM+pOVkjk7FX8C3y9rg/+xB8WB0+3a+LlStNEmTu1ySEU+gI6luOlpUEUAcEQMAc0yDhgUciOEnWlymzjjTnluxcBQBuH81AJ0lF5dI7dxZshtPSEDVQ9l4csPuzU3Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780213973; c=relaxed/simple;
	bh=ptyCHszpg/QOyVlzPMNK09b7ZoINYfhUEmfopAIc8ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kp3vMfz7B1w5vF8ZP5/gD1SpaCB4d6IZOvgAByyfh1v05sUpq6cRnmcr5vNspV0q9f9z3nLGf5x8PnZa70ettuOTj7QuQpqC1J0xsHM4r+qPOQ18lZ6swrJa4nyNrNCBWBW3wIW8fS5/+CtcvNLib4zE5sTrg78LCwoP5Dcb+Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kGPHrxtS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kGPHrxtS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853FB1F00893;
	Sun, 31 May 2026 07:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780213972;
	bh=lVME6BMLZrouDuwpKNXy6uU2e3Q/0FIm0B1uSihMQ94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kGPHrxtSgLsNxGZ7FHVnrPNQTEYvVXZwKKIT2DOpCf0AmPTi94rgHbW1Dt94ix43I
	 mSFIXcmXGSbNdnmc3HD1/+7zK4ONnG5dFXbQ7Flz29WsH2t+EaRPmvYzmAvTEMy40O
	 PYeDqdC+9AGewVd36lBOX/NvddNEgV6D2ufrg2RU=
Date: Sun, 31 May 2026 09:51:56 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:TTY LAYER AND SERIAL DRIVERS" <linux-kernel@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCHv2] serial: mxs-auart: fix probe error paths and clock
 handling
Message-ID: <2026053127-nastily-fool-88eb@gregkh>
References: <20260530195525.5059-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260530195525.5059-1-rosenp@gmail.com>

On Sat, May 30, 2026 at 12:55:03PM -0700, Rosen Penev wrote:
> Sashiko reported three pre-existing bugs in the mxs-auart driver:
> 
> - For non-ASM9260 variants, mxs_get_clks() obtained the clock but never
>   prepared/enabled it, leaving register accesses in probe at risk of
>   faulting if the bootloader had gated the clock.
> - The error path and remove function used pdev->id instead of
>   s->port.line to clear the auart_port[] slot.  For DT-probed devices
>   pdev->id is -1, causing an out-of-bounds write and leaving a dangling
>   pointer in the array.
> - The probe error path called iounmap() while the IRQ was still
>   registered. An interrupt during that window would dereference the
>   unmapped membase.

This should still be broken up into smaller pieces, don't you think?

Whenever you have to list the different things you do in a patch, that's
a huge hint to do so.

thanks,

greg k-h
