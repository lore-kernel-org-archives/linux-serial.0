Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AB33E8685;
	Fri, 10 Apr 2026 15:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775834448; cv=none; b=iiH5SgKcEtZY4CnFEdSwuExZU6hhh+c7ISChT4vP1P0+Y/HhbOUVSk2jIt0/LWhz28EJOnhOeK2WNCLJ7oHPNUB9Aro99Fq3nc+AwhamqY04s8NtYR8P2hSVMhteWcQfduFfgLj3tsl6BDGWxzYmuryqfBPduo+bc6nKBDPEwYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775834448; c=relaxed/simple;
	bh=qre5QTp0oNYNYr1fhvtH0HflUbdsUpmXg9OzasaI5B8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=izfQm/IIE+SreVH2cLiSzg5dSK1y7+1slQXS+2JhP3roRzxsfC/vS302J1GnMpqt/Xfepx35Nm8dHI6OqszStmF7p9zRIvEzUI5Y1MIg8WUUNCdSe729zv8cp8rSB3GDPphVKhb9StN0Uf2rhpREyJ0i/4uVPRA1db99VNcX3+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=rksytO81; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="rksytO81"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:subject:date:message-id:reply-to;
	bh=9fp0mmxsvJwLah/tysG889Bb62eYEDk3dVb++99VmJk=; b=rksytO8191iqAg17ks4Cx2+DmV
	yTGctO1bVonP3zcbAsFcxXn2ohCrzN8SRqKtMqNTnfaUjQYt1FbzSl2c4pEgGC8W2SzPpC3nluw8X
	N/tSgSENrBXTzNDL2Z2Do2LiTOVoYDx9uudwzy2tre9LmjXSafIDZdjLNQ21k97P2fKE=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wBDez-000000008Ub-077x;
	Fri, 10 Apr 2026 11:20:41 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: hugo@hugovil.com,
	biju.das.jz@bp.renesas.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: [PATCH 3/5] serial: core: update uart_get_baud_rate() obsolete comments
Date: Fri, 10 Apr 2026 11:20:11 -0400
Message-ID: <20260410152022.2146488-4-hugo@hugovil.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260410152022.2146488-1-hugo@hugovil.com>
References: <20260410152022.2146488-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam_score: -1.0
X-Spam_bar: -

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Update obsolete comments to match the actual code.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/serial_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 89cebdd278410..e6a8ab40442d9 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -465,7 +465,8 @@ EXPORT_SYMBOL(uart_update_timeout);
  * baud.
  *
  * If the new baud rate is invalid, try the @old termios setting. If it's still
- * invalid, we try 9600 baud. If that is also invalid 0 is returned.
+ * invalid, clip to the nearest chip supported rate.
+ * If that is also invalid 0 is returned.
  *
  * The @termios structure is updated to reflect the baud rate we're actually
  * going to be using. Don't do this for the case where B0 is requested ("hang
@@ -523,7 +524,7 @@ uart_get_baud_rate(struct uart_port *port, struct ktermios *termios,
 			return baud;
 
 		/*
-		 * Oops, the quotient was zero.  Try again with
+		 * If the range cannot be met then try again with
 		 * the old baud rate if possible.
 		 */
 		termios->c_cflag &= ~CBAUD;
-- 
2.47.3

