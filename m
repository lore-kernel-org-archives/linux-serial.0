Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F337B3CA491;
	Fri, 31 Jul 2026 08:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785485195; cv=none; b=CLWT8HQBDyHsSHzEIjW0NYI2TZ+WdF0USqF0LT+kTwiIE56lPLDvuLpJpQBbrxNAXRR5RBG4CZucQCR2wtSDBSEFserOL06gMiN/G12b5y0p4pzF4/YaZktRrsl0P/k74PUOFOotvAJavPt/WLZMj+RJurwNMWpzjw9O65T188k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785485195; c=relaxed/simple;
	bh=rJISz485z0GX96GNUrLIFr0nQsKGxAVGVuLA51W4+5Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tKuCeYMoPmzstT2lrRJ9c/sV0/9Y/mWpe72YHMeFT3K96u+j+DspM8dDVh8GWZOOGFmlI94x9V1t/FN4yGDEmW2Ij0e4KvVyo8/fZ3ranaQpki5FLYvG06Czf849ZTsais4nAiehsW6qaZBrja9W31YPANjrxkdkk/bKv9sFJmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YNZxXxdP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YNZxXxdP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1589A1F000E9;
	Fri, 31 Jul 2026 08:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785485193;
	bh=kWtYNBXgx1ERnjuPzRf0p7LW+RSZjWnKR1InaA5DbMU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YNZxXxdPuUa8QYFJYecg20/DzUICGSXsOM3OK3CBujNOpH9wCPVnZeveBbVI7ip+M
	 9G+lcDYptuzH6dH2TOFgAWJ9v4Or6906TErwgQFO1OmIBD8lwLoJiKwg1iblfc+BbZ
	 Ak/cWzyf1CjHSZWtfR+tfc6G5HDoISvGN51pyWCQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 31 Jul 2026 10:06:10 +0200
Subject: [PATCH 2/2] serdev: use tty_port_tty_get() in ttyport_write_buf()
 to prevent UAF
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-aisle-tty-serdev-v1-2-2401a3189327@linuxfoundation.org>
References: <20260731-aisle-tty-serdev-v1-0-2401a3189327@linuxfoundation.org>
In-Reply-To: <20260731-aisle-tty-serdev-v1-0-2401a3189327@linuxfoundation.org>
To: Markus Probst <markus.probst@posteo.de>, linux-serial@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Jiri Slaby <jirislaby@kernel.org>, 
 linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Joshua Rogers <linux@joshua.hu>, stable <stable@kernel.org>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openpgp-sha256; l=1578;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=CIoA1U7goq1GlxfkNWw/iYNPnQOup6iGI8gPBqnZteU=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFk54aWGJ9vMRZMubW2rVfIwmz5tMeesuM656qqN/797P
 PxUNdWgI5aFQZCJQVZMkeXLNp6j+ysOKXoZ2p6GmcPKBDKEgYtTACZiLs8w32frovxLqQfTnvT9
 t/J8V5y87dc+b4YFRxa8lp5vOW/z43eBC5zEb9ce2XZiOgA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

From: Joshua Rogers <linux@joshua.hu>

ttyport_write_buf() snapshots serport->tty as a raw pointer without
taking a reference, while ttyport_close() can concurrently release the
tty via tty_release_struct(), leading to a use-after-free. Use
tty_port_tty_get() to obtain a reference-counted tty pointer, matching
the pattern already used by ttyport_write_wakeup().

Assisted-by: AISLE:Snapshot
Cc: stable <stable@kernel.org>
Signed-off-by: Joshua Rogers <linux@joshua.hu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serdev/serdev-ttyport.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
index 48ce5b3f8308..4d37c8130dd7 100644
--- a/drivers/tty/serdev/serdev-ttyport.c
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -85,13 +85,21 @@ static const struct tty_port_client_operations client_ops = {
 static ssize_t ttyport_write_buf(struct serdev_controller *ctrl, const u8 *data, size_t len)
 {
 	struct serport *serport = serdev_controller_get_drvdata(ctrl);
-	struct tty_struct *tty = serport->tty;
+	struct tty_struct *tty;
+	ssize_t ret;
 
 	if (!test_bit(SERPORT_ACTIVE, &serport->flags))
 		return 0;
 
+	tty = tty_port_tty_get(serport->port);
+	if (!tty)
+		return 0;
+
 	set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
-	return tty->ops->write(serport->tty, data, len);
+	ret = tty->ops->write(tty, data, len);
+	tty_kref_put(tty);
+
+	return ret;
 }
 
 static void ttyport_write_flush(struct serdev_controller *ctrl)

-- 
2.55.0

