Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794497637;
	b=TP+4nFs0Pc0B/jrkShhbx0wKAlO79toQlW8ocQaTnDrHPTpxWrG8Rbamy6BVYWhTKi1x
	 bvAa1RXPrIX1fL1bOmcETA1ffPbabN4odsE8eL5ieVhquBI/v01dZ4Zpwh6w3BTCyL83H
	 cVw4voAWJUZqzlB2YaM9cCBK/VQCnqTjLo8htzUfQWuu5+f6rV8kJLthU+GjguzPuApM/
	 wIy20hsJYF2qRmkWcZwCGq/ghNT7W8vuyVBs+0S2aBXL8/Qi+chXXIJBOf1T+PZ/fzGwE
	 LMcoOdxTcii+zeUgEJnyfK5GoraJbNkiyOfRsUwJD2HKoxPi5piKRk8S40v+XW7268w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794497637;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=VvrdohMl1QV4VMTfBknOdBjsvgvvJgr+uP4Xo2NyrYU=;
	b=gFDOKOy9z+o5FA8zAgbqCA19CWAbwy8gG1IDUQXfL+alJugOlU1SCYi95qxV0oeno3xG
	 AB7cMXPbxRVi0G7YWq09Ivjbrfw0AgX8VK82YG0jKNnYkhrfntCQCZ1CQ2ZzVMVu6/GV8
	 VVPe7/HIdJaripSSL2sBZQilAlO2C0vAeKCSACAYIodQZh+bD2kZ34S0kRtgblGOIkua3
	 jz01gALEzDQTA/iruKBLr9Fb1Gi+Xq+rdV0SYbc2mYyFWedeib0feQjMCR1K/6zyfiIvz
	 xbmg+0NaaMKos7UM9HrIpIGRXHT6aCPjrQPZhfTv8VyILU4HSJBZCXd8ykuxZMIKjuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ZrF3GV/I";
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995AF606A88E
	for <linux-serial@vger.kernel.org>; Thu, 12 Nov 2026 15:33:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 995AF606A88E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZrF3GV/I
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso42179385e9.1
        for <linux-serial@vger.kernel.org>; Thu, 12 Nov 2026 07:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794497635; x=1795102435; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VvrdohMl1QV4VMTfBknOdBjsvgvvJgr+uP4Xo2NyrYU=;
        b=ZrF3GV/Ijit5cJpcLlKNZMUbCXcWY75b4SvDZpmXFxNzmsuovLiNt1bxikbiuBa003
         pneT3M9Tn+sbVERHYmDWxbPBfDY+T8kl9kQtEY7ffhGUvjvzS5d0+mETI/wZbOyPf1Kv
         fr05Pkt61gl0So+rLDR2kqU8ofpFotF7RXYP3Yneu6oBIWmnaIb2z3ZNVTNGBBo1yd9W
         P+JoaRIY+A/TBpP/oXB5bkh/j8WgGbWQOEc+ND92WaMNQTSB5nKxa305l1v9VEAsQDM/
         k8p1CqodAf8cIRDsb7towDhb1101qe6rd9+Snh1WA1a0LX2yoP+Zga+NJsf8WnBR5yUs
         VjGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794497635; x=1795102435;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VvrdohMl1QV4VMTfBknOdBjsvgvvJgr+uP4Xo2NyrYU=;
        b=Lsf+PATpXjkyn6oZ6T5m6GjGNnmrnufGXDbBJ6VdZDJ0AdnIAhI3fe7MjlO+gHJIC+
         8D60zzsyLK7JcSjBGFmJcmCypFh0jCCzPkl0tcQGdX2BZUJg/8AydKp1IWt8bsUAYqh2
         6NvW8VJ7BU7Yoxo3U2wGEW33MPvy1zcbjMwQl9SOhXTjDV00pN53U4XJG1I38JL7akTe
         UoqTzpW/muiPGkV8IPVO/aZbo8cVtAFYIGArTwRJKHBNH2gGv1qLJJ/BRcB0mkivhdyn
         0GBY5PzUZi+RNt9jhBynuX9LkGcPPdhnmBjwaGf9XgidHbcFNcmyu9qIaatl/GqhyVD0
         RmMw==
X-Forwarded-Encrypted: i=1; AL+hErH5/ydPfys+bVMc2nFwcorMKXYO78QaiStGasGRmKXJs+TgoMiKrZ9VOWzxb8InNhUKVJKDZOyAcBsLFlI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/uzdB3n4mUtPnv1UDv25maQRR83C8M1rx84OvmN7JRcIgMcBIA
	pWdwXG8rFO4xrmhn9DUIKv55IFsu0JZXeN0GJHWT8rWbd1Na+QxV/hwJ
X-Gm-Gg: AYBFou02iTUIqhd/kvmWl/5avvf9G2Re10Pz/GxbNcTVNtZoZFhm75ns1pY27+WUKMW
	F68B0G9iawTQYIPCuwPiRVrPIhUhpv7cGPFkwB7z6VP7PigMHTDEm4k/tHtEHZQlkB8xjRakEYR
	xKJgBLZcVMFNLFIlH9ZKQBqMmJff8eXUg/wF0vCLhhgsx8gGgMFiBGDRxthI8aajeyODw39e+n6
	v4o6nVZ/7DuRTWOb/dy5EfPzzQzGkMU7VJJcYH9vQfms/eqLrshyGm4cPh2eG6o/x5SCqov1ah1
	bpgIPl+g5rrBevVQY+6mJwSKufy5SU5b3uxF3bj9HlRqKMVGcBbyRxailTkSsBfUTE+J/RcWPLb
	C30uDPLjDa1Fx15Rs7lTNn64K9frOI1LKMzug6l22fjuGreTa8eBNAeOzx6lj1gFXIiWqmjyPrI
	ppPdUsURJh80VF2FF86g7aJga6jxgiT+hJ49Z9l3+bGMp5xQD0z0k9dt29keoo4lz3m63bwhGTN
	cbPdzkc3Gy+C7tOvytLaTJcUhvYKFAcL7uWVBTOhCNEYWWPWHxlOSqlQdmmDqDe/tbMzrudTJwV
	4/dBcrkIdv4VCOI0Ge5rzlqdkzOk6df80n1HoAUNHqKpxBBJDv2MPPdIbSaRc8807lLGFgCzgVO
	foyV5ST0=
X-Received: by 2002:a05:600c:1c01:b0:4b0:bc65:b9b5 with SMTP id 5b1f17b1804b1-4ba09395574mr132571925e9.35.1794497635084;
        Thu, 12 Nov 2026 07:33:55 -0800 (PST)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae. [86.98.194.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2593e4sm87105855e9.5.2026.11.12.07.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 07:33:53 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Date: Thu, 12 Nov 2026 19:33:11 +0400
Subject: [PATCH v2 3/6] serial: vt8500: Look up console ports with
 uart_console_port()
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
Message-Id: <20261112-vt8500-serial-cleanup-v2-3-36b258e0c0dd@gmail.com>
References: <20261112-vt8500-serial-cleanup-v2-0-36b258e0c0dd@gmail.com>
In-Reply-To: <20261112-vt8500-serial-cleanup-v2-0-36b258e0c0dd@gmail.com>
To: Alexey Charkov <alchark@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Tony Prisk <linux@prisktech.co.nz>, 
 Alan Cox <alan@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, 
 Wentao Liang <vulab@iscas.ac.cn>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3052; i=alchark@gmail.com;
 h=from:subject:message-id; bh=3liCMnx0+/nFxGsSTGfQu36lLL1bgD05zvuvM2xQkgE=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWR9vePFvWXRnptJkmJnv8UtXvbDco7zgzAHp9aHWw6Zy
 nEV37A92zGRhUGMi8FSTJFl7rcltlON+Gbt8vD4CjOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq
 GRrpGOsYMXBxCsBUH/rC8L/sSa3g6x7lMwryTiW136IWf8zIrmGN2nTRQXWzZ6yUWwLD/2qp/a/
 yOLe2/fzZn/esX+xGv/XpkrhOx4NRx997H9nByA0A
X-Developer-Key: i=alchark@gmail.com; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Ask the serial core for the console's port, which it registers before
the console, and drop the private vt8500_uart_ports[] array that only
mirrors the core state and gets in the way.

The helper also range-checks the console index, which makes the checks
in the console callbacks redundant.

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 drivers/tty/serial/vt8500_serial.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index a7f167a73416..4abd4a8d5ef3 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -444,7 +444,6 @@ static int vt8500_verify_port(struct uart_port *port,
 	return 0;
 }
 
-static struct vt8500_port *vt8500_uart_ports[VT8500_MAX_PORTS];
 static struct uart_driver vt8500_uart_driver;
 
 #ifdef CONFIG_SERIAL_VT8500_CONSOLE
@@ -472,46 +471,38 @@ static void vt8500_console_putchar(struct uart_port *port, unsigned char c)
 static void vt8500_console_write(struct console *co, const char *s,
 			      unsigned int count)
 {
-	struct vt8500_port *vt8500_port = vt8500_uart_ports[co->index];
+	struct uart_port *port = uart_console_port(co);
 	unsigned long ier;
 
-	BUG_ON(co->index < 0 || co->index >= vt8500_uart_driver.nr);
+	ier = vt8500_read(port, VT8500_URIER);
+	vt8500_write(port, VT8500_URIER, 0);
 
-	ier = vt8500_read(&vt8500_port->uart, VT8500_URIER);
-	vt8500_write(&vt8500_port->uart, VT8500_URIER, 0);
-
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
 	int flow = 'n';
 
-	if (unlikely(co->index >= vt8500_uart_driver.nr || co->index < 0))
-		return -ENXIO;
-
-	vt8500_port = vt8500_uart_ports[co->index];
-
-	if (!vt8500_port)
+	port = uart_console_port(co);
+	if (!port)
 		return -ENODEV;
 
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
 
-	return uart_set_options(&vt8500_port->uart,
-				 co, baud, parity, bits, flow);
+	return uart_set_options(port, co, baud, parity, bits, flow);
 }
 
 static struct console vt8500_console = {
@@ -683,8 +674,6 @@ static int vt8500_serial_probe(struct platform_device *pdev)
 	snprintf(vt8500_port->name, sizeof(vt8500_port->name),
 		 "VT8500 UART%d", pdev->id);
 
-	vt8500_uart_ports[port] = vt8500_port;
-
 	uart_add_one_port(&vt8500_uart_driver, &vt8500_port->uart);
 
 	platform_set_drvdata(pdev, vt8500_port);

-- 
2.56.0

