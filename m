Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794945932;
	b=MWqP8XfvkSy1coQiTGQLOMceJhsl/ZBMZshcYGK+/hjEG6SGSljgo8F6PU7NDilPisa/
	 wV830oav3kWqfwy+GSvHnnx7vix/prZpfldcokTRXNjWs7ilEx8wQAtR5Tl8ITplOnKzx
	 ghu1VOsgaJ2roz8p0aAtTKYMUPmF2N3+FZE7KP8HVE516TsOotKoJsci29EDDz50teezV
	 CgmqF1nMtPLZtlA7z16E/DUrqWAxjZt98qwMWL6+t0D4lxHDDJ4bQRc4nlAcznTY4VSzO
	 Gtn84bHAY8QgmF4iqFWW3BZhWWZ7C8z1VieG7FEU//IBixz0sJLvy+jXsFcNeyNJL6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794945932;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Th+rcVsW0xkGEUkonwHob8ff183eupHjg3fCrT4Vn5o=;
	b=MpQGngZyow+SjvLpUXHjIhrTzZQwhIEkiOr4mqUnL0bl2+kUnKNuCILPix5eF9PtkFF3
	 hGTCQTlfnXX+p+r9oTdwJQgzM7BEliB0ujaOGX/nYtMEs652x4oHAI0bP1Izua/FVVjwc
	 y1jBw4axZ2BVP1dxKRpRsTPDVrxriE3ogKsO+1W8wzxN149JwuxCSlSur1jvhJvlduJtj
	 OhekWfdHznixzB969Xg8GvVS1FeFzJuLFiJuecuT89389mo2QRbtAec9iP3hqsvZqpNun
	 ugOkvwGnphnj1fcT92C8GC1KXlXgR2nh+b2Q4s4PU/74aa4jBZvogFzn40IiQ6c0psQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=es5pELrA;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EB860A2636
	for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 20:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7EB860A2636
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=es5pELrA
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso2363865e9.0
        for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 12:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794945930; x=1795550730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Th+rcVsW0xkGEUkonwHob8ff183eupHjg3fCrT4Vn5o=;
        b=es5pELrAOUr+g+3D7z8CtlE/OWafjfkfZUkZAhf8vdzOiZjtZ9HujkUjq8DdR3RS6l
         BgDw8xyrpuphSTgXLKoIKc1FV+AJkwk6n6bIxwE25Nt2IdFzhdHqw2Q011TEbOeejYDi
         pG1OWL3T1OPZdxwFTvM1Nx+Vy0BN3vvu34nUkmvPsQ805PLwbHtqYQ7K7nqQNgVT9GLe
         IiteJS3O6c8YTbBGJ1pg57bSsww8GhoCyWAV2dpoLHLDgZf097fAgYKZt9IXpvl2G5NF
         VLabas9KgXieSW44Nlu8MRTnNZcir1ch1dswPBqk0JErOu6zQHBvJqtQo2IkeWswQo6d
         DvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794945930; x=1795550730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Th+rcVsW0xkGEUkonwHob8ff183eupHjg3fCrT4Vn5o=;
        b=gSl7iLNwexJuJIXufy3lgVu3QLT8ugw0+y8bIgE3QbCbXAmzKgMcCy2dSxb5AGX/p0
         Fx8JriaInIAN1MwxPI0gi5mYOJklqKbbDnM3RrbWWBnsoE2Jgkk4EM6+FMf3YSc/c9yd
         pR3vaJlJHaJ6RGIIuUGFnQ/TOyd3ADnArvmpL3+GfmTQqO1Cn08x6oBxg0cOXYfyieHP
         0+gVg9GyVEVfiDCC222oTIGf6Ojc67HuoJ9aY4WuW9ydmPaGn2lVA1P8Fxr5p6/yBgW9
         AHvBFNAEPktPLVWpS85OUjkuU8btyMUwz3TWUcOn2Rsoo32zxXay8AZ4aQwde+l255Q/
         7pAw==
X-Forwarded-Encrypted: i=1; AL+hErGqgU0VEptgTeROlYKIu9Y3DSSbhZUSlU9yH5rGwBVqo6T4l25IySevqcyhq7vqWDDrPUniOSaV3qzYqjM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8qHhr9+uNPhf/zakXYZ0PJfXQoCeb51KA/xP1JoIRqJDf/lpvR
	KbIiVZfhAleXS3jcLRfigA4wHkAxLHadGomN59m3FieJU9ewVf7PH2u0
X-Gm-Gg: AYBFou0aLA+BCHhA80pd2PyiHffFOPRIS+kIn7kvIjPq7JBFYzvpzo0hAn9z7qOlQ82
	RVPr/SBvz+Cc4uLidPeYAQXjcjb+QSaSgw8RuRmX8T9hh1ROCRapWyX/75DrOe2dZmbNj1G2NrD
	Hr2A5LoLV7aRN4Zcj1f/rrhOWObcP9t6lLP/edcCU3ZROUa50bdX09uX9dJh4TdPyAqI1XGLSYZ
	BHgsTSWiQ9yP3REhpKI378g9pW2+IuaZPsfDtD3K1TlftYBa9b1G29p8b2cFJSzKPJnslwcKi95
	o8Ozsl97rVlI5eh6Hi2gjCIe9w8itFfbdzXCD6GhQwkB0e31yCphz3oZ8sxeJamuMGwXKIE6CUn
	T9Myq5mcJng0jW/IZq+6ie1nGA7Sj+loovUDiSYrJG/7XM0FwFCanrDSqOUtUyivO/HDDMkUhCa
	0HOHF72cttaGyzyr7hDpTXTtHKF6SkaublJM7erRJaPfWaXU6pdiYauRIEohzvb0Q6Cn8nQQIR+
	HpfSRhakb27DMSMbHDHMvc3Qzx4dhmcWtgesfjXCr77WnC2goPkP32mZ7+0ksWGGHXmhy4qC7Jd
	yILhfqimQW2kNw1iDcvq92lzPf4R
X-Received: by 2002:a05:600c:1d05:b0:4bb:73d5:ab33 with SMTP id 5b1f17b1804b1-4bb7da27094mr5436645e9.22.1794945930207;
        Tue, 17 Nov 2026 12:05:30 -0800 (PST)
Received: from m2.. ([37.142.154.208])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4a64b60940csm625528f8f.0.2026.11.17.12.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 12:05:29 -0800 (PST)
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
	Michael Zaidman <michael.zaidman@gmail.com>
Subject: [PATCH v4 12/16] HID: ft260: i2c: abort in-flight transfers with STOP before reset
Date: Tue, 17 Nov 2026 22:04:18 +0200
Message-ID: <20261117200423.19561-13-michael.zaidman@gmail.com>
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

A transfer that ends without STOP leaves the FT260 I2C controller
with BUS_BUSY set. I2C reset (AN_394 section 4.4.15) restarts the
master but, with the driver still bound, status stays 0x60
(CTRL_IDLE | BUS_BUSY) even when SCL and SDA are pulled up. The
next START then fails with 0x72 (arbitration lost + error) and
further resets do not recover; only a USB replug did.

Add ft260_i2c_abort(): a STOP-only write (flag 0x04, zero payload)
then FT260_SET_I2C_RESET. Use it wherever the host tears down an
open transaction:

  - read wait timeout
  - read status check failure after the HID report arrived
  - write status poll failure after the report was sent
  - SMBus block read with an invalid count (count phase has no STOP)

Leave ft260_i2c_reset() alone for HID output failure (the request
may never have reached the controller), sysfs i2c_reset, and probe.

Tested on a UMFT260EV1A with a 24LC512 at 0x51. Five 1 ms read
timeouts each followed by STOP+reset left bus_status 0x20; raising
the timeout to 25 ms on the same loaded module then read 16 bytes
successfully.

This matters more with the 25/75 ms completion timeout from
"HID: ft260: i2c: reduce driver module loading time", which makes
read timeouts more likely than mainline's 5000 ms wait.

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
 drivers/hid/hid-ft260.c | 43 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 096e46836d74..cf745db8e3f1 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -613,6 +613,33 @@ static int ft260_i2c_reset(struct hid_device *hdev)
 	return ret;
 }
 
+static int ft260_hid_output_report(struct hid_device *hdev, u8 *data,
+				   size_t len);
+
+/*
+ * STOP with no START and no payload. Used by ft260_i2c_abort() when
+ * tearing down an in-flight transfer: I2C reset alone can leave
+ * BUS_BUSY set even when SCL/SDA are idle, and the next START then
+ * fails with arbitration lost.
+ */
+static int ft260_i2c_stop(struct hid_device *hdev, u8 addr)
+{
+	u8 buf[4] = {
+		FT260_I2C_REPORT_MIN,
+		addr,
+		FT260_FLAG_STOP,
+		0,
+	};
+
+	return ft260_hid_output_report(hdev, buf, sizeof(buf));
+}
+
+static int ft260_i2c_abort(struct hid_device *hdev, u8 addr)
+{
+	ft260_i2c_stop(hdev, addr);
+	return ft260_i2c_reset(hdev);
+}
+
 static int ft260_xfer_status(struct ft260_device *dev, u8 bus_busy)
 {
 	struct hid_device *hdev = dev->hdev;
@@ -682,7 +709,8 @@ static int ft260_hid_output_report(struct hid_device *hdev, u8 *data,
 }
 
 static int ft260_hid_output_report_check_status(struct ft260_device *dev,
-						u8 *data, int len, u8 bus_busy)
+						u8 *data, int len, u8 addr,
+						u8 bus_busy)
 {
 	int ret, usec, try = 100;
 	struct hid_device *hdev = dev->hdev;
@@ -711,7 +739,7 @@ static int ft260_hid_output_report_check_status(struct ft260_device *dev,
 	if (ret == 0)
 		return 0;
 
-	ft260_i2c_reset(hdev);
+	ft260_i2c_abort(hdev, addr);
 	return -EIO;
 }
 
@@ -750,7 +778,8 @@ static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
 			  rep->flag, data[0]);
 
 		ret = ft260_hid_output_report_check_status(dev, (u8 *)rep,
-							   wr_len + 4, bus_busy);
+							   wr_len + 4, addr,
+							   bus_busy);
 		if (ret < 0) {
 			ft260_dbg("failed with %d\n", ret);
 			return ret;
@@ -791,7 +820,7 @@ static int ft260_smbus_write(struct ft260_device *dev, u8 addr, u8 cmd,
 	ft260_dbg("rep %#02x addr %#02x cmd %#02x datlen %d replen %d\n",
 		  rep->report, addr, cmd, rep->length, len);
 
-	ret = ft260_hid_output_report_check_status(dev, (u8 *)rep, len,
+	ret = ft260_hid_output_report_check_status(dev, (u8 *)rep, len, addr,
 						   (flag & FT260_FLAG_STOP) ?
 						   FT260_I2C_STATUS_BUS_BUSY : 0);
 	if (ret < 0)
@@ -859,7 +888,7 @@ static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
 		timeout_jiffies = msecs_to_jiffies(timeout);
 		if (!wait_for_completion_timeout(&dev->wait, timeout_jiffies)) {
 			ret = -ETIMEDOUT;
-			ft260_i2c_reset(hdev);
+			ft260_i2c_abort(hdev, addr);
 			goto ft260_i2c_read_exit;
 		}
 
@@ -873,7 +902,7 @@ static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
 		ret = ft260_xfer_status(dev, bus_busy);
 		if (ret < 0) {
 			ret = -EIO;
-			ft260_i2c_reset(hdev);
+			ft260_i2c_abort(hdev, addr);
 			goto ft260_i2c_read_exit;
 		}
 
@@ -1057,7 +1086,7 @@ static int ft260_smbus_xfer(struct i2c_adapter *adapter, u16 addr, u16 flags,
 				hid_warn(hdev,
 					 "smbus block read: invalid count %u from slave 0x%02x\n",
 					 count, addr);
-				ft260_i2c_reset(hdev);
+				ft260_i2c_abort(hdev, addr);
 				ret = -EPROTO;
 				goto smbus_exit;
 			}
-- 
2.43.0

