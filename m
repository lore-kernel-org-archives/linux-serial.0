Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794945927;
	b=j+lD2kY8Wb8e4ybTQjCdiHVOE7y2d8QVZktTYghMRN8HSzkmgSxFy15j+RBMD2cR2aGB
	 SMeI+deo1qPMU2mP5Jssfn5pQ19wMv35VU8MrKuuhDirqD/jug3znOFlWQkEEe5pzoi/t
	 eB+tcSfiDNCutojXI2Snxsx5BXzNmyjcgyCpwCXOT/DUIHQmDXaoxun2ihlqsFDH7nWZh
	 4lG8A/r+kIxdA79K8Bu7xRdxVQtBbwnq8QlbVuQiGwnCsvO/Mf6rhz+ptgcrMefPCHiMh
	 MSdTnJI0Faw4dQ9ORg/IlVF+KQQLmKUZlFBD2XWwLhiIVJ9lgL7a9zNICEviQ5IFBwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794945927;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=IcA1V59Xrw/X1M11v2NylbJPbcubWbeuZI6r+8JViz0=;
	b=iDx5GEZ1LL5n9KJfM1QGj03wQ3PHPWRFv9MPqdTFUjrz2x7Z102SlepbU1IKn4YcGtqV
	 +X+8HqOLXxPdokvvS0eIEpkJ7/k488XUqEnE6ZRdQP2RkkTk9pb5OcgVrzUdwOrAXjS3y
	 3p1aa8YtEEke1a7UvnV3rNih9pgP+YOkcpdOxD2U8qbm7XdffAwd+8QNh1/EMlgpgBBYL
	 H2ksR7cyxLkbG7GWim6nzcJTpdEHIMuHj1SdAaVc3xFsJjrSZeyVSt6ZIqL7JincoTIz7
	 ++OlwXCUAiT73BYzNULQFqhlRdN5CERoyRmMtFDCF5bEhb9DNjWorT516ifj//FKOug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BK72qdnz;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75E6606A32C
	for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 20:05:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B75E6606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BK72qdnz
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4bb5b8ef642so2055325e9.1
        for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 12:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794945925; x=1795550725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IcA1V59Xrw/X1M11v2NylbJPbcubWbeuZI6r+8JViz0=;
        b=BK72qdnzmaDtP7R1pR0jeCLNMQz1bZpzDfjqREbCQeqjHLCxlo9ncoy/+SVKUPvsfp
         7qptgGeUX6x/hWpN7mWS/BxNKl8mNHfjxszOlVBjmorDzR+f7QHRbZyE9JE5vNSHXOpl
         R7RzfYwMAc+ZwTJToASqn4t9IBbP3i4LZ+qHqFwfjGzfqnz31V5NBmcXAKqRrQrdm4Iw
         rDFmnbe2iqt49Hq8POERV+c5HuoPejSsPOFUC8TVOmiLpBPBqJKTZFluuYT+zp7W/0F0
         2xX6SN03uwr0agXfvn6IXCu2WS373nsdlV81REdLaJIS7JT9tAA8zHdiyK9onnf1WAwv
         1jOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794945925; x=1795550725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IcA1V59Xrw/X1M11v2NylbJPbcubWbeuZI6r+8JViz0=;
        b=QUwNxVKvUIoSv/VpRJKc61bg5s9exfy5EG23xY63pSwjcDWwLj5Uc7h6dNtLRZVBra
         uzEbquWlogcXJjiItIj4XrWybQ19ts8NZnfd1m99Ij23WIm6AuQdA1wXUlr1tFiY0rtp
         DHfF1kcUYYeLqb+vMUnxyi8aH272Mf5anHUxKHquoIYg/aWjrQOPeVFLfkQuVVu17rC9
         ss3SyoHXT98WtqJFJjh3wIvQL5biJZ08L9bwbVIbPV4R8mXT6RKkFMhYCtGrk0Am64BP
         5xUq24ETMaAyOMSn9cun9KlXqdus161RXf5mLZUSsBMyVQ+xOvixPVhIGR6zjXBZYnrB
         cQrA==
X-Forwarded-Encrypted: i=1; AL+hErGbwUFM2b0BUcM5SE5gqyuSo/hsGddLc6DEULAam4QDdQnosE7alLb+uu+U0FRRuMZV6p9knuqetdq0gjc=@vger.kernel.org
X-Gm-Message-State: APuU4Z98smgBUAHXMUv+0ss8IYwsKbgKGpMN/dWaTlqQjpdd8YngQLLg
	BG1ipTQEcChveysPzNWfYq2kEbTiHaliMvYUCJ7v27t8cbsxHDPsaOzS
X-Gm-Gg: AYBFou1F9SPQUprUD2HHYwLuP8BjoYsyumP3yX/unLo040AUtnpcalTwTXW5dDON0r7
	g2AmnYhOQ92QQXtJAnl3FZTe+FRNJ2xFYACf6u/wtNqy946NJUzMTprzSaCYPkgrvnxFEAWJUvF
	o1Zam/9BTOBx+2qEFue5XxaMXoBe1LPhhjkZE6ANrZA9MGKukah0ZE3KkOqvMfERhYzxDU3Nc8Z
	Ue3fMLt7wUsTBkPcSBI7LomKHqD2LweM8x+HFd3T3M4CQLgJsfc4CJppfulsUDLm40psh3YklI7
	Nju7/xSwmvYGouD5hLdIWNWkZYnT0ZfU62pHIvHDEHbiC86153dKBc+9RWOv736hYCbxsA3vAmL
	qZ51FS3Aga/MNoevGVFtB2ROBdfSH+M71M0KvDml6I2A59dlT6sDxstlJPcZzglfE73A5viL/VI
	NayFTPdakOY9lro7NCNp0//Wo2+DxFcbN+v23oFcjFB9LZ7POzl9mApgJcg+DtTrucYqoLiGFcr
	t4jlLJ2Nyno/haO4bkOA3bfFWB1F0AKJy/YFi4lGl25juzsnnf4YrWt+/shfAS1AgP53YrSOqfU
	SiJ5/LKrrXRWCH9QVj8aP/3btflo
X-Received: by 2002:a05:600c:8b05:b0:4a3:12fb:1ef1 with SMTP id 5b1f17b1804b1-4bb7da26eacmr4921245e9.29.1794945925053;
        Tue, 17 Nov 2026 12:05:25 -0800 (PST)
Received: from m2.. ([37.142.154.208])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4a64b60940csm625528f8f.0.2026.11.17.12.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 12:05:24 -0800 (PST)
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
Subject: [PATCH v4 10/16] HID: ft260: i2c: fix large write transaction failure
Date: Tue, 17 Nov 2026 22:04:16 +0200
Message-ID: <20261117200423.19561-11-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117200423.19561-1-michael.zaidman@gmail.com>
References: <20261117200423.19561-1-michael.zaidman@gmail.com>
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
index e34780c62522..e708b1be734c 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -580,9 +580,14 @@ static int ft260_xfer_status(struct ft260_device *dev, u8 bus_busy)
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
 
@@ -616,13 +621,10 @@ static int ft260_hid_output_report(struct hid_device *hdev, u8 *data,
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
@@ -639,16 +641,6 @@ static int ft260_hid_output_report_check_status(struct ft260_device *dev,
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
@@ -665,6 +657,7 @@ static int ft260_hid_output_report_check_status(struct ft260_device *dev,
 static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
 			   int len, u8 flag)
 {
+	u8 bus_busy = 0;
 	int ret, wr_len, idx = 0;
 	struct ft260_i2c_write_request_report *rep =
 		(struct ft260_i2c_write_request_report *)dev->i2c_wr_buf;
@@ -677,8 +670,10 @@ static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
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
@@ -694,7 +689,7 @@ static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
 			  rep->flag, data[0]);
 
 		ret = ft260_hid_output_report_check_status(dev, (u8 *)rep,
-							   wr_len + 4);
+							   wr_len + 4, bus_busy);
 		if (ret < 0) {
 			ft260_dbg("failed with %d\n", ret);
 			return ret;
@@ -735,7 +730,9 @@ static int ft260_smbus_write(struct ft260_device *dev, u8 addr, u8 cmd,
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

