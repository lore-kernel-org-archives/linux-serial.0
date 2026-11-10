Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794304483;
	b=C66r7GUoDms2T6oVKsz01vxD0odX3RIHtNKC/nvvHm2nBwWbvVgLjPVo//4wSVBED5/m
	 A4F1bG+HLitgvPflYjIqM4MFJgiHoKo7wiNWk8QRBpLPat625aQZJLiKIPTSEDTZ6fQ8s
	 Dh7osIANij3H6R+CBOlCSqeUlHM6ghUOhGoo64QZOy7Ug2FOvtnn+2d5Rid1lFp4fTMPw
	 hDCnXCsI/PKyBxMhMxaMDEd8CKfz4hrkWurZWDGFqNVn6DCtNgwBS4liAtsbv1lYPy8+V
	 rVh/Ycb2VROrF/DXVwSqck/753JUnGZhiiL25FKQZelhHq2JFqTKO8+R8xkkZb36o/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794304483;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=XoornKh9z5jpJH7j8+EuQEpUcX1Rogb6YE7C2nngtQ0=;
	b=wcPXhy5s6WTf6zetnM8zlGyKWIprwrEqJwWRIR5JyX99nQXU4+qztjkptooJePMHc4+T
	 ACmHnnEppdaoamIOO/+JmGn0foJRdY7fcaLKRugytFU3pzbSh9Zn/a9iXnmTTisu6MwrM
	 rWbnFKf4U/65C+IA47B+kOtnxQzrEn2Wb+8/stkOaDeLjUP6UgTX7b1o/RUgeb9NtZn5T
	 EUrFreR6VuHeYYgUKMX+Kb3caqkW71BhA91TUE6ysWzF32SOwH/CP1hCJc5w6E1V0uJc6
	 llf7Aq62JWIyb3T2OxpJQ+N+Y/WuTre8NVVkar4nrMi+Ejz5gvCU10U5beNrHDxkaiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CldSljc2;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0D3606A321
	for <linux-serial@vger.kernel.org>; Tue, 10 Nov 2026 09:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D0D3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CldSljc2
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso19245495e9.1
        for <linux-serial@vger.kernel.org>; Tue, 10 Nov 2026 01:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794304481; x=1794909281; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XoornKh9z5jpJH7j8+EuQEpUcX1Rogb6YE7C2nngtQ0=;
        b=CldSljc2YDB1K8RmxJDeFZjd2LVdS9NaIH4OGfpHmMJoctX3GM5a9xvVKV4saZJWu/
         BWGeGNMj6H2n24m0+PY0cdqD7OSFs20lSGZGBRMLMCh8mRBiiSvJFyhpvCmkDsMH5g9N
         tqiu3KwHxHqtctw5+o+K2gERzbelRMd2UvmNhuvC4mt+nC7t+U2nYGTfkVTRHlWfOQU4
         TmHYxhwruyXtOIEsbu9VYPvrPi4iEJkKJhr4CMe1GgKcmGSxTJEAUcJOdxK0wttfKSAc
         NqujhOFc14aMK+XJ+iA2tuRJkUBDtt63tBeySZ4zeBV+eOrAPGw9l0AdctTGmK57HUXm
         PG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794304481; x=1794909281;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XoornKh9z5jpJH7j8+EuQEpUcX1Rogb6YE7C2nngtQ0=;
        b=nCO9JyLBGrGyot7l/69j8h6FrSetIRoP0tJUBPA0ZdZiZGzKwWDaIq03IL4tQQ0dqd
         JXVGPyM/01BQIJqLTGFyuO3MFy031nwPWHloMfhwGZOjWDay7r8gEMAwehizWgVpVOSN
         sKMcaaKm8Gt8mEOQ+VVevj3J4PgoQJiNaeMF2kTmS1AmbVBhCz+OUIyVfd1EB2locjdo
         k7T860GKxxf/bCpU0i8VmW2cdtVUXgPwRdTwpVcGL3sPPDlk2HMdMQpnqJLYx3PQQsfN
         oYN1lTYoEeAz7hMh3Ze/ddAYwzAVSLqgeq7OPoO+GwTKbv+SdjfzPOCFcg9KvImPOnbK
         SwEw==
X-Forwarded-Encrypted: i=1; AL+hErF2cA/PF/WorLXqOETzhJ4B7IjA+YUP6ed1tZoM1JRQZDodeeXseRuLTJLHTRfzYYAYPtUepvuHD8tHuG8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/b/S4H3VpF63NGvhEOEYtIKqaP/7kq7loLYkobxzbcuY5HKogx
	hNWTD/AxQvxwM8WaaTdwobHiEv4vbI24+d4cOpXNNr2nbqbgL848906u
X-Gm-Gg: AYBFou3gvh/SWOF3HZ7dXah5ZhAQuWXZJBEX56+BOQd1DECZ5HK0KUsBsVGpCC87X2K
	gs3NvoyURXierofK0NnrR837dm6ShH5BhFgmrrvGKtjyPVuUut/wAKMnsVbZpPhpipKHkKTo9FL
	tOyXU1vEM2CKoOrtJgsKbLBc3WTdhdcOZPJdgs20b9myxXyc4fuqO/DayJRlC+n+6LLx7YLFD7P
	JCC3jOvkoJVvGFOXeLnI63dZbnbItM6rhQVBtTStwtPwVHySP/WxEapr1IfK58zLsOi2q/N2jvI
	5eLNMHHa8bhNlvNifFRyp8urVrQeQh4364YtdoTdPgUE/r/9usz+JQ6HvQYaUODdBqmT3RZZC/4
	k2bIUkTStHYAFIZxbkBIwxhIq3kyNwPhAmj1Z0B2nsLlwJJOZ8YsRR5/qUA7GwqS+5K961D+jaP
	cFGJAaJ2Xr3ojfHaAj6E7as7w5KQvJV72F/YS59yHrZrSWpQQfk7fjN4o79Ky46z3lgYipPEm0u
	0Fb0GD6JkVKZarph/twXh+fkyfUj2c59tOrOZHiCiqQnE/isNqN6c0/S6llnedq7a25qQS01J3o
	f7hXUHv7cy4iF8HciO1+igNgWB3QT8vBWHatTCW1eR+7PnqqqMxDiQZdOeDQz4MG4qFUdrILcnL
	fpP9Qtg==
X-Received: by 2002:a05:600c:4f4b:b0:4b1:32c8:27db with SMTP id 5b1f17b1804b1-4ba0234bd12mr43740995e9.22.1794304480565;
        Tue, 10 Nov 2026 01:54:40 -0800 (PST)
Received: from ?IPV6:2a02:e98:40:8091:e8d5:38f4:f7b3:6dbc? ([2a02:e98:40:8091:e8d5:38f4:f7b3:6dbc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0204e22csm48483805e9.12.2026.11.10.01.54.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 01:54:40 -0800 (PST)
Message-ID: <873c22a2-fd3f-4927-a06f-16a73c30de86@gmail.com>
Date: Tue, 10 Nov 2026 10:54:40 +0100
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/11] serial: 8250_dw: share RX trigger setup and
 describe Allwinner UARTs
To: James Hilliard <james.hilliard1@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20261105-submit-h616-uart-fifo-v1-v8-0-14024d2b184b@gmail.com>
Content-Language: cs, en-US
From: =?UTF-8?B?S3J5xaF0b2YgxIxlcm7DvQ==?= <cleverline1mc@gmail.com>
In-Reply-To: <20261105-submit-h616-uart-fifo-v1-v8-0-14024d2b184b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

> Based on tty-next at 6628e7d4c6b2 with the posted RX trigger callback-lifetime
> fix [0] and DW BUSY-safe divisor fix v4 [1]. Platform setup runs before
> installing the BUSY-safe divisor setter.
> 
> [0] https://lore.kernel.org/r/20261024-submit-serial-8250-rxtrig-lifetime-v1-v1-1-731b78d5003d@gmail.com
> [1] https://lore.kernel.org/r/20261027-submit-serial-8250-dw-divisor-v1-v4-1-41714a75e15a@gmail.com
Hello,
thanks for the work, I wanted to upstream my changes [0], but got 
redirected here instead. This fixes the issues I have had in a better way.
I have tested the whole series, so I reply to the cover letter, didn't 
make sense to me to reply to all messages with tested by, but I am not 
sure if that is the right way.

Tested on Unipi G110 controllers (Rockchip RK3328, CPR-described
64-byte FIFOs, ttyS1 and ttyS2) on top of tty-next 6628e7d4c6b2 with
the two prerequisites. rx_trig_bytes now reports 32 instead of 8 by
default, and 1/16/32/62 select the matching hardware levels, checked by
chunk sizes in internal loopback and over a real RS-485 bus between the
two ports at 9600 and 115200 baud. Changing the level mid-transfer
kept all data, and the level survives termios changes and is kept when
set while the port is closed.

Tested-by: Kryštof Černý <cleverline1mc@gmail.com> # RK3328

[0] 
https://lore.kernel.org/all/20261109-8250-select-u6-64bit-v1-0-04bc8332fa34@gmail.com/
