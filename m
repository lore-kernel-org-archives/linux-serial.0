Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793399853;
	b=PBLx7gBG4sxho6aFf+GBfo43ZKkUTYGgycJ9jWnohYMn2BhD2gfnTFgJKHbeJCeX6fcV
	 79/CldQvbkzHSvMD/bh8V9wPMdxtr7XTiuJi1PZY2LKWgwQHSOQIAxgVwlg0uDp4Hh4R7
	 h6pJ7a4dGGYUTzg16qu8/LjB1b9P3FJgMPtQf/P9LrQ6jHg9md8Z8tqoCYS0We6UM6B+P
	 yoevufpSck99U4JPKqhg8KR5xxhXbIAlLRUOZO5kPAM/s4qQH3/NzAHxrNF4RbwQSymn2
	 pl/S2IPAkDPXwsM7WAO6Sa4aJQ1GylFO75ZuD08FX2FF2BFnFPREnvtkykulxWoGKYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793399853;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uJVUWRv+X+dXynVZ6IIPhUljYt+AbMuyn+nbQfPo/N0=;
	b=y1HAK/gqK8a5duOVI7GRIEWnNiQDKovVJFnNAa93TzV+bZPoeWm+ZTVC3nzTASm/UIZe
	 wsMSbtncM64Doftlk0j/DD9JrfQ1UBN6Lr8ig5z5dheUntsskTGiIbox+F/GFuyZIEP9d
	 FaQ41E4XvjPFGSbr96lNaEnNwdF8k1937uscHbBG1Fy1KdBd4dx/JnnYXjffu3zryuw+D
	 9pVloWfP7x+guzhI0Ji9Je9BIrC4w0OuK990Dt6aW1RDs8WI+ElziTdgJ36AYIkYKGQ/B
	 HCZtYiRN3xx3/Jx8vdh9WI0or3hyqvMAnJyevn1AjHrMXPiOBma8uxoUf1H5MLEz1ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yd5EpnNO;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A43D60A2622
	for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 22:37:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A43D60A2622
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yd5EpnNO
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a208d93758so12993575e9.3
        for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 15:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793399839; x=1794004639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uJVUWRv+X+dXynVZ6IIPhUljYt+AbMuyn+nbQfPo/N0=;
        b=yd5EpnNOD2uZtleapc+hZXnJ+TEjXTpUZJmmTe21kU25Yu9fYu/s/whBTAuP3x/wM1
         V8WVki5h1ivcr/NvTgB/TSTWqpQTfTVwqIwYn553dt0xaJtEb4TuWmeWmnHx1JLLAAxE
         KzWhcuPfI4kmVS06PeLeQrrNtckKErC+nCg+N1oO+yVXbrfyqwLpyZ5NFcj4nE6Mqdg9
         X6rQHL3kift3MfQof0XedmmzQedYkMTMeFTRGx1/MGrKVve+vxLlUKZTBOQ2EtMfYtQO
         rkHZJIzfu/mf50nmcYlvQACKBaK5OR7zp48II0T/3RsRzqTqddDLj3P1fHHUCj57nHC4
         8jZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793399839; x=1794004639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uJVUWRv+X+dXynVZ6IIPhUljYt+AbMuyn+nbQfPo/N0=;
        b=0eSg6UtPPcjp9zxXFhfqm4f0RTAZ8EiMX8MIOaUB1noYlLhMZOV22gFd+mvxFPhwHM
         aO+BkaR8hx73t0uHD4LGRNguYpTDPpKlqyyafPXplTZ40y1ZwWVn74Blypm0O4vFyRzM
         waTCq/gJapfai7cVwvYPnzX8GPvNBzf0FGSnBgZekMIPJO/G6AAk/ma7lC0zkhA5UDnH
         DOlO5GpZnWetLLFQ76HZdILw5VxD/xEanpgWzUfoRVfTI5WgRSbEi97iLi9RVj4hNgi2
         2KoVhnxPEr6fIy4A4rLMKyoGJIdBfJK6TnPqbftchQC4Bf+fIu4jCHe83XzwsLBte03t
         r2wg==
X-Forwarded-Encrypted: i=1; AKwUvBz1CNF4l/Z6zBbv7LMJJFJxDcWrOh6sr96iiQnVumqsHuXezfquyfutXX1mQl4yFvuu0G8zS3GxczIJVIk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJbTPixMhGuEh8K1p/40V1/MDWPQAe8hf5Z0QO7Gxpe3FggQQrC
	qG7oM+66Fm47GbDXOUBPuN8DLeKmrTCGMmtcCcWJVC6DIECG0gifADEB
X-Gm-Gg: AYBFou10E3tiLh7vc4mEYEdD9KEntf6quMZ5Lphoq1ZHx7mypOVZFeIud4SgFaZVm8Z
	UrEiukigF4bfKrmWH6MrpiDMiPo9XebqsjxJ8DbCQVR2w2CjWLnSuaK22Dr0zYuShQWkPe4nE1R
	EbCbHSevI3kWvY2MKq4EVlpAYhSImPumbgRTjAW2qtjoFczkXOowjqlcHD3dfwbXEYM2IDcR5wh
	BQw+v17kKeghR9N+mQWVW9sj1/cMlFf0+X96Hro177ALUMqDEK8V53xa0CshcVXGxI5gqRrXfQh
	5o7VMPibjxCIWWimVZH/zCoPNWmobWybnXBHKcHC3CoUlLrSG2qVnCjgXFBhMjh2r9rOk33tmBw
	3hzx9BkhS7G0P2oXaj7K180+xbftxb6trzsSF0E7C/PjOubytL6WhvKsBFpACRP8lk7zzCGezH0
	8v/0KVnufm22wKt82XJBczDWZD34n2TcN9MTSh2JKBNnitim5Yp8vSJVInwmWrvoRu9QnUa4d+0
	HpEgZSuucAdlRXxlKx8TueWJfUfmNDlKQ9lKn/Brjbj9vdgehT5v6nhX5YJjIx0BUBIEgShQBM9
	8OqQpFw068ics/IVYBJN0qh1Ce2a
X-Received: by 2002:a05:600c:1f93:b0:4a0:1fb9:2f51 with SMTP id 5b1f17b1804b1-4ac182dbc34mr81626205e9.14.1793399838726;
        Fri, 30 Oct 2026 15:37:18 -0700 (PDT)
Received: from m2.. ([37.142.145.227])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48e71b959c1sm5457300f8f.45.2026.10.30.15.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 15:37:18 -0700 (PDT)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Raman Varabets <kernel-linux-20260610-80b7ab08@raman.v1.sg>,
	Germain Hebert <germain.hebert@ca.abb.com>,
	Christina Quast <contact@christina-quast.de>,
	Rio Liu <rio@r26.me>,
	Bruno Giacomazzi <brunoceg1@gmail.com>,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Zaidman <michael.zaidman@gmail.com>,
	Chris Keeser <chriskeeser@meta.com>
Subject: [PATCH v2 10/15] HID: ft260: i2c: fix large write transaction failure
Date: Sat, 31 Oct 2026 00:36:32 +0200
Message-ID: <20261030223637.86907-11-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030223637.86907-1-michael.zaidman@gmail.com>
References: <20261030223637.86907-1-michael.zaidman@gmail.com>
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

Fixes a regression from commit 5afac727defa ("HID: ft260: missed NACK
from busy device"), which waited for bus-idle after every HID write
report except when the report flag was exactly FT260_FLAG_START.

Multi-report I2C writes keep the bus busy between chunks for atomicity.
Treating those middle reports like a final STOP caused ft260_xfer_status()
to spin on -EAGAIN after the second HID report and fail large writes.
Write-then-read combined transfers still worked.

Pass the bus-busy check policy from the caller: ft260_i2c_write() and
ft260_smbus_write() wait for idle only when the report they send carries
STOP; intermediate chunks and the command phase of a combined transfer
do not.

The SMBus side matters for register reads. The command phase is written
with FT260_FLAG_START and no STOP, because a repeated START read follows
and the controller deliberately keeps the bus busy to keep the
transaction atomic. Checking the busy bit there makes
ft260_xfer_status() return -EAGAIN on every retry and the command write
fail with -EIO, which breaks probing of clients that read registers:

  ads1x19 6-0040: Failed to read config register: -5
  leds-pca963x: probe of 6-0008 failed with error -5

Fixes: 5afac727defa ("HID: ft260: missed NACK from busy device")
Reported-by: Chris Keeser <chriskeeser@meta.com>
Closes: https://github.com/MichaelZaidman/hid-ft260/issues/35
Tested-by: Chris Keeser <chriskeeser@meta.com>
Reported-by: Bruno Giacomazzi <brunoceg1@gmail.com>
Closes: https://github.com/MichaelZaidman/hid-ft260/issues/42
Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
 drivers/hid/hid-ft260.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index dca0250f2c25..65835e13fa2a 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -576,9 +576,14 @@ static int ft260_xfer_status(struct ft260_device *dev, u8 bus_busy)
 	}
 
 	dev->clock = le16_to_cpu(report.clock);
-	ft260_dbg("bus_status %#02x, clock %u\n", report.bus_status,
-		  dev->clock);
+	ft260_dbg("bus_status %#02x, clock %u, bus_busy %#02x\n",
+		  report.bus_status, dev->clock, bus_busy);
 
+	/*
+	 * Do not check the busy bit for combined transactions
+	 * since the controller keeps the bus busy between writing
+	 * and reading IOs to ensure an atomic operation.
+	 */
 	if (report.bus_status & (FT260_I2C_STATUS_CTRL_BUSY | bus_busy))
 		return -EAGAIN;
 
@@ -612,13 +617,10 @@ static int ft260_hid_output_report(struct hid_device *hdev, u8 *data,
 }
 
 static int ft260_hid_output_report_check_status(struct ft260_device *dev,
-						u8 *data, int len)
+						u8 *data, int len, u8 bus_busy)
 {
-	u8 bus_busy;
 	int ret, usec, try = 100;
 	struct hid_device *hdev = dev->hdev;
-	struct ft260_i2c_write_request_report *rep =
-		(struct ft260_i2c_write_request_report *)data;
 
 	ret = ft260_hid_output_report(hdev, data, len);
 	if (ret < 0) {
@@ -635,16 +637,6 @@ static int ft260_hid_output_report_check_status(struct ft260_device *dev,
 		ft260_dbg("wait %d usec, len %d\n", usec, len);
 	}
 
-	/*
-	 * Do not check the busy bit for combined transactions
-	 * since the controller keeps the bus busy between writing
-	 * and reading IOs to ensure an atomic operation.
-	 */
-	if (rep->flag == FT260_FLAG_START)
-		bus_busy = 0;
-	else
-		bus_busy = FT260_I2C_STATUS_BUS_BUSY;
-
 	do {
 		ret = ft260_xfer_status(dev, bus_busy);
 		if (ret != -EAGAIN)
@@ -661,6 +653,7 @@ static int ft260_hid_output_report_check_status(struct ft260_device *dev,
 static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
 			   int len, u8 flag)
 {
+	u8 bus_busy = 0;
 	int ret, wr_len, idx = 0;
 	struct ft260_i2c_write_request_report *rep =
 		(struct ft260_i2c_write_request_report *)dev->i2c_wr_buf;
@@ -673,8 +666,10 @@ static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
 	do {
 		if (len <= FT260_WR_I2C_DATA_MAX) {
 			wr_len = len;
-			if (flag == FT260_FLAG_START_STOP)
+			if (flag == FT260_FLAG_START_STOP) {
 				rep->flag |= FT260_FLAG_STOP;
+				bus_busy = FT260_I2C_STATUS_BUS_BUSY;
+			}
 		} else {
 			wr_len = FT260_WR_I2C_DATA_MAX;
 		}
@@ -690,7 +685,7 @@ static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
 			  rep->flag, data[0]);
 
 		ret = ft260_hid_output_report_check_status(dev, (u8 *)rep,
-							   wr_len + 4);
+							   wr_len + 4, bus_busy);
 		if (ret < 0) {
 			ft260_dbg("failed with %d\n", ret);
 			return ret;
@@ -731,7 +726,9 @@ static int ft260_smbus_write(struct ft260_device *dev, u8 addr, u8 cmd,
 	ft260_dbg("rep %#02x addr %#02x cmd %#02x datlen %d replen %d\n",
 		  rep->report, addr, cmd, rep->length, len);
 
-	ret = ft260_hid_output_report_check_status(dev, (u8 *)rep, len);
+	ret = ft260_hid_output_report_check_status(dev, (u8 *)rep, len,
+						   (flag & FT260_FLAG_STOP) ?
+						   FT260_I2C_STATUS_BUS_BUSY : 0);
 	if (ret < 0)
 		ft260_dbg("failed with %d\n", ret);
 
-- 
2.43.0

