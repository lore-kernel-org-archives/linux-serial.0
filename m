Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793450277;
	b=t+Kwul0A5C8IXxkrbgBt/MOH/yWDL1BlEhbmxDs66OvRiqBumZq0WfKSFjMuphNZeRnb
	 +ihxLHVgTXK19QRwhlJZ2w1dN4cI1jN5yGq7nA9DzmXrQDc/lUQ4nLNu/d0Qff4nnIM47
	 x3+BjPWasiMbxgVPsNlQR4QHe7+0SEaohYbx7pcmKGBsjJ3dESMRqZ0I59Wx29G8d/QLx
	 9EwI3X3G94jwVndmeMNzZ4mRbZxOIwWhrSMTXHgp5tBcwWPXhvLCz3jSoWR00qFj5dDKa
	 ww29l5XsF+jlpb725uucAXB9Da3Td8ujkgYP0o6QZtTxXgwaIdLlvERxR7uarzH1xbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793450277;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=PX/w5mj9R3qkptDA+QYolfzSb7nBXSDEWkIWU6gsyAI=;
	b=uYwfrkR2FaoZaz4OrEYxatUOZNE5DU0BJIReHO9gB/kh4HUcDHIJGKG96UkLldcWcN0j
	 4JvP6rdA2Gdc2+KftTX1qZ+20XAHX3GYL/2KR5lL4Jg1QzQ9MrDzqpp90uwDvHor/eRUb
	 N3OUbsylxLzgJYQ+DGcvSyV7hizn+mp20ZhJ8lUkZxClhtcA6l40JLVVmqeWGD/dGn3a4
	 scLNSizHcelJISMNm0vDjeOI1NF65RGbjc+2HsKfXcwKbH6I2MuWrHtsCFP696RJTb3Nk
	 LXYGIPi7IOT8cDbvEaOVVb1yi7mT8nMWV7OWun5QwY07pXXqlUNpCqCTWRP1c+ABH5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GIapd0vK;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D65606A31D
	for <linux-serial@vger.kernel.org>; Sat, 31 Oct 2026 12:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8D65606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GIapd0vK
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1a3c08d6928so2077019c88.0
        for <linux-serial@vger.kernel.org>; Sat, 31 Oct 2026 05:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793450276; x=1794055076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PX/w5mj9R3qkptDA+QYolfzSb7nBXSDEWkIWU6gsyAI=;
        b=GIapd0vKx/2mPeVtvd/1JjMJO/Q3LFx62uc9QCJus5BZgc1tTNZkaOxr6LDDHwNNV1
         YB1hL3u20alf55Y+djSl/+I2Y2qZTPcZdG7LKHjGjgCFcFtlJWYNa7QKD2qk1J53FEyF
         WqE5VttFOLtyZclRbAkPporkGokYtlgigDbsYergx6yMwpF15KQfiYsnTi3itIVJQG9y
         SbyVy7c+xCpATPw6FdjjQa34SuLAVtVXf9TR4Eoobqfm1N+E97zeadtPiUYGJZdyqZow
         rpAprqVNFL2+TwRx7H24RkSGfIxbEpB1bUIjrdIihVRQkWgSANYQm+Orr7TQx5LdoXAC
         +wMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793450276; x=1794055076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PX/w5mj9R3qkptDA+QYolfzSb7nBXSDEWkIWU6gsyAI=;
        b=BMb8CoYLiyRnbnKTwaRTfvopG+7XpV9bbtZ/owbspCetkyE4wmZJEoe9n2q2st9NL3
         XD3Bopr/L/9A0oxVCmk5yveBgKpAPEggDzbqisdh9HXVrhKn0GN+NGB8XutwvDGPRY8p
         9u4WF7unaOD/eE5iZ6za8qhvflmTNWgA0A/yzDUACUVqP43qNgSamlsx0+4eibpmpzuX
         GMKtW/4pqwcMTviPwCm5W+KMHCLwgBxbvgKpVFxCkSCa541tt1t8IuD8LYwvvr5brsTB
         CN/NUJBpji25R9yx3eME9kVXkFy4f4bNRiSH3ULiI2fWpoKLF0Wca0FJ5Lwkppt57QTR
         3yaQ==
X-Forwarded-Encrypted: i=1; AKwUvByEINGeij05zgebiQbGPdGohW9m4ohppQhTtKaetgje6q4aNBiXFDaQ2suM2GdqkCkojx4yhJLE/pkaTw4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKIFqCvroZpIuw+bSdcV2JKCT6Bx50xPIXYRi0vNM623CLzz+uL
	zds4M8gvM1pMI0FQpkUE/lMSu7Og2geVXWk4AcLK9Wncw2c8pTsgKV6l14yRt5OwYng=
X-Gm-Gg: AYBFou05aC7Vgo/pZp1mj9k7JIy2aKcT/mO53ZCcGSlTG24KcEy4PFoUtSn18RKlyKH
	CEsjOmewmMb3LHIiDSEBTRpYXVyadkqo75uvtxpthQMjDY3p1OXaekJhhvwVxwG99iuYdciomIH
	LkKF542dtIp8hByc314mRxb4g5xWcHoPkrsvqGorU30N4tadJpa8zBfU6WOLfGBXzLqN1Qk0/v0
	3V5Z+6yQSwvCTr/XsC8N5SSKIYpYYSmyO1trecT2rLWzscS10psqFeEX206mCX59qGiOzO+pjzM
	oPepjabMGnLZkmvXFdZif5NNcQ0d/BiPPNyHDQ1kxt1cmE24yitFHdZIBCrBmdPRCTq6WoAVwjv
	6SNxaflBWRyBjiu9bglUDRiIK+fi6cW5A6Afj3O6eZ8VbKcipPRLVgxUhEAqZGM0rDP+GwUkMIh
	gFNCfDJaQQnOhTpV/PxihVpG1qNpHRMm/JBCR5QXv8KVHiViukk6l30k4wByULyVJNjx8RCncUS
	FKcoZgANp0j8A/3ZyKFtM0VlaTcQOp8CakGnheaP33qMkAduANSaHz9md7Wkn9B0jn7X6G2/hB2
	T9jo6xbR/vFTBNPYnXzWZ1ELixNsPE9enjXRR/iwqyzd6E0LgZ38S2t43hvOt4iZl+NTtOgcGxr
	r2i8OkYkJQdWQKfk7GGleqSehKwgJETmQsX2dKRZrXmav7VyKfRl3ufE+cS2i14Vs7jDWiQD9GQ
	qQXzTgi/3T6oRKBN1lcuUs8DEdiIVD9yMagUk=
X-Received: by 2002:a05:701b:2094:10b0:1a9:f3d2:6262 with SMTP id a92af1059eb24-1ac5d69f68amr7196755c88.36.1793450275760;
        Sat, 31 Oct 2026 05:37:55 -0700 (PDT)
Received: from brev-9gdpyq8lp.ap-south-1.compute.internal (ec2-3-110-210-194.ap-south-1.compute.amazonaws.com. [3.110.210.194])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1a13652csm17300763c88.17.2026.10.31.05.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 05:37:55 -0700 (PDT)
From: Samarth Narang <samarth.colleges@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Samarth Narang <samarth.colleges@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-serial@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] serial: keep the flushed TX buffer mapped until DMA has stopped
Date: Sat, 31 Oct 2026 12:37:47 +0000
Message-Id: <20261031123749.3783352-1-samarth.colleges@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261031005425.3351240-1-samarth.colleges@gmail.com>
References: <20261031005425.3351240-1-samarth.colleges@gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series addresses the DMA buffer lifetime issues in amba-pl011 and
fsl_lpuart reported in the parent thread, where flush_buffer() unmaps
the TX buffer before the terminated DMA transfer is guaranteed to have
stopped accessing it. In fsl_lpuart, the buffer is unmapped even before
termination is requested.

Since flush_buffer() runs under the port lock and cannot wait for DMA
termination, both patches request termination while holding the lock and
defer unmapping to a work item that first calls dmaengine_synchronize().
The TX completion callback leaves the cleanup of flushed transfers to
this work item, while shutdown, and suspend in the case of fsl_lpuart,
waits for the work to finish before releasing the TX DMA state.

Both patches have only been compile-tested with arm64 defconfig, the
relevant drivers enabled, and W=1, with no new warnings. I do not have
access to PL011 or LPUART hardware with DMA support, so testing by
someone with suitable hardware would be appreciated.

The imx driver also needs a fix for the issue reported in the same
thread, but requires a different approach because its TX completion
callback unmaps the scatterlist unconditionally. I will send that patch
separately.

Samarth Narang (2):
  serial: amba-pl011: keep the flushed TX buffer mapped until DMA stops
  tty: serial: fsl_lpuart: don't unmap TX buffer before DMA has stopped

 drivers/tty/serial/amba-pl011.c | 54 +++++++++++++++++++++++++++++++--
 drivers/tty/serial/fsl_lpuart.c | 53 ++++++++++++++++++++++++++++----
 2 files changed, 98 insertions(+), 9 deletions(-)


base-commit: 36aad21d50d1af3f6954bb0c988257a908202477
-- 
2.34.1

