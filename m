Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671BF2116E7;
	Wed,  7 May 2025 06:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746600723; cv=none; b=dBKlg7Bshi2Zy8Nsv4gvtoxcTK2oqOc+hpRfEXMTcf+1kjvL8hGHagjSNQRzOWFgUeuIg8NiVnXrrPf4UH1GXZo4DQIeVURfOHhmg3CfpepWtN98YJFgzv/Aujo9eOWG416dE3tZTq8Vqdp52aK6lVMpa2MfcKn+eUc0Rste/c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746600723; c=relaxed/simple;
	bh=7HbNIzMEBH3G1bZP2toTzbtQQnF+CEXpP6d9nsdQ/bY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FCn/BPjrem8Cp7HAJ2UsnvaU4e6DAlu+Nb+8f4kylbP8CkZT9WfAUZHPNfunTdMNjuskdfIk6xTZTEztE7DloEoNNUvLEqEsK/IIRyDu2hCX/BNWAE/QeQeZ1pAsymZIXDAZro0oqqTRqBPT4MF8YvXrUrvm9uHu4Dqi6PcSfsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=TSDu3/e9; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=TSDu3/e9; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="TSDu3/e9";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="TSDu3/e9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1746600331; bh=7HbNIzMEBH3G1bZP2toTzbtQQnF+CEXpP6d9nsdQ/bY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TSDu3/e9wC/7vkGemThhcyDL1eyfJswqiF+QvbHgBBl5FWJdrT3q+vqpcVyLE53ZI
	 PP6DCQL3tLLlz4Ygb5IXgCe4AvGmt1NsYzFrOl6Tt2gyiBwrk6ZPBds7qSL620m86B
	 LQmiNSbBi7qQ8xhaiTy0oMF8qyeRiCEl+hQdebrQUoD2Ye+IcH0fMiyo1q0yuSoVfN
	 cXPi2iOGg4TDbFl+bdURsC9F1hSyiiFkXY42/53VIX6aQJThmsPwaLmc2kVWx35tV/
	 2IvU8xF3JWvhpMH/OscJWcOdTRs0hPvhelVz+9TEwOpJ+jjwd0reaU258Gd3mvp/zK
	 PSTtEEgGHVzeA==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id 2C8DA3B7F0F;
	Wed,  7 May 2025 06:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1746600331; bh=7HbNIzMEBH3G1bZP2toTzbtQQnF+CEXpP6d9nsdQ/bY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TSDu3/e9wC/7vkGemThhcyDL1eyfJswqiF+QvbHgBBl5FWJdrT3q+vqpcVyLE53ZI
	 PP6DCQL3tLLlz4Ygb5IXgCe4AvGmt1NsYzFrOl6Tt2gyiBwrk6ZPBds7qSL620m86B
	 LQmiNSbBi7qQ8xhaiTy0oMF8qyeRiCEl+hQdebrQUoD2Ye+IcH0fMiyo1q0yuSoVfN
	 cXPi2iOGg4TDbFl+bdURsC9F1hSyiiFkXY42/53VIX6aQJThmsPwaLmc2kVWx35tV/
	 2IvU8xF3JWvhpMH/OscJWcOdTRs0hPvhelVz+9TEwOpJ+jjwd0reaU258Gd3mvp/zK
	 PSTtEEgGHVzeA==
Message-ID: <fd2eaad2-2c9a-4277-b705-cac5258d6409@mleia.com>
Date: Wed, 7 May 2025 09:45:28 +0300
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: serial: Convert nxp,lpc3220-hsuart to DT
 schema
Content-Language: ru-RU
To: "Rob Herring (Arm)" <robh@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20250506220048.2546915-1-robh@kernel.org>
From: Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <20250506220048.2546915-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20250507_064531_201306_81B92975 
X-CRM114-Status: UNSURE (   4.52  )
X-CRM114-Notice: Please train this message. 

On 5/7/25 01:00, Rob Herring (Arm) wrote:
> Convert the NXP LPC3220 HS UART binding to DT schema. It is a
> straight-forward conversion.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Vladimir Zapolskiy <vz@mleia.com>

--
Best wishes,
Vladimir
