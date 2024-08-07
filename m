Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4FB201252
	for <linux-serial@vger.kernel.org>; Wed,  7 Aug 2024 13:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723039108; cv=none; b=hHasnw0Lcf61NoYTn/ZTjbeAav1WYK16JhkT74VsTaW7shkaphaC12xd/xyI9U581cIsmkfhcGuCD2Gfw74KhR15DjeHa2dpkPZFTB+9mENWphIGdoYGPBlM4J1IturJoqyhyXNemsxtBfadDEe7ddMLnhLCPf/08pc7K952Al8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723039108; c=relaxed/simple;
	bh=GLWJWoJDWDt0GGZarvdflK2+h7z2p92bed9kZi4O4Iw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QArs8Dv66iE+4yGA2Ts6hkUN0hHM4MuaDRj0lujfdhbFnLj/qPFvRo0AGjXx3J/Wk7P7crHXHF1Z8YT39i2EDMS9HwxkUznVESaODI4zEBX7IoXV1aqtIgeZ5wUM/arXaqu+KLd/lkObF5MXnBo91+aOrfZEIkwYwYeyU6Yknic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DeuTsum5; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DeuTsum5"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-428178fc07eso12537225e9.3
        for <linux-serial@vger.kernel.org>; Wed, 07 Aug 2024 06:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723039105; x=1723643905; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GLWJWoJDWDt0GGZarvdflK2+h7z2p92bed9kZi4O4Iw=;
        b=DeuTsum56USKjSv8I5P3BXyKJ5xfb/Qn2sqOiq7UpW+Zk7cxQFvAqaknYwg//Dd9P5
         uKqgXk9C9hqg4jvEbFz77tM95qZFNZKmpn79tH5VHmVrRBWc0364WnEMyCitukMiBMJ2
         CalYfwdPFT/jEk5T1yc00ULwRKtCdSxL6Fe9nHjd6HqLh47XTOOCbawuA8BJUIW4DSuf
         ktQ2MKN2dY5+qBEIc+pSq4a4wQVyD1zVvFPzqeetx+0TQdyKmuorIuhfV/L1eKQxpaut
         uvWomdtW3hRBCHE3YF0iJOmnzXCAGj3uNzkR2C7r02X8ulAPzvmavIjSfLaOGauRbVjX
         AKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723039105; x=1723643905;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GLWJWoJDWDt0GGZarvdflK2+h7z2p92bed9kZi4O4Iw=;
        b=GUijC6GgNDTzh7ogaxHo7N/t8PemNvWlWK+nuXi9z729wqhOqc4DQztn0q3kPO7GbQ
         zY+BZYvNOYMSyOuA4Bs4gyUF3yiQpqKPACE+AGCy3Lp9c6i+neeR78zkXw/lzUVoyQ8T
         RAhRTMfAcVUNSqZ2QALipcABnY0hFLXHYllEzmhSazzWfRqQCohoz6TXpTHxjlSXIIjK
         GFpht4fLuPzsrG8l1SIDJpsImGENsI5B+f/zk3jxwnBDvG0LRHb7X5vMfUx81CIJI0hu
         IcLNyCF/POjaTpwbr9vQhA28WtgEy+hzVhKOpooDQ5/awgTDtVZ87QvgG28O2SEpFCNQ
         raOw==
X-Forwarded-Encrypted: i=1; AJvYcCW7mwwekrBZyyplEnHmVsebGiCiOpqf8XiiOVJ75pyD7F1G9EPalpOCva56pBM0mkORAFtGXQPuRXr9ANk/m5XNc3UrPmlsSpjluMrb
X-Gm-Message-State: AOJu0YzbQFiRBUhddHYvOI9+Z3RbNrTkOVzWdvD7QtZQRdqmR7NCKLOt
	n+AWPDJNuo/GBBZ6Jk8U/bSZEq0fyXNiaU2/TQhtuRl9dna3danjbBGpQ8IW+Ho=
X-Google-Smtp-Source: AGHT+IHIy3NnDD4sdlQEd27JM4ubJnaDsLDt46yF51X+1USDElnWTiYyYnPMUQU+ZvzReQNa0h9tHg==
X-Received: by 2002:a05:600c:1c04:b0:428:abd:1df1 with SMTP id 5b1f17b1804b1-428e6b059fbmr121339145e9.9.1723039105282;
        Wed, 07 Aug 2024 06:58:25 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429058026b0sm30916915e9.35.2024.08.07.06.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 06:58:24 -0700 (PDT)
Message-ID: <62c027a1692c1b80652b58147d4ff215a0ada88b.camel@linaro.org>
Subject: Re: [PATCH 0/2] tty: serial: samsung_tty: simple cleanups
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar
 <alim.akhtar@samsung.com>,  Jiri Slaby <jirislaby@kernel.org>, Peter
 Griffin <peter.griffin@linaro.org>, Will McVicker
 <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Date: Wed, 07 Aug 2024 14:58:23 +0100
In-Reply-To: <cef7b260-7f47-4acd-9d6c-d26b7f8cc7bf@linaro.org>
References: <20240806-samsung-tty-cleanup-v1-0-a68d3abf31fe@linaro.org>
	 <2024080714-spongy-wannabe-7a9e@gregkh>
	 <5e73f1b405e06f9ee796d3b7002933f75613728a.camel@linaro.org>
	 <cef7b260-7f47-4acd-9d6c-d26b7f8cc7bf@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1-4 
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-08-07 at 14:53 +0100, Tudor Ambarus wrote:
> Same on my side. Any idea why CONFIG_WERROR is not enabled by more
> archs? I see just the two:
> arch/x86/configs/i386_defconfig:CONFIG_WERROR=3Dy
> arch/x86/configs/x86_64_defconfig:CONFIG_WERROR=3Dy

I can't answer that, but it's an opt-in these days, see
b339ec9c229a ("kbuild: Only default to -Werror if COMPILE_TEST").
Surely if the concern at the time was runtime testing, then that
runtime testing CI infra could have disabled CONFIG_WERROR instead of
globally disabling it for everybody.

Anyway, I've updated our Pixel build env now.

Cheers,
Andre'

