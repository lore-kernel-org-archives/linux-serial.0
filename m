Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464C5190664;
	Tue, 24 Jun 2025 08:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750752414; cv=none; b=IqSlN5ICp5ZeyfMz0tpvP2c97qzm13EUa9weiL/ck1yC0hgJ8Ntw0ELl1Lfo+/ozDWPI/AA1u62KV8EgeqVgozyu9wdcwRIT4vKFynGdNfFCZ1gzgy5z5NAnEbEWlhdn7tGId1jdifTszjmQHWn3X98QTIaccFRKNXel1Dd6ES0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750752414; c=relaxed/simple;
	bh=rONZBqSu0G336QD6fdEcLUvwhyF4RivARlvQIYQaJu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LF66IqYHpw0R27vnJmRDyqs+/O2bIJF7AvtXgUgbSiR3QaTLtFLpsg5u3dJZMYc2S8O9dRCk5383zimZGVClb20ksRzDDfAK331fFI06hWb+947XFas26gfMBhu3w8wnrYDlP2AnUGppSfRzICxX/2J5oc9/oOGsjdY4Ms2TG7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/9oKIGy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/9oKIGy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D05EC4CEEF;
	Tue, 24 Jun 2025 08:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750752413;
	bh=rONZBqSu0G336QD6fdEcLUvwhyF4RivARlvQIYQaJu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G/9oKIGypl9sgF5wi0bI6DQWCsjBJW4+FlBDMK61TRiZyAz92va9RLWsu4sdbpB9X
	 b7/PNne8bE4qUL/cpttYo16r+fGTPKNYruANTu+nXoAd9p8+Wkdk+uy7zr6KMvY1oh
	 0PyTGm3+jhHFz6gEZOFMmVAQHRgS2CbLmS98RBy2wULZThNEXkVe4R2gZ3OSOhP5X7
	 Hw7EQc0F4iFxPWEic/GOvMuvRFHk/SYeZ5jax1PQczZqgT1sk4XwDx19xc6gTN9J2+
	 FmR1FaM5gjjQ/cGBzZVq3ItGp6DXEqvVhiSdlIWfRn3npU8KIT+j0SR+902vy1tLSc
	 xNnluErWJ81Cg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 5/5] tty: fix tty_port_tty_*hangup() kernel-doc
Date: Tue, 24 Jun 2025 10:06:41 +0200
Message-ID: <20250624080641.509959-6-jirislaby@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250624080641.509959-1-jirislaby@kernel.org>
References: <20250624080641.509959-1-jirislaby@kernel.org>
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
2.50.0

