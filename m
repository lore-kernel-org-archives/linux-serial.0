Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066A43D3D11;
	Thu,  1 Oct 2026 15:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869880; cv=none; b=EmQx5eL0/W1JiBpgj1pCooVGSEM0cYBK9unbms0AZEil38hljCw3u3DlFbEvfNBEMW+Enddm2r+GJr++xGWdgAR2i3mndO9ehk11e2ZzG8xwE7bcY5JA/Ccd5eJ0rPEfzQNDEJKlovRoXtsjjenWtV3hXLGkMv87qvtuD7DXMmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869880; c=relaxed/simple;
	bh=Yuns9E3KGms7wb6PGVNm+5IOEbxvimzMSkyBzHlrIYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sC/O5YNk+bTzZvxBeF/MfK+xTHfBfSH4jt4EeVXKPLF5pTYCTV6LSh4AIOrJ3x0I7MLW01hvwaUIWtLL5/5aAsO4SlNFH8529HTZDFL4Crfn5OhDQaBueAvKUIVzxihfRrJmaBz3PyWIAIIn5KeUk/psX2agGO4oSqZwvqTDbrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRppxj+A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRppxj+A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD9C1F000FF;
	Thu,  1 Oct 2026 15:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790869878;
	bh=AxqsiyUPL1aYVcbhtVljXtqmVoFslqYIIISj4vvWajQ=;
	h=From:To:Cc:Subject:Date;
	b=nRppxj+ARHSCEFtpxg/6LQ2559dxVxm1gkPfC1jGLlE05TYQma64unYjONJo5s2tL
	 srI7d4ksafVup+0H67yRNfBujbZIyfJdvqeUFT52jR28N7QFP4sTNlhdPsLdkIufIr
	 5hj586lygtZnGCp28vRYhHpmREdBtM9wLO3GrANrt9Mx0vmfS0bj38Fu032G18Ph03
	 ZqpbcrLOUk7krzonqZEYIxh5Q8M6BIq5vV3gfl+tEdRSTC8hK8bNkuoNC22c8B8qY3
	 DHE44DlnHHLNU9CYvBiozQasQoQZuP1T7sKe6E2WWeTo0549I/UU8VYrBwBRc2E4SZ
	 uYXi2fpWU6MNg==
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
Subject: [PATCH] MIPS: SGI-IP27: print the NMI dump on an nbcon console
Date: Thu,  1 Oct 2026 17:50:13 +0200
Message-ID: <20261001155013.1694-1-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the 8250 console became nbcon, printk() in nmi_dump() only queues
records for the printer thread, which never runs because no CPU leaves
the NMI handler before the hub reset. Print the dump from an emergency
section.

Fixes: d3539347022a ("serial: 8250: Switch to nbcon console, take 2")
Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
 arch/mips/sgi-ip27/ip27-nmi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/mips/sgi-ip27/ip27-nmi.c b/arch/mips/sgi-ip27/ip27-nmi.c
index fc2816398d0c..4447c0bec8b4 100644
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

base-commit: 5dd1818b15d98d4a20806cd00b1b40320b06004f
-- 
2.47.3

