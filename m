Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BCE49C4BC
	for <linux-serial@vger.kernel.org>; Fri, 25 Sep 2026 18:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790360710; cv=none; b=aM+4tvi2IoWapq9rlLLqPaEdAJ82cx7QNOJve8BwKi6R82XCV6xwrZg1f9sDWqW2Lcqtk6/pG1xtjli+BzM5Ro85lfkLYR3RQ9WxzAOJ+dLFmzrobDKwWme8nxt++v6eaFIP2Er4dirwUIgLy2v/llZiKpJ7HZWpGgdAes7RGzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790360710; c=relaxed/simple;
	bh=5+xAhSNTy2MZHQVy/np/VjUsf51lDMQ2lB/7hMy0IF0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TR1IE79GYHT8cwJi44GNiAaLrGXeEICUB3wzdXzNQUsQEHjKFHyP4By4L7gYB2mYfp6o2xi2UqcxofVRbXtYAoCBMA41TkSfVhUNSEuOn+t/LA1Tz/uoZawT/DBoHjoJLWhwGs7owmj+e8l5Lv+AmoWBOKVwoepDA/nWVKdSgQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mp7RkX+G; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mp7RkX+G"
Received: by mail-pz2-f39.google.com with SMTP id 41be03b00d2f7-cc78e1a94b8so557604a12.0
        for <linux-serial@vger.kernel.org>; Fri, 25 Sep 2026 11:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790360707; x=1790965507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GWLCx0r8AlMgp4yLMAlnbb/AEeR6IQzmFOzYO3/wf50=;
        b=Mp7RkX+GcBeZn8URFmAjzRDA3ziK5gPpmgn1cKiBuGfrlaj72XTM+U/fqeY/iUQgf1
         dd9mi0ybaZyMnG1S7V1Zk8bxTiRJBHpEnRb1FOT1gioj0F0j+XhyWvuoweczw1rG56w0
         GOfqZNsp7dvS5tc6BzhdR4Jw29S+7GqYje3L3VqIXVp4r8LSHBFhdmOalobYBT9eANqW
         p4WytE+QHxYETVqW6cn3k/4IFeVp+Y+QnE2tuElDmTLHR0XTZu/OM/xiSHl2m719q2vz
         Rem6tDnAkNLT0NnHhss3QMFvbvIBm3vcZhvDeUijmTmjQ8bBBOiPbszFKOkhfCycsHth
         PhZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790360707; x=1790965507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GWLCx0r8AlMgp4yLMAlnbb/AEeR6IQzmFOzYO3/wf50=;
        b=Gc8YFv3upwY/vM4Sv9/RWekksWWVUgp4ScLQFNt5zpwvmfAXLttYf8Ln4K9+8nCpgH
         Dy27GeHpgU6LtLBJgW3wr2ffQLhZP/R3Gb0hQ2XrJVL7cUyRJqwPbYNgnJQXX1+mBblR
         /Dy07oaqBXhGtuqNIaWKTOtr/AEHcUABF1ZAgF4wX6CtxI2OEfw4RkYTRyaW4bQqx+jv
         4f6H1EWhvcRA5/aIJVYMyb4m111tqEYJVZiP4KMDQGLcSg2H8dvgEYo95y0qTR/RONPz
         HtmAXHjIu+ZZ/vw9JlrKanAdUzMTlXdQy4dje/WF3Oj6p2yzneSryIZNX0K9CrXiVvkH
         uP4Q==
X-Gm-Message-State: AFuF++nepTD84wQTDjp6IhD1yT3+TKd/lOXD5Oh8Mq/WJvE06877Rszt
	Ts+Z7TQgex+DzEbAbbZiwnt+UvRcOi5nFP9gcNS0KtIXZ9J7M97ZesCMYu86Jg==
X-Gm-Gg: AYBFou3KWlhvydEI2iqHBzKgozy6maWsaur+tpXQ4hCsG3zUWrTTUbnQIYB7gBoZ+C5
	2IXSvTtKk8eRUFR+4T4uw3W/oTAG97a/sJd+dnYLPkbGOCv1Z1B2VYo18gS5rho8ZY2DFKh6GOX
	T/ZQdxcSRQkssDyd6GShK4ZrA3hzxMejdxOvXIvFhYXrY9s9CYPF8+FQ1Rpx4xKmRbgFyaW7lK2
	9OMGt00aNSQdeKCAhCPL4fit60i7Ynim/FHMe4mXqwdq6BzaECET+w8yghvTSRr/3O66eg7WUNi
	vfzPHJDSosa3orcEzw3NvIThVBuHuvBR0eAwEdizW5bOYIOUVJQ7Z5kZfMZoachm7W6z/SvRGn4
	U+xZuE73kcwrUFqlfj1q5HIyOYqcP4K0tLDGS7GFGlMbNSOR6bz6kTeEGuRjoZeWF53cqmKfyBf
	UAJV5trA/1aN5L4i7FUtarZeD/9GCyUSAD5xx7qQJg4rfRPDLtjqE0s9zK1CdOkPKFaAUZj5HbN
	hpp2YsS9oc3Vd/WIR8fQ4AKDUt2bA/5hbtb4IauLgZ+blx6I0rVNtJ/uMZQApTCEEX74QQZfn4+
	bq0bGtILQ5BVSfgSEX4m5iqptbc2di3p6MB69SYknGpz5fIc
X-Received: by 2002:a17:90b:384c:b0:3a0:c8e6:ab23 with SMTP id 98e67ed59e1d1-3a0c8e6b96bmr1504783a91.54.1790360706898;
        Fri, 25 Sep 2026 11:25:06 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b8efaeb3sm5693240a91.2.2026.09.25.11.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 11:25:06 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-serial@vger.kernel.org
Cc: Timur Tabi <timur@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE QUICC ENGINE UCC UART DRIVER),
	linux-kernel@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS)
Subject: [PATCH] serial: ucc_uart: Use platform IRQ helper
Date: Fri, 25 Sep 2026 11:25:04 -0700
Message-ID: <20260925182504.54976-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid calling irq_dispose_mapping() by letting the platform_device
machinery handle it. Also enable possibility of handling -EPROBE_DEFER
and other errors. Handle before any allocation or anything to avoid
dealing with gotos.

Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/tty/serial/ucc_uart.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index 6b7dcbbacd13..c3c83a59dcce 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -1238,6 +1238,7 @@ static int ucc_uart_probe(struct platform_device *ofdev)
 	struct uart_qe_port *qe_port = NULL;
 	struct resource res;
 	u32 val;
+	int irq;
 	int ret;
 
 	/*
@@ -1247,6 +1248,10 @@ static int ucc_uart_probe(struct platform_device *ofdev)
 	if (ret)
 		return ret;
 
+	irq = platform_get_irq(ofdev, 0);
+	if (irq < 0)
+		return irq;
+
 	qe_port = kzalloc_obj(struct uart_qe_port);
 	if (!qe_port) {
 		dev_err(&ofdev->dev, "can't allocate QE port structure\n");
@@ -1338,13 +1343,7 @@ static int ucc_uart_probe(struct platform_device *ofdev)
 		goto out_free;
 	}
 
-	qe_port->port.irq = irq_of_parse_and_map(np, 0);
-	if (qe_port->port.irq == 0) {
-		dev_err(&ofdev->dev, "could not map IRQ for UCC%u\n",
-		       qe_port->ucc_num + 1);
-		ret = -EINVAL;
-		goto out_free;
-	}
+	qe_port->port.irq = irq;
 
 	/*
 	 * Newer device trees have an "fsl,qe" compatible property for the QE
-- 
2.55.0

