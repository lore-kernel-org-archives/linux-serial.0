Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDFC23ED65
	for <linux-serial@vger.kernel.org>; Tue, 10 Dec 2024 17:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733852569; cv=none; b=AXvHxtJAUOKi09plux5laatzrPMEZr5OFMKqS8IPfPhqxxpyBBSFsYFeSmLa9PTPdfWvh4mn9oqikkGyCd3ggsO+fl/oZiEg/+VwDQy1vSlqG0YLG3JzL9ZGvEp/5b4hwbnOXx9tDywjipKJglLY66z6ly3nuVhTK7UpmQYk47U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733852569; c=relaxed/simple;
	bh=zyY+LvfKIlfyAiCLJWS7+1JGxiO0FEIr6sylV/Xgzzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RpcbTcVSML50o90klql+d9pI2BYhXRGdpaCIVKhBtn44He9aCHZR38TDKoGuHYhZLOqDjcpP+WKL2k0MnxgCUYbzr1k8YBmGG+2vjBVjsFAmVghoHE3eLaqoS/jqeyfEtLCq83CRBEToiN4GkRwwRkkBvl1AehFsR58V8R3I2o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RrumTtKl; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RrumTtKl"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53e399e3310so3812709e87.1
        for <linux-serial@vger.kernel.org>; Tue, 10 Dec 2024 09:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733852565; x=1734457365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AjuuFtemyP+DI+76rQdawmoZ3eTqeNEd2wfGxX97PdQ=;
        b=RrumTtKljN5JDlD7+rQ5Vqqem4buCpOhssX2yqD2dt+GByGR1ZK4OupvaLwcOxCevP
         EXWU9gIm8La01wgEXDvkvD7tt0pBLUlTqz4VgFfX4Xa8w30IzWVGPYgA/PYS2rBeH00V
         Cy72ZrfnAwlSn4fGi+2vVVlKD6iLJoY/k6RuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733852565; x=1734457365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AjuuFtemyP+DI+76rQdawmoZ3eTqeNEd2wfGxX97PdQ=;
        b=B0nElBXb6PvgG3SallaDyW3gdWGS+2vGmTtv7xrJ9L6FmoFYjp1LyPZtBTVlCHMA7X
         ipSBt5/RsdmxFvsXQ+WNDus6MSirNRzfdmRgjNn/dPtcSEcRxqieAoVT5NXA2NQ3u5UO
         gWwLLSSLvxYaqQd7VNzbpEZ3VAOKJqDwWfOumQkXK8HGswJEeRAFPCgnFq1GcR8dmCy7
         3Bb+cC52mXe/Cf2CG7mobL8prMlkjjvWDXPpgXDdnlihKYDmY+ozeM4XjXGKCKOHuNjm
         DTnZFYVNk83FDvAr0RW8vNiLmc4PjXyYO/PfxiTyRf88JGuvHoCma+NPTKiF8oXFLEYH
         blkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIQAPmH5gk2RtWc5aMcKzS5cZySB/R3CXiJUEcxIcVJ0SwhDyyl/mDXXqazQD5yxO+fwNFT97qKT/eH0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YynCI0xU40MBvhSqLFYy4zVIq0BWch7WMYQ5nj8G4v6OIL8Ce+o
	ZR8+HhL7oOQF9I6rj1FbMAt5C47CY1Knpkzita0KOQ2eLL2r7dacZuZWwm1UNipMfxCJvUDsIM2
	ZlQ==
X-Gm-Gg: ASbGncuLqqP/75EmhvDWJY1QDF/Zijg+Qbu44D0+dyzSbuKPGN3h0DZ8e7RHUsBwP/i
	Iw7VN+/FBcTBxBT6tsdXtSMCJWNE4D41p5n9/IAT+N2HIEPqPzVuKmyVr8wNopayS2+YeNkL0tW
	AFZIucK9KWEhLumb7EANax90uING1d4WqW7z4b2DjTFOsx+3MDyk9KrThy5z45dL0eIZcjKuENZ
	hOoQRU4EJW0yr8zULGSKxhfePkNSb3Zgc2AKaTDyAY56kOZBA55u+W65ur0rr3RQB84WmDJ0RLW
	xO1DdvEq7MEhPQtVuF8+EA==
X-Google-Smtp-Source: AGHT+IHRhLTKXC+mvDqC6LK517hC1N8Du7kA7JalYmQe+aNrfZEpuZczPCq5Dne9v6pDeQxk2+NxnQ==
X-Received: by 2002:a05:6512:2812:b0:53e:3729:eaf7 with SMTP id 2adb3069b0e04-53e3729ee24mr6448918e87.34.1733852565041;
        Tue, 10 Dec 2024 09:42:45 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53f2307fdd2sm1091540e87.159.2024.12.10.09.42.44
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 09:42:44 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30229d5b1caso19354951fa.2
        for <linux-serial@vger.kernel.org>; Tue, 10 Dec 2024 09:42:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWb68Xm3ws6J2p7XgLAU8rmHzwSIWqv7Th4SzS4arNRtfmeqmZUZ7w3k+o5XudGnxe5P6fZM3eNejDE6hI=@vger.kernel.org
X-Received: by 2002:a2e:800a:0:b0:302:1c90:58d9 with SMTP id
 38308e7fff4ca-30240ced962mr314001fa.16.1733852563643; Tue, 10 Dec 2024
 09:42:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204150326.1470749-1-quic_vdadhani@quicinc.com>
 <20241204150326.1470749-2-quic_vdadhani@quicinc.com> <CAD=FV=XF+9wxZ5xNtO3Uy8QW9UY4tb+KR46jkondvBeQuVLsrA@mail.gmail.com>
 <6736db20-127b-45c3-ac90-3e3e359c343b@quicinc.com>
In-Reply-To: <6736db20-127b-45c3-ac90-3e3e359c343b@quicinc.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 10 Dec 2024 09:42:31 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VReNQ3nw+wfZizL7JjxEX9z=GwDEJAFzheNkW7rSrB5Q@mail.gmail.com>
X-Gm-Features: AZHOrDkKw2FmHmZQUJPUfL4ELobjfrjI9icl10Uq0FkzH_2PdMnaEbBKyuOx5E0
Message-ID: <CAD=FV=VReNQ3nw+wfZizL7JjxEX9z=GwDEJAFzheNkW7rSrB5Q@mail.gmail.com>
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

On Mon, Dec 9, 2024 at 9:28=E2=80=AFPM Viken Dadhaniya
<quic_vdadhani@quicinc.com> wrote:
>
> On 12/4/2024 10:55 PM, Doug Anderson wrote:
> > Hi,
> >
> > On Wed, Dec 4, 2024 at 7:03=E2=80=AFAM Viken Dadhaniya
> > <quic_vdadhani@quicinc.com> wrote:
> >>
> >> Document the 'qcom,load-firmware' and 'qcom,xfer-mode' properties to
> >> support SE(Serial Engine) firmware loading from the protocol driver an=
d to
> >> select the data transfer mode, either GPI DMA (Generic Packet Interfac=
e)
> >> or non-GPI mode (PIO/CPU DMA).
> >>
> >> I2C controller can operate in one of two modes based on the
> >> 'qcom,xfer-mode' property, and the firmware is loaded accordingly.
> >>
> >> Co-developed-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
> >> Signed-off-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
> >> Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
> >> ---
> >>   .../devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml   | 11 +++++++++=
++
> >>   1 file changed, 11 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.=
yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
> >> index 9f66a3bb1f80..a26f34fce1bb 100644
> >> --- a/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
> >> +++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
> >> @@ -66,6 +66,15 @@ properties:
> >>     required-opps:
> >>       maxItems: 1
> >>
> >> +  qcom,load-firmware:
> >> +    type: boolean
> >> +    description: Optional property to load SE (serial engine) Firmwar=
e from protocol driver.
> >> +
> >> +  qcom,xfer-mode:
> >> +    description: Value 1,2 and 3 represents FIFO, CPU DMA and GSI DMA=
 mode respectively.
> >> +    $ref: /schemas/types.yaml#/definitions/uint32
> >> +    enum: [1, 2, 3]
> >
> > I'm a little confused about this. I'll admit I haven't fully analyzed
> > your patch with actual code in it, but in the past "CPU DMA" mode and
> > "FIFO" mode were compatible with each other and then it was up to the
> > driver to decide which of the two modes made sense in any given
> > situation. For instance, last I looked at the i2c driver it tried to
> > use DMA for large transfers and FIFO for small transfers. The SPI
> > driver also has some cases where it will use DMA mode and then
> > fallback to FIFO mode.
> >
> > ...so what exactly is the point of differentiating between "FIFO" and
> > "CPU DMA" mode here?
>
> Yes, correct, Will update in V2.
> I plan to add 2 modes, GSI and non-GSI(PIO or DMA based on length).
>
> >
> > Then when it comes to "GSI DMA" mode, my understanding is that the
> > firmware for "GSI DMA" mode is always loaded by Trustzone because the
> > whole point is that the GSI mode arbitrates between multiple clients.
> > Presumably if the firmware already loaded the GSI firmware then the
> > code would just detect that case. ...so there shouldn't need to be any
> > reason to specify GSI mode here either, right?
> >
> > -Doug
>
> GSI firmware is loaded from TZ per QUP, but to use GSI mode,
> we need to configure the SE to use GSI mode by writing into SE register
> QUPV3_SE_GENI_DMA_MODE_EN and SE_GSI_EVENT_EN. This register is
> used to configure data transfer mode for Serial Engine.

Can't you detect it's in GSI mode without any device tree property
like the code does today?

-Doug
