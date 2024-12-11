Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E071D63C1;
	Wed, 11 Dec 2024 07:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733903382; cv=none; b=Zr1T+WQm2lTebZMMl0sqhxgGyV+j3UUfb0jyn/orZeRMY9NHd3699qTathpPZ0q3jXVi5m0OIgndavoY/aelbtjR2hSQWIPaXNLYDSbHHYiScscyfrvMmvc6CTFxXDeNh8Yy2MR3ytAje8PQcpooekZYMYrQwco0iHTSMGxGVVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733903382; c=relaxed/simple;
	bh=zH9FqQDIKQTcnr03BUXcyxCj0kOdnnKetZcxtG47EgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sv7AundDuS0ucBF1k6JopMRppryhA+wsgBmaVceG/84R9oRB2kEy/udC3uKzkdaSbtNFL6rLy9144+DK/gd3y56SO5qjGC760wOoArW9Vs882xNbPNj+VgNe0z14iCEr/CzMoPtVW6+8PAftsEkq9BTBEWHnjg4qx2vunBvxJTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1kEaxDI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1kEaxDI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3671C4CEE1;
	Wed, 11 Dec 2024 07:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733903381;
	bh=zH9FqQDIKQTcnr03BUXcyxCj0kOdnnKetZcxtG47EgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p1kEaxDI0VERsT1DKoSs3PrmaoZRaqWtGTa1/IfQD1N23HK97ajp0pBD9jEaf4nMn
	 giHivrLwrUos/JACalqXFjQjhFrE0TujgphVaO96IfntLfOlpoiC5nKGq3Rm5k8RAz
	 ENQ3ntFiky5YtBOcSkZMtmGVkjTqtrfOkiZ86QKNCpvWPAk/diWxreBvmPDc4r6IPM
	 nANf27RzhtUvb8LxNaCfO7m/UP1s1bM15450uPyYbUtu7EljDS/EiZjpHvPlMBhskW
	 rTfC5ucflPOfMdBljt80cNDPrSXhBSmFqLPNWsFn1wkoZK9vZ2Ni6yCpS2xF8rdali
	 JxUu6uNlq1M1w==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 3/3] tty: serial: extract uart_change_port() from uart_set_info()
Date: Wed, 11 Dec 2024 08:49:33 +0100
Message-ID: <20241211074933.92973-4-jirislaby@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211074933.92973-1-jirislaby@kernel.org>
References: <20241211074933.92973-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This "change_port" part of uart_set_info() is for no good reason
inlined there. It makes the function rather hard to read. Therefore,
extract it to a separate function.

This allows for flattening the ifs (with short path "return"s) and
avoiding two levels of indentation. Both making the code really flat and
comprehesible.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/serial_core.c | 114 ++++++++++++++++---------------
 1 file changed, 58 insertions(+), 56 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index ce3cf95fc910..c472594c3a9f 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -834,6 +834,61 @@ static int uart_get_info_user(struct tty_struct *tty,
 	return uart_get_info(port, ss) < 0 ? -EIO : 0;
 }
 
+static int uart_change_port(struct uart_port *uport,
+			    const struct serial_struct *new_info,
+			    unsigned long new_port)
+{
+	unsigned long old_iobase, old_mapbase;
+	unsigned int old_type, old_iotype, old_hub6, old_shift;
+	int retval;
+
+	old_iobase = uport->iobase;
+	old_mapbase = uport->mapbase;
+	old_type = uport->type;
+	old_hub6 = uport->hub6;
+	old_iotype = uport->iotype;
+	old_shift = uport->regshift;
+
+	if (old_type != PORT_UNKNOWN && uport->ops->release_port)
+		uport->ops->release_port(uport);
+
+	uport->iobase = new_port;
+	uport->type = new_info->type;
+	uport->hub6 = new_info->hub6;
+	uport->iotype = new_info->io_type;
+	uport->regshift = new_info->iomem_reg_shift;
+	uport->mapbase = (unsigned long)new_info->iomem_base;
+
+	if (uport->type == PORT_UNKNOWN || !uport->ops->request_port)
+		return 0;
+
+	retval = uport->ops->request_port(uport);
+	if (retval == 0)
+		return 0; /* succeeded => done */
+
+	/*
+	 * If we fail to request resources for the new port, try to restore the
+	 * old settings.
+	 */
+	uport->iobase = old_iobase;
+	uport->type = old_type;
+	uport->hub6 = old_hub6;
+	uport->iotype = old_iotype;
+	uport->regshift = old_shift;
+	uport->mapbase = old_mapbase;
+
+	if (old_type == PORT_UNKNOWN)
+		return retval;
+
+	retval = uport->ops->request_port(uport);
+	/* If we failed to restore the old settings, we fail like this. */
+	if (retval)
+		uport->type = PORT_UNKNOWN;
+
+	/* We failed anyway. */
+	return -EBUSY;
+}
+
 static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 			 struct uart_state *state,
 			 struct serial_struct *new_info)
@@ -930,62 +985,9 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 	}
 
 	if (change_port) {
-		unsigned long old_iobase, old_mapbase;
-		unsigned int old_type, old_iotype, old_hub6, old_shift;
-
-		old_iobase = uport->iobase;
-		old_mapbase = uport->mapbase;
-		old_type = uport->type;
-		old_hub6 = uport->hub6;
-		old_iotype = uport->iotype;
-		old_shift = uport->regshift;
-
-		/*
-		 * Free and release old regions
-		 */
-		if (old_type != PORT_UNKNOWN && uport->ops->release_port)
-			uport->ops->release_port(uport);
-
-		uport->iobase = new_port;
-		uport->type = new_info->type;
-		uport->hub6 = new_info->hub6;
-		uport->iotype = new_info->io_type;
-		uport->regshift = new_info->iomem_reg_shift;
-		uport->mapbase = (unsigned long)new_info->iomem_base;
-
-		/*
-		 * Claim and map the new regions
-		 */
-		if (uport->type != PORT_UNKNOWN && uport->ops->request_port) {
-			retval = uport->ops->request_port(uport);
-			/*
-			 * If we fail to request resources for the
-			 * new port, try to restore the old settings.
-			 */
-			if (retval) {
-				uport->iobase = old_iobase;
-				uport->type = old_type;
-				uport->hub6 = old_hub6;
-				uport->iotype = old_iotype;
-				uport->regshift = old_shift;
-				uport->mapbase = old_mapbase;
-
-				if (old_type != PORT_UNKNOWN) {
-					retval = uport->ops->request_port(uport);
-					/*
-					 * If we failed to restore the old
-					 * settings, we fail like this.
-					 */
-					if (retval)
-						uport->type = PORT_UNKNOWN;
-
-					/* We failed anyway. */
-					return -EBUSY;
-				}
-
-				return retval;
-			}
-		}
+		retval = uart_change_port(uport, new_info, new_port);
+		if (retval)
+			return retval;
 	}
 
 	if (change_irq)
-- 
2.47.1

