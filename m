Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E68230BE9
	for <linux-serial@vger.kernel.org>; Sun, 13 Sep 2026 03:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789270922; cv=none; b=iFLWHOL/ZjA4rHolA6slX4qY7boIVzH01ORf2EZTYRFN0P0XAXQFctg616/8xlV9LLyKfqLPq+WYYGKFIIQO2rnOwaMzxml0K3jU0LbgLUuKBgMT4PVYdrW8VKFjIDjX+N1d2nZNTAe48JF8OgAvTOUza1PHA8edmCEiWqMrMjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789270922; c=relaxed/simple;
	bh=MQi0CJ/fz7tg5s+eLvlNcw0LS2EBxH9xVWjWGdQ246o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JY2pkg7/XBYfSZfaRXiJp8TQgmXMF8Q+yJj5UtM5GltTEXKSsVIMdlB0gDPIgCxVNN1KRlidYCBvoQ+Lu8vJhCN8uNy4a97JP2wyAdHYHhqgG8rUlLcZCqxlsqk+RrgMLPT9ITb/L4VWFfjUkYYlR++WB2mGBOgtU/nbBwQDLtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kDF799cq; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDF799cq"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93910ad20d4so122520285a.3
        for <linux-serial@vger.kernel.org>; Sat, 12 Sep 2026 20:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789270918; x=1789875718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uJp5ud/myTFefNhCI2ZzWiRr2kbld/3n70B98OUzWtQ=;
        b=kDF799cqAa+MUyHN0lyY+sVQ6Bd/JIgTBMz0jogn9Ri+HGcyixWki6ER/ebPBggcV6
         jKWEtI3GRn2ng1byPwX9IhHpLv8CdzUsskW06GNZDVTu7NujZsvyfJBI8sXy4z8GfSsa
         zfhYAFgeewf14W0dSe876eKi4/5FIyNKOuPqa6/fGJ4AXTPKejwKe689DZ7YzRuJhpgF
         kgKrI1A9QW38gZSga+79dLl2jMLPsbSfS1EbjsjIIPmHO5EoTgo4s06gWCuILvJoullR
         WsdJFCvyJVM3Qxqs80+7gWdxqSw2O1N7kfEj4JkiyqSdND2JSsjwJTjprpuB24G5l8zA
         njOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789270918; x=1789875718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uJp5ud/myTFefNhCI2ZzWiRr2kbld/3n70B98OUzWtQ=;
        b=bJeeAewZOy27xL76aTDVhhcFhfqa5+F0AEw+q9P0iwyIEiUqVSb4CymZnPZQAe57xV
         7+a5gEqWWmhkajX/Km9deDoqfHLUHJo2wBO74pA5MbipzzAhyU1h4kLIDw7Og4v43hvT
         B0dUEXydHseyv9V5DTBFbOLSiEPb8mks0Ksj8nJ0LKxiyFe7wYmvjA3KGgJ/QLsgz06e
         b9yL4ftIF1rfTXh2vrgOzW+7Ea/BiiQVbw/HWbTcdzBg+3ifu7pqpWtbSDS819FfVtXz
         ryPhIh8jqGuoaJjJxCaWS0KWmanuYOvXluQFUVutheMc6Cgt2osYiUaKq+1Hv8PUgQY6
         lxcg==
X-Forwarded-Encrypted: i=1; AKwUvBy3XjRLe5Kwxfet00yaL0zzjiQaK3w4ECs40YdAK/PbF4HYFH/QM8NnXPnyLfarZsug8JeeHy2iba5xsio=@vger.kernel.org
X-Gm-Message-State: AFuF++lzXQs480nrZFCrivMg5nKq5ANsvTyb29iRX26pLM64w/wafQqn
	lKBufVlOlkWJ29HhN+PQIwb2OyzOEZg8KE3U8Tgm8Ky2sl/wiEpX+nY=
X-Gm-Gg: AYBFou1IDrQaoI3fstOnf61eI3Kt689coPls1ufhKrOuPhYBfiDoD88P0d22JL6P/Y3
	PwN8Ha2eESUoH8sfHG+uFahwLazByXK6IYsVJS2IOwaD3kP+fD+ya/lMWP0CGATM/JArtwqhw5L
	vmAjP9VPrPQ9RxCQA6vjg/fMA/ooQ/oZaySDDTPlkxeQr/55gah7ql/9gt1/V98dNd6SdpvaFpB
	ify2B0MKrEBFGdEgQgHTpCoOPW+zq93g9EevFD9xjC45Q/4fozVlKBeZmCgNSbUlEYrgwFhigyD
	JBZItY8Waq63JTfl6JgUwkjpTGh44wcZwQmyBOJlQ7mKsCjKzrJhJMfgUYDJFomIgC06mOMHJ+L
	miM1+iMvRz85326GK/G1ihlSdvVcb4j3R5kuu+1c5U9cy5IiILYo6YpweZowxjsKFu3jgt9ECYy
	R9uy5FtiP5K3TuJk1CdrJEieJ2YbTMhaLz6tOvF0lxVG+MFUazqPKvlDVMsKeYFDRuIvgS61+9i
	kxU8FLJXpCUsGY7Cx3KU5JMm9/dopzEVKdNskimam5kUgeOMaZNnFf6NmBO7K4Nebbzt7E1irk6
	6bzWyJ0XPIk+cs7ru+/OmbMLfiBG
X-Received: by 2002:a05:620a:d8d:b0:939:597:e7af with SMTP id af79cd13be357-93a038fa617mr775671985a.35.1789270918119;
        Sat, 12 Sep 2026 20:41:58 -0700 (PDT)
Received: from localhost.localdomain ([104.39.73.78])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e80d453esm652916385a.38.2026.09.12.20.41.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 12 Sep 2026 20:41:57 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Dmitry Rokosov <ddrokosov@sberdevices.ru>,
	linux-serial@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] tty: serial: meson: fix UART driver lifetime
Date: Sat, 12 Sep 2026 23:41:48 -0400
Message-ID: <20260913034148.15068-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Moving Amlogic UART registration into probe left the first driver
registration behind if uart_add_one_port() failed. Adding the separate
ttyS driver later also exposed a global last-port test: removing the last
port of one driver kept it registered whenever the other had a port.

Track whether probe registered the driver and undo it when port addition
fails. On remove, retain the current driver only if a remaining port maps
to that driver. Serialize the shared lifecycle decisions against parallel
probe and remove operations.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: bcb5645f99ef ("tty: serial: meson: redesign the module to platform_driver")
Fixes: e71aab9d6132 ("tty: serial: meson: apply ttyS devname instead of ttyAML for new SoCs")
Cc: stable@vger.kernel.org
Assisted-by: OpenAI:GPT-5.6
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/tty/serial/meson_uart.c | 52 +++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index a6cb2a535..4bd9d9826 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -12,6 +12,7 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -80,6 +81,7 @@ static struct uart_driver meson_uart_driver_ttyAML;
 static struct uart_driver meson_uart_driver_ttyS;
 
 static struct uart_port *meson_ports[AML_UART_PORT_NUM];
+static DEFINE_MUTEX(meson_uart_mutex);
 
 struct meson_uart_data {
 	struct uart_driver *uart_driver;
@@ -692,6 +694,16 @@ static struct uart_driver *meson_uart_current(const struct meson_uart_data *pd)
 		pd->uart_driver : &meson_uart_driver_ttyAML;
 }
 
+static bool meson_uart_has_ports(struct uart_driver *uart_driver)
+{
+	for (int id = 0; id < AML_UART_PORT_NUM; id++)
+		if (meson_ports[id] &&
+		    meson_uart_current(meson_ports[id]->private_data) == uart_driver)
+			return true;
+
+	return false;
+}
+
 static int meson_uart_probe(struct platform_device *pdev)
 {
 	const struct meson_uart_data *priv_data;
@@ -702,6 +714,7 @@ static int meson_uart_probe(struct platform_device *pdev)
 	int ret = 0;
 	int irq;
 	bool has_rtscts;
+	bool registered = false;
 
 	if (pdev->dev.of_node)
 		pdev->id = of_alias_get_id(pdev->dev.of_node, "serial");
@@ -731,11 +744,6 @@ static int meson_uart_probe(struct platform_device *pdev)
 	of_property_read_u32(pdev->dev.of_node, "fifo-size", &fifosize);
 	has_rtscts = of_property_read_bool(pdev->dev.of_node, "uart-has-rtscts");
 
-	if (meson_ports[pdev->id]) {
-		return dev_err_probe(&pdev->dev, -EBUSY,
-				     "port %d already allocated\n", pdev->id);
-	}
-
 	port = devm_kzalloc(&pdev->dev, sizeof(struct uart_port), GFP_KERNEL);
 	if (!port)
 		return -ENOMEM;
@@ -748,11 +756,22 @@ static int meson_uart_probe(struct platform_device *pdev)
 
 	uart_driver = meson_uart_current(priv_data);
 
+	mutex_lock(&meson_uart_mutex);
+
+	if (meson_ports[pdev->id]) {
+		ret = dev_err_probe(&pdev->dev, -EBUSY,
+				    "port %d already allocated\n", pdev->id);
+		goto out_unlock;
+	}
+
 	if (!uart_driver->state) {
 		ret = uart_register_driver(uart_driver);
-		if (ret)
-			return dev_err_probe(&pdev->dev, ret,
-					     "can't register uart driver\n");
+		if (ret) {
+			ret = dev_err_probe(&pdev->dev, ret,
+					    "can't register uart driver\n");
+			goto out_unlock;
+		}
+		registered = true;
 	}
 
 	port->iotype = UPIO_MEM;
@@ -781,9 +800,14 @@ static int meson_uart_probe(struct platform_device *pdev)
 	}
 
 	ret = uart_add_one_port(uart_driver, port);
-	if (ret)
+	if (ret) {
 		meson_ports[pdev->id] = NULL;
+		if (registered)
+			uart_unregister_driver(uart_driver);
+	}
 
+out_unlock:
+	mutex_unlock(&meson_uart_mutex);
 	return ret;
 }
 
@@ -794,15 +818,19 @@ static void meson_uart_remove(struct platform_device *pdev)
 
 	port = platform_get_drvdata(pdev);
 	uart_driver = meson_uart_current(port->private_data);
+
+	mutex_lock(&meson_uart_mutex);
 	uart_remove_one_port(uart_driver, port);
 	meson_ports[pdev->id] = NULL;
 
-	for (int id = 0; id < AML_UART_PORT_NUM; id++)
-		if (meson_ports[id])
-			return;
+	if (meson_uart_has_ports(uart_driver))
+		goto out_unlock;
 
 	/* No more available uart ports, unregister uart driver */
 	uart_unregister_driver(uart_driver);
+
+out_unlock:
+	mutex_unlock(&meson_uart_mutex);
 }
 
 static struct meson_uart_data meson_g12a_uart_data = {
-- 
2.47.1

