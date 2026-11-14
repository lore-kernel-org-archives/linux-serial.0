Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794697737;
	b=y6ScdENzU+x4bgymA4Q5/VNPrT0fG54ZAWx1/ViJDTZRu9PjfRAlslwS92a+fREJDOQa
	 c6qxYWTG3ACSTTGPW7W3nvtBuezI3484JjuP0Q/a0y2CGNmNT2Ivd13Rm3L9I1ju11jl2
	 agaJF/pm+OZmMhsljxUL84rTqIame5aU9uvNWKOiIGN/At+sqf7Eyb55WBvA3F9YTQqFA
	 M5cvZl9Ye7hYxT8V6nxgC8+oQ/nr2C0zbpctgZgntLn7oxPHiGaKbvudPWG/SPU/0MlbX
	 V2MiCi4rPQQl0p5CgAdu3tSN6jLz6cAK6Y2XIxOImtzR/c0wgxc1XCkr1YVcn82JaXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794697737;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uxveAn0EG2iJi9Y17MjWE+pFeZafxnDF9/Vb19n9Ewk=;
	b=JBOAj9P8yap7A/YWLzdhSfb7BFuAaAFmXspFhOA6NpFDCk4BTPxKegWD+uE4kPFfIllB
	 O0QQS3ShYS4814wK+1ROMUibPTVApJQ008xHDmAvWZA4okdpt/7AOxCVwYYUhoDpBPig7
	 AcFzfweUayLr9kdmEzkm4zCTKFpeHmCyfmq7/+gHqNtob/nrPfpx1Y0R3h++7Az2vX3nb
	 35cg8Coag6l8NjPT8KcHrym39/WdN2sWVBMwzA84RxN1cloTSPlTfNUDU94Bjxn3m95MU
	 cKNbPFZXZt16ACThdEbmzXrEWe0GnR28gZBwmPufhGlnuDowuOZ1AmyU1LSzKmEb5vQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mxtJ4nYc;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04AC60A6F7A
	for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 23:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F04AC60A6F7A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mxtJ4nYc
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4910b863b84so1830383f8f.0
        for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 15:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794697735; x=1795302535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uxveAn0EG2iJi9Y17MjWE+pFeZafxnDF9/Vb19n9Ewk=;
        b=mxtJ4nYcD3JlhG7YDutpAQpj7FaeOIgaBQzUDovzeWv4MAbcvmdvn2lQ+aKk7Po3G5
         /BxoS2VZ5fgpggK0Y7jhBNdDAe7Mp3WIhZJBn3jEM7F0CF32A3TZECkAbaqkNN0YQxCa
         y7iEpKP8aZfa4yI6ARG2t+cxi9s1NH9exiq//CyjY7wOzyRf858LQ+O053LkjfNDTJUD
         MRPpI1t/ncVOfmBFHi9jrOnogVHDbEktNrmpigNSQ6vTxNdleitT73gxskCzjzPwcKe5
         8D4EpfcJhzlJ9HdtVyXqWq0cggrGPV+0bR2Vmz0SCDBQKYOJSNMufDQi+HE2JvrZbSK+
         AFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794697735; x=1795302535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uxveAn0EG2iJi9Y17MjWE+pFeZafxnDF9/Vb19n9Ewk=;
        b=Gyocji8UCTBVvGvVFzRmEfR8U/FpohabkSQ4pPbiCcFbAYC03FUMcjWn+v0dLqXgbh
         SJmHUxIb9oir09cdm1Ly8TYir9/C660FYwZ2iCZd0x8lnoJBoTNHYPEkBFqupS68C6qL
         FKM3QVyB0+2Mq9wVDTsjRF5WxaBaiuORse6JOlYglZ311W49ivW+07UagAgzpGU/Euvn
         gDn9Mu5Tm/O3D3PEr8IOvJDNM8E0MpiHlDpdrujcRT/XhEc0EjMnFnsYn+xlneT1IAmP
         3j2PKeFU+WYxJdccAK6XditbWxLMEWW4DYSna8zUD0M06HgXg1vdST3aRiQKlR/wbcJ0
         EMIQ==
X-Forwarded-Encrypted: i=1; AL+hErED7/GUDqhP3mmn6ZSi0AIQuSI2dYWTOSlLMPlG0Ludhww/SzheSMrUbRFKC2Fx6VQIYVm+1hCN/WCDCyI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8JOVfZzyxeJnyY3y8C8UcHSpnN3kYDRfFGyf8hpVP5XrxF4mu+
	O2dLNrP4W95Uu8H6fEMjdHnQvovKRkf6C4KbtvrXerOaMaZhFbCt0Y3v
X-Gm-Gg: AYBFou31alaRSmfywL4mlC1OUNyxMrtjoZ4sWCWMBC2LKhdajIU7SJpR6c2cGUQaJwo
	MmSvZzPf+kstAnxjz6sNFnPCBMtKf81c3FDj893n8ZE2Pik5iv/ZoQkuvbYdxoeSErb/0s70CYP
	uuHHzaAgrmJmwBOdfztCVxqOL4e5r5bQhgrO8mcdtgKZzxcPIrTXzinwY/UoDOIF+d3LLcv+umi
	+VnbmqNzgh4AJ+wswyqaAsgSg1fDDuGwuCHlSTumRQwoYflghu5S8b+v5V+yjRm5Jzk/eQ7ZatF
	Ouv+QttvCyQSqCATBn/jxl111guu9fZeRg4CUcUjOmeNfOLk+jESrD/hD5Qlx9r6iDFhXkbXLhx
	1iQrfrf+GETcJxciS7QaqKb+MWX5PriCJrVC3BInRIM4KIdSRhL8Mo/eqcOwOZRtiVpgT+xNsHV
	0ZObuSsRa7B2qSu1SZPaGqM5YIW8HEgauzOe5eEISE0yVj/00sV43Aflu2Y5Gcug2cPHxw3PSX+
	DQmGyxPDSheXWr4ikcZztq7sNY9gllsYpamdHVnkmynMC6BL9jyLV57YY99s9mQ1OPoRpOM9pIB
	d/y9+r+nvqlkNr9kJxeWjE6K3MD1R1PNKqaOHLRgh4UW1v/l0g==
X-Received: by 2002:a5d:6f0e:0:b0:48e:7475:fe7b with SMTP id ffacd0b85a97d-49b01734a32mr21424865f8f.6.1794697735316;
        Sat, 14 Nov 2026 15:08:55 -0800 (PST)
Received: from m2.. ([37.142.149.161])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-49c5d03b10fsm14910018f8f.1.2026.11.14.15.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 15:08:54 -0800 (PST)
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
Subject: [PATCH v3 14/16] HID: ft260: i2c: fix i2c_reset sysfs store return value
Date: Sun, 15 Nov 2026 01:07:58 +0200
Message-ID: <20261114230800.1344401-15-michael.zaidman@gmail.com>
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

A sysfs store must return the number of bytes it consumed. kernfs
hands that value straight to write(2). i2c_reset_store() returns
whatever ft260_i2c_reset() returns, which is the length of the
feature report it sent, 2, not 0. The "return count" below it never
runs, so every write to i2c_reset returns 2 whatever its size.

A write of two bytes is right by coincidence, because the report is
two bytes long. A caller that leaves out the newline, as C and Python
code usually does, writes one byte and gets 2 back, which is more
than it asked for:

  echo -n 1 > i2c_reset   1 byte, write() returns 2, bash ignores it
  printf 1  > i2c_reset   1 byte, dash reports an I/O error
  echo 1    > i2c_reset   2 bytes, correct by coincidence

Return 0 from ft260_i2c_reset() on success. The value is discarded by
its other callers, ft260_hid_output_report_check_status(),
ft260_i2c_probe() and ft260_i2c_abort(), whose own four callers
discard it as well.

Fixes: 6a82582d9fa4 ("HID: ft260: add usb hid to i2c host bridge driver")
Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
 drivers/hid/hid-ft260.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 391128e4bb35..80b300893658 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -615,7 +615,7 @@ static int ft260_i2c_reset(struct hid_device *hdev)
 	}
 
 	ft260_dbg("done\n");
-	return ret;
+	return 0;
 }
 
 static int ft260_hid_output_report(struct hid_device *hdev, u8 *data,
-- 
2.43.0

