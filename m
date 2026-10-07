Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FA138DC54
	for <linux-serial@vger.kernel.org>; Wed,  7 Oct 2026 09:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791366452; cv=none; b=rpXXOHVY+4njDnoh5NAUOj4xGWOdnne9S4loULV1e2vfFgEqiWh2nkVArtUuwsGy8/ulwlsMP1qGuH7gjHj1SZHdqxa8OdZmY5Ir2jU7Omjsz2aGkpvEz5/Lxlv+EtJhHop8vKglMIb0dS5phrlhZcl9nfh3U77ooM+loU/Zpl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791366452; c=relaxed/simple;
	bh=g80PFUph4ibDHloeyB+7t6p2oepxRcwNrKkYhWZ/D8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tpu6Dh1DxbQew60jzLapR7kLHTseiRSRJfH9g8wasbRztfc/S9PU9CP9VEwa40wSNVSz40ZkFBvgURLDNP+J+vckgFQiwOStcEtW3rUx8FJeswgjL0P4FQieApJFxCcX0ya1KtsnTfjzQ77wo+nucqaIoREb/kRaQuQqdQekdlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lSYSVjfO; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSYSVjfO"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3a4b9732d5aso1615934a91.3
        for <linux-serial@vger.kernel.org>; Wed, 07 Oct 2026 02:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791366442; x=1791971242; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SIXjivVbQJCgdZ82dSTwxSq9rPlm7KuY+QIYP6gq+2I=;
        b=lSYSVjfOJCKPjNVo7g4jFWFfTfqBgOyA5cOFuMsulSykSE3ROyqIrQxa9iw7iC3+nb
         m3whBSckMUuPJaPmJgAzFfAhwoFPX97ahHnxwq0XNbjINJq4cnrHdcq6Di6QZwdnDDXa
         4mVc5zfh0LejmVPUPlB+8xtzyrBu4wbVjituvu1zMuZ+Xcr9VPSMpjv4cu3rdQ9/Y/ZR
         P8reP4YrQxBgh6UJKRtcRyyQwpBswuc1iJG0pzRsrVAxPAjD3pMpaTFjpA2YHndkPeDz
         8mtXEnMroZrNJIu967rwMbU0flWVgxnV4AxSSUQ3P6mfqdLQ77H9JDCbIvaDxz+GUmZQ
         R2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791366442; x=1791971242;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SIXjivVbQJCgdZ82dSTwxSq9rPlm7KuY+QIYP6gq+2I=;
        b=aAa3EthTXZkxqGZOpg0ywWBwnet7VQhuvyWYKYcWnB2gNHoioa7NI2ykkJsMaAZPt9
         9RasiI2KasA521E8kns96J1csiSCpStmJjavpjl2DnevAn2SmtzIpi1WFqCFi9ObYj+B
         sMKueJ+NhtVj8fdIChOqiqgpD619NBppj3qaBj4eJydx5dJnaNXOLE6JA+reRez/x17s
         78Q1kxhEr875Vtn0QMEd2eBGDK6E6HZ9zP+N58mad1dCSYo4GDDd0LypSLfXhddfhgPU
         jsw2HlLX6UMiwimGKaxUDVgB32KZuFdaXcmwxYRwAGMJl6YxB6zxWxcB0rZsf+Oil/T/
         SD7w==
X-Forwarded-Encrypted: i=1; AKwUvBx13SQnk61DbXFprL5kl4UC+ymO78wTXuIftakLPPN+f9dsxPS8kbI6pFytpY+srL8ibRI+08MsV8xlWKo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ5gk4kws0DDTem5gLnjCtxJT0SKDZJn5rJxy7pqZVCwjnlQZfZ
	GpOsnJyo5F/lGvyzzNbvTeLabysv9AtCG2ZqH6AOl7C7aM0COVuxYUGoRtxVNKt8
X-Gm-Gg: AYBFou129gAKUgPSYM4efjIInQWzdT4M281WDzZPSF6GIS2a2eIX47QnMuK6I8+AbfP
	tnWiyDkmAQe68yxjMBsBzRwUbMpFqbvRjtk0iCJYnlYIAG4DggpLsl7joDblKN66zWF8sLxEgHO
	VLNBoy1e9uigUicxd2UjFg8KZ8W+WL1bo9/9D2r21I5z+thaccGxFgnPUH/0N2XW/nEd9wVMKay
	1a2W0gmKBi4YVaDvZLmMOoE7vIfwHEyvLnUJSgHpwSxXSCJdtiRdpKgm9Ab0fP6wNDo/iKb/roC
	nFraIJLc2sPMbj00BiKV2b9bltm+GdKOKL73a9VdVc+7lqeGFVrDu8O2A59S71rg401vSY7xLbP
	l7mPeMIGDEjmlDP6z5J/ZqR7JxHsp6MlO+H2hoQMyNlcqwOqRxe/0PsuIYJHpK1D9z4SA0a1Hqb
	3SERbHGW1eMlKpplouk6E7n1qOQMw5Pr9TNReQgBJdM4IW8YWoV1R13SdPHXj+5ngRQA9QENlVT
	4CXyQKtQEbbDOde6WM2x132DpPXxvhUIgXX78Bbo/E+CQr+8wUcrN/0W9Z6/C1UU/8OMnx9cPX6
	bm3Xu31Pw4I=
X-Received: by 2002:a17:90b:2e46:b0:39e:6c68:c77a with SMTP id 98e67ed59e1d1-3a8a12bf661mr1450443a91.48.1791366441970;
        Wed, 07 Oct 2026 02:47:21 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a8c46a2f9bsm265866a91.2.2026.10.07.02.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 02:47:21 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hugo Villeneuve <hugo@hugovil.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v8 0/2] serial: core: fix baud rate fallback loop and baud_base overflow
Date: Wed,  7 Oct 2026 09:47:16 +0000
Message-ID: <20261007094719.1362769-1-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series addresses two issues in serial core:
1. Division-by-zero WARN/Oops during baud rate fallback in uart_get_baud_rate().
2. 32-bit unsigned overflow in uart_set_info() when multiplying new_info->baud_base by 16.

All patches are ported to the latest tip of mainline (551c722f4080) and
dynamically verified in QEMU KVM with CONFIG_KASAN=y.

Changes in v8:
- 1/2: Rewrote commit description to detail the step-by-step loop iteration
  progression (try == 0, try == 1, try == 2) as requested by Ilpo Järvinen
  and Greg Kroah-Hartman.
- 2/2: Dropped secondary Fixes: 6eabce6608d6 tag per Hugo Villeneuve feedback.

Hui Peng (2):
  serial: core: fix baud rate fallback in uart_get_baud_rate()
  serial: core: reject baud_base values that overflow port->uartclk in
    uart_set_info()

 drivers/tty/serial/serial_core.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)
-- 
2.47.3
