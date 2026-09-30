Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EB83914E0
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 04:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790741543; cv=none; b=YO/q35273Dx8ORKRKXvECc9jZ0/QvUy6p9PKkRIGntaoW4nqK6Ci+AL8RVAo7mGJOF2Fa0GSrWeSVlqHppZU/3kyg7ms4XGuFmIYo6/5TCznyr36QVFY+QEkFUFYpKYkC03byc9jl/hOlt6xI8KhO+CETZrHolNNDSIOaPubE/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790741543; c=relaxed/simple;
	bh=Oo53tl50DDhxZTRU2kZqD5YiIutvwW1ymk3R6TVtHH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eA8rjqtaYTK16TFzIux0+2NW2TJB4w6Cf8tmboYJIYFvGTMSxu2png6UPCUBXPsYjaO/8Io9MokJp7tIuPva8V7HljhrTN/vL/NjCuw0vKvCXaJTBTebd7eNZU/dJKj9vxuRoOxSZ6ZkW1nQYP5JfkENsrgFwLbYkabIaaOO7e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1V6mfEb; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1V6mfEb"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747ee1f9bso22895555ad.3
        for <linux-serial@vger.kernel.org>; Tue, 29 Sep 2026 21:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790741541; x=1791346341; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S5UnmPY5kMPPG0bvMqpXCuTQXTpRA5TFyDbtv9y34iU=;
        b=e1V6mfEbOoqO6t5vSOwnanmSj36OjXwSkwkO+6TykwM8Zk8psqTM2f1m24xgUbiJh4
         Anllh3gYQcDwtdFF61naei3+tUsT+qh0GnWH0ehTfT+WVyNbM40F21SCB9lW29O5XBz1
         Ys/ytgCplzjb0jd2cjw7XO3VbE+BYTWlgji18MYbLpEw/E72kOoCLsX7/tzDKAoLgXZr
         i6Kmv2pKaDFT8CI9uGV+weXYhIL2tXRhCnEUnpO3B0PjIDPCxqRyCjsv3gqDBCUDhKPp
         2S5Gs5wLl6oec+momVLmS/rTTAUPfdKfEEqAySTJ8gInLaCiThchJPPu2KmlNu29r97O
         0uTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790741541; x=1791346341;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S5UnmPY5kMPPG0bvMqpXCuTQXTpRA5TFyDbtv9y34iU=;
        b=o4+ESMe1x/W9WXfHeiq7Dgo9pDMQ+RGl68g/d5N6rDEeYXokA4kZ8ZSnYhAyIbwVl/
         DDH6LS6qdcKZKqCDgEgrX8IEbHVFXMLIX6zIweHzV5Yq6BALraXXTcfQHp3PxsYhL3nU
         Mj8xyDAJDKvR7+awWlGSyQFVk9XRYzfgcDQR1xgVn9SnZQhlnuqAO50tz3FdHnnC7QC6
         RVzFMyWFZ2KfO8sU3c++T4G9Whf6Ucpzzaa6PCTM2Shqo7vkdk16HK3nM96FuLvl7Nqi
         CcqTzGRf8m/2/U44rC2V9voEwmGL9UbtiT52XAAqvkHd6MDqo82VZPqiboEbJUTR7UFg
         2B+w==
X-Forwarded-Encrypted: i=1; AKwUvBw4AGwGF/bnAOEPoP7Href/vUwtf2k54jrOMFHOgsXPvyoksmiy9pU6wr1Uw0AP4BtoBxEirn208mgOf3o=@vger.kernel.org
X-Gm-Message-State: AFq9FYLuKX7UwcxRYvxBCnF9DjZPXIRMshvLlK4cz9e7Dj9xs6DNXk+D
	d/EUXccL164hqBSwXxpaO8ZZoQCtINqy592la2Y3bLDKOS4tOanZ9GYt
X-Gm-Gg: AYBFou3bEEvNuB4dVjGRV+OKdBjAylqGT86r9G060YNRMKwD1SYkWWNt4tD/Lfr07FA
	pK85/BRAj2ifbNCAJGZUXISkcKcpwQf4rTHWmEQPkWhWQsG+gfMnD+v26VsS+pYwV8Y/oASVhy3
	rzQxAM8CZl639aDkxI+0PR5lDj/OCXxbtx6IOqt/K6ThdULnWTN5OdxfQeCUwiiJn7ogs/C1cEY
	qqYwkQZWA0pfbFjWtE7cmSw93CSqzd1wvNI1sH9fMCugu1lTajaLPQEDgUldr1wefa5NhgD3ONu
	FunMaYtbMoADrpQRQ8TSgRWXD+Dlt18ExVNq4unepgzL1+9PUAmsrTTMciYTVrPwKHUdIdkP2Yb
	7zCeBAOjQ37KL8qCElmG3BnyDyHwU4rawcdr8si481n8XvkJHEfNV+Y0MKpwub2rfKuGAUbk5xL
	5k4TvGYH7klpV3dDuAS+fhPmB67UDSPfj6wpj6j4WeROh1xhC3nJPB24Zt5tfr0IducIuP5+jbL
	2qnf6fpWZzkwnP70MaFt9jc4IBltwU2veogDF20H3S2rUDl4G6japEDF3T5vKA0AtF1Ll0oTiE9
	c4QH8wuWffUT2SraUJfM
X-Received: by 2002:a17:902:e741:b0:2dd:c100:7cbe with SMTP id d9443c01a7336-2e2e4a246aamr1838635ad.58.1790741540913;
        Tue, 29 Sep 2026 21:12:20 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e2e5c4a240sm160065ad.81.2026.09.29.21.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 21:12:20 -0700 (PDT)
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
Subject: [PATCH v5 3/3] serial: core: reject baud_base values that overflow port->uartclk in uart_set_info()
Date: Wed, 30 Sep 2026 04:12:16 +0000
Message-ID: <20260930041216.155911-4-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260930041216.155911-1-benquike@gmail.com>
References: <20260930041216.155911-1-benquike@gmail.com>
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

While uart_set_info() checks if (uartclk == 0) and
if (new_info->baud_base < 9600), when new_info->baud_base exceeds
UINT_MAX / 16 with low bits set (for example, 0x10000001), multiplying
by 16 wraps around in 32-bit unsigned arithmetic to a small non-zero value
(16), bypassing both uartclk == 0 and new_info->baud_base < 9600 and
setting uport->uartclk = 16 (baud_base = 1, well below the required
minimum of 9600 * 16).

Reject new_info->baud_base > UINT_MAX / 16 before multiplying by 16 in
uart_set_info().

Tested in QEMU against Linux 7.3.0-rc3 by calling ioctl(fd, TIOCSSERIAL,
&ss) with ss.baud_base = 0x10000001 on /dev/ttyS1: on the unfixed kernel
TIOCSSERIAL succeeds (ret = 0) and wraps uport->uartclk to 16
(TIOCGSERIAL reports baud_base = 1), whereas with the fix applied
TIOCSSERIAL returns -EINVAL and preserves the existing uport->uartclk.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Fixes: 6eabce6608d6 ("serial: core: check uartclk for zero to avoid divide by zero")
Cc: stable@vger.kernel.org
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v5:
- Collect Reviewed-by from Ilpo Järvinen.
- Re-send as part of v5 series in a fresh standalone thread per Andy
  Shevchenko's feedback.

Changes in v4:
- Check new_info->baud_base > UINT_MAX / 16 before multiplying by 16,
  as suggested by Ilpo Järvinen.

Changes in v3:
- Add missing #include <linux/limits.h> for UINT_MAX and move the
  new_info->baud_base > UINT_MAX / 16 check to the uartclk == 0 check, as
  suggested by Ilpo Järvinen.

 drivers/tty/serial/serial_core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 95774b0f1484..75bb1eaa27e7 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -16,6 +16,7 @@
 #include <linux/console.h>
 #include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
+#include <linux/limits.h>
 #include <linux/of.h>
 #include <linux/pm_runtime.h>
 #include <linux/proc_fs.h>
@@ -931,8 +932,13 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 	old_custom_divisor = uport->custom_divisor;

 	if (!(uport->flags & UPF_FIXED_PORT)) {
-		unsigned int uartclk = new_info->baud_base * 16;
+		unsigned int uartclk;
+
 		/* check needs to be done here before other settings made */
+		if (new_info->baud_base > UINT_MAX / 16)
+			return -EINVAL;
+
+		uartclk = new_info->baud_base * 16;
 		if (uartclk == 0)
 			return -EINVAL;
 	}
