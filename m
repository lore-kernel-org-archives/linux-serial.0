Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793436944;
	b=mKoItaE76dUyKN22/6JZcTC2xO+MNvCk3H0/d65T2eBqHR+76eyQuqUID+odDyhe9Mbq
	 +Iy3CyYYHiIiG6cgV+cpaINV67Zx2f20IxzNTY5qC+QnqF+jtvFFyR8yjaW9job6/b+eB
	 +21jL9R9rAsZvCuq+pvCbc34bg2yXyzERz3MkWhkn3ViWIguvAvz1SJZ+wlJk+b/T1G4M
	 fqn+SZ83D9RqeN1yjAF/iNxD0N6Y7MYI5OUjz3I2f27VcAFfW+gEzgQPv0zdYq9a04ZPK
	 OZe13MXmYK4xgskEwr9amZ40hggGAZpsWpPqmBVUFT8kMdXUcN0aQYXCyWTFXfsUr4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793436944;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=7+0xxUCm+JAA4R+1UjiixWGXTAcQgz34PoPN0EUYKGI=;
	b=QTP3CGuJtSKt2zL3jufJh2SD+699+5N/5TWmcsNbSoU3Jqk6ILkCmvjP5Ro3oi/a2OA4
	 BMU8TT079bl1TeJOVWMajf7yl/P9GK6bIR+f7vMDonrSZV2qIh/Cp9HiWNfgCV7nkoktq
	 yVN/JGZf+PMF+Y4VGjoMHPaXsDutJu2c5hP5kv9LBofCNun9iO1kxWjxinCdMxwejG6Ur
	 UqgpdFzKoJIEZ7mn88UWzVzmsk8C05rUNeREYdQ2tIT9zpEAQ++5D2631fe0QEr0qFm0V
	 bnnHMo4ZVlGbCOfIvkj2ibpvTicZ1JJCoxLDRvhqgUjltRY17xGtP6m5BlW+eYiRzyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=JybzRn8A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BD1606A31C;
	Sat, 31 Oct 2026 08:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=JybzRn8A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E2D1F000C1;
	Sat, 31 Oct 2026 08:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793436944;
	bh=7+0xxUCm+JAA4R+1UjiixWGXTAcQgz34PoPN0EUYKGI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JybzRn8AU1UtqT7hy6d++pSNxVef0x2zRWQofb9oLd98WIIKWK3ujvqLgOLwPQ++a
	 nWemPKiXZuh7tYupnBNYQX3VxQJe3YBi79jMGjhyqS3gP52w2G9acpyBB35yyPEskz
	 86DcrESvkNy12oG38c30QYod3pVZu90Iy92JEMGM=
Date: Sat, 31 Oct 2026 09:55:34 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Samarth Narang <samarth.colleges@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Russell King <linux@armlinux.org.uk>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-serial@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] serial: amba-pl011, imx, fsl_lpuart: ->flush_buffer()
 unmaps the TX DMA buffer before the transfer has stopped
Message-ID: <2026103106-pessimist-brisket-25b7@gregkh>
References: <20261031005425.3351240-1-samarth.colleges@gmail.com>
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
In-Reply-To: <20261031005425.3351240-1-samarth.colleges@gmail.com>

On Sat, Oct 31, 2026 at 12:54:25AM +0000, Samarth Narang wrote:
> I have compile-tested candidate patches for amba-pl011 and
> fsl_lpuart using this general approach. I can send them for review,
> or adapt them if the maintainers prefer a different synchronization
> strategy.

Please always just send patches, you do not need "permission" to do so.

thanks,

greg k-h
