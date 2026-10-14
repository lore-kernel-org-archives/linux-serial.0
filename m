Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975A52459CF;
	Wed, 14 Oct 2026 14:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791988277; cv=none; b=eyBfbEnyLnkzJ23Rb3Kd+/skdLQ2gDMO/3A9OJcxg2OCn2GPPqrsgs5QCBT3IwHf9OWBicUsD1KBBJDeEu+MRCMYuxa1Q7jk/PCAfnHAfG7pQTWxCN2BmxxwrgQ2EbTWwUP3rokgWNsKUkuLXE94z9ZO6SHdSSyJbltkdehQRd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791988277; c=relaxed/simple;
	bh=2QGMjq7cqQGN5ZOMdtwsCxDpXoG9ti4blKQA6vN6xWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p6zWX0ajpvZQLLQCYsD3TjSOterEurn+CgjU5VRMsCBr3OLd+2Adqa2e1HqWtg1zpFijwPl89rkyud4JXVzcKpXMoi060J6lenXHYcZ2tpUwB8IxS5hE4WAsXr00yWqcca3QsBPSBDYVsNQbI1snrHNs7f1zinM4OVZO8a340ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmFNnxef; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmFNnxef"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D231F000C4;
	Wed, 14 Oct 2026 14:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791988275;
	bh=mzTil1Gx9UHaAA1B16T6Pa/81wdFn2t2SBA8UJdng/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KmFNnxef2EwugCajAIvZygKzxX+Re9csd+RSdhkJwCYVppoDHEFl0NG2gpQ+nJN6k
	 ix4k/RVQao3vRVHosuqJTlJmqTjYr9CtrwH7lEZEXSFXxU9Rk1t0yNRsspAe6ynxRQ
	 QONjeJ3aZd7RwCSEC/ubY0frtxGtt6C684CSxxsk7IdWkqilzTWn4HqDFt57Mc97vR
	 3GpBcZ+wLHmYScvr4nV+1y5WXFD55FO3XOc3iqUbFObDGQVvXz2oc8V/0vp3dT67Jh
	 SuzEQk/WNs7T/SEwctwgmzaGZy88kDuhd5nB0on3dQBUKjGuNUAww5bKUvp2ESFyjT
	 ZLWJjJ31PRwwA==
From: Thorsten Blum <blum@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: Thorsten Blum <blum@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH 2/2] serial: earlycon: Use isdigit() in earlycon_init()
Date: Wed, 14 Oct 2026 16:30:33 +0200
Message-ID: <20261014143034.104950-4-blum@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261014143034.104950-3-blum@kernel.org>
References: <20261014143034.104950-3-blum@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1131; i=blum@kernel.org; h=from:subject; bh=2QGMjq7cqQGN5ZOMdtwsCxDpXoG9ti4blKQA6vN6xWA=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFnnJyk87O8I0Ws7+ZTL/2yBkXBRQM/BI3+Wfle/4ndt8 V3xqF9rOkpYGMS4GGTFFFkezPoxw7e0pnKTScROmDmsTCBDGLg4BWAikkwMP95OjXxwZ/bLwoKH 9vf2rRGyuV4TM1UkZFJl4YU7azi8Mhj+KYusO7X0qZvzf/X+uB02xRNrHwZwGL0ItPO643M5zCK PGQA=
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

Use isdigit() and a while loop to simplify the backward scan.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 drivers/tty/serial/earlycon.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index ce740cdc7ceb..05d99ec6e709 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -11,6 +11,7 @@
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
 #include <linux/console.h>
+#include <linux/ctype.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
@@ -59,11 +60,10 @@ static void __init earlycon_init(struct earlycon_device *device,
 	const char *s;
 	size_t len;
 
-	/* scan backwards from end of string for first non-numeral */
-	for (s = name + strlen(name);
-	     s > name && s[-1] >= '0' && s[-1] <= '9';
-	     s--)
-		;
+	/* Scan backwards to split the trailing index from the console name. */
+	s = name + strlen(name);
+	while (s > name && isdigit(s[-1]))
+		s--;
 	if (*s)
 		earlycon->index = simple_strtoul(s, NULL, 10);
 	len = s - name;
