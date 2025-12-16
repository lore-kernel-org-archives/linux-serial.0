Received: from mail.elsta.tech (mail.elsta.tech [194.150.96.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0927D346A11;
	Tue, 16 Dec 2025 15:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.150.96.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765899253; cv=none; b=Yp0GS4YpHO452Od+8JK2AXTYMlKQc4AFluuRvdfPaXCCTKvEQGNGnCwUIqAfFtRYMxnT0HHfdT/eXfG/Sje79/l6AxoJ8I7vKUzuYcADRRaJ/uyWOVjiYI4s7NNaRVsgidwkjj5i2epciEg48UQHFOuun0HsbYImwt5ie/KRcf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765899253; c=relaxed/simple;
	bh=A0B3UNA2l3Jrttc9EjCes1c+BbepUiBfORJgiE2TV30=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q9QE4bObiMoIGlgZVpzFA1MxHn7XH0hsUWhONjEzTrFzEFONVABksivZXSgYblltIcNyB4bVV6fQ8dIg1CjIebAs86egUZYa50Yvot6epEibdWRNRBFn7W3X0bBp83uG2VhS1edMCbub5cMKKTVb/0S50dltHljlUp+1bGfzv+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=elsta.tech; spf=pass smtp.mailfrom=elsta.tech; dkim=pass (2048-bit key) header.d=elsta.tech header.i=@elsta.tech header.b=D5qvq80e; arc=none smtp.client-ip=194.150.96.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=elsta.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=elsta.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=elsta.tech header.i=@elsta.tech header.b="D5qvq80e"
Received: from localhost (localhost [127.0.0.1])
	by mail.elsta.tech (Postfix) with ESMTP id 8E9B88C00C4;
	Tue, 16 Dec 2025 16:27:39 +0100 (CET)
Received: from mail.elsta.tech ([127.0.0.1])
 by localhost (mail.elsta.tech [127.0.0.1]) (amavis, port 10032) with ESMTP
 id 7ZJ2rgH8-Rks; Tue, 16 Dec 2025 16:27:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mail.elsta.tech (Postfix) with ESMTP id 4DECE8C00E1;
	Tue, 16 Dec 2025 16:27:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.elsta.tech 4DECE8C00E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=elsta.tech;
	s=0883730E-C77C-11E9-9DA4-0BE9876769AA; t=1765898859;
	bh=OTkMzslZuFHuKZCP/n42zZM3gYCt1QyOVGH3TZnQcqk=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=D5qvq80evHvKNB6XacBcIQrwESQjeC3JNVNwksjpeA28GJx1iqBWlyLuLYIw44YFp
	 SD8VnDCk2CxJ09528689D+QJoLvxNAzPEbs93tWf5v2mUJbigpbB9JZI4D2x2DRdmW
	 wA3ygPzFVMtFNQiAQCxSg1WyjXH2SqWW7zR5MQQ8BPLI0kVjAkhBsYExxOIipQL9iI
	 QS8M8Hk5R86s/zghwZk7c8jHoVBi+be52DyPTQHRXOlMTZpGfsZ4n6nzmqiHmqTXGH
	 c1POyMCh7t0NY55pgAw2m6ZWg+n5kcQEdZzcYRKk72WSoqmtE/tQ1W6ILf7CKjbLuE
	 +1GF9cRQRlA9w==
X-Virus-Scanned: amavis at elsta.tech
Received: from mail.elsta.tech ([127.0.0.1])
 by localhost (mail.elsta.tech [127.0.0.1]) (amavis, port 10026) with ESMTP
 id HkQ4IHc0qYHm; Tue, 16 Dec 2025 16:27:39 +0100 (CET)
Received: from dev-VirtualBox.elsta-tech.lan (unknown [172.31.0.125])
	by mail.elsta.tech (Postfix) with ESMTPSA id 2017B8C00C4;
	Tue, 16 Dec 2025 16:27:39 +0100 (CET)
From: "j.turek" <jakub.turek@elsta.tech>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: michal.simek@amd.com,
	namcao@linutronix.de,
	tglx@linutronix.de,
	zack.rusin@broadcom.com,
	sean.anderson@linux.dev,
	hshah@axiado.com,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"j.turek" <jakub.turek@elsta.tech>
Subject: [PATCH] serial: xilinx_uartps: fix rs485 initialization at boot
Date: Tue, 16 Dec 2025 16:26:41 +0100
Message-Id: <20251216152641.196221-1-jakub.turek@elsta.tech>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When 'linux,rs485-enabled-at-boot-time;' property is enabled in device-tr=
ee
and there is no rts-gpio defined there is NULL pointer dereference in
function 'cdns_rts_gpio_enable' because 'cdns_uart->port->membase' pointe=
r
is not set at this point

Signed-off-by: Jakub Turek <jakub.turek@elsta.tech>

Fixes: fccc9d9233f9 ("tty: serial: uartps: Add rs485 support to uartps dr=
iver")
---
 drivers/tty/serial/xilinx_uartps.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xili=
nx_uartps.c
index c793fc74c26b..1e4d54fd5762 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1816,8 +1816,6 @@ static int cdns_uart_probe(struct platform_device *=
pdev)
 		console_port =3D port;
 	}
 #endif
-	if (cdns_uart_data->port->rs485.flags & SER_RS485_ENABLED)
-		cdns_rs485_rx_setup(cdns_uart_data);
=20
 	rc =3D uart_add_one_port(&cdns_uart_uart_driver, port);
 	if (rc) {
@@ -1826,6 +1824,9 @@ static int cdns_uart_probe(struct platform_device *=
pdev)
 		goto err_out_pm_disable;
 	}
=20
+	if (cdns_uart_data->port->rs485.flags & SER_RS485_ENABLED)
+		cdns_rs485_rx_setup(cdns_uart_data);
+
 #ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
 	/* This is not port which is used for console that's why clean it up */
 	if (console_port =3D=3D port &&
--=20
2.34.1

