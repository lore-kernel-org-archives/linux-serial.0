Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704605;
	b=t3MnsUj9X5D5dO2BSFXmIrchGs1oqFgIKA6q1wsE0uP3l3OPIV7rf86Nx8KWQ64cwRU4
	 wNb75xPc7U+ZoSCh1YxQ9rtg4h4QAuXfLkd5vJiQXQgMM1VMBRLkvTMMtQvUCw38aNFwn
	 /Ix1LLO6OgCHzwIal8P8XTN5pgccX81TsCNhEXmNMgmlmm+C6lHEHu+5/G59qA5krMd3T
	 Ius0IweKYr7ujvLu8TVcaUtf2clV8/iMS3vzslCNWvc8UJjUNt+f8CljtMT3l+T+W5QeI
	 KOg5y76S9DykZXVtkhFCBqtiG9ESvSZ6ERMvlsvZKofZKZFW/s3QW30umy0Ffkqi+Cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704605;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8/YfSRZgXrBKbb1fmLtj8WE3qU5bIJYq+HM8wflcGik=;
	b=Vw0GgCH6aFWAVzTEpcFxRJ5t7uX6OWxLuWr5rINeioaPdvsRAKRH3SaMb3mGX/mfRRZA
	 CqFlvXvVZXg2If5dz5v74PHFq/6SPSSO4k5Eu39BVUVxfic9mZQt7b4yxKPf8wsc889Lf
	 fZASeIVLUR1Ko++/NmnveRqyExwvEotB0qnt0VWigcPu8fkPebCQluyUlaIdtLRcQGezu
	 Jno+Nj4asfbWh0kUcXxRStN55hI24YWWDcvMXVyIjNslgTttIs6hbGXlMkVX5MqusRMow
	 OxL2fsm4CixlDE8pac5zmjzXqho9Sq6aScpsE/mSr9y/ixZXZ5Y+AJ5G9lXegh+PBTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CnrN8NVq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AEC606C565
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 11:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CnrN8NVq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910931F000C1;
	Tue,  3 Nov 2026 11:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793704604;
	bh=8/YfSRZgXrBKbb1fmLtj8WE3qU5bIJYq+HM8wflcGik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CnrN8NVqCQxVmVNhkAJximPI3bvH+uS/yygGUPjqlPU7v2vsDVG3vLGIMLj0H1+fX
	 EG5duE7B/8+yYGqa0ilxxzNe+ZJLxfJQCaFKvru3dgazOtINZ7MfP/kOSKYmsx5Eam
	 aciFKGDNjCEqeb4EA+6eiXE5ipXZRfHzqQPwVOUp71s1oEsVYPYQoToyQVtvMiPre7
	 EO0GRDFweTvDZGMWYDei4RWP3z0TexrM6NGrYjBrSkxtLJOXZ6/2AzSb36Rr+uSu61
	 /KBN1c/VzGtndmEU2H4fNeGqF+a7So1H4SB36dzujbAgESuB3h1oFz0zQGNipxpGcc
	 AfM0qybdeQNWQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 2/3] serial: 8250_hp300: reorder HPDCA code
Date: Tue,  3 Nov 2026 12:16:38 +0100
Message-ID: <f4dbbb45248771baa130e56bcb0b1916cd909256.1793704520.git.jirislaby@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1793704520.git.jirislaby@kernel.org>
References: <cover.1793704520.git.jirislaby@kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To have less ifdefs (code is now under one) and no forward declarations.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/8250/8250_hp300.c | 62 ++++++++++++----------------
 1 file changed, 26 insertions(+), 36 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_hp300.c b/drivers/tty/serial/8250/8250_hp300.c
index e9599c5c2fea..68ce5972c296 100644
--- a/drivers/tty/serial/8250/8250_hp300.c
+++ b/drivers/tty/serial/8250/8250_hp300.c
@@ -34,29 +34,6 @@ struct hp300_port {
 static struct hp300_port *hp300_ports;
 #endif
 
-#ifdef CONFIG_HPDCA
-
-static int hpdca_init_one(struct dio_dev *d,
-					const struct dio_device_id *ent);
-static void hpdca_remove_one(struct dio_dev *d);
-
-static struct dio_device_id hpdca_dio_tbl[] = {
-	{ DIO_ID_DCA0 },
-	{ DIO_ID_DCA0REM },
-	{ DIO_ID_DCA1 },
-	{ DIO_ID_DCA1REM },
-	{ 0 }
-};
-
-static struct dio_driver hpdca_driver = {
-	.name      = "hpdca",
-	.id_table  = hpdca_dio_tbl,
-	.probe     = hpdca_init_one,
-	.remove    = hpdca_remove_one,
-};
-
-#endif
-
 static unsigned int num_ports;
 
 extern int hp300_uart_scode;
@@ -197,6 +174,32 @@ static int hpdca_init_one(struct dio_dev *d,
 
 	return 0;
 }
+
+static void hpdca_remove_one(struct dio_dev *d)
+{
+	struct uart_8250_port *uport = dio_get_drvdata(d);
+
+	if (d->resource.start) {
+		/* Disable board-interrupts */
+		out_8(d->resource.start + DIO_VIRADDRBASE + DCA_IC, 0);
+	}
+	serial8250_unregister_port(uport);
+}
+
+static struct dio_device_id hpdca_dio_tbl[] = {
+	{ DIO_ID_DCA0 },
+	{ DIO_ID_DCA0REM },
+	{ DIO_ID_DCA1 },
+	{ DIO_ID_DCA1REM },
+	{ 0 }
+};
+
+static struct dio_driver hpdca_driver = {
+	.name      = "hpdca",
+	.id_table  = hpdca_dio_tbl,
+	.probe     = hpdca_init_one,
+	.remove    = hpdca_remove_one,
+};
 #endif
 
 static int __init hp300_8250_init(void)
@@ -280,19 +283,6 @@ static int __init hp300_8250_init(void)
 	return 0;
 }
 
-#ifdef CONFIG_HPDCA
-static void hpdca_remove_one(struct dio_dev *d)
-{
-	struct uart_8250_port *uport = dio_get_drvdata(d);
-
-	if (d->resource.start) {
-		/* Disable board-interrupts */
-		out_8(d->resource.start + DIO_VIRADDRBASE + DCA_IC, 0);
-	}
-	serial8250_unregister_port(uport);
-}
-#endif
-
 static void __exit hp300_8250_exit(void)
 {
 #ifdef CONFIG_HPAPCI
-- 
2.56.0

