Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C1F4436C;
	Sat,  6 Jul 2024 08:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720255420; cv=none; b=gvmSNQ98gj67G+nn4Z7fUuwklt5bLHa/T2IQBTWlOzV64X9Wy59oqTBg4O9egBMfFfiEPruXz2CgqjP1keL6b9BrCIf+IS4dth7VJZLYvazw21m2bVS5JObOxyrieW9kkG5D87lLZOYsGNjn5/eqvQTbrdJZB0V4igmQJY5hYyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720255420; c=relaxed/simple;
	bh=luJ5DLdUyXD8SFaZVQleUHpTlDnNDHd76QU1blhacnE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SCL/r9qphu1RrdqqLQmBbj3Ntj40LtCBxd8wJgaPUyIrzEGkbrKrFzAhOB1MVhCG2ddAqCcTQymVHVx6qYYw6/6SbnwhKdMYvkQojXixHpet6goQqEQBVA2oyLDhHHLYll3WpJn+h4nLg5VW6scep1Wr2dsu/G+kIf1OqMAHS8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VomqK22i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VomqK22i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED0FC2BD10;
	Sat,  6 Jul 2024 08:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720255420;
	bh=luJ5DLdUyXD8SFaZVQleUHpTlDnNDHd76QU1blhacnE=;
	h=From:To:Cc:Subject:Date:From;
	b=VomqK22i/Sp7tfddlIJ2CbgHTeJmj48WXxMdDLFyt8p7GebDHaWMb/ACS/ia5eJ2o
	 kOHqLJ/9JO5owU/jzTUaf5cmF532+Axm255G8FqE66ZMF0VNoMrbZtgOrsoH0pRADK
	 FBUvSI7/zD3AGEFRH2f+6KRgiWhQfDTiuRASp+PNDyjU4IHTi3avL54vAB7uRPE2pK
	 AXJbP0CH+gg2W9ulWYA/zAMnWIahripkd+azVouj6hOyhDvVOz1O5QBmxc37Tphe6R
	 QU+alL0oD45iwk4Lb8VLjPkQWpvJ4w6cJHYZLIZlwtz+naUyp3e5bR/JejAMcXdOpt
	 MFrBS/ZqVg5Gw==
From: Jisheng Zhang <jszhang@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH] serial: 8250: don't lost port's default capabilities
Date: Sat,  6 Jul 2024 16:29:28 +0800
Message-ID: <20240706082928.2238-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit b0b8c84cf58d ("serial: of_serial: Handle auto-flow-control
property") added support for fifo-size and hw-flow-control properties
to avoid adding new types to 8250.c for UARTs that are compatible with
the standard types but that have different size fifo or support 16750
compatible auto flow control. We avoided many new 8250 port types with
this nice feature, but there's a problem, if the code detects fifo-size
or auto-flow-control property, up->capabilities will be set
accordingly, then serial8250_set_defaults() will ignore the default
port's capabilities:

|if (!up->capabilities)
|	up->capabilities = uart_config[type].flags;

If the port's default capabilities contains other bits such as
UART_CAP_SLEEP, UART_CAP_EFR and so on, they are lost.

Fixes: b0b8c84cf58d ("serial: of_serial: Handle auto-flow-control property")
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/tty/serial/8250/8250_port.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 893bc493f662..e20614241229 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3245,8 +3245,7 @@ void serial8250_set_defaults(struct uart_8250_port *up)
 			up->port.fifosize = uart_config[type].fifo_size;
 		if (!up->tx_loadsz)
 			up->tx_loadsz = uart_config[type].tx_loadsz;
-		if (!up->capabilities)
-			up->capabilities = uart_config[type].flags;
+		up->capabilities |= uart_config[type].flags;
 	}
 
 	set_io_from_upio(port);
-- 
2.43.0

