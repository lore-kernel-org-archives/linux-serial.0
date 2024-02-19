Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DF140BEB
	for <linux-serial@vger.kernel.org>; Mon, 19 Feb 2024 16:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708360812; cv=none; b=pb6ExnusLmSBs9I8O0Nzs3vj5i6fGulu9lym+k2/5f+fnw+II/dD6SFA0M67k/0il99m7IdT8hTbWL0hPY6WfDY/UFz9a8GmMSp7xL36020CAPh1K8GDIFSkYVyGSq9Kc5Y+Tiu4W88AHlJRZ7QhpEbGV7KioE5esadSPxxhzZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708360812; c=relaxed/simple;
	bh=95GvX6IkRKyNVrApn51thQj4Nye8v5hz784wB2DCO04=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P1K1DVztDQqXJ99WOh/nOsuUX0Sy/4i3CsjMP3/MX200zuB7a9x5hYtStSJz7FBV+vtzVR9Pwl02dVBdCTALXxdQZaAXJx56XpV3cUbGvzzyC0OAUX2a1gSGXdIF8m61YQyHZ5sip66rdCKnR4yjqIL76YCkOdtKlSYWEGQ4t5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oh0242Ia; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oh0242Ia"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708360809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aWnNccAiTUjVXKX2RmHz2334a0dYfqfAPgkPcqZqo7E=;
	b=Oh0242IaUhEVwk1yJM5JhU/UkIjjXIjWBd5PJYc3fp1ws0p/u8f6zlZMX+BOABoTCMRCrq
	vopZd5xOSq8aGUNauf5tCSVnsmCLew2+ubsaKHM424eyBLh8U8bdj2TLTnnWEV6Qvp+3PQ
	MW//R7TAGr+SzUf7i9pFXUd26o84R80=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-vNaxvvWQOqem7xRflWcJIQ-1; Mon,
 19 Feb 2024 11:40:05 -0500
X-MC-Unique: vNaxvvWQOqem7xRflWcJIQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F0B3C280FEC9;
	Mon, 19 Feb 2024 16:40:04 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.115])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A15F6492BE3;
	Mon, 19 Feb 2024 16:40:03 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linux-m68k@lists.linux-m68k.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] drivers/tty/serial: Remove unused function early_mcf_setup
Date: Mon, 19 Feb 2024 17:40:02 +0100
Message-ID: <20240219164002.520342-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Compiling a kernel for the ColdFire causes a compiler warning:

drivers/tty/serial/mcf.c:473:12: warning: no previous prototype for
 ‘early_mcf_setup’ [-Wmissing-prototypes]
  473 | int __init early_mcf_setup(struct mcf_platform_uart *platp)
      |            ^~~~~~~~~~~~~~~

This function seems to be completely unused, so let's remove it
to silence the warning.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 drivers/tty/serial/mcf.c | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/drivers/tty/serial/mcf.c b/drivers/tty/serial/mcf.c
index 8690a45239e09..b0604d6da0257 100644
--- a/drivers/tty/serial/mcf.c
+++ b/drivers/tty/serial/mcf.c
@@ -470,33 +470,6 @@ static struct mcf_uart mcf_ports[4];
 #if defined(CONFIG_SERIAL_MCF_CONSOLE)
 /****************************************************************************/
 
-int __init early_mcf_setup(struct mcf_platform_uart *platp)
-{
-	struct uart_port *port;
-	int i;
-
-	for (i = 0; ((i < MCF_MAXPORTS) && (platp[i].mapbase)); i++) {
-		port = &mcf_ports[i].port;
-
-		port->line = i;
-		port->type = PORT_MCF;
-		port->mapbase = platp[i].mapbase;
-		port->membase = (platp[i].membase) ? platp[i].membase :
-			(unsigned char __iomem *) port->mapbase;
-		port->iotype = SERIAL_IO_MEM;
-		port->irq = platp[i].irq;
-		port->uartclk = MCF_BUSCLK;
-		port->flags = UPF_BOOT_AUTOCONF;
-		port->rs485_config = mcf_config_rs485;
-		port->rs485_supported = mcf_rs485_supported;
-		port->ops = &mcf_uart_ops;
-	}
-
-	return 0;
-}
-
-/****************************************************************************/
-
 static void mcf_console_putc(struct console *co, const char c)
 {
 	struct uart_port *port = &(mcf_ports + co->index)->port;
-- 
2.43.2

