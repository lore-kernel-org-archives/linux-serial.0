Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648B41F2365
	for <linux-serial@vger.kernel.org>; Wed, 11 Dec 2024 22:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956062; cv=none; b=KHXGqWd9Ui/nbExO2FWz5QYxfxPIcnxEREHJWuTFEsZna5ApsGgGxKYeds6xfWvmyc5RoMyrcVo1/aHwC8pwNOdWyIhj3L9BFD0DyAytr1fqIL68Sse6LBx42KHdu34ZoQbbm0uxZJ75ouRq8NT1ANmE4B8YqBa8Mzrh5ywqlQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956062; c=relaxed/simple;
	bh=CxczlAVJ2KXIHFoak56IOVnj4UTzCb1FwfYB8pYAXj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EB6GRtDCsUANOgmh8wgBHdHygHlZVVVJVNCPZdP6Lr74us9C3UEUMp4p2uholPyzXQANjjIqe3y1XE4baTX4H0i+bbl6ljV8vAUlx2aowJBHGo3WIxSDITViwlwHWMdv8jutUZuWRKMjTEKj6H7dRcnl5sBnQ9cZxgl5s1vlDgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=g25QaZNV; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g25QaZNV"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-54024ecc33dso2719022e87.0
        for <linux-serial@vger.kernel.org>; Wed, 11 Dec 2024 14:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733956056; x=1734560856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OP5yTlQX9Qcr5Sy7oqm3jVaqriEDKIPmmSAXtfhzrP8=;
        b=g25QaZNVdLsi49hDDiQ8E7JV55EgTicKHuTYYH6lkrZFKd2ce8yPqbz+i/6yNX6QJd
         2xc3ubIZzfMdQ3qXza9FJbFo9XKQ2NISV20jH5RR5TZ/sMfU2zxHvHwRAiTtHViIYhmw
         j041ffngNuD+E15ZcolLVvr4QKNCF/sSkUStk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733956056; x=1734560856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OP5yTlQX9Qcr5Sy7oqm3jVaqriEDKIPmmSAXtfhzrP8=;
        b=UTVC7ggJPWML2rUfR18u4lEwXBpKD2IpVyVfonsqn89nEDOjXhnmIRnxpv9VaiJBhZ
         0EW5ovhbiMVu8AMp3fFkIG6amKCBXgUO5Rz012WgZzPYyomv0jjIj4sxp+VMXiqN9lnX
         J2wD5+aPfm+JEcgu9wcpokzXlE8XqTcJsk/0gbDtRfVFGI1VLwvGfM1qSz2xjP+gATvo
         HmAjImagG5a4KBA9Q+4TwiHEswD3EQiMNTkwPJ3dueuk5DPNZ6df6EFdXjDO498+OExi
         T/OzNHr3GHAJvQgrXuC9JiafTI5ZQ1ilE2pUnI/hKvRsKhzzofA1Pw+Z+l/nXswK6im1
         J8Lw==
X-Forwarded-Encrypted: i=1; AJvYcCWem78bcWBMF4wuRgUYjZNFpLU5kVZlDI6jADb1iyc6ONgU6rH76mal1v1Sh7iTQF/8CvCwianIvF0IxP4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywihhjsp3/1kqczF2ket2UEnZ9XLqtP8bzNyXMpxisd9JRhcWJH
	0EPwzki+/m6c39whPGjxc0LkWJkg+1YHAic2e+AHPPpXHvpfDUuCr/51w3dXylvZ3Qc2KRKKq/h
	waQ==
X-Gm-Gg: ASbGncsAmEJ7u3ZVV0k/a/IIAb+Utfd6reUpExTMq7d4aSIiF/HcfarFdyXIJ3kbiPE
	eoF26LPFpM9n4gjTl9w+qQ0UYcsVFjcTJrFRzHtMSezlkG/uh/cmAivrZGpgQ1CWMgZe/UJq48j
	zpP1m+InXH5gWMD+ftb2Geq+bvLJ80KcT/UEpNx8pxH8s+QTfsAhv5tT+/4L/Ki2bFS5Ll+PClt
	FxI5/cZuA6togXFv6zcn4Tzn1Gd3XXBnEySl8aHKlCqIcbzXmmUkWphFAvmJ/54qo/eMyUhZvBx
	xdBDzxxu1q0CQmS21HXdhg==
X-Google-Smtp-Source: AGHT+IEYDvfrXmO0rYs8R2EEpqD4/FYqGXEOdMTg/dVNPXUbEvm2gVoeV4E/2p5rtAlTB3JMxuLZTA==
X-Received: by 2002:a05:6512:238e:b0:540:17ac:b374 with SMTP id 2adb3069b0e04-5402a5e8075mr939341e87.25.1733956056045;
        Wed, 11 Dec 2024 14:27:36 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5402111e0f1sm967047e87.189.2024.12.11.14.27.34
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 14:27:35 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30039432861so56265611fa.2
        for <linux-serial@vger.kernel.org>; Wed, 11 Dec 2024 14:27:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW46sxFI+4Ysq6pKlrpaHT1rmGchI+3q7zARag+/SYll4tVNHeRR+H/kL/oBiS7fdSQYg6yhzAFXQWii6A=@vger.kernel.org
X-Received: by 2002:a05:651c:210c:b0:300:3a15:8f2a with SMTP id
 38308e7fff4ca-30249e00c59mr4195391fa.2.1733956053624; Wed, 11 Dec 2024
 14:27:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204150326.1470749-1-quic_vdadhani@quicinc.com>
 <20241204150326.1470749-2-quic_vdadhani@quicinc.com> <CAD=FV=XF+9wxZ5xNtO3Uy8QW9UY4tb+KR46jkondvBeQuVLsrA@mail.gmail.com>
 <6736db20-127b-45c3-ac90-3e3e359c343b@quicinc.com> <CAD=FV=VReNQ3nw+wfZizL7JjxEX9z=GwDEJAFzheNkW7rSrB5Q@mail.gmail.com>
 <65ded632-963a-4bfd-906c-1b09e916b5e0@quicinc.com>
In-Reply-To: <65ded632-963a-4bfd-906c-1b09e916b5e0@quicinc.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 11 Dec 2024 14:27:22 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WrXegUW7n0e5Lp6AMN9u492Rn1yFXCOzGRbs36VeKrMA@mail.gmail.com>
X-Gm-Features: AZHOrDnd4yPKzZ7z0r-DDC60k0pmk_2L5RUUePsjv7ZkRWOmo6qWozIHPBzjPco
Message-ID: <CAD=FV=WrXegUW7n0e5Lp6AMN9u492Rn1yFXCOzGRbs36VeKrMA@mail.gmail.com>
Subject: Re: [PATCH v1 1/7] dt-bindings: i2c: qcom,i2c-geni: Document DT
 properties for QUP firmware loading
To: Viken Dadhaniya <quic_vdadhani@quicinc.com>
Cc: andi.shyti@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	broonie@kernel.or, andersson@kernel.org, konradybcio@kernel.org, 
	johan+linaro@kernel.org, agross@kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-spi@vger.kernel.org, quic_anupkulk@quicinc.com, 
	Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 10, 2024 at 9:27=E2=80=AFPM Viken Dadhaniya
<quic_vdadhani@quicinc.com> wrote:
>
> On 12/10/2024 11:12 PM, Doug Anderson wrote:
> > Hi,
> >
> > On Mon, Dec 9, 2024 at 9:28=E2=80=AFPM Viken Dadhaniya
> > <quic_vdadhani@quicinc.com> wrote:
> >>
> >> On 12/4/2024 10:55 PM, Doug Anderson wrote:
> >>> Hi,
> >>>
> >>> On Wed, Dec 4, 2024 at 7:03=E2=80=AFAM Viken Dadhaniya
> >>> <quic_vdadhani@quicinc.com> wrote:
> >>>>
> >>>> Document the 'qcom,load-firmware' and 'qcom,xfer-mode' properties to
> >>>> support SE(Serial Engine) firmware loading from the protocol driver =
and to
> >>>> select the data transfer mode, either GPI DMA (Generic Packet Interf=
ace)
> >>>> or non-GPI mode (PIO/CPU DMA).
> >>>>
> >>>> I2C controller can operate in one of two modes based on the
> >>>> 'qcom,xfer-mode' property, and the firmware is loaded accordingly.
> >>>>
> >>>> Co-developed-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
> >>>> Signed-off-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
> >>>> Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
> >>>> ---
> >>>>    .../devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml   | 11 ++++++=
+++++
> >>>>    1 file changed, 11 insertions(+)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qco=
m.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
> >>>> index 9f66a3bb1f80..a26f34fce1bb 100644
> >>>> --- a/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
> >>>> +++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
> >>>> @@ -66,6 +66,15 @@ properties:
> >>>>      required-opps:
> >>>>        maxItems: 1
> >>>>
> >>>> +  qcom,load-firmware:
> >>>> +    type: boolean
> >>>> +    description: Optional property to load SE (serial engine) Firmw=
are from protocol driver.
> >>>> +
> >>>> +  qcom,xfer-mode:
> >>>> +    description: Value 1,2 and 3 represents FIFO, CPU DMA and GSI D=
MA mode respectively.
> >>>> +    $ref: /schemas/types.yaml#/definitions/uint32
> >>>> +    enum: [1, 2, 3]
> >>>
> >>> I'm a little confused about this. I'll admit I haven't fully analyzed
> >>> your patch with actual code in it, but in the past "CPU DMA" mode and
> >>> "FIFO" mode were compatible with each other and then it was up to the
> >>> driver to decide which of the two modes made sense in any given
> >>> situation. For instance, last I looked at the i2c driver it tried to
> >>> use DMA for large transfers and FIFO for small transfers. The SPI
> >>> driver also has some cases where it will use DMA mode and then
> >>> fallback to FIFO mode.
> >>>
> >>> ...so what exactly is the point of differentiating between "FIFO" and
> >>> "CPU DMA" mode here?
> >>
> >> Yes, correct, Will update in V2.
> >> I plan to add 2 modes, GSI and non-GSI(PIO or DMA based on length).
> >>
> >>>
> >>> Then when it comes to "GSI DMA" mode, my understanding is that the
> >>> firmware for "GSI DMA" mode is always loaded by Trustzone because the
> >>> whole point is that the GSI mode arbitrates between multiple clients.
> >>> Presumably if the firmware already loaded the GSI firmware then the
> >>> code would just detect that case. ...so there shouldn't need to be an=
y
> >>> reason to specify GSI mode here either, right?
> >>>
> >>> -Doug
> >>
> >> GSI firmware is loaded from TZ per QUP, but to use GSI mode,
> >> we need to configure the SE to use GSI mode by writing into SE registe=
r
> >> QUPV3_SE_GENI_DMA_MODE_EN and SE_GSI_EVENT_EN. This register is
> >> used to configure data transfer mode for Serial Engine.
> >
> > Can't you detect it's in GSI mode without any device tree property
> > like the code does today?
> >
> > -Doug
>
> No, we can't detect GSI mode in the current design. The GSI firmware is
> loaded from the TZ side, while mode selection occurs on the APPS side
> based on the Device Tree property.

Presumably you can check to see if the geni firmware has already been
loaded before the kernel started, right? In the case that it's already
loaded, can't you fall back to the way that existing code detects GSI
mode? From reading `drivers/spi/spi-geni-qcom.c` I see that if the
FIFO is disabled then it assumes we must be in GSI mode...
Specifically, it checks:

readl(se->base + GENI_IF_DISABLE_RO) & FIFO_IF_DISABLE;

The i2c code today (`drivers/i2c/busses/i2c-qcom-geni.c`) does the same.

So, essentially:

* If geni firmware has already been loaded, then check
FIFO_IF_DISABLE. If the FIFO is disabled it's GSI. If not then both
"CPU DMA" and "FIFO" are allowed.

* If geni firmware hasn't already been loaded then it's impossible to
be in GSI mode since GSI only makes sense if the geni firmware was
loaded before the kernel started. Thus we're in "CPU DMA" / "FIFO"
mode.

In both cases you don't need an attribute telling you whether to use
GSI mode or not, right?

-Doug
