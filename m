Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17734BB266
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 10:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790765856; cv=none; b=MhU/Ny9q9XnNCYjUvjF750f4cxxcJr2iQorTr3uOwz2OcT1FVAQKP2BwZoksKnRVPWx1oJ+CVVqSkEprM9IMRLXqnoD2M6p1VCciMf9fQPofY/qTT6iSeqagUc0ajiBY7yKLlHjXIVLzVR9rg2JGieltl9oZDdFnAc0eht+97O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790765856; c=relaxed/simple;
	bh=3Ps7OVPCUls+dQh+qEqi79V2MQpSrrvFi3h1eo/2FTc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LX24Z/cQ3hb/6+TDEhVXegr7uq5FXsIkBe1txL2TPIyw9TW4loQoTuAMt6hKNtYrYbq5tkACWdKieAwsR3ZMy7aQYn9dxDCVMai41no6L+6sPlBYLKHQFWCjbGEp7De+hEGuCxKojguK/z3lm3dnlhudjY6IjNpKB/C6O2Lmy7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fBOFQ/vi; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBOFQ/vi"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48b02b1b4cfso116299f8f.0
        for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 03:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790765841; x=1791370641; darn=vger.kernel.org;
        h=content-type:mime-version:content-transfer-encoding:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wLis0s98ZuwFHTL90Zcm9u7pqE377mGnvWwB/RoEQu8=;
        b=fBOFQ/viZwFRT3jU1y1jt5R5cq0pV2fPtBHSaoJX20WnIEARAEJVxp34q7Mul03YPg
         6cymSSMy7H1/UEObu41D3p1gzb5nuXvQ52EpYXBlr0uqablWLC96lUg0A3GlL6fCG3LN
         /eJCisKGiwMeOmCEe8LzTXD2R1MbmfsCJCMT1kUY4yqmRQU6bMO1VXNuReBnXlZCzEGC
         /dpgrSoYVWcm8H5ZrfJFo6sXst2fYtTRwKsvpwvpaF9D+cDH2sNGy5qS3ktDws7U079Y
         poPoEyBVw6LfY0ZLqeiXSoStDMo6uBuHDGmi0UPBfC1Sz5jXEf8GHUPFTcW6l3GC0/i/
         dyQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790765841; x=1791370641;
        h=content-type:mime-version:content-transfer-encoding:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wLis0s98ZuwFHTL90Zcm9u7pqE377mGnvWwB/RoEQu8=;
        b=KKtzCiYTHQqJZ+lItUKJNY1qTO8W8AB/8Cb+CY7sQUZl8Inz/1gdDA/PkvMW/thDqE
         vCcBZ1TmKwRimxU8BvncDD70OAajQiP2KzPpmtIppkwwfCKVwru2nrskciaWy/Cz+eCE
         NCdHyN0ILBwAjJfPxhFKXHRQMKNPz4gwp51Pa+KbEuzSsurosT4PoKreNZajMf2viBRR
         XV1JBnmicxMalhnTnXpjrEewqRWUK5QtHSD1AQh9X8jD4PQR7GrKAVCmmhxtUGN2ab88
         azkGBFoIkDC+DWrqlcuv6P7Vg68jPbCOjc4HHiZPuA9YiIItEYclk4MIFnUVFBcqf/da
         b8BA==
X-Forwarded-Encrypted: i=1; AKwUvBxNMvUtba3EJ457wv69Nbq56KpBklw7TNwqFYi7J14ESPE2tKYodpt4RSGpGkEPj1yzbAMRrw8P2QW2Js0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKDzBEyVWyAEJBOBu3YJ/Kz0IlExmPxhXZbqjKQXTdVx8hQluk3
	I+5XgwkpjIVBnmbOYHl6nO9JbnlRTyMC5YPjk4j0/uNgT/rmbCfEMHC/
X-Gm-Gg: AYBFou0yVpfV9mY87IixhrI29dUediihG6zYP5zAbCmqBziYBlDLz9FXd6v/u7NXCmS
	iim0R/7SAvOoUUw5ZxZsUsd7miGkce73DOmJ/k87LtTIZ9BK18KH/tiNwzhqWZpP6ekA1ssrOoJ
	3lrsTvrmVplnSQGMZueP0ON46xVKtB6KKR3SzNai05lc5Vmta1vm24emu553jsh0OeMEzIJ4FwX
	/5MmV8lWTIm5b969V7MDu03s0JHnUiKcqX4xx2+amz4mhlL8QF+chkJbsClX0fWvQgIME5S841g
	Zhf3i/QpkKkgKdrzupix1JakvJZQ63wVUj3Zj450fUZGx4xAnYLH3+rfHsAHF7X+Jb+ADz4Pw2G
	b6PhwZ7oIWcEXsDJhZgH7k7kFUhVajT4SqZ//FVJ8GawsUZLjWbqvSWmQgFcijx1jsdb4AxTB9e
	G9EMfsN4Cn8m0fP31ytOvKwMhlmG+kP/PoT2BihqE/GjE68y0SRoXmuB2hBrj1smxnL6kkyPevQ
	6eWLrlwtdaNSFuU3pkKTJuOiYMoC0B5nEmzcVAHZpQ=
X-Received: by 2002:a05:6000:41cb:b0:488:8aa5:b4a1 with SMTP id ffacd0b85a97d-48b024b4a4emr2192936f8f.14.1790765840706;
        Wed, 30 Sep 2026 03:57:20 -0700 (PDT)
Received: from [127.0.1.1] ([92.241.26.38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b02949f3asm2695384f8f.1.2026.09.30.03.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 03:57:20 -0700 (PDT)
From: Fil Dunsky <filipp.dunsky@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linusw@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Drew Fustini <fustini@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject:
 Re: [PATCH RFC 04/10] ARM: cortina: Add support for the CS75xx SoC family
In-Reply-To: <65c87e07-1722-44c2-9a08-ed9e18902058@kernel.org>
References: <20260930-b4-cs75xx-v1-0-4617c4463529@gmail.com>
 <20260930-b4-cs75xx-v1-4-4617c4463529@gmail.com>
 <65c87e07-1722-44c2-9a08-ed9e18902058@kernel.org>
Date: Wed, 30 Sep 2026 13:57:17 +0300
Message-ID: <179076583795.3054628.14443934429806440798@gmail.com>
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="fixed"

On 30/09/2026 12:20, Krzysztof Kozlowski wrote:
> How is it different from Cortina Gemini?

Apart from the vendor, they have little in common. Gemini (SL3516/
CS3516) is a single ARMv4 FA526 with Faraday peripherals (FTINTC010,
FTTMR010, FTGPIO010, a 16550 UART) and builds for ARCH_MULTI_V4. The
CS75xx ("Goldengate G2") is an ARMv7 dual Cortex-A9 MPCore with GIC,
SCU, TWD/global timer and a PL310, and its UART, GPIO, interrupt
controller and NAND controller are different blocks from the Gemini
ones. So it cannot share mach-gemini or its drivers.

>> +machine-$(CONFIG_ARCH_CORTINA_CS75XX)	+= cortina
>
> Arch should be rather per entire family, not one SoC.

CS75xx is meant as the family (the vendor kernel covers the CS7522 and
CS7542 with one ARCH_GOLDENGATE), but I see the name reads like a
single part. Following Linus' suggestion of mach-goldengate, v2 will
use ARCH_GOLDENGATE and arch/arm/mach-goldengate for the whole family.

Thanks,
Fil

