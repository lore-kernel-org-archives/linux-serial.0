Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4787D313527;
	Mon, 11 May 2026 15:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778513230; cv=none; b=U4InB5Y2aawLYPD9nTlduogh7PF2NEnco5QlJuIML0iBiAJ/RvSp/K+0J5yUXyJi617U3XUfjgj6ZDsDHcJpeQHw7TnTPzZUh7Nhu595lDDxalif7OVntijqoGD1lUcYuQIOLUNX5j9hhNTyk0eFwVEUTd9e8gfv3um4kHVNRII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778513230; c=relaxed/simple;
	bh=HqK9WI/4RERvi25TuZkJmKmoMaOvZ4CUokoGM8wn3Yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QtTedBC6fj53614oj1XfhksOjWeNcsKegR1Qxx8zPEzpr6fNV686cytl/WPUkFcFv8IIqkNThEKr80HY3vnPW2feCDAKhqDWC1Cb8Z6x0sVCuYtkmnn+0rNJxFwc+H/IJi1z7F8wzCWB+FaTE0AtDxvCgZybmesDfVEwKP+6qYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bEmIUJv4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZrA9cZ1A; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bEmIUJv4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZrA9cZ1A"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778513227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SrOyFhVPontbzgEAbyb/2JFaAOM/AqtJ/5aPb0vTYtY=;
	b=bEmIUJv4PdJvk/PxJ3hCYegohctCpoG2tbvKKxai8OhWb056OYn80Z2LLfIUeeAyvLK+Bh
	MUf80VaoCNHafdcAiCZfsncB5bl8dh4ok0oZBMVnlH5V+wBULwYWQNwTQVKqOCrmw9Pzg2
	wRpLA6dFbsMpnb7uR2eQr5YWUDgXdedgXRFdNlCjjPFjkUgrYshH5BhVHkr0dRccOCOAGB
	320wQimMCRNnZkfHWwZbIBFDl1cHkXqeIr3pav0/22hQlhUFyFfZp98clOei6IZa5nbUR6
	acaE7Mg6of5XA1DVpa+NXtszUR1scIWQBzpHl4rDzMX29dj8wbxPjrNX1M1mvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778513227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SrOyFhVPontbzgEAbyb/2JFaAOM/AqtJ/5aPb0vTYtY=;
	b=ZrA9cZ1AtCp81B+Yvw1KuY4wid36yyphEwu6tSXtNLl7ry+agcYcs+urdZqZtX4fJTPcaf
	25T2pEe2Qna4xsAA==
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Xin Zhao <jackzxcui1989@163.com>,
	Kees Cook <kees@kernel.org>,
	Osama Abdelkader <osama.abdelkader@gmail.com>,
	linux-serial@vger.kernel.org
Subject: [PATCH tty v5 1/3] serial: 8250: Set cons_flow on port registration
Date: Mon, 11 May 2026 17:33:00 +0206
Message-ID: <20260511152706.151498-2-john.ogness@linutronix.de>
In-Reply-To: <20260511152706.151498-1-john.ogness@linutronix.de>
References: <20260511152706.151498-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since console flow control policy is no longer part of uart_port.flags,
explicitly set the policy for the port.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/serial/8250/8250_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index a428e88938eb7..b0275204e1167 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -746,6 +746,8 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 	uart->lsr_save_mask	= up->lsr_save_mask;
 	uart->dma		= up->dma;
 
+	uart_set_cons_flow_enabled(&uart->port, uart_cons_flow_enabled(&up->port));
+
 	/* Take tx_loadsz from fifosize if it wasn't set separately */
 	if (uart->port.fifosize && !uart->tx_loadsz)
 		uart->tx_loadsz = uart->port.fifosize;
-- 
2.47.3

