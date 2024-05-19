Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0FF1E49D
	for <linux-serial@vger.kernel.org>; Sun, 19 May 2024 19:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716147227; cv=none; b=SdQAFxqiH5UejB28XZ1kotp29LE2bk5E5diY2ojZ3kN9j64Y0oevHZWwvMMPXLMu1DprQGA1zdEB50vp8DpLFRRG6SuO2KG5wVqhTVSo0vrzHhkSASCE8lcV0jTWY1O7KNxOFSmdqeNLSPMn9RFyiEhjLQOw+NiicUzkSFuSzCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716147227; c=relaxed/simple;
	bh=qE8mIA+xVdk8DTtuzds9lavQ2HNIoDG8GtOt0Hcbh80=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Sv9Knk+KKRWVVubVf1Btzs7/XrdNMnMIUvV1182e6nibLtwIc9D/su0qA7JmLVEezTDr7AOn7bwPL4/O42aGKuZjYJCRKUtg5AEZoUaOqnZj+bXqUrJ8k2NHVB0ZPA7DY6HDxToR9v52lmrMtJAjRiTiV09ehD8UBDoAQNPqURI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schmorgal.com; spf=pass smtp.mailfrom=schmorgal.com; dkim=pass (1024-bit key) header.d=schmorgal.com header.i=@schmorgal.com header.b=Z7QqHGdv; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schmorgal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schmorgal.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schmorgal.com header.i=@schmorgal.com header.b="Z7QqHGdv"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f2e3249d5eso7649405ad.3
        for <linux-serial@vger.kernel.org>; Sun, 19 May 2024 12:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google; t=1716147225; x=1716752025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KXSyCgiuJo4mhoQvXJMk883wTmYaBoWOltUpQ4E5Puo=;
        b=Z7QqHGdv1qd8VO9epNFhFZSUe+M+6S9EWLLcIxOjuOA/eUGkSIwLJPRwWEaZMoLUUK
         EIQOl6f9qogazfIbWqKRje0eIKHlnQbpygsvdK9R8kTZ1W38DXtHj/FAkJu05sy4g//9
         6i+Ut6Al9KvwTP+T0PAijRTQehKzMqpisH3Ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716147225; x=1716752025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KXSyCgiuJo4mhoQvXJMk883wTmYaBoWOltUpQ4E5Puo=;
        b=f94Lyo8/FxljiSD0YS466udUPVlC5bwpAcR3wdj7gYPdg4MRGk15oRn4P4meA/ZUcg
         u6wpAI5eSgGrNvN5aL2P/prrwzJsfe0C8SllJNAphvawqfWilfKXQvvgMfb8+bI572ur
         msYQOjp7OqmtNYW3fH/RC/mOmfmEMWBFnGRl1natuibEAb07cEtRameGuVX1FISP5YAg
         f9L1nvIhg3zX3angDDk4pb6caDFv+h+j8pt+qilXmPjRXg9MlzfJwyBXbHNLxFjYVqln
         owdXcSQu/B+anQlhrUy9HLfehzxR71KJVJdnwOuntcIJVpwMSTs5vB00bpQwNTqBTMQg
         5YFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsJHYPY/9WIa8u0l5hivkMjpNn6yLRQ0wxUx5uVYPTdYqc//RYF7M35Q/EM3Xu6fpDnv58I7+Qyx7HRFUuV+oSkk01hEY/mbu1DARD
X-Gm-Message-State: AOJu0YxI87ytpcVlexcY6eGD9p1bLk+8PjX64/LpD8AqDl9Bcjpdue7H
	TqrTRPLXKdm/VBMEIQJ5QEPW527LE/csqsBPHkTpyHw3Zzby+JQ1si9Yqg2ciAk=
X-Google-Smtp-Source: AGHT+IFY2ndlmDoZsXPkqAaS9xNvmNk3m0X2w8datGeJf/U+BD55adiFh3Oy5r8i+QgUiZcyXxBHIw==
X-Received: by 2002:a05:6a21:168c:b0:1b0:1be7:3708 with SMTP id adf61e73a8af0-1b01be7388amr15574564637.1.1716147224465;
        Sun, 19 May 2024 12:33:44 -0700 (PDT)
Received: from doug-ryzen-5700G.. ([50.37.206.39])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-63411346dc1sm15776489a12.83.2024.05.19.12.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 12:33:44 -0700 (PDT)
From: Doug Brown <doug@schmorgal.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org,
	Doug Brown <doug@schmorgal.com>
Subject: [PATCH] serial: pxa: Disable TX interrupt if there is no more data to transmit
Date: Sun, 19 May 2024 12:31:12 -0700
Message-Id: <20240519193109.122466-1-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a TX interrupt occurs and no new data gets loaded into the TX FIFO,
the UART will never fire another TX interrupt until the UART_IER_THRI
flag is toggled off and back on. If nothing ever calls stop_tx(), this
effectively results in transmissions getting hung up until another
unrelated UART IRQ occurs, such as an RX interrupt.

The driver used to do this correctly until the transition to
uart_port_tx_limited(). This didn't matter until the behavior of
__uart_port_tx changed in commit 7bfb915a597a ("serial: core: only stop
transmit when HW fifo is empty").

Fixes: d11cc8c3c4b6 ("tty: serial: use uart_port_tx_limited()")
Signed-off-by: Doug Brown <doug@schmorgal.com>
---

Note: I based this on v6.9 instead of tty-next since it's a fix; please
let me know if that was the wrong move and I would be happy to resubmit
it based on tty-next. The patch changes ever so slightly because of the
circ_buf -> kfifo transition. The only difference is it needs this
condition in the "if" statement instead:

kfifo_is_empty(&up->port.state->port.xmit_fifo)

This has been tested to work properly on tty-next as well.

 drivers/tty/serial/pxa.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index e395ff29c1a2..8abb85bee87c 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -176,6 +176,14 @@ static void transmit_chars(struct uart_pxa_port *up)
 {
 	u8 ch;
 
+	/* If there is nothing left to transmit, disable the TX interrupt.
+	 * Otherwise we can get stuck waiting for another IRQ that never happens.
+	 */
+	if (uart_circ_empty(&up->port.state->xmit)) {
+		serial_pxa_stop_tx(&up->port);
+		return;
+	}
+
 	uart_port_tx_limited(&up->port, ch, up->port.fifosize / 2,
 		true,
 		serial_out(up, UART_TX, ch),
-- 
2.34.1

