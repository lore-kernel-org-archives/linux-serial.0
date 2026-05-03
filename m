Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BF92773C3
	for <linux-serial@vger.kernel.org>; Sun,  3 May 2026 19:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777837810; cv=none; b=YS2pnpxRLk9IfF1nrYKiiRpz2oodbcZ0cmELkpL1JO7u3cWITrIir921dN83ihiyQVQgmjtkR1TPM7bmGVzd9JkmeODkzhOF8asBtdOJVqh1SMiusdplrAjK+KDqRsj0MlJgEV8NXSewSEItQI9Gzg9ZVhLTOcAjke3LiqV3s7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777837810; c=relaxed/simple;
	bh=uthZmONBUuk+WMGtj597kAOFGLE8xMCSEXcpDcg2u6c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cn6DCDgNeFwI75H9p+26bjFMgBfQUu3wXvdEe+irTs1dHi/1CReEofki+wCXhVSZWhMk5xDBdAtRAwpY+Vtgk74H0g+jCmFx/Uub6dIQy5iR2CF22tFKNOCVnxuLBh6DenBGdcD/Zpc1vwYOfHqeichyQDfccA6m5oBIKdun1Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icgo6sxk; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icgo6sxk"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35691a231a7so2275686a91.3
        for <linux-serial@vger.kernel.org>; Sun, 03 May 2026 12:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777837808; x=1778442608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uthZmONBUuk+WMGtj597kAOFGLE8xMCSEXcpDcg2u6c=;
        b=icgo6sxkbKXMVEyrPoKTdHKhLIyeZDKnHpo7yNP0bNeXlfiw7+KoWxKnw1r7w6i43X
         mpUm/79/YegCUgnsb5hCbVzmRPsUOXL6hIVru0zCz/jYFTjQ4e2KgE1x0kYbeZ1+gLk/
         1/RwnYIjxPKqypjFzF4U8eQ4E9RkdyGz5nQPpXpZI8BK9YCdhcmIEF7QYw8L6cKgyu8B
         x3nyLHpXu1B6ShqJlD83de2AbjkYOE/uVJq7NqnKClrycEVRbeKw9vKBN4AxcaZpFLRj
         Ucw6zOYdlXxRCHEy7GTj3ltdsFi6Lwe8eh9n5HNAsSuiKlzZ8FNJc9zkOc8GgjoPlTqd
         z2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777837808; x=1778442608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uthZmONBUuk+WMGtj597kAOFGLE8xMCSEXcpDcg2u6c=;
        b=SiYMNXMBp9iLzY2RtjxGWI/S2VatG2zmOM61U5pw/lZLTAtO2mnplgy5hU5vPFH/8f
         8VE35VxFlBcSE3qGfh0z23iNnmKYHMhFzRLowWA9zh2jRMTbigs1vtMDBKufLU2CWr2c
         McaQsPJgUrtlfytEjgmhG7e4VWYFIFk1mhmysqlMbXrI2hoCUXL+qB1qKovxrkUAvQdc
         CG3vBLIccVq/hhpyVftun4xtwE/WLlrfuHgDiwlRmtItP1JLsD4xN2fy6VCDVuy0nJfT
         8QXJFurMs4V3VS839J2gv6f8gTrpzqELmyhJaWLdeSkp47o2DmUf7imI7vM59y9eoam4
         qW0Q==
X-Forwarded-Encrypted: i=1; AFNElJ+e4lWSrIYtQumX/3Njcq694opUM/+HCnpWs54skTQsx5f8T1uEJ9Z5e/vxMV2a/5mFN+ta4WP27NV76jg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhFfCicld75phxeq7ckA4VRKMchBm4RFeW2jCjjgrLpZTwp2PR
	uAvfKo/nIS0Q9AFSgACTC7YeEyYnOaGfbw27bMnHccL8i2RaqMdceg4Z
X-Gm-Gg: AeBDieui3+u1pozldIGaZBdLqTZ+WRl+lrdpbwcVX2HcI/ARKSEpw0Fho587bRtJBzJ
	jiwPrRKF+rX3n7/tgj6tBJsYIfRcFh6U2kT3WMZ3EnIyWlrUL9X9JMZU/UdpKSMB23/+XkmQ3PQ
	LPUKKIOWi+jywu2it78wOij+yi5u6216qISgpUHdkjMJeY+eG4p0mnph4yz0E2DPVldh9fWvuY7
	7I+PjAj2QSZ60xt/b/ajI8m7dmvONBU1at+iHdt4pZNxfTQk5qlchSq3bXzHPriRH9GsrYpG5lk
	mhS8nuzBF9TZf7cKESKRsxj83JQ22WhP6Ljv5xx2MatIY6yGNVGjUpjmsgqrwzdapjnrzo6sa+C
	A9Sb28JESIPOzus2lQ+CC6XdS4bylFAi6/Umh6o6I2iAGt0hkl3a95cbRA01kuq6tgw3OnXddpt
	I1hf+2lseTjawEDvj45lqvY3iWxDGZNYTln5mutCD3yOJUtTCBf7VtfBLUQNAKXMr7Kv9Ep1sA5
	fslhyA983U=
X-Received: by 2002:a17:903:944:b0:2b7:9d86:ad3c with SMTP id d9443c01a7336-2b9f25e222amr62851315ad.23.1777837808409;
        Sun, 03 May 2026 12:50:08 -0700 (PDT)
Received: from localhost.localdomain ([115.110.225.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae0d97esm80224185ad.48.2026.05.03.12.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 12:50:07 -0700 (PDT)
From: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
X-Google-Original-From: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>,
	Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>,
	Peng Fan <peng.fan@nxp.com>,
	Sherry Sun <sherry.sun@nxp.com>,
	linux-serial@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Subject: Re: [PATCH] serial: fsl_lpuart: fix rx buffer and DMA map leaks in start_rx_dma
Date: Mon,  4 May 2026 01:19:21 +0530
Message-Id: <20260503194921.3449864-1-shitalkumar.gandhi@cambiumnetworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260420135903.2062024-1-shitalkumar.gandhi@cambiumnetworks.com>
References: <20260420135903.2062024-1-shitalkumar.gandhi@cambiumnetworks.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg,

Any update on this? It has Frank's Reviewed-by but I don't see
it queued in tty-next or tty-testing yet.

Thanks,
Shital
