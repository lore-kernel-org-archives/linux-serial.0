Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794402048;
	b=m17tkrJU1cOoMQL/ET7uPe6ykRslA2wfC0AWpFD5WlxipD4vmw1aIu4OG2lHXdRjpAyV
	 ryCd0/LB0viCgQQoArYXbjLwlon91FEGe8iopYcd+uXHJ8TrwP+fPGz94xi2Dr2w9jzh9
	 aL5Jx5eWuCejlADC9wCirJ0yZd00dHIP2jy7j89nmHcXMy5MxqLi24EM4sM0IKUINppFd
	 8v85LZJEO1SDBPnhFVBAKaJvONur5Dfy9j5L+nzbuiTQq/5SFRWQYofv/Yol0LD9yv+7X
	 6zUZyHkTM2NGjFtJijYVYo79+mjmvcY5E37Ragl0U6vx8sPq3lq51maGAH4RRaLjsgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794402048;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=eldvn9/5NmqA8Ewg91TTZ27bKSEW+mGyVA1mL/jn1nc=;
	b=SwZarINF3cxQ3wE7+l7kOOyLEVFlHzKK/OTS4YdohOpzRhoiiu5mGWelg0dsEEt7cS3e
	 8qCANofZqnDEyt50mNanEnDLTqybBxxVXGVxiiHQH1ppdeDXUgu/3CeJm/B9OGkOqVYeY
	 h32L28CQ0STj3W1bgJ9YC3MAFD9aIElo83OsTbZO4M4jasldAhvxTrbD3AqlJE0TsPcto
	 K0g3Cz2DlNUVXt+ua8D0WskSxtgPoAHB6+xP98QfCrkpsTKulSmoyutgpdt+p0hHccIEP
	 2QFtPCdhYwfxt1bGpFSOS4MCMpGsD56GEdr6CgPUJSH9I9YBgCjud63c6eBNVzAEzHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YuG9mpz3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2D9606A333;
	Wed, 11 Nov 2026 13:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YuG9mpz3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36DFA1F00A05;
	Wed, 11 Nov 2026 13:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794402047;
	bh=eldvn9/5NmqA8Ewg91TTZ27bKSEW+mGyVA1mL/jn1nc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YuG9mpz3ABG925h5Qxyb3ASPt4fOXxSfaMpo1i1r05FLsNC1WYAET939MSY/F3YU3
	 KmlskmUi/Ns8duBw5lXabCDNdpIS90opusva2LYRNwMgd4hwof783ta+rZlNupxG9z
	 vANtYrClaSh0KMIhiwHoEg0hR9DEgY6t/xZlOQfpsnyf2s5o/VzjQ4VEtlmnYnpmOk
	 kwzOWHN/zq6BCy/OwOOxYv6UuNDGFIkBnKNMXKkavhDJ+sa6nIUTkMKBkgnHIHsGFz
	 KqSs33F57n1Ox/TkK93ILiOY8CcRARmH8JjBUyHw9AuY6n5f8Wn3uBkgZv1w28VhGG
	 kNSz2Cq6+Qgmw==
Date: Wed, 11 Nov 2026 14:00:45 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rui Cao <i@udp0.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sean Wang <sean.wang@mediatek.com>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-watchdog@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: serial: mediatek,uart: Add MT6833
Message-ID: <20261111-screeching-badger-of-storm-a9bdf8@quoll>
References: <20261107-mt6833-base-v1-0-bda21083e9f3@udp0.com>
 <20261107-mt6833-base-v1-3-bda21083e9f3@udp0.com>
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
In-Reply-To: <20261107-mt6833-base-v1-3-bda21083e9f3@udp0.com>

On Sat, Nov 07, 2026 at 08:22:00PM +0800, Rui Cao wrote:
> Add MediaTek's MT6833 (Dimensity 700). Its UARTs are MT6577-compatible:
> MediaTek's MT6833 device tree gives them "mediatek,mt6577-uart" alone.
> 
> Signed-off-by: Rui Cao <i@udp0.com>
> ---
>  Documentation/devicetree/bindings/serial/mediatek,uart.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

