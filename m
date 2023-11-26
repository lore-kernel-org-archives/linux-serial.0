Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qxpCeGJL"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995AD101
	for <linux-serial@vger.kernel.org>; Sun, 26 Nov 2023 08:04:27 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5ce16bc121aso27186727b3.1
        for <linux-serial@vger.kernel.org>; Sun, 26 Nov 2023 08:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701014667; x=1701619467; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jAcVnKA6iADA9vLnhJjfNDjx1x+ezMFBfqAWXzVOUug=;
        b=qxpCeGJLfF1BCtxowMWAsfvRVIv/6qZrnIrK/Xl5809mDWHNzkIX7uE999sOckKP79
         DN2Purd3BvPqXnrl6nFdfvZ6cWbSFnbAzz6T1SLRYaOqrv/LSKAdNO2Z7SqVe5aN8KEO
         TWLG6Wo0k4O7deHKhrgrhWmdq65QJwd0Kqotz6lDgxZXs4dwrDRierRwYIQNEGQGInuq
         YGYjpssDOzVLRN7U1LYM0ZRfIZiYLQbu8jAtqoc2qFzaG7+oOTdSYNIseyyqLUlxvZfr
         TjvQOSxdZ1hxh9pznfRok2ZZ65iTbpznhZ4QTcKvo0Pjjbja3Ivzolj9OI87B0yP4coL
         GU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701014667; x=1701619467;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jAcVnKA6iADA9vLnhJjfNDjx1x+ezMFBfqAWXzVOUug=;
        b=VGYia3oMryCR6JtnFiv5B5wGP2npEhx96ibuWWCUKI5XBHVUsVMDvq5zGjngYGM+zw
         Cr/4jFdo2rZyBgyYSbOPNz9NLve6ASbUnJrB64Rdwm17v+2sNKKWLxj54UERtF/h5mpV
         /lFefckfYcLxq8msN1PAjtupP/sbfzy/UvEa1JoW/Ed9BQ1cChmuh2RC4pcEC4LNvqMD
         BtJagZ2q/dopUKK7YTNxPYq/uhQ7kcXf2x8bwh9oEcMd1PKAzMTgfHPF1WfMaMvr7K1b
         iHAUHCbUqpq9p2nvFtxsuDmYlDlH0WJJRJaVmztGy3XrJvKWQ8r9CyQfXiFFj/rzO6Wj
         4ajw==
X-Gm-Message-State: AOJu0Yxr532ekVT+A1ntdHWKgOOTLWB5Qrbfcosi2eA1B1aPGilyBaIC
	GoUf9hiHL+L9IqMqpfv9Inhdgdi6Pb5icPtJYiRZ
X-Google-Smtp-Source: AGHT+IH7cSvAl+dD9EIaxrdjmVvg/Xxrak/8orkiMKrBN+wcdRVvxz+40ZTE5uo29YN8WI2xwKeM0LN6CAvXzZhldwne
X-Received: from vamshig51.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:70c])
 (user=vamshigajjela job=sendgmr) by 2002:a81:9b10:0:b0:5ca:5fcd:7063 with
 SMTP id s16-20020a819b10000000b005ca5fcd7063mr318515ywg.3.1701014666758; Sun,
 26 Nov 2023 08:04:26 -0800 (PST)
Date: Sun, 26 Nov 2023 21:34:20 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231126160420.2442330-1-vamshigajjela@google.com>
Subject: [PATCH] serial: 8250_dw: Decouple DLF register check from UCV
From: Vamshi Gajjela <vamshigajjela@google.com>
To: Jiri Slaby <jirislaby@kernel.org>, ilpo.jarvinen@linux.intel.com, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, manugautam@google.com, 
	Subhash Jadavani <sjadavani@google.com>, Vamshi Gajjela <vamshigajjela@google.com>
Content-Type: text/plain; charset="UTF-8"

Designware UART has an optional feature to enable Fractional Baud Rate
Divisor (DLF) through the FRACTIONAL_BAUD_DIVISOR_EN configuration
parameter, and it is not dependent on ADDITIONAL_FEATURES.

dw8250_setup_port() checks DLF to determine dlf_size only when UART
Component Version (UCV) is non-zero. As mentioned above DLF and UCV are
independent features. Move the logic corresponding to DLF size
calculation ahead of the UCV check to prevent early return. Otherwise,
dlf_size will be zero and driver will not be able to use the
controller's fractional baud rate divisor (DLF) feature.

Signed-off-by: Vamshi Gajjela <vamshigajjela@google.com>
---
 drivers/tty/serial/8250/8250_dwlib.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
index 84843e204a5e..136ad093c5b6 100644
--- a/drivers/tty/serial/8250/8250_dwlib.c
+++ b/drivers/tty/serial/8250/8250_dwlib.c
@@ -259,17 +259,6 @@ void dw8250_setup_port(struct uart_port *p)
 	}
 	up->capabilities |= UART_CAP_NOTEMT;
 
-	/*
-	 * If the Component Version Register returns zero, we know that
-	 * ADDITIONAL_FEATURES are not enabled. No need to go any further.
-	 */
-	reg = dw8250_readl_ext(p, DW_UART_UCV);
-	if (!reg)
-		return;
-
-	dev_dbg(p->dev, "Designware UART version %c.%c%c\n",
-		(reg >> 24) & 0xff, (reg >> 16) & 0xff, (reg >> 8) & 0xff);
-
 	/* Preserve value written by firmware or bootloader  */
 	old_dlf = dw8250_readl_ext(p, DW_UART_DLF);
 	dw8250_writel_ext(p, DW_UART_DLF, ~0U);
@@ -282,6 +271,17 @@ void dw8250_setup_port(struct uart_port *p)
 		p->set_divisor = dw8250_set_divisor;
 	}
 
+	/*
+	 * If the Component Version Register returns zero, we know that
+	 * ADDITIONAL_FEATURES are not enabled. No need to go any further.
+	 */
+	reg = dw8250_readl_ext(p, DW_UART_UCV);
+	if (!reg)
+		return;
+
+	dev_dbg(p->dev, "Designware UART version %c.%c%c\n",
+		(reg >> 24) & 0xff, (reg >> 16) & 0xff, (reg >> 8) & 0xff);
+
 	reg = dw8250_readl_ext(p, DW_UART_CPR);
 	if (!reg) {
 		reg = data->pdata->cpr_val;
-- 
2.43.0.rc1.413.gea7ed67945-goog

