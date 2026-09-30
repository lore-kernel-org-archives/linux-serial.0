Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512BA3A874C
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 07:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790754541; cv=none; b=I+RFg1uMq3TuhqypHiINiUU76DHtrq3goT1SBecO0Ia7AMlWHvvgwa1W5CTsLoUgBaTmiNtGDnS+6xhfD9y/HgYHFs8WOA9FW9xYSZy0EggSxXsuYoFvS9R/A8que+WVimDFMJJMYSiX/pwmmD74BMOrx5gMGWq2UT7++3yS7Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790754541; c=relaxed/simple;
	bh=uGsfs2DK/8iKOR0jIBI43Dd61dqBAmynhEDo4Fw0n6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vtt15PqiWUroenLjUu/CTsh+I5DDFgA1R9If0uYH0s/eKJFJjrwChR6hnH1n9Wk0uflI5JjiBaCvR3wOWksuq1HDDg8fMEzR1aDBR+39Y16llOmEoBYGc630x5dcEi96949bZT8CXOSSqyN4PyTXftZsCMl7XyxGGSiB4VywSis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCgUqWe2; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCgUqWe2"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-86e6d007703so2372549b3a.0
        for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 00:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790754535; x=1791359335; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CLNiYBnWBySrGmvyKG0sfUJh2e5Yl6VfGdIE3Jf5vdA=;
        b=MCgUqWe229jck/GKLd8NY5iqGSRf6cOkLmeW2bXJynXMjZwE2bL6maMLCnTsHKZ1lt
         8N9vTpPmE9VAUO3m2cWYCIyK50itSzTsiJoSy8u8YpsmTKQ5zUgVfgZdQgasVOXAAbMs
         bApMZ6gsBZcxH79DUzZutqF1ClUB2OuCO1wiKmdGOjFRImbnI1/OkMeV8OJ8ZUP+8kw6
         N5Qfx/c6EZJu6BxACdkz6GPrMm6HrouhOyALGDtkOqHIgtXDUwiUegxzJl/lfhZL1uVq
         0F1pqzV2EfCwAjlMW7+PPOv5AJ2NeDkcKVkYwREmQkJSeGxWVxnC8oi0RAr2BwNjKpdf
         6s0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790754535; x=1791359335;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CLNiYBnWBySrGmvyKG0sfUJh2e5Yl6VfGdIE3Jf5vdA=;
        b=batffnRRslTWt+iiqzRfvLkOqiMBLiWri0HfIQ5fMki82UzulQhQd8jgU6Bw4EzhnN
         R+Btt/K5STRuCZbtn0EymwCD+QHsiqGpWLPbPki5hTYSZgTc5aJv2s6I4kqRAI/siIlT
         JHWDSdjpgy1b/F290tGVhb/13KQ8TENaVyjuqlzW/HZmoLjnHK94H/FqzT3D1V1WymYG
         x5XUbg1c5JXLr1pJjbm/D65cAe5K9guQRSXt4G/nC+Zww+jey90Vg4/3+wRSMxn83fGT
         jer2rn9DZXY+6cJFpdRxpVS9kWq91JRTl+48lsfSLyQsBY8XLFg4Jw/MLtjUmNzsDt8W
         aPBw==
X-Forwarded-Encrypted: i=1; AKwUvBzjElw6ZWJgkc7I6Nu5XgVFniY1Ezu3YYRvFljEPYEAD89Giaas6UaKMTaRy2P7pcOttjGfgfhef/V6f7c=@vger.kernel.org
X-Gm-Message-State: AFuF++nQ6k6v1SGo1qzdtNOU8635hsKxXdIbBQ5qtMIYPgz1XwJGFcI6
	f0wQX8V71Bxs/piRGUkn2iPvCAYHsGewxacoOxYzTqMkdKeVZymKRfIJ
X-Gm-Gg: AYBFou0kptGLhb+0/0CwS59KOtUmxv8zjwEBdrwglgrEA0tJpn1+/UB/zVx5XD0aYPg
	JRtwqDsQtD89WPcG8j5E7OtxFIdMkfRzBfX9XXw+ssaT3fcb+32PqYkRl7SvmmhgoALijzWxYMX
	b7l+XQdQWCJQajAHUWn0UABKJNUsaKIg0L6j38LOq+cjJa+oLrf9Rl9I8PiJTeq7uIGMu3BiN7j
	cUe1UdPYeQTRtvYhftyTpG4UApcpDm3tx70j8crzryU7wqpUN9teAPmq7VFdhwbCC0qOjJ1SpvA
	eRb08BvVO0b0dJG7YMYn9F/YmCG0vER9BUFenyNuUUnhVh0TQqB53Kj/bV0D7/X7N4MhRSd74Mq
	E+7pC/p8vm6Mx3ICtwtHCFrvR+oQuDrlhJIRj2LH9iYre4PgxMHgXuy+whyXSGZNEkD014gZUvQ
	qCszm2Nf6gCWzDOY8enltahLwSCSXwUW8k94vIlCeHtLIgtBavnGwC4N4uZOd4iGLUQ/WUNA2Gp
	b9Pfr/B6NDGrJcdaBx8aixurp/S5q8WAUFHiHwKUHTt3ykB4Zt0PW2Ms4GuxBkeAJPt6XFjTLYx
	XMSj84G5Tw==
X-Received: by 2002:a05:6a00:4b07:b0:886:8600:97e7 with SMTP id d2e1a72fcca58-8874a4b0f01mr385952b3a.27.1790754535369;
        Wed, 30 Sep 2026 00:48:55 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88725881fa6sm376732b3a.27.2026.09.30.00.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 00:48:54 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v6 3/3] serial: core: reject baud_base values that overflow port->uartclk in uart_set_info()
Date: Wed, 30 Sep 2026 07:48:50 +0000
Message-ID: <20260930074850.465003-4-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260930074850.465003-1-benquike@gmail.com>
References: <20260930074850.465003-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In uart_set_info(), new_info->baud_base is multiplied by 16 and stored in
uport->uartclk (an unsigned int):

  uport->uartclk = new_info->baud_base * 16;

While uart_set_info() checks if (uartclk == 0), when new_info->baud_base
exceeds UINT_MAX / 16 with low bits set (for example, 0x10000001),
multiplying by 16 wraps around in 32-bit unsigned arithmetic to a small
non-zero value (16), bypassing uartclk == 0 and setting uport->uartclk = 16.

Use check_mul_overflow(new_info->baud_base, 16, &uartclk) in
uart_set_info() to reject baud_base values that overflow 32-bit unsigned
arithmetic.

Tested in QEMU against Linux 7.3.0-rc3 by calling ioctl(fd, TIOCSSERIAL,
&ss) with ss.baud_base = 0x10000001 on /dev/ttyS1: on the unfixed kernel
TIOCSSERIAL succeeds (ret = 0) and wraps uport->uartclk to 16
(TIOCGSERIAL reports baud_base = 1), whereas with the fix applied
TIOCSSERIAL returns -EINVAL and preserves the existing uport->uartclk.

Fixes: 6eabce6608d6 ("serial: core: check uartclk for zero to avoid divide by zero")
Cc: stable@vger.kernel.org
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v6:
- Use check_mul_overflow() as suggested by Jiri Slaby.

Changes in v5:
- Collect Reviewed-by from Ilpo Järvinen.

 drivers/tty/serial/serial_core.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 95774b0f1484..75bb1eaa27e7 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -935,11 +935,6 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 		unsigned int uartclk;

 		/* check needs to be done here before other settings made */
-		if (new_info->baud_base > UINT_MAX / 16)
-			return -EINVAL;
-
-		uartclk = new_info->baud_base * 16;
-		if (uartclk == 0)
+		if (check_mul_overflow(new_info->baud_base, 16, &uartclk) || !uartclk)
 			return -EINVAL;
 	}

-- 
2.47.3
