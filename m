Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A80257AC8;
	Tue, 24 Jun 2025 08:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750752412; cv=none; b=r/waITKRdsI53Gn+ZW/BLGoa40ZtzgrX5zl0EH212TKy6d2OnUsbM4faEIGcflY/ZqWDLgAygQlfCzEwH1Qf7Eu2NNE14l8qXQbxllUksXwVYEp/9d6oN9z7ilINRskr+MXWdTPHw48RNvJigfA49Bi3ENuinuHyInNdHua508k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750752412; c=relaxed/simple;
	bh=bPw70BD5pj31ckZznLcFvRWmbrsDy0b/Ef6HXqgt00U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dBIc8rvEqpONGhYiEEQCNipXu8h+dajhdN3Z2Q5InRvqtkDDg1JqUVQqivBkWFzJ8w9kk4t73vYwEWH5Q9Lz4W+TPeiMJNgvSi6IrvTBkvH86hz39rk/9fVkAUZKHkL411g7jsRO2bqx234k89FJIjGHkK72E9i5eonE9QO1OCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0soTZsi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0soTZsi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79739C4CEE3;
	Tue, 24 Jun 2025 08:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750752411;
	bh=bPw70BD5pj31ckZznLcFvRWmbrsDy0b/Ef6HXqgt00U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h0soTZsixmgJrfrRdYEg99iImnUwkaLR3HPvGLOkKp03Z4AS90NFWBS6MXnOenavS
	 t32I6kEamF0/5gEmHMV7KAdcv9FIeXWJ3p2Bc6mvrWJi2FDekk/FNYJ10mhB71N1Uy
	 R6DxuMrQePaMBBk0xK/C3EvOc/NQCQVavh+kgIOloknLz7fEC1GrfqvEPA4yebG9tR
	 VL0ZYK3iP4w2YkasV8kunmo8n1uq/Negux1hJB81ag9+pMgXhPD/ZL7JYG4JXZWPk9
	 j2iccEB6ffVvuJZU5mkmSPi4tMHRdEKFu9YE/ZSHMjGYFSjbkjECFwmOYQFCRuhhmh
	 jQBu3gQYeGLfg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	"Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH v2 4/5] serial: 8250: document doubled "type == PORT_8250_CIR" check
Date: Tue, 24 Jun 2025 10:06:40 +0200
Message-ID: <20250624080641.509959-5-jirislaby@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250624080641.509959-1-jirislaby@kernel.org>
References: <20250624080641.509959-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The check for "port.type == PORT_8250_CIR" is present twice in
serial8250_register_8250_port(). The latter was already tried to be
dropped by 1104321a7b3b ("serial: Delete dead code for CIR serial
ports") and then reverted by 9527b82ae3af ("Revert "serial: Delete dead
code for CIR serial ports"").

Document this weirdness with a reason.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Link: https://lore.kernel.org/all/aFcDOx1bdB34I5hS@surfacebook.localdomain/
---
 drivers/tty/serial/8250/8250_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index a6ecb8575da4..feb920c5b2e8 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -717,6 +717,7 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 		nr_uarts++;
 	}
 
+	/* Check if it is CIR already. We check this below again, see there why. */
 	if (uart->port.type == PORT_8250_CIR) {
 		ret = -ENODEV;
 		goto unlock;
@@ -815,6 +816,7 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 	if (up->dl_write)
 		uart->dl_write = up->dl_write;
 
+	/* Check the type (again)! It might have changed by the port.type assignment above. */
 	if (uart->port.type != PORT_8250_CIR) {
 		if (uart_console_registered(&uart->port))
 			pm_runtime_get_sync(uart->port.dev);
-- 
2.50.0

