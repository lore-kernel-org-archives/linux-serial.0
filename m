Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49ECB1624D5;
	Thu,  1 Oct 2026 19:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790882445; cv=none; b=o61PUJhim0wgnRwho1QzcnLxc8tI+Ng1FBRQxLnvOMWXvHH9WJcK+6XzzYa8u6S3rD4U1f6c1SWRLAlMe+5eE0/IVurP8YPO5m3Oq9mgZo/rBO3QcwJ3Be97YyRIaCgQiN8WiP2kl4ObIRQpkxMXdqNUZJ1DQY87o/z6DCCaSZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790882445; c=relaxed/simple;
	bh=TSwMD8nl+PjPuPRpFSzmLP1DTG8nZBaUE/WJp6oCTwM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SR3QJ58yxTxfRHJux47d2uv3wNgxNmYsCHYwHK1pcRDmSUzAxfuoIS5TeCJ2TYj2L9vAhS2/Qm0gsKtsBXIQ0gf9U4TIJTTftMlQ6LvGR+vaMx2SgFb4QF3fwo0Wv5LpQZvoe6+0s0Ikl42zzX5oFIweUMr1/0vEGplZbn51D5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5YSQrqj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5YSQrqj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D681F000FF;
	Thu,  1 Oct 2026 19:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790882443;
	bh=YoRRWwHHrdSAn0vKfcey2RKMKMtPzjTI79hJWIRNUQY=;
	h=From:To:Cc:Subject:Date;
	b=R5YSQrqjd1zN93EbJst8Dcm7q5HHCAqWPG3E3vZg97rYAHUkyNi7ApWf7MWs72Jkg
	 2gS8MtzeSYUSdkSjGCR9bU5Az0VuCHCzUd5YiMSo5bkKqfp+vPIi8KGVRxy2wSusTB
	 OTLHLkwZhUFqPihbT6yNsw+ADsPu8SANczcXsaBgh3a86qveBZ1SCGeRDD9ka5SegM
	 UzUJzjRd5Z6wTLh/Vm1MUaNL/qNCwr2dpUMHmILGp0FO/+CizcaymIh4V+vVoEqjPy
	 6CiqlhHwkqoUggk83ecrZYAgYPPX18XVZ0w/EMoyFSsGewykQxF2iVWA7gS6vR2hWO
	 ce0tDZhSm+G3A==
From: Imre Kaloz <kaloz@kernel.org>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v2] MIPS: SGI-IP27: print the NMI dump on an nbcon console
Date: Thu,  1 Oct 2026 21:19:38 +0200
Message-ID: <20261001191938.3256-1-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the 8250 console became nbcon, printk() in nmi_dump() only queues
records for a printer thread that never runs, as no CPU leaves the NMI
handler. Print from an emergency section and flush pending records
before the hub reset.

Fixes: d3539347022a ("serial: 8250: Switch to nbcon console, take 2")
Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
v2: flush pending records before the hub reset (John Ogness)
v1: https://lore.kernel.org/all/20261001155013.1694-1-kaloz@kernel.org/

This conflicts by context with patch 14/38 of the IP35 series,
https://lore.kernel.org/all/76f2a9c32eba23de36817f0a186def01e009e1c7.1790857966.git.kaloz@kernel.org/
which rewrites the reset write. Whichever lands second places the
printk_trigger_flush() call above the system_is_ip35 branch.

 arch/mips/sgi-ip27/ip27-nmi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/mips/sgi-ip27/ip27-nmi.c b/arch/mips/sgi-ip27/ip27-nmi.c
index fc2816398d0c..c502982621e6 100644
--- a/arch/mips/sgi-ip27/ip27-nmi.c
+++ b/arch/mips/sgi-ip27/ip27-nmi.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/console.h>
 #include <linux/kernel.h>
 #include <linux/mmzone.h>
 #include <linux/nodemask.h>
@@ -183,6 +184,12 @@ static void nmi_dump(void)
 	 */
 	arch_spin_lock(&nmi_lock);
 
+	/*
+	 * No CPU leaves the NMI handler before the hub reset below, so an
+	 * nbcon console's printer thread would never print the dump.
+	 */
+	nbcon_cpu_emergency_enter();
+
 #ifdef REAL_NMI_SIGNAL
 	/*
 	 * Wait up to 15 seconds for the other cpus to respond to the NMI.
@@ -227,5 +234,6 @@ static void nmi_dump(void)
 	 * Save the nmi cpu registers for all cpu in the eframe format.
 	 */
 	nmi_eframes_save();
+	printk_trigger_flush();
 	LOCAL_HUB_S(NI_PORT_RESET, NPR_PORTRESET | NPR_LOCALRESET);
 }
-- 
2.47.3

