Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E239265CCD;
	Thu, 14 Aug 2025 07:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755156315; cv=none; b=bfT1hpZ1azhyD+u1etFJx3Pf6m3Ctfk4JcnvcHUVwt2W0aBPjDoAI3Qwy65ZSEQuWRlQtArU02HFgobVhbR/gh6/DA4ezVQY17TNIwwuVBQBW7OP+76VFCt8RcFEckMqWcIFWRkN9m6XckxNITB/K7TyxMOXg+Ht8l0U8CzFT/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755156315; c=relaxed/simple;
	bh=KLx6NVm+RmsxH/8u32u5hO7DHm5qurcEHVq9Jk6noOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q7wfkhSSN2P3KbsktUZ8N901+7PhvwhDWFIgRwg4NKtDWukNmQz5nG1Wd8MWX8etk4gNXlOjzrtjXl9YD1RbUTHcbx7t90tCT/Zs7rO7z3AnwGILJnLcw9XspjwzyL/nEs71AsCgIM+qK+CtvlMvvwFq1ECiy1meMBqlbSaj/ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFrrccDj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFrrccDj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3D3C4CEF4;
	Thu, 14 Aug 2025 07:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755156314;
	bh=KLx6NVm+RmsxH/8u32u5hO7DHm5qurcEHVq9Jk6noOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oFrrccDjAgCxWNWxnqt5H6NjAflfYZwFw14K7QjljioU3ldS1RB7CH+L4iw3aCDsu
	 Go4QTKSgfIypvnl0BJUObgcM5gUhChu2t4/G4fogllAuwZ7vIHtaCDlhcl1WboGiuG
	 5F5Z9qRgTKt0pm7tHns35NTvEL1Jqa2fpz8kc9lNlrHy/+zLzepoNxz5sKlaaRuo2H
	 tI4n3xXJi7xjfOYqiFL3l14MNtVMrT0kVZ1cBani5qvbebjb1ETqyUpvxvg4eC1ySi
	 I8Fsu50tdiHnsQf1PAKSb/zGFruxxcfxSzkBLrlUk1z5Jg1E1fMBoA/sVu2KT9kk0R
	 n895xjgLbZHdA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 10/16] serial: 8250_core: use guard() in serial_unlink_irq_chain()
Date: Thu, 14 Aug 2025 09:24:50 +0200
Message-ID: <20250814072456.182853-11-jirislaby@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814072456.182853-1-jirislaby@kernel.org>
References: <20250814072456.182853-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Having all the new guards, use them in the 8250 code. This improves
readability, makes error handling easier, and marks locked portions of
code explicit.

serial_unlink_irq_chain() is done separately here because with the
guard() used, those BUG_ON()s can be switched WARN_ON()s as we can
actually handle the conditions and return (despite something went really
wrong).

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/8250/8250_core.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 82c3636451e5..7d931693b311 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -178,20 +178,22 @@ static void serial_unlink_irq_chain(struct uart_8250_port *up)
 {
 	struct irq_info *i;
 
-	mutex_lock(&hash_mutex);
+	guard(mutex)(&hash_mutex);
 
 	hash_for_each_possible(irq_lists, i, node, up->port.irq)
-		if (i->irq == up->port.irq)
-			break;
+		if (i->irq == up->port.irq) {
+			if (WARN_ON(i->head == NULL))
+				return;
 
-	BUG_ON(i == NULL);
-	BUG_ON(i->head == NULL);
+			if (list_empty(i->head))
+				free_irq(up->port.irq, i);
 
-	if (list_empty(i->head))
-		free_irq(up->port.irq, i);
+			serial_do_unlink(i, up);
+
+			return;
+		}
 
-	serial_do_unlink(i, up);
-	mutex_unlock(&hash_mutex);
+	WARN_ON(1);
 }
 
 /*
-- 
2.50.1

