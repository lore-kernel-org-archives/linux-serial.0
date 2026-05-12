Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D3B3E1736;
	Tue, 12 May 2026 13:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778593597; cv=none; b=o8lr+u4z7aJIfxDFFyXEqDppbncr3SWwnBZ/8hOOXnzMRHiDFc7rwFBMHjgl7DYdtAWJLCeVfVTaYVQ7k83AFo3OYKHEFoQ7OSSAUnVR4BMtNmGvgO0kgXfokFshPAl2CW0S20U+MogLWeowFw7O6sUMIByCtZa/g0UTnRAFSUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778593597; c=relaxed/simple;
	bh=cuWMSsUlc2lCcUTutxW89kagkofY7NkL4XjmQE+73Uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sEDI0HkzOh3TAY/HbUqbqovb4LhWO9WSaU2LJqsNVJz34U2oa7S0Ld/4QUiq+5wCeACz3Ecdxm9hW4/EcB7u+/msQ1qQle6XWp6xEyqwZHN10E9XVTrW9vrBQR5TDb0O00XZNe0Rm5SzXf6q8SqEVKX0irjgC9BR/CNyYyoTZ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=Rwc24TgV; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="Rwc24TgV"
Received: from Gigabyte.tail209581.ts.net (unknown [IPv6:2a02:8428:7df0:ac01:fbfd:168d:553c:3eec])
	(Authenticated sender: jnilo@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id DD96C780513;
	Tue, 12 May 2026 15:46:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1778593593;
	bh=cuWMSsUlc2lCcUTutxW89kagkofY7NkL4XjmQE+73Uo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rwc24TgVdSF/BtT+qR8X8lc/YgmhpP/mRClmF0Jxz4T3JHK1KGjqComY3CAj6fsfb
	 wONhcxGC2589UxRaALXL8H0j87asEhjmfdzrGWm6mgRnYLm7f9aOgcBrAbi7D89Qeq
	 l5gVHkYgPDX+ZNsE2kpgC9Ot93tlkiW3yFlrNp3uUsR5vSZ3hQa5TUp3PucQJaGQ/2
	 A7nxxMIYpFzorXja2o4dS2kPpyWnXvX+JfY7d0DKLVPzCM2qA019kilb+Kr9FOjRfa
	 iN/FjjrJ61Ua7RLHGLzt5LXYgzdoQNNW9YWlspoqZxoXW6bS01qbs+T8tkj8tDISiR
	 3wyfvgjYK4vjQ==
From: Jacques Nilo <jnilo@free.fr>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Johan Hovold <johan@kernel.org>,
	Jacques Nilo <jnilo@free.fr>
Subject: [PATCH 1/3] serial: core: introduce guard(uart_port_lock_sysrq_irqsave)
Date: Tue, 12 May 2026 15:46:12 +0200
Message-ID: <b65b5237542c1c1c694a20e9d8fd0e18434a82b9.1778592805.git.jnilo@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1778592805.git.jnilo@free.fr>
References: <5efe9e03-4d86-43a0-9ec2-e610ff31095d@free.fr> <cover.1778592805.git.jnilo@free.fr>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

uart_handle_break() and uart_prepare_sysrq_char() (in
include/linux/serial_core.h) capture a SysRq character into
port->sysrq_ch while the port lock is held and rely on the unlock
helper -- uart_unlock_and_check_sysrq_irqrestore() -- to dispatch the
captured character to handle_sysrq() on scope exit.

The existing guard(uart_port_lock_irqsave) cannot be used by IRQ
handlers that process RX, because its destructor calls plain
uart_port_unlock_irqrestore() and silently drops port->sysrq_ch.

Add a dedicated guard variant whose destructor is the sysrq-aware
unlock helper. Callers that may capture SysRq characters opt in by
using guard(uart_port_lock_sysrq_irqsave); the existing
uart_port_lock_irqsave guard keeps its current plain-unlock semantics
for the many callers that do not process RX.

The lock side is identical to uart_port_lock_irqsave -- only the
unlock-time behaviour differs. Naming mirrors
uart_unlock_and_check_sysrq_irqrestore() (sysrq before irqsave/irqrestore).

The new macro is placed after the CONFIG_MAGIC_SYSRQ_SERIAL block so
both definitions of uart_unlock_and_check_sysrq_irqrestore() (sysrq
enabled and disabled) are visible at expansion time. When
CONFIG_MAGIC_SYSRQ_SERIAL=n the destructor degenerates to plain
uart_port_unlock_irqrestore(), so there is no overhead.

No functional change on its own; users are converted in the following
patches.

Signed-off-by: Jacques Nilo <jnilo@free.fr>
---
 include/linux/serial_core.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 4f7bbdd90..4fa079dc9 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -1286,6 +1286,19 @@ static inline void uart_unlock_and_check_sysrq_irqrestore(struct uart_port *port
 }
 #endif	/* CONFIG_MAGIC_SYSRQ_SERIAL */
 
+/*
+ * Variant of guard(uart_port_lock_irqsave) for IRQ handlers that may capture
+ * a SysRq character via uart_prepare_sysrq_char(). The destructor uses the
+ * sysrq-aware unlock helper so that a captured port->sysrq_ch is dispatched
+ * to handle_sysrq() on scope exit. The plain guard variant silently drops
+ * sysrq_ch and must not be used by callers that process RX.
+ */
+DEFINE_LOCK_GUARD_1(uart_port_lock_sysrq_irqsave, struct uart_port,
+                    uart_port_lock_irqsave(_T->lock, &_T->flags),
+                    uart_unlock_and_check_sysrq_irqrestore(_T->lock,
+                                                           _T->flags),
+                    unsigned long flags);
+
 /*
  * We do the SysRQ and SAK checking like this...
  */
-- 
2.43.0

