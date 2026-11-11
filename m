Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794424774;
	b=W+k5AqQTcpmY4pE7HmVINyCgCjrhtb6NiBxaBLSi/h7YqM6oJiIj6tkGv7ODT3nj7LgD
	 Qno330C/OL6a/QEcn6kNL5BHiBB8M7KIlV7usHg+EnNbL0A2ZfJ/B48csT0oRDX5dQkzl
	 b/B1q4sTgSh3BvY87DUJiSJVD1UjcTiClmJJzBosexmTi1PD1+LFQsQzCZPMjjLhJayiq
	 od3AAZJcF4TeDR/+KVkX6dQang1y4vOXyUd4CcPWBM+ezohsOFUTC5KhrbtdXI4KgppY8
	 QB06k9e2lke8wlZaogKD2Z1Sf2Zv9qlN4fkmljZHy5mbXwZajz3c9jlpuItJJJqb1VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794424774;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=8CLRxjGrgnc3g9yFPsKCLb5zi7Ab6DJWbbm7vTXq7rU=;
	b=3aKeHZPC1XqQq9wUQ67T6Rl8gqVlhBCKLRCB4Al33nSkTiyXxkGrGyM/BbKiQx5XUuzl
	 alT9CH0AL9nHZLajW6Mcu2OEmxrmxKRXkjZ4stSPuoYpvkJ201NrhRSPuL1gpQkRk+vw8
	 +oqpDiip6vipaS1ctc9BMCdLmaxDSEhnprSfARSn0uDZvgW7eMOGOFeXGoRvPtslPx9HK
	 fCfgNccJ+LUvbn/92w1YIwxmJMPrNaMUeM+uFq7A9n2aJCStfcYnGYj/4Pj17XEYUo+Wf
	 HvRKveRBlPFOCjQVaW7ej5yzm4ZOSg/BiZJ/uv5L1+H2iBjMTP0oPNpCA8YAuYnXvpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wZKN2tQO;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77914606A881
	for <linux-serial@vger.kernel.org>; Wed, 11 Nov 2026 19:19:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77914606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wZKN2tQO
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4ba013938d7so22261735e9.2
        for <linux-serial@vger.kernel.org>; Wed, 11 Nov 2026 11:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794424773; x=1795029573; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8CLRxjGrgnc3g9yFPsKCLb5zi7Ab6DJWbbm7vTXq7rU=;
        b=wZKN2tQOCkD9ywJFG6rGISczED63TO/YVKwzUVOLVmvMuyhJkgTxAF+GDqyf8Vj/i0
         NmC8/t7UJ5koXLA+LjQNn2zQx0V00uxkLo0u7Qx9Y0DVxmDzbQlTnh/s3+Lq7UofuI+G
         UEJejmcURh/wkZSU2MWnWReY65ajUpftO9gxt+AWssFt+eJ3DJOLaSRplsrY/jvz3jbi
         zWXatmXfy413N/IiErQ4t6AFS/i8bpCli4sbUnixLGEAXKF7aoUDaLbp0PiateU8G50d
         RMFThTL1Foe8d08v3yqPViK8OgByC+EMSWJXagGv72VT7hU5JBhRjACCfXZDoSjaUN+h
         zRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794424773; x=1795029573;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8CLRxjGrgnc3g9yFPsKCLb5zi7Ab6DJWbbm7vTXq7rU=;
        b=kPor+7ZG1V0SU0U8fLvGR6nzlGFGCN6s0vKo8XnU5B8wpN6ESlOie3XzE+ZNWR4tqq
         w9UTp2Uds9v2MjjUKBNHuD1zAHl5H8FY0Lti97dOUsV1znhisIxi2D1cD+jEfkZmChd2
         xk8FmiLWVlUrkg/c2T8We23Z9hUirVtfa2g/9ZPWxni1VNBNJJTAg0RV6rG24x6AWo4q
         5sXrmhTGVDsEIqaMX7ifnhk3NWZ1rLtEmeXED4p+O61OJYdCWQhQ2cbwQCiA3V5wnk7Y
         ydfFK+Qju+ooNNosstp+aeF9HyS9ipT9mpMNmryffFt/aH0X9Ww6cXKC24xjydzIqrLn
         96zA==
X-Forwarded-Encrypted: i=1; AL+hErFaL6kzFUraZyM6KAG2VpVO3TJEQKePZxegwvQ3tlQvY/Ewr0w9C/XGtn8AyZZKfRlzxzSiZ13shT1nso0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+v+QBY+qV6FxQrYZPb+zquTB36Mj+f80Umk5tYBuqCzjrb6GWJ
	tL7DaUEnwvlVjik2HgieLSJNeQt1c3J0TyQFAnHPHd0z/VPO6d5a3ob0jrFPWAHKGvyPPA==
X-Gm-Gg: AYBFou3Qsef4a/INkqVGU3HsgKIFnYQaRqN1LkQ4EcTEn75C7O+l+dxRx2ja6Pfx/Hm
	ZW1g4gmLneFhmmF79/vi+iXY4gKvsUTWzRVsX4cbDIehPJa4kVtgK0jf0EeW71Qi7z+s5WKtqv4
	+f3EaIqPkbhYuvJmJglJrsem9/cjgJ5YCzP0lauklRNBtoMVqX6JM5qwwZAMBkklyTu3HfquD6u
	HLkUF1O2O67QmaqRwZQdzj+nN9gKM2xq68xNRphtRW5Hcigwx3CX57WvvmNxXRFY/11MeB7eC0a
	YO3nY9PnZirAF6qnUPlqoEwljyURsBamUwlOtinNBt795ZoIKtgQI03aCpsamnCfhCE056tney8
	Qu4n3D0DgPPkOibMGAz4e8DGUr7Dt4BuosP99e4FyQ0FKoO+KCqyTRwlDddxeYYsnOHAx6fMZbB
	jlPqXNEk2TxOqOtTHht9MHESqxGlUL2zeSOh1jLaPSD0ua0AcjYgLZ/ARlEI1RoEk+cPAEoP87b
	s5zabR7r5h6JeVP1Vo79T3p+viqYQINOYfb1EF5BytjZXLKas+1XMRE5yAt4M+JhtOVujxMF6zM
	pzit3BSluBpzLKvQX2E9Y6hK2WHXBWQWNMxNp7u+a2O7yyUUQcL2Hgj5oz4zq5ZCTVBkhgVrwfW
	nemhPJkW1
X-Received: by 2002:a05:600c:3f0a:b0:49c:d019:70c5 with SMTP id 5b1f17b1804b1-4ba091a5148mr63037045e9.0.1794424772838;
        Wed, 11 Nov 2026 11:19:32 -0800 (PST)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae. [86.98.194.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e267dcdsm9345305e9.11.2026.11.11.11.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 11:19:32 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Date: Wed, 11 Nov 2026 23:19:16 +0400
Subject: [PATCH 1/4] serial: vt8500: Find console ports in the serial core
 state
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-vt8500-serial-cleanup-v1-1-b33594a25f87@gmail.com>
References: <20261111-vt8500-serial-cleanup-v1-0-b33594a25f87@gmail.com>
In-Reply-To: <20261111-vt8500-serial-cleanup-v1-0-b33594a25f87@gmail.com>
To: Alexey Charkov <alchark@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Tony Prisk <linux@prisktech.co.nz>, 
 Alan Cox <alan@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, 
 Wentao Liang <vulab@iscas.ac.cn>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3082; i=alchark@gmail.com;
 h=from:subject:message-id; bh=p/31Oy3JuvkdbBOoFFziUsr3TcuAESl+1LC0x6wy1PA=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWR92b+/eAJzGzMbv4m/V+obwQmrEr9/SZu88cLqA/fPf
 dAqqzk9q2MiC4MYF4OlmCLL3G9LbKca8c3a5eHxFWYOKxPIEGmRBgYgYGHgy03MKzXSMdIz1TbU
 MzTSMdYxYuDiFICpdhZh+CtZE6Fknnt3ucVx9cWJgpt0ArYEB3G0BkqHRPB++qJaPIHhr8Bn199
 h3+tb8ye6vRPyab/pdz0jvTy0rpfxzrbFM6qVuAA=
X-Developer-Key: i=alchark@gmail.com; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Look up the console's port in vt8500_uart_driver.state[], which the
serial core fills before it registers the console, and drop the private
vt8500_uart_ports[] array that only mirrors it and gets in the way.

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 drivers/tty/serial/vt8500_serial.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index a7f167a73416..6c53e108756a 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -444,7 +444,6 @@ static int vt8500_verify_port(struct uart_port *port,
 	return 0;
 }
 
-static struct vt8500_port *vt8500_uart_ports[VT8500_MAX_PORTS];
 static struct uart_driver vt8500_uart_driver;
 
 #ifdef CONFIG_SERIAL_VT8500_CONSOLE
@@ -472,28 +471,27 @@ static void vt8500_console_putchar(struct uart_port *port, unsigned char c)
 static void vt8500_console_write(struct console *co, const char *s,
 			      unsigned int count)
 {
-	struct vt8500_port *vt8500_port = vt8500_uart_ports[co->index];
+	struct uart_port *port = vt8500_uart_driver.state[co->index].uart_port;
 	unsigned long ier;
 
 	BUG_ON(co->index < 0 || co->index >= vt8500_uart_driver.nr);
 
-	ier = vt8500_read(&vt8500_port->uart, VT8500_URIER);
-	vt8500_write(&vt8500_port->uart, VT8500_URIER, 0);
+	ier = vt8500_read(port, VT8500_URIER);
+	vt8500_write(port, VT8500_URIER, 0);
 
-	uart_console_write(&vt8500_port->uart, s, count,
-			   vt8500_console_putchar);
+	uart_console_write(port, s, count, vt8500_console_putchar);
 
 	/*
 	 *	Finally, wait for transmitter to become empty
 	 *	and switch back to FIFO
 	 */
-	wait_for_xmitr(&vt8500_port->uart);
-	vt8500_write(&vt8500_port->uart, VT8500_URIER, ier);
+	wait_for_xmitr(port);
+	vt8500_write(port, VT8500_URIER, ier);
 }
 
 static int __init vt8500_console_setup(struct console *co, char *options)
 {
-	struct vt8500_port *vt8500_port;
+	struct uart_port *port;
 	int baud = 9600;
 	int bits = 8;
 	int parity = 'n';
@@ -502,16 +500,15 @@ static int __init vt8500_console_setup(struct console *co, char *options)
 	if (unlikely(co->index >= vt8500_uart_driver.nr || co->index < 0))
 		return -ENXIO;
 
-	vt8500_port = vt8500_uart_ports[co->index];
+	port = vt8500_uart_driver.state[co->index].uart_port;
 
-	if (!vt8500_port)
+	if (!port)
 		return -ENODEV;
 
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
 
-	return uart_set_options(&vt8500_port->uart,
-				 co, baud, parity, bits, flow);
+	return uart_set_options(port, co, baud, parity, bits, flow);
 }
 
 static struct console vt8500_console = {
@@ -683,8 +680,6 @@ static int vt8500_serial_probe(struct platform_device *pdev)
 	snprintf(vt8500_port->name, sizeof(vt8500_port->name),
 		 "VT8500 UART%d", pdev->id);
 
-	vt8500_uart_ports[port] = vt8500_port;
-
 	uart_add_one_port(&vt8500_uart_driver, &vt8500_port->uart);
 
 	platform_set_drvdata(pdev, vt8500_port);

-- 
2.56.0

