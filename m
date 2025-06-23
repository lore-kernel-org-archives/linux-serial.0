Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0A8376;
	Mon, 23 Jun 2025 07:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750664778; cv=none; b=fRyxFeUnFlkl11vPcjZX7TPxUnS3h0IYw9H3xfp5Vqi4ZFNkUHwhW4RuFcgMh9WR0GRvjubP3E7KB8CcmlM0gWI/wbkRHE93aHNTL2UavuGl1LSer/DCJFazd82XiBIwcj0e4tPQTUOsigtYrKquX8dboav/+AKiO5nyC5i1Ye8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750664778; c=relaxed/simple;
	bh=+Uu7ZDBV8otT4ly3/z72aeMoH2gzzQm99pYq+sIxM2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F93B18YQB6aI/MMa68IFkR0yvy4moSNGunejaeCeMSEH8m3gTcY+0mjLi7qcOu4ob5t1Kokdo6kRgQP8bU/Cru5LIk8fS6uSaUrZssDndLSOLSFgB85QnVLZBr6vSqtSm7H9MiDjvs+hnhAzops8oRweN/WRfTpQKRWKOcji4NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YaTiHsmx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YaTiHsmx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A964C4CEF1;
	Mon, 23 Jun 2025 07:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750664777;
	bh=+Uu7ZDBV8otT4ly3/z72aeMoH2gzzQm99pYq+sIxM2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YaTiHsmx9fcU1jHFGTUE/P7l3uItgMpvwlksKjUK53q1DIR4RLx3wMKNmRozrrruh
	 kaVvWaOA0dUwrWOAfsrKQ8u+SShD72545UAh7cJNWDEI9KlJ19fctj26riZvz6dd3j
	 8eZMzSAQ1WtC+ZrCF+l/JA5EHP2ZhyqS6Al4tEb5IUooUo49FwEABwK04ZSCFvksp8
	 fyJlgW1iyyVhgZEgvtD2WcVMop7HBcjKfQrxXXI7FcHBH6Vxpvv/tBD4bf5bR6hxZP
	 Ny3zUE2QLzOX6G8Ht4fQTWzUKIjKrD6PIUm7mzzM3GsBtg0axOO9fjjIYa9aln1Tou
	 gmsqITgESetxQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: [PATCH 5/5] tty: fix tty_port_tty_*hangup() kernel-doc
Date: Mon, 23 Jun 2025 09:46:06 +0200
Message-ID: <20250623074606.456532-6-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623074606.456532-1-jirislaby@kernel.org>
References: <20250623074606.456532-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The commit below added a new helper, but omitted to move (and add) the
corressponding kernel-doc. Do it now.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Fixes: 2b5eac0f8c6e ("tty: introduce and use tty_port_tty_vhangup() helper")
Link: https://lore.kernel.org/all/b23d566c-09dc-7374-cc87-0ad4660e8b2e@linux.intel.com/
Reported-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/driver-api/tty/tty_port.rst | 5 +++--
 drivers/tty/tty_port.c                    | 5 -----
 include/linux/tty_port.h                  | 9 +++++++++
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/Documentation/driver-api/tty/tty_port.rst b/Documentation/driver-api/tty/tty_port.rst
index 5cb90e954fcf..504a353f2682 100644
--- a/Documentation/driver-api/tty/tty_port.rst
+++ b/Documentation/driver-api/tty/tty_port.rst
@@ -42,9 +42,10 @@ TTY Refcounting
 TTY Helpers
 -----------
 
+.. kernel-doc::  include/linux/tty_port.h
+   :identifiers: tty_port_tty_hangup tty_port_tty_vhangup
 .. kernel-doc::  drivers/tty/tty_port.c
-   :identifiers: tty_port_tty_hangup tty_port_tty_wakeup
-
+   :identifiers: tty_port_tty_wakeup
 
 Modem Signals
 -------------
diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 903eebdbe12d..5b4d5fb99a59 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -391,11 +391,6 @@ void tty_port_hangup(struct tty_port *port)
 }
 EXPORT_SYMBOL(tty_port_hangup);
 
-/**
- * tty_port_tty_hangup - helper to hang up a tty
- * @port: tty port
- * @check_clocal: hang only ttys with %CLOCAL unset?
- */
 void __tty_port_tty_hangup(struct tty_port *port, bool check_clocal, bool async)
 {
 	struct tty_struct *tty = tty_port_tty_get(port);
diff --git a/include/linux/tty_port.h b/include/linux/tty_port.h
index 021f9a8415c0..332ddb93603e 100644
--- a/include/linux/tty_port.h
+++ b/include/linux/tty_port.h
@@ -251,11 +251,20 @@ static inline int tty_port_users(struct tty_port *port)
 	return port->count + port->blocked_open;
 }
 
+/**
+ * tty_port_tty_hangup - helper to hang up a tty asynchronously
+ * @port: tty port
+ * @check_clocal: hang only ttys with %CLOCAL unset?
+ */
 static inline void tty_port_tty_hangup(struct tty_port *port, bool check_clocal)
 {
 	__tty_port_tty_hangup(port, check_clocal, true);
 }
 
+/**
+ * tty_port_tty_vhangup - helper to hang up a tty synchronously
+ * @port: tty port
+ */
 static inline void tty_port_tty_vhangup(struct tty_port *port)
 {
 	__tty_port_tty_hangup(port, false, false);
-- 
2.49.0

