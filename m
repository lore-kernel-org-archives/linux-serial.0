Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794914138;
	b=jNudSiR8O/SzrZiSQrNxWjGnEVOaMFsQgI2r7ak2jJJJhTncFJQICqb9P2jOpHJQvP9m
	 eXK1shaFE/6VEf3050p3krBW705y5uQf+lXMGew5M93IjBX/a04UypJUOK/2465ljfNGn
	 az7OhYqduuWUSvjAURiwozfEw0TrSNnBWyUlNL4Wt012OMyMcWtSMSN2jP0LRr+uYDoE6
	 Q3Egjmm0G1jtbgjipxFuuEKcl0Dz9ueTPCXRzKcuZ4oSqoeJIpIVc0Ta7MsE8Kn9Tdtr4
	 BmXn86oj5Z0a7f/Zc3aN9z0gP4th5YImjHO8Ary3un8NxTBmrcEUgBLifHhcT70OkZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794914138;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=HuszLLEjXpkORq58yz0GcNo/iqkBHOAIX91Mb3TYLQE=;
	b=eRkR7BkL/LeqX87gQoD1ajaOZFkqIv8Xw8fI769IZDlfm/ELg4hM2s6thpVZjQ7mexS9
	 rQ4xKEnFRXD59DN+zpadBI4WjYL8NIW7ZwlwOsU6jQ1F2lOVW190ZQVy98VtJDUPATc5t
	 /btp259DDNyBT7z+TRP/seFZd5QlFQJLqBq+W51PMN181xIXwbgcUSTlBFyml4yuWjd6A
	 fvEF3+qjBNDsP9GMV1+LHowkXbS676pTh73c/vqW/TdR5L+BA3zjHH3gKu6gIcpH2Zudz
	 8lZxOWYDBG8pbNnyTKtJMmxV/pMlgtY8ggLzvhX0Dr7dGLocV4O3Pxh/OfTiIpWC9ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=GFLdkHCT;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DBF606A323;
	Tue, 17 Nov 2026 11:15:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61DBF606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=GFLdkHCT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1794914136;
	bh=Yowmv05lbR40wQjKJ7RKOMQYkspttaK5HaDL4dRGMBw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GFLdkHCTqu2t1UmYxAlJ/UbqwGp0LcB8XoKMVuhFze4BN8fUNBw4bYVnpLaCThZ1P
	 k8CjQEWp16KmKRxPuYRQIWp0XPuCwIm/AAL40vNZL3TbhkaPixjfq+nIUgEspqfLOR
	 iRal+NIhfjZDoMANrXVsVzhAz5YBQUNB+AsS7Us5akG8St/Q0Yc9cTPrdud0BYYy7O
	 v6yBalOCHkfnsW6a1ntehyf6z4Zo8nfvNkWR1501mtTsvqz55USmt9rPUXEYtjKfuw
	 oQssNpmvbn6L/zpYZemKD0J32XAV1yvimGRj9ZWAr0+jbbdveLiOgjD5M6WxdaoWGd
	 wHvDFVFjRrz3w==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DE2A817E0060;
	Tue, 17 Nov 2026 12:15:35 +0100 (CET)
Message-ID: <843a1fba-f74c-41c0-90be-f97b8dbffc09@collabora.com>
Date: Tue, 17 Nov 2026 12:15:35 +0100
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] dt-bindings: watchdog: mediatek,mtk-wdt: Add
 MT6833
To: i@udp0.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Wim Van Sebroeck
 <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-watchdog@vger.kernel.org, linux-serial@vger.kernel.org,
 phone-devel@vger.kernel.org, Roman Vivchar <rva333@protonmail.com>
References: <20261117-mt6833-base-v2-0-058a0685c40c@udp0.com>
 <20261117-mt6833-base-v2-2-058a0685c40c@udp0.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20261117-mt6833-base-v2-2-058a0685c40c@udp0.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/17/26 10:11, Rui Cao via B4 Relay wrote:
> From: Rui Cao <i@udp0.com>
> 
> Add MediaTek's MT6833 (Dimensity 700) as a compatible of its own.
> 
> It can't fall back to mediatek,mt6589-wdt, which also describes
> MT6589's twelve TOPRGU reset lines: MediaTek's kernel for MT6833 resets
> the connectivity CPU through bit 12 of WDT_SWSYSRST, past them, and has
> no full reset table for the SoC to take one from.
> 
> Signed-off-by: Rui Cao <i@udp0.com>

Reviewed-by: AngeloGioacchino Del Regtno <angelogioacchino.delregno@collabora.com>

