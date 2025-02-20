Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38DD1F583B;
	Thu, 20 Feb 2025 11:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050214; cv=none; b=XHdQLHvtgMHOX7yrQYVmtj7NDDfLtpBwPNpQOs74df4UG/t1Q1d8aBkV5gWmcG5hkmEZgj69l6tcghwQYGstWx9mAyFZ8WFPGZLbzSUKC4QUi1qVAY/BwuHQHB0yKTFLhBUQC7F6+PZH2jQPWTzf8pUGQN342v1YyoWqANjN4+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050214; c=relaxed/simple;
	bh=0qLHAAL+353m1Ju7cnS1kMjUN4v4Ya2R2cFuwY/DLvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ooaUW6NmpU/+x/totXUjpRkPWOxZ4qpmDwQFAlOkt8G/86NMlH71tLJG9IEryPLTW7rf9g47VyHACFEow3VTSg/rSP5ZlVxlyaEz5ltbbRnOZ4wu4xk0oqi7DrnfEqPyGfyCl/7t2DMDtr2JrzUu+1pjcSIHZEitZOfj+Rsf5wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rRlYCPHD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rRlYCPHD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5DD2C4CED1;
	Thu, 20 Feb 2025 11:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740050214;
	bh=0qLHAAL+353m1Ju7cnS1kMjUN4v4Ya2R2cFuwY/DLvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rRlYCPHDVmppWoly1Y0GQT5Ef5Agm6+dSC7J2/cvFqc4ZSxQ7+UiQVltohDS/Iezq
	 pNxgCMDKQ2MjqMJ6gh1eVZ60jvav1vHiHUN5DCIFQhQeHKaXBMzH6LcL3eAXA/Rfet
	 BnM//Shikh7GhiI1ILnZcweCNYqNk01ETET7RRxti/RP61DIwrySEzsH2LXjoH7Un4
	 /PaOHfXCvn4CiAXVXMyjy2HeIOB4cn5CaaXq/ALmOdc7IwUTGoLLNFZY+yvPJ8IuPY
	 CjVlL/EnyT7LGwUmasPwAncK1dZusJqJo8PIQXIyJ2jeAQeeXA/c9bMeUr30FovUSd
	 Z5r6Y0X7ObzTQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 25/29] serial: pass struct uart_state to uart_line_info()
Date: Thu, 20 Feb 2025 12:16:02 +0100
Message-ID: <20250220111606.138045-26-jirislaby@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220111606.138045-1-jirislaby@kernel.org>
References: <20250220111606.138045-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

uart_line_info() wants to work with struct uart_state. Do not pass a
driver and an index. Pass the precomputed struct directly.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/serial_core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 2a6453891801..04eaa24ed153 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2013,9 +2013,8 @@ static const char *uart_type(struct uart_port *port)
 
 #ifdef CONFIG_PROC_FS
 
-static void uart_line_info(struct seq_file *m, struct uart_driver *drv, int i)
+static void uart_line_info(struct seq_file *m, struct uart_state *state)
 {
-	struct uart_state *state = drv->state + i;
 	struct tty_port *port = &state->port;
 	enum uart_pm_state pm_state;
 	struct uart_port *uport;
@@ -2100,7 +2099,7 @@ static int uart_proc_show(struct seq_file *m, void *v)
 
 	seq_printf(m, "serinfo:1.0 driver%s%s revision:%s\n", "", "", "");
 	for (i = 0; i < drv->nr; i++)
-		uart_line_info(m, drv, i);
+		uart_line_info(m, drv->state + i);
 	return 0;
 }
 #endif
-- 
2.48.1

