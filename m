Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629EB1B59A;
	Thu,  5 Dec 2024 14:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733409108; cv=none; b=NFgGHWM3cMnpHeQhRm6XeJmxzkttFrYOcpFpopvNtYAxitzvFhnF7On9V6ORzrRQNFmGV4Kh2oOh9xyfMwVnLxqnyLxo5zYmCkke+ShG2XaozSCvaZOB9jsA2LZQzxzuAuWWCuAnYyAIeSk/Mt+78MHyKCrTRzgOa9idevc5Xj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733409108; c=relaxed/simple;
	bh=2ooXvGIRutsTmBlw036YiGWlbvKybJSW0NV0FlBwh4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MPCmSApcl0o3eiYPTJOCOZ/av/GimAwSgB725JAqQr6ClFIyxOfLtcfOs/hVI9PWVBZ1Zi40ANbIx5eGFJ623jcdGx7zPEIFRyYtNvkqXDPqg6W+fuUpZtbYdJDIzo9DucaSBgGh8ifiDygJNZvgQh9ahkz9rVwRovjImk32OpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5b+GpIG; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5b+GpIG"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21572ca3cccso7934215ad.2;
        Thu, 05 Dec 2024 06:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733409106; x=1734013906; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=4a7eyUFMmn0FHcV8cIZ4gjpSVCKLOYbpayDLEhjEOgY=;
        b=Z5b+GpIG9L2Nn2S2i2UD5kdqrtdH879bJVjUFl6K70E1++gsCHFltw7QHT9dFmMEKP
         kmErYGpm5mNc9YGESyDuFxuJ7UvX6peCXWj2npLWLTw+t1WLZuAWRWk7BC1tj2pc0xQm
         UgOher3v/lLiVjIpyuHPdC7s29aH4pBcRAScSNZig/hbXqwEu6iCIFHHFCOZ4CscT191
         JW+AUAxkma04XkHXfu0aC9tPePFzWEqL5ysbGebpal6N2E0JwVV04twsqbPYOLFKmlb7
         FAVTZD1/ibtUfI+eXSLy+mUUHjClqnLacOl+UNCJmUr10E2f7pP6EFEGBPYzmc9EVh39
         ceaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733409106; x=1734013906;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4a7eyUFMmn0FHcV8cIZ4gjpSVCKLOYbpayDLEhjEOgY=;
        b=wxHHEi3UxUY/H3uIzH9Y/fz5wkxj37goaxNrxKGjt58zfK2AMCIBDG7xuqdJljQ4zR
         9CGCfr2hRuOzTMJKkEO89EqAUcAYSke9723iogYiejHqenA0owx2QWPg8HsOlw1NxFZd
         wt1XF2OpuUJDd/KTcHR/Vk9r+IaqR5oAGtvhnNBXyOOhVbhiFOH3GeKGKWrt/hJDSbUj
         J4N6FXjG0cq01ljNodfsuc+kp2Wt3SQmPiIY8fMuPSr/7D+PIKbZc6TOMr5a/XvaRgrM
         hXhTgbaBwF7oqZLuLcF63/zHjd8NFhspl06dmKDx5M6aEAFkplf4q0zTClBAWTKzxExf
         QOug==
X-Forwarded-Encrypted: i=1; AJvYcCVh+WrNLuwkeni3M4ItWv2EoWsb/hk7OkRQQUJETjkU8zgteMQG4HUNdJQxgrS87usxgXWTn7tqo+VlGQvn@vger.kernel.org, AJvYcCVo4BHnOnM9vNAqjeLlVqXSx6UTaQ+RJfWNCtT1oBsDxb3DcIaNC5Rh+SHjsXAzs7ih7rqC88Y7o6uuyG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPeeeIzuaCcr5a7jhZgAq+X5Ptzz/vRFZq4KT2a/X8HLKFxV2V
	JKya3bDSw3dvlbiX514blMGHWnTndtfnMY0DQrpFFLM/BZ81iSvP
X-Gm-Gg: ASbGncsZurDCNHDeoa3mtCkUmpTWTL+PjhqxGtzbECyQNGnz+ME8s11TAyA7x3lnbe8
	quEQDl+UtxmY8uy9+dzvawRM7D2DPZ6VleB6FyyH1CSchCRHa+juio3hLziUDt95XITG/RWSaS4
	VHNSUxWoeXdi9ty7eRwmhC+oRC5vh8dTfeAw5jR9+qP2to0iGFSvI9qU3m3VdbqGyzF1iIvEs0i
	5mfQ3KAzLCEQBDkgEvdZL2jRoS2whgxrxSVM5N5PQCZmseqOBHMgdrymSg1iD5JOJw4nRkqM13l
	aFm+FsO8q7PZu4178QpidDg=
X-Google-Smtp-Source: AGHT+IFilV0G0u0Cx4xSj+Ivho0XKSW83tPUsipi4Qa9cUm/st1KcVR95ZR8AS+wAzwR0NGa5xyR/w==
X-Received: by 2002:a17:902:f543:b0:20c:a44b:3221 with SMTP id d9443c01a7336-215bd1cb76emr140764565ad.15.1733409106552;
        Thu, 05 Dec 2024 06:31:46 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e3ef29sm13245125ad.50.2024.12.05.06.31.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 06:31:45 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e2459828-aa7f-4f5f-b6a8-4e61ae64353b@roeck-us.net>
Date: Thu, 5 Dec 2024 06:31:44 -0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] tty: serial: handle HAS_IOPORT dependencies
To: Arnd Bergmann <arnd@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-serial@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
 linux-kernel@vger.kernel.org, Yang Yingliang <yangyingliang@huawei.com>
References: <38bf3b8b-81c4-42c9-902d-b5719f3881c5@roeck-us.net>
 <3b75b92805648577ed05ff221d0c56e381aa1c7c.camel@linux.ibm.com>
 <472eb22a-dcb1-4fbb-bf2c-a4173706bc7a@app.fastmail.com>
 <27685942-fb62-44c5-86ed-98beb547ffed@roeck-us.net>
 <744920ba-551c-466b-ac5c-2607b81261a0@app.fastmail.com>
 <Z0QtZky8Sr7qUW7v@smile.fi.intel.com>
 <00f5e842-3ee9-4d83-8836-0ff4f703fa3c@app.fastmail.com>
 <Z0RSZ-YD_BozMs1n@smile.fi.intel.com>
 <be43108e-4135-4927-ba58-141836fde6af@app.fastmail.com>
 <30a38025-afae-4bdf-a468-21ae2cd5a7b3@app.fastmail.com>
 <4446d7dc-efb0-4395-8fcb-7177d9e07b5c@roeck-us.net>
 <acdab483-05a4-4fa8-ae1c-70ed53402aa2@app.fastmail.com>
 <0e07c26d-5136-44d8-b9a0-96154050ae8e@roeck-us.net>
 <ed8f7230-6eab-4f8e-b607-877e6c8e5a7d@app.fastmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <ed8f7230-6eab-4f8e-b607-877e6c8e5a7d@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/4/24 23:08, Arnd Bergmann wrote:
> On Wed, Dec 4, 2024, at 23:44, Guenter Roeck wrote:
>> On 12/4/24 14:17, Arnd Bergmann wrote:
>>> On Wed, Dec 4, 2024, at 22:09, Guenter Roeck wrote:
>>>
>>> I had considered this at first but didn't really want to do
>>> it like this because we should not be registering empty ports
>>> on platforms that don't use the setserial style override for
>>> the port configuration.
>>>
>>> It does of course address the warning, just not the
>>> underlying bug.
>>>
>>
>> I had a look myself, and concluded that a clean fix will likely require
>> substantial changes to avoid regressions. Your patch series pretty much
>> confirms that. This is why I came up with the hack below. Yes, it doesn't
>> get rid of the underlying problem, but IMO it is good enough for 6.13,
>> or at least not worse than 6.12, while at the same time avoiding the
>> warning backtrace. It seems to me that a clean fix would be 6.14 material,
>> and I really don't want those backtraces to clog up test logs until then.
> 
> Fair enough, let's use your patch then for 6,13,
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>


Ok, I just sent it out as real patch with your Ack applied.

Thanks,
Guenter

