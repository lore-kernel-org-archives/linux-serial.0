Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA44214228
	for <linux-serial@vger.kernel.org>; Fri, 11 Apr 2025 15:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744386270; cv=none; b=F49Mt9Ft0OgocJAtfU26/5CqVREvht44vG63d39xGs7p1Q4Ble54Bx2KYFa26C2/lthGvNhjIoKhBFftZWH0h201Bx6RjhYPKccYhzTgeZMGxjiMlJw0SxhihQjExqTixTa1m2GeI4PQGJPN370INh/Yn+oczyE94tx2/Bp83a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744386270; c=relaxed/simple;
	bh=YTCOV5qFH6rsTE5f1V8QRlk7DYXjTy4SSao1Noq3mc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PewcPR6Gqzholf3kyaNnSM4v3QofT46e3QFt3BMeK9PY0OBJumm8XR9MlvfFJj/vZiBZeCinUC9YMcYZDelfvKX/YHBNrvXgamZBhmUagQBt0OzEO9I5cJuXRWeKd1Zln3eMjjYl/KgEh32WJmnTvJrX55nAz5EikhZQ1V3PN+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=WLJFZxg1; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="WLJFZxg1"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-8616987c261so67986339f.3
        for <linux-serial@vger.kernel.org>; Fri, 11 Apr 2025 08:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1744386268; x=1744991068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIR6+1UCymjCvWnHm+vRVxN4kx6Kunaak/TDrneY48s=;
        b=WLJFZxg1QCCV0kk3mFo2+q7h+KNKBsioJ2xaTCj2vdLR0j3oZKGIlc2MUudSE58LM7
         c1IYKHrD4iwv5/OT9YZzKrwnTZ4W1FgjhXaHcshWlUAzg08NHNE/EoKYW2woOxyIF3D1
         CiEV4Bc8OIfla7LUFeHOkd+g83pDscilKcVoKR0j+4PJ90Ko4fx85QxzxA48mSN3GYlc
         JDYbeJ2G0a1bEzlwPwrI3WRVcet6mkDykoBEMkJgszxem8MQp3uHE61SOT2oS7vPVmQb
         9EkMSnANAp7FHvXbm6tDbxMiEZF7DusrAktoeFvjDtyxN0dGwNpnfGIbvUL88C0EHCB5
         F4kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744386268; x=1744991068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pIR6+1UCymjCvWnHm+vRVxN4kx6Kunaak/TDrneY48s=;
        b=EJ9xZrgLOFQ1v2knWoHtJ5+7LgTNjQZYFM+fwlwadD4uUcb5GuvZaV9O3KTegmVATD
         BBTA/AuPPQSnuLWroV6nhu0BNJwxUnNEhTyBFBQX3geu+CTtgyMlLVbWvjZnJNW3j4Ou
         aCtBcezPOAJ4hsrl80FKpeExklcp4JLd9Zsoh89MdzjLYtBfvWwxLboZeOqyKc53i9XR
         NR26TGyZw8fRWIb3+9VCanZs1v7AT8e6sLij7N/Act/o8zd45VXQjRiLAfNMRKPprfKz
         vNmlKBU8a7SO3MC6HqBDy3xn+Wv2JPjXIBVYxva9jI2tDWdnsjKZrylRXPHSaO08oRoH
         rb6w==
X-Forwarded-Encrypted: i=1; AJvYcCUjO1Kb5tVM8tPAdzOx2IpE+jP4MJGSjS7tCj7MEL+1++qTM7oBiB7jNvNWAMDHsrSBpNOmDneFgGZYyaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYtRpGPungE7PBSq+h9hWcGidUSUj/1IRFbc72IZ81Wx5atnrt
	Sm5utrrHnQ7WYt59EltcOucKUezClOkc2Zkj1wT7XYWTTRJvJIavWbulBt3ovdI=
X-Gm-Gg: ASbGncteXU+IZp+y5LPAaMUXYHv6ZfvtjdtYC+9MHd239TPygS/YADPLqQ8/Oy7Vfod
	QdksPaKFtQtTNu0p8EOgXmkbbm1+HNY30DAk60aXav0fgU+ynZ3szXAhEqFCV1x27EUGNEywYBE
	vNp3B8bYUqAGp5jqVMtmuSCaDKKAI44cMS5YKVZAQfesVijt+mlmD4J03bVkkv6xzaMEau+kpAh
	75LORnNqvi5IZpVuCrEBas8PQ3yyuAsarNbp1ppRxmfz009w012blpxS94XeCJXhU/XeSC4RTmM
	JUwylDONxsM2EL2sq9iJWAlzAqspI47JFcvdQjBQBFOurZ11fLo863TKKtq3voxNqWk/1rImMzX
	x2Qy2+1v3o/Tabw==
X-Google-Smtp-Source: AGHT+IGFDCID2V9OQ58DdGxUCrdRPix2Sm9SOyZ970XE5klNUQUYc7yCAtoOB8Vh9getD8RZI/2TFA==
X-Received: by 2002:a05:6e02:3601:b0:3d4:3d8c:d5b4 with SMTP id e9e14a558f8ab-3d7ec207fdbmr28814495ab.11.1744386268085;
        Fri, 11 Apr 2025 08:44:28 -0700 (PDT)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f505cf812dsm1276326173.18.2025.04.11.08.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 08:44:27 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlan@gentoo.org,
	benjamin.larsson@genexis.eu,
	bastien.curutchet@bootlin.com,
	andriy.shevchenko@linux.intel.com,
	u.kleine-koenig@baylibre.com,
	lkundrak@v3.sk,
	devicetree@vger.kernel.org,
	linux-serial@vger.kernel.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] serial: 8250_of: manage bus clock in suspend/resume
Date: Fri, 11 Apr 2025 10:44:18 -0500
Message-ID: <20250411154419.1379529-4-elder@riscstar.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250411154419.1379529-1-elder@riscstar.com>
References: <20250411154419.1379529-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Save the bus clock pointer in the of_serial_info structure, and use
that to disable the bus clock on suspend and re-enable it on resume.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
v3: New patch, managing the bus clock during suspend and resume

 drivers/tty/serial/8250/8250_of.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index a90a5462aa72a..8f2529f699e0a 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -24,6 +24,7 @@
 
 struct of_serial_info {
 	struct clk *clk;
+	struct clk *bus_clk;
 	struct reset_control *rst;
 	int type;
 	int line;
@@ -123,16 +124,15 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 
 	/* Get clk rate through clk driver if present */
 	if (!port->uartclk) {
-		struct clk *bus_clk;
-
-		bus_clk = devm_clk_get_optional_enabled(dev, "bus");
-		if (IS_ERR(bus_clk)) {
-			ret = dev_err_probe(dev, PTR_ERR(bus_clk), "failed to get bus clock\n");
+		info->bus_clk = devm_clk_get_optional_enabled(dev, "bus");
+		if (IS_ERR(info->bus_clk)) {
+			ret = dev_err_probe(dev, PTR_ERR(info->bus_clk),
+					    "failed to get bus clock\n");
 			goto err_pmruntime;
 		}
 
 		/* If the bus clock is required, core clock must be named */
-		info->clk = devm_clk_get_enabled(dev, bus_clk ? "core" : NULL);
+		info->clk = devm_clk_get_enabled(dev, info->bus_clk ? "core" : NULL);
 		if (IS_ERR(info->clk)) {
 			ret = dev_err_probe(dev, PTR_ERR(info->clk), "failed to get clock\n");
 			goto err_pmruntime;
@@ -299,6 +299,7 @@ static int of_serial_suspend(struct device *dev)
 	if (!uart_console(port) || console_suspend_enabled) {
 		pm_runtime_put_sync(dev);
 		clk_disable_unprepare(info->clk);
+		clk_disable_unprepare(info->bus_clk);
 	}
 	return 0;
 }
@@ -311,6 +312,7 @@ static int of_serial_resume(struct device *dev)
 
 	if (!uart_console(port) || console_suspend_enabled) {
 		pm_runtime_get_sync(dev);
+		clk_prepare_enable(info->bus_clk);
 		clk_prepare_enable(info->clk);
 	}
 
-- 
2.45.2

