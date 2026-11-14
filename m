Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794697718;
	b=1/8sAIg6UQ12+6Ql6B7pwdfDZlnaFFsYcTyH8B09muUPYtPYp2kd0XHSbjBVlol0IgNs
	 IJICYCEJ2bm9Ciz8yWQmwpJu3wCOR2UvcFmx/aEBn8w/J7r5IdWAmOkb23e1AkdwH3JUJ
	 xri4m0TfKTDHCtexWUFIX065VCqj6HrDmEtFmisZ+efSy9PJC5N4V54Bq1ye1vv2roA75
	 IFbgkxGUXq6JLwK7o6KkUx+nE1DAJzVYpKPNMY2agA65ax/+zod4RJWBJGkFpvkJMTYeM
	 TQ7ChMkm575N11LIVPERVZkS7zoLMXR3Jxh6FYMrV19cuaUmFZhj+GFPZqoonmkXtmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794697718;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OSqdRG+Xct5NqgpqBzobcU3MbGZQEh89MxMNsDRUZg8=;
	b=yxNdDO5cgGikcSJVED0WGYopLZ/mtQm/RKJhQq9Y3p+jvb6XyHYexummzB6esYUffdbY
	 yI7bIa+JMiYTlSMyd41knD0YsM59aV/TyruqLh2VNFvUKxDxGsNwhZbuX9KI6qjS9F17I
	 iOWGrztnHFq5X9B1D5XeNZ9H0p2MWSdzHOw7U2q2PX6j4A2zzLGqDGk+VrvylDVB2l5Dk
	 eMoIEJXCmdiQhnytqrTwQW3hbKdILSQ/w1QJZQrHvL6y0Jq8irVEfXI4xhcNs/yGgoXX5
	 ULvvSHmXWuzdOhhW/LWc79hFnga2aj2VWpLWpOijPHFVVh9YYh8EZ+YN9Nz8n+l6Puw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KvU31w+9;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111CC60A2625
	for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 23:08:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 111CC60A2625
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KvU31w+9
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-490d59c3edaso1252185f8f.1
        for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 15:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794697716; x=1795302516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OSqdRG+Xct5NqgpqBzobcU3MbGZQEh89MxMNsDRUZg8=;
        b=KvU31w+94nb1cErfYmbg1u4f99C7TlkBLz0aJN4/pQnN4ydmCM0hbfUvGIEsSnv97C
         mavbbWgp5H4XpxoEk2ZPPS1a/Oqsga2vScdlpGbPrM7l0WE7KLQAA+IMKEFgw1qq06hR
         tsSqZCPo6czlwGudGlHQUV09pfSVujYATrFEugdgAViqQ8gJYbDHM6CxvoXVLV0qGLiy
         CXSRa0d5mn0s8pHZhLYNFAt/chWeTbWWhc1UNVOn7QW1z8RiXt78FZ7Bw2yCYmhUjm+I
         ayBJ4hnVGJbcYFLVJvrD61xaTA599XAA195iASuvR/KlYCbXmMBGR8ejUaZtZF+fhMK6
         MKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794697716; x=1795302516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OSqdRG+Xct5NqgpqBzobcU3MbGZQEh89MxMNsDRUZg8=;
        b=muWN3yubWAO8yWYLGyTJlkHC33p7Y5MS/eYwKw8FboG80TdQFpiYBpX22bQfQvMr3U
         tI93py2nN9WyT5LK0VkAVmTk2s3gZJegIXSN7TVozouvaDtZl5G0tpTElYfbPyrJ3vcc
         6vSKta2FkIubsVeMBIWevENbGr1sck3PVP1/R3KJxbKZbc18LZC3VIRn9nmnXfAFDIZX
         iAXPszeDo8LH81qbEXfH42BpGDGkvQVhJszTpee/NUbHjIhxLG6mf66cbW5c666Lnu3/
         cC5aZx9diyW8BvFdpxwWbBFJaNJqe2oST3jo6hEQFFzu413TqhwIRdOR9/Yr45cvaL26
         p8hA==
X-Forwarded-Encrypted: i=1; AL+hErGaOFXlQ1pn7iOVZX6b/44Pfw0VbeGJIFomDrgIfbSpOUaA4SqAhfL2sHu7q3g22rabz5gctvGd1Znx5is=@vger.kernel.org
X-Gm-Message-State: APuU4Z/spL/FlE58t1Kjvntagr5tqRkJZDNSgDf925AYS9RatbrgRkMK
	JrVlf9Zy4lG48eOn5p4QHnpAnuzhdh04TeHwuhVSj4rUZZjXazjUdoDCyBItnhg0GTI=
X-Gm-Gg: AYBFou2mZcVoG2sFVUdvOXd75WjfDP0INWihUMDPvF6YRxphXiu370XUzOoy6VQEqY9
	vJ+f7q16MATBDD+At2puPBePzgZRiuujF49hUB8b3q35aG2JvqLycLO42GWLpZre4qcXjoyhiIJ
	yMOCZLISJXQyVTygVUc47xIqrAEoSN+CKn5VaSrDO3Iz8z6frhtdOkkBnelS54WslcP0EUlbpo/
	sPlcUOI6aUon9f6Sk6tOGYkYan3R7fe895tg+dmReeKRZX2y1mQALU8JNukDjlOs024cC/Y83At
	Vq9EDsx591e2r63E4S4LtwSmliJlhDrwolsUX+jSwR72vR+oLB/ciH97D1ZA4Dg4qjYKvbIeslg
	VCw/a9nrQEssZsYeiSSv6qYM4Kf3l4p8JLiMeCY+2LtxzwxOQDVcOHRJ1//Y4XK+GXmesMgo7bu
	3TU2e74VsxeAT5ravTnGfNi31RlMlzUCpJ0lLjBAiq2qffX6lk3yYvOuKeS/mcFpdQ4GWXkz8WC
	Kh3rZpuTmjYjPJIvbGzhc+xtLI4QhKIn1gpiWAr5tEgIJWwowbS6zsJebCZo+Eg/Oi3vCX/KMtb
	KQeH50+pZbCbKQSaXYiLR9c/JymL
X-Received: by 2002:a5d:5f05:0:b0:48e:76ab:78f3 with SMTP id ffacd0b85a97d-49c7026072fmr13647580f8f.15.1794697716378;
        Sat, 14 Nov 2026 15:08:36 -0800 (PST)
Received: from m2.. ([37.142.149.161])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-49c5d03b10fsm14910018f8f.1.2026.11.14.15.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 15:08:35 -0800 (PST)
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
Subject: [PATCH v3 05/16] HID: ft260: fix sysfs store failure notice for big numbers
Date: Sun, 15 Nov 2026 01:07:49 +0200
Message-ID: <20261114230800.1344401-6-michael.zaidman@gmail.com>
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

FT260_ATTR_STORE returned the feature-report transfer length from
ft260_hid_feature_report_set() instead of the sysfs write size. For
values like 1000, userspace writes more bytes than the HID report
length, so the VFS retries the remainder and reports "Invalid argument"
even though the attribute was applied correctly:

  $ echo 1000 > .../clock
  bash: line 1: echo: write error: Invalid argument
  $ cat .../clock
  1000

Return count when the feature report succeeds, so the full write is
consumed, and the error when it fails.

Parse a 16-bit attribute, such as clock, into a u16 and convert it with
cpu_to_le16(), because the report field is little endian. Before, the
value was parsed straight into the __le16 field, which is wrong on a
big-endian CPU.

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

---
v2:
Fixes for the issues reported by Sashiko:
- A failed feature report is not reported as success.
- A 16-bit attribute is converted with cpu_to_le16(), so it is correct
  on a big-endian CPU.

v3:
Subject reworded after the original out-of-tree commit, "Get rid of
sysfs store big numbers failure notice". The v2 subject read as if the
patch hid big values. No i2c: prefix, because FT260_ATTR_STORE serves
all store attributes, not only the I2C ones.
---
 drivers/hid/hid-ft260.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 50389b3e79d8..13dbff661fab 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -1484,56 +1484,60 @@ static void ft260_attr_dummy_func(struct hid_device *hdev, u8 req, u16 value)
 	}
 
 #define FT260_SSTAT_ATTR_SHOW(name)					       \
 		FT260_ATTR_SHOW(name, ft260_get_system_status_report,	       \
 				FT260_SYSTEM_SETTINGS, u8, ft260_byte_show)
 
 #define FT260_I2CST_ATTR_SHOW(name)					       \
 		FT260_ATTR_SHOW(name, ft260_get_i2c_status_report,	       \
 				FT260_I2C_STATUS, __le16, ft260_word_show)
 
-#define FT260_ATTR_STORE(name, reptype, id, req, type, ctype, strtou, func)    \
+#define FT260_STORE_NATIVE(v) (v)
+
+#define FT260_ATTR_STORE(name, reptype, id, req, type, strtou, func, conv)     \
 	static ssize_t name##_store(struct device *kdev,		       \
 				    struct device_attribute *attr,	       \
 				    const char *buf, size_t count)	       \
 	{								       \
 		struct reptype rep;					       \
 		struct hid_device *hdev = to_hid_device(kdev);		       \
 		struct ft260_device *dev = hid_get_drvdata(hdev);	       \
 		type name;						       \
 		int ret;						       \
 									       \
-		if (!strtou(buf, 10, (ctype *)&name)) {			       \
-			rep.name = name;				       \
+		if (!strtou(buf, 10, &name)) {				       \
+			rep.name = conv(name);				       \
 			rep.report = id;				       \
 			rep.request = req;				       \
 			mutex_lock(&dev->lock);				       \
 			ret = ft260_hid_feature_report_set(hdev, (u8 *)&rep,   \
 							   sizeof(rep));       \
 			if (ret < 0)					       \
 				hid_err(hdev, "%s: failed!\n", __func__);      \
-			else						       \
+			else {						       \
 				func(hdev, req, name);			       \
+				ret = count;				       \
+			}						       \
 			mutex_unlock(&dev->lock);			       \
 		} else {						       \
 			ret = -EINVAL;					       \
 		}							       \
 		return ret;						       \
 	}
 
 #define FT260_BYTE_ATTR_STORE(name, reptype, req, func)			       \
 		FT260_ATTR_STORE(name, reptype, FT260_SYSTEM_SETTINGS, req,    \
-				 u8, u8, kstrtou8, func)
+				 u8, kstrtou8, func, FT260_STORE_NATIVE)
 
 #define FT260_WORD_ATTR_STORE(name, reptype, req, func)			       \
 		FT260_ATTR_STORE(name, reptype, FT260_SYSTEM_SETTINGS, req,    \
-				 __le16, u16, kstrtou16, func)
+				 u16, kstrtou16, func, cpu_to_le16)
 
 FT260_SSTAT_ATTR_SHOW(chip_mode);
 static DEVICE_ATTR_RO(chip_mode);
 
 FT260_SSTAT_ATTR_SHOW(pwren_status);
 static DEVICE_ATTR_RO(pwren_status);
 
 FT260_SSTAT_ATTR_SHOW(suspend_status);
 static DEVICE_ATTR_RO(suspend_status);
 
-- 
2.43.0

