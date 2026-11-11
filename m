Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794394130;
	b=i85f21zK+L6oNRYEBEXCwyePihWJJDJaKXF0+e+BpSfCICQI/s7jGDUODma/uAkB3dZ+
	 t7NNw6IVypEbcji+sWD87tZzUmYRdbQhpwwdwfd4KH9MKfoNYHUY76QuJYcP2jR/f0VOJ
	 UEIeejXE79weI9Er0rVKSCDUkJJ6bkrL8dGMyNQfuABvKYO2/K1i9zENevgV3CDVLgaac
	 vjjpZcmGriPm8T4U/uzDTxCkW8DP+XrKZwF0JBG8dzI3RBoIfjQjPHq9BWoGv/sQnBFyD
	 hEjPlHHmwxRpS706jAwK0tiUd56xyRNVNh22gNvb9s/zrV6qVKldOZwxrZ9oyOduDrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794394130;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=SJE8c/dZm+CWhQbZBqBGTdaX2jwL8ZWmvduRU6X8Ew0=;
	b=oa9NzX+XtAOW7bW3IHRDi1ORTa79VfQAk8LdJKatbVyPAA2fGRswrGIhWXB6kVMPFkxQ
	 iLPsxF0EP7vRx5GooKLtY1D/Retl09N5UmaGBaCzLOps45TsR3Fga/T+PqgPNUcHMVTvp
	 Nen7JDTfYrtimEsx06DpqZ+U9JD9q2LpkCTWpAkd/f5AlrY1VZFjatEQUNJ9jNW17oKu0
	 oXCDcqQfaaHCiBiR4cfIPvbM+vcaQd5MSAvFm7vDdwFcmd7UIV8E0yCjjCG7iAiVojPjz
	 gmp5ddu5IE2ccR9EQaVlL0b4IgzqrX2m+mnzESIxAAklkdMPVQIB5X97MWKuaNKnTJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=GBKkvpuR;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4521606A32A
	for <linux-serial@vger.kernel.org>; Wed, 11 Nov 2026 10:48:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4521606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=GBKkvpuR
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48e1d0e5dafso1999360f8f.1
        for <linux-serial@vger.kernel.org>; Wed, 11 Nov 2026 02:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794394128; x=1794998928; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SJE8c/dZm+CWhQbZBqBGTdaX2jwL8ZWmvduRU6X8Ew0=;
        b=GBKkvpuR5r+JH+yFSCx2MRbxX6k1mn+PDhE0+d7qG4hyFMh2NoIazPozMTmQIzj+JD
         9V8o/DugtUDYfrwFdXFHHxGzNFBYTu7e76oRigVpHZa80NBx+zbfSyUnBxDqxg3KoAOA
         I2K6lq0c9BVy7Cbjw4IwNKTP+XHg7DTaHTxQbG5Nh6/cbrNOti3bTUOFGssN6RfM71le
         ijhIsPf9Un9wqeCXlb5W6zgWPLYabiBOKuih/2tp/XV9plgnBLPIiy+2ydMVk2wWH3eO
         jqtcIRFucEU87Lf0iApwLllYGg7Jt9b4puTC3EpxpXWCSs10ncEoku0H26XlqImr5k37
         xJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794394128; x=1794998928;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SJE8c/dZm+CWhQbZBqBGTdaX2jwL8ZWmvduRU6X8Ew0=;
        b=uGN2mcL/pFfUnZBX0PjUHy7mv/NpytDml1XIITgIM+d6hTvAYhotvrOZRH870ue/Tl
         24S1guSSPGpGuI+QzjjC9fbTjIGc8Be7MGCMlWURluzOOrD8Q7IHIpPgE+/eSoqVpLZT
         SWYhCWp1Hkk+H/+BJWvQcafD6ER26qMqvJmAmUIY8Gx0qfopmoNRxD7S8oxdOR5KnTSx
         nGX7CyPfN8mbr2P5pi8MfCUGLRbO8ZeOUpQFw0fsFKDN+x8Oz4oUSRSv2tv7En2sn01w
         quSl2KXSZb97+ka/pfl/DXQssNQ9OgMD2lL6GpeMZJ4r6gb+4hf1UArTNtSFz6jXG1SU
         zwzA==
X-Forwarded-Encrypted: i=1; AL+hErGP6CAqaZrX3zGM1Pt0hDOmcRBTQGtoOul7YnrR1epGZOK43JUhwT2zDM0fWArWn5wsXV+n6+fHRngBNug=@vger.kernel.org
X-Gm-Message-State: APuU4Z9YVxoR+SGnGOw+SWAWvrVVxeoVMrGINSl5QpBLlPk855/MYx7P
	2yxhu/LhpZbnsyCPm284sYp+1atfLmU7cuOxX390noOpFweilq1l4KH3L5CIVpslpuU=
X-Gm-Gg: AYBFou0kdVQsxoyAbQ6C8EgyNQ70D6QvLHBmSKYWY8iXwv6RgbaRRALUqF27m4uj+rz
	Bh9wYrxB1OkXEsCS+dxuQITpE7oQRQ6v2uplCwjvpe6OrvxLBZ+i6cKz/8nhrK1qHVfD3scKOXW
	o33GOhimekfYWP8U3mTuL21cal2sFc2EO7bMFgBI68W9dhJ2H1RcENj98bCDkdtwjwUdO4XzKAO
	YgbupxXIna8tVNL096tHuPaHIXWESgY4LEdkdbZLw0JB+iXCG+q6tO7vQ8vQYoEnVdg0l2Gy4SY
	hN0MqvQPpn9CFUDDAxETXcZgiFAOi8bX2N83zwet9kjL2OikCXRIEHc3Ebk44OqX1XREhLJRIjY
	qF4KgTdSaGlUs2tEYg2aapJQVTPWTtfvWiKiLJM5MzffqkJKhHcI3UWkxuGXeoZ9Mwt+vAJU4y1
	kdP8chA1tH28WoUPVtZSpl8rQgVwe0HlYtlj1egDFPNKHiJBLi9Df/WFTa1pCFCzEj0AWWfLpOu
	vkdJlBlJfSzwwHwCLANLVyuga3SNElVtI7X9u5qGpzjTB/mf1t9glOvnX0+HIiCjz6vOcfeqmc+
	bP21Ls7twYIEB+L946YxkDC3fk9smtMVJKWyjy0xSAr5IJKwvXi/6kLAcchsBw7siA==
X-Received: by 2002:a05:600c:1f93:b0:4a0:20b4:ba93 with SMTP id 5b1f17b1804b1-4ba0938124fmr41926975e9.16.1794394127955;
        Wed, 11 Nov 2026 02:48:47 -0800 (PST)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0951fe22sm54693255e9.3.2026.11.11.02.48.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 02:48:47 -0800 (PST)
Message-ID: <2e392c2b-3fde-42fd-82e0-8130d2de48d2@suse.com>
Date: Wed, 11 Nov 2026 11:48:45 +0100
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
To: Jani Nikula <jani.nikula@linux.intel.com>
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
 <a190f981-d668-4208-8148-f4e50adb31a6@suse.com>
 <6c00fc009f4e61e87895eb2dd3d77c5dfb28183d@intel.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <6c00fc009f4e61e87895eb2dd3d77c5dfb28183d@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/9/26 7:07 PM, Jani Nikula wrote:
> On Mon, 09 Nov 2026, Petr Pavlu <petr.pavlu@suse.com> wrote:
>> On 10/14/26 11:36 AM, Petr Pavlu wrote:
>>> On 10/2/26 10:31 AM, Petr Pavlu wrote:
>>>> __MODULE_STRING() has been an alias for __stringify() since "[PATCH]
>>>> MODULE_PARM support for older modules" [1] in 2002-12. That change also
>>>> moved it to the graveyard section at the end of linux/module.h
>>>>
>>>> Replace the remaining uses of __MODULE_STRING() with __stringify() and
>>>> remove the macro.
>>>>
>>>> Apologies for the wide distribution. Acked-bys are appreciated.
>>>>
>>>> [1] https://git.kernel.org/tglx/history/c/136839a1b4
>>>
>>> I've queued the second patch ("drivers: Replace __MODULE_STRING() with
>>> __stringify()") on modules-next for v7.4-rc1. Thanks for the Acked-byes
>>> and reviews.
>>>
>>> The first patch ("hwmon: Replace __MODULE_STRING() with __stringify()")
>>> should go through the hwmon tree. Once these changes are in mainline,
>>> I plan to pick up the final patch ("module: Remove obsolete
>>> __MODULE_STRING()").
>>
>> v7.4-rc1 no longer contains any __MODULE_STRING() calls, so I've queued
>> the final removal in patch 3 on modules-next for 7.5-rc1.
> 
> Perhaps send it for v7.4-rc3 to prevent *new* __MODULE_STRING() users
> from cropping up between now and v7.5-rc1?
If I need to send an earlier pull request for the module loader, I'll
include this patch as well.

-- Petr
