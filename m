Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793399848;
	b=AnJ0AdaF3peIvE3d3QnO4YT/CsiN/65qt3ybWZuvyNqrwTjuS0t7Bk5TseGj2PTC9/At
	 sltSNZakQNd0OEU4WaQqBFtQ2CtJwvAjFCg6Hxff7Ca8A+evXpcy+TdFCQowGNOuOWnfr
	 ba+xWFlhazuHXPO+btT3BtF1aSbNeXKZXnn90WwJlEJQoxemBALUFR+W0M/924GsOX/76
	 Gtwj6F1McY9t95HIM2eFzKs6kq9flxnkMZEyzKYLpjfaAkkvTP7Br/SB95SoOTfQqcfNd
	 9mDg/C3YJaN2FnuSesCSOOE6vutRCcu0v160r8U0EE2Qt0FuQDBFZ/xmmITjd6Afdog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793399848;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=smxd6atDvW+XcNIEKcY809Fe9dqPoq4HuHxsaG6+qd0=;
	b=dbvoYeQpSMrtCEaKwIfwHDj/pdtVSwKyTzm2N1h/71RapxGu0x9kpNjfVI8o0Tp7OasP
	 XEnuF0KCuivMZSTZHkZ1hB0okfRJ6hebGtDxS3bcSG0LWXojNnp400aYZF+nGaRN/Qs7x
	 rr7Y0O/eR9KMJLD0iwcQgqDEbxcXmTiBqRKM1dYNiRyoorLyMBchZSAkNm8GhHrNK4adE
	 vJcpuOnbpPDhxuBxuO+q4bC1WzUwGdouCMnV8/u5cZdmG8QKQfIOMm9QsQ2GT3EqfGdeI
	 pqD2T4r2a58xOgZ/2PWJCb4OuHbqiOZFIjrtMRq92CXCQYr7mwbUpcTrFj0w3BRZj+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M2I9t4hp;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A0360A3806
	for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 22:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59A0360A3806
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M2I9t4hp
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4ac95761c85so7166425e9.2
        for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 15:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793399847; x=1794004647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=smxd6atDvW+XcNIEKcY809Fe9dqPoq4HuHxsaG6+qd0=;
        b=M2I9t4hplWMbO8tPuee3YyWYgEo3wyjcr0/4BG4YKzu3NCWdVKYAMmKMUvw6UbDvx8
         BcX4QsuLLNI3QShg+6TAx6QfEBf68vsNfxrxlN8naod6hf6myRsr0HkCry0hYrdWCcus
         L64wCfLUnofWYSxXo2tF9h41gd2jGhtnHCcBjBz2pmOic55Yq+F+E3fJFGdlUWdZDvrt
         NdJEUlNXC79r72UKiAgOBXdnjy7b/kw1mYOjqhjZ7J7DbLKb3GW+cm14TLJfWP5er6Km
         7tPZrlHXLlrek2xUExAq6V6GQVUhH0faZ0GJK/JU8xJwzv0Fg0PINfnJnb6sHm94jy1q
         eZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793399847; x=1794004647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=smxd6atDvW+XcNIEKcY809Fe9dqPoq4HuHxsaG6+qd0=;
        b=QfM/fKlYta1nOrzIKIdwxmYiOZHzvIPWOEWh9LUs6WfhGXF6y3gH/tBa2Nq49Q7O/z
         X1MITuxQP5qs4PvvQVQ4Q5xa3MPF/h3bT4BZWClgfnwZdOxxlJuyRtHlJ2NVQp/GbK87
         zvZ69AgG4uetSKkIUGnsEQ4TRhHS/86PQvLaj9p53vWjI5A4VkV9Ik7PebcgcKbM68lz
         36fgbfXHWC7HdxtR/hqn8itQLQpf1NPKjc0pGpiKKPa2vOxARJefAMWYMySSQ3Am6kgQ
         VnPTu2UhcVDYvsOutYBjqPGGMA0CzmBvY6CQUdAUrNBY2Ipvt84QCHDdt1zgJusrbJSU
         7aIQ==
X-Forwarded-Encrypted: i=1; AKwUvBxAS/L0vXCbyPtPZAXpI4m0bxMsoszDeM44Cx9TfvCcnop3FM317FDcTsPOWagvB4N1frcXG2uyEutnPk0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKypU6xYUIdKswdg9L+bUYAN7qxmAtvNreyADq2N7A0JI+Az4Jw
	MvrS23gTq+YIsn2ACud1Tg/Pn6vAoWQCmhiW5BkS2jfkchWnlpYMs3mur+TNYdwmQWs=
X-Gm-Gg: AYBFou21qMJY3J8SmqoBBnSBDvFXfuDbS7ZAx6BocT3NfgANEyLYDtg+9bK5qUkCILR
	MRuKsGmAzujzNNsYlHhMI+LaUpDEvIr3jJ7pfec62oxCZdQSAe4fh8qJnjcXRz58nUQd2moAnzS
	ZqkONl21rS2onWwWCYTa1yktDy6tM2TuAm4nG0qH8jhUUL3fob43s6vBgmOm22lnASrb8GbkaJG
	BweAew49mhssy49haaF0vJ5yt5ZYNpieghR7xjXuuot7hDrt79SDmeIuETIVLLYaxwM2SaF018O
	QNM2yJodNszk6S6MRExXlfk3PjSEnAcSDEPkG9XzGEhFPVReCWrcUbXLgQ/DsAmJ3XTAC2PtPIl
	C6Yc5r/VpliI9f5IcvOUHKFkD0zEUbEwf8BuhiKmS6wg3BJ4NYmP0SpcgcVGqQUP3GUa4jQdBd6
	PYy/fK3W2qlAXRG/jyqZ+1jUC0dC34kvF2G2noBLsCO50v2mt5GgE4jF+Pmy3bcLTb+TdhTYKhh
	KVUth8vTj/+q8MphGkZAUBiDw+2JNZpxxHdvgNWI2kilsFH2w13r3SmjJyFbu5BjVGoHRt2tn5t
	5kbBNZxYRpJJT34F4eGXcZ72lHbX/sC1Zq+HBvxwppBGw/fMjNU=
X-Received: by 2002:a05:600c:8b0a:b0:4a2:191f:7cbd with SMTP id 5b1f17b1804b1-4ac17191009mr83697245e9.11.1793399846753;
        Fri, 30 Oct 2026 15:37:26 -0700 (PDT)
Received: from m2.. ([37.142.145.227])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48e71b959c1sm5457300f8f.45.2026.10.30.15.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 15:37:26 -0700 (PDT)
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
Subject: [PATCH v2 14/15] HID: ft260: i2c: fix i2c_reset sysfs store return value
Date: Sat, 31 Oct 2026 00:36:36 +0200
Message-ID: <20261030223637.86907-15-michael.zaidman@gmail.com>
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
index f7d01d9e07f7..cd1117c170e1 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -551,7 +551,7 @@ static int ft260_i2c_reset(struct hid_device *hdev)
 	}
 
 	ft260_dbg("done\n");
-	return ret;
+	return 0;
 }
 
 static int ft260_hid_output_report(struct hid_device *hdev, u8 *data,
-- 
2.43.0

