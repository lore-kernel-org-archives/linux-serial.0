Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7742026C3BF;
	Thu, 14 Aug 2025 07:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755156304; cv=none; b=aAudSLg/8TDHQPdI3KhW8eRzVKtL897AYJVuGTLqLy13c8MtAhhRehcStNgg4TnRGlf2TQuMN0E9NWBk99Mulhyp2PlzPFJTXJUCPcpuIm0k2hJ6mso1lno4dYmQYET1LBCy7xmxUAgvq2WI6X1v+UlVaxOM28TGXN3wqDs70E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755156304; c=relaxed/simple;
	bh=+nuDBiZ+xaMkbDUd9Y9iFbfqjNlclFhhFDwVdp/XyJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wn3iR9AP4jM7EFPftQGGLnFVXEDbdInUawqMMj2/YD/j7/gfQ0GGwf8ooDNtIW56bcWYGEDhkkI32Si8RBfT+Q2oH8KkSv6XKxN1wYQBo2Xnz+7RRQdFBqSL+ILBT2oyqKhuRm62uXE0Ev/xI7/Rha8Qhv7kmuClP2WqwuwPcys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=duKm8u7V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="duKm8u7V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2029C4CEF7;
	Thu, 14 Aug 2025 07:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755156304;
	bh=+nuDBiZ+xaMkbDUd9Y9iFbfqjNlclFhhFDwVdp/XyJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=duKm8u7VurU5LnjONJDN3HMrabW0ICEYWpdsTzMDbGNlg1HWhcjuJzrnjBbelDbTO
	 EUVOQhiyqt0Yza9cXhh3BrBX8hDjuYMfVxw17Ocmqo4hTKjWFy1eYrEMkQd7Z0RdRo
	 LSMrGNtiAWaSat8KHjjFFV9tun4wh96j4EeEPbiqdRsBpdgPNakrwSL0FBKZfgtVhQ
	 URvEx//mL6xm/TPe83eQtG5EaaoV7WWH1yeeBaIJjt3LXiwPsJh8IglVUcg6ZXKhf5
	 EBkHlVgaV/Ip/DOgBD47kz3pavGbAP2U54q0DeScmA6Qbm2yI8wdOEGrrFdouLqaQa
	 4dw9pZ1HjStVw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 03/16] serial: introduce uart_port_lock() guard()s
Date: Thu, 14 Aug 2025 09:24:43 +0200
Message-ID: <20250814072456.182853-4-jirislaby@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814072456.182853-1-jirislaby@kernel.org>
References: <20250814072456.182853-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Having this, guards like these work:
  guard(uart_port_lock_irq)(&up->port);
or
  scoped_guard(uart_port_lock_irqsave, port) {
    ...
  }

See e.g. "serial: 8250: use guard()s" later in this series.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 include/linux/serial_core.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 84b4648ead7e..666430b47899 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -788,6 +788,19 @@ static inline void uart_port_unlock_irqrestore(struct uart_port *up, unsigned lo
 	spin_unlock_irqrestore(&up->lock, flags);
 }
 
+DEFINE_GUARD(uart_port_lock, struct uart_port *, uart_port_lock(_T), uart_port_unlock(_T));
+DEFINE_GUARD_COND(uart_port_lock, _try, uart_port_trylock(_T));
+
+DEFINE_GUARD(uart_port_lock_irq, struct uart_port *, uart_port_lock_irq(_T),
+	     uart_port_unlock_irq(_T));
+
+DEFINE_LOCK_GUARD_1(uart_port_lock_irqsave, struct uart_port,
+                    uart_port_lock_irqsave(_T->lock, &_T->flags),
+                    uart_port_unlock_irqrestore(_T->lock, _T->flags),
+                    unsigned long flags);
+DEFINE_LOCK_GUARD_1_COND(uart_port_lock_irqsave, _try,
+			 uart_port_trylock_irqsave(_T->lock, &_T->flags));
+
 static inline int serial_port_in(struct uart_port *up, int offset)
 {
 	return up->serial_in(up, offset);
-- 
2.50.1

