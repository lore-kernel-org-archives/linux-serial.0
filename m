Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D70E23EA9B;
	Sat, 10 Jan 2026 23:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768087614; cv=none; b=p6kLNGf3eDnEsewBWEspGreorGiUqRKeIrl8aYroViPSHe1hHo7oari7CfnpBjxcz5S1gtrTXYdLg+GI4wmTa60Q15FYsZDKPtT4echcEMlFQFJBJlgt2wlqtZ/nAZg1WPhX8CFxQ2IL9xdsGRwfg7b+1/MYk89l3Sl+G8HnJaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768087614; c=relaxed/simple;
	bh=15BWXFeMSMIh6w661ix/FbNONx1QYCGdtYtG2EPQ5Q0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TZn7DtHJiukU6dDWfTn/kTEdvYZdz382ysDdWArmhkxlVSgsRb3lgk/nuYWo+w4wERl1rnlHupdCSkpJq6D1COn9n/r93YuEUlVQBHtaqyPbAdG8n3GTwdh6pypTLn0V/I4nLGnb8xRVqom3bgptUC47ccyVpTL4f6u5gv1VYUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=feoAPe8t; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="feoAPe8t"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=spkX88AB1ItPY7AAUri8iKAK/0QnhYU30lyjDwyqRQI=; b=feoAPe8tl8UFGM+3daoVIShonV
	+Ll/YTZRkFig5oj1euVSDaZqB4OtUJwxdTrTaVtLGN1QQc55qI/jX+FHsgXtuoBscyY5cb0AG/Lgn
	+5px+IEnJkVxMFldphWHWpUef0alyjP9fF7yZzvYCP2kVmHCMJYUjv4zMxo81xp2tuBOfa/GhPx+K
	v5ZnboXgO/vpMixp10tTn/A6NLzdGeK8e5OYy3r7gHBXEuWst1NacrS02ZQA1rBWOiL+LKvznFiku
	LeNb1YqJXu8IWlwkiTN6stG4k6LipvAZA7kVOk9ejpuobc6PwKkTRlt5PoA7Qiit1TJ9rsHLfUXJy
	/2G/Sxcg==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1veiM1-00000003lbk-3qMR;
	Sat, 10 Jan 2026 23:26:45 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-serial@vger.kernel.org
Subject: [PATCH 4/4 v2] serial: SH_SCI: improve "DMA support" prompt
Date: Sat, 10 Jan 2026 15:26:43 -0800
Message-ID: <20260110232643.3533351-5-rdunlap@infradead.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260110232643.3533351-1-rdunlap@infradead.org>
References: <20260110232643.3533351-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Having a prompt of "DMA support" suddenly appear during a
"make oldconfig" can be confusing. Add a little helpful text to
the prompt message.

Fixes: 73a19e4c0301 ("serial: sh-sci: Add DMA support.")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
v2: make the prompt more like the other SH_SCI prompts (Geert)

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-serial@vger.kernel.org

 drivers/tty/serial/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20260109.orig/drivers/tty/serial/Kconfig
+++ linux-next-20260109/drivers/tty/serial/Kconfig
@@ -671,7 +671,7 @@ config SERIAL_SH_SCI_EARLYCON
 	default ARCH_RENESAS
 
 config SERIAL_SH_SCI_DMA
-	bool "DMA support" if EXPERT
+	bool "Support for DMA on SuperH SCI(F)" if EXPERT
 	depends on SERIAL_SH_SCI && DMA_ENGINE
 	default ARCH_RENESAS
 
