Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145A037E300;
	Wed,  1 Jul 2026 16:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782924948; cv=none; b=hmcbCs/20iL0dxgBspwEfyAspBcu+80BGCr71D/6PvGJSPB3BH6Y6qwBEQxqLxSsIWnCKZwbjbL3Jm/siL6OWIB6ttpIcp0CZZMMxWIc8spDcVdDoU3E+W7dOJfieOQumftCf5vtEA8lS50lYaQW0eD8Wyj/yHjSlauClSt0BWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782924948; c=relaxed/simple;
	bh=y7gtTI0ydq98AZsQ2d7PtGJojxoKiDUQ/aGW+YI8xuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nNrHRRRuYiCtQyUPYYRKp0WSrYOr0MQpGVXZe8Kiw/yGUYLlSMbwI9Wbf3hWc2bOAukmawNmvXp2EUpQZsu11iJxi8ZnidWotuPqXO+arVgd6afiRfkzIcN3ffFlXXZ0CxqQTC4V42/jnF0fGon30Y8YE9Mud6Ohbowfp4DwQhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=D1Ra6Y3S; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="D1Ra6Y3S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1782924945;
	bh=y7gtTI0ydq98AZsQ2d7PtGJojxoKiDUQ/aGW+YI8xuU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=D1Ra6Y3ScH0xOht1DNftMgZndiCg7oBVferRNeiE0ZrnhpWK4ZS6UzHCCJKys6PMJ
	 bzbyH2rTDQ3wyiq+hanKMiRfUyGfVHTWovIDIPuufmE9QOQP3vtYd0ge79mwOVPRer
	 Gb470Q/pgc/EWeKmR6du/ANew24kWcsFF5tGSyY6XV4uyVOIdjwcBwC+OBxmejgcOw
	 GbXJD3tqTuDgpTkH1Ug5GzfC09goJS4/SDh3jxX0/U9tuTt0/IOm4PKqJYl+FIhChK
	 aMB1sIcM8cGSrm9Ps/ZvNWEyiLVPOL4FkqXJwmue4zHSI6B2rho99CxRwIBFr9Am98
	 7t2asgpe4Ft0w==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D93D817E0CD4;
	Wed,  1 Jul 2026 18:55:44 +0200 (CEST)
Message-ID: <94632030-6204-4403-af8c-13aca3916857@collabora.com>
Date: Wed, 1 Jul 2026 18:55:44 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] dt-bindings: serial: mediatek,uart: Add compatible
 for MT8189 SoC
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
 <20260701-add-mediatek-genio-520-720-evk-v2-1-19d5da4ef984@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260701-add-mediatek-genio-520-720-evk-v2-1-19d5da4ef984@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/1/26 18:35, Louis-Alexis Eyraud wrote:
> Add a compatible string for the MT8189 SoC.
> The UART IPs in this chip are fully compatible with the one found in
> MT6577 SoC.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

