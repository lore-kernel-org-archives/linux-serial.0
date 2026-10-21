Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792622269;
	b=uHB4EdV7ZS8VryF8qJZWzZNU/HW08+qUV38Q1l335qO1mdZEYlLdz+VEYZAboGULSSqT
	 hCDRpswl2AIb+ts3jJMpJYXDCKO04R13AKSHLnfAZkVIE+7zyYXa//FpUAwyJjb/knHwj
	 Q/zZblUI4xYAxtel/aKXW2rtcUmKOvPsYpkgR/Qh9qHAxNr9gwpXSevVaK1t0GIDdQP2+
	 vBQ/pad29pEFG2jc8EbkrMx5ZEPWJ1YtqOv7kcGW1zcBZLYl5wi5ZohEbsSxQwrfFvtjF
	 6CHRtnzd4MvMGutn3g7WfmAzKLukHBNiCUjD/vMm9QteojjvrqcJm+F/uy9DyyYkZDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792622269;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=0wP5I5Jhcbwyv568wbMd4NHu0ctYeOKtwMrn8vLgYrE=;
	b=c1pcDAva7nhIMydGu7FC2V6R3+0Gummka/v79aRx72MmSmflmFaNYNKphToxRvC8PDvL
	 Bgrf56fefn2uHuAKuMCyEXBkRcCiojHXlqao3zVJ8XX/E8bgzqtOad/FL1DjBla3Ylwhl
	 z1EedMVr6tIRwsH1HK+9wDNrToWJp5iagNrP6STXlgPVXvjJArkLxMIoKh+JnM2QEow+P
	 7O/7IGhNberqi9NUXASG3FKgcy0hezojFd1RcwgrCmRp5Mx2S1Z/yfxa/Tyf8VsOU8vKP
	 7y/OwJBhBP2mXYfNPA3j27DRYfnW2NjHLIZ/fLSY5vuciryLXSwZ+RmWqykBXPYEKKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NYUaD0Nz;
	arc=none smtp.remote-ip=209.85.210.54
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE05606A31A
	for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 22:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAE05606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NYUaD0Nz
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-846566246e8so286765a34.1
        for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 15:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792622267; x=1793227067; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0wP5I5Jhcbwyv568wbMd4NHu0ctYeOKtwMrn8vLgYrE=;
        b=NYUaD0Nzct+fMrgf8/gyouUqIY4INZ28n0ECbaivbn5kFbe7NPPnvO40kbWZInHPlz
         Z+SxQRz5tFQjjxzBocyGyJ6Si1UBXVjnAfPW9mWjwpemZ8mf4gWrhF0zdDeVmEXl3FsK
         QMv8oOZ6FJHQDZBP/q1F/P0O1Qw3RjiqzA47lOTepdJ3ve1gIh1J4RZljM9ighXUXi+S
         g089KaFhEmaMDvOF/PlL7RkCHMUqsTDnD09JbBZnUb6XgwOnAfNa6vmlv0j9nFPecKaI
         z52DE1K/i7V62DxJbMsXSmtsZu/s+d18MD5fyMmuDFom++xdjwNNXMspj36K0HSkeTby
         cHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792622267; x=1793227067;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0wP5I5Jhcbwyv568wbMd4NHu0ctYeOKtwMrn8vLgYrE=;
        b=IL36gKRT685w2T9U3ab1JcyVcYkZdds/B1vi7URsEyjISu83A4O2km8GBR7ocPTy+t
         FFHuzfzIdCOqE48YMeBo+4Ykb0ybsPYKR+478sJGh/TizJO/nhWfIxD4/N1qFVwkFcKn
         ellKzYEK8WB+amU7C+Oj9e8cPdlDd4AMC9aXloI0P7+Fn49X+uyNbJhNJ4h0jWCrEyI9
         2Rk1irh1A01Iba2GyiADZuaqltbmxIcuXaZgleZfLmoio2pkkmjRNlSKSb+n40/+oKm/
         1bkoAQwHa0y+qMtZFHqONQNzA6CzmBi/KzxebSiSAhkdVrKruK2BeMR2UhMWKtjGdOz8
         Cyig==
X-Forwarded-Encrypted: i=1; AKwUvBwLx/aB3P/IJ1N2DhmqE3ubC5pQxqthsXQa5GRdR3mdRRMmwiZH/IXAVDAOdR7ALYxwbK9CzFH8m+Kcj44=@vger.kernel.org
X-Gm-Message-State: AFq9FYK3qvb9i2KoCEbbTS8HsI14Un/VFbpLOWImHk9Qjxyx/768vPdR
	0FpVQREdS+Xb5GwOUHm5ClAOu06Rc88tWKWFtQ9Jd4GMF2bnUYwHXSKc
X-Gm-Gg: AYBFou07x8WjfruyagqJCnrHpIyoTmV8twbF9sIJjb7gA1tzWM0Cbm7WN9Pibp3SFjA
	JQn1M3l6NHkHtc9vQjBYsF77UlgG1/Jd1DymTcp1djyXjt+aNi3aSPIHqT0Am5R1cGdT8zS6Oqc
	8vjbbFOeEIc/m1wIpv0NNeYBP5lFqnNNG5WLHg4leKjK47ox6mPWly+aHjf2Dwb2vRr4AF4CCMG
	YE/HyQl6tDsYA5g9kvlBewQfe/MrpKOFH4jhAxSklZDKglWiyat9vCL7yG6D5K5zBXileZYqLRN
	DA0BFtMfz/b6vSuv63oVvquRe+/ykwF3C6DhBP2uviYGDqsoZA1O2eVF+lwOLzf/iAJmxv1va8R
	ddweX+tANN6Fspy8gaTc33NKrsS7kY04NTDl8KozjIqygIFi/95EZ23EyGyqFf58X/QQy79riqA
	1tbCOiXPs4J6ks36y76nB7XkQD6o6/uRaLMr+froVp1iMFvqycf0FNMzfNGaPBsdXwNP6Wn/ZJm
	91GCslSi+YiooDfF9DLVI1V4ZTu0liDdiModVkr2yPfY7cHDYxasjvr4F90FxLZovuAgExLJLTa
	3We81M9KNWMyYbRGk99qR7L2wMNqziuDCKyAxeOpEQw8+zcGPIwLxS/StZL5zHPWabCIoF9iZDC
	5gVtz12X24BzH8J3zdXR63mGRPu6h+zc82zCceKvNcNhmSZuUy7GG9+I1EpmiJaTVk0/fChSqlC
	4fqg==
X-Received: by 2002:a9d:6e83:0:b0:845:d6e7:22b6 with SMTP id 46e09a7af769-84e348eedecmr337297a34.34.1792622267629;
        Wed, 21 Oct 2026 15:37:47 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-84cbddc7100sm3538837a34.24.2026.10.21.15.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 15:37:47 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH 0/2] serial: 8250: serialize DMA cancellation with buffer
 reuse
Date: Wed, 21 Oct 2026 16:37:42 -0600
Message-Id: <20261021-submit-serial-8250-dma-cancel-v1-v1-0-efe2b89f2303@gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WQzW4CMQyEXwXl3KhxNj8Or1JxcBK7bFWg3V1QJ
 cS71wu9cOhxoplvxrmamaeRZ7PdXM3El3EeT0cV8LIxbU/Hd7ZjV2288wmcBzuf62Fc7BqjT4s
 +OtsPZBsdG3/aC9jqHQoGxtLAKOZrYhl/7hVvu4dWxge3ZeWujkoz2zopYb8+qWHi79d/G/6g6
 jnr3OVBfkDa6aDjdD5gEMzsc3GMJKXyAJAkOeyeMdWQi++531G0tL1eud0MyYUqRANB8xBKyZ1
 BQIO+IlCIAUgi1edULr27MojUIbKPgbWzq0LELOqHmoKUkJ9T6Ci6BB1DczFSCi0n/WIUrtwhl
 5Yw11LE7G63X65MLAOlAQAA
X-Change-ID: 20261021-submit-serial-8250-dma-cancel-v1-b208f84e89c1
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Raul E Rangel <rrangel@chromium.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Keep canceled transmit and receive buffers reserved until the provider's
completion callbacks have finished. The TX fix also separates the DMA
source from the serial core's kfifo, which is reset before the driver is
called to flush a transfer. The RX fix keeps partial-buffer delivery ahead
of the PIO fallback while the canceled descriptor is retired.

These changes repair the existing finite-transfer DMA path.
DMA providers must honor the existing terminate/synchronize contract;
fixes for providers that do not are separate DMAengine work.

Based on tty-next with the posted shutdown guard [0], channel
configuration error handling [1], and RX TTY accounting fix [2].

[0] https://lore.kernel.org/r/20261021-submit-serial-8250-dma-shutdown-v1-v1-1-3d3ce383c614@gmail.com
[1] https://lore.kernel.org/r/20261021-submit-serial-8250-dma-config-errors-v1-v1-1-c067587d1ef2@gmail.com
[2] https://lore.kernel.org/r/20261021-submit-serial-8250-dma-rx-accounting-v1-v1-1-c11795914ab4@gmail.com

Assisted-by: Codex:gpt-6-astra
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
James Hilliard (2):
      serial: 8250: drain canceled TX DMA before reusing its buffer
      serial: 8250: retire canceled RX DMA before reusing the receive buffer

 drivers/tty/serial/8250/8250.h      |  20 +++-
 drivers/tty/serial/8250/8250_dma.c  | 205 ++++++++++++++++++++++++++----------
 drivers/tty/serial/8250/8250_dw.c   |   8 +-
 drivers/tty/serial/8250/8250_mid.c  |   6 +-
 drivers/tty/serial/8250/8250_omap.c |  26 +++--
 drivers/tty/serial/8250/8250_port.c |   3 +-
 6 files changed, 191 insertions(+), 77 deletions(-)
---
base-commit: 1184f87e2790e8af9be3116f608d2e86b4792d7d
change-id: 20261021-submit-serial-8250-dma-cancel-v1-b208f84e89c1
prerequisite-patch-id: 3604bfaa3a1c214997de1f11162b81a4541af5ab
prerequisite-patch-id: 79dd093ffb35e254e790dffb8887faf51b64f947
prerequisite-patch-id: 80a5061d84c055a64c760268febed179c687b99f

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

