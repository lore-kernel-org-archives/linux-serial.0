Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793399832;
	b=LqgMasW1oq1dtIgELLhJID3n5c+tZMQW8IGiNNENVUMYkP679E60WV+zN5jkicxInXRE
	 8J+xjjRHSQRT/kzHiWWnk/N3B+pprJYhKq8A1iuuzIU3hP5V0gA8Y4sAonQXKH4sZjCJp
	 wpWa27NaQnD81TuqUipqHVJvg+xO8ISlSlU+hl6XyM/7N66CMEhbmWwSEyPURqM7TNIL3
	 mSQfc6DD+CTgMW5oYFQy3pgnZIHN0XpUh91dau6+fBl9hC+9PxMsSMctlesnVa78NgqQZ
	 B6eBCFhaCuKFwsYcP3D+S6NIu8awGAEZ5OPn1E0S8AgFiy9ElRA7J9tTvhule/KqK8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793399832;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ITruexzC3YrUxXEBUSI41RKRjFRMFCmpkb9IBOKFR5g=;
	b=rAqr+McEFgJfXrWn9GZoUbH3JqoFXb2uqxjTFFgu32nElb7+5xkwONu4XaSQFbilXm5a
	 UMOE5kFy3MaSvdF5VP2CKcP+nztzsyJ5rIwcExpDoqBAzZk+7bFgX2boq2hEpCTuLKNjj
	 h5AWxncOZWsBPt+NDdPlfDlnGTd0zPaEv7+W8Q4B5hmGWLXJNJkD12I56fDIKpekPVqaT
	 ChHqeX/x99mgLS0hgsiu4iC7CuU9ze05ebLxfZXfo8xNNSgX2ekUqsm2Y5bPhA2xPnXKv
	 ZId+hf6LEqFF1hkKSni70zPe5zyb8aMYwC6WwFDwL3919CUx6/qcad8Wj8he9RzlKxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="PBKZ/jnW";
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0DC60A2602
	for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 22:37:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F0DC60A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PBKZ/jnW
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48c5358fc28so945659f8f.0
        for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 15:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793399831; x=1794004631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ITruexzC3YrUxXEBUSI41RKRjFRMFCmpkb9IBOKFR5g=;
        b=PBKZ/jnWa7mmm0tS9g1kfixlHrM8IMYxEIHY2MEbheruyGor+NpYfhGtHuBAVe4OEn
         Rlhq1kUQhAokfvYgRY8u4jkmegL4T4AcB1oEplG9FIz61gKmJYcVUPIaCv8boO1zaYcA
         o6R46deS0v1dTBsiCHpNe5rB+V/TxVK1tP4uy53Vm69DxvvkRJR3YKaLfUQ/hnEgJaKM
         bJ1CdjOSK+dr+iKAbRthch670fYqnBO9M0VVg7NdGVHqQwregA6vSLYbIzjr52XRWQdS
         xOXa0TOG+UIeeRHYnCCzrhLpdp9aqxXWJFwjyvLXwsBdMksu3/zAm4Ziw7MctucOEoJo
         n1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793399831; x=1794004631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ITruexzC3YrUxXEBUSI41RKRjFRMFCmpkb9IBOKFR5g=;
        b=ji63t/ZZZ3qNN9gnCxBQU9gmDm1iDMN4LEtXFbaH0mm4NevwGMEo311xy0ze5Pp3hV
         7KdtC9aQs0JuBZE3FpCMqC4BtEH4GKEzas0sOrBF98ahIgievlgKLE1BkDgMhLHdgy6S
         /JK7i9N1cN1VbgGcUkbhHM/zBhYBw86T5WVFtyAGLdWiRUWd+oMJzOonhNK5zeYxl+Lh
         iYa0c3V7pLCMTQ4PuyccIAfi3MbvALvrinbZfWsR6dmA6t+EI91gMYODYCZrNoIB75j3
         8ftyJXmv2S5LRW7aU6QU0Lwo0YqXLov2XG3mUdcVcrlWkXzmKQrwv4acwkmnMUkgyn9h
         Q4IQ==
X-Forwarded-Encrypted: i=1; AKwUvBxUrNIFgO4kQnVtRT7BJtC2+lsF/Yn+PwlW+By+IV3znRvdujR811jCL/Mp8VV1sfgkWou37RajDWaDLlo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJOqdRxEqs/PYqx3eTO8bYlUN60BnWDb75DxerYLU00jFs86NAa
	ruA+PF8s8uKx3FgsHhUtosIntgmykvgRqy03VJBc01Nt9Mmqjb0Q9T8h
X-Gm-Gg: AYBFou2tFK36nmKARG4Qql+VBRFhlOyk22/MP2FospBd08OvJeequgunORFcWYEck5G
	lju9dJ20Gx16YBwAcXgrXSa5iRwdnQiAERtO6nKq+1kMoVfpU2ErN0y35m3kNy39K6JGtw1Bdt8
	JVszCv0L5GN9KuVsXtV5dPEoEv+PTjvxuL0joJGpv3IJ2+Qq/zK19qjtcFNPG4OzSKsdOWweXlb
	IASu5vQhEhv2PAk6CczpxMhVDS3oqEn+mQHGi5347en9brxZzt24jQ3jZ1/l401WPzBfPX/DIVs
	g+YT45LT2Ab4y4sB7h9c8TXoDzLdDbzX8+F1VI7jnBVVO7tpYCOQp3m80KVH6o6aHetPpDCvi0m
	XJxYUFKquxkpa9Sff9piY9w/Q29bM8SLBuVR3kCG/UeZNfI9A9GXOx9SiPKT4nf52ejDPbQI1vI
	YfftpMUQKtFsb4z4wLC40olXvC97G2jPJsR0OOuGN7Nm/VEMOuxdEJmIXsmXBMK8vtu/Aw9TtLH
	lW3g4fU0G/yYitSYe4amNjtbKrNyG46Ks0qpIm5cUjuQmPI+Aijar06r7v4bpbVCOBxU+3VNe8G
	z7quAMB3YuKioiDo7ZqilHXZlh+/
X-Received: by 2002:a05:6000:310c:b0:48e:2a6c:153b with SMTP id ffacd0b85a97d-48e6e2fb0e6mr8615074f8f.35.1793399830633;
        Fri, 30 Oct 2026 15:37:10 -0700 (PDT)
Received: from m2.. ([37.142.145.227])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48e71b959c1sm5457300f8f.45.2026.10.30.15.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 15:37:10 -0700 (PDT)
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
Subject: [PATCH v2 06/15] HID: ft260: i2c: reduce bus-error message severity
Date: Sat, 31 Oct 2026 00:36:28 +0200
Message-ID: <20261030223637.86907-7-michael.zaidman@gmail.com>
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

The driver logged errors when the FT260 reported an I2C bus error or when
ft260_i2c_write / ft260_smbus_write failed after such a status. That was
meant to flag unexpected failures, but bus scans (i2cdetect, HWMON
discovery, transceiver monitoring, and similar) hit missing devices
routinely and should not spam dmesg with either:

  i2c bus error: %#02x
  ft260_i2c_write: failed with -5

Keep returning -EIO, but print those via ft260_dbg. Still use hid_err in
ft260_hid_output_report_check_status for actual HID/USB transport
failures, which are genuine errors.

Drop the extra __func__ from the write-path ft260_dbg calls; the helper
already prints the function name (reported by Sashiko).

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

---
v2: do not print __func__ twice through ft260_dbg (reported by Sashiko).
---
 drivers/hid/hid-ft260.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index d2c5c9ed7927..6f8d72938702 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -575,7 +575,7 @@ static int ft260_xfer_status(struct ft260_device *dev, u8 bus_busy)
 	 * to 1, bit 1 is also set to 1.
 	 */
 	if (report.bus_status & FT260_I2C_STATUS_ERROR) {
-		hid_err(hdev, "i2c bus error: %#02x\n", report.bus_status);
+		ft260_dbg("i2c bus error: %#02x\n", report.bus_status);
 		return -EIO;
 	}
 
@@ -609,6 +609,7 @@ static int ft260_hid_output_report_check_status(struct ft260_device *dev,
 
 	ret = ft260_hid_output_report(hdev, data, len);
 	if (ret < 0) {
+		hid_err(hdev, "%s: failed with %d\n", __func__, ret);
 		ft260_i2c_reset(hdev);
 		return ret;
 	}
@@ -648,7 +649,6 @@ static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
 			   int len, u8 flag)
 {
 	int ret, wr_len, idx = 0;
-	struct hid_device *hdev = dev->hdev;
 	struct ft260_i2c_write_request_report *rep =
 		(struct ft260_i2c_write_request_report *)dev->i2c_wr_buf;
 
@@ -679,7 +679,7 @@ static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
 		ret = ft260_hid_output_report_check_status(dev, (u8 *)rep,
 							   wr_len + 4);
 		if (ret < 0) {
-			hid_err(hdev, "%s: failed with %d\n", __func__, ret);
+			ft260_dbg("failed with %d\n", ret);
 			return ret;
 		}
 
@@ -695,7 +695,7 @@ static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
 static int ft260_smbus_write(struct ft260_device *dev, u8 addr, u8 cmd,
 			     u8 *data, u8 data_len, u8 flag)
 {
-	int ret = 0;
+	int ret;
 	int len = 4;
 
 	struct ft260_i2c_write_request_report *rep =
@@ -720,7 +720,7 @@ static int ft260_smbus_write(struct ft260_device *dev, u8 addr, u8 cmd,
 
 	ret = ft260_hid_output_report_check_status(dev, (u8 *)rep, len);
 	if (ret < 0)
-		hid_err(dev->hdev, "%s: failed with %d\n", __func__, ret);
+		ft260_dbg("failed with %d\n", ret);
 
 	return ret;
 }
-- 
2.43.0

