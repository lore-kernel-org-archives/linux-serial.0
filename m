Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB089478875
	for <linux-serial@vger.kernel.org>; Wed, 13 May 2026 15:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778684725; cv=none; b=SD1eQ49oydm5rpzxV/nkDZb5XFvNsOsmfjj0f2GtXmBnv+8CINQsRiVPD/Y/hoVOolePWmog0FbgpC+c6qJtnLn2b/g1aKytpezcOPIKOvppvSBl53PXOIiE4owPt7zPrOyt/h6pjIjHhXl6JFTojzi1HERBRxsTQrq4BdytSUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778684725; c=relaxed/simple;
	bh=TY5LAW5T0Q46o3F/BrwLU+uTPiuSwGLPqe9gXyroDN8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TwrNde3z7Lk4BvyUBH/jTMqn2Oo4sDgAURtLeDpFKQ9poJOvG+vu44Q/31gRcOJH6W/yCj7MNi7EnaYMyKE4z8EFP/eR4P0JEQX/zxogXIxzDLavJq2QNCBN9AUiSyP80okzPY60I7AInPRXl58PHEQB8hZNz7u3wcIgxgBGRlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hyNEaex2; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyNEaex2"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48e7b0208ebso1659795e9.3
        for <linux-serial@vger.kernel.org>; Wed, 13 May 2026 08:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778684722; x=1779289522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DNKpWb2v7e1+HtXK95De7TC/an+HY3mrnyponhhlU8M=;
        b=hyNEaex2dpKip9hm5qrYoFLz+OAbnokyVqm0849XseAUZb04Xj6a+z/Dh1oDxi4KCx
         rj5iyUcMUwl5yggGGDS/sRFbo+HmIC/4mxLYN61WD0XPi6E32baY5zazD4eCVGRCbLL1
         sfqKJcd892yDgRlDqSxpd8WhHzx7EWz2D3oLuad4crzqW2KUfJ9abdZHtV4HgjErRxNK
         cYhBMVPJ616KY8kHCV8TXo4n7LJM+kPFIwPax4Y1G3cCgaw3fAaiCaehRHU1w7uAKUWz
         sqjgtF/6TvD61lVpymcHHTj2dh8p70Z90T4L+rbdmfL71IOdFRxtRcHTmfPaukL2bHr3
         tkzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778684722; x=1779289522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNKpWb2v7e1+HtXK95De7TC/an+HY3mrnyponhhlU8M=;
        b=pdYGExzeC2I0IesrHN31BbNjkxWo74O6E1Q8WqC73EYKKZbiqvgvM1hY1JB0W8VSxG
         l3c4r8Dxqy0meOadyNp69SVdhBZoJJZ2tVz6U0dxcBateYCs1vIN09kX3oy3tpBT3VtR
         RZplhMQrJXgzKdq9yAC8ij4o6Nzn8cNtaqre+HmZXsOKLIpEu0uArdPex/dcFIq4us7c
         n6qh+E376tnxdBveiPv0QQ+Q4FqWaJ983C7rpYO27LCZiyA/nTfN/0TxPyyDV8WqKJZH
         eS8WAqfOvde5unRhpONKd7/CSvAhzavyOWajnXSF/nmPQFuWWXsbblwpIYUVrrATQv+9
         bX8g==
X-Forwarded-Encrypted: i=1; AFNElJ8ZxOoHOaBw9e/eBlAX5ICSgXT5RFfspqrvBoetu01rwn/Z9qxOM1OX4DNpYGrNfqcBj2rJXM7tyEqrEj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YydfIIEPDfbxR++vk+ACh4oKLFJeJKMHZXuVew6sX6/ccnbgYH3
	VhQh0nWhCUeH2/IKuKAtqxSPWQDW4gujrbny2Lf+p2MvVRcp8vQS426z
X-Gm-Gg: Acq92OGYm28JgnX7vuhIuKCKr6EzIueOlbeAfgrg3oLIEiL30Lz0Rn5P61LqZErTQZv
	2g+XxoBYwBaIIpb0qymfpi93xsKzm6CTI6Ir/JDk1QaNPDavPDFdwlYZg/LzYghZUdQczOrUmx3
	IPrPUFnj+UvlfjkZeFGzVRagjLpTRoZSu3wMf0244/CKKR32xOjtGu5YFJl/LuKwAjoEL730U6M
	X+jDjZO0OzRq+ypmxqJBtDrv8l0Z8wTK996kTQoAmF9CFIxQsy9HV+opIajhMfNS+WwMjhpWFog
	H5SB01pX6vzBf5GjB/TZu2wQ0ayJsOgHxCarl5hTpfVO38e08ntzr0ydygytH6/XHwx5IE21Dt/
	w/w+h+hMoTI3ku4myRI/KTuSNjIbAjSpJ1D16fUhuCnd5foMkD4o+chMWcyv9rtPQ1chXMCXvay
	XhU6syxr7XBuGrDWzc1dRrhsXOJQK6HwW01f+Iu0hjItVX
X-Received: by 2002:a05:600c:3042:b0:48f:d410:605e with SMTP id 5b1f17b1804b1-48fd4106119mr6816645e9.7.1778684721908;
        Wed, 13 May 2026 08:05:21 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd62792f6sm91365e9.14.2026.05.13.08.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 08:05:21 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: ilpo.jarvinen@linux.intel.com
Cc: andriy.shevchenko@linux.intel.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH] serial: 8250-dw: unregister 8250 port if clk_notifier_register() fails
Date: Wed, 13 May 2026 20:05:03 +0500
Message-Id: <20260513150503.11037-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dw8250_probe() registers the 8250 port via serial8250_register_8250_port()
and then, if the device has a clock, registers a clock notifier:

	data->data.line = serial8250_register_8250_port(up);
	if (data->data.line < 0)
		return data->data.line;
	...
	if (data->clk) {
		err = clk_notifier_register(data->clk, &data->clk_notifier);
		if (err)
			return dev_err_probe(dev, err,
					     "Failed to set the clock notifier\n");
		...
	}

If clk_notifier_register() fails, probe returns the error but leaves
the 8250 port registered. The matching serial8250_unregister_port()
lives in dw8250_remove(), which is not called when probe fails, so
the port slot in the serial8250 array stays occupied until the
device is rebound or the system is rebooted. The devm-allocated
driver data is freed while the port still references it (via the
saved private_data and serial_in/serial_out callbacks), so any
access to that port slot before a rebind would be a use-after-free.

Unregister the port on the clk_notifier_register() error path.

Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
 drivers/tty/serial/8250/8250_dw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 94beadb40..7dbd79a91 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -850,8 +850,10 @@ static int dw8250_probe(struct platform_device *pdev)
 	 */
 	if (data->clk) {
 		err = clk_notifier_register(data->clk, &data->clk_notifier);
-		if (err)
+		if (err) {
+			serial8250_unregister_port(data->data.line);
 			return dev_err_probe(dev, err, "Failed to set the clock notifier\n");
+		}
 		queue_work(system_dfl_wq, &data->clk_work);
 	}
 
-- 
2.43.0

