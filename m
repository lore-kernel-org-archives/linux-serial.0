Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794945915;
	b=N55P9YLE503WWx5jZVjR2izztGeKZWY0t3Lnokc7WMf1xP4iZlDnRh7371hUYe8pRcwy
	 J0ABsZtmV4hAIRlwfSh4KkitYZyQCM6oGxTkfPEcAb9Vy69SktIx1MZeaWxZUyApD3mkp
	 KOq8E19j0ggS+sef9xJKwbyVUbi7Jpu9KoSah+upIGjv2W/7bGjIfbfT5Q6rKtW7SDJX0
	 eJLOIUZ/1pazAeFd+Ree+vhOkoy7N8cgPg/Tb4Ala6OwuyTQxcfnu/sgE59WAWbVwNKwm
	 IUtX6qBXm7vhUEpnygGx/2zggIGrus1t9sh0QVpyTQkiRTdY2j9fttNfAiEGG3xjLVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794945915;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=I4V/mFDPpkUiPU517GUo/F8CChNGX/URZfOCzHfy5Ek=;
	b=RvmtiMFB2WItsGcO2tnTwbHakHUW0DwIxkFJFgOjJWq7gaUaDY2gY5U811WJPZXxVoBS
	 3t7jDF7oOmgTgYw5ms+w8n586vQA9mtiH25SHc5c3Bs/Z0ulcXvwsN7Bd3HB5xeNuygIr
	 zR60i0G15TM9Wp3qKfO34M5/EdL3A076uJmrgj8tXwvOQxrJHlYLb4AVWmiG7IOUuJjIv
	 G3gz7BMagb+nVYpuN2xl8wvb1sGEIuJN6uGExQUlK/iR/LYk19HGo38cHFc54xY4S8pQE
	 RAdlw7ic5VN6yBg6zXOZNeo+y/sSNk0gmRBCEJK88qoUN0HcTRH8pAwiu31u4le6kNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SMpoD2pQ;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9D460A5BE0
	for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 20:05:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF9D460A5BE0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SMpoD2pQ
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48b001cd92bso89436f8f.2
        for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 12:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794945913; x=1795550713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I4V/mFDPpkUiPU517GUo/F8CChNGX/URZfOCzHfy5Ek=;
        b=SMpoD2pQjaA/cYwragUAoL2cukgsQqAGoTUGPepWYe3flBwQMPJYr2+y+F+Ut7Kz+E
         OtvViQ4W7x5E7+e5G5fCm0nKIraG+qRrtUI6HMDdyQeh7FKYXzyp/7AaQw9uMl7kFF6S
         mqOpcHdDv35O2pRw8ttbgzFzyxpcUQGPxGB2Ge2naeMbBTSEJOxnvf8liWSxYvtEsIL1
         75McRy04KBF+kNYieEZr07EBSyz00zguoprTeNdA2cJn/deMAz6fQ2eS/bk5G91FkAe0
         hFeXUG9iDIzGHafEklmHwTxURZbJFyTqF5ghJztE9wemZNwf4wZeyNM272S2hPY6rvc+
         GZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794945913; x=1795550713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I4V/mFDPpkUiPU517GUo/F8CChNGX/URZfOCzHfy5Ek=;
        b=y8JWUj8V+rzU+sLJRbwWWrHBP+6WRrPXivErz6c4PWr+MIzQWmgS2uKQNM967F3bZM
         25209bhYFuOtecl24g3V197i4VyqHohv16y/4adb4+GDrF/DDUG6cXwZOKMO/283HqVE
         pr+8t0jc+GaCYu2n8wyA+BwptLEB1HSIw5rmB+cwcuRyAc/ueMEIMrsvP9HJvLyM37WB
         MompTf9iIaj9J4qRw946Ic+5BGgpZ97ZXU2G7bdyuvAZrJSst6SN1R1uE5v6YRykEdnx
         c5hstoOTgWasnOR7ufyjSB19YwFxpArUhE/sSKqt+kqMcHK8YWNuyMIHcUiKTgdKOgd6
         PUew==
X-Forwarded-Encrypted: i=1; AL+hErFOjlObCwGROXEHpIePlrKBqVBxoipDt9Ob2zCmC9mDuqeU6rAZEwMqq7c5mAFsDn3KhWw60hJhoVFeklI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/v0UQdsbpbRpexy3dWCkpv+SUhMq3UIl8egVaJugOpab+Aa+ri
	sXlj77g0piBg9c7LQ7Z1iqCmEF/4WnM67rK45BPzrhXwbJKci5PqSxjF
X-Gm-Gg: AZFdTZdAMM08mVviCsOZhQrm2fSrVbF7/qx7jH+aA2Qin++lpJfT/uggNnnjbFmqRWH
	ug9Yr19Lja+vIBWt79mg9aC8cbQ+k7OYkg3oOWt2CyuzP2qp8Jt7kKn7WPJZCHj2XE4SH+YaY7e
	RRwBRK/P5uHeTToO9I2RrKWANtnayW5RBe8fNbN96XHTyRXjh+/y6yPexKfHHzCIMLrTLQAYTBK
	DHLgLZfqAGCOYF8aX9sJW6kRkc7nnxtH9TT5DGGDBqJoOBQrOx06i4hqWvJO+RYQ46452J89JUs
	4Onms5aC5VcWBR33hPEwdsqUbw7okGXjCwuxXH14f63o/7L0dO/GrH4ZRxv7H18Um0qFOZdKxCC
	OZXgQhcczoD7a/Jm2wK24cInXCJxMKj2bJ2VEmgM6QwaSfg9lDOb6ncSwu8Ef/Dz+0eT+5Y9bhH
	/QkVX4QbEmksE1G5q2I5NRiucLu7KMTTXmzgaWWjklNWS72NaubRUda7WWgkb3WFbhH4LhD0Zjj
	yczpf3S3rzrttYEYInpNM4IUx18lT5kxJvg//uHOueY+g6CZeb4SsMjDaQXoS05t4B5ZISS3I/L
	EJ6vS6KmmLO04edoBmxSoSUmcc8I
X-Received: by 2002:a05:6000:184b:b0:48e:3df8:74cb with SMTP id ffacd0b85a97d-4a6334a76d3mr1304109f8f.6.1794945912888;
        Tue, 17 Nov 2026 12:05:12 -0800 (PST)
Received: from m2.. ([37.142.154.208])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4a64b60940csm625528f8f.0.2026.11.17.12.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 12:05:12 -0800 (PST)
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
Subject: [PATCH v4 05/16] HID: ft260: fix sysfs store failure notice for big numbers
Date: Tue, 17 Nov 2026 22:04:11 +0200
Message-ID: <20261117200423.19561-6-michael.zaidman@gmail.com>
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
index 1b31b484a11b..bdd55b35df9a 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -1486,56 +1486,60 @@ static void ft260_attr_dummy_func(struct hid_device *hdev, u8 req, u16 value)
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

