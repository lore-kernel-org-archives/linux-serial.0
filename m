Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239514;
	b=E3FZO6eIw0zCDdtEZP3Jt95VAnAEyZyeRvBNjRUQ/Y+c9bbKn5ZMLIkZd081jSjGxEC0
	 ZydF9hGRqLlHauwe41bjmpNsl3UydhcMCEhIFvX1uB+5SvA8dmxPvGDLmDLTZb5NDV38R
	 M1fFl8Btop3R9WfLh1hRHWw2MJxVMdJwA9+YC1WXff+PB8BmnNLc3eUPK8wzFjakqJNyk
	 AR54hbkzu3G7zOFN/RNAYVrqfAv3xYmkqwv6HT2wBEuz4/GqHRvGse0ru5mu0ryYm/axQ
	 7asStaUWAHWFrtUjoDh7ahJ7uUwZ2JbNS3zsuIpIpzx6Cj6unx+puQKvn9jILA7FyWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239514;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Cc:References:
	 Content-Language:To:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=GqcUVOE8YZm1FPDzDze4+rCKgn8rK0xiBVztztTok30=;
	b=B1nCqHICzR6tKEmYPREV4J7N07JvgwR5coaEvE/TxZBbn2k5hCGclhPGpveHNkFYBaTs
	 dKkurWX4An0FV1gCkXqfpV9EqcAVAKMPiRun+kaKgZmsMnPfMrLOdVuB/hqQeS8Vtzf0X
	 WiqiZcq/aXOkl6W8y7VSHa+RHwYGkrSyhRoF+JzzHHisrOmuurUdRPwBBD2IAS8MBqYR5
	 1V8uLkqclzW838VtVFn/F8BUVW5E3Jd/b5AY13ZEmmgnQLfcypPnBucc1QP4GJKZelFVi
	 BMijbViYhjnNduHCVIciEuZOdX02L/bBPCrlAt8OZL/QrDCVd9C5xfuRvNparXmE1Rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=I6Gf+TJ+;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0325606A31C
	for <linux-serial@vger.kernel.org>; Mon,  9 Nov 2026 15:51:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0325606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=I6Gf+TJ+
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48e3b22e971so563439f8f.0
        for <linux-serial@vger.kernel.org>; Mon, 09 Nov 2026 07:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794239511; x=1794844311; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:to
         :content-language:references:cc:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GqcUVOE8YZm1FPDzDze4+rCKgn8rK0xiBVztztTok30=;
        b=I6Gf+TJ+xx28C6M6wGa7IriJIxP64CATq5xKa5KY4/dVEF70L68u8oNbC3qDhkhEI7
         7ia14iP5TbkPq0pUWtgTMNnR57unFzAtVelBZ6VlJdQ4CrgVYgxw4RobiXpnUn7hkB+D
         nzTyACD0+MFjBaqWPAWXlFUgKFrj/LJmZ6fQQvFA0wYX9Z+YdDx7xP/wSzXM8J7jhI3Y
         cnv1opUi8bNDC5CGiUC5RyhE5sufSwg94ps4g0+w/MIT3GHEM+nHtCTD6yBD+zcjVMzC
         KM6SnUFC/LBhWAJoh5/3RAr1pEMN+dTTDdPPEWzL92kIaF0QNP3pX9QYFDhi6xIlcLq5
         xWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794239511; x=1794844311;
        h=content-transfer-encoding:content-type:in-reply-to:from:to
         :content-language:references:cc:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GqcUVOE8YZm1FPDzDze4+rCKgn8rK0xiBVztztTok30=;
        b=byJGk+qkml/YRoHshqTQNSY8kImABqNrUoALR2uvghl8ViEH6KCnT439cVh87U5eo+
         WziJc5Y45oT7pi0qjE74xkpgNKruh+UnxOfxZ5UgdYkZFqxrdnx3iktGoSCDn2sUraxb
         TAI8MnTdjjPtYw2kda7KpCQF4cFXPIsOjTK5FZGoR1QQrRKFy/5Y7z/YW3adXT7ozqJf
         2f/ub/YQExO4bHLIMZhhWe5BkxNF7urT2srryDs5ZSh1tJHWH6wTNO+caKFBxJhZK3i3
         xYrxNDYU5r++T7/Wut30VMMKVePOoe/jeLvSMke1XwZewZLVirFMdVDe9oHE/yF30zEu
         OpkA==
X-Forwarded-Encrypted: i=1; AL+hErGgFF/66hqGLl9rjwbrfgz+ShuYzFcATieYHsdXhuY1d9n/mUvcAk9zhpQLVqOZpgY0ZG0WUPOuqDrfpDI=@vger.kernel.org
X-Gm-Message-State: APuU4Z985/NEFytXH/AJc1/z732uqp8s5uleMRupWl8xhqDyP5DRXzgU
	raAwDMNrXHb4jAOVClKz+iLG3b/IicZDpCkGDGDcopnfwKrbiiqndPJK0NtR/F0Ncis=
X-Gm-Gg: AYBFou0HzwvdXc96p+jif1pTzd75cpaLSRdTsLxCq5pWHBgx1EevFlERRvfa0TOTghF
	jSD+IS/sIYtD47tc1HttmliDzSP/6dZBrqomlZwkZq5eRws94+pQHjjTDi9WnJ8fdfhP27kiLwe
	LaGL2w2LUEkechdUS8ugORKu5p+OXh0/i4Zjp67Rp/CUPSJsMQs0ZSXHFbNVrNy6Yo4XIiRaoIm
	ykUQm66VA/NtKyOW4y1eFlfyVFrKPKAo5U3cgP0BPI5fQ7rxNtXl+jsQUr8Pzh94vucO8g2QYZ/
	bwrxgFw33CSpaqs1SU7maOo+BQMaV6pMv4KPmueXMrSqgT5jJaNQZK5EGEwJoIfpq4jp6U8qMyx
	9kN+oE/nbbuSEEzYEoFHlCv2JVhPaQtas7+gOBxqENnpFJfIBRTVHd17kZruZIlcHJKIaqQpVo4
	X4VDlA90nvPK25+pGB7FQmBjQW2H5r3pSUURbUFzn83ExpPJklsbuaiH+IOpNNoTgI9haqaKs97
	Anfv7yp+7H/TGFdTr709wL5+WFPLgcg5lwTO1/WNTyJWVHGeJpn61k8IVwG/e696LPVUqznhsCg
	rmHcQYPnV4ZStwz/ZmxKAoIo75kX4znRyWvlQH8HogDppaiVKi2zcdNtyBkJQBdg
X-Received: by 2002:a05:6000:25f5:b0:492:e1a6:90eb with SMTP id ffacd0b85a97d-49582e8e516mr8245452f8f.10.1794239511204;
        Mon, 09 Nov 2026 07:51:51 -0800 (PST)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49597186eb9sm10435718f8f.35.2026.11.09.07.51.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 07:51:50 -0800 (PST)
Message-ID: <a190f981-d668-4208-8148-f4e50adb31a6@suse.com>
Date: Mon, 9 Nov 2026 16:51:48 +0100
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
Subject: Re: [PATCH v2 0/3] Remove obsolete __MODULE_STRING()
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, Ian Abbott <abbotti@mev.co.uk>,
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rudolf Marek <r.marek@assembler.cz>, Andi Shyti <andi.shyti@kernel.org>,
 Chris Snook <chris.snook@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Andreas Noever <andreas.noever@gmail.com>,
 Mika Westerberg <westeri@kernel.org>, Yehezkel Bernat
 <YehezkelShB@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Duncan Sands <duncan.sands@free.fr>,
 Chas Williams <3chas3@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-watchdog@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261002-module-string-v2-0-fc7438acaf4d@suse.com>
 <2e88806e-57dd-47e0-a9ef-a8507d22aa3e@suse.com>
Content-Language: en-US
To: Petr Pavlu <petr.pavlu@suse.com>
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <2e88806e-57dd-47e0-a9ef-a8507d22aa3e@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/14/26 11:36 AM, Petr Pavlu wrote:
> On 10/2/26 10:31 AM, Petr Pavlu wrote:
>> __MODULE_STRING() has been an alias for __stringify() since "[PATCH]
>> MODULE_PARM support for older modules" [1] in 2002-12. That change also
>> moved it to the graveyard section at the end of linux/module.h
>>
>> Replace the remaining uses of __MODULE_STRING() with __stringify() and
>> remove the macro.
>>
>> Apologies for the wide distribution. Acked-bys are appreciated.
>>
>> [1] https://git.kernel.org/tglx/history/c/136839a1b4
> 
> I've queued the second patch ("drivers: Replace __MODULE_STRING() with
> __stringify()") on modules-next for v7.4-rc1. Thanks for the Acked-byes
> and reviews.
> 
> The first patch ("hwmon: Replace __MODULE_STRING() with __stringify()")
> should go through the hwmon tree. Once these changes are in mainline,
> I plan to pick up the final patch ("module: Remove obsolete
> __MODULE_STRING()").

v7.4-rc1 no longer contains any __MODULE_STRING() calls, so I've queued
the final removal in patch 3 on modules-next for 7.5-rc1.

-- Petr
