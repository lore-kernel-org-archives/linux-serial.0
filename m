Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5173D213220;
	Thu, 20 Feb 2025 11:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050213; cv=none; b=E18V/4xTYr5mj2xf4cT2bPuqHuXeHxJJBAd2LPEl19SFajmAXS2We6gZbeUMFqXugSWD8RDt2nHgQf/7GIEwKvGwKXOw6g5o+Okx0y6mQrB9bOaw6ty/nEwkq/cK+GFJJb4XHZWTP2zSH5LoiBL4B4RhNiAGfTIZyX7ehHvziTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050213; c=relaxed/simple;
	bh=JJKCDyoUI49ul5goAoSRKGA9x8DCTFWq3J5//jDxDjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fam0+Jpr1jWVPOJd7q9WVw3hErzg2fnw3JIHh494YMP1VoQ/SnPSs2YyG8hxoz+q2Jd39QK6/Refkm8MnukuYqZuMZ/9CokMoKLfAND0eqPModxDiQBVG1wD0cU2odfFlzNPzyskFM5DpkU7lbib0smUwfN7gE8BVsVpp/hThEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMdWy1gp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMdWy1gp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C0FCC4CEDD;
	Thu, 20 Feb 2025 11:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740050213;
	bh=JJKCDyoUI49ul5goAoSRKGA9x8DCTFWq3J5//jDxDjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UMdWy1gpn32bSWxPGo3mySZvFZ2rRlzYQAJMQfSCLL9xKO/j//hBnlEMjwmKV2/Iq
	 Lph/8bGB8TPXIrvVUt+rjQ0KZzQQa6Ubt9xHK5jNLvfHvmOg+S8/zeuI9NB3uHP8ua
	 jXMCtWrUtSKUCK6nKfHkMXzkyLz7hQIjYrP1SLvcLFGQGyoSAxInrbUsSqSmggp2tQ
	 W5acqCUgFiG7YsV2254jVzIpi5Q80yZEM6irvvqoVwbLs9wQ4JRiG/tLeOZU2l5Wwk
	 wYc4EjLI0SZCDx8dgwBv5VgmCyRsm6yATkapcalI+Rr+fwxsa9qLnUUDKW7gMsZy9f
	 Rh5CvRuH9cGzw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 24/29] serial: remove redundant tty_port_link_device()
Date: Thu, 20 Feb 2025 12:16:01 +0100
Message-ID: <20250220111606.138045-25-jirislaby@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220111606.138045-1-jirislaby@kernel.org>
References: <20250220111606.138045-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The linking is done implicitly by tty_port_register_device_attr_serdev()
few lines below. So drop this explicit tty_port_link_device().

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/serial_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index f24d8edf1bee..2a6453891801 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3156,7 +3156,6 @@ static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *u
 	if (uport->cons && uport->dev)
 		of_console_check(uport->dev->of_node, uport->cons->name, uport->line);
 
-	tty_port_link_device(port, drv->tty_driver, uport->line);
 	uart_configure_port(drv, state, uport);
 
 	port->console = uart_console(uport);
-- 
2.48.1

