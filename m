Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3E730AAC3
	for <linux-serial@vger.kernel.org>; Fri,  4 Jul 2025 13:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751637075; cv=none; b=p3cGMidKxDdPMtB+aaZF8fH/4ycucDKywrM1ygclcZw96f8nYQXkm2NWomvUiN8fve6b+sZDeIkQjFW+W6dO2NdvQpbiJoHqUAnXMF7BzOpfthM5gb+wEsb+a4Ccwzc1Tcmzr224xyV506vVCeuYYJ6iEn+CqHT2uU7KF/jQpcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751637075; c=relaxed/simple;
	bh=miC47NO9VePQREntYQ2C1ptH1JHrH445C2mxs1mptSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CMQnuctddJVUcPuyDYxMGkvsTazycXygAaY+uQnsAnWsbYiPPr/UjgRAHbTHCt+d3B9U4zyEpsS4puol0DqkfzK8FLG3pjbDuf2xySByr8TFKEC4gN33B40JRVk7nsx1GOHWz/VT+94VfriWOuQhRzmxYHwDoNAbV0DhCpvveKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=qRfmkpVD; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="qRfmkpVD"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae3a604b43bso160529966b.0
        for <linux-serial@vger.kernel.org>; Fri, 04 Jul 2025 06:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1751637071; x=1752241871; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U+4pnbmOXAdM0mHM7kF6SCf+HmJcVo3mHL3EXrsTmvo=;
        b=qRfmkpVD+xI+Npzbq1OPbfQdUTJO8vOQ9eX5GxigJa2Tqop1BOwVlQj/S9qRHzx5ty
         viijJo0m9xgO15vGt3QzdtbbE6rX+kxUIf0SNjmKTWN7qsD9gzGXGHe8h/CxP8CoVAsJ
         00dZtJsEQcSkR1yUpcFoxzwhyoSBPCtnHkiH7pz1pJKL4qKLN2dO55QZKACEisQXU1Gs
         8cD0wWE1yYcbGiZRGvbY8OXL+JEzvXr/u3E7dDPab3pA1b6ir403KnL3zfp0tKgftnVm
         C+18Q4E3kv2QP2/PxCrpcfMR1vC5fKkh00Rw/74AUPiotlD/MJ8bM0BoV7i5Hepz2DNo
         icuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751637071; x=1752241871;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U+4pnbmOXAdM0mHM7kF6SCf+HmJcVo3mHL3EXrsTmvo=;
        b=NOI3kSWNJEYpHqQtgUhWT0zwIi3Dwtls9yEu48o/hgRlPsHc4o70rBMiwJAq4EAsxI
         W9g2eb7J2ucU4uyp53x6jCCSkh+to5cvokTSmYII/UdY1AlSqukUF9n12xv3CsoJcnGf
         v+IyvKBdbG49yeX4//B6zUbHGO7cAqV3hzJkvq40z5nFxL2XJBRcag5c4e/AlkMlfAIF
         KQ6u69v4rdxjQEC1Kn0hETN2ipCKk43S5oCIjfLVFednFqcU4L5Mc6dB6MOx9Nd4qpzE
         o9sEbjZcaH68ogGuO5ulhrV6lSSk0NXDjXh9Jq93Nf+Mpr+/aLZWL7mGNqc/Yo2CdB/+
         sd1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXWMvl9z5PZwUIRxnhJZBIj1ZDob2FCmMW05OZYg6VrilQ0WMHK9WqMIW5Sp+o+nuAgqAxIGzhVFrijLfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+ltTMs+vb7mdFFbaXybQYqy4O1y4fni7y6Jb8iVOps/dpVoNs
	rukox3M9A7jLso04YwLb8/xVMcxl3nAJshVsb7160P00ZVzffiUcQHcDyenYIz9Zkn8=
X-Gm-Gg: ASbGnctvTjSXcFCYemrgLDeq4o8Vh4nmrK01O83i+fruwW1KFbaY4Ohphnj5NXp6M6o
	YJnHOzCoLOPeMPPql4PWg3uG4zeAVfUwCWV4S0vFZmKo4SBF9y19wRDyLvMxreHmoU7NK1T+gvG
	81mPgHcdEPsR7g3vuMF9ryeqxNY2BpIDmE0OHJZJwF0ofUDCag2hLRd0j0TCWCkzNtJUpWq7CKM
	OM9R+0SH1AxdNBskLd9AAlxW3XWcPgNnOVKBOlbExU9EcWbJyO6Vzb3aYCiAzhAptjZTjCyPdOh
	sTaAXO/yZ7XYwHE1BnVfBQjL05VU9iV1ABre6FmQH9buzLIxT3CpfVs0XHEtD4ypLJ11rQ==
X-Google-Smtp-Source: AGHT+IEKaHL8J9Su0mB3XI0LmZS3jYa1Tv+ttRwStxrwJ7gZXvWH4fgHU4a56M1/TXoMiu+j5EZrtA==
X-Received: by 2002:a17:907:6d26:b0:ae3:6cc8:e426 with SMTP id a640c23a62f3a-ae3fbc336f7mr270116966b.9.1751637071005;
        Fri, 04 Jul 2025 06:51:11 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.83])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f692ecacsm179199366b.57.2025.07.04.06.51.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 06:51:10 -0700 (PDT)
Message-ID: <930cf8e2-5716-4a36-8238-e573876db869@tuxon.dev>
Date: Fri, 4 Jul 2025 16:51:06 +0300
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] PM: domains: Detach on device_unbind_cleanup()
To: Ulf Hansson <ulf.hansson@linaro.org>, rafael@kernel.org
Cc: linux@armlinux.org.uk, gregkh@linuxfoundation.org,
 david.m.ertman@intel.com, ira.weiny@intel.com, leon@kernel.org,
 dakr@kernel.org, len.brown@intel.com, pavel@kernel.org,
 andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, wsa+renesas@sang-engineering.com,
 mathieu.poirier@linaro.org, vkoul@kernel.org,
 yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
 broonie@kernel.org, robh@kernel.org, jirislaby@kernel.org,
 saravanak@google.com, jic23@kernel.org, dmitry.torokhov@gmail.com,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-serial@vger.kernel.org,
 bhelgaas@google.com, geert@linux-m68k.org, linux-iio@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, fabrizio.castro.jz@renesas.com,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20250703112708.1621607-1-claudiu.beznea.uj@bp.renesas.com>
 <CAPDyKFoznqfdX7Dvu3VPa5Me10VHGphnRRHrU17w-fie7HrQ5g@mail.gmail.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <CAPDyKFoznqfdX7Dvu3VPa5Me10VHGphnRRHrU17w-fie7HrQ5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Ulf,

On 04.07.2025 14:15, Ulf Hansson wrote:
> On Thu, 3 Jul 2025 at 13:27, Claudiu <claudiu.beznea@tuxon.dev> wrote:
>>
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Hi,
>>
>> Series drops the dev_pm_domain_detach() from platform bus remove and
>> adds it in device_unbind_cleanup() to avoid runtime resumming the device
>> after it was detached from its PM domain.
>>
>> Please provide your feedback.
>>
>> Thank you,
>> Claudiu
>>
>> Changes in v5:
>> - added PD_FLAG_ATTACH_POWER_ON, PD_FLAG_DETACH_POWER_OFF;
>>   due to this a new patch was introduced
>>   "PM: domains: Add flags to specify power on attach/detach"
>>
>> Changes in v4:
>> - added a flag in dev_pm_info that is saved in dev_pm_domain_attach()
>>   and used in device_unbind_cleanup()
>>
>> Changes in v3:
>> - add devm_pm_domain_attach()
>>
>> Changes in v2:
>> - dropped the devres group open/close approach and use
>>   devm_pm_domain_attach()
>> - adjusted patch description to reflect the new approach
>>
>>
>> Claudiu Beznea (3):
>>   PM: domains: Add flags to specify power on attach/detach
>>   PM: domains: Detach on device_unbind_cleanup()
>>   driver core: platform: Drop dev_pm_domain_detach() call
>>
>>  drivers/amba/bus.c                       |  4 ++--
>>  drivers/base/auxiliary.c                 |  2 +-
>>  drivers/base/dd.c                        |  2 ++
>>  drivers/base/platform.c                  |  9 +++------
>>  drivers/base/power/common.c              |  9 ++++++---
>>  drivers/clk/qcom/apcs-sdx55.c            |  2 +-
>>  drivers/gpu/drm/display/drm_dp_aux_bus.c |  2 +-
>>  drivers/i2c/i2c-core-base.c              |  2 +-
>>  drivers/mmc/core/sdio_bus.c              |  2 +-
>>  drivers/rpmsg/rpmsg_core.c               |  2 +-
>>  drivers/soundwire/bus_type.c             |  2 +-
>>  drivers/spi/spi.c                        |  2 +-
>>  drivers/tty/serdev/core.c                |  2 +-
>>  include/linux/pm.h                       |  1 +
>>  include/linux/pm_domain.h                | 10 ++++++++--
>>  15 files changed, 31 insertions(+), 22 deletions(-)
>>
>> --
>> 2.43.0
>>
> 
> The series looks good to me, please add:
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Rafael, do you intend to pick this via your tree?
> 
> Another note, the similar thing that is being done in patch3 from the
> platform bus, is needed for other buses too (at least the amba bus for
> sure). Claudiu, are you planning to do that as a step on top - or are
> you expecting others to help out?

My plan was to take care of it once the approach here (or something
similar, if any) will end up in a release.

Thank you,
Claudiu

> 
> Kind regards
> Uffe

