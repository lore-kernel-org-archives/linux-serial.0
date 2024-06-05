Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817D8193076;
	Wed,  5 Jun 2024 11:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717586921; cv=none; b=j2K01p+72XJOWkLzspP/5gZBsMzJq+6IkXuwz2fnJhgmjbfKUlhF+JISfctJ93B7bAeZOsCZWiKldmgAX5OUfpV53+3tqHJBmq9Ap4Tx4vVCDG5xdyPnDq1V20UPz3JFo3KM4f6XzrnbAgKAXFz9FXLtN6YHbhU79Qmm4xMyh40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717586921; c=relaxed/simple;
	bh=tEC6hZwB59McJZffKYjkfYCEF0e6oUY/CmR+yUBVyMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W+hg42qp4ss6RRMne3MyoxV4Ion1GBovTlUlYRHQYWz85KcEXBAcUeeS5CuCyd1gKPhW8zuQC/pQTsuBawXZRxVg0ZmqK2YUqqr+/aqLoD/KP9n3Sr8Y2+ZtwBPIlBTByjn6rQ8rwZk4fhmqhGHEVDmfCZ6QP3XvPmMYpaGor3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=G/I8gKEj; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="G/I8gKEj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717586918;
	bh=tEC6hZwB59McJZffKYjkfYCEF0e6oUY/CmR+yUBVyMY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=G/I8gKEjvqcqOGG+bqYHs2awTIwFTENqnO7ADXaoEnLRJo8BE6EIrjFm6/TnMjQNg
	 g9GOVLgmc2cnCHBag+/y/GsAjS9MGJw24ey3siw4EsmvTlUdS7hNRceUM7j70nHnJa
	 e4C8vP0GAoXYd2a2UrwU1x56c2i3haMoOT4TisWg53PE6Z9JeFF3ypd6UED85uu8d3
	 P1ZdpD41KF7gXZjIdfW0/pjRcW1ni0j67A2BVki+m9dyEASXWbpVhWg6zIULwDlp/Z
	 HhUwdh4UDpQtlku0DCXircy4VQRLTQiucesLIAPBbjwn4vSw1i/KezhA2kQyTiGJnR
	 Rd7r8CRaBuK2Q==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 295C73781139;
	Wed,  5 Jun 2024 11:28:38 +0000 (UTC)
Message-ID: <4d8e5114-22ec-421c-a106-aa8279f100ff@collabora.com>
Date: Wed, 5 Jun 2024 13:28:37 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: mediatek: mt7988: add UART controllers
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20240605085433.26513-1-zajec5@gmail.com>
 <20240605085433.26513-2-zajec5@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240605085433.26513-2-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 05/06/24 10:54, Rafał Miłecki ha scritto:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> MT7988 has three on-SoC UART controllers that support M16C450 and
> M16550A modes.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

