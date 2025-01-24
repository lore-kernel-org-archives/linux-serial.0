Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906B8157485
	for <linux-serial@vger.kernel.org>; Fri, 24 Jan 2025 15:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737734135; cv=none; b=ZE0uu2EiX4GRI2BEaQOdP7K4vGCKb40aCe7ZcSVZPPgQC2lxTtHFNpCJYcEkBVJTw4cSAV3/LLoapwEmWmloc7q0KKDL+F5Tsn+qplX6+ug0b6z+VIzxkXNZem8l0ZsG/5zSHoY91Qh1S5oZcqkynNYukLGy0yjXwV3HDS1JoQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737734135; c=relaxed/simple;
	bh=s/jO4NPWKOieyxzi6luyHh+P5ju9zoKIC7bH0SB8o4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R8AGUFHKTvZcjryVQY9grTuDtjf02uylwp0RWfgprZvG7+th+WzEjbKGWeQRy8YoDoW6HRgb4imk0PA440/fdryOV5knyxSWD/UOzGby5AFs0gMTHSFQZhKd9Z24Ec6RYmzytdEWhmwrsYoy/NlY/1yJAZsPRmil3sNf2HRTfQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s7zZ3quV; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s7zZ3quV"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e5447fae695so4077408276.2
        for <linux-serial@vger.kernel.org>; Fri, 24 Jan 2025 07:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737734131; x=1738338931; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ilPZPULNnLI6UK/uv5dVV+2Dss3A/uBmwkDVQdaY3K0=;
        b=s7zZ3quV6sSGQi23hJ8dEM4EP7tlS0VnAiaxBv3lK2wpY8qVBS+nv0u+LtSgG3zm7a
         3jC/AeebNiMJTjl0CVRjs0C+ZCprv/VSwLRNaAB+dBzP91o0J1unli1foSINTUIjCnrN
         WHlsm/odmDIZNdqV4J+p6YtC9wuZ+t6FP+ZlBqLaLju/eWO3BGhQmaL8HMcSn3NxA5uM
         wozOiTvrTWMH9N0FeRUT9N3m3ZjyqmTfRJlH4vvuzIdATqdDi3VjBVvW1VdVijcrWkOK
         N5FZhjLj2bhGl8EF8f1n+WVssM5PB9NIxCkKwnRfCaN37YqkH2LBT4uq39WZsLnGIbfF
         Dgpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737734131; x=1738338931;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ilPZPULNnLI6UK/uv5dVV+2Dss3A/uBmwkDVQdaY3K0=;
        b=kKD6fGRm1nXS8oYyX63PdjgCueQLswHtViUdufWuSTRXFlrzYgtR+MNhvLiw1s9QJS
         Cu+u+GoOcyT9vtlsllnrOZqB6UcSt5/ZlURJXxTv+g860wbMZA47TKxVgpmGaxyO4xxW
         Lyhs34pR6WMkKYL7Ho37/R9gImqikP2UlRN1nztnZojFhF5ITGe52N+lcphEXDlMxxRp
         F9FkQfUQewH0UFiuyvYYzYyiVmUO7qhc5y/8BiokBRpFwWttwG83XVu8Sr4q/pjvz1/5
         gd1LDkPEB6euKY6XDpj04wA//KOIErGAiVyKq+MZoXNDv+roqbAmLQXaYSFw7FEBqvIP
         +T2A==
X-Forwarded-Encrypted: i=1; AJvYcCUL8s2S34ga4T9WevducKcc73j6tupiK8IIyfVsrzvEEEljoYvWBnTByQwQjWXu4M6y2z1auw14oiPUrVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzlbwyZSQGHpGS0zAajyrXeffQMZ/7V3KjbbUujH/c3LfjhqcY
	QIZXUlKpYOsGPzJ4CfJHcHzUZGuQHbCxFae7hF3+3Ww7LPeeLWGPhLB8hMsb+Zkh84wwIPvRQz5
	Lq+P1K8I7fFgx35zaQ6axsNPplhJBfuRigRqolQ==
X-Gm-Gg: ASbGncscbmDd9veotvHqrjT+OduDPvtUUiZU6ugYUhfLKcqMl2S8VPokurjgW9VJEnU
	MkbAujUwdadbPEOX6xCzyhbxTy4Sfq/f0Ifv8VrXNn8MOiKQaekxOBZfhOuEhsn+Eh9EL/o9weG
	1lH8TUC4jl8P233Q8rHg==
X-Google-Smtp-Source: AGHT+IE5CrP20lwY9b957F+q8FfX4UrWyqpcD5u1RzqaZ3UIpMjXmbJiX0igSbAvphxXL+FBMTlukLRROvc9N2dsUB8=
X-Received: by 2002:a05:690c:3701:b0:6f6:d4bf:d01a with SMTP id
 00721157ae682-6f6eb940fb8mr246220177b3.34.1737734131503; Fri, 24 Jan 2025
 07:55:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250124105309.295769-1-quic_vdadhani@quicinc.com>
 <20250124105309.295769-7-quic_vdadhani@quicinc.com> <d3tydp3m7pehhiphupwybjlol5v2u3sabqotqximxmnswjlczb@jmdzpbrcrgou>
 <08545d45-bfe6-45e4-b7be-503c318315af@quicinc.com>
In-Reply-To: <08545d45-bfe6-45e4-b7be-503c318315af@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 24 Jan 2025 17:55:20 +0200
X-Gm-Features: AWEUYZm4pYCNJdHGiPnsyF_MnRCwaJQzJ4L3pN0DCmSTM3Gxdme16eoXtL4QfTk
Message-ID: <CAA8EJprSZx9Bx7EXA_RpwZdhieOLtrTARqXSuo-gO9sVMdK5Qg@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] i2c: qcom-geni: Load i2c qup Firmware from linux side
To: Viken Dadhaniya <quic_vdadhani@quicinc.com>
Cc: andi.shyti@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	broonie@kernel.or, andersson@kernel.org, konradybcio@kernel.org, 
	johan+linaro@kernel.org, dianders@chromium.org, agross@kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, 
	quic_msavaliy@quicinc.com, quic_anupkulk@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 24 Jan 2025 at 17:24, Viken Dadhaniya <quic_vdadhani@quicinc.com> wrote:
>
>
>
> On 1/24/2025 8:34 PM, Dmitry Baryshkov wrote:
> > On Fri, Jan 24, 2025 at 04:23:07PM +0530, Viken Dadhaniya wrote:
> >> Add provision to load firmware of Serial engine for I2C protocol from
> >> Linux Execution Environment on running on APPS processor.
> >>
> >> Co-developed-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
> >> Signed-off-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
> >> Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
> >> ---
> >>   drivers/i2c/busses/i2c-qcom-geni.c | 7 +++++--
> >>   1 file changed, 5 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> >> index 7bbd478171e0..9ad3b8c9a224 100644
> >> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> >> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> >> @@ -872,8 +872,11 @@ static int geni_i2c_probe(struct platform_device *pdev)
> >>      }
> >>      proto = geni_se_read_proto(&gi2c->se);
> >>      if (proto != GENI_SE_I2C) {
> >> -            ret = dev_err_probe(dev, -ENXIO, "Invalid proto %d\n", proto);
> >> -            goto err_resources;
> >> +            ret = geni_load_se_firmware(&gi2c->se, GENI_SE_I2C);
> >
> > Hmm, so if the SE has been configured to e.g. SPI by the TZ, can we
> > switch it to the I2C?
>
> No, in the current design, TZ will not load the SE firmware.

But that's what your patch is doing: if the protocol is not I2C, try
switching to I2C.

Instead it should be 'if unconfigured, try loading I2C'.

>
> >
> >> +            if (ret) {
> >> +                    dev_err(gi2c->se.dev, "i2c firmware load failed ret: %d\n", ret);
> >> +                    goto err_resources;
> >> +            }
> >>      }
> >>
> >>      if (desc && desc->no_dma_support)
> >> --
> >> 2.34.1
> >>
> >



-- 
With best wishes
Dmitry
