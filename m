Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389663101C2;
	Wed,  1 Jul 2026 16:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782924945; cv=none; b=PqFbOK9p4WXVBtVZVfeNQJqTDl2JuTNq8rCZ2Ve6C4GM462FGftYRfQR43YNaZN9d8LjtNW/J6TlmOow7y9IHUL9VVhezRrQ2iu8l78FRgBHrZfcCBF7TxGtJje7GaaziARBYmwEjrY0VPjirXlkJsRbx87z94HjESPlR9bo6DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782924945; c=relaxed/simple;
	bh=ptNn3aFC0Z+kps7/VxGR0POA/bIx4QVuPCUXJBIkA9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V/APL1FdELY0k6rais1WTsl9/hnofanhTr7tOS3fXAGQNmnZWScq4H2X6fwHf4xkJifGLi2ZUxwTHYMDkyjsm3PGbdMB2VZ4YVxwGF+Uv7SKH/EcRVwR7/7k6rlyg/1ZgkwJudwkY9Y6PDSkAGS6GQOuNBbrLUAj36uWxO3u3+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dCCUYnbz; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dCCUYnbz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1782924942;
	bh=ptNn3aFC0Z+kps7/VxGR0POA/bIx4QVuPCUXJBIkA9I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dCCUYnbzdnzmG9GsYI9cLJNK2ZX7jWuWnAOnj716NZ2qSXiuT1NkPiTDBuB2gUJpw
	 VH497QKq2u61vTlBar/l40NhfE9ooX63W8V1q2Zs4Obc6A1mNaCyPvehBUcj48wwA4
	 OmBrbJgRSS4xDbS8mRYqvFISXebiJZ3WeBbNIfAtkbT63wg/KOJDduyuE4pR5WAhAW
	 V5F5sscuyXEY9RxDeTv+4ElXwbGaIsEA8Y/SnH/vkMVGG+U1gMiby8G6jFA5SX8gZf
	 K/WkhY0qxeYqdUccy02MN0STuMJTpmPvPd8DkG4kMcgOIsvkLaUaLWkSrlTf4xH2cg
	 WC4+1KRTaxfwg==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 181A317E0CA2;
	Wed,  1 Jul 2026 18:55:42 +0200 (CEST)
Message-ID: <c5fab7d4-a4e4-4d6d-a9ff-51cf6e8d5075@collabora.com>
Date: Wed, 1 Jul 2026 18:55:41 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] dt-bindings: arm: mediatek: add Mediatek Genio
 520/720-EVK boards
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260701-add-mediatek-genio-520-720-evk-v2-0-19d5da4ef984@collabora.com>
 <20260701-add-mediatek-genio-520-720-evk-v2-2-19d5da4ef984@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260701-add-mediatek-genio-520-720-evk-v2-2-19d5da4ef984@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/1/26 18:35, Louis-Alexis Eyraud wrote:
> Add compatible strings for the Mediatek Genio 520-EVK (based on
> MT8371 SoC) and Mediatek Genio 720-EVK (based on MT8391 SoC) boards.
> MT8391 and MT8371 SoC are less powerful variants of MT8189 SoC,
> with identical hardware register maps.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

