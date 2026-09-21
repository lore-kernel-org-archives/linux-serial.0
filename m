Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8544A2DC76A
	for <linux-serial@vger.kernel.org>; Mon, 21 Sep 2026 01:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789954232; cv=none; b=fAozzcwVVqmiuQBOPH829S7OOUI7rlP3zXBKCF+J6RNKB2nR2Xy2a7syzpkO2WMzIRthEMiY9CJj4xCwRyJIYB1ngZgDIKBi7kgwaxiV2eCPMI8v2Ll13L0aOlm4ch0UKK+oPF1CnBiXgLHk+wI/btS6sqkGQ4w0/9v9fRDCI9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789954232; c=relaxed/simple;
	bh=t2kXYTfDoWYw6hLSMeM9i1WMUS5zpvinMMov6e67g9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Um+/n7gTOjQ5S6oM2jlD2Wz6ep48e7HEXUpdj25iXN+yn+YoyDsi8651T2IFEEeIJj5o8b6GKy0qdfjggESIaftYA5ro4OKJ35a8cQrcogMNJUHFWdfkCizjQyA8EmzF/MIyYPruknvYLk3qbl6c4dapliA7Li7Kpvi1PvFfC+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GwmLPTOg; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwmLPTOg"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4cacd3409so2819626a12.2
        for <linux-serial@vger.kernel.org>; Sun, 20 Sep 2026 18:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789954231; x=1790559031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f+cTrga3fxRheLjWFEIpCVJBOqMuKdwt4xEbbBWyGpQ=;
        b=GwmLPTOgMCCaK3VxPfrrX1aedCgh6HG39XTL7CnTan6hxCRHg4SvV6WJu83ZeYtEyo
         eRFdM0ndjrXFALfoe5S/odZUQFUaHW+Q7ah3Lcoj8iK7KEcIRhZex2RTu3BVKm3038iL
         vzI7jmtxVUj1hP+/7YbPhW1LWxJAtkf9Kstlvsl2e2Pjy5U5eW/fSKZRcMjEuAQoAjyT
         2bsxUyP5O6Br5AdVMK3orrGYgSgK3nKaoIGjjU+tteP/GdIjpDb3gyDGdogg7m4m1JZ7
         NRKoA0NuxU3RCJdoW70z9qa14FMv4l2sFssnorDf2K020JeXaX1CpfQqVh+jXP/f+cOl
         iqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789954231; x=1790559031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f+cTrga3fxRheLjWFEIpCVJBOqMuKdwt4xEbbBWyGpQ=;
        b=gw4Cl3zgkyzpjSLdOQUkmQ4kgSnoJC+q57BWHd4/Za5XpPRXI/mlEJo1skt9EEbXvu
         GM93q467SdVxo3JgH3ZcPStUrzI/KcxBofUu0TkjK5RsbyyzdLxQxwCd/Jif9Gmm1axD
         dp9sUOXbFJDWSTAyuvBPcJylfrc5H2ihjd0JR4dTiob/gy8h/9uCiPzJUJyhZfIqwl8L
         HVnKZNSogbaorEIOqt36LeKoyFwJUoWAJ6PRn1No3J4mTXBDJKtfEweF4QYyoYRQKsxX
         uBxMKLMDDzoVrJ+0EYn5FA/jFq1gDOPCHKAPBnoLagONS0ur2xHPVBQnXwzoOE4JO9gh
         5s/w==
X-Forwarded-Encrypted: i=1; AKwUvBxbaFGEviohbESQZoA07OYTB34HJVQClQOOJ2ibFzKwSHqqUN8P5o+I5cc1BclIYejLC/xBgJtrHjXyW7Y=@vger.kernel.org
X-Gm-Message-State: AFuF++mH68u+xDmZk4x+HmEwv8k0xBAMXObFLyX5VsVkPTXvPiaRCwLb
	gR74OuFVZsGJ9CSVuPVX9DcW1IMGI6MLzwTUcnoFSZ8TZY8SoS8dLUxM
X-Gm-Gg: AYBFou3F1N9qdGQ5pPc1R/b3oZD/Fr0m05l2JjMoEpqIgmxnz6KmipPDjuwR2KHGLAM
	7xrrG/9NPk1y1t9WAds4Cgcki+V/NJejRv1F7c2rf9AnDpvspEa3NpGz01Yk1i3jitoodI+6q11
	elYB7i50i7rVRMwhYRNKjOcS6FUuYJ1fzAwA/0w8QqS6UMptuQk6wD8r3fqdF//ZPLxt+ljo98w
	nnh0E6kvG/IYadwfBPUHddYhoEJsXd+QJJqlBNLIivC3ZIMttNDK+G7UP+fZvznQ2kU5aSRFOuh
	w4QcO8XNjCOHaEnC7dej/+LbOm1k64FWqASnNQtiW1WbUOqXc0cTO79BYVjCbXwpXWbDnv4OUvd
	8wW9WBO+Z8+Rw+wtX3Ic/yQBMnzWGq2spusY5I27ibKoDSvLQIMM+k+JL08n7TdVsVQWt36i7SK
	ZicUbcwQKehLTlMtAVx6Tn5vhhzSTuv79SQH5aCbwZY/m5t+fpVkXj6Y2EsnKx88giVHBxC3ygC
	zH84nRduZ8N8LXUm+WMo0/Zag5O7SVkJYtZhmiCNtkIpXfMFbSmCofjhxWsl9Dr6NlKo8/LZzB/
	wMSjazYBzQ==
X-Received: by 2002:a17:90b:37cb:b0:39e:6c69:9b9a with SMTP id 98e67ed59e1d1-39e6c69b2eamr9095109a91.63.1789954230752;
        Sun, 20 Sep 2026 18:30:30 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c3145dasm11291460a91.4.2026.09.20.18.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 18:30:30 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	John Ogness <john.ogness@linutronix.de>
Cc: Hui Peng <benquike@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 3/3] serial: core: reject baud_base values that overflow port->uartclk in uart_set_info()
Date: Mon, 21 Sep 2026 01:30:27 +0000
Message-ID: <20260921013027.659965-3-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260919222627.3797854-1-benquike@gmail.com>
References: <20260919222627.3797854-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In uart_set_info(), new_info->baud_base is multiplied by 16 and stored in
uport->uartclk (an unsigned int):

  uport->uartclk = new_info->baud_base * 16;

While uart_set_info() checks if (uartclk == 0) and
if (new_info->baud_base < 9600), when new_info->baud_base exceeds
UINT_MAX / 16 with low bits set (for example, 0x10000001), multiplying
by 16 wraps around in 32-bit unsigned arithmetic to a small non-zero value
(16), bypassing both uartclk == 0 and new_info->baud_base < 9600 and
setting uport->uartclk = 16 (baud_base = 1, well below the required
minimum of 9600 * 16).

Reject new_info->baud_base > UINT_MAX / 16 with -EINVAL in
uart_set_info().

Tested in QEMU against Linux 7.3.0-rc3 by calling ioctl(fd, TIOCSSERIAL,
&ss) with ss.baud_base = 0x10000001 on /dev/ttyS1: on the unfixed kernel
TIOCSSERIAL succeeds (ret = 0) and wraps uport->uartclk to 16
(TIOCGSERIAL reports baud_base = 1), whereas with the fix applied
TIOCSSERIAL returns -EINVAL and preserves the existing uport->uartclk.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Fixes: 6eabce6608d6 ("serial: core: check uartclk for zero to avoid divide by zero")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Split out into patch 3/3 of the series, add Cc: stable@vger.kernel.org,
  and document the QEMU test method, as requested by Greg Kroah-Hartman.

 drivers/tty/serial/serial_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 128fc056f5c9..4cd4fb0f7ee3 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -965,7 +965,7 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 	}
 
 	if ((new_info->irq >= irq_get_nr_irqs()) || (new_info->irq < 0) ||
-	    (new_info->baud_base < 9600))
+	    (new_info->baud_base < 9600) || (new_info->baud_base > UINT_MAX / 16))
 		return -EINVAL;
 
 	if (change_port || change_irq) {
-- 
2.49.0
