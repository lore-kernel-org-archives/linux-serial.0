Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25953433E81
	for <linux-serial@vger.kernel.org>; Tue, 22 Sep 2026 08:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790065922; cv=none; b=ByeJGVOZZTKbMDXVHsFHKLsuUp9//+QLX+zIOjMUsppaEq5PW+f1s6m5lADFWGOol1vPBheuEM8EoNlftZXtlXLbTFnTbN5RHoJvhLowgJ7h2n9N6yf8l3Ja6AwrRreCQn3ZQkxn10zh1Kbd0dkTRxf8WZLNnjB45VD24rD6iiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790065922; c=relaxed/simple;
	bh=+hb6WhVGSbxazqPNFCzPE7V0omcNMJ90KZH/aleX+Cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vDn+sJK0Y2KcjgEIH0buVdBV1HFTT0RmCasr39L9U9YpQ4ZD+tssJNpNdqhLhAY3feXk8um1TnxW56XbM+p/FsAeE7r4l68KWT24NHdsHIMwLR7PKWhUIBm2VeO9HIhqPLw3nyxI25NAz0UqY1jEt95l00vRsZ23I71tuzFRnM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=msA5QAbD; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msA5QAbD"
Received: by mail-pj2-f41.google.com with SMTP id d9443c01a7336-2d91a931f66so27292815ad.0
        for <linux-serial@vger.kernel.org>; Tue, 22 Sep 2026 01:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790065917; x=1790670717; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a7VfkeZl7fPR5dTy6nweVWt5o/UsHxB20RTbQxUVJM8=;
        b=msA5QAbDTQiTHal9jp2jcWdZDd+NqRdbjjMox47NYi2L8nwDgRc8o9RLGvJou+DQs4
         HtRl/wORNBY86OoAQoeJBsVwWkhQj5hMrlIG9SyCRYMc4QA7hs7KpJ08FRRNlNS6IRtD
         f4NRYZIQafVir12mBbzVgjZ3/2cnuaei5ix70SF9UHfOSWHL7ROK9Ht4LRPF9K0n9x6S
         Oy9O7cLev+0QHHvti4cUkOO2/FW/lbpnICDruCe1rm2zzcUfvVJUm9Rj+i5cLI56oovh
         ERx8NefDAlcGFb1DvHLozW+V5kwOccWkGGeh919+Y6vzgXn7qRs4YTIr4QqVmOF8trPi
         1BXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790065917; x=1790670717;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a7VfkeZl7fPR5dTy6nweVWt5o/UsHxB20RTbQxUVJM8=;
        b=tvpoRtWD1g2DIK3AkbErqodhQEFxDm5gRwALVzSbI4bK+K1Cw6DBtV8bJKF82GsWf1
         2Fy+mQL9I57p0bbwnMAwPr+QGKN7ZEgNLExYmuVaKB4QOGD2raIBDt3mMtaQ5der22Iv
         HlxMK3UA3xgdeYfErOE+UsfjRJ52vOwzExoUrMjiWgqTXWlLhHLGqtY/d6rB/u7/QhdJ
         jbHdnDawPdSajgw7scv3YM/BJGPMWDdpZrKkUNxU1O1GQJtmo8UAcTZ94cyF0g3oQvNE
         /o7OL8o5lVZ86GrgA9mfjNp5UmJTT8DyZj/vLqKXHdmggEyvvqEqh5Gpn1LluW6HQDSW
         KKqg==
X-Forwarded-Encrypted: i=1; AKwUvBz8CbfcrugB3/nneH3CaQtclq3WrcYrhhykuVRp3gdodeqm2RFU5OidMYAhwPsxJ71UAJXYEqLI+do5upA=@vger.kernel.org
X-Gm-Message-State: AFuF++kBDW1a5bzOKh9dxzmXZ79ykTXjzP4/Qp4DvTr5/+ePpxmEpbuJ
	WsUxL6+uHb8LWrxAJanO/oUMk7B3pXH828VfSh/o8s50P8v9ZTcmJ+/oS4OFbRKu
X-Gm-Gg: AYBFou1aiXOMZJTBPX14XA4TcW2cnTRDfXWP4ksTzWxiT+uzHVJD3pZnWbkeRlvs10m
	ct0wbrzcwkDvp/J52hfY9CDauGtDX3RmKKZiaSS3pSfNJnLH7QlFpt3AsIqEf59lY/FlypgDO8j
	BNM2axP06/s0vM7+YywE+YR8BVVNMU2Z5TeRSAsfjReWgEoZ+ebh16zQgXUYrL/h/Yxf0GBwRDT
	5p/ez+zU/R0b8Z5GYl96HUP1PzEHuyvAmV1sOffwzTUQ4mbH7Vb4Eb/5j1RWsGTxOJPvOswrdS3
	vVgIyiANqj+JwstNp4IGZspCOnvn3Vuzk/uSjBu0KCMlWjFpTOepDf5vU60+u8kob1TGJPMghiT
	N8wlPR6mN4nU8VZHzn061Oyd2nU7sTzmrowqD96xv/AkJzzwZH1AxIhhfhub7a54xmcN1CTHo2W
	g0fFRg0iAzUrhC32b9UBxVa+rxucMP5v4Ou+muATYrFctSvAcDt+fasvkgGWAzoGbZwDFBo6WPg
	WEC4896cRcT5SNhQBGoiWbyQuYhg7dAihPMtr+2zOEp7pw64Tp/ZKTut+Wtqi07peG+r289glr3
	VxsevWU8rQ==
X-Received: by 2002:a17:902:ce85:b0:2dd:ad74:6d1d with SMTP id d9443c01a7336-2df60adefe3mr5279055ad.26.1790065916879;
        Tue, 22 Sep 2026 01:31:56 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df5d0197d3sm5848175ad.13.2026.09.22.01.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 01:31:56 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hui Peng <benquike@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 3/3] serial: core: reject baud_base values that overflow port->uartclk in uart_set_info()
Date: Tue, 22 Sep 2026 08:30:51 +0000
Message-ID: <20260922083152.4055969-4-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260922083152.4055969-1-benquike@gmail.com>
References: <20260922083152.4055969-1-benquike@gmail.com>
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

Reject new_info->baud_base > UINT_MAX / 16 alongside the uartclk == 0
check in uart_set_info().

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
Changes in v3:
- Add missing #include <linux/limits.h> for UINT_MAX and move the
  new_info->baud_base > UINT_MAX / 16 check to the uartclk == 0 check, as
  suggested by Ilpo Järvinen.

Changes in v2:
- Split out into patch 3/3 of the series, add Cc: stable@vger.kernel.org,
  and document the QEMU test method, as requested by Greg Kroah-Hartman.

 drivers/tty/serial/serial_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 3845fb582f45..362dd6648ba4 100644
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
@@ -933,7 +934,7 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 	if (!(uport->flags & UPF_FIXED_PORT)) {
 		unsigned int uartclk = new_info->baud_base * 16;
 		/* check needs to be done here before other settings made */
-		if (uartclk == 0)
+		if (uartclk == 0 || new_info->baud_base > UINT_MAX / 16)
 			return -EINVAL;
 	}
 	if (!capable(CAP_SYS_ADMIN)) {
-- 
2.49.0
