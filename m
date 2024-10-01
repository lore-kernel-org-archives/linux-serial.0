Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926211BD51F;
	Tue,  1 Oct 2024 07:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727769048; cv=none; b=u8mhw5H5Yzd6ObBjgPiTpwsKF2aF5116vEuQetxYH86SZF9xVOUKsarl9hiXjiXtRdTF/iyiHmyLiMRmTaNFlvsxd4kyTwrkH/mgfVXdziXV5SCdBbJNBDEkjVpWknUCos9ui8KTlUO/O8E/bMN6aIYvBgdqPna0aDETFV9JkpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727769048; c=relaxed/simple;
	bh=Fdshc4z5HS4VUTO1VEv8lv8up1mqx8R8zuvM4emz0wk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qFkovdmAeEapIhWfmxAnTXI3GCFh9qMz713RrzG3ptFQasmaP+NmuQwoEWtXnmCdVxsTMUq1tXk/Cs4ygO4AN22t+I6U4exAvcTlfCFAns8KwTngOUCgjA8d9kCaq3rwm2xYbu6h2chuxjgwNANYSOxR9IfO/+Cifz+lF3+qNZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DMrGIaBw; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DMrGIaBw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727769039;
	bh=Fdshc4z5HS4VUTO1VEv8lv8up1mqx8R8zuvM4emz0wk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DMrGIaBwX0bNIQJNWI/E/smC1zVoO37IDpgeplPP1GBaweWDz0o1c59n3yMFPJr2h
	 vT8u35o354IqBNXfcxbeHjYafmfJfEbT7i3rYV1MpIXzu/iPIHsqa/d5BUIDXk2JS9
	 yfXP1DphGCdDMhYxWGFxQRLn3DbqZuTkcl5UNE8aBK+0MPp1LsNYi6x6mPN++yYChc
	 np6449tGffzRSEVPxEJY0jPNGDvSRisrUVjC1ZP913s3bHEkxWN8rL9EtjQ4Lp5OgK
	 q2TQ7CPkq2/hZRdF0IbgUydzx+NI7Q2dO1iJRsGhgFnVWRMgTddLFQDgijcsXK50sQ
	 TehJHJhQRySjQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id F081317E0E39;
	Tue,  1 Oct 2024 09:50:38 +0200 (CEST)
Message-ID: <23bcf642-ad0f-4fef-aec6-af710ff13fea@collabora.com>
Date: Tue, 1 Oct 2024 09:50:38 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] serial: 8250: Fix typos in comments across various
 files
To: Yu Jiaoliang <yujiaoliang@vivo.com>, alcooperx@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, matthias.bgg@gmail.com,
 andriy.shevchenko@linux.intel.com, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Cc: opensource.kernel@vivo.com
References: <20240929100931.530620-1-yujiaoliang@vivo.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240929100931.530620-1-yujiaoliang@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 29/09/24 12:09, Yu Jiaoliang ha scritto:
> This patch fixes several typos in the comments within the tty/8250
> directory to improve readability and code documentation.
> 
> Detected using codespell.
> 
> Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


