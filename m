Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC8E433041;
	Fri,  2 Oct 2026 07:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790926090; cv=none; b=O5cT97zZlJzJGUM5rVmTFB0VJk4lcOhkcRqGzEmrGwItssINon/ZvKGFrFioELYY/HJQbiEuwmJ95wATc9fBiEzNnjGnK+eBV/7ZYmAZ/31/F1JOqipRfwhaYDoOtkdW1GrFKEdHubWG8N54M9LC0oDGOhzmsqBdmxmjg2SNriA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790926090; c=relaxed/simple;
	bh=YpX4+5072Cz5bcYafYRHV43Mf/mG6zN/3qIGjFi54os=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=emsxn6Nsq++WSzpXYtspQjls2FmL4HwIsQXUgBc3mFcqcVG4V3PID75+NKXNpHwAah9GicmbHRVlw8A+VJnxiq0cV7Yluk50nJ4sQcLtpPiDcwmM0cWydlzvjVsHP61IO8+UlOd3IXy8NKBFoDvU9LPlNJvlPgEJM9yTD8E/C1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=itxXhBl1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="itxXhBl1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350531F000FF;
	Fri,  2 Oct 2026 07:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790926084;
	bh=7ncR0z0XZE0PryC/HJYmrm5CKarQVVxnnV5tCxdDkso=;
	h=From:To:Cc:Subject:Date;
	b=itxXhBl1DdZ1lu4TfQW7u+rrAfswYusGesLP9ilRGjr+/SPDBK/7HcaS9H5qPjrgi
	 UzSRTocTeVstlB404NY5ZnP9nA3zqfrAdzErK9WHkflQGu+alUS9CGyiXU2vvRq/vy
	 k+HO0DMtEn5RezGLIP/oBLu+a3O53UO4ZVePZ482UGVA9qvcdfiAzjVxmWYfcspE01
	 yzVHubHGLqvUEYRiqRuTIN/sRVOvN6psMAQRZbPJVJhjqhteQhOxk2u/F+iw7GzzLO
	 hJ0RznM+C7jmU44ei7/g/FOXLpt7X8vtncavf2uT10vvHJXQ36RLCgJx9s9AyajVYu
	 t3PRM5JmJ6Vog==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xCXgX-00000008egp-3eLQ;
	Fri, 02 Oct 2026 09:28:01 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] tty: add missing driver flag kernel-doc colon
Date: Fri,  2 Oct 2026 09:27:36 +0200
Message-ID: <20261002072736.2063004-1-johan@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A recent change adding a new TTY driver flag left out a colon required
for well-formed kernel-doc.

Fixes: 8df07fe93573 ("tty: fix saved termios reset race")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Link: https://lore.kernel.org/ec3a09d6-4ba4-41b8-abb1-b59e265f4532@infradead.org
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 include/linux/tty_driver.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
index 62e459c5d3ae..40ae3bb13e11 100644
--- a/include/linux/tty_driver.h
+++ b/include/linux/tty_driver.h
@@ -74,7 +74,7 @@ struct serial_struct;
  *	Do not create workqueue when tty_register_driver(). Whenever set, flip
  *	buffer workqueue can be set by tty_port_link_wq() for every port.
  *
- * @TTY_DRIVER_RESET_SAVED_TERMIOS
+ * @TTY_DRIVER_RESET_SAVED_TERMIOS:
  *	Reset any saved termios settings on device registration when reusing a
  *	minor number. Must only be set by drivers that guarantee that the minor
  *	number is no longer in use.
-- 
2.55.0

