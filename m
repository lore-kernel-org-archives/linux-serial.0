Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794697716;
	b=VVwT9TLSjRh+3auF9wSp4UQ8vasJGK7gklWMzGTiq1d2JEqrcmHVGH/PMdyEc8C0UVkN
	 OY5MpQQi7dnSUMlD6+VFhMzmyu6uGrxR+1qZsYYyrGyN3Uzj2AnbMhLI8YcTJ9Nf+nz1s
	 xeWI5tB3aMeh1XyLYguIHPJufphqfm6130E54tllmg2CDxizQiOVANJkkUn7IUK3k08g1
	 nMxAr3d/uFnJfQChFXSKvA/dyLohvklp42idnc/aauKpKUPWcczmVGhky+gyP95QMFX5o
	 Fws3+qy29dS9AzlVsqWHNfXjQ99lJ1KgZQpwXm7+y3CqJfBYqhdYveOB58yWOwjBggw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794697716;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7tlqBEORNJM+EJ64JjfZpDzizcgcXj+RIpcTDkE/fcA=;
	b=GnlFh5LAwKJxCKkYa2b8F0zwp1Nm5mrLuWc3Mi/YRGgcUKAYOTdAoTsiCaHt1t7YYaRv
	 GgvvL7Pt6GipMZTRtxfRyINGwwzzCiw7PJObjw+70VGVOoAQSpA4+MpppUsyCaKPpH+Zc
	 yY62heCAd8sYAaYKj1xmwdrk8MiVnecmjs46Qpg+/PEbCTXzMfUG9eYqYglXPuY8PyKcF
	 fjB7qUWNWfk28PAWIBujsvKND1cFIn0oeql669HGa/y0elejKTKj6iYeDDmVwelACRAfK
	 73dnp5WgSMNmgyL8T+seC2wLeS/w+HGrUlSyoFpfC1fO9ePZH/SCidHWvIJrmYgvMeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jx83ylx2;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003D3606A895
	for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 23:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 003D3606A895
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jx83ylx2
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-492f0a1b685so1702678f8f.0
        for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 15:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794697714; x=1795302514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7tlqBEORNJM+EJ64JjfZpDzizcgcXj+RIpcTDkE/fcA=;
        b=Jx83ylx2taxMD9eTcVWDa1NgH5ig+fmVfCT4xi+3Re12S4rD3N/khXcjy3CM0rwUP2
         Hl9tX63MSY/oLIvpiysvkZYFtW+Vn+MrbYUFMSovwfsr/VrYEWV9mvtk532lpYRfk/yY
         P3zcSkzJF5W32wGxL3w7TovLmlAzO7GpGgVjifTObB/y9LbODTcH1HmWsQjaVATRw/2z
         Sk8gRc3Mo95d3pPQLUHGBQh2OTIhWE33uqLHPCON5NlGPI3wdcJHqGWwPxlgYIWbNm18
         2YR0GqHBSTcgAwNrXAXK7eMhJ1NdFwd57ziPd8Q/FiE2XlIkHwtVEAG6RaWboaJ9rP7E
         HZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794697714; x=1795302514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7tlqBEORNJM+EJ64JjfZpDzizcgcXj+RIpcTDkE/fcA=;
        b=osS9eK5LDem8h0bSk67hqt2w+JWjx1Ror9U0TkXpWn/IAZpmCIcAHdd5yeswwyh6cW
         7BcZZF87Z7KXxnN3l3iaAs+kAtQEyj+eWJmbQYoFTtQ98apxVHmF4OpGkTpOxqF41e6B
         leg/suCtRlrvjV2EnwG1QqNJh3Yo9rChR3hsxsJXxXwykgeUb9aTOSE84DqXfOcnELVT
         6KpF0ItJTpbqlitlX6vr/BAJO2lP362cnV0j9V7Z5ONO+LWjOoB3YLF44xxAHf3WOh09
         8ySuI52UvfZHHCR3YlbmgdzPZpqFEFEm5vB4bVxuW3Y31XnTUb0P9WCEwXXUwOasz6XC
         luDg==
X-Forwarded-Encrypted: i=1; AL+hErGPW/o/kECFOHoHWVzBePSGkoVgiXcK/vv7UaqvjsA5nermLYdeSl0GTR6FGLKj7z5KFLhTEYRdCFsRaRg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+mYyYWG5/LWfZArVi6tYwgDbs1Yi3l5Bx/n8PKVApMrw5bVBYp
	eP7zBdUAnIu+LBT+IOqb4gcQ4bZCOj0CWF4KtFbIZ4Axq2nAzOhiam2u
X-Gm-Gg: AYBFou2S92tNxfIvob63EfCLuhv4WVPSe1hgmJiZizgcQyydeCBLAk1qhHw26MzVCjr
	skk0stM6LOkKALo/BGO7y+78hHbUtaUkPv813SExYkIDJaBlUdKTUG1T49neBF5rt/LxL9CfK5v
	GQq2r9u6qCHqH7PaJzKzh0LT2atHlckPdOus322f5ybAIx8ec40a3lEDWa8z/jbfFTXPG802KjN
	jGZ64cTx1O6aa/OkSF+UMXMkk9PnKAuYYK1Flt7+G3X9R6+8nK+Ykg8QN6v7L7hbJybAOMkK6Ba
	YaS0Km1ExoqmeCvkQpcylOmpad158ehPfp+4yhu/6rlHw8XgigoQrt7GjOJCTTTBwpPQque/tK6
	4tvyw+uYdcuhTIZVOXieGX19DgCzJstKUBpBu/mtaMfFrY+B8AHTe2jFAq4imFaIyCLrW/EGEpG
	T4lSNf0ApMW6ghmGqtN2iqai44tOowrGWbXuIN7/63i6ncaea6dwEic3J4+QcUrHb32HYX215Rn
	3FMAi1NIrzD55CI34433PuUfsSHkIJiBr36Z+NkNUZCEVWSGhgYzDAid4jArfLIvOS5Eg0z0Jyr
	k1rHxd4rol7mhShz6RMof4gPEStXrg==
X-Received: by 2002:a05:6000:26ce:b0:48c:571a:a1aa with SMTP id ffacd0b85a97d-49c70de38a0mr13439813f8f.19.1794697714304;
        Sat, 14 Nov 2026 15:08:34 -0800 (PST)
Received: from m2.. ([37.142.149.161])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-49c5d03b10fsm14910018f8f.1.2026.11.14.15.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 15:08:33 -0800 (PST)
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
Subject: [PATCH v3 04/16] HID: ft260: i2c: reduce driver module loading time
Date: Sun, 15 Nov 2026 01:07:48 +0200
Message-ID: <20261114230800.1344401-5-michael.zaidman@gmail.com>
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

The HWMON class I2C client drivers register the address range to scan
during the I2C master module probing. For example, the lm75 module
registers eight bus addresses scanned during the ft260 module loading.

In the case of ft260, the bus is scanned by ft260_i2c_read, but due to
an excessive read completion timeout, it took about 40 seconds for the
ft260 driver to scan the lm75 address range before exiting the probe
function.

Adjust the i2c_read timeout so it depends on the amount of data to
read, reducing the lm75 address range scan time to about 200ms.

The 25 ms per-report budget was checked on a UMFT260EV1A with a 24LC512
EEPROM by shrinking the timeout until reads began to fail: a 60-byte
read still completes at 9 ms and times out at 7 ms, against 5.4 ms of
wire time at 100 kHz, so the fixed USB, HID and scheduling overhead
costs a few milliseconds. At the chip's slowest 60 kHz clock that chunk
needs about 9 ms on the wire and a 180-byte chunk about 27 ms. Scale
the wait by 25 ms per 60-byte HID payload so a last chunk of 61..180
bytes gets 50..75 ms, not the single-report 25 ms budget.

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

---
v2:
Fix for the issue reported by Sashiko: the timeout of the last I2C
read chunk is computed from rd_len, so a chunk of 61..180 bytes gets
50..75 ms, not 25 ms.
---
 drivers/hid/hid-ft260.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index a924ca2eef88..50389b3e79d8 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -17,6 +17,7 @@
 #include <linux/serial_core.h>
 #include <linux/kfifo.h>
 #include <linux/tty_flip.h>
+#include <linux/math.h>
 #include <linux/minmax.h>
 #include <linux/unaligned.h>
 #include <linux/bits.h>
@@ -49,14 +50,20 @@ MODULE_PARM_DESC(debug, "Toggle FT260 debugging messages");
  * The ft260 input report format defines 62 bytes for the data payload, but
  * when requested 62 bytes, the controller returns 60 and 2 in separate input
  * reports. To achieve better performance with the multi-report read data
- * transfers, we set the maximum read payload length to a multiple of 60.
+ * transfers, we set the maximum read payload length to a multiple of
+ * FT260_RD_ONE_REPORT_MAX.
  * With a 100 kHz I2C clock, one 240 bytes read takes about 1/27 second,
  * which is excessive; On the other hand, some higher layer drivers like at24
  * or optoe limit the i2c reads to 128 bytes. To not block other drivers out
  * of I2C for potentially troublesome amounts of time, we select the maximum
  * read payload length to be 180 bytes.
  */
+#define FT260_RD_ONE_REPORT_MAX 60
 #define FT260_RD_DATA_MAX 180
+
+/* Time in ms to wait for a single HID input report at ONE_REPORT_MAX */
+#define FT260_RD_ONE_REPORT_TO 25
+
 #define FT260_WR_I2C_DATA_MAX 60
 #define FT260_WR_UART_DATA_MAX 60
 #define FT260_GPIOCHIP "ft260_gpio"
@@ -724,8 +731,8 @@ static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
 			  u16 len, u8 flag)
 {
 	u16 rd_len;
-	u16 rd_data_max = 60;
-	int timeout, ret = 0;
+	u16 rd_data_max = FT260_RD_ONE_REPORT_MAX;
+	int timeout, timeout_jiffies, ret = 0;
 	struct ft260_i2c_read_request_report rep;
 	struct hid_device *hdev = dev->hdev;
 	unsigned long irqflags;
@@ -750,6 +757,8 @@ static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
 		} else {
 			rd_len = rd_data_max;
 		}
+		timeout = FT260_RD_ONE_REPORT_TO *
+			  DIV_ROUND_UP(rd_len, FT260_RD_ONE_REPORT_MAX);
 		rd_data_max = FT260_RD_DATA_MAX;
 
 		rep.report = FT260_I2C_READ_REQ;
@@ -774,8 +783,8 @@ static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
 			goto ft260_i2c_read_exit;
 		}
 
-		timeout = msecs_to_jiffies(5000);
-		if (!wait_for_completion_timeout(&dev->wait, timeout)) {
+		timeout_jiffies = msecs_to_jiffies(timeout);
+		if (!wait_for_completion_timeout(&dev->wait, timeout_jiffies)) {
 			ret = -ETIMEDOUT;
 			ft260_i2c_reset(hdev);
 			goto ft260_i2c_read_exit;
-- 
2.43.0

