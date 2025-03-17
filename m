Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD80322F397;
	Mon, 17 Mar 2025 07:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742194891; cv=none; b=cyYHMgztMnMA1pSdejDRdo8ysx97zEzBUYt7ijVxcspB0tSvhoTtL8Xv/VJx3a6kAUUE9yZ0GPZc+cvF9ZsZe02Nde23rA3X+6KCzmOQap226KUWaFphqu6JOftaLRL1s2/2YwDfsij06lDdMzX2/+Edgmxk9uwXdrBlKVtmwqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742194891; c=relaxed/simple;
	bh=1rdXQyJej8ITir/cAQWBTR5R0h/xen+2KFDCxqV7Gjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BZn+yLbebuXYhj25o2PvZYt0PgZnnyuc8hwLeo+57y6vUO+F1xgJxgBUysN6BLGynMxF+5Kp51UMHkTYXuW15zGYnIwS9KCsdzYQXpRufjy51ANVdei2UncKofi5XSXoKQcNBqzRvByqgNZgdqvrEoMVg2H3MpiReT2Y1xEkoVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rln0cIwM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rln0cIwM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BDD0C4CEEC;
	Mon, 17 Mar 2025 07:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742194891;
	bh=1rdXQyJej8ITir/cAQWBTR5R0h/xen+2KFDCxqV7Gjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rln0cIwMCYJI4ui2N9Hjz3l9cLCdyrVeu9tqVFfUG4dda5oSKIadm1f7xRzun6iA7
	 MegjKWhXW6UEyRbdX+hcCYhohUh5R7P39SnleRzcHTetTUjcY62KOEb1WrGHtCdEm6
	 3awqMzBoNIrx4VPeGzV8A5fLd6ne8b9CF+qbYO8PtYFIUIRquOE3w/sO6Xd4siCj1g
	 G1JDd4NrBOMUJHc1ta9nUlqxEox0EB9maTeQYe2iTQxLLJngUt07U46Md3SqbN+sEu
	 XmcNIS4jYCd0FtkQ9dYcvW1p4w0zkSQy+EtLdw3BUoV25LKigPYH3HbERtMU1FQ9Vw
	 IyzsX4qs3idkw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 25/31] serial: remove redundant tty_port_link_device()
Date: Mon, 17 Mar 2025 08:00:40 +0100
Message-ID: <20250317070046.24386-26-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250317070046.24386-1-jirislaby@kernel.org>
References: <20250317070046.24386-1-jirislaby@kernel.org>
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
index d46650e578e5..6fafb1bd6860 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3156,7 +3156,6 @@ static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *u
 	if (uport->cons && uport->dev)
 		of_console_check(uport->dev->of_node, uport->cons->name, uport->line);
 
-	tty_port_link_device(port, drv->tty_driver, uport->line);
 	uart_configure_port(drv, state, uport);
 
 	port->console = uart_console(uport);
-- 
2.49.0

