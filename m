Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1488F6A;
	Wed,  5 Jun 2024 11:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717586898; cv=none; b=ieg6fqoil6t8oRuY8voSj5KYc4FeLNF+RXBKiL6HLV7xPg3dCrVjRDjm2pg6DTLn254LEOtrwh5JKxZ08aGWgSABGBRD1BFUJIpZtmHg9QMW+wFYy76mSABGwhF6PhuDfN1E52/XND4c4UqOnTXeYIn5AUR1u2S8qk5QbFi65jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717586898; c=relaxed/simple;
	bh=tTRbEUHErhXOb2ErgxeUWtY7iZL3LEzBhTNIwuNR+rg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Swlu39aD5sKsnQia2oTXm/oJKxN+xyRknAF2X+LGERS8ogRP+/E5TdKfSKbaTD3Zibc1eth5I7Fq3+9soertuAmI7FnckFynqhxd/g+RZnbfLXAXgsYck5qYPPkiAj7fudiUc+WR15AJmApnap+Eq1zk9WOhkooKA1dmjXiKjvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AbIjBOWR; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AbIjBOWR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717586895;
	bh=tTRbEUHErhXOb2ErgxeUWtY7iZL3LEzBhTNIwuNR+rg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AbIjBOWRiZsvWHdcvS38X5SrYgUa9pAtachgcKEpBPgiLf7iDsxFSdgo+1fk7U6R0
	 H6q4b0jc8zp4Jz5tDGI67d4650OGweZpgrsCbamETVPnh/4j2yxd6psQFGuV5IIIwX
	 7Isqsf6klqqmUj79JbuBuBYOiyTuyyZBoRgRcWrEIJF6675x8O8AqsR0BqnbiDVgEO
	 HW7zLBOQBRzM29IWEq9Fi0+nXrPS/K5GvRhzbKKm8LGsHOXXBHGTaHCTixDZ1b0xnw
	 tSmPviFuednkEn13/ra9QP3rVxCak0moX0374mM0FZ/8uQdepQSSo5cRPsJixQ9w5d
	 6+MLHe0iFYcRA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B9FFD3781139;
	Wed,  5 Jun 2024 11:28:14 +0000 (UTC)
Message-ID: <48f9b777-9c3f-4306-972a-f615e323026b@collabora.com>
Date: Wed, 5 Jun 2024 13:28:14 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: serial: mediatek,uart: add MT7988
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20240605085433.26513-1-zajec5@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240605085433.26513-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 05/06/24 10:54, Rafał Miłecki ha scritto:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Add compatible string for serial on MT7988 SoC.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


