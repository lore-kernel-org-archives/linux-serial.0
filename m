Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5220334C2D
	for <linux-serial@vger.kernel.org>; Sun, 18 Jan 2026 14:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768744996; cv=none; b=Tm5x+DE/tpDwNWqjZ+MjE5HPkcPps8euiz2W+12nU5Ll9CwvA95vWTe1C0odp0G0fOi9Wboki3ullSmPtDxTSvcDbctC6WdPtB19ASwLb+23bcJpjx24s/yJqK/FVJJTFQpJj6DMMsSp8INAdMtygxrq6A115tiVWPUr77q8OTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768744996; c=relaxed/simple;
	bh=/GsF+Uwls1Cn2yinM71Z8W+ioXcZeW9vpkl4szRkNjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rCr+PFVmVTXdP6iNVRwfmo+6v8uYtOQeWqLCxJirTyfWHoOLmglZTdsO4tf4QPJGVela79cFt8wkGqiCQQbGSwsF7f2a+GJS1i4kt+OVChTVrmQmeyozmza7Wa2F1CKewQKNWtnn2klvgwuvBcChkpUP+b1JNGJzTUK9+nRkeSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=AU1u6WOt; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="AU1u6WOt"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47ff94b46afso22472995e9.1
        for <linux-serial@vger.kernel.org>; Sun, 18 Jan 2026 06:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768744991; x=1769349791; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IMK1YqKVaUf0IoyRsQOMCKJ4gS01F7A0JEX5JckEMXs=;
        b=AU1u6WOtLoi8xhtxE3eZH2de7tMEOJBbWbxjQ3yhiZkjPT2U+TxzYsQSeFKocZiPFp
         AfUR8WeygLNHXiE9Viiw1RtzFAsj1KyVxaWitGd2d8N3ANyj+Y7kO43+hm5JZhbBq+Lb
         lPvGKm4ZddOA32TKUnbLjuE3F06FWBpu3jNeWG8PxL6W7eEJcdrnLaI8SrtPWsd/V4W6
         +EAvlq2BKqQ/VvftFp9V9f78dx1EN5wahowO2gdSHzutwK6Z8mTGZRreowFvAg6oCWZ7
         I8ZU60NADPdABqce0/chNtZRxbKpG3J3sqT37gvVSYI6RT6C+EjRstJOaUfYQFkChaEz
         m0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768744991; x=1769349791;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IMK1YqKVaUf0IoyRsQOMCKJ4gS01F7A0JEX5JckEMXs=;
        b=Ed+WZIndojbWoV2/CFzQj/oKgdB+T3EZkj9iGci2omgfiuPa2E0K1SP2MgNM1pDb71
         tKZ9PRi3lgk0rwryUmaMVFTKIZiGaNb9w2oeif5HmXIXdOfl0ibJhG2nOnjcExSkAgVE
         QwM/jd831JGEVirJOKRGZ6sF2KHUVexdwwowA9Gi1YdArLA295sVgOAZwJ9i910Z1mTD
         x9cNaob1ujwzW5AnPh3Y1ImKV2plW4TKOlax68ETwmqr2pJ8JPebQ1UIU5TJAy4eDAvA
         Nto36hnxS9mloCNtmr9hjPEApEzEH0hoDbp/U7Skl8ytpiQVMWg6sGTy2QmRqVFjPg9d
         6x5g==
X-Forwarded-Encrypted: i=1; AJvYcCUiN2BAQhqm1jm+F+5f82jDwFoDrcK5M8Mu45amED9phCF5RJYoRLJIc7hv9lHRdsxc3vydMdeu5dvhKSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO8V23FHppsoZLnefxDuNUY4NaVVchK3tEcWX0UxfBCndn0haZ
	OIVR27wYFOxCzfMGpjUIJ4sfhRIsXidtBVKsUVWOVeOcnVPcgW9Lr+dGKBDG/0fzxfU=
X-Gm-Gg: AY/fxX6zU0z1scj9fa/TPbgaefRlSx/uLBtgInKAinLfwHxM9//dGsNTM3KfE1b6+nU
	EWa9Ej98bn37gJheff+kF4r7o0X5WzBHjD6OZzZad4UeKzDbVjeMqXLvDMUt7S9VMl4Vl0N7eHB
	0w9NzOOPn3bAuNbI7K3dhY7wkQXNIWsL10ShLJEngGnvSffhbAqz88irDEBOzdtIVWd9njVVQmt
	sc+GTqmZzOcTMwA3mFlkddfrXWH3wCVBcnTutx3tKL7Ufj3gno9gLPyFbmLpHegUgf6blhVXHPE
	4lCG/7G2JxrBRfyzaHXFadcGjkO1NoRCT233rEnHL9O0ONgSHFoLciBCIuWp8OvlZl2gZiMuA/8
	9CnuwbSxWxrvaFHYM0CWzQK/dSF+FHZSqAwd/sER4cERwRPA77fFuZEWzDoc1gm/0pqJhEkaR6M
	xH99IXmGYY1uPHUin4nw==
X-Received: by 2002:a05:600c:4da3:b0:47d:7004:f488 with SMTP id 5b1f17b1804b1-47f428f5e9amr84049025e9.10.1768744990847;
        Sun, 18 Jan 2026 06:03:10 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569921df9sm17725892f8f.3.2026.01.18.06.03.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jan 2026 06:03:10 -0800 (PST)
Message-ID: <9c34b805-8c6f-4711-9718-6c39a141d451@tuxon.dev>
Date: Sun, 18 Jan 2026 16:03:07 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/11] arm64: dts: microchip: add EV23X71A board
To: Robert Marko <robert.marko@sartura.hr>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, lee@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
 UNGLinuxDriver@microchip.com, linusw@kernel.org, olivia@selenic.com,
 richard.genoud@bootlin.com, radu_nicolae.pirea@upb.ro,
 gregkh@linuxfoundation.org, richardcochran@gmail.com,
 horatiu.vultur@microchip.com, Ryan.Wanner@microchip.com,
 tudor.ambarus@linaro.org, kavyasree.kotagiri@microchip.com,
 lars.povlsen@microchip.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org, netdev@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-serial@vger.kernel.org
Cc: luka.perkov@sartura.hr
References: <20260115114021.111324-1-robert.marko@sartura.hr>
 <20260115114021.111324-12-robert.marko@sartura.hr>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260115114021.111324-12-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/15/26 13:37, Robert Marko wrote:
> Microchip EV23X71A is an LAN9696 based evaluation board.
> 
> Signed-off-by: Robert Marko<robert.marko@sartura.hr>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
