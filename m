Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794697720;
	b=WNXuZPOPAyYDB08n3aRTKqY+Tm5AZItRTwt2gnPiDf5OTni8HfhkCjfCgIn8dTU2eSa0
	 fW1sqr5hne32pCp5f+jIzvzzLj6of1Pf9w+aNjXmSX1YRqMPg+xlR3AxGl0zDb4p9iDL9
	 t/zd6vA3WcU2P1sGvMpKVcwluL803EvRnb3J8SQl7LmzyhCRDBVJcrKYiMjdVxu76r+F0
	 KZTOUsdqPmDtPpMKivK9Uw867ZbK2Ss2xNtmNq4dKxbVwl15PHJ9Y+duFvrlWUBTygn9g
	 zuSAu1hhWn+C65dSraM0Inbfm37UaVaXOydAt+Sde3V8yqcOIgdV7cQp2kPXa27Z0qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794697720;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6gQE3IU+t2cIqdtVZhrTpEEYl5O5vhKOK1Q7R6X/tsg=;
	b=32PYJvZpbRbkhxUffrbHtW6CGOIaCXZg+yTcXE+ihQZCWmalWzmJr9qqNUg+S6AIudPq
	 v01RR2T1E2ARgMOcYb5wWOHiCX00r5WUaWg7QowSxdvulSvbkC8C7mMbDu3HVaKhTgUZh
	 CPzqHwY1WOGN2yOA9JiUBR8Y0rFpjwdLslCZKsh6ukTuFScLOPgwxxA8runXYOCgrvvOD
	 cLfJ2aTe1KFmep6aijUvMXcjQ6Zzs2FPBBKSmUmQwG8ZXH/CiZtiHPPkiGbxWCTtAPbka
	 GKbdy6pPvhMS+wE7lzam0QMVDzYiKxxRyGgK6dElVUZq+OxhRrgjsJuI2oEG8AE3DtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DzSqjZd2;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3806160A263E
	for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 23:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3806160A263E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DzSqjZd2
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4bb666304fdso3504415e9.0
        for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 15:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794697719; x=1795302519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6gQE3IU+t2cIqdtVZhrTpEEYl5O5vhKOK1Q7R6X/tsg=;
        b=DzSqjZd223Xa2elVAQbBkL6ejqVgE4nK5Yshf20ooHKziJQK2mgAEAXDKFgmVWyiSO
         nvKfNG6QmenzeaFXtWwoRLOAaH9ZcSxrlIAwL8mkpCirGe2nAx3S7j0x9qHIY8iv93o1
         udRKrfiuqFz7gRZ4sSRBLO382WKomnZYUdKJv7cpxeec3qzeQjF+vE8TP9VC81m0w0kn
         2OocJCXx2gFPpO3GS5le07hQKTb3fpdDiOO659DvFBekV3WFLiJ6x/ywAgBxzaGHB9dE
         rfINzOwENIrjTD/n8Jtc1ev1zXxRmQmhqX91w+Fj0XAi7H7sgTXrMEz1XR9KeKjaDQor
         DINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794697719; x=1795302519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6gQE3IU+t2cIqdtVZhrTpEEYl5O5vhKOK1Q7R6X/tsg=;
        b=n7BkwBWjdsU0wTEYiAhrn7GEXYuzP5nEnnAHp2lGLdOZf12QNc+5OYLoJhV8MAsmFS
         rfc7T1X9AVSu1ZgJJDhzvJaH9O0D9obCnT/Tyzq9gy5G2fcP7/8BTlT7abuNzS/tGCwZ
         ebkJKgZnX4sHnBoFJIJiyvuohWHCAJQn488LGjCQUlvBn22YSF62y1Zy7M9LpCsiXXbL
         K0OYdP9N0FQlFPFUj96izkS5QfKwnaA2N1qiRcV6JQ+XUVaszHagUnhmyX0DL7YK3BWu
         CaItPu+EuRaEzAvbQaGVuqLuL+nL+YfNBY+sGGSxpd4AsjbSN0ajzAtMEN3RsnLcj0Yi
         qtgg==
X-Forwarded-Encrypted: i=1; AL+hErEDseaphwH4/N6CzIyVH1+nh/Okpndu6rjFYEAKm4Bff2TnFoAKQmwyrsw7ZXC42fUiHX8KYPr44QVZksQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Gjdcmvsh8SUO/FLtuep26Zlf1PqGl4sago7oU3HEmyUrngkAf
	vkwi1XCBtTGPNj/l1zn7xBPOBqkjwg0ZvBnvX2Fi++Akf1AI0FtFPB2P
X-Gm-Gg: AYBFou1Z8y8WiZSmxXY8Ioz41DjbB2ibAxvl10TmSOf5hol+FmeQDIpLVWps5RSyDdj
	THmMpz7urY5e8T71YCsc72uCkR/AhoTqyBSAnnpPULsrisL2qX64wNgn0MCf0U07cmNaUETTyqM
	nPT5JbGwBhQai9EGzBy12kHVWoJ0ZGWKOKYnUaZ0QW+nMHIKWwlzKB9EDIFTJC9cMHrCSKdxnfb
	kILOWIuUAd7D82VADWHD3yT/lObQCyfgVBjviPHiRgi/rYBEJujwUI9+9BkO2Zm3Q0yAIJkga4M
	68X/9HmDycwwgMniC2wpR/1vnarzpLze5pprcKWKLOJt8cmW8KlnMxRwiVV6Q/TaRHvg8stpZZD
	KqU8cWn+l+ALaD3z9HGxwbb+QOzL2uMuyKoLOJQWXDv1/Vix8u+MAmIUyW/yBn2PZsl4dcyCNMW
	pKh6ZGmzYy5mhXXKRaAOTm6EAmCnhoqD5RWFhpGyhfspdjRi6s2sfHCPJSKaa33sgBo9n+UbFRw
	iYaA4h27s2KZDO90/i0auFXmH6QJnqqq25RM3sAykC0XyWYcv0HwJehvifBjFEOTVKR592O0j8D
	d5GC3LJKVSSsg4KhdTUkltgWoU9x
X-Received: by 2002:a05:600c:588b:b0:4bb:643e:3b8a with SMTP id 5b1f17b1804b1-4bb643e3bd6mr54723335e9.17.1794697718472;
        Sat, 14 Nov 2026 15:08:38 -0800 (PST)
Received: from m2.. ([37.142.149.161])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-49c5d03b10fsm14910018f8f.1.2026.11.14.15.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 15:08:37 -0800 (PST)
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
Subject: [PATCH v3 06/16] HID: ft260: i2c: reduce bus-error message severity
Date: Sun, 15 Nov 2026 01:07:50 +0200
Message-ID: <20261114230800.1344401-7-michael.zaidman@gmail.com>
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

The driver logged errors when the FT260 reported an I2C bus error or
when ft260_i2c_write / ft260_smbus_write failed after such a status.
That was meant to flag unexpected failures, but bus scans (i2cdetect,
HWMON discovery, transceiver monitoring, and similar) hit missing
devices routinely and should not fill dmesg with lines such as:

  ft260 0003:0403:6030.0001: ft260_i2c_write: failed with -5

Keep returning -EIO, but print those via ft260_dbg. Still use hid_err in
ft260_hid_output_report_check_status for actual HID/USB transport
failures, which are genuine errors.

Drop the extra __func__ from the write-path ft260_dbg calls; the helper
already prints the function name.

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

---
v2:
Fix for the issue reported by Sashiko: the write-path messages
printed the function name twice, because ft260_dbg() already prints it.
---
 drivers/hid/hid-ft260.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 13dbff661fab..270481766e2c 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -577,7 +577,7 @@ static int ft260_xfer_status(struct ft260_device *dev, u8 bus_busy)
 	 * to 1, bit 1 is also set to 1.
 	 */
 	if (report.bus_status & FT260_I2C_STATUS_ERROR) {
-		hid_err(hdev, "i2c bus error: %#02x\n", report.bus_status);
+		ft260_dbg("i2c bus error: %#02x\n", report.bus_status);
 		return -EIO;
 	}
 
@@ -611,6 +611,7 @@ static int ft260_hid_output_report_check_status(struct ft260_device *dev,
 
 	ret = ft260_hid_output_report(hdev, data, len);
 	if (ret < 0) {
+		hid_err(hdev, "%s: failed with %d\n", __func__, ret);
 		ft260_i2c_reset(hdev);
 		return ret;
 	}
@@ -650,7 +651,6 @@ static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
 			   int len, u8 flag)
 {
 	int ret, wr_len, idx = 0;
-	struct hid_device *hdev = dev->hdev;
 	struct ft260_i2c_write_request_report *rep =
 		(struct ft260_i2c_write_request_report *)dev->i2c_wr_buf;
 
@@ -681,7 +681,7 @@ static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
 		ret = ft260_hid_output_report_check_status(dev, (u8 *)rep,
 							   wr_len + 4);
 		if (ret < 0) {
-			hid_err(hdev, "%s: failed with %d\n", __func__, ret);
+			ft260_dbg("failed with %d\n", ret);
 			return ret;
 		}
 
@@ -697,7 +697,7 @@ static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
 static int ft260_smbus_write(struct ft260_device *dev, u8 addr, u8 cmd,
 			     u8 *data, u8 data_len, u8 flag)
 {
-	int ret = 0;
+	int ret;
 	int len = 4;
 
 	struct ft260_i2c_write_request_report *rep =
@@ -722,7 +722,7 @@ static int ft260_smbus_write(struct ft260_device *dev, u8 addr, u8 cmd,
 
 	ret = ft260_hid_output_report_check_status(dev, (u8 *)rep, len);
 	if (ret < 0)
-		hid_err(dev->hdev, "%s: failed with %d\n", __func__, ret);
+		ft260_dbg("failed with %d\n", ret);
 
 	return ret;
 }
-- 
2.43.0

