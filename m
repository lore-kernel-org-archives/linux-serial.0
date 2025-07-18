Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D996917578
	for <linux-serial@vger.kernel.org>; Fri, 18 Jul 2025 06:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752819279; cv=none; b=ln+UA6RJep7fbva0GtTcpqeaC8dTVttlvC7UumWA1nVRDZHLqzc3JRp9NFEc+kkSECAg1BETj/ZG0KnX+7Rju+vcpXfOlhRwaDHXUpHZaZHzMFfGB3SAxKn4urNkfWPf0qsUUdIDTPCz6WY17ItAHMfEtSoAYisTkttmh77wCoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752819279; c=relaxed/simple;
	bh=6S+y/P+II8gQtXm108YJxIXK9ZODMt2aLQR6rh2xuDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bJ4ntTyoGZ3fODU342lLD8/SeM8q3MeISxRKm3Vr+DjmbydXJzLhQ3DC84U0h1Sfu67p6OG502wW2Pw34C6PWWnOJicosk8cgbYA7fI7yYRDlRbj4XxSMGHet2LrTg5FxaUgf7l1zi9K4xwUgsb5VfJKcHpgGHx3J2qXgAgdhsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uLCQ4BrE; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uLCQ4BrE"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-60c733792e9so308843a12.0
        for <linux-serial@vger.kernel.org>; Thu, 17 Jul 2025 23:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752819276; x=1753424076; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VWiqtcrm3UpqYWicE+Qr3IVBY26YZu591zaNb17vRzc=;
        b=uLCQ4BrESZ6PeJl5DQAjQIaXCqA+aHYlodIv8+NadCem61jzJtZDaceTsT3JbHS51o
         KyyNInTcanBz4r5KQS2aRwzcgPibyBHo3t3w8xOjKh4pxVEFPuYLbUKvAkwis77wYppa
         pp/ulwup/BMf65VIfX3v+F+mXqr2sDb38J7mtt59O2LslUsdkGyQb0gdev5A6dWwoCGM
         B6c3eTwqIRIlUxW1xsxzMdTdETaYPXUJQqvYBEGsIIkzCvCgxl2oVJV2w2Iy4RdjhqvU
         5pve0eGUW26QEuuufCmoTi+S0ZKRzoR889Xf/hXVkTX3zmhwHpYPfphaexljmLPqh4HK
         Lygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752819276; x=1753424076;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VWiqtcrm3UpqYWicE+Qr3IVBY26YZu591zaNb17vRzc=;
        b=lQA2LE/P6fWFp2e6uW4afG/1QrgeJJe/0AxE8oPpz8Iv/RVgH5OrYEgl0UrTYPdXYT
         oBU7Oz7e2AfI1700NDlTiauHvGj6Ov/FGkWl4Vi14KjK8jn/pI1BC9fqWK1GMk+WF8DV
         M6U5CuOKnc3EvDMQVeuRYdF4GBy0HMRbwwWJH0T6XJElqahlnuK8zubii304TiVIhJbe
         lN6UMeO/BqGmMgVgvsy+fpJehxlzBdfbm4Z0Wo9/ygnG2/NyCHjHFl1rh6jXw7L+pLgi
         /hlz668lZCZnvFgYWIBmQTreLRwvJjLaqpYncO4vmnmYsWTbs42GuN/uZ8b45TsOLX2W
         ytng==
X-Forwarded-Encrypted: i=1; AJvYcCVDNuvu1y0EpHdE/qkOuTvg4Fjyk3ajoseTJ9Ri0TVqBjMH1IIbXOpI+jh5A4Qpfz4lW08WLhMPXHRfc/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjr/wNkQaRs3WztSWYz7uD/lxxh6blAMUbegcdtaVxNdPiegcf
	H9m78hb4XdImqzTsGHU0Egsh7zb/LP53YyP85z+Sp0eDkMz8cMACBwj1GAxCergLPR0=
X-Gm-Gg: ASbGncv5V4df+07KdprBWiEHMKtkudYIIrxmovHd/KexKNm6CJYsRnUnsNUdLhfvkHz
	nxiXVZlN/oWBmrx/zN7Xaqm0eqSME2ZLqrhl74+3GWGihFRJn5MHtePa0z053SBDdzOKym6r/Pv
	FL7fTrGATtXrcbkCg6cuqOCKc56EI2/FWGk+86slowwmfnGAfsxiesFvf/6eh7Fw5wMs1CPGBhz
	0qHhOaibjJ9Q91FBrC8HXPT6tYtvk5hI2ARYbSHNa3vA/NQ4wUyfEVMjk5Q976eRrcmbZLlsf51
	S3wTvd0CM3Xu42V3XiyfRhFlpI2ThimDw2Ab/jmJB4clzKOUHhCDrzeTddLRA8lj1CZIBCjhvFR
	++beU5gFk1s9Rjnra8J3hpZLU3LIMF98wZcMSIJcKe/q6rXUbWsYK
X-Google-Smtp-Source: AGHT+IE9LoG3p8nLyIseKLpQcssOqg7w3tMU8M2AmWdPDwMRm5y5MbuuS+ZNv4TcdwiluHmo/FRJ9Q==
X-Received: by 2002:a05:6402:4019:b0:612:bd30:d320 with SMTP id 4fb4d7f45d1cf-612bd30d674mr1047426a12.6.1752819276028;
        Thu, 17 Jul 2025 23:14:36 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c90d671bsm476342a12.73.2025.07.17.23.14.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 23:14:35 -0700 (PDT)
Message-ID: <e461e5ed-f512-4d3b-9903-8092dab7f81d@linaro.org>
Date: Fri, 18 Jul 2025 08:14:33 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/10] Axiado AX3000 SoC and Evaluation Board Support
To: Harshit Shah <hshah@axiado.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Arnd Bergmann <arnd@arndb.de>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Jan Kotas <jank@cadence.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>,
 Michal Simek <michal.simek@amd.com>, =?UTF-8?Q?Przemys=C5=82aw_Gaj?=
 <pgaj@cadence.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Frank Li <Frank.Li@nxp.com>, Boris Brezillon <bbrezillon@kernel.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 "soc@lists.linux.dev" <soc@lists.linux.dev>,
 "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
 "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>
References: <20250703-axiado-ax3000-soc-and-evaluation-board-support-v6-0-cebd810e7e26@axiado.com>
 <b7322d03-2ff9-48a3-bdc6-0e95382ed83f@axiado.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <b7322d03-2ff9-48a3-bdc6-0e95382ed83f@axiado.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 18/07/2025 01:48, Harshit Shah wrote:
> On 7/3/2025 11:20 AM, Harshit Shah wrote:
>> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender and know the content is safe.
>>
>>
>> This patch series adds initial support for the Axiado AX3000 SoC and its
>> evaluation board.
>>
>> The AX3000 is a multi-core system-on-chip featuring four ARM Cortex-A53
>> cores, secure vault, hardware firewall, and AI acceleration engines. This
>> initial support enables basic bring-up of the SoC and evaluation platform
>> with CPU, timer, UART, and I3C functionality.
>>
>> The series begins by adding the "axiado" vendor prefix and compatible
>> strings for the SoC and board. It then introduces the device tree files
>> and minimal ARCH_AXIADO platform support in arm64.
>>
>> Patch breakdown:
>>    - Patch 1 add the vendor prefix entry
>>    - Patch 2 document the SoC and board bindings
>>    - Patch 3 convert cdns,gpio.txt to gpio-cdns.yaml
>>    - Patch 4 add binding for ax3000 gpio controller
>>    - Patch 5 add binding for ax3000 uart controller
>>    - Patch 6 add binding for ax3000 i3c controller
>>    - Patch 7 add Axiado SoC family
>>    - Patch 8 add device tree for the ax3000 & ax3000-evk
>>    - Patch 9 add ARCH_AXIADO in defconfig
>>    - Patch 10 update MAINTAINERS file
> 
> Hi all,
> 
> This patch series was reviewed by Krzysztof, and I am wondering if it’s 
> queued for the next merge window. Thanks in advance!

It's not, unless you received clear notice about it. Please read
maintainer soc profile how to send patches for merging.

Best regards,
Krzysztof
