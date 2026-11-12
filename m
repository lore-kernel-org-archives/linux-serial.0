Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794497633;
	b=CKzk2odyVFaMhgpaYwiuMhO+MgB0jPvVV0B+EAZsRQvS1IeUzwjC9PBqNKGMNoSz6y4t
	 s0CYJIkYCuyO7B64fEZ4u/aDg+ytxBFSqO70CJTYJYSK+Wzm51SsaaxmZ99kqWD3Z3ba0
	 pR1U9jZlWvtaiVfTMiZ5tdzH09du3/zR5pgqrWD2BhXgB/QZ+whHUlEieNg35462sqPHL
	 PYTKxz5i3QhSqCOwkIuZ7bKGjWOM+CfgqKyH4N1qnS5Duw31tGoK9YUa/kZ0EFgJhUOzR
	 Qy5Z4bF1VYro/x8yetOw8aMshWOK2UbYw7zqIEAl2BzHjAI5sGjeO/iAmzuhSvbMjCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794497633;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=L1LMY5qyBag2HeM/ukaz5enhzW6oSXExQCIV3gTZALI=;
	b=dHy7gs2rGv/b7qEtczguzpt6gc+ljHBF9qj228OcgjRBb5qU1A88hEiClmdpjgZgHk0Y
	 zslYbD2j22hmlutAffRQbepswoiD6t9RGW94DOzx4D/1KJlzgT6br5O94mhX7DkyCaxJf
	 7haLZnhYSJu/uv9/HHogsCion6aIHOrtBgZWd+vuX/1gzxjEldQiT16r7EC2SmvsqVhR9
	 da2YeicezQHFbDbQJEqGxLcSY/agQgmLEQrhyWX9BedZBLzrx0K5OC13VBuDIJ0M/QBjH
	 FZred8Su9aOggR2HXqFWXCA9/XYCXZO6sB/UBu5W9Kz1/4Xsbi816lCZL5mH72D2Bwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="lfKwIr/O";
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB40F606A88D
	for <linux-serial@vger.kernel.org>; Thu, 12 Nov 2026 15:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB40F606A88D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lfKwIr/O
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so12172965e9.1
        for <linux-serial@vger.kernel.org>; Thu, 12 Nov 2026 07:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794497631; x=1795102431; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L1LMY5qyBag2HeM/ukaz5enhzW6oSXExQCIV3gTZALI=;
        b=lfKwIr/OGjtUqZfBmMJ/Aoplfh1BTyYUXKrttf4X09PBZXTQGCYXKkij1nUQcLeXRc
         inG51u9HVJXkmXrMhR3iTOSJ9N5bwyAXcgUYLTGZ8VkaJlaWidxW4XvEf72ncHKOXbeT
         8hR1uLic3QgXHHeWr7lab4WNwLXsWrmprfdPihCKEU4JrNywYT4P9yGRm+gxzoW3fN7L
         wMluG88gjZM4tCZtP4LdXArB/drZ5VVuihte/WpjiUjLt7oHw391+WTxkCBkpikNUAjt
         e/DV3seGgOEsSf7QCOMtr9DMecbE3D4aqds9KgJ0D1iY99oaXkbXAuhA9Deh7XlmA2w6
         2/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794497631; x=1795102431;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L1LMY5qyBag2HeM/ukaz5enhzW6oSXExQCIV3gTZALI=;
        b=0ND8LXFmSZWleVjgw/fuW8AGZswqPhyec9aAHevpjrx3ocQKUSxLO7vCnDD1vQVgca
         5UXAeipGOrf43a8kINwsJSbXkHSqM5h1gHvFeQ8UXwKU7HxTh/lBMWzdlLUKO+jUC3lB
         kaw6Erk0fVpMTu5LRjfUSsChsqy1EbajWFBHq9DB9R0CzzAv/T4hEK9LJ/cVoiRCCXap
         vZCSg9v3IRJbjvrBvzH/XmIDTqNU13SahXFLQv6ExE6/K5kdAWSR8wvsMLCjmnHjF7sL
         pUCRpz6C9dsE3ZsK+CG0ce/77vjejJ+xqno9n0x5vIB7OUgsJyaEQ7G9qtGuNvb3QFJI
         9dDQ==
X-Forwarded-Encrypted: i=1; AL+hErGNiQY+KR+Jtvy86ndKGKn5O98l2TzN1T05R2VNYBwTDGtPnQuzOFTU7VGkURvhYUBCU0W8dbMBzgQyOd4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/tuXsi1r6mGkhTcDpcD38H53d9OQG/oMg8O/Dxn5eDliXlxnPo
	R3hZzOSlIL4IpdTXpMUzFsFZfMoo4lOmXfKxJuFY9lQY6Mela4L7DEjf
X-Gm-Gg: AYBFou300izn1B6GLi4XikTpx8AseoOkw+WBwsCafSJtKszadneVfqMixHJLDInCpG5
	SLcB3qB6KL1ZUCYF8xzRUfUot3YX/H/rzjAa4WilxrSeThAKD8LhU9roH7YNrsr8dJ0tlxa+g7r
	CYtqlP1jxg/AlBEPWL5AficISJ7nUv7RCLZooZWvqgHlisbOO0kWUB3fNW5deCt/SeMy6fZK6Vv
	2sjGBz/BGlOT+sOVxABYU8ofxgW3IewCMT2kqkeEZ/fcMBJm4GeBCq6rF1XMKlHOD3CVORABo+2
	oiQTJFx5hPwBuluKmCfiCjMtY2z3UbwtOS2WnS6YVMsVUcf50ImBEK+YQzhPlk639S0vnABkfG2
	g58OCVxfkkYWEDFTum4/2KKOr/DBJflHb/sRsIpT36uCWt1SpBuiyhvvyRI4ZmLde0lqkA1e1DZ
	PMOM9cNsdpA/SQVqwci8BhsK4qBwW12VdFeqwdlHegZqEQBEDJghX8yI6iH5zuQKVpQiGu/l/9G
	aWcUJsE4rSblKWcxz2lHG7pCCOD+W6sRcUwDrEjRe5+Z04XfuAZEsIch4Ux14lCia6UqBGwTcqo
	0Ae3y4sTm+m+5c59UCPuTjj9iWZmM4sz/uXA+6QRQn0c8f64Bi0DWGsvxYOUmdnh4EqvVjmkp8e
	s5vLdKQ==
X-Received: by 2002:a05:600c:a31c:b0:4bb:53e4:a7c5 with SMTP id 5b1f17b1804b1-4bb53e4a861mr15636085e9.14.1794497631072;
        Thu, 12 Nov 2026 07:33:51 -0800 (PST)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae. [86.98.194.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2593e4sm87105855e9.5.2026.11.12.07.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 07:33:47 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Date: Thu, 12 Nov 2026 19:33:10 +0400
Subject: [PATCH v2 2/6] serial: core: Allocate a free line for
 UART_LINE_AUTO ports
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-vt8500-serial-cleanup-v2-2-36b258e0c0dd@gmail.com>
References: <20261112-vt8500-serial-cleanup-v2-0-36b258e0c0dd@gmail.com>
In-Reply-To: <20261112-vt8500-serial-cleanup-v2-0-36b258e0c0dd@gmail.com>
To: Alexey Charkov <alchark@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Tony Prisk <linux@prisktech.co.nz>, 
 Alan Cox <alan@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, 
 Wentao Liang <vulab@iscas.ac.cn>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4704; i=alchark@gmail.com;
 h=from:subject:message-id; bh=V3K8xL7bNVN+ns8AQIHh0AGuzdUIQXbz5k/DUkYJUmI=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWR9veM16cHDd2d+W8cyNDpPTSmbuSrnR+2eDdNnb1Ve+
 3q7bZRXWMdEFgYxLgZLMUWWud+W2E414pu1y8PjK8wcViaQIdIiDQxAwMLAl5uYV2qkY6Rnqm2o
 Z2ikY6xjxMDFKQBTLcrIyPC5XujIgXAeXYcPEwyi+D5sl/maHD7JMzV8adzxxbytIVWMDN3Lpa2
 bI6rWsx2dPsNptpXTS/WZsiuZ/vo8+t+4pn/nFG4A
X-Developer-Key: i=alchark@gmail.com; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Drivers that accept ports without a "serial" alias each carry their own
line allocator, be it a bitmap, an IDA or a scan of a static port array.
Each one has to get locking against concurrent probes and release on
failed registration right by itself, and the state table already holds
the same information.

Let such drivers set the line to UART_LINE_AUTO and pick it while
registering the port under port_mutex, which serialises every change to
the state table, so the choice cannot race another registration and
needs no separate bookkeeping. Skip lines that an enabled device claims
through a "serial" alias, so that the device still finds its line free
if it probes later, and hand those out only once no other line is free.

Restore UART_LINE_AUTO when registration fails, so that a retry with the
same port allocates afresh.

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 drivers/tty/serial/serial_core.c | 68 ++++++++++++++++++++++++++++++++++++++--
 include/linux/serial_core.h      |  4 +++
 2 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 683ffb4fda92..e0f9551ff7f8 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3351,16 +3351,73 @@ static int serial_core_port_device_add(struct serial_ctrl_device *ctrl_dev,
 	return 0;
 }
 
+/* Whether an enabled device claims @line through a "serial" alias */
+static bool serial_core_line_is_aliased(unsigned int line)
+{
+	char alias[sizeof("serial") + 10];
+	struct device_node *np;
+	bool available;
+
+	snprintf(alias, sizeof(alias), "serial%u", line);
+	np = of_find_node_by_path(alias);
+	available = of_device_is_available(np);
+	of_node_put(np);
+
+	return available;
+}
+
+/*
+ * Pick a line for a port registered with UART_LINE_AUTO. Skip lines that an
+ * enabled device claims through a "serial" alias, so that the device still
+ * finds its line free if it probes later, and hand one of them out only when
+ * no other line is free. Caller must hold port_mutex, which serialises every
+ * change to the driver's state table.
+ */
+static int serial_core_alloc_line(struct uart_driver *drv,
+				  struct uart_port *port)
+{
+	unsigned int line, fallback = drv->nr;
+
+	lockdep_assert_held(&port_mutex);
+
+	for (line = 0; line < drv->nr; line++) {
+		if (drv->state[line].uart_port)
+			continue;
+
+		if (!serial_core_line_is_aliased(line))
+			break;
+
+		if (fallback == drv->nr)
+			fallback = line;
+	}
+
+	if (line == drv->nr)
+		line = fallback;
+	if (line == drv->nr)
+		return -ENOSPC;
+
+	port->line = line;
+
+	return 0;
+}
+
 /*
  * Initialize a serial core port device, and a controller device if needed.
  */
 int serial_core_register_port(struct uart_driver *drv, struct uart_port *port)
 {
 	struct serial_ctrl_device *ctrl_dev, *new_ctrl_dev = NULL;
+	bool auto_line = port->line == UART_LINE_AUTO;
 	int ret;
 
 	guard(mutex)(&port_mutex);
 
+	if (auto_line) {
+		ret = serial_core_alloc_line(drv, port);
+		if (ret)
+			return ret;
+	}
+
 	/*
 	 * Prevent serial_port_runtime_resume() from trying to use the port
 	 * until serial_core_add_one_port() has completed
@@ -3371,8 +3428,10 @@ int serial_core_register_port(struct uart_driver *drv, struct uart_port *port)
 	ctrl_dev = serial_core_ctrl_find(drv, port->dev, port->ctrl_id);
 	if (!ctrl_dev) {
 		new_ctrl_dev = serial_core_ctrl_device_add(port);
-		if (IS_ERR(new_ctrl_dev))
-			return PTR_ERR(new_ctrl_dev);
+		if (IS_ERR(new_ctrl_dev)) {
+			ret = PTR_ERR(new_ctrl_dev);
+			goto err_free_line;
+		}
 		ctrl_dev = new_ctrl_dev;
 	}
 
@@ -3402,6 +3461,11 @@ int serial_core_register_port(struct uart_driver *drv, struct uart_port *port)
 err_unregister_ctrl_dev:
 	serial_base_ctrl_device_remove(new_ctrl_dev);
 
+err_free_line:
+	/* Let a retry with the same port pick a line afresh */
+	if (auto_line)
+		port->line = UART_LINE_AUTO;
+
 	return ret;
 }
 
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 9ac1ce1c10b5..a6955c446eaf 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -1135,6 +1135,10 @@ void uart_console_write(struct uart_port *port, const char *s,
 /*
  * Port/driver registration/removal
  */
+
+/* Set uart_port.line to this to have uart_add_one_port() pick a free line */
+#define UART_LINE_AUTO		UINT_MAX
+
 int uart_register_driver(struct uart_driver *uart);
 void uart_unregister_driver(struct uart_driver *uart);
 int uart_add_one_port(struct uart_driver *reg, struct uart_port *port);

-- 
2.56.0

