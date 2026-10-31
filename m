Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793451642;
	b=e+q58x+0t3LBIqBfTWZLMxA05aMwDnjG6OKMMCcLCAHcSIHt0ybVrzyTohWNiw18Dh4j
	 3bXwXeezYC0hY1gyfXi01f42QpK9Dls2mW+KXpHGLdVeYzFOabd/0EDcqDCB0hGmD2fxy
	 gerJC5+b6A2iuelaok/xeDsfaN4U4CfPNwt/j+iT+dpbD3RWbAE+TSzhhMVGpu5AfpsFg
	 zSquyzXKKans9ihRR1s2AGfkn3dOqVATeMqtDSoFqzU7DVqS5+ihdJPFNx6OS771s9ro7
	 ZjnvujB71hViWOJKfx0+CnPsrD0KDuuftRDU4FIhi/iem6kCI5WxlRSk7q+Q2qzXACw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793451642;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=vWqfOIwVuRm8zQbmNHs1md0dinWn8EUsLETVtH4KCrg=;
	b=2arOxi36JRiFvTvEl5xB2oRJDjh3fmh49s/llkpxAtyBzuNRnlIn8iM6EQrsRqgy4Y5V
	 cb8/Gc2JnCftGlg1FJcc96cnXUuIpdvKSr6NDaKRV8hM97c671ACpk57LhCsnbDzZb0Pk
	 i5ExG5+CtOtEZpfLlnpdlMouFVbzSVCBqNsXxPvgPXNicZXFXPx81xnjUX0iI6xzPYUa/
	 7duDiUw7G/WSt7RslVHuDwmU2NKFlLQqQKl7OLyaxD7Wval3kuIV9yYUHJgO59nq9qhjD
	 Zf7pdWG+1kvXMnzh3IKBPaM9sPPDGy1lxOgMbtCTIhQLesG2l1OdAs4YOYEIKoZ8fXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ccbScL4x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EA5606A31A;
	Sat, 31 Oct 2026 13:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ccbScL4x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48BDF1F0093A;
	Sat, 31 Oct 2026 13:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793451642;
	bh=vWqfOIwVuRm8zQbmNHs1md0dinWn8EUsLETVtH4KCrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ccbScL4xejEP1z6GQUJYMc8L/9RLYP61ciymo2evxUrSloDYE0oWiMYWEtj3dxc3A
	 hbMxxVRj78EhceZMV4bWej/YpH6KELhSDtSMLFNHsx3FcazF6B5LMjxlLvzqc1Rj43
	 xp+uVPIOk3XctlopNi5Q4OQq4WkXzX1eYJ1eBxkk=
Date: Sat, 31 Oct 2026 14:00:14 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Samarth Narang <samarth.colleges@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Russell King <linux@armlinux.org.uk>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-serial@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] serial: keep the flushed TX buffer mapped until DMA
 has stopped
Message-ID: <2026103143-alienate-subduing-50f6@gregkh>
References: <20261031005425.3351240-1-samarth.colleges@gmail.com>
 <20261031123749.3783352-1-samarth.colleges@gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261031123749.3783352-1-samarth.colleges@gmail.com>

On Sat, Oct 31, 2026 at 12:37:47PM +0000, Samarth Narang wrote:
> This series addresses the DMA buffer lifetime issues in amba-pl011 and
> fsl_lpuart reported in the parent thread, where flush_buffer() unmaps
> the TX buffer before the terminated DMA transfer is guaranteed to have
> stopped accessing it. In fsl_lpuart, the buffer is unmapped even before
> termination is requested.
> 
> Since flush_buffer() runs under the port lock and cannot wait for DMA
> termination, both patches request termination while holding the lock and
> defer unmapping to a work item that first calls dmaengine_synchronize().
> The TX completion callback leaves the cleanup of flushed transfers to
> this work item, while shutdown, and suspend in the case of fsl_lpuart,
> waits for the work to finish before releasing the TX DMA state.
> 
> Both patches have only been compile-tested with arm64 defconfig, the
> relevant drivers enabled, and W=1, with no new warnings. I do not have
> access to PL011 or LPUART hardware with DMA support, so testing by
> someone with suitable hardware would be appreciated.
> 
> The imx driver also needs a fix for the issue reported in the same
> thread, but requires a different approach because its TX completion
> callback unmaps the scatterlist unconditionally. I will send that patch
> separately.

Again, these need to be tested on real hardware.  Not to mention the
bugs that sashiko just found in the changes as well.

thanks,

greg k-h
