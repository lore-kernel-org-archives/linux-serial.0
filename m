Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9FE3624DE;
	Tue, 22 Sep 2026 01:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790040013; cv=none; b=Cb2ODWJjYdGHf91I4ToiF88sh0243DRkbCQKaIJqSxGxC2/UKiRJFZOMCickd8uF7Wo3ZzBEkrdH/62SCA4baqw8iJ2EhqRAkfgumpEWJfnnglf0VvI/Gylam/oeS1rCXZGuy6iBubLnYSC3Csi9UGe5nx2ZAfObrWGLsKlt8S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790040013; c=relaxed/simple;
	bh=Z86KznxgeTUIZD2SxMmTodrmCZvMPJnEO7LZsVetIxQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cdkYceDKob0CY+yizLpQGx8oRp+twZBmz5MRrK5fn+CtXCtZWyA4tR5VL4/Ka5epq0UaxAcpyVDIa2TLS33JZpQNHZ0lc1CBLpH5Wt5j7smp0yC/ZZBRLX8l1blEzlcFHXXNvnD8XhF98R1J8WMICNPaqYPOQrbAn4Nw5/OmlgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCsZaIzi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCsZaIzi"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45232C2BCB3;
	Tue, 22 Sep 2026 01:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790040013;
	bh=Z86KznxgeTUIZD2SxMmTodrmCZvMPJnEO7LZsVetIxQ=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=RCsZaIziqhY96cXeXwjkVyFGsU/aU6xafZ2yF3NJqQiz0QOgt4wHLDnGsVFbB1A9+
	 lafWep2xCLGmj07PinnDxEYkgIQVb2soHARij1bBz9+LfhYiF57gUWWCTrvFY1FiJJ
	 9vQXdHIAsynQnmzhEHr4GtE9lCL8Eq+5I0WmeQWkSgJuEAnYRpVF/ed5Nes20I6gzo
	 4AJCa1IDvUXC+HM2rPAXBLdGOUHFTjOkufNdHD957LzLnWU9tsrUPKumAHNRHZZo5G
	 8/IyoRAsxGGRiO/KK3Qfd96/dp5o3xIqgaAJPiKISrxjhIHbzpERlhSBBS4zzC2a7d
	 qqHrS9RIG6aTw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300A0C982E6;
	Tue, 22 Sep 2026 01:20:13 +0000 (UTC)
From: Jaidev Shastri via B4 Relay <devnull+jaidevshastri.vt.edu@kernel.org>
Date: Mon, 21 Sep 2026 21:20:12 -0400
Subject: [PATCH] serial: amba-pl011: publish amba_ports[] entries with
 release semantics
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-mb-pl011-v1-1-b378bb057d43@vt.edu>
X-B4-Tracking: v=1; b=H4sIAMvXsWoC/yXMzQrCMBAE4Fcpe3YlP0bRVykeku3GRjSWrBah9
 N1N6vEbZmYB4ZJY4NItUHhOkl65Qu86oNHnG2MaqsEoc1Rno/EZcHoordG6GImsGpyLUOtT4Zi
 +21V//Vs+4c70bvvWCF4YQ/GZxhZtnE97i4UOsK4/S1adcYwAAAA=
X-Change-ID: 20260921-mb-pl011-35ffcc30d55f
To: Russell King <linux@armlinux.org.uk>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Jaidev Shastri <jaidevshastri@vt.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790040012; l=2804;
 i=jaidevshastri@vt.edu; s=20260921; h=from:subject:message-id;
 bh=HVyVKJUfeShA9Cl/yJ9Y9hzw2YOBdrEEPbai4gSDMk8=;
 b=Uus3PlpLesgrSLqCkQkUW5L4vrXYNJGcYbo55wSXb1LkDNXlCMzWUUa3MDn9II5WNo+ldABIV
 vOhrLS5voi8BXCPkm/gFc1cd7TDeut2PvYh0k79XPM7pyg5gBDjzLr6
X-Developer-Key: i=jaidevshastri@vt.edu; a=ed25519;
 pk=J7+xYJRlTPds+pv5hbqFFRqGCpDeJDzmZT1ggRwj7/0=
X-Endpoint-Received: by B4 Relay for jaidevshastri@vt.edu/20260921 with
 auth_id=1044
X-Original-From: Jaidev Shastri <jaidevshastri@vt.edu>
Reply-To: jaidevshastri@vt.edu

From: Jaidev Shastri <jaidevshastri@vt.edu>

pl011_setup_port() fills the port structure and then stores its address
into amba_ports[] with a plain store. The console callbacks read the
slot through co->index with plain loads.

Store the slot with smp_store_release() and read it with
smp_load_acquire().

Found with MBCheck, a static herd7-based memory consistency checker.

Signed-off-by: Jaidev Shastri <jaidevshastri@vt.edu>
---
 drivers/tty/serial/amba-pl011.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index c4824c201..696c12ca9 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2536,7 +2536,8 @@ static int pl011_console_setup(struct console *co, char *options)
 	 */
 	if (co->index >= UART_NR)
 		co->index = 0;
-	uap = amba_ports[co->index];
+	/* Pairs with the smp_store_release() in pl011_setup_port(). */
+	uap = smp_load_acquire(&amba_ports[co->index]);
 	if (!uap)
 		return -ENODEV;
 
@@ -2574,7 +2575,8 @@ static int pl011_console_setup(struct console *co, char *options)
 
 static int pl011_console_exit(struct console *co)
 {
-	struct uart_amba_port *uap = amba_ports[co->index];
+	/* Pairs with the smp_store_release() in pl011_setup_port(). */
+	struct uart_amba_port *uap = smp_load_acquire(&amba_ports[co->index]);
 
 	clk_disable_unprepare(uap->clk);
 
@@ -2644,7 +2646,8 @@ static int pl011_console_match(struct console *co, char *name, int idx,
 static void
 pl011_console_write_atomic(struct console *co, struct nbcon_write_context *wctxt)
 {
-	struct uart_amba_port *uap = amba_ports[co->index];
+	/* Pairs with the smp_store_release() in pl011_setup_port(). */
+	struct uart_amba_port *uap = smp_load_acquire(&amba_ports[co->index]);
 	unsigned int old_cr = 0;
 
 	if (!nbcon_enter_unsafe(wctxt))
@@ -2672,7 +2675,8 @@ pl011_console_write_atomic(struct console *co, struct nbcon_write_context *wctxt
 static void
 pl011_console_write_thread(struct console *co, struct nbcon_write_context *wctxt)
 {
-	struct uart_amba_port *uap = amba_ports[co->index];
+	/* Pairs with the smp_store_release() in pl011_setup_port(). */
+	struct uart_amba_port *uap = smp_load_acquire(&amba_ports[co->index]);
 	unsigned int old_cr = 0;
 
 	if (!nbcon_enter_unsafe(wctxt))
@@ -2983,7 +2987,8 @@ static int pl011_setup_port(struct device *dev, struct uart_amba_port *uap,
 	if (ret)
 		return ret;
 
-	amba_ports[index] = uap;
+	/* Pairs with the smp_load_acquire() in the console callbacks. */
+	smp_store_release(&amba_ports[index], uap);
 
 	return 0;
 }

---
base-commit: 93f51579e7df248780214094418f205253383cc5
change-id: 20260921-mb-pl011-35ffcc30d55f

Best regards,
--  
Jaidev Shastri <jaidevshastri@vt.edu>


