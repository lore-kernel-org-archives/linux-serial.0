Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19C41FE44A;
	Mon, 23 Jun 2025 10:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750673570; cv=none; b=Ksfgp0LQuCzJPkId8NXvhOIi6dRNhxr5bBLTgFaP/uuVbcS4E/ZlE75IfCqJmyHDRGyZEVJ448WOqlBu8owcHvBzvnObEXr9n5bKmtk6K0VcJSKgQNfUe2e/r2Pm4TQ63pK8oLnZYb13Xz8ydQSyd3uvygh19U+swPg1+rHKm5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750673570; c=relaxed/simple;
	bh=hgfA/b06GuQR9iRfwkMjqHmGnydmJxYS9Q7Ri5B7ndY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X1Y6gXpqmOPJhksE+0i5MdaxIaGFeWpebSCbK7orhwo51wATeQlNx5v4ZnBR3jhfWKxYM/wByzJ/jJJsND0sInrx30by02jBOeGNZPkps6tpMzHsJUBKJZS/X2VMPXE4YKKH6HvXocKM4WWw+PsHq8/pHwdNlhuoD2fRN23pHic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTLE45Pw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTLE45Pw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129E1C4CEF0;
	Mon, 23 Jun 2025 10:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750673570;
	bh=hgfA/b06GuQR9iRfwkMjqHmGnydmJxYS9Q7Ri5B7ndY=;
	h=From:To:Cc:Subject:Date:From;
	b=pTLE45Pwy/7Ih/VF0V81Zobp/miUcMfOC6jgVBNwrlkUOZyQ9GsRhgcV/r90zXQ5g
	 wZtutyGP970xPoXjMfUssBBlvarwZkazUAeih6NkPGVCaiw60A2JN36r5Wh9gudwZU
	 UNrg4Oa6aLbu7wiFpSVci7h9F0QwMEh3shxe3y5PnXWXKOZpdRG9j/6QiSBvve2frq
	 mTCrqLm6nKgX+B/Gz282qB1FBZe/COHYsxzIXc3L0twUjQJ5TCzRffA/7xTUlL9KE4
	 l4zYVFwh/QljNNFmf+JjYWZwh+akLHO2M2zSczcyIfcF/kqzKSHGgtnFpZyfxaRWhO
	 h1rm8mRDn25Cw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 1/2] serial: ce4100: fix build after serial_in/out() changes
Date: Mon, 23 Jun 2025 12:12:45 +0200
Message-ID: <20250623101246.486866-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This x86_32 driver remain unnoticed, so after the commit below, the
compilation now fails with:
  arch/x86/platform/ce4100/ce4100.c:107:16: error: incompatible function pointer types assigning to '...' from '...'

To fix the error, convert also ce4100 to the new
uart_port::serial_{in,out}() types.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Fixes: fc9ceb501e38 ("serial: 8250: sanitize uart_port::serial_{in,out}() types")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202506190552.TqNasrC3-lkp@intel.com/
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/platform/ce4100/ce4100.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/platform/ce4100/ce4100.c b/arch/x86/platform/ce4100/ce4100.c
index f8126821a94d..f19d20f0dfa4 100644
--- a/arch/x86/platform/ce4100/ce4100.c
+++ b/arch/x86/platform/ce4100/ce4100.c
@@ -49,9 +49,9 @@ static unsigned int mem_serial_in(struct uart_port *p, int offset)
  * errata number 9 in Errata - B step.
 */
 
-static unsigned int ce4100_mem_serial_in(struct uart_port *p, int offset)
+static u32 ce4100_mem_serial_in(struct uart_port *p, unsigned int offset)
 {
-	unsigned int ret, ier, lsr;
+	u32 ret, ier, lsr;
 
 	if (offset == UART_IIR) {
 		offset = offset << p->regshift;
@@ -73,7 +73,7 @@ static unsigned int ce4100_mem_serial_in(struct uart_port *p, int offset)
 	return ret;
 }
 
-static void ce4100_mem_serial_out(struct uart_port *p, int offset, int value)
+static void ce4100_mem_serial_out(struct uart_port *p, unsigned int offset, u32 value)
 {
 	offset = offset << p->regshift;
 	writel(value, p->membase + offset);
-- 
2.50.0

