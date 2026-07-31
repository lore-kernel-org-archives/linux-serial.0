Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA91B3C3F45;
	Fri, 31 Jul 2026 08:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785485192; cv=none; b=Kq7NBsB3U778uI84K3P6QiTOkp3qvD8Pu/vFe6rJvGVSq5jEfA48/vKPyFNSkzG3kFhFOpBtU5cLxetG0qTlYm0JdEwII66S8mHsLPdMHPWNmQFb1hOUMS9/I0i23RoJPcxD9oWFMscYh6JXuGFpVtD1fXTX9cDZEGQ2th9l5m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785485192; c=relaxed/simple;
	bh=qdq5EyXtVwNpuw7AVa2YqUJsxXL4T/jgAWUgunTxXbc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a7fINy7oDi3ocjmM2upjZPkzmH9/cg2N67G+ySDUICY9Zg7mndlZG1pouKiM/nO/grmCsn2gr8II3luiDtmicP8u3J7z+aj6yQQZVTNyCZAq07TWJWTS8ptpJ2P+UM1ex4L6f0OxaAANiBp2XDYZVCE64j/JKhRUlpTLS7jbUy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yBIfDb02; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yBIfDb02"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C3C1F000E9;
	Fri, 31 Jul 2026 08:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785485190;
	bh=IDKBP4xS0/qjx/ftnPDgwoOfm5XHHxPnCxJvToAEpTI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=yBIfDb02v4bCOjwHHdpQ37TI+V5fYLEMpGu2W31us6rsffwm4gaJYeEKLmmRK7dSu
	 HKY1rK9oDcY8K7FWBJMUK8LRxPsx1Bgo2XHATFwZ70V1Q+A0Jr2ruWtNpcD7OWjNGb
	 KadN+wzf6TuIkKj6na5V7o1lwBmSmc8ftBX15pUI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 31 Jul 2026 10:06:09 +0200
Subject: [PATCH 1/2] serdev: fix race between tty-port unregister and
 in-flight callbacks
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-aisle-tty-serdev-v1-1-2401a3189327@linuxfoundation.org>
References: <20260731-aisle-tty-serdev-v1-0-2401a3189327@linuxfoundation.org>
In-Reply-To: <20260731-aisle-tty-serdev-v1-0-2401a3189327@linuxfoundation.org>
To: Markus Probst <markus.probst@posteo.de>, linux-serial@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Jiri Slaby <jirislaby@kernel.org>, 
 linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Joshua Rogers <linux@joshua.hu>, stable <stable@kernel.org>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openpgp-sha256; l=2153;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=sWQEFy8Ddd2hU898EwQf6RGWycJhOwdR3kEU9oW/Jds=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFk54aXPWA89SVNrOR6dcSD9cvU/66PnTbkObjiiflBV4
 9+SJaLrO2JZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAispcZ5lk5t8uxX6jbWC4m
 4/q9tIcnY8cRLYYFE74v23zwp0qofCbn09ufO1ilPBYyAQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

From: Joshua Rogers <linux@joshua.hu>

serdev_tty_port_unregister() clears port->client_data and frees the
controller without synchronizing with in-flight flip buffer work.
This can cause NULL pointer dereferences or use-after-free if
ttyport_receive_buf() or ttyport_write_wakeup() runs concurrently.

Add cancel_work_sync() to drain pending buffer work before clearing
state, and add NULL checks for client_data in both callbacks as
secondary hardening.

Assisted-by: AISLE:Snapshot
Cc: stable <stable@kernel.org>
Signed-off-by: Joshua Rogers <linux@joshua.hu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serdev/serdev-ttyport.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
index bab1b143b8a6..48ce5b3f8308 100644
--- a/drivers/tty/serdev/serdev-ttyport.c
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -26,9 +26,14 @@ static size_t ttyport_receive_buf(struct tty_port *port, const u8 *cp,
 				  const u8 *fp, size_t count)
 {
 	struct serdev_controller *ctrl = port->client_data;
-	struct serport *serport = serdev_controller_get_drvdata(ctrl);
+	struct serport *serport;
 	size_t ret;
 
+	if (!ctrl)
+		return 0;
+
+	serport = serdev_controller_get_drvdata(ctrl);
+
 	if (!test_bit(SERPORT_ACTIVE, &serport->flags))
 		return 0;
 
@@ -46,9 +51,14 @@ static size_t ttyport_receive_buf(struct tty_port *port, const u8 *cp,
 static void ttyport_write_wakeup(struct tty_port *port)
 {
 	struct serdev_controller *ctrl = port->client_data;
-	struct serport *serport = serdev_controller_get_drvdata(ctrl);
+	struct serport *serport;
 	struct tty_struct *tty;
 
+	if (!ctrl)
+		return;
+
+	serport = serdev_controller_get_drvdata(ctrl);
+
 	tty = tty_port_tty_get(port);
 	if (!tty)
 		return;
@@ -312,6 +322,7 @@ int serdev_tty_port_unregister(struct tty_port *port)
 		return -ENODEV;
 
 	serdev_controller_remove(ctrl);
+	cancel_work_sync(&port->buf.work);
 	port->client_data = NULL;
 	port->client_ops = &tty_port_default_client_ops;
 	serdev_controller_put(ctrl);

-- 
2.55.0

