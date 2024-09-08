Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A92EACD;
	Sun,  8 Sep 2024 15:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725810556; cv=none; b=LRQ5cCp0RigbGxphuOGcg33OSrNWc0cTIeQN15Ri4du5YopOgiSDCh+t5dGsyW+/NrYGqw9vhImyEEc73DY4+/g1Wa3nfUrWWhx5kE+AzkbryXqBpEqxsjY6Mn2QH2cWoBsc//Yo6Al2l8tYGQgtNR21kkpD3q9dVDkbYfdB0fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725810556; c=relaxed/simple;
	bh=Ej/MFl0U2grPzl6++vWZajsco3EirVz0KDFILRpbV9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sWBWwFysmoJdD6gZgLxpsuwdePO2juI5QJR3i5mTnKe261K745U6k5+ssgkZuWBlDGnmiDOLcvrAjqQFZfaxKt67z+VIwLzdFngJyOY2K5FLsVTjluIajPTWSJsguZuaQWh15dUrn/Q4SauB2Yagl013EMd/sIxmXRIVTs+FKiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZ8GvTNL; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZ8GvTNL"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-718d704704aso1972104b3a.3;
        Sun, 08 Sep 2024 08:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725810554; x=1726415354; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SAgWa81lHt3+8vspOTElzUpWSVFWjeBPjKGz1uM25hg=;
        b=fZ8GvTNL5thcj5d6mYrR9gmw9iDLa2YM+AIgtgCF3FCFrllz2DwODgonZj34n+tX6E
         lwkX4A6uhuHnMLTnjAsYEWdHAcZG4DhOeRBp1Dj5jvGX3fOT/XPTTEw889m2qQWgpkBK
         Nla5kR5Us+xUegsGd/gTRF2U0ycK2Sgg7riFRznbiBatNmBWhcfK9oOluSf2iMDrZYAM
         L3n2mGZ97K0boyaKq4HVMEvF3pW1qCmkzZ5YFwkSLYhi6t41pkFePUxnwscS1psexrom
         H9t/B8Z+uUyhqPs6e4R5o5okwxFFK6LzdPaLub2MzKWv5BqL+S7k2lIjiLltFCdILZ1Q
         flSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725810554; x=1726415354;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SAgWa81lHt3+8vspOTElzUpWSVFWjeBPjKGz1uM25hg=;
        b=UFaOvLZp2WgP/OINVWDUSptmTsB6J59F9sjRyLiIKFEvXuQoNaSrUcfhBtIU45kURx
         Wznv8cdwhJirIDpeY8PKakMpHpYP/MfLSllDDzSl0fBwOxCTh9fjHrS+MDHWxtIo1ar1
         VqNVwVdlF8LVnPMpsvtL0sao+B6C9n25Er2M1TcfndimOye3D2XWjJKxaDsXhOfH+OWF
         Vx59P9WOH5XyHPss1wbzntvK+JHQt46xTb6CYsRyWqQaNMgiYfNz762VyquMe0FBpQha
         cB9m4lPNqvu5AGiz3xXBsWgdeIIzBhhrSqpqel5KF35tdaaZ1NHrBRfiZViI5ozLYqtC
         5lKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRhzy2yn30AXSdYcSxvYHRR26b130yshsIDZ5jsGwP5d1WyBZDJMw+egf3tZgCDbRazfBg9+f8ntSak/pVdqftcX4=@vger.kernel.org, AJvYcCW7Dqn3sT0imp++5sgnGPx2ifRmzVoRxR2mdVh72VZV0kYuNvV3jJzBWwvy2f/Xopbrf+HB/WlbHUhOtI8=@vger.kernel.org, AJvYcCXk7qZ10bCZuIgz0KBqhdbdQFhZDcpwd7f159TyGBMv1EdgVk5xrsRSCZJGQzYzlzNtc8xGDrDGPJDc3dir@vger.kernel.org
X-Gm-Message-State: AOJu0YwQYx0vpAyspQi0yB/eHvVGZL2wdiBl23cvAnUIOYo4bX6+qi+3
	gm3EL85j/T7qlLftIaPUz9g1DfYtHMtCC6z6GITaSRghBiBm6MaO
X-Google-Smtp-Source: AGHT+IFFrn46ubbqFuvUo4a8LlVSDErVxtVEIX8+YBhSiGmjRd6iFtQgAdWXG9qXP5Fm0bTGW9ZC8Q==
X-Received: by 2002:a05:6a00:21cb:b0:717:8aaf:43be with SMTP id d2e1a72fcca58-718e3108dcamr8126650b3a.0.1725810553973;
        Sun, 08 Sep 2024 08:49:13 -0700 (PDT)
Received: from [172.20.10.2] ([49.130.9.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e599135csm2162442b3a.193.2024.09.08.08.49.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Sep 2024 08:49:13 -0700 (PDT)
Message-ID: <13a98caf-80f0-477d-b276-249e3fb20e83@gmail.com>
Date: Sun, 8 Sep 2024 23:49:09 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] tty: serial: samsung: Fix serial rx on Apple A7-A9
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Cc: asahi@lists.linux.dev
References: <20240908090939.2745-1-towinchenmi@gmail.com>
 <20240908090939.2745-4-towinchenmi@gmail.com>
 <215fde01-0e04-4445-9620-b0dba3232a92@kernel.org>
Content-Language: en-MW
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <215fde01-0e04-4445-9620-b0dba3232a92@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/9/2024 17:14, Krzysztof Kozlowski wrote:
> On 08/09/2024 11:05, Nick Chan wrote:
>> Apple's older A7-A9 SoCs seems to use bit 3 in UTRSTAT as RXTO, which is
>> enabled by bit 11 in UCON.
>>
>> Access these bits in addition to the original RXTO and RXTO enable bits,
>> to allow serial rx to function on A7-A9 SoCs. This change does not
>> appear to affect the A10 SoC and up.
>>
>> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> This never happened. Please do not add fake tags.
Sorry, this happened by mistake, and tags are added to both commits present
in previous versions by accident. I can send a v4 tomorrow, though I think
it is the best if this version is to be reviewed, since the mistake does
not make a difference in the patch submitted further upstream, and it saves
everyone's time.

> 
> Best regards,
> Krzysztof
> 

Nick Chan
