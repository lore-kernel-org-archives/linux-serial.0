Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C28F4CEE62
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 12:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790770318; cv=none; b=L2ZU8gPkQEpUhcbb1YlTPIdOdX430MOeIVcj4KwLBy6OZ+CtK7RPwL47VInT75noBSFB0ko+zZsMtWZ+SgnGufoII/MEvd+sdPqx/KEc5ldzvuNEGbCvsX5tNrkkt1Gsz7IJd3vcidpv6UprYpz5kyvvBrXxZRyNNboeGoHHmaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790770318; c=relaxed/simple;
	bh=UjmEz7DEJdgRMfvXHXMbt0X+mPHt3JAbY1oLpvUqkxw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uxYtIwMtJIXiaYqTwX7v5WC1kanC+TeZGP44e7NgM/+uxIE3NYyiJqx+52x7zHhwBHjdyy8qGeWz8UklJLOMRYRMzarkgWUUCuZt+R/IeOThep/tH0xBLMCobZmzQxh41sOGtpfMCLqzqBmSWXEdKAo0w3moKZ0g0H0/2xSw7+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LK7Ha7BP; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LK7Ha7BP"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49fe8bf173aso27935035e9.3
        for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 05:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790770309; x=1791375109; darn=vger.kernel.org;
        h=content-type:mime-version:content-transfer-encoding:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UjmEz7DEJdgRMfvXHXMbt0X+mPHt3JAbY1oLpvUqkxw=;
        b=LK7Ha7BPMwM6q1Yg6SYoEyxpXzLNVONvxz4I4o5bvhUJo9aoC0bLnK3T16rthJMIQr
         VDMiAMryDFbgX7Ftzd90tuAzG/gzYxr8WK76yCAo0CUqeUhSVvY1SY78eubMgLicDLUo
         vbvp1MKEyE/8n6Jvf90XBmSJbcYvyoGmf38SSDgA3EJpLgxSVb+OpmbCM92WvzOBxrLv
         OuwcXoSHd+5pSiw+SDOrFUvl3q8vmYOGZFtzJugqN6KU3dUGFz65KNLHAS9/WuQ0F6mx
         rD5CnrxTzeTstVdaAlR3j5neKyqDWx98+m3EjRLMzffH2madaEG7z7Qdbm9t1d6e0II2
         1WZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790770309; x=1791375109;
        h=content-type:mime-version:content-transfer-encoding:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UjmEz7DEJdgRMfvXHXMbt0X+mPHt3JAbY1oLpvUqkxw=;
        b=oMuBfbevDheVt+oYs0olI6EfJc6W3uak27bI0OqLcyITpp8KWXCgkSKkJ97GPatVmb
         MhdSeSMPu3osvBMS3l9RdI3Ffg5rsDiqrdU7W5cpYDqtiXw9vJQmB1LMOtVaobtSZQD5
         tR1wGpLg/D7RF4MNV28kVWlsrptTo3mngwSewupRkjYO1zdDVA2h9/VAKaw3+VR2vp0f
         GrrHo3SWJoh5d5Yfa7AU2Y8AeSKq8h61uJnMtljNY41k1JUATxV2bOXS2e6DNHG426pz
         c6VXamlgRnSVye4AfpDziNWV9zSpmANg1Z+ePTE0K4Guh6fVuK6hoT27Ce2wIGMXdgQn
         e2sQ==
X-Forwarded-Encrypted: i=1; AKwUvBz86xudZPp9WpYqfcxz+u3uvQVbZe2Hlj3CLyDr2WUsNT2KWkw2YQn7JT+sVfBlSHQgTiwPhhPg3TWPOd8=@vger.kernel.org
X-Gm-Message-State: AFuF++lEq8KtYS+fw7WQCLIPWPBTMmh8NTjdYM2Bx36ys6oU2Mo5T8BR
	m7d9ZcZsoHipRi5koRo9TgAGkpJnBNuyGoGTP1bohqprlN/wKV2WbihO
X-Gm-Gg: AYBFou2gvoaZHgc6cGK8JMJnXWI2HCzhSQIIcq86a6JWieAW81LeJmmjEw2lzdA4CZX
	yhYmRZFN1MH1PVBIvcFY8rOoewi4BREcQhQVyBwyhZr8OgO+QW7XG5H5d/oavlLQbqxrcEl7smS
	P1ArPJynaIfoxLBuKXL0inAiCq0k3Da1azSqPxWbU7FoHpzRPU9mGXfamQxDZFsw83kwDpxMThr
	AhDRf5E1PYkqbgkQi3fDSVUYWjxKKV6D5NxZ6yYGtibKeS2yB01M57rPc0/SOtkZJPhXP4rWpoL
	eqryFvQqOEG+r/m1JRUsz3ehRIuFXQhv6/NBrSucfLEVQWZITOF6//CMclReZ0bUfthvoFA7pYn
	lmx2xByL+sZI0yeHjN41M8zxW+FQ3GPMaZroETafdVoEulz9OPqkMOQv9RfiezT26JbrXE+/i8D
	yoehZOrvX36a8TPzOX9tK4JrRN39qoADuRjzaTbVF+srJk6h4rRytnDdIun08dO4icMXDkpjquw
	TKxVqYjzRf/dYQHLkTvey65S3eBCaQO
X-Received: by 2002:a05:600c:19cb:b0:4a0:1c17:4fb2 with SMTP id 5b1f17b1804b1-4a01c175025mr13081675e9.31.1790770308790;
        Wed, 30 Sep 2026 05:11:48 -0700 (PDT)
Received: from [127.0.1.1] ([92.241.26.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01771b0e8sm58527975e9.12.2026.09.30.05.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 05:11:48 -0700 (PDT)
From: Fil Dunsky <filipp.dunsky@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Walleij <linusw@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Drew Fustini <fustini@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 Jason Li <jason.li@cortina-access.com>
Subject:
 Re: [PATCH RFC 04/10] ARM: cortina: Add support for the CS75xx SoC family
In-Reply-To: <f6d0478a-3438-4903-a9e2-5d314f5948c4@app.fastmail.com>
References: <20260930-b4-cs75xx-v1-0-4617c4463529@gmail.com>
 <20260930-b4-cs75xx-v1-4-4617c4463529@gmail.com>
 <65c87e07-1722-44c2-9a08-ed9e18902058@kernel.org>
 <179076583795.3054628.14443934429806440798@gmail.com>
 <CAD++jLnZBpoF3H3-sqzmrtwzxLGombFMdSYMVo59jiGFYcyCFA@mail.gmail.com>
 <d97a806f-a5a3-476e-8910-30027a6f568d@app.fastmail.com>
 <179076863241.3327419.16233537387530771884@gmail.com>
 <f6d0478a-3438-4903-a9e2-5d314f5948c4@app.fastmail.com>
Date: Wed, 30 Sep 2026 15:11:46 +0300
Message-ID: <179077030602.3399593.12266354979192327093@gmail.com>
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="fixed"

On Wed, Sep 30, 2026 at 02:02:43PM +0200, Arnd Bergmann wrote:
> I think I would go with mach-cortina here. Or even better would be
> to find a way not to need any code. If you control the boot loader,
> you could just implement the psci ops there and actually bring
> up the CPU from EL3. If that doesn't work, maybe it is time to
> actually have a generic spin-table implementation on arm32 the
> way we do on arm64. As far as I can tell, your code is just
> a copy of that anyway, though we have so far never added this to
> common arm32 code in order to encourage SoC vendors to use psci.

The boot loader is the stock U-Boot 2009.11 from the router vendor, and
replacing it on these devices is risky enough that I would rather not
depend on it, so PSCI is not really an option here.

A generic spin-table for arm32 would work for me, with two differences
from the arm64 one that it would have to cover: the release address
here is an MMIO register in the global control block, not a word in
memory, so it has to be written with writel() through an ioremap(), and
the Cortex-A9 SCU gets enabled in smp_prepare_cpus() (I have not
checked whether the stock U-Boot already does that). If that sounds
acceptable, I can post it as a separate patch in v2 and drop the
enable method binding and mach directory from this series; otherwise
I will keep the small platsmp.c under the name you and Linus agree on.

> I don't have a strong preference either. If nobody else has a clear
> guidance, changing to "cortina-access,..." would seems the most consistent
> to me.

OK, unless the DT maintainers object I will switch to "cortina-access,"
in v2.

Thanks,
Fil

