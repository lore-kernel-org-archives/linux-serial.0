Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE961CF96
	for <linux-serial@vger.kernel.org>; Tue, 16 Jan 2024 18:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705428694; cv=none; b=IpxPS7GWeFmfyDjYSAq15x0warLPLNV3wMd68h3g9uRROgEzjvc7tzZ50akwZfZUV8DCax3Mx4WS+T5DrzoteP1H0dWyTjdeNyJBuEqIVPxnleiMeiX2aPp2OBlmuttb0tLufKQ+fXldiqUoMnyFtDCTGRO8IZQHsGoPaghWtAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705428694; c=relaxed/simple;
	bh=M0Ooulm9S8WHLNo6AfrCErL0/OwFMQeru2lh9LT1eww=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=BIg+8Xj/9SBiaOBzhU/79ph524tkzEPUqhdLyBHXGAQtQ+JPZSMl2e8zKJn7PbS3s7Rc7QHzYqsvusMB5XO1RTwUB/EZ09vORt9CO73TqT2EcWANmZ/lRWKd64HswpA+d6VWl4lxhbhRaLWBAHB3+CUcTo3tAzsePdjbEF+2X3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tmddb43k; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tmddb43k"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7bed8faf6ebso307554939f.2
        for <linux-serial@vger.kernel.org>; Tue, 16 Jan 2024 10:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705428692; x=1706033492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNxgcWOo1csnjFsBhzJAhb4fTQBuYKqyH36PPDUAqrM=;
        b=tmddb43klQoDUO20LffXTBLPfgv4Y9FAsY3TKpVG1j6i6Mwoin4jsgY10a/KNQ7JoS
         JJaNAFKUgr2U+TVWa2mUpPgkbD9owDRbNonMWozlnjB6RyIdbAyOM/Nx45qJgfffrv3H
         rvHoOsUqLiJfUYDMp12k9HlQ8fuf/LDeGp3QSKOtAZlyLoYkNd9lixsp4KHnR43mdMOq
         p0PfTYEDXjOhD5XacqcnKFR7zuXSrVolRnlvtiZ9id0U3/rS+SZFwbeXZMxuUmfPJNsO
         mkLddh5Grv2lHkTlQsRtYUcoAtsdaxT49lb+Wl72hEvD+s/BTKLhKPB1gJB8SePSvuai
         UUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705428692; x=1706033492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SNxgcWOo1csnjFsBhzJAhb4fTQBuYKqyH36PPDUAqrM=;
        b=XTxCWKjQzjbx221KdP82oBt1YPTeROY2+FaXdbywy3TAjChv8GjIuOXAls0iCP2N93
         eoIXnQQEsCBAI/ahPbUgumr/Nsi2R2SdTO4MtTcZOwQJ9VRl7qfwFfjIZvz3oiJd6Sbl
         BsuMW3/jeCv6UUCNrJWVgRDVeEZTtwFfw7YL5e+NAhp8/t4Ty7XwihWWwSHQv+Ge1Bq0
         K0shXOKtOh1Jx86XB4MAV9VDoFMoJEyNcm6c9purYooGJODlcmIJqsrQaBU210qIlVVP
         awirJDvfHp817KsN7+QZcN1Jgwe+SUGyHxaguBuuJO3OJfpLnpasC1MueM6LFpiKGKel
         EzVw==
X-Gm-Message-State: AOJu0Yy7lN1tNwTyEUdSGVgxvTjQgIpn9gtOdzGERgZqVeXKrjSIUlyQ
	I8IrfSC7Ml/4Peze52aLaqUb34zfR78d9mgKZuXmszZhZvRvmQ==
X-Google-Smtp-Source: AGHT+IE5QD79wikGUbt+f+gyh/dGDvkkcbx8JHtG+ewUTqw1m7M5U8NmftDLIr2A/UQiHvfv2iLRDc2vlArXMBbwfU0=
X-Received: by 2002:a6b:cd0c:0:b0:7bf:554c:bb63 with SMTP id
 d12-20020a6bcd0c000000b007bf554cbb63mr1637673iog.14.1705428692146; Tue, 16
 Jan 2024 10:11:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109125814.3691033-1-tudor.ambarus@linaro.org> <20240109125814.3691033-4-tudor.ambarus@linaro.org>
In-Reply-To: <20240109125814.3691033-4-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 16 Jan 2024 12:11:20 -0600
Message-ID: <CAPLW+4=BO6jkN+RRhO=8=79XtoOTRdfrEQBgDDzq8seWi8YMaA@mail.gmail.com>
Subject: Re: [PATCH v3 03/12] dt-bindings: serial: samsung: do not allow
 reg-io-width for gs101
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: peter.griffin@linaro.org, krzysztof.kozlowski+dt@linaro.org, 
	gregkh@linuxfoundation.org, mturquette@baylibre.com, sboyd@kernel.org, 
	robh+dt@kernel.org, conor+dt@kernel.org, andi.shyti@kernel.org, 
	alim.akhtar@samsung.com, jirislaby@kernel.org, s.nawrocki@samsung.com, 
	tomasz.figa@gmail.com, cw00.choi@samsung.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-serial@vger.kernel.org, andre.draszik@linaro.org, 
	kernel-team@android.com, willmcvicker@google.com, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 6:59=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro.=
org> wrote:
>
> All gs101 serial ports are restricted to 32-bit register accesses.
> This requirement will be inferred from the compatible. Do not allow
> the reg-io-width property for the google,gs101-uart compatible.
>
> Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

> v3: collect Peter's R-b tag
> v2: new patch
>
>  Documentation/devicetree/bindings/serial/samsung_uart.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b=
/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> index 133259ed3a34..0f0131026911 100644
> --- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> @@ -143,6 +143,8 @@ allOf:
>      then:
>        required:
>          - samsung,uart-fifosize
> +      properties:
> +        reg-io-width: false
>
>  unevaluatedProperties: false
>
> --
> 2.43.0.472.g3155946c3a-goog
>
>
