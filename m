Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A962819FA9B;
	Tue, 16 Jul 2024 18:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721152829; cv=none; b=qZjLsoRMwjyV96dUaDuK0gDIQGmGFrizPr+P/EtgxiP9nJgxTPZt/XqOPM2eKLtrccIgcPR/3zGCpHUFAHxOzYoi+m7tR9sVo69o9bofjgfcz5A0pVnpTvJcJtnqdiUbtlediq5A1OSge4RiWA/ypCjGGPMqkkf/0baUGz89jis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721152829; c=relaxed/simple;
	bh=qmuj9g6bkirzr1j++wLweK/8Ad1fLNfo+jpMNs18pYs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C+MO4FVhpQxAzvZm9lXuMeUSvSF3myf2amYMKw0vBEAyKWDgx2HtpHX+gX+ESbYcowymzSWOXZTDmxVladCHXr4bg1azkMfjaFujwL/JmJ6A0VDTx8rxokAKg4GNDu6kMiY+d56k3Bqwbwy5hqefkoZDOiHVrDnomqna37cAJHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K95DTl3J; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K95DTl3J"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4266eda81c5so46500025e9.0;
        Tue, 16 Jul 2024 11:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721152826; x=1721757626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ePgpYFkBe3qAoTduEyFM1RrNaLGJSVdjeXc5RO7/VUQ=;
        b=K95DTl3JM59syr3cAX3RbRShTTrnwE9z7+Mm47dptMLBB/NjJNM26+1rkTOMUUWtrC
         8Wj+9wbnPoTYPMZ7CyeGpcTOP1sCcgSfiGynhE/A9XvzjfOaMGHQhbwGAhoO/rwMMhsS
         2YRa43alDArCZyP7cFJoqhbTniLF8PB/AuzE7VzQ4iXKjlp5+gWhzOcVV3vr7HWOBT92
         ZyS0J44UaROQ8e2cv7sucMtoywXw12jXuif8YsSIktQZu/KIdrVXEwfExej4JV/yIbxo
         V5RtJXUue66DqUWB6kYshavh+4D0wFmPRIONZn8nwyhKBMfUh5ClL32juXtOv8mWUAm3
         wvDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721152826; x=1721757626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ePgpYFkBe3qAoTduEyFM1RrNaLGJSVdjeXc5RO7/VUQ=;
        b=E/MdeAEoDIMNdDWBtNK5aDYPBQ/TUftv0G3G0Aj66GdjrwPSf6Jyi4K6RQxJrIJg8/
         NlrPX+yCPqFDBu7lKkT8HjS75oQujqjzc/+ypqkPNd0V4HmJoZGoNxc55T/5XCeWMFWA
         WIA791k1mjTjRKKrYSQddu+likg4VAbnRw2gNpFnBGsr3EHHhX2qgPe8ne20ARvA64IU
         DRjrge4jlBw5PVYmq9B4oa+bEIoebmO/gN1Ngrc27sf+GPSH/fhDDvoWceBo/0mi44Fm
         c5G6gUMcyc6tS0P6M9ufc1mdbn6svSgJufLapdyO6iLKpyqBit+3TbX/3olfmqplLhdH
         16cw==
X-Forwarded-Encrypted: i=1; AJvYcCW20rVhKyAgzkI5rc6CaEU1r3Tzi5vmvsjULLCX5xjS36Ehcy51tW06FoXd4j/5raCfrahy1mxITEC1i7A56EO+abZdO0b5bAIZV5o/LmuPLuJDI/KgMzUKFe8xUnKUr/pKd0tpsYmexhgA
X-Gm-Message-State: AOJu0Yxcp0ZBEemXy/Q5APCe899mN/FmCOp+Rth/J6wRP817GdAgkcni
	G3EfwDTP8q4NY7XKkVkoOqrV4D9Q8uZi3xNKJeubJfCc5VdETx5PNIh9MQ==
X-Google-Smtp-Source: AGHT+IFEbnR254xpr2eCNt05Z8i8hkwq+V1zJCxhVNl41Xk9b4hDR6NjRNJb345aFhEo2aZlS7vM6A==
X-Received: by 2002:a05:600c:19d1:b0:426:5b44:2be7 with SMTP id 5b1f17b1804b1-427ba66a5e9mr23251815e9.10.1721152825523;
        Tue, 16 Jul 2024 11:00:25 -0700 (PDT)
Received: from localhost ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f27983esm170194845e9.27.2024.07.16.11.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:00:25 -0700 (PDT)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] serial: st-asc: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
Date: Tue, 16 Jul 2024 20:00:10 +0200
Message-ID: <20240716180010.126987-1-rgallaispou@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Letting the compiler remove these functions when the kernel is built
without CONFIG_PM_SLEEP support is simpler and less error prone than the
use of #ifdef based kernel configuration guards.

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
 drivers/tty/serial/st-asc.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index f91753a40a69..8aea59f8ca13 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -808,7 +808,6 @@ static void asc_serial_remove(struct platform_device *pdev)
 	uart_remove_one_port(&asc_uart_driver, port);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int asc_serial_suspend(struct device *dev)
 {
 	struct uart_port *port = dev_get_drvdata(dev);
@@ -823,8 +822,6 @@ static int asc_serial_resume(struct device *dev)
 	return uart_resume_port(&asc_uart_driver, port);
 }
 
-#endif /* CONFIG_PM_SLEEP */
-
 /*----------------------------------------------------------------------*/
 
 #ifdef CONFIG_SERIAL_ST_ASC_CONSOLE
@@ -932,16 +929,15 @@ static struct uart_driver asc_uart_driver = {
 	.cons		= ASC_SERIAL_CONSOLE,
 };
 
-static const struct dev_pm_ops asc_serial_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(asc_serial_suspend, asc_serial_resume)
-};
+static DEFINE_SIMPLE_DEV_PM_OPS(asc_serial_pm_ops, asc_serial_suspend,
+						   asc_serial_resume);
 
 static struct platform_driver asc_serial_driver = {
 	.probe		= asc_serial_probe,
 	.remove_new	= asc_serial_remove,
 	.driver	= {
 		.name	= DRIVER_NAME,
-		.pm	= &asc_serial_pm_ops,
+		.pm	= pm_sleep_ptr(&asc_serial_pm_ops),
 		.of_match_table = of_match_ptr(asc_match),
 	},
 };
-- 
2.45.2

