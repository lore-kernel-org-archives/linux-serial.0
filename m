Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7863254A2
	for <linux-serial@vger.kernel.org>; Mon, 18 May 2026 10:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779099311; cv=none; b=gVrcOaDeHAEcEyxgqguVW2Xi/W/fEr/dVRhLZm2dV9NOwQ2tkk26JPsDtktZIIe0XMu4VQZY4jOi9APrSU9dk7jUCPgXKeMYbbx4YAjjhoewVbf7EFSYexgxpRqxT8sjvbIFlHz/10j+HtZvph3n9D6c1/ANP0FjqYiHHPzKv6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779099311; c=relaxed/simple;
	bh=gWVfDidBZPIWcU7dRUXxYpUwrEW3lYdjaP8RDg7ddWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VkPhuZ1sTXld23zdDFTtrFelDMRIaTAjNZfyrUCts4x9APdkKpgBbY2ZI19kLCopFQHExpeqYvyEF4l04pp5zcPPvtorgfgQ5CvSKmDktHvQMoESfp+gh+YbDreNdSAF+qB+tTX2caPw112Gb0WWZcOuSGZs1iRC2tGByhERQHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=dqeBG6zB; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="dqeBG6zB"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45ae6a0e523so959109f8f.1
        for <linux-serial@vger.kernel.org>; Mon, 18 May 2026 03:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1779099307; x=1779704107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yef2OxHPO6NCColQiJSX2213UsQXUe9NzdyRR7J7TuQ=;
        b=dqeBG6zBlebhZNXRBM4h8Z6dFeDqk8N6a/h/n2LqLcLZUitmpqanqA+1XAvzkYHFSm
         v5Q9NtrTnckTrLPG219Z3J9HyzbEB3gFzldUqkchROYtKlrISKqsG/vyIJ7ieqrbD8c/
         zzQ7G8TYgxYYocEFm6PgL3drn52yDJF5QMW0WBBaBvOc9M+FGY3qw2R8IJ5l8/5ivFDz
         y4qXartjCEUvE0gkarpt8VeGIjyj59YY68BzhnEq6/hOWWSmI8LM6lE4eexQXN9zVTHy
         Mo8kiuY/cI1vMr5i+jLH78b+sEI51N6x+DLd1czDISctFGUDCpmQQw6Es68AAw5kpws4
         88zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779099307; x=1779704107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yef2OxHPO6NCColQiJSX2213UsQXUe9NzdyRR7J7TuQ=;
        b=Utm3IfgUAUaKYipHj/5ypt/Kfv1OOk2EwS4KNacY6DMCtGPzg76S8qoxYOzmdBOgbE
         Yy+QEcATbhrECGSTPJWSTce6kPBifPa6bV7KYtwttFKmj+EgVRi/j/ngk3alRs/QAszm
         BCYYswXC9iOgZOdgZFgeaveBOghLgHbEVppGU/DwQqOkN2603j/PaTM96Kd0empeRqk7
         W4cY9BI3nEIh2CL9Al9dyRa0kedHJGmf1BTn3ZbkHs7LTr1bYVoqaSYF53YriKxka5G1
         408HVhgTmH+64L7KeC/jLy3WNsG8qHeUSmiopOCWzIs59f/ZZX3FEDJq80mejvBuK+bU
         LlKA==
X-Forwarded-Encrypted: i=1; AFNElJ94hpYoaxD/ZwVErmoV2FpKxHTY/1YAaWQ9h/UouCPB7BdbjPFCP9c0KoOT2d/1uCMHtcb8kDUmRScfwl0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi7yXMmteQ9+mFCjJ4vxgUKSPMyWCQJbiuI4CrkHjpbZSh0rCA
	nUrKlrfZoiXH6+ZJXHkjdKR2YzyE8tTbb0ybBzsXKiMYJgfYtTR09MIOKwXBG+kE918=
X-Gm-Gg: Acq92OFVtp5japgyuGPKQEzcgAswSY1KUWakFtOAVXDZz6PTfI8tmIkyhep1P1RrYUc
	3/2vT3PZJg7V3z+oqa33oif7ntrbRUkF2nujQziLwrFLhyEONgXjOS4fq0IYF8og/svuRUm1HOT
	SK3TFL/ATWEtRxWnSEccNsZ1A9AFE1gnQMhNKYoBLMou77O/yDVG3oeGrle1kmHldv6jm9nhB7a
	ECRRUaZlPdSiFXkbrG7OLlc9PrV0x4u0rf9GyZxNkXzqwOrUrwCkRmyO2aWQkyfos39EH19fFsh
	+O3cJvPhm9omaxv3e8WFh+GpVvX/93/nPbtCru0ZGUj/auVLlStrwu0I4qXHJZSJMrfzSglj1KU
	W8yqC0+MdKUxsNt5pKEPZmPC97/B4SpTa+wVw/JFGc8CIyOz0cTB5l2AnOjMSfL5Nq/dTfy/Ru1
	jZ7XcxOyiKJGHWlzxwYagf5YnPVXZSVpe+iQ6+htNDNb1ZU45c8wpcHMboTx3eZOZDujQp44lMP
	kWaigv1/rG2ROH7KhP3mMcn4w==
X-Received: by 2002:a5d:52cb:0:b0:45e:655d:6f7 with SMTP id ffacd0b85a97d-45e655d0715mr12424737f8f.24.1779099307115;
        Mon, 18 May 2026 03:15:07 -0700 (PDT)
Received: from localhost (p200300f65f47db049367b55fc4056f2b.dip0.t-ipconnect.de. [2003:f6:5f47:db04:9367:b55f:c405:6f2b])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-45d9e768c4fsm36171677f8f.8.2026.05.18.03.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 03:15:06 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Tapio Reijonen <tapio.reijonen@vaisala.com>,
	Dan Carpenter <error27@gmail.com>,
	Xichao Zhao <zhao.xichao@vivo.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] drm: Use named initializers for arrays of i2c_device_data
Date: Mon, 18 May 2026 12:14:56 +0200
Message-ID: <20260518101456.632410-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5912; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=gWVfDidBZPIWcU7dRUXxYpUwrEW3lYdjaP8RDg7ddWk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqCuag1ll+dFBRP6YGuv0PULwXrN7t/tr7kjdCk 9FQMlq7EvaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCagrmoAAKCRCPgPtYfRL+ TvGFCACOtQ1XBECOWkFXKtQ8nGd0VvMSH0Tn390ZoXc4NflYGpVfsWgbjc+ffBNEUE1N0MGMDkl bCOYiiZ8pliyh6raMxUWjDvU3AsgYGMSqDFE1rXoHd3Vft9B+x5JXWRXSFfCgcg8DBCL1NtowBj B1UkOE2scC1NW0ejBzIJW64iT13zCMGb0rUXnYCAC+lAzOELqSAVOvkmbhsyZ0llEzvFlxJoI+6 7xGElcktfXn6Jc/Rh+9+pW3+et4jPDFnThHY52H+23iduulDh2VTAu/fhcp0PybNXMl0kpBQZ9T 30r4s0spXr1uYIvvd9w0/IG/LqUgxIcLtPtNJpukRlKWLjTj
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

While being less compact, using named initializers allows to more easily
see which members of the structs are assigned which value without having
to lookup the declaration of the struct. And it's also more robust
against changes to the struct definition.

The mentioned robustness is relevant for a planned change to struct
i2c_device_id that replaces .driver_data by an anonymous union.

While touching all these arrays, unify usage of whitespace in the list
terminator.

This patch doesn't modify the compiled arrays, only their representation
in source form benefits. The former was confirmed with x86 and arm64
builds.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

the mentioned change to i2c_device_id is the following:

	diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
	index 23ff24080dfd..aebd3a5e90af 100644
	--- a/include/linux/mod_devicetable.h
	+++ b/include/linux/mod_devicetable.h
	@@ -477,7 +477,11 @@ struct rpmsg_device_id {

	 struct i2c_device_id {
		char name[I2C_NAME_SIZE];
	-	kernel_ulong_t driver_data;	/* Data private to the driver */
	+	union {
	+		/* Data private to the driver */
	+		kernel_ulong_t driver_data;
	+		const void *driver_data_ptr;
	+	};
	 };

	 /* pci_epf */

and this requires that .driver_data is assigned via a named initializer
for static data. This requirement isn't a bad one because named
initializers are also much better readable than list initializers.

The union added to struct i2c_device_id enables further cleanups like:

	diff --git a/drivers/regulator/ad5398.c b/drivers/regulator/ad5398.c
	index 0123ca8157a8..dfb0b07500a7 100644
	--- a/drivers/regulator/ad5398.c
	+++ b/drivers/regulator/ad5398.c
	@@ -207,8 +207,8 @@ struct ad5398_current_data_format {
	 static const struct ad5398_current_data_format df_10_4_120 = {10, 4, 0, 120000};

	 static const struct i2c_device_id ad5398_id[] = {
	-	{ .name = "ad5398", .driver_data = (kernel_ulong_t)&df_10_4_120 },
	-	{ .name = "ad5821", .driver_data = (kernel_ulong_t)&df_10_4_120 },
	+	{ .name = "ad5398", .driver_data_ptr = &df_10_4_120 },
	+	{ .name = "ad5821", .driver_data_ptr = &df_10_4_120 },
	 	{ }
	 };
	 MODULE_DEVICE_TABLE(i2c, ad5398_id);
	@@ -219,8 +219,7 @@ static int ad5398_probe(struct i2c_client *client)
	 	struct regulator_init_data *init_data = dev_get_platdata(&client->dev);
	 	struct regulator_config config = { };
	 	struct ad5398_chip_info *chip;
	-	const struct ad5398_current_data_format *df =
	-	                (struct ad5398_current_data_format *)id->driver_data;
	+	const struct ad5398_current_data_format *df = id->driver_data;

	 	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
	 	if (!chip)

that are an improvement for readability (again!) and it keeps some
properties of the pointers (here: being const) without having to pay
attention for that. (I didn't find a serial driver that benefits, so
this is "only" a regulator driver example.)

My additional motivation for this effort is CHERI[1]. This is a hardware
extension that uses 128 bit pointers but unsigned long is still 64 bit.
So with CHERI you cannot store pointers in unsigned long variables.

Best regards
Uwe

[1] https://cheri-alliance.org/discover-cheri/
    https://lwn.net/Articles/1037974/

 drivers/tty/serial/max310x.c       |  8 ++++----
 drivers/tty/serial/sc16is7xx_i2c.c | 14 +++++++-------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index ac7d3f197c3a..742b8c23bacf 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1671,10 +1671,10 @@ static void max310x_i2c_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id max310x_i2c_id_table[] = {
-	{ "max3107",	(kernel_ulong_t)&max3107_devtype, },
-	{ "max3108",	(kernel_ulong_t)&max3108_devtype, },
-	{ "max3109",	(kernel_ulong_t)&max3109_devtype, },
-	{ "max14830",	(kernel_ulong_t)&max14830_devtype, },
+	{ .name = "max3107", .driver_data = (kernel_ulong_t)&max3107_devtype },
+	{ .name = "max3108", .driver_data = (kernel_ulong_t)&max3108_devtype },
+	{ .name = "max3109", .driver_data = (kernel_ulong_t)&max3109_devtype },
+	{ .name = "max14830", .driver_data = (kernel_ulong_t)&max14830_devtype },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, max310x_i2c_id_table);
diff --git a/drivers/tty/serial/sc16is7xx_i2c.c b/drivers/tty/serial/sc16is7xx_i2c.c
index 699376c3b3a5..6c2a697556a6 100644
--- a/drivers/tty/serial/sc16is7xx_i2c.c
+++ b/drivers/tty/serial/sc16is7xx_i2c.c
@@ -39,13 +39,13 @@ static void sc16is7xx_i2c_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id sc16is7xx_i2c_id_table[] = {
-	{ "sc16is74x",	(kernel_ulong_t)&sc16is74x_devtype, },
-	{ "sc16is740",	(kernel_ulong_t)&sc16is74x_devtype, },
-	{ "sc16is741",	(kernel_ulong_t)&sc16is74x_devtype, },
-	{ "sc16is750",	(kernel_ulong_t)&sc16is750_devtype, },
-	{ "sc16is752",	(kernel_ulong_t)&sc16is752_devtype, },
-	{ "sc16is760",	(kernel_ulong_t)&sc16is760_devtype, },
-	{ "sc16is762",	(kernel_ulong_t)&sc16is762_devtype, },
+	{ .name = "sc16is74x", .driver_data = (kernel_ulong_t)&sc16is74x_devtype },
+	{ .name = "sc16is740", .driver_data = (kernel_ulong_t)&sc16is74x_devtype },
+	{ .name = "sc16is741", .driver_data = (kernel_ulong_t)&sc16is74x_devtype },
+	{ .name = "sc16is750", .driver_data = (kernel_ulong_t)&sc16is750_devtype },
+	{ .name = "sc16is752", .driver_data = (kernel_ulong_t)&sc16is752_devtype },
+	{ .name = "sc16is760", .driver_data = (kernel_ulong_t)&sc16is760_devtype },
+	{ .name = "sc16is762", .driver_data = (kernel_ulong_t)&sc16is762_devtype },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, sc16is7xx_i2c_id_table);

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.47.3

