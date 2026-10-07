Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB1C4756AC
	for <linux-serial@vger.kernel.org>; Wed,  7 Oct 2026 09:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791366452; cv=none; b=QZznUk/fjgqFDqXMkU+PxVQDJsoDbsBKblYGe7mFyWKK8jEuX7nduw5Sjkpc1fGQnk91RLDwFWa/c/rAF3Cz0/CTiIwQXMLYgTPIWOLquSCir16PPucpBf+Y7dq805YwnLSsW5RZePx4fz3KA2iE1sZOmcdPHasIsGWaf6Yn5tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791366452; c=relaxed/simple;
	bh=vXs24fjaC7qTQGkg3xIXR4ZuGvdt8SYm25AED1Umq1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EbGy2oddHkCXDXn9YJsr3W85vW65/APDDtspXl9I1ISeQnA42GIIs1kfwARu8bn0QvQ/YNIH3vxI+bh2pYWWSNQhSa54xO0FYOT/d2WYrYJ4+S74u/yZPPSZJHF8IIWGcFTZbwRfN/tUY3vExiDSM+nXoPsv3KGchFNprKLekVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDQfuR6e; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDQfuR6e"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3a7d9d9b67bso1180879a91.2
        for <linux-serial@vger.kernel.org>; Wed, 07 Oct 2026 02:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791366443; x=1791971243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yT0TcbZ+JG8IlTQxGO7eLDG85XROXTPgMXO/HoKFVoo=;
        b=HDQfuR6erjCOUdjs35bckBUMF0WXycQs5UyEFXS/ST7oqMqCDkuaYvU01rFfSal0Si
         33SRnpNcuXmbYClsy6njeWtAsdXsYoSY+kgV0DUoy+W31Cl9233gQ5Bf8GHsi7IULv0b
         yuZs9+Y0bVpnxrnWF/IoLSPq7yNjXIAQYag5lBy3JOWtuLj+krr4Q9FtR+eK4Sv7tOa5
         cqt1cxMYrgs/QbAwCVCa+cml5vbJ6PUvfEoSGzB5ZC592NTJzBRpPIsksQX5m5iX/zgY
         XEnFolvLmp+Tx86xF+lV8XzfoHgWo+YK0OaduY8xn48azXzjnh15pJNhIOsFcUOSpzGC
         xypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791366443; x=1791971243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yT0TcbZ+JG8IlTQxGO7eLDG85XROXTPgMXO/HoKFVoo=;
        b=pIdloTooYMGN4iRBiWeqEOplNcwgYXdjCoCdAl+JsUvQxCoao2AIL5StTmz7V4++GF
         Pp0XkpIZQCBs/UCUGW7sOcD8ynLJqk2zRJCnvsnDnppRIrshfQr5NBgWkOmpwiIf5pYF
         S9BVSaTNz1DDlHH4f47D1JGuAZPnqscHIpO5KXi5lFweTGCeVL64iOUW2ITekmDqAMFt
         CDSQC3XO5g2NBRrSERokKVm7RLYGAM1qF1AHhDKCg528YjOu8hEF8OegUOs38CJpZqfy
         HPRanCx4TfoTcgCNuPg5SFs+Zr7KX+t1LaqZMyIWHLrDjtGi/oTUKYq908BlpE4NJH/k
         dxrA==
X-Forwarded-Encrypted: i=1; AKwUvBx/uj7xwKrx/RtJfpIguV+7ix79o47pdUfqvrGz7v9q46PuVmtZFXWUKQQrVsVB+6xvZQovWFT+OoqGz00=@vger.kernel.org
X-Gm-Message-State: AFq9FYJmV1MdURMQp9GeA4fuCZ8r/Uab0QSL/f8Cy4eUgqTcKJSEEQcg
	NHYkMl2uPt79VkiXqzJw+QERFpjpgCFnWzTC3vjYgwYBhXSQDGCQMi0D
X-Gm-Gg: AYBFou3hc88pqDZoqyZthQt2kG2y3wWAWpQb0zJD1JBw13j6OVd3iboU3n5Antk1/UQ
	k7gR7CRbTU/6Z3geqEauipygbkJwuT2IZR1h7jpZjE2ptDfL5fF6IeWK+bMZouTxgkEUL6PqVOE
	cRk18mmXEeuZDGBRKYdscZ4VwgyOBK++K9Wd5hSSEMHDl5IGkXuzABwfNiGNN8/1vKj6grMtINK
	3ey6VOpmq5lCQ2U7nrVxZZwS/thV3KaSOy9n+N3XRU7u4/xnj6tHPIic2dBNbLBKxjKCFuwZICG
	Vy+PwwhyNgNZWGjFgVzDwopziVu8Yi3bXaIhG6rqOHRd+JXpKI3Ao+F34wgOrFewoRyziYkbenb
	wVy2NuJ9KmBvdRugOclVwRHVu1/rono6okG7ryh/oLJJC16Uu+sT2Ec7I7PO9Gfg7bTKpkhCHje
	/+LtyBogpgG4b/jjVN+zZ/+CENJWqGvrw8xBTRon38zBSNXAXUOec9Vr01eztR8rvIRXfB3OMco
	TLkdiW+9tUkda0+c+uWk3Do4Pn6cCxcCfcTg182rypPxQC78COewyyONI0MRauONuadX2SZNmQP
	KRSkCS4zUw==
X-Received: by 2002:a17:90b:5390:b0:3a8:6b84:235b with SMTP id 98e67ed59e1d1-3a89f671ff8mr1142874a91.7.1791366443261;
        Wed, 07 Oct 2026 02:47:23 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a8c46a2f9bsm265866a91.2.2026.10.07.02.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 02:47:22 -0700 (PDT)
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
Subject: [PATCH v8 2/2] serial: core: reject baud_base values that overflow port->uartclk in uart_set_info()
Date: Wed,  7 Oct 2026 09:47:18 +0000
Message-ID: <20261007094719.1362769-3-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20261007094719.1362769-1-benquike@gmail.com>
References: <20261007094719.1362769-1-benquike@gmail.com>
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

Use check_mul_overflow(new_info->baud_base, 16, &uartclk) in
uart_set_info() to reject overflowing baud_base values with -EINVAL.

Tested in QEMU against Linux 7.3.0-rc3 by calling ioctl(fd, TIOCSSERIAL,
&ss) with ss.baud_base = 0x10000001 on /dev/ttyS1: on the unfixed kernel
TIOCSSERIAL succeeds (ret = 0) and wraps uport->uartclk to 16
(TIOCGSERIAL reports baud_base = 1), whereas with the fix applied
TIOCSSERIAL returns -EINVAL and preserves the existing uport->uartclk.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v8:
- Dropped secondary Fixes: 6eabce6608d6 tag per Hugo Villeneuve feedback.

Changes in v7:
- Use check_mul_overflow() instead of raw UINT_MAX / 16 comparison as
  suggested by Jiri Slaby.

 drivers/tty/serial/serial_core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 6ed0195e6912..9a8f4c2e1180 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -14,6 +14,7 @@
 #include <linux/tty_flip.h>
 #include <linux/serial_core.h>
 #include <linux/console.h>
+#include <linux/overflow.h>
 #include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
@@ -931,9 +932,11 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 	old_custom_divisor = uport->custom_divisor;

 	if (!(uport->flags & UPF_FIXED_PORT)) {
-		unsigned int uartclk = new_info->baud_base * 16;

 		/* check needs to be done here before other settings made */
-		if (uartclk == 0)
+		unsigned int uartclk;
+
+		if (check_mul_overflow(new_info->baud_base, 16, &uartclk) ||
+		    uartclk == 0)
 			return -EINVAL;
 	}
-- 
2.47.3
