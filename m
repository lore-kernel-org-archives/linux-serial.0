Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49AB1940A9;
	Tue, 30 Jul 2024 09:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722330708; cv=none; b=D5cKyEujJoCgN+BM4waHKPt/wNv8iBQdmZDbuRiON6CBeAicXJxVqJJUlCyUcJo3XRSthtD80lOT+rly8Uca5GtJzH4jjeZLwUUSpO5svDUOcA0v0P+cqzvxcwHttP/od9P/YznwzP7pofPHmzjmxsrgTXfsnqsluR1mHys7FUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722330708; c=relaxed/simple;
	bh=LEB266Y/Z05ka56vMjBVHaG1mD/x2/PBj7c6e8BC2oE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KLhGGeUJp7ktkRKAX2zmyYyZOMIOG2JwhZWlizFe3iKgzkHRoGMeEREDUcjfkC/RkFro4BZc0eRF2sl+eBLawwm4LjwyUsai4e4xtwWXH+EQhb/nz+hyNp1PLGySfS9ync9ma9UEztTKae4JjDLlPD5svIRpy2piFnW9th56iVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=2lPP/0w2; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="2lPP/0w2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722330705;
	bh=LEB266Y/Z05ka56vMjBVHaG1mD/x2/PBj7c6e8BC2oE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=2lPP/0w2qH48P34LkdXlBIfa47AJaeT8FXvKqwdX8wjUXbLa5od5+kRUMK8HGtRu+
	 knpJtwns1OpAphADA6GFZWXMn/P2HPP5uFZNz07YvC0rgyVcqyDVWjTywsaUhJboUL
	 MmYI0ZJx7dmyUZobnkqOVRRegqqkqPGTgSFDcj9YV9N43fkuMamsHxznoA/KhSQzvh
	 6i7loo80FNRnVj92IvQ5DWNkYUlQ3n9Sizv+sT+oaevVKyfAWdZfpZMgaIdJmotOfu
	 r+SAQDlxuY3bvQY/4ixh4I2Labfic6HQ+WrzgI48GoQF4gWm67k2V1d4gpBbEHpPsK
	 KzbQQN5CKKggw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 289D03780BC9;
	Tue, 30 Jul 2024 09:11:44 +0000 (UTC)
Message-ID: <c2e7392a-1ccd-42c7-9d4d-e079abade2f1@collabora.com>
Date: Tue, 30 Jul 2024 11:11:43 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: mediatek: mt7981: add UART controllers
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 John Crispin <john@phrozen.org>, Daniel Golle <daniel@makrotopia.org>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20240727121447.1016-1-zajec5@gmail.com>
 <20240727121447.1016-2-zajec5@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240727121447.1016-2-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 27/07/24 14:14, Rafał Miłecki ha scritto:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> MT7981 has three on-SoC UART controllers.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

