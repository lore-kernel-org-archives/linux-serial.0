Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D041230BCC;
	Mon, 17 Mar 2025 07:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742194893; cv=none; b=PZ4OHAeqH10Jox13UL3oUYLghJr3A7eFA02dPv8v4VYo4S/3QcV/Z0m4X31GUvMIG1ZFqtp2eAPajwz6kwLY54tcjFGFBUR+BLRmEJMT9PVrExHhyUB9319SDuuWmJuJYSOzf92p0zQBJGwE2uouOfE0PSGvvbVG5cpS5WpTazc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742194893; c=relaxed/simple;
	bh=alsk6lQTdxl1hqqV3gqF9jWzzecxLAozrApyEDbGWoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HS+Y6tOC93cd6gpmtG5BW1n0lt3NiD/KVY5wIpIDY/kAVvPw5xIPV7aghG9yNVL+RiHcFNdsJAY1OhIGqFAyva+/HNRUtqultkhNi5PFkAX7CUVvHylP9yuZC7JCs6HnKp6xFQKj0uZoPCY5znUAdmYwJiv/YgzibanyMEQ+fmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EriGr61W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EriGr61W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D404C4CEEC;
	Mon, 17 Mar 2025 07:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742194893;
	bh=alsk6lQTdxl1hqqV3gqF9jWzzecxLAozrApyEDbGWoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EriGr61W9gNPOWf8ap7iY3tlUUrapDNF8FrrWuylhZbRDWEGfkHBYqqT9RZIwT/gL
	 2TRO+YyhKsutmDnXxocqgDJ8sPlii+ZEwSR2RpAsUjYEqMTqzqXl0LB9ZNDyhyREzu
	 1QsdmxcrDIDw0CGbma1cVOqz+yiZC2bWRpZph7753BBRhhDttgj2yJWV93DIGuX5kB
	 8sqGEFhmTGCPiGo47upSbc81YE7GkVXjURy75Ii0WGHiOmmeJCUtRNrFgPYLYeqLJH
	 si2SAUTvv6HDR32vjAyAFSzZwuRfhbYsEFbujED2yKJ7dhwTkiwpMqU0/qKtRrIEdy
	 hd3Om0jIPGbsA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 26/31] serial: pass struct uart_state to uart_line_info()
Date: Mon, 17 Mar 2025 08:00:41 +0100
Message-ID: <20250317070046.24386-27-jirislaby@kernel.org>
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

uart_line_info() wants to work with struct uart_state. Do not pass a
driver and an index. Pass the precomputed struct directly.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/serial_core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 6fafb1bd6860..0dbf75b25ff6 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2013,9 +2013,8 @@ static const char *uart_type(struct uart_port *port)
 
 #ifdef CONFIG_PROC_FS
 
-static void uart_line_info(struct seq_file *m, struct uart_driver *drv, int i)
+static void uart_line_info(struct seq_file *m, struct uart_state *state)
 {
-	struct uart_state *state = drv->state + i;
 	struct tty_port *port = &state->port;
 	enum uart_pm_state pm_state;
 	struct uart_port *uport;
@@ -2100,7 +2099,7 @@ static int uart_proc_show(struct seq_file *m, void *v)
 
 	seq_printf(m, "serinfo:1.0 driver%s%s revision:%s\n", "", "", "");
 	for (i = 0; i < drv->nr; i++)
-		uart_line_info(m, drv, i);
+		uart_line_info(m, drv->state + i);
 	return 0;
 }
 #endif
-- 
2.49.0

