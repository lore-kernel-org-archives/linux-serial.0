Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793436907;
	b=fq3qSYdu2glZU69+PJ0nnl+OhTAfH3Lw7T4XJ7FgjWaAYFUU7yUU1QkeHUT6ctqKQxnG
	 tE/wVeYUmeGbE1sG5DuyyKnUr6APMxn0xEc1ePfLa3157iHELObwRFtYJwzrwF/AoF2A/
	 Gm/Db6v2XA9QeaPCo3+oDuujH3q2/H+62107vmKEEJn/RCSHAWMMVHMQ9e/lGFFcwm0Vu
	 /E9grfeFPoC4xN+wyo3twjDaO2TKEF7aVBJDpfTJZPywzY7+Z8YEKDZtgJ2MOfnTCwaYQ
	 ZtaWjaAsiKCXS6iLsrTzkocn5uC4tNsdZmVJhCzDtta4XWgUGyuaXDzAN71gudxEz+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793436907;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=r7ldF0+SFDf2U5rthJYo7X+jFoAp1G2D38xbh/n0Tfk=;
	b=XdzULosyc/At8Qu77UgRab/eCVjdgPyx0fKFbBbbq2al9uqAKYt01Ome9ak9qYrd5Oc+
	 2mX1+3MCGsVBc00u9FjWqGwnZQWfKhlW6yUU+FcR0+iAQrwVlClAeNgP7cf+7LH8XOuDg
	 Og9kwYzQgSUWwIuAgIWbpJ+OIuXBzLyinuQPLoUvKd3+P1EIl2/NACBI0EDIjftmY12lL
	 HDYSdYU1aPY3FLIPPDjCR1KatRyFkFwzSpMliq9VxVs5wy6i2ifHspHrBWmxLY7eTNFIq
	 z2Ml6DtozNvWAoiVLboyKj6NTYSL8wHMm65ZXMYyrQLZ0GD6UwrYZ0RDPJfp75Bfiww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=iew1UTn3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B748606A31C;
	Sat, 31 Oct 2026 08:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=iew1UTn3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4481F000C1;
	Sat, 31 Oct 2026 08:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793436906;
	bh=r7ldF0+SFDf2U5rthJYo7X+jFoAp1G2D38xbh/n0Tfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iew1UTn3DVH5qDJ1jUeI8une6eJPuQAM6qZRyw8mzgsuKVIH7QSb9fVhddlx6aOuh
	 xbRD5WncX4Bn8XcYI9HE0a+/5cYa4Qvc89MvIF/7VfHt+Bnyk8K+dWrzhizq22pVC8
	 SNjzPAyGO7egk5si3D1SSrzCMU4V6jjn1rB6GwWk=
Date: Sat, 31 Oct 2026 09:54:55 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Samarth Narang <samarth.colleges@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-serial@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] serial: TX kfifo underflow when TCOFLUSH races with TX DMA
 (samsung, sprd, msm, pch_uart, tegra)
Message-ID: <2026103122-repurpose-cost-2da7@gregkh>
References: <20261031004733.3345841-1-samarth.colleges@gmail.com>
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
In-Reply-To: <20261031004733.3345841-1-samarth.colleges@gmail.com>

On Sat, Oct 31, 2026 at 12:47:33AM +0000, Samarth Narang wrote:
> I would be happy to prepare separate patches for the affected drivers if
> the maintainers agree with the analysis.

Always just send us patches, after testing them, you never need to ask
if you should do so.

thanks,

greg k-h
