Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793451635;
	b=3rXnpsel0YAWc14uW0CUj8yBGJbIM+SS86imHnaAb3Mkmh/04LCFU2YERLWATM1DACNL
	 59UT/gfSHkm4ybaBF8nLibYYjPa7vP3beKiVueK9VMNYqxRN+aglG8Ljawf4aI0uEMqu+
	 H5oKnCm3FF2U/jduUKgqxVbBDXEXTPhLKSiW0z4AUASkR0/EZRKHR7Hp+TjZ3eJQwltqe
	 78OhU1BXtqAznE6dAnaXzx6fBvsJO+sSY8m3wJTFhRIYLPusQOzCr2C+XUwEqw8w5n29n
	 PbYFWmKCpHZM1ocSIplO9GPKvhwUXqy3KaPs+nkwxY4ydOGhFHziXPH50XedN1/qMLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793451635;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=9XWbC7ZxLw6jVxWLU+pCBYSR3Sh1yV++LUbjveX1pN4=;
	b=wC9MjUMpIrIm2neOfmjrLeX/tW149RBQzt6p5UuTSrEaaOpgXJCo66DW3vt1Z+OMXy1O
	 uWDzda5pgC9kAHWCYU1JwiL9act4ZKUkMkiAjavDhgdV645P3DuHc9lx23Tldyc1/Ds4h
	 2LMlKe/sRaZemWLmBcvuUNQv2LYVTPTdWKuUW4Kj18PHRrxgQy9hjmpIXouDGfzCkigZm
	 UZ07llqThA59bW0r4Mt0wzVpdjkqXRrjnsg3/1y9UnBqX6hMp95vErFX27GYN5fQd3RKA
	 oTOgS6jGuMGgZaWTZBdMOBlmnicv9ndt8l7i4oYHKXFhFO1Mb4u2i2GWMneh9qfV7wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=wm3wvK8u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FF6606A31C;
	Sat, 31 Oct 2026 13:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=wm3wvK8u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCEEF1F000C1;
	Sat, 31 Oct 2026 13:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793451634;
	bh=9XWbC7ZxLw6jVxWLU+pCBYSR3Sh1yV++LUbjveX1pN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=wm3wvK8uyJ8DoBrMikTSHt7SewcgaKQ7yEW222ntOY5QgqL1xozXEOOc2MXGlE4vJ
	 Whf8wdwybWPlwjpawl9ABbMs7PlZG+vZT4NydVg7WwbJF6vTZ78eFQ3At1Gibukz9c
	 tzsg5h/E7k5JNiOjb29yd0m2fyfksLbJEB6DXupo=
Date: Sat, 31 Oct 2026 13:59:20 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Samarth Narang <samarth.colleges@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>, linux-serial@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] serial: fix TX kfifo underflow on flush in five
 drivers
Message-ID: <2026103146-dance-hull-0a9e@gregkh>
References: <20261031004733.3345841-1-samarth.colleges@gmail.com>
 <20261031123911.3784690-1-samarth.colleges@gmail.com>
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
In-Reply-To: <20261031123911.3784690-1-samarth.colleges@gmail.com>

On Sat, Oct 31, 2026 at 12:39:06PM +0000, Samarth Narang wrote:
> This series addresses the TX kfifo underflow reported in the parent
> thread, where uart_flush_buffer() resets the transmit kfifo but a
> completion callback from an earlier DMA transfer may still call
> uart_xmit_advance() using the byte count from before the flush.
> 
> The fixes take two approaches depending on how each driver manages its
> TX DMA mappings. In samsung and tegra, which map the TX buffer once,
> samsung's new flush_buffer() terminates the outstanding transfer, as
> tegra's already does, following the approach introduced in 8250 by
> 9e512eaaf8f4. A completion already in progress skips the kfifo update if
> the transfer has since been retired by flush_buffer() or stop_tx().
> 
> In sprd, msm, and pch_uart, which map each transfer separately,
> terminating DMA there would leave the flush hook to unmap a buffer the
> controller may still be reading. These drivers therefore leave the
> transfer running and mark it as flushed, allowing the completion
> callback to unmap the buffer without advancing the kfifo. This means
> that the data already queued for DMA before the flush may still be
> transmitted.
> 
> All five patches have only been compile-tested with arm64 defconfig and
> the relevant drivers enabled, including pch_uart through COMPILE_TEST,
> using W=1 with no new warnings. I do not have access to the affected
> hardware, so testing by someone with suitable devices would be
> appreciated.

If you don't have the hardware, and can't test that the race is even
there, are you sure this is needed?  :)

What about using qemu?

thanks,

greg k-h
