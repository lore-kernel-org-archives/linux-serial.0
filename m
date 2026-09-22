Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824D1385D72
	for <linux-serial@vger.kernel.org>; Tue, 22 Sep 2026 07:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790062006; cv=none; b=fzsxx+Nye5BttoO4pgEHcUK1duwnGBVfmZ86n/FwV79fJZ/0aTNsYOfMSRGJAo5Jd0mDBt06TWlvFejdNXsMMs7Qgf/FvTNPZeAVroFi45G26Lw6OdadmumAjtAhVzUU8C2ZXVVTXX9/RzvSSDg8+9bd8v4mgEg5QjnTJI+w4UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790062006; c=relaxed/simple;
	bh=4Z62Xv5PMHnfdSbbUYiP/gr3VyxZoYSTSx4wDC2uPe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b8JMQvO672XH7AQiiLzWLQXnKNjfY2RzoKGVhVSPaKOV0yI0sfThV+4GLIZKgEF+sA9jYfHJESTI5MGa8o8mlVqH7dW5KYazWceT5nFxK1pG5IHrUyCuUDSPDAf8NoagyKajx48xIMJBDmHEUcTyv3MZ57jPErLq7YbaNdOgkz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RfVhhZr/; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RfVhhZr/"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485b1d2874aso2765827f8f.1
        for <linux-serial@vger.kernel.org>; Tue, 22 Sep 2026 00:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790062003; x=1790666803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mijCsOeT4dW/QaoqrTcbYmQViveRxBniaswO81wBCMI=;
        b=RfVhhZr/6f/blD4HsgpAaq+LoKZI+yFQh38j8flKgtzR7KwCF/rwHFfuNmEMs5kxKr
         aZ+RLgpc/bS7sdsLKzw4MvgRtKKFiP480nivJ4VQJEoPJIHppz1+mWgwn3UFHZEZ6iWc
         bmCRk4JNTjO5zgczDAhpbL57XkHbbuaJusDUIEeWPt6hCtvaUhoBo5LX5zlZyZP6eumh
         cC/Tqu0fRWn3583Qvws4c/1vXs+fhNLpN9UQ5URuipO/sVnTdIRkdy51PQ9UOw8X2eRZ
         7TrVBs/RMpBHMfcckSttRyln2ayR7YXl8eYTXjLVa1gR4C+8OdLoI+A2oo8hWjYJJoT4
         VG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790062003; x=1790666803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mijCsOeT4dW/QaoqrTcbYmQViveRxBniaswO81wBCMI=;
        b=csrzMIgJ8/zfimT0V+NQ/iKUJNEsSZxUuwJnUE2W8NQRCLvMXXfciZslyX4oMQSVj0
         0mWKtIzUjvwPzT8s+roelYZBx0UcVhLcUi5DnU+0z65ubaW1Dwm2voaa+tV8XzND+l+/
         EAa+G04MV2HnoEG9b1tH7IC1QpcAuYIMjLW2dbClbFrw6CyPnsyBAEucZAFcO0t0+QSG
         MNR53UbKytZ9hd+CEBMQNTRxizZ/wZ2EkMtLfpD5v52YEZDmcy20FSYye2JxwUBj/zKK
         jr3VhUN7gea6awjQvbq3OhH6mq+0XPnkOBnUXf6vQOw9sIEsYp+dLZqzvuO6QgISu/Pq
         BxwQ==
X-Forwarded-Encrypted: i=1; AKwUvBw9JrPUMLlstuGmHj2PwJs/3YqiwVR+nIkkH7zwzgu+OSf+bpCCepT1vS9W7pLqP0syP7/zzacp7HL+69A=@vger.kernel.org
X-Gm-Message-State: AFuF++kiydcEMoMPDME8pM6AVpyn9Yqy3WYoECtKckSTqaNwPid9uVQZ
	BGxMP16IJg4xoEnhsS74iZ4+rlGumhN8NWXuRt66Vlb38FpZCg8KZwS66TDDJa+gEDU=
X-Gm-Gg: AYBFou0WhkMhyvGZol8M8JHT8yFKJ0HjhB9iqeLHP+aFU540aHcW20lwGvjdnELuBli
	FCdE7oWckUB44cU0z22yyDiLZHg0okdY+Nazw2hKwtHqs/XKYX+nICP4XAKFoBSX0Y6F7yaskxt
	3bD3oi0MbbqcuM6HpMawLz4p78U6pneumaJLlWSU1b5Uo0JFvspcqFDfWQKfnhsCyNVGXirrDf4
	ELp7HHRno+lNGFZvbFnLMrF3TYKB1SsXXVg5UxKRTCWZfQWPxBA2l4moTJUgFp9rfalQM5BVOu/
	Qm9VO52Vsw1AVRY06rqtXNABJX5rmkCYzDKuDRcx4nKhM8xytiiUXNjf/mNHnuEuw3dD46ZSS4q
	a5uHXXpZEQK4RLUoM+uSHgNjTdIVYCigHiusnP69yyeVsQOuyH89nuuRIchK1C5xd4YRxkHz7SX
	2ztuzkm+YqQqY5Z8n0CWYod8ee9hdn+K3hO6atyUF97BXfHyJ/fmkwqsv/oAgmPd1ayOOs1RFj
X-Received: by 2002:a05:6000:38f:b0:487:27f9:83d with SMTP id ffacd0b85a97d-48727f90ba9mr11598775f8f.50.1790062002655;
        Tue, 22 Sep 2026 00:26:42 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48862773ff0sm2915327f8f.9.2026.09.22.00.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 00:26:42 -0700 (PDT)
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Fushuai Wang <wangfushuai@baidu.com>,
	Kees Cook <kees@kernel.org>,
	Stepan Ionichev <sozdayvek@gmail.com>,
	linux-serial@vger.kernel.org,
	Manuel Lauss <manuel.lauss@gmail.com>,
	linux-kernel@vger.kernel.org,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH 2/2] braille: nbcon: Use nbcon atomic console callbacks
Date: Tue, 22 Sep 2026 09:25:58 +0200
Message-ID: <20260922072558.98854-3-pmladek@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922072558.98854-1-pmladek@suse.com>
References: <20260922072558.98854-1-pmladek@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Braille console is integrated with the virtual terminal (VT) and
writes its data using the legacy con->write() callback of the associated
serial console driver.

However, once the underlying console driver is converted to the NBCON
API, it should use the con->write_atomic() callback, which must be
synchronized by acquiring the nbcon console context.

Adapt braille_write() to handle NBCON consoles:

1. Acquire the nbcon console ownership using NBCON_PRIO_EMERGENCY
   priority before printing, disabling local interrupts to prevent
   any nested calls into the driver.
2. Call the con->write_atomic() callback to write the buffer.
3. Release the nbcon console ownership and restore local interrupts.

Also, adjust __serial8250_console_write() in the 8250 serial driver to
exclude Braille consoles from the newline prepending logic. The serial
port is not used for standard printk logging which might be interrupted
in the middle of the operation. In the Braille mode, the serial driver
is supposed to write exactly what it gets. In fact, it does not print
any newlines at all in this case.

Fixes: d3539347022a ("serial: 8250: Switch to nbcon console, take 2")
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 .../accessibility/braille/braille_console.c   | 38 ++++++++++++++++++-
 drivers/tty/serial/8250/8250_port.c           |  5 ++-
 2 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/accessibility/braille/braille_console.c b/drivers/accessibility/braille/braille_console.c
index 06b43b678d6e..cd1019d478db 100644
--- a/drivers/accessibility/braille/braille_console.c
+++ b/drivers/accessibility/braille/braille_console.c
@@ -62,14 +62,32 @@ static void braille_write(u16 *buf)
 {
 	static u16 lastwrite[WIDTH];
 	unsigned char data[1 + 1 + 2*WIDTH + 2 + 1], csum = 0, *c;
+	struct nbcon_write_context wctxt = { };
+	unsigned long flags;
+
 	u16 out;
 	int i;
 
 	if (!braille_co)
 		return;
 
+	if (braille_co->flags & CON_NBCON) {
+		/*
+		 * Braille console might be called from unknown context via
+		 * vt_console_print() from console_unlock() from printk().
+		 * Use the atomic callback and synchronize it just using
+		 * the console context. Disable interrupts to prevent a nested
+		 * call into the driver code which might cause a deadlock when
+		 * trying to acquire the console ownership, see
+		 * __nbcon_atomic_flush_pending_con().
+		 */
+		local_irq_save(flags);
+		while (!nbcon_braille_try_acquire(braille_co, &wctxt))
+			cpu_relax();
+	}
+
 	if (!memcmp(lastwrite, buf, WIDTH * sizeof(*buf)))
-		return;
+		goto release_nbcon;
 	memcpy(lastwrite, buf, WIDTH * sizeof(*buf));
 
 #define SOH 1
@@ -102,7 +120,23 @@ static void braille_write(u16 *buf)
 	*c++ = csum;
 	*c++ = ETX;
 
-	braille_co->write(braille_co, data, c - data);
+	if (braille_co->flags & CON_NBCON) {
+		if (braille_co->write_atomic &&
+		    !braille_co->flags & CON_NBCON_ATOMIC_UNSAFE) {
+			nbcon_write_context_set_buf(&wctxt, (char *)data, c - data);
+			braille_co->write_atomic(braille_co, &wctxt);
+		} else {
+			pr_warn_once("Braille requires a safe braille_co->write_atomic callback\n");
+		}
+	} else {
+		braille_co->write(braille_co, data, c - data);
+	}
+
+release_nbcon:
+	if (braille_co->flags & CON_NBCON) {
+		nbcon_braille_release(&wctxt);
+		local_irq_restore(flags);
+	}
 }
 
 /* Follow the VC cursor*/
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 38fa45e74a37..6eb0b439e433 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3417,8 +3417,11 @@ static void __serial8250_console_write(struct uart_8250_port *up,
 	 * If the console printer did not fully output the previous line, it
 	 * must have been handed or taken over. Insert a newline in order to
 	 * maintain clean output.
+	 *
+	 * Braille consoles are an exception. The serial port is not used
+	 * for printk(). The driver is supposed to write exactly what it gets.
 	 */
-	if (!up->console_line_ended) {
+	if (unlikely(!up->console_line_ended && !nbcon_is_braille(wctxt))) {
 		if (use_fifo)
 			__serial8250_console_fifo_write(up, wctxt, "\n", 1);
 		else
-- 
2.55.0

