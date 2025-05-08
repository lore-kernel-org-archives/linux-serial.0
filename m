Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6781DDC23;
	Thu,  8 May 2025 08:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746692144; cv=none; b=dMqvflxEeoILLtVGy5oD0bHm2FGMt6M/hBfD0TIHcYwcNQPIQ9PN0z/ZZRRNfO2+GuAMjLhJNNm2HRetFxCYlhkdF9R0T9ZakcV9YJH75HyMKO34vpc3ofsHTBzH8DsLVk+RgshDd5Q/07hOTHKVBnMubVa56tu/sps/8oPai74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746692144; c=relaxed/simple;
	bh=0J5yyuWYoiqeNSzqTqaD/OXkyRKI3jBk1sYRAPwhWEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AYfme5MwyuC6EHzLoeRiS5JLZMqijEZTu+q2XjcHipird/NS/oR0BlSWYHxJbe8NBI44IqiaOCyWKdZtb1Uhgrh7JCdYotnzdfUbt1Ws7tPwPiXfdpougK+SI4qGtxDjX7NzMgxXdgbLd8dm4rFvJCuTF7qvovRLaiP9ruLOE4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KYe+QqaY; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KYe+QqaY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1746692139;
	bh=0J5yyuWYoiqeNSzqTqaD/OXkyRKI3jBk1sYRAPwhWEM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KYe+QqaYHxtSZYuPW61wnny7iHdzaiyk/VdmR7/oKaJKB7i0uDQet2do1NGazV1YQ
	 cLxdziCRoag4XEfGt/p292DHgFhZpbja63fY8YbbVWtSNYywQ0VRLPyeRwciMrgAC9
	 IIjnhxe9ItQ77AQQU26VQmh0q/gsJYM2jAlcJRlEyGupSg8xvxOzJzZrdYTuWn2lwU
	 yOlU6K/7nR95f/2/x+GHUlFuzAgW8EZBJ6exf09QRilKptvKvbyuTK6pyQ8Ef8pRhk
	 3aSkAqoxgFmhezGJ8WeTyNHDgoIcak/+cobyN70MRpiq+A55W0IMMBAZoJSyE8cetB
	 3NFc1svtJ1jHQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8995317E0FBA;
	Thu,  8 May 2025 10:15:38 +0200 (CEST)
Message-ID: <fe72f05e-6a79-4240-8cf5-7a20e094aa46@collabora.com>
Date: Thu, 8 May 2025 10:15:38 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] dt-bindings: serial: mediatek,uart: Add compatible
 for MT8189
To: Sirius Wang <sirius.wang@mediatek.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Sean Wang <sean.wang@mediatek.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, wenst@chromium.org,
 xavier.chang@mediatek.com
References: <20250508063546.289115-1-sirius.wang@mediatek.com>
 <20250508063546.289115-3-sirius.wang@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250508063546.289115-3-sirius.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 08/05/25 08:35, Sirius Wang ha scritto:
> Add compatible string for serial on MT8189 SoC.
> 
> Signed-off-by: Sirius Wang <sirius.wang@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

