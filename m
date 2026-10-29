Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=74.125.231.198
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793255921;
	b=b72fKt1kiDMjYF8bBScwyzgBaB28Dq494QqQNmg9pqHH3qF6IYuOkADIp9CQBRTklRxy
	 BEpNX9xU+aSh0tGi1rIj8I1awOIuAxn9HbDvdnIq7tJR8iVbcGU8pT67Nf2hPXAVDeYh1
	 lVdHCN9l6FBEg8dILvg0fXMT+TtXU7a9mG5tOqEkJfjGQXh5qAep5e0+ewvB0Zy4PK3Fg
	 nSyPLzQXGfDNl+6sZeCojiR3k/1A1r6Tt5DRIlQ8iwtfyErOc0vAXz2npBMwQMKiPEuYr
	 a5a6N41zW4IOtA7bhsMorR8pE/BeOHS+et9PtgDZSiq2GClqwt9MXn8IU42SULkH5YA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793255921;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=3gBAmM3LC3tWo85Han3FCwW9Y43tPIO+MqwsQV7d8Ik=;
	b=ut61+yubmOc3h6PSkuxqc0Z/ah+necYT3By6uMrDpNmiCXDXYxTVWmVzJVcoXhf48oMo
	 ZXnXTONNOKc5/xWmZcONxQ2R+s8Mt9QiCTH9dteRG4BynaxOqnO7hcI5CQDdKuQAm2CgH
	 Zh+jiSlL+n9cvc2Fy1wCWLlq8C53U1z1rBeTEibmX+vbhUXkSqsUlpi+hewtP3ASnst/D
	 X8wyX5U4NerVDOqyyEWVsAxOlmFuIgiwRbT2YwivP9iAKOTZZdWTmPmdX5yxhEIHze/VJ
	 /DIaqDkn3ewHNRlxeUZdxQb/0H53ciRjpR/hn/hXLW8eX/2g5rukDb8H4lqWmiDlnDA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="i/NQx0gS";
	arc=fail smtp.remote-ip=74.125.231.198
Received: from mail-oi2-f6.google.com (mail-oi2-f6.google.com [74.125.231.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09F3606A31C
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 06:38:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F09F3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i/NQx0gS
Received: by mail-oi2-f6.google.com with SMTP id 5614622812f47-545a4fb8d5dso108410b6e.1
        for <linux-serial@vger.kernel.org>; Wed, 28 Oct 2026 23:38:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793255920; cv=none;
        d=google.com; s=arc-20260327;
        b=DDSedjhFsQt79iD8NrNMzFeQgzghQ1mbC00Or+MEmQd0kJlq6RoEilLKDzDWKntlmC
         0AlfIxz8sO/kD5TLLJnZR5j92oNhGgz1EHkvQyDW7Rgi5rdjpBeoGfJ3jzDtA2aTJXL2
         oI9Y8ch78QPyeVJnHFYwix+5PSszslqMU6koasFoP9kEpzPGSkAZh/y0RkU4FsKTSp3j
         28knTAzudAsDM2OXs4bvTNMviW9pRciWPzA6kAkaEk7C8rIOEvZggj61JVRWZm4HKtJS
         2NO05I2yQaLv5i7cMHIEW4fB7YVTxRZrmU3iiknERBhn1CxVlyA3n35X+5W7F1neloDY
         tnDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3gBAmM3LC3tWo85Han3FCwW9Y43tPIO+MqwsQV7d8Ik=;
        fh=0SBRKq73iILX16ZG15DbZ4g04GSo2GQ3TmC1zwU+xFg=;
        b=YGc8lTq19ZF+p9LS1Zlkf8QhFVonOyXDduqSG2emCor4FqgHkYVPd7l2ON9h1o/UwW
         4daJc2MC0jHX6zMpsYwNbjPHYEqy8WEK3NPsLbpZh863HWY6hAddvOVtR+jM1+t3YALA
         YpypLr5XwL7aJ5lS6T68o0WD7+vE0+dMIV+EpBhk8R85yv0yS5MZbbDGs1Uog7YDNO0E
         AKM9da92gZ3hqSKBoofFoU3yLjrD1V/Ky/G+MhP6rcPZXUQ1MAiFq7GXRfr2R5DIaMP7
         Le0ONf9m59Bi/kSdC6UgXeVJNcOeOIUJuHC6ocyaIBhhTcJCupsewRcFYChvuO1IP2aL
         9rNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793255920; x=1793860720; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3gBAmM3LC3tWo85Han3FCwW9Y43tPIO+MqwsQV7d8Ik=;
        b=i/NQx0gSkOjJQl0K0epv2YWmOQZ9jPeUuvcIg9BHNzhqMbxG6iwJmEtrej38fjOryl
         Q1GWjhPP5/W5qfUXyoxsC8Bis7MasWNT8cCAWwrF8JpoxlVEh0L2juXD7M4IFqs7aQ4B
         JJRKCeAx9fPvaMdR2kmNIzbFb9aZK5imrI9eN2fL5EJR9YQCZ8zKQEr4rsFWfiAAmBJM
         CgA1HT7kVe5AZH4kzrWPFmsnuAeAO/l55Es/x2p5LToz3s+tKmSzWAVhfuXYKI1yVRSI
         t0ZxuHvJh9xWMqfzPPnN3mIRluSylimeZc5PUxsLAmH+jle8nt+KtlanWO6PJ8Ie9as/
         5kKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793255920; x=1793860720;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3gBAmM3LC3tWo85Han3FCwW9Y43tPIO+MqwsQV7d8Ik=;
        b=LsrhmrNs4jN1ZebfcBErqbEF8FV7FT813L89jqVbnYtj84DwNag9C2yj4/I8UGWTO6
         buyDWd8aacK42JEeAQVXSE1JNraiChyfZ867UhYR5iDtUGOYz2/0V4X09owcVFCj2blJ
         rs+6qXrkT7/OOZA8t2yGl7gCRNarCyb93aigQrvpKL1jrIiC6jGlo3fwEudPaWJ4XJZS
         uB7C4BYmYTqJopgMYAqos7Cdjm69R+AbWejc/mpq0XQvDDlDlidqHcTH9amyEyzRLb5E
         e9NDj2KodBVDDFK9Y+r6fPMAb/2z3kFH/UrHJc79aEim8hz4QmXDaFrcsMD8vLmR4Ge+
         yE3w==
X-Forwarded-Encrypted: i=1; AKwUvBx7TRXbk/BxG3tlPcEnDlYFXjG4sJIyLhQxFZzI6G5LxwwZNcWEDPFd2hOT9QV3G018kqEvIXHEb2vwzRE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIdPTBN+IxHcpuowltp0jEOKu1lVkmOyRHHmJMDmuxbA4abylSL
	aqrz4XJksDg0D7tBaaxeQ1WE2Pmbzvf3/ZivyeIz91eR3enCTAYFF2QRF2F1BR/3RT3hBKbH0Ua
	mehCLpkN1oS5n+LWnhNoaRqFD1w1xOQ9besd7YyZpBg==
X-Gm-Gg: AYBFou3wSCe4g614hmfleW2fCK5FAk3OSVqJ2wqMTnMr4vvBLmfHlCG3RWnB9vTk/2n
	94VfsUNq7fqBoDRjsa7YxCzU7sR9WwH+pUnX7qSHfPi6eA4ILd92gpuF+lvu1zVM7c2D7EDg68i
	jGcnuob+25gmHiBqXYRlKICqBj0CMrT4wwabxLxaFoLc4j8pxpSetLjxyApOy1gQYzEn+Wx6/42
	3VwBMyjotruito5pqEL9Zpc9UmYjuraV5UrWklkoTgvcruGn3Y8fSDmVJ3USMDSnyR1YJZ46Sqc
	qOAaEMSfket9Z9bjAB3LW1dpxCi/YEsOTkO3ERJU2m1yMmICcAq58SpMYdo5RXYPf1ZzP2euINl
	ojF0N8499q5gkxkmexLXiglwOqKFkvIf4ketY4GGppPwXFLGvkZoXWAQCyRw6LTKQpwNkvDQ=
X-Received: by 2002:a05:6808:1b26:b0:4d6:90f3:74a3 with SMTP id
 5614622812f47-5638439be59mr3259317b6e.46.1793255919749; Wed, 28 Oct 2026
 23:38:39 -0700 (PDT)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029002052.54117-1-dennylin0707@gmail.com> <2026102957-suitable-gesture-be83@gregkh>
In-Reply-To: <2026102957-suitable-gesture-be83@gregkh>
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Wed, 28 Oct 2026 23:38:28 -0700
X-Gm-Features: AclHuK970NKTknXqhyuBgBwWz22aYrs_CUFSUWZhOmuLQSID-Urkoi621mgPKbo
Message-ID: <CAGEkeHft5gqu1Kq0saC1O0hg+ZE9AEO1tOgeXmd-g10uk2obgQ@mail.gmail.com>
Subject: Re: [PATCH] tty: n_tty: convert the full VTIME interval to jiffies
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jirislaby@kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> What real system uses HZ=128 ?
>
> In other words, is this a real issue at all?

AT91RM9200, for example. arch/arm/Kconfig fixes HZ to 128 when
CONFIG_SOC_AT91RM9200 is enabled.

OpenWrt also uses HZ=128 for its at91/sam9x target; see
target/linux/at91/sam9x/config-6.18. It publishes images for
SAM9X60-EK and AT91SAM9G20-EK, among other boards.

Thanks,
Hungyu
