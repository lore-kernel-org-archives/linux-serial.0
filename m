Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECAA33DEFE;
	Wed, 19 Nov 2025 09:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763544310; cv=none; b=c2gE88goYgzCtaE6pNHBebPghBVvIAM38HqFUtPthziV6Rs2hnlg6e3ziZJ2Tt0tlfiOhrMUaZtP7ibSBXUPB9amHo6RMWAIf0ggcNEzvRNTmy2RQmDy/PmJrL9GoXQFf31aCC47Nsj+ymW1iofzOwUC/hFsJgctOKLYe1XIxvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763544310; c=relaxed/simple;
	bh=NRn1NfBgPUORdw8OpscMlXHnoEzm+3rzwpdJkyfa6GI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pf9uRJ+buPkzbsIvxRnXRMsCidnZhHP32yaDVnGdEc9Hak2qIRPQmHtGyC738twn3lpYmhPpRctpFrXzi1ItYKEQWYatp1J9cqYmcICGgzcxy28CmYs+n35wf1on0EJgcKHrAV7sn9e/e+PECPLw6uEh1NLuwUFUXu/IAZLH93M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaKZ4NH4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UaKZ4NH4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE5F7C2BC87;
	Wed, 19 Nov 2025 09:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763544309;
	bh=NRn1NfBgPUORdw8OpscMlXHnoEzm+3rzwpdJkyfa6GI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UaKZ4NH4TkUmZMnA6ih5P724uNcq7N5+sbDHpgNZrBXVdnNCdXoA/JMf2urvucgYL
	 Et9XAtK87rmijCu3qjWqC+opZF4FFeZadxsxlwlFuv5Vypa2vxwBxKb8dMYO5BDtQg
	 sNg6Pz6fimcJOIirrgMST1s+ntIGfUhSdvcjr6zrh5V2ktLc4d1csD3uOOnAFp4Z6T
	 7SEbXAqY866dzKuN/uMf19ur+ghWglfJ9EYufn9oIeV6p46Xe9vaQ6SYQIeWaHGS4e
	 azje1/Xr0M1MENe2RL4t0aLIcEUGYH5KcyDw35hE9+bT4MOXQDrc+zOvxRyuofvjYl
	 BbZ41QCpi4mag==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 4/6] serial: 8250: move skip_txen_test to core
Date: Wed, 19 Nov 2025 10:24:55 +0100
Message-ID: <20251119092457.826789-5-jirislaby@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251119092457.826789-1-jirislaby@kernel.org>
References: <20251119092457.826789-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

8250_core is the only place where skip_txen_test is used. And platform
and core end up in 8250.ko, so there is no change in module name (param
prefix). Therefore, move skip_txen_test there and make it local.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/8250/8250.h          | 1 -
 drivers/tty/serial/8250/8250_core.c     | 4 ++++
 drivers/tty/serial/8250/8250_platform.c | 5 -----
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 58e64c4e1e3a..d8a726b355d5 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -105,7 +105,6 @@ extern unsigned int nr_uarts;
 #endif
 
 extern unsigned int share_irqs;
-extern unsigned int skip_txen_test;
 
 #define SERIAL8250_PORT_FLAGS(_base, _irq, _flags)		\
 	{							\
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index bfa421ab3253..0e81f78c6063 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -52,6 +52,10 @@ struct irq_info {
 static DEFINE_HASHTABLE(irq_lists, IRQ_HASH_BITS);
 static DEFINE_MUTEX(hash_mutex);	/* Used to walk the hash */
 
+static bool skip_txen_test;
+module_param(skip_txen_test, bool, 0644);
+MODULE_PARM_DESC(skip_txen_test, "Skip checking for the TXEN bug at init time");
+
 /*
  * This is the serial driver's interrupt routine.
  *
diff --git a/drivers/tty/serial/8250/8250_platform.c b/drivers/tty/serial/8250/8250_platform.c
index 38b158ec4725..6f09416d4107 100644
--- a/drivers/tty/serial/8250/8250_platform.c
+++ b/drivers/tty/serial/8250/8250_platform.c
@@ -29,10 +29,8 @@
  * Configuration:
  * share_irqs:     Whether we pass IRQF_SHARED to request_irq().
  *                 This option is unsafe when used on edge-triggered interrupts.
- * skip_txen_test: Force skip of txen test at init time.
  */
 unsigned int share_irqs = SERIAL8250_SHARE_IRQS;
-unsigned int skip_txen_test;
 
 unsigned int nr_uarts = CONFIG_SERIAL_8250_RUNTIME_UARTS;
 
@@ -386,7 +384,4 @@ MODULE_PARM_DESC(share_irqs, "Share IRQs with other non-8250/16x50 devices (unsa
 module_param(nr_uarts, uint, 0644);
 MODULE_PARM_DESC(nr_uarts, "Maximum number of UARTs supported. (1-" __MODULE_STRING(CONFIG_SERIAL_8250_NR_UARTS) ")");
 
-module_param(skip_txen_test, uint, 0644);
-MODULE_PARM_DESC(skip_txen_test, "Skip checking for the TXEN bug at init time");
-
 MODULE_ALIAS_CHARDEV_MAJOR(TTY_MAJOR);
-- 
2.51.1

