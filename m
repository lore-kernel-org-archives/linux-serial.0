Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794945917;
	b=DKRZR+7XfWZiG8MsdvvnHWaWhNksTrmP6aq7EshocjvxX67BZ0vm4XzrEJVTni62pwA0
	 JaRq+Pcei8Y+Dxgxy4lftaRrYJ67nJFoUPV86DPtC74ThHJdXIH3cLu6VtfwewBNk0y7r
	 K0blFrgGJPl4tdyPqx5P6DtczWiguIsoXc7HHAQFuEy3WdxaP64rrLWl1u+fTLVJdMbS4
	 VAH/8PtfVp5fTonk0zvaVEmeYps0MGluuxHrEy35uXQnRUyXUU7otJaDPFZk46Ed9H92o
	 kG3Yo7IrWaSCzznDc8augJzE2ysnlayYwkL5mPJdf18kP6oUx+F5B0TjJ+a2R3lziqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794945917;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oQ6kVNTKtHM/GlFIwNb9GkcrSJOUH3g4l0nbt5E8WPg=;
	b=4ZwSClAiKU0WEq1XYPwHyyGalOmqzyIsufMtEbFaFrygjFWDtHqsvQuywobD3C1GS3tB
	 LFPD04FxtpiIYebwxvGM84b8vCeZCWHMvJ4NxFSgfwBc18mrJyP4rn7KsheaOkADupRV3
	 jOBInGxiTn3JKshFYmjJ+wzbb+QE2rQHsu8P4+IPYC4C1Ee61eYFC4Hxi9OjfDZ0Akwum
	 ntjQVWrSvOZxdjaTCSKVWI+0821vPegy0xdhZO42/HjPvssf4o1GjDnQhroXK1OqeDWMp
	 ZNc5DSx53cdh0LM9C3O17963307N7YlLpCjlBeaWsTqbTxeTbE7FqQb1fnrR1qlvH8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SUyVBPRK;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5D560A6F5B
	for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 20:05:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF5D560A6F5B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SUyVBPRK
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-492f563d1c6so54853f8f.3
        for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 12:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794945915; x=1795550715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oQ6kVNTKtHM/GlFIwNb9GkcrSJOUH3g4l0nbt5E8WPg=;
        b=SUyVBPRKvlIPfyyfb6ETZn6Oj8b+gAXpZ80SFzVZXHh1crDmixmj41Va2EnEXc8FOX
         9f98bIqfQM1Xa0Nksu+TZxCa+HmDaHxPppk8Y9ZM+BDDT1f5poSw3b/+kgZ/mIS1o2UV
         sWTKIA/hzmTGVe9vcRqtxbiZuKWqmGihhxzWNTxa/SicsmYe9eZeE++3LR7L+cKywBRo
         QiDIJxvRqORTekCjEsTfNBMPXP3ak0NIm3LBwDpSSB/pdziXocUb45WHMc4uJySF03eJ
         dKZuF+UFj2Cd5sKkR+fLI0RjiI74dwW62oojhyG9zJmBaNMS2UxMqjwXTBQQyD3YovYj
         0gDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794945915; x=1795550715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oQ6kVNTKtHM/GlFIwNb9GkcrSJOUH3g4l0nbt5E8WPg=;
        b=tjMKEikCqrStDnSrj3FebPCsZ5QbmtMivNII2FGfeqfTPK6ttOgAyt0Y86hbFBcp2n
         U8LU4zKW98DyRUqPJ33TtdTPtbLYP+5Xsia7n3fuupQRCouN8N9vXLEoQrJNIlIjHysu
         rnhk2UQN7pTU/r8SCP3jx1AA74LOW8x7U92dnOToGJtE1UhP9QV2flGWv3XJvmFtXxc5
         /2Cu9aKAB50gM4W5bwhz9SytvwFIuxcRfIYf1EwgZ+pqg4WqMzr86h++LaMpYjePipP/
         +8KevduF8nUPcKo4rlpf16GG9GEPKzzlk42VIQWmFUVowtbIpoybY7gvfeDEq5BiMpIZ
         yaHg==
X-Forwarded-Encrypted: i=1; AL+hErEmEIJPQ+mILQHS5JlaMgSGjq1O6/G+g0H+kac5vQlhw3wttjcGg4nFoqTM5BKb0L0np0SAp1mPdDMVpDY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+TweqAUdx/jXW+TiHAopaQlNuq1GMpXI4fpDScox/DFMtBVxEv
	eq+KCsenIKdbZ4PNqVcvqhY/Vk75wLXSpiYwWfplW6qxsVuzT+wGsJ9g
X-Gm-Gg: AZFdTZcR8cuL2EPros/v+kmfUk88EGQYlROeKQojy9cof4kNY0RaqQfZ1fPn1+g9AMg
	AmV6bXyK2fel9XrqEHjZyPvnNXH9zAjYHltKiJgwxs3FVErPm3ex/HO4InExu+ZNaT0J62yVOMg
	pp82g3yyuN6Hg3eJscZui76u1Ga2cqteY9drU8Tm76GmC0CHFqV4lkzTedyiP9tJ5xH8GvaiB+P
	PphNA7h9bdy6fKF5u6EwQvow8ROdL3BErfERsGgfZ4ddyhGtDAkQ5jIAeKrmBHLbuvbdF1VYGIB
	EKJo5GB1W9yQsL5JQi/S4YqTgExw7NsNU/ni1EtUA9ji9Z508pBk0927TXBkxPctCy2U4uja7WG
	OznOrwb0QgNX1FkqAHC0hCY8i6iSgqBsG11/+kUG5rWgddZ7t5UjqGlB4tF2ZvoEDFOSdX2Jklh
	wItnEWtHjXsdLyVla5Ckh+jetOf5IgKb56+pRw4NAbJOAMovtS4mkV51rDjefQpvR7Ab4+65uOO
	V/dHXScDFCpqDrRz93ZyPF+pGuMXcJgpq8yyysiVe+cf9+EVSBsa2PnrGaiRrrWvHgpQaZOCfGn
	esqgYs9BU/i0WrdcalFCij+oIGpl
X-Received: by 2002:a05:6000:4555:b0:4a4:7328:21f1 with SMTP id ffacd0b85a97d-4a63ac6be9fmr782897f8f.24.1794945915115;
        Tue, 17 Nov 2026 12:05:15 -0800 (PST)
Received: from m2.. ([37.142.154.208])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4a64b60940csm625528f8f.0.2026.11.17.12.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 12:05:14 -0800 (PST)
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
Subject: [PATCH v4 06/16] HID: ft260: i2c: reduce bus-error message severity
Date: Tue, 17 Nov 2026 22:04:12 +0200
Message-ID: <20261117200423.19561-7-michael.zaidman@gmail.com>
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
index bdd55b35df9a..f722ef0ddf06 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -579,7 +579,7 @@ static int ft260_xfer_status(struct ft260_device *dev, u8 bus_busy)
 	 * to 1, bit 1 is also set to 1.
 	 */
 	if (report.bus_status & FT260_I2C_STATUS_ERROR) {
-		hid_err(hdev, "i2c bus error: %#02x\n", report.bus_status);
+		ft260_dbg("i2c bus error: %#02x\n", report.bus_status);
 		return -EIO;
 	}
 
@@ -613,6 +613,7 @@ static int ft260_hid_output_report_check_status(struct ft260_device *dev,
 
 	ret = ft260_hid_output_report(hdev, data, len);
 	if (ret < 0) {
+		hid_err(hdev, "%s: failed with %d\n", __func__, ret);
 		ft260_i2c_reset(hdev);
 		return ret;
 	}
@@ -652,7 +653,6 @@ static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
 			   int len, u8 flag)
 {
 	int ret, wr_len, idx = 0;
-	struct hid_device *hdev = dev->hdev;
 	struct ft260_i2c_write_request_report *rep =
 		(struct ft260_i2c_write_request_report *)dev->i2c_wr_buf;
 
@@ -683,7 +683,7 @@ static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
 		ret = ft260_hid_output_report_check_status(dev, (u8 *)rep,
 							   wr_len + 4);
 		if (ret < 0) {
-			hid_err(hdev, "%s: failed with %d\n", __func__, ret);
+			ft260_dbg("failed with %d\n", ret);
 			return ret;
 		}
 
@@ -699,7 +699,7 @@ static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
 static int ft260_smbus_write(struct ft260_device *dev, u8 addr, u8 cmd,
 			     u8 *data, u8 data_len, u8 flag)
 {
-	int ret = 0;
+	int ret;
 	int len = 4;
 
 	struct ft260_i2c_write_request_report *rep =
@@ -724,7 +724,7 @@ static int ft260_smbus_write(struct ft260_device *dev, u8 addr, u8 cmd,
 
 	ret = ft260_hid_output_report_check_status(dev, (u8 *)rep, len);
 	if (ret < 0)
-		hid_err(dev->hdev, "%s: failed with %d\n", __func__, ret);
+		ft260_dbg("failed with %d\n", ret);
 
 	return ret;
 }
-- 
2.43.0

