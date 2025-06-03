Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F8D17A30A;
	Tue,  3 Jun 2025 10:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748947489; cv=none; b=qiCpsrO6sq3+5grRPMXbF6t/06mrXFcwT1ndthrphzolny9nhEM3dIuoz4MgZM4dM952Ley3H862NDkfvquIeGcgEEYoWH0Mv0wzsDxVY+xckL0M7x2T51rH+S/K59ThsTNP7+MDVQ1XVvI7fmMXbrENk74IYsT7D6gBvo3CY9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748947489; c=relaxed/simple;
	bh=PA8zEiKKCsCWRZbO8ejMZAAPGiQdCkJaJF55XJJ5x58=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qph/gEEEzxoG5fLfuEywHswAplbPN1Bbn+2UY3581qe8BBkBuX5uSzKSrGk2aXVkhOpQib3s/Tb3QBZ6Xjf/3lf7pZLiVPs59SgBeFh3daPOpwTqGrlvBwEPebsxlhj1f7ub/RWE2xFa+7uQJM5h/3xdGy3OJxrA7AIInyI/b1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wlzLbfwL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k1gR3bXO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wlzLbfwL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k1gR3bXO"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1748947485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qyerjqJWeMkiU3JFd0PuWL/CwiYER2qHnJinnhBcrJE=;
	b=wlzLbfwLHjpswLCvW1kkayxbHDXig57HNT37SNWboCbiDaDeZYhzPLmZ/DrZw4CxEWOJPz
	1s8HcczWfbGYkaQgYvgr6BfIOqkdR/aIhXv4R/Nf2TFMfhrmq9Y9OwKWrQOpnmVUIPd+xh
	pL5U6vd5FGmN2JOkAnxK7IXm20C0442/yp/qsiSxWeRRzZv9PTQ4EIUqZ/IfZW7N9H1O8+
	F8b1K+2j64BBypXlJos2NQY5jy003Y4YgD2XhoTLBnALSAdZCWMyqj/3E4XhjfgC0gn/F0
	3Td1V+UQECIXpSp9CQyi6+EwMzzELbLFHXlcvGfFLCBi0knI7sLtqPDzInJw3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1748947485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qyerjqJWeMkiU3JFd0PuWL/CwiYER2qHnJinnhBcrJE=;
	b=k1gR3bXODmtwnAo31Z4DtIGO9CBdeclvJrlw+1wVoOFu3E76stL6fOXgqB61E629HPI9a3
	bAi5ika9rvkNeWCw==
To: "Toshiyuki Sato (Fujitsu)" <fj6611ie@fujitsu.com>, 'Michael Kelley'
 <mhklinux@outlook.com>
Cc: "pmladek@suse.com" <pmladek@suse.com>, 'Ryo Takakura'
 <ryotkkr98@gmail.com>, Russell King <linux@armlinux.org.uk>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org"
 <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "Toshiyuki Sato (Fujitsu)"
 <fj6611ie@fujitsu.com>
Subject: RE: Problem with nbcon console and amba-pl011 serial port
In-Reply-To: <84y0u95e0j.fsf@jogness.linutronix.de>
References: <SN6PR02MB4157A4C5E8CB219A75263A17D46DA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <OS7PR01MB13775FE1A20762D1EA4A38D0ED76DA@OS7PR01MB13775.jpnprd01.prod.outlook.com>
 <84y0u95e0j.fsf@jogness.linutronix.de>
Date: Tue, 03 Jun 2025 12:50:45 +0206
Message-ID: <84sekh5cki.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-06-03, Michael Kelley <mhklinux@outlook.com> wrote:
> The problem is the failure to stop secondary CPU 2.  (The CPU # that fails
> to stop varies from run-to-run.) It is mostly reproducible, but not always. I
> bisected to commit 2eb2608618ce ("serial: amba-pl011: Implement nbcon
> console") in the 6.15 kernel.

Unrelated to this particular report, I am looking at commit 2eb2608618ce
("serial: amba-pl011: Implement nbcon console") and I do not think it
implements atomic printing correctly.

pl011_console_write_atomic() assumes uap->clk is disabled when it is
called. However, if it took over ownership from the printing kthread,
the uap->clk is already enabled. And then after printing its line it
disables uap->clk, even though the interrupted printing kthread expects
uap->clk to still be enabled once it regains ownership.

The atomic printing needs to track if the clock is enabled or disabled
and act accordingly. I suppose something like this:

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 11d65097578cd..914449b46b95b 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2520,11 +2520,14 @@ pl011_console_write_atomic(struct console *co, struct nbcon_write_context *wctxt
 {
 	struct uart_amba_port *uap = amba_ports[co->index];
 	unsigned int old_cr = 0;
+	bool old_enabled;
 
 	if (!nbcon_enter_unsafe(wctxt))
 		return;
 
-	clk_enable(uap->clk);
+	old_enabled = __clk_is_enabled(uap->clk);
+	if (!old_enabled)
+		clk_enable(uap->clk);
 
 	if (!uap->vendor->always_enabled) {
 		old_cr = pl011_read(uap, REG_CR);
@@ -2542,7 +2545,8 @@ pl011_console_write_atomic(struct console *co, struct nbcon_write_context *wctxt
 	if (!uap->vendor->always_enabled)
 		pl011_write(old_cr, uap, REG_CR);
 
-	clk_disable(uap->clk);
+	if (!old_enabled)
+		clk_disable(uap->clk);
 
 	nbcon_exit_unsafe(wctxt);
 }

I am guessing that it is allowed to use __clk_is_enabled() for this
purpose. Otherwise it can be tracked as a bool in struct uart_amba_port.

John Ogness
