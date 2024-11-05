Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C253D0D5;
	Tue,  5 Nov 2024 15:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730818965; cv=none; b=T2NqFNIlIuq5tJi80/Y/F0p4FA2TG/Qk/Kg60aM5P+s/+rgr+6atQTGATKeySCrnmmyoUa6bha3RFMetq8NpnpkpDXJGO1uH8hctAUA9hd1Phr2B/87N3+T0upSnCOhE1I0FUbrbTF4XFFGDMEP6AgD47yayTpb//9lXNVwENIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730818965; c=relaxed/simple;
	bh=kAW7oETZEfzL8D/Rhw4QbRy1C16BeO1NPTdITkgYSoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e5n2HYv2n5nXo9qbgRs6oOgLXYCWxYe5SBJ81HfN442ItGDZuKrL8HhXCLc0NHELYZsGNE50TDsbGx/sUrex7ZoIG3PJIY66CA14W629fHpCoSFAxKD2u3FcUjb6yhj9AH457ulZFvgNt6IFPLoPX8wGPGZyYaQHIwmUXjwoEjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=maDr4YOu; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="maDr4YOu"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20e576dbc42so58137875ad.0;
        Tue, 05 Nov 2024 07:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730818963; x=1731423763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GylzRZAw80Z1YP9ykCKe0zWAimOryNrUB5zoTN5UfS8=;
        b=maDr4YOu5KrSvIOVcBy4QVJgNWufyTbhvX+1UIozLhigs+WbQsi20lG3obTiPAKd+I
         pVMcbkI8NSAFLxNohe0UdVt71XWdCISZAKS6JrvhrcWsxMchT6OzVw2kBd3BYBorJpOW
         hIEssB7itMCDarTE7JiCAzsfDgTvJj2am1HrnPtYSzCNmY4+OjEj7F9gY11AyVuGvcYu
         z1uTOqqICOv3re3dy/Y+PdRWPGpyXJb49aCoRWVm7OFn0lZbj17qh5TmVDgtJdsqiZq+
         7cN9ykuuE1BnnCtR7cGhb20XH92uZhNfj7gjUMBgVmu4hlfEsfbL54p9xgV5WvqhSgKP
         0Dqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730818963; x=1731423763;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GylzRZAw80Z1YP9ykCKe0zWAimOryNrUB5zoTN5UfS8=;
        b=osRg6EWXsmF4XTsKFZu0QL15PzGMajuJq53TOqiqNGrV0FSCVMU85dAyETacAfxzz8
         7r4HhunFeWonuwQ482sIBgOoMeguiDxzZJEQWVXP2ECi6AMfp/X9+GV9J3J2uptUzEsi
         Nk2xTBYxianSMmYyZAuVJNwHiP8jeZJXKJGYLtMgXLq0hivAwffaoqmsFW9oXAIy+O6t
         ncviboNzy0OqQL9ePki05OybD0rRRqrj5UK4xgn1pieWJ0i6cQPIRu6QEU0UPcGKZoza
         8w17MH1yuT7CFbGyXSs5Y4fwdpYbqsyo0U8PQlpwFhIgM3NiGvKB4o9aIsb+NwS0bx2X
         rERA==
X-Forwarded-Encrypted: i=1; AJvYcCUD61FN0kDG/uxWFNUtH6bB9qkDUFCujiuvI52FVwAXRT3Pf7nZoJ+n7k5fKVrQuCfKxCkjT9RUOpgQyIE=@vger.kernel.org, AJvYcCVq+PLP5ZolIQctPgrJNX9Od/ZptUEUdPKM9eGhFpoYn0UYwflBCntBuJChNsY4/S+0YzCwwHfAJtRxsEAa@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/q8RrEa0zmzPH5RbyLLCx94LGbMCB0C40XXwpJWoTtVGPX7B7
	dFpn+FZFutxkSQF/2gJxH49ruhG0ZtYy3S8z6DuaTOwUp0cUg9IA
X-Google-Smtp-Source: AGHT+IF/eUZKDzQsRxKzTlua0VGkAg3XHFmVRb6DFSZ+1VJsC1hbumlf8z0CTzQo9N2NGxWAK6QLWQ==
X-Received: by 2002:a17:902:ce89:b0:207:1675:6709 with SMTP id d9443c01a7336-211039ed04fmr280580415ad.0.1730818963193;
        Tue, 05 Nov 2024 07:02:43 -0800 (PST)
Received: from [192.168.1.7] ([27.7.141.222])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee459f927dsm9131881a12.75.2024.11.05.07.02.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 07:02:42 -0800 (PST)
Message-ID: <2946c37e-d46d-46a3-a965-4932d5fc34bf@gmail.com>
Date: Tue, 5 Nov 2024 20:32:38 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Typo: Fix typo in atmel_serial.c
To: Richard GENOUD <richard.genoud@bootlin.com>, Hari.PrasathGE@microchip.com
Cc: alexandre.belloni@bootlin.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 claudiu.beznea@tuxon.dev, jirislaby@kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20241024172300.968015-1-cvam0000@gmail.com>
 <5933bb3c-3b1e-4579-88c6-b9bbbed93a4f@microchip.com>
 <94726cb7-7cd5-48cf-b158-a66e6b279058@bootlin.com>
Content-Language: en-US
From: Shivam Chaudhary <cvam0000@gmail.com>
In-Reply-To: <94726cb7-7cd5-48cf-b158-a66e6b279058@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 05/11/24 6:40 PM, Richard GENOUD wrote:
> Le 05/11/2024 à 13:18, Hari.PrasathGE@microchip.com a écrit :
>> Hi,
>>
>> On 10/24/24 10:53 PM, Shivam Chaudhary wrote:
>>> [You don't often get email from cvam0000@gmail.com. Learn why this 
>>> is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>> EXTERNAL EMAIL: Do not click links or open attachments unless you 
>>> know the content is safe
>>>
>>> Corrected minor typo in atmel_serial.c
>>> - Fixed "retreives" to "retrieves"
>>>
>>
>> Pls fix the subject line. Refer to the previous commits from the git log
>> of the same file. Also,the commit message should be in imperative mood.
>> Send a v2 with the above comments addressed. Some useful links below:
>>
>> https://kernelnewbies.org/FirstKernelPatch
>> https://kernelnewbies.org/PatchPhilosophy
>
> And for this kind of patches, I think it should go through the 
> kernel-janitors ML.
>
Thanks for responding , i think kernel-janitors is not active 
anymore(IMK). Ill address the

review comments and send the V2.


thanks

--Shivam

