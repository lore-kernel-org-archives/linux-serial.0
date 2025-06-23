Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0356D23A9BE;
	Mon, 23 Jun 2025 10:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750673573; cv=none; b=HZIHwqfOQ7/ujo3MIu3VAsv6GqWUE3451/7mjjJWjIvgTzZ6GDXRTR1hqVxbDz7dzOmC4SlZVNo1A9SWkitg82XqnyS+ZDUzFJU38Nn6kbgg9YKHPIbfZvI1cH5gVGl+VPdoXIy46GmNVJbB+RZyYFortwxPUx0/alwBGhh8OrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750673573; c=relaxed/simple;
	bh=EpFFplIt00ij91D3qC5Z0NcMfeDRE0WklzeKPrVl3gU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SHgz9qVnogJBfPtve3HkFWWVTGmYCTanqjsXeAzS2sqro1fKtytbJcA78/4TmmtCBLg5kMp0ZhGmWPYroYTRx1uaIndRU1ggXaj4vrk4gk7FLiTYinCfqacwrIu1sOPtoYLKcN2WbxlErTrjOarXDnQiQ3rXwAM8LUu6RmrY7jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u5x4JTW2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u5x4JTW2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A2AC4CEF2;
	Mon, 23 Jun 2025 10:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750673572;
	bh=EpFFplIt00ij91D3qC5Z0NcMfeDRE0WklzeKPrVl3gU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u5x4JTW2TeLdedqA7js41rhEFsB2zXXUvhcRBnrtHLlWf0G9YNUwbdBupXiFcZ/tZ
	 xKX/BMGiheDK6VJjUTbmQv4shu1mRgxG6acqrYtF7V3tgRNj/1SvWVOAFSG83eoDbP
	 MokfoP6fzR7cnBhqAxuM0rxaFaoVdEXXLK9h/gFHLXLZX0BZaYPlzZ+xLB5WMZEX7o
	 FHyd2fctg+10B+XbtWU98I6uZs/KNEDr7kb/MA+VF/bnUfIvLcNNgP9+/BViQN7mPg
	 /kPwILfeafyULLQl3YVrSxOZ93LFl9N95HWzEV0kCyOfqyl+7LQHKFZ3YqJ/0GJA4h
	 zfWK+S1HyzBzg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 2/2] serial: ce4100: clean up serial_in/out() hooks
Date: Mon, 23 Jun 2025 12:12:46 +0200
Message-ID: <20250623101246.486866-2-jirislaby@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623101246.486866-1-jirislaby@kernel.org>
References: <20250623101246.486866-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ce4100_mem_serial_in() unnecessarily contains 4 nested 'if's. That makes
the code hard to follow. Invert the conditions and return early if the
particular conditions do not hold.

And use "<<=" for shifting the offset in both of the hooks.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/platform/ce4100/ce4100.c | 39 +++++++++++++++++--------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/arch/x86/platform/ce4100/ce4100.c b/arch/x86/platform/ce4100/ce4100.c
index f19d20f0dfa4..08492bea9713 100644
--- a/arch/x86/platform/ce4100/ce4100.c
+++ b/arch/x86/platform/ce4100/ce4100.c
@@ -53,29 +53,32 @@ static u32 ce4100_mem_serial_in(struct uart_port *p, unsigned int offset)
 {
 	u32 ret, ier, lsr;
 
-	if (offset == UART_IIR) {
-		offset = offset << p->regshift;
-		ret = readl(p->membase + offset);
-		if (ret & UART_IIR_NO_INT) {
-			/* see if the TX interrupt should have really set */
-			ier = mem_serial_in(p, UART_IER);
-			/* see if the UART's XMIT interrupt is enabled */
-			if (ier & UART_IER_THRI) {
-				lsr = mem_serial_in(p, UART_LSR);
-				/* now check to see if the UART should be
-				   generating an interrupt (but isn't) */
-				if (lsr & (UART_LSR_THRE | UART_LSR_TEMT))
-					ret &= ~UART_IIR_NO_INT;
-			}
-		}
-	} else
-		ret =  mem_serial_in(p, offset);
+	if (offset != UART_IIR)
+		return mem_serial_in(p, offset);
+
+	offset <<= p->regshift;
+
+	ret = readl(p->membase + offset);
+	if (!(ret & UART_IIR_NO_INT))
+		return ret;
+
+	/* see if the TX interrupt should have really set */
+	ier = mem_serial_in(p, UART_IER);
+	/* see if the UART's XMIT interrupt is enabled */
+	if (!(ier & UART_IER_THRI))
+		return ret;
+
+	lsr = mem_serial_in(p, UART_LSR);
+	/* now check to see if the UART should be generating an interrupt (but isn't) */
+	if (lsr & (UART_LSR_THRE | UART_LSR_TEMT))
+		ret &= ~UART_IIR_NO_INT;
+
 	return ret;
 }
 
 static void ce4100_mem_serial_out(struct uart_port *p, unsigned int offset, u32 value)
 {
-	offset = offset << p->regshift;
+	offset <<= p->regshift;
 	writel(value, p->membase + offset);
 }
 
-- 
2.50.0

