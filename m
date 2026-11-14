Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794697735;
	b=QQrQSwu+xwDV4IfEHXADEOw7T/p/ARhN9sNgCfgWuJxwI0Brzscz6MdpyvubSyf8aMAk
	 bE3DIcOXH9HUV4BpZ1eLMdnmqsOuLyIg5R6SRwcs3PB9GrV4x5v25fYOTHocUhF9j/z1C
	 tcYRxKQ9qL5YoADLz8UAMMRWkQSc4kXXpxMkBUmO4AW1zPTx1iK7Kucz9dPKMTKQK0uHc
	 s3KsSQILx2JAOx0HDxTPU3XQQjaDGrjWNvJehzLmgOLihsCo6x5ZLKvPae1CwJx5d7Lqd
	 sYavXiKuUyMEaqb1+RauPliRUD2Twnw19JbEqSRciU03RhYTElFXpDX9YmjLm7TMCnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794697735;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=hh9ybCpP5y8fCdG/ue0SgeIlejwXAiQet93xa73o/ck=;
	b=flqmj8SxLgyxAKZbUYlmISn0gUR9CVLJAU4kg32Jl6kllcnAxyEgMdeq8wFPdFC6oQHS
	 HGqMCdT+y2rPOtdQ+qmi1PbvZacO1uor4OnwEVq8bor11UqmqDam4uaTotyuQaHBZt3El
	 l/szwDutNHjwpHmbm7Zl+as79ioaXb/Sh8gFeXWE2JiiRbc5nNbVMYtPAKCWW3oPGwFzh
	 dCNTQ9dopxIFFerD5JG9fiq+k+bIcf/awT978xZzAciH7ttE78rU8EwEJ8vMdhXJ+LwP4
	 OpWdDxFRzOwjZMb/BV8il/Nhak3SgaloKS0CCRiAvYryMhY4ABegz239BF+iY1IsKFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="jeFJb/c0";
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E351660A6F5F
	for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 23:08:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E351660A6F5F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jeFJb/c0
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-490d59c3f0aso782326f8f.1
        for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 15:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794697733; x=1795302533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hh9ybCpP5y8fCdG/ue0SgeIlejwXAiQet93xa73o/ck=;
        b=jeFJb/c01M9tftwZV+FhKblIVrnpLKLb+K0qW29KG8tNYlpIt2M0ZA/r3nSu2sNB00
         MwRBxF+fvkIJobYzGZlbR9zhP1oSohsw9+QLS/qLiDoNr215xRcFwSxqToxY1PgEr75G
         yYxSxbq6ZprH62dUFNhBIkEqmEUTIkYo0m3OKc18rbjj+64lwlFKnKcFeT/TuI2fIxO8
         PRtGSohTG4gGxMjlnn1dqiOCGxe2BYWtY9zeyiN91yQZltWhb0tuB8CrrBgn1XoUZV6A
         PZzeLPUWEFUUBdoh7wkx6yS4wTgfvAuxvZ7LbaWK0TgMCAYSd3RO1Vkt4JkvyslI6ypC
         8d8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794697733; x=1795302533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hh9ybCpP5y8fCdG/ue0SgeIlejwXAiQet93xa73o/ck=;
        b=IULzdxHjzMkGzWEMng3L+JdLEqxmbhrhEN8YQBSldz+tN/A8pvbt26EM+v1icRzf6S
         oMSMiYNvD3V2hLuCl93qESsxkuO4KA0m0T8zXt9gYuaVTp2pT3sUTUpS3fMCxvhzsXKy
         HOq7Y/Fhql9oZDO4uX7xoKZ2w14pwpRCHrNHSTCMUOiH7COZgkqANheTjYu3La5VTlUk
         9glt5IukU7K4NIAU8Ebw1srs32dnUe1aIa0m8BFJqiSmn2dERKkuHLsKbFt+G2It1ReJ
         YlfLuKh2j3yAJcLNsI26aFIMd6P4f/BaqQQgxJrwbLJJ9pdtYzb+nqwHl5jq6nbnRttc
         qzHQ==
X-Forwarded-Encrypted: i=1; AL+hErFDUGfUTJm5gSY58dPQc/9JTehCMbLuZPrz5LJ6C4S8SwxQRP7VA7RwlkiShrWhTAcZ196QTs7jn/DlcW4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+FnlTygaqR15F+QhuTTxg2NJp/zqlFssvGZ6aKJK/NPil5M6cJ
	KP5Y+SVeiy3E4UbxBsLHxqDDZE5cqIBwwti5Ai91I10cjfm8aLXNY6gm
X-Gm-Gg: AYBFou3G+KkAF6c29m2lsdwDDsLwikMRGMdo3MXMrNQBVzRRrX98yXL51o/Jv0CX9ac
	KVEyPEgne8RzxdQBOB1Pp7uqwZwGowPFOGgWDhAMcczV48zT8pUZqmZRaP2lNXqgzjpO0eKLP0b
	/BV4oFixxJgMAEGbvZ5DoBcwtA9QwB/bEDQDP5SQnDxTxMAVbrMfox2ezz2tJ4c/x8OsziW+KUm
	ULuZLgQwcNz9Me3IQrQTBdxc2+4nwFBxJcyQT94+6bg9BV/BvWSa4U21iT6OtD+G0AosYnfJGKj
	H+a+QBRGph/i3dMtnNZyhcrnEQ9G/XM+SbB6C8II36h1j52rZnet0mLbqj47uMry0EK0LTxs5u9
	KeorfFZzW6c1gfOr3cnSKvLz1fv8lko9j70ilDwwmtctaIm8QxHhAkv/mOMeerMj78tV9euZTVW
	AIj3KBmghmDYxkTtah/lPSsULI9r+NBdiasFykNrX97ZV9Y1oMySywFiu2uhM/TA6CaYTIAduDC
	DuKwEicXoX1ePGgyXtOnekcEGDRFaR7jC8RRJz9fW6X8FZszitufJAS6LvNxyJfIo1E9TjDvvQ6
	LliGzDQ9S41hxPjNLEtQCvF9xTTj
X-Received: by 2002:a05:6000:1a8a:b0:48b:f93:3b87 with SMTP id ffacd0b85a97d-49c726da6e1mr15621389f8f.30.1794697733385;
        Sat, 14 Nov 2026 15:08:53 -0800 (PST)
Received: from m2.. ([37.142.149.161])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-49c5d03b10fsm14910018f8f.1.2026.11.14.15.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 15:08:53 -0800 (PST)
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
Subject: [PATCH v3 13/16] HID: ft260: i2c: reject an I2C clock outside the supported range
Date: Sun, 15 Nov 2026 01:07:57 +0200
Message-ID: <20261114230800.1344401-14-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261114230800.1344401-1-michael.zaidman@gmail.com>
References: <20261114230800.1344401-1-michael.zaidman@gmail.com>
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

The clock sysfs attribute passes any 16-bit value to the chip. The chip
accepts it, reports it back in the I2C status report that clock_show
reads, and runs the bus at the 100 kHz default. A read of 2048 bytes
takes the same 0.298 s after writing 50, 3500 or 65535 as it does after
writing 100, while 60 and 3400 give 0.387 s and 0.058 s. Userspace has
no way to see that the value was not applied.

Refuse a value outside the 60-3400 kHz range named in the datasheet
section 4.4.16. ft260_uart_change_speed() checks the baud rate against
FT260_UART_CFG_BAUD_MIN and FT260_UART_CFG_BAUD_MAX, but termios has no
error return, so it falls back to 9600. A sysfs store can return an
error, so the clock store refuses the value.

FT260_WORD_ATTR_STORE() takes the parse function as a parameter now, so
a word attribute with no range of its own keeps passing kstrtou16.

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
 drivers/hid/hid-ft260.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 5564ed62cc48..391128e4bb35 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -69,6 +69,11 @@ MODULE_PARM_DESC(debug, "Toggle FT260 debugging messages");
 
 #define FT260_WR_I2C_DATA_MAX 60
 #define FT260_WR_UART_DATA_MAX 60
+
+/* I2C bus clock range in kHz, see the FT260 datasheet section 4.4.16 */
+#define FT260_I2C_CLOCK_MIN 60
+#define FT260_I2C_CLOCK_MAX 3400
+
 #define FT260_GPIOCHIP "ft260_gpio"
 #define FT260_GPIO_0_5_COUNT 6
 #define FT260_GPIO_A_H_COUNT 8
@@ -1592,6 +1597,25 @@ static void ft260_attr_dummy_func(struct hid_device *hdev, u8 req, u16 value)
 {
 }
 
+/*
+ * The chip takes any 16-bit value and reports it back in the I2C status
+ * report, but runs the bus at the 100 kHz default when the value is
+ * outside the documented range. The report gives no way to tell the two
+ * cases apart, so refuse the value here.
+ */
+static int ft260_i2c_clock_parse(const char *buf, unsigned int base, u16 *clock)
+{
+	int ret = kstrtou16(buf, base, clock);
+
+	if (ret)
+		return ret;
+
+	if (*clock < FT260_I2C_CLOCK_MIN || *clock > FT260_I2C_CLOCK_MAX)
+		return -EINVAL;
+
+	return 0;
+}
+
 #define FT260_ATTR_SHOW(name, reptype, id, type, func)			       \
 	static ssize_t name##_show(struct device *kdev,			       \
 				   struct device_attribute *attr, char *buf)   \
@@ -1649,9 +1673,9 @@ static void ft260_attr_dummy_func(struct hid_device *hdev, u8 req, u16 value)
 		FT260_ATTR_STORE(name, reptype, FT260_SYSTEM_SETTINGS, req,    \
 				 u8, kstrtou8, func, FT260_STORE_NATIVE)
 
-#define FT260_WORD_ATTR_STORE(name, reptype, req, func)			       \
+#define FT260_WORD_ATTR_STORE(name, reptype, req, strtou, func)		       \
 		FT260_ATTR_STORE(name, reptype, FT260_SYSTEM_SETTINGS, req,    \
-				 u16, kstrtou16, func, cpu_to_le16)
+				 u16, strtou, func, cpu_to_le16)
 
 FT260_SSTAT_ATTR_SHOW(chip_mode);
 static DEVICE_ATTR_RO(chip_mode);
@@ -1704,7 +1728,8 @@ static DEVICE_ATTR_RW(clock_ctl);
 
 FT260_I2CST_ATTR_SHOW(clock);
 FT260_WORD_ATTR_STORE(clock, ft260_set_i2c_speed_report,
-		      FT260_SET_I2C_CLOCK_SPEED, ft260_attr_dummy_func);
+		      FT260_SET_I2C_CLOCK_SPEED, ft260_i2c_clock_parse,
+		      ft260_attr_dummy_func);
 static DEVICE_ATTR_RW(clock);
 
 static ssize_t i2c_reset_store(struct device *kdev,
-- 
2.43.0

