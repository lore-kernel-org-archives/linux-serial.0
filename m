Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588D4285071;
	Wed, 26 Nov 2025 09:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764148366; cv=none; b=AYLQcdqHmylw1ArtKGVeBfXqb1eBFdUxdMXpR0A9UUj8U4LICfH3T6NYjQ2/P9a+U6TOTOnCLaiXWSmLYBoVIxXjvFVOBpaBVpWf8tTXuhlzCQs8FMcRh2lMTHkRM5PjNNfMD2gZvkTm+F/AYv8TS4js7YzyOjM5crg5KKjOc4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764148366; c=relaxed/simple;
	bh=R9aJ44s0Pck4UKLhBc8/lG4gOTHPHzrmFn109fEeoF0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XEXxJcOwqJZA2OE4ZT8JRfIoXAFROKNyrtY+cvatudiQxGL2Yp2tZ1d70aJW04ed9dYtCokiNuzn9aqnV6loMc3e6dVMTFaN59Pj5HvL60G2nRnFpXn1WVRMsD5AP3o108LKDw5PnvoBTyLF2PtaMJYuBtcM/3ycKg3AdXc6P/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6TXh9rW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6TXh9rW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C8BC113D0;
	Wed, 26 Nov 2025 09:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764148365;
	bh=R9aJ44s0Pck4UKLhBc8/lG4gOTHPHzrmFn109fEeoF0=;
	h=From:To:Cc:Subject:Date:From;
	b=J6TXh9rWpGe3fNOJ2puYp/RK1pzOGTDkkUpsv6sNAZA4eqJRIPsK3//yc76M0f8sf
	 HcC9qdsiWxeuJvUDe1YzkWjpcFyE/qV2MhK5IT0XkGrchULTflK0Rq8nhQBmKph8V+
	 IFd4z9gucF5sEJ561JTiFixRXE1RY75bDSlSBDP8gxPLhatOs8ktlb5orDNZbn6Czs
	 Ex+XgLye9QefBTWLLdPmpvBgekOBMs8Em4evWZlJuEZ8besi0eyHsGzbn6LloBFBoH
	 L4TZxgp5G5CiHcKpjNOEl1ZNkE/IwnXjttIwfB0WCYrFm4YkGND3qKVkd8foZIn9xL
	 ujBZTsY6i8eLQ==
From: Philipp Stanner <phasta@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Philipp Stanner <phasta@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] tty: serial: Replace deprecated PCI API
Date: Wed, 26 Nov 2025 10:10:33 +0100
Message-ID: <20251126091032.130787-2-phasta@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_iomap_table() is deprecated. Moreover, its special usage in 8250,
causes a WARN_ON to fire (in pcim_add_mapping_to_legacy_table()).

8250's function serial8250_pci_setup_port() effectively maps the same
BAR multiple times and adds an offset to the start address. While
mapping and adding offsets is not a bug, it can be achieved in a far
more straightforward way by using the specialized function
pcim_iomap_range().

pcim_iomap_range() does not add the mapping addresses to the deprecated
iomap table - that's not a problem, however, because non of the users of
serial8250_pci_setup_port() uses pcim_iomap_table().

Replace the deprecated PCI functions with pcim_iomap_range().

Cc: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/dri-devel/16cd212f-6ea0-471d-bf32-34f55d7292fe@roeck-us.net/
Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
@Guenther: Can you please test this? I hope it fixes your issue.
---
 drivers/tty/serial/8250/8250_pcilib.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pcilib.c b/drivers/tty/serial/8250/8250_pcilib.c
index d8d0ae0d7238..f98eb2ab1005 100644
--- a/drivers/tty/serial/8250/8250_pcilib.c
+++ b/drivers/tty/serial/8250/8250_pcilib.c
@@ -28,13 +28,14 @@ int serial8250_pci_setup_port(struct pci_dev *dev, struct uart_8250_port *port,
 		return -EINVAL;
 
 	if (pci_resource_flags(dev, bar) & IORESOURCE_MEM) {
-		if (!pcim_iomap(dev, bar, 0) && !pcim_iomap_table(dev))
-			return -ENOMEM;
-
 		port->port.iotype = UPIO_MEM;
 		port->port.iobase = 0;
 		port->port.mapbase = pci_resource_start(dev, bar) + offset;
-		port->port.membase = pcim_iomap_table(dev)[bar] + offset;
+
+		port->port.membase = pcim_iomap_range(dev, bar, offset, 0);
+		if (IS_ERR(port->port.membase))
+			return PTR_ERR(port->port.membase);
+
 		port->port.regshift = regshift;
 	} else if (IS_ENABLED(CONFIG_HAS_IOPORT)) {
 		port->port.iotype = UPIO_PORT;
-- 
2.49.0

