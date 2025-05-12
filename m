Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE431D5CE5;
	Mon, 12 May 2025 13:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747058063; cv=none; b=GRo+3F/ZKOxvHhrk4TFKKVHlsFiNU9P6uLwJvCQhgTHFkPLkTTAChFaNFfzXVOBAtJ+LlpPlieZ2rUQZxf7x4tU8+PR0P9pdDH+hu+KcU2h9AvoyAz1Lf41ITu9mTCPlsLTpsYHuo1p4xhWIUXxnrDHQVWZRr4W3J8R3LJ9h0hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747058063; c=relaxed/simple;
	bh=8GkWBNNnFESb8efDPn89Tm9awp56Urw0Vq6vCfo5XSs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qzj4CqofUmIoN0vRQUJ6ldOdworxmieDVwHAR+mwPsyo69b1ikIvjXvds5A7xEVknoUIn57mvsnX8HsrPQa0wlGjPyZV0rJvZoCJwn61qo5cwtKeiXWm9rJin3p82TKeZMqFDmHqew11IE/6vB4uoD6W4qqXCpOup90HBvoSVF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJBtG02F; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJBtG02F"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-736c277331eso4744424b3a.1;
        Mon, 12 May 2025 06:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747058059; x=1747662859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GkWBNNnFESb8efDPn89Tm9awp56Urw0Vq6vCfo5XSs=;
        b=HJBtG02FFC/smcWUoZWsUkr5cyuNMcNTunfPHZ+YS6iSK3WrwMXRHsNKFBH/e1kvfY
         WPFzcEeuwpFF6atTklBLb3LBPKIhUV6r58UpCVLT9/YWBM81twl4n1aZrWvqp1+duQjq
         NlCw9Nh4IbCI/0f2W21blvl+SEQbY3XclbfjqmSv5ndajndjt9CR93U8DIGIi7r7dffR
         fJs5ki/mi0J0BChDT+xjKQf1rPWt3AJWizyzJ+mL7tHxKEUnNJlaFsxaoHshKHpRC3ZA
         PkO2CFcBio/JPSLde5ZQWYU8myQ9vK0JQeWkLpRW+HU3zmxCydelAQuzO+kThUUl05rm
         aZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747058059; x=1747662859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8GkWBNNnFESb8efDPn89Tm9awp56Urw0Vq6vCfo5XSs=;
        b=g5lyHNkawKQpjtzUpzTCsJfodltfNgbdOOqdmN9lK5u26hwxn0S6VIQBYwf8h8NIQd
         suJK8VE33JzgC/gNbZoCB/VKpT+sQ0mvpcW2PtDFeKakWGaOhXO+rG2FWGYrS67JFN+Q
         0heuKBMho0udg6myab2Mr+T9J2DFnmI1gbb6RtCOwhNdp8cfusvAUNZ3/+4gPE+G9CVI
         Mzzom1Fe3+lDq/tTwhchCxyKz6CTwQkObs0oOca4XRxRqoqJNFeP5LeKuYqU6RMa6JlW
         xH2xjxpByh8IQTR92OjX9jFXiuIVzP6ZqGoKVa44ZFwesBU1p/2cHX75oyLGq2CJlN55
         rlYA==
X-Forwarded-Encrypted: i=1; AJvYcCWGm8L7cA9vvSYYClKzZ75DDX2qylAY3OaW1Wt4ECG7/OoT+qxeB6Dn1dhjUG6QBZdwd2kVioA9oGykFJCr@vger.kernel.org, AJvYcCXvwmBidAMaEGTlq9J4zeA8CBSAkmdGyha6yMx12rKe+yjmtamfxouuPWi8s3Hv8MkR6Gm4uwVe8TbEr74=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWCzYr+eAf3UgBcR4ebxw9K7ZnHOmCi1Pf5gr/maTgUAj8qvGg
	eMCUhQIC/WvbccZEr41/qRqUgBRv6Ja1fG/3kGenmFvjWxHsxW/O
X-Gm-Gg: ASbGncunkeq140Bb4vB3ZhpXoEePkbMJlnoSBT7uQnkOnUen1lkwZOvlQdayNx94Ufb
	BYsd7P0L32Wi6E+pKfAox+dPWz3el6I72vjyMj3Xjo7EliwuEkUY8Hj3Kh9mXRx0rp9dMs/Go65
	JZobigkRNQS6NgC/vGHVoAOKPqLLfTyYiypAl5HNeEM5vQhD0MWzjjPdZ9s0uIkYB3nkKsHhvUs
	Q47psWu1wm47xc+ZiQuNoE82XCBtRuBS23JCMrE0YVZEcUATFSnfatXd6IwsaKRKIslk7aqrxWE
	0aj78/6q2+sqpoqgQRAiBzOpvzjlN8cOsxr5vE+1Ufeqr9RcPs8591sw64i/6bJed4vOcWDGQN5
	Dm7KkvMhHq4+ajET1aveTFD4hqyYv+m8AD7nrKPI87i6O9XhI
X-Google-Smtp-Source: AGHT+IGcwH4xhgzu92EngbJgz8zitgY8MX8eSyq2ibCraSh/UyRp78E7gCvILjWHKR9masBZ0d4tkw==
X-Received: by 2002:a05:6a00:3e20:b0:732:5875:eb95 with SMTP id d2e1a72fcca58-740a9316019mr30196519b3a.4.1747058059150;
        Mon, 12 May 2025 06:54:19 -0700 (PDT)
Received: from DESKTOP-NBGHJ1C.flets-east.jp (p12284229-ipxg45101marunouchi.tokyo.ocn.ne.jp. [60.39.60.229])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237a0cdf0sm6245501b3a.98.2025.05.12.06.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 06:54:18 -0700 (PDT)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: john.ogness@linutronix.de,
	pmladek@suse.com
Cc: Jason@zx2c4.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	lkp@intel.com,
	oe-lkp@lists.linux.dev,
	oliver.sang@intel.com,
	ryotkkr98@gmail.com
Subject: Re: [PATCH] rslib: Add scheduling points during the test
Date: Mon, 12 May 2025 22:54:13 +0900
Message-Id: <20250512135413.4558-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <84ldr2xmz6.fsf@jogness.linutronix.de>
References: <84ldr2xmz6.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 12 May 2025 10:22:45 +0206, John Ogness wrote:
>On 2025-05-10, Ryo Takakura <ryotkkr98@gmail.com> wrote:
>> The test has been prone to softlockup but stayed unnoticed because
>> of the printk calls during the test resets the soflockup watchdog by
>> calling touch_nmi_watchdog(). With the commit b63e6f60eab4 ("serial:
>> 8250: Switch to nbcon console"), the printk calls no longer suppress
>> the softlockup and warnings can be observed more evidently that shows
>> the test needs more scheduling points.
>>
>> Provide scheduling points by adding cond_resched() for each test
>> iteration on their up to/beyond error correction capacity.
>>
>> Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
>
>FWIW:
>
>Reviewed-by: John Ogness <john.ogness@linutronix.de>

I'll add it. Thanks!

>Thanks for getting to the bottom of this.

I found it was quite interesting.
So thanks John and Petr for many feedbacks!

Sincerely,
Ryo Takakura
