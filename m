Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C6D3ACA75
	for <linux-serial@vger.kernel.org>; Sun, 19 Jul 2026 16:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784477319; cv=none; b=DqlQuVcA8+yeG9owURkbZWIOvGKwQFWPcWiVoeXu/QNNMpfPRZUOLVDJ2bP8GBko43xiYuEQ0wowqvPlQSfBxj9FDE/4Aukjxb/aQCk6RF91rmqxL6gyDYZqxJEe2a+Qw+jwxnoddqm0xCzy4WSwV1oOLrFMFkgwVaipWJ8+lLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784477319; c=relaxed/simple;
	bh=8sdnQwIMdO7CwPShC74pX/gtmmBu9zvdCtaHEui32XA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EVIcZECa3yvEZ31GbIZ9V7rT3j2u4wC3S1YOdWIj7GvWI5hHwx3TYNLN9mLHIobU3Z+nhV8IDnekRdRPP2p4lJFWnwXmaVXbbLi4DmsFhX4Xm4BZepZgoTB5coW6pb8aerGa/XMYb4Vl+qSinyyhRkNSxKBX8KaLflcMSVnBtII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DW/jTCV2; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DW/jTCV2"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4954dff6536so11322785e9.0
        for <linux-serial@vger.kernel.org>; Sun, 19 Jul 2026 09:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784477316; x=1785082116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/SUAt/6zWUy8VxjfuD7LmHF2gwOSZYdtNqcx/e+ByoY=;
        b=DW/jTCV2S3HFHpdNmnAIJkQh4qaLZdmdU7SPXoSzy60dW+KfNOWheL9rwc3lDTc0L5
         P57PNBce04KyoJbgkW3kjcLplQzQjFE8DeeCcsVHOZkdPns002m6eXUd/Rd2tTavOUeU
         mIvzvcqnfx+AtJqWdSINxguTSHdSkDzOPmVFYa9VPHiOcI6z3o2ee2Jyqb6ZoA5/vgPl
         GgKFAEQgRulpwAzR7ndpymy3x9G26foYf2l810mq8vGKll24roFyrqm0BVBtKiKsd0I0
         T7QC/Z025fvlRKC1tm8Rm96SritzUqkxV6SynBuIdgcfA9gYVC5qeriPt1NWwNMROyfC
         xN8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784477316; x=1785082116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/SUAt/6zWUy8VxjfuD7LmHF2gwOSZYdtNqcx/e+ByoY=;
        b=L/002aCWTLI+SemmopIS6dcyCnFEQy6cy+PGO5ryTGaKSfZKbdC2mp58YbGbazuk2L
         X1bxDbdJtU7w38iOlYJq5vjsIWpCOh38nJQKJ87AnPNuR5/bH4MidKl1SiJu5imr0cHJ
         89KDPp2OUcoEHWEafoNEhht+/YFMR53RprVdlha4DLKhBj/LDFM3+LuCCIVSlfm6tTCs
         D/pf8IPl14gxOc/ZoB2bH250SHZW84pBXG8c2csNL+Zo8UxfAf5R1Qo5N8AQFRs61+Vl
         kEC0dO6cgVG6tWFqQu3yqQnh5ok+/PdXUscdQGl9RHNueOKFVkcMuItaQKofqdVrZmGE
         pPhQ==
X-Forwarded-Encrypted: i=1; AHgh+RrSSRPOvcZVC2Sxk4Zo51XxynVPWExfWO8Go2sXAtIOjr1xSJJ1BVIhcTBw+M0LGhq/ZPdT/qZb+ZbhhD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMXaFQeGpdW7av5KiA7VrwmyuCIhEMdrd94pUcIVRwxFlA5M8V
	oOKwyeAhxUn+P/Hnq9Id3/hM/hXfCrxbEjy+Dm3xhjePKX/4oOW4mcFx
X-Gm-Gg: AfdE7ckZGS+fCtmOCalKB/UdRB2/7F7z0UfDGwXioQH2vuFbM9TfcU9BCxVFXMHfQGs
	xYW/hB2Xc5fxs12RbHBxeaGztJxRr5G5MPUjotYmcfo8c4BRMCA3Zw7GAnfoANsV5BsYNPMETWw
	Mk9FGQ88GEzqD8ZcSJAq7hRv8cBGs/9wlr/J/NHV3dO0eRFbnaY92x0iYtP7mNHGVXFJuK51/Ao
	pxrhUk4aDvGTvDba6KZVVSGgji9idTHzgcQ5rfCWj+/i3i8889IyktPiYPlVSJtWXZ6vbdFrOcB
	yyzPRrXTvqMBnKUEHFGvKp4wvs3oN63Pic39+43j/u2CRKjwDhxL1D/TtkPPw+RhQ/9rn1Qwrr1
	s03Ge8FoUtRdNFJfXUJUIzpr0ghzcJN7qYdxhpQhN3CmtKOnfXSfsx/rkY3WqUAHFCFWtdE9UAb
	MKPrAx9swIpY06K1qoEpa+IrfpxFoAbpfsARRD9ZScs9jPuOLtmyuKX9lgy3vogd5rSGU+AAKAC
	XZ1aXa8nnmiNS6Z1f5gkFTkh3q2m2PGAAKORLbm9XdtZdBEsZLIhsTDfj6oKwpk1iYgHjDW3xUc
	pD2KyfDlEQ==
X-Received: by 2002:a05:600c:4504:b0:493:eb71:5cc6 with SMTP id 5b1f17b1804b1-4954a40bbc8mr113521195e9.27.1784477315903;
        Sun, 19 Jul 2026 09:08:35 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-aeaf-bd01-78a0-2a2d-507f-c97c.310.pool.telefonica.de. [2a02:3100:aeaf:bd01:78a0:2a2d:507f:c97c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2edbe4sm223826745e9.12.2026.07.19.09.08.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Jul 2026 09:08:35 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH 4/4] serial: imx: clear imx_uart_ports[] entry on probe failure and removal
Date: Sun, 19 Jul 2026 18:08:12 +0200
Message-Id: <20260719160812.35407-5-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260719160812.35407-1-kmehltretter@gmail.com>
References: <20260719160812.35407-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

imx_uart_probe() stores the port in imx_uart_ports[] before calling
uart_add_one_port() because console setup during that call uses the
table. The entry remains set if uart_add_one_port() fails.
imx_uart_remove() also leaves it set after uart_remove_one_port().

sport is devm-allocated, so a failed probe or unbind frees it while
imx_uart_ports[] still points to it. A later sibling probe can register
the shared console with the old preferred index and dereference the
stale entry in imx_uart_console_setup().

Reproduced on qemu's mcimx6ul-evk by unbinding a sibling UART, unbinding
the console UART and rebinding the sibling:

  BUG: KASAN: slab-use-after-free in imx_uart_console_setup+0xd0/0x3d8
  Read of size 4 at addr c49ad9d4 by task init/1
  Call trace:
   ...
   imx_uart_console_setup from try_enable_preferred_console+0x158/0x1f8
   try_enable_preferred_console from register_console+0x1cc/0x80c
   register_console from serial_core_register_port+0xe58/0xeb0
   ...
  Freed by task 1:
   ...
   devres_release_all+0x100/0x18c
   device_unbind_cleanup+0x38/0xdc
   device_release_driver_internal+0x230/0x288
   unbind_store+0x64/0xa8
   ...

The entry must remain visible while uart_add_one_port() and
uart_remove_one_port() run. Clear it when adding the port fails and
after removing the port. Save the line index before removal because the
uart_port is no longer valid afterward.

The probe-failure cleanup relies on the preceding serial-core change
"serial: core: do fallible allocations before the console can be
registered", which ensures that uart_add_one_port() cannot fail after
registering the console. For complete coverage, both changes should be
backported together.

Fixes: dbff4e9ea2e8 ("IMX UART: remove statically initialized tables")
Fixes: 9f322ad064f9 ("imx: serial: handle initialisation failure correctly")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/tty/serial/imx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 251a50c8aa38..617c35772056 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2637,6 +2637,8 @@ static int imx_uart_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, sport);
 
 	ret = uart_add_one_port(&imx_uart_uart_driver, &sport->port);
+	if (ret)
+		imx_uart_ports[sport->port.line] = NULL;
 
 err_clk:
 	clk_disable_unprepare(sport->clk_ipg);
@@ -2647,8 +2649,10 @@ static int imx_uart_probe(struct platform_device *pdev)
 static void imx_uart_remove(struct platform_device *pdev)
 {
 	struct imx_port *sport = platform_get_drvdata(pdev);
+	unsigned int line = sport->port.line;
 
 	uart_remove_one_port(&imx_uart_uart_driver, &sport->port);
+	imx_uart_ports[line] = NULL;
 }
 
 static void imx_uart_restore_context(struct imx_port *sport)
-- 
2.53.0
