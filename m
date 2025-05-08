Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E79221FAF;
	Thu,  8 May 2025 08:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746692145; cv=none; b=iBTCzZ+BpO2MXB5VHOCicubbGd0zMc8Y3UYpUitayB3a6OSjEkgIoWpKSrvs3JKPJsnBwrsGOiEbrJYdIwZbglomNWUrF9AFsKYp0BWw8b3DfmmY+K6kSn0CRDSntupAY2xyxB3MDz70MOleKDxAemILpQ9/SnW9dRB6i4yTcgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746692145; c=relaxed/simple;
	bh=7r6OTGgvged4uco8BW+BLg38bSJrp+WvRqlr9YTSWRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uSwSX0cv1O0PhXd3RKd7gvK5GerjcpkXoaMwEvMlnT25Yb2j/qRX2J2SlgwOrDOLdZ3SiVTlh+6iktbOYwGz+qfD7TmYhixJ9sXTJ8alQBxDcVOR40b000KJdTf4ZJ0YlZ3X//emPV1kqC+D9AJa8/LvoKXvFvlYVQ0hOMV858E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bfgaKB4v; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bfgaKB4v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1746692142;
	bh=7r6OTGgvged4uco8BW+BLg38bSJrp+WvRqlr9YTSWRU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bfgaKB4vrzTursOZlFORwMk/wp4advCrn57O6uhdlNElcWsKrQilcXdLZQA5cYlJl
	 OAKG6Inmp4uKTeuGkeNFlV153FIuunxAuY2iXaBWSvvMdewGtnPLDbkI7+K/LQiDJB
	 I5oSwtc+AG7YaLGkj9k6W616zq/0E8Q/cvoU9hZdP02Bf3AvhuzzUngWEd685986bb
	 P23lWwUmd9xuq+HCci8PCoe+lWyjltOo4eYUpfThnaKrcsO7tk393+hEGOD5gls2Cy
	 meTxEVjbHFbMCTNW6cxIv5LYBphOGAUs7AX49xaiLCycgIv8YZw37sp+tj+pHkyJgv
	 3M+2lQ+Y8eUZw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 47BB117E120C;
	Thu,  8 May 2025 10:15:41 +0200 (CEST)
Message-ID: <97ec1373-1662-49e5-aecd-407a2ab2c2aa@collabora.com>
Date: Thu, 8 May 2025 10:15:41 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: Add compatible for MediaTek
 MT8189
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
 <20250508063546.289115-2-sirius.wang@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250508063546.289115-2-sirius.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 08/05/25 08:35, Sirius Wang ha scritto:
> This commit adds dt-binding documentation for the MediaTek MT8189
> reference board.
> 
> Signed-off-by: Sirius Wang <sirius.wang@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


