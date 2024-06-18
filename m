Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F6B7F489
	for <linux-serial@vger.kernel.org>; Tue, 18 Jun 2024 10:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718705976; cv=none; b=NRB74jZwrzfdjGXxV3HqavnlX5mvBVC1dBs7P9xRW750kgX8IZGaM53J1Qt/WV1PSIISxR0YxUZWDiRNWdUMucNBvJ/HUOBWAgxOobqY76dJAZcMuRkmzfv/3Axr4Hd7HtFEAdpfCcj9hpfatL6fIG1/0GDSjBFxR1M4nLzPl5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718705976; c=relaxed/simple;
	bh=FL2m4h63/JYdTiaKJrp9jJf3fm87LLFXYnkOZJlTIJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HeukVoAiVTNIpw+1D8aYto1shat1nCB3nRSiPnn0lIaYBc7IM7nFHIuP/gRcjYAlKJYOgtyFvreRlTKQU4pzUR3Qt6aQa4YwoN4kcyStTPtVl4TgH0Fd+3W73Lpgm+iLAyD9CcchILO4XhNdp6Zv384Sv3BhjmzdGZu21bDYT8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a+Bh1b9h; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a+Bh1b9h"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e724bc46c4so59018311fa.2
        for <linux-serial@vger.kernel.org>; Tue, 18 Jun 2024 03:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718705973; x=1719310773; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dIyeFs4XULhFDZJgfL03OcH28UMXmwHIpiQH/OD/zBg=;
        b=a+Bh1b9hpy5b1kmyC+FI+MyXek99RWTV4cWqOJvzsLBKalCAmVnFLLAUiVQD2549tU
         3mEcUDsPfLZoUgzONuQ9t5uH06nWy04FIHp+YUKZtV8ds+SUHcXAK2TrFye8QIfxUYfX
         NTxr3jE+Nn/07LzDVMbEknkauJJk9Pd5sBAZag6BtrWXWkLBITOfFuGtWSNJAnWSDDLA
         w01WyZ40FGQoHk0IL0bdxjyRuO8dRukNnT4Q5TtkyU5f5TNm0eoovqXh+Oms1MDFgAQa
         JZTtfr1/82F147ErRcGZ+Xhn3ovmC2h7/3aySz1224G5ueDyMa0p56+17WJHKP4gwPla
         BJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718705973; x=1719310773;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dIyeFs4XULhFDZJgfL03OcH28UMXmwHIpiQH/OD/zBg=;
        b=tG/JZsHjMpwnhVIOVC2adfz+mQe+ISI58w0IbUBKTcvhRLytMeXyj6mqhMHb03S2o9
         uh/rlu8WtsfXWs0DwWeoPxzCwiDTE1+YsbG+71/VnZZEb22fVDSCymjQDj+NbYl6KCS9
         i8y6O6eKs98IOgUKcxe5PZ1W02GFt2m8MqMmw+pB4D6FauoMw6STLwFu7oCEBAv5Ry5s
         UrDSagBKJCxku7ypyvMSsCRkXgxLlDOF3OX0FfItz5V/+iDzn8cSHvu+J4dmB2PxR85m
         SmvJyfBWowKfvq44uepifW6BWl4sN9W5XDuYpNvM5pklMIkm2GY5llrSJT/eLoF2muQo
         Z53g==
X-Forwarded-Encrypted: i=1; AJvYcCW6ws0N5jRrHtgAJ+f7mztR7W8uPRTns1SsiKjYDtRFSBTOkgrWSZI3bkwKqK31cl1IHFX1FNun7vlMB+hvE4m/apd67wGAdoTuR1Dh
X-Gm-Message-State: AOJu0YwxSYY7yKFHs5PogDGuE+yVYE+q8ScO4RK5v+Lxkn1xBaaoCL+Y
	1uJqNsCh2rqkKNpsyxlURSgYxavfPXAhvltK3/loQOzLFtQYBDdReunyxEN2BH/V1+wFP9oQW8d
	U
X-Google-Smtp-Source: AGHT+IEiSEe2+WeGXoJd3Xd2iIJeTICulV8Itc/CtPMx/C82PUg6rNZxzqUkmlCMCr0waHh4qMZ6Gg==
X-Received: by 2002:a05:651c:1057:b0:2eb:de2b:940 with SMTP id 38308e7fff4ca-2ec0e6002d6mr73923941fa.41.1718705972634;
        Tue, 18 Jun 2024 03:19:32 -0700 (PDT)
Received: from ?IPV6:2a00:f41:9028:9df3:4fb7:492b:2c94:7283? ([2a00:f41:9028:9df3:4fb7:492b:2c94:7283])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec07d17709sm16507351fa.123.2024.06.18.03.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 03:19:32 -0700 (PDT)
Message-ID: <b384e6d1-0cd5-45ca-b488-1ae2743c10cc@linaro.org>
Date: Tue, 18 Jun 2024 12:19:31 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/8] serial: qcom-geni: Overhaul TX handling to fix
 crashes/hangs
To: Douglas Anderson <dianders@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: Yicong Yang <yangyicong@hisilicon.com>, Tony Lindgren <tony@atomide.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Johan Hovold <johan+linaro@kernel.org>,
 John Ogness <john.ogness@linutronix.de>, linux-arm-msm@vger.kernel.org,
 Bjorn Andersson <andersson@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Stephen Boyd <swboyd@chromium.org>, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Rob Herring <robh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
References: <20240610222515.3023730-1-dianders@chromium.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240610222515.3023730-1-dianders@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/11/24 00:24, Douglas Anderson wrote:
> 
> While trying to reproduce -EBUSY errors that our lab was getting in
> suspend/resume testing, I ended up finding a whole pile of problems
> with the Qualcomm GENI serial driver. I've posted a fix for the -EBUSY
> issue separately [1]. This series is fixing all of the Qualcomm GENI
> problems that I found.
> 
> As far as I can tell most of the problems have been in the Qualcomm
> GENI serial driver since inception, but it can be noted that the
> behavior got worse with the new kfifo changes. Previously when the OS
> took data out of the circular queue we'd just spit stale data onto the
> serial port. Now we'll hard lockup. :-P
> 
> I've tried to break this series up as much as possible to make it
> easier to understand but the final patch is still a lot of change at
> once. Hopefully it's OK.

Tested-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
