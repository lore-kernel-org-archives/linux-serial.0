Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CB532D0F5
	for <linux-serial@vger.kernel.org>; Sat, 17 Oct 2026 07:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792223136; cv=none; b=eVI9HqPfLaDI7n0nvFUT3c3wgdUODgb1bKFKdNnZBL8dPRA9jAx3qJYcZyqQ9te/7Z8hhF49MsW9OasJAp1paaU8pTRzFKtma1ZunoyFeLrCtuzPd0+3xUO2qMXhm2KblE8pLf/iF0WY5M3KJX1e1mD3UBmWGwTowvKTmo9WMR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792223136; c=relaxed/simple;
	bh=Ing3Vja3nrFXgDMNEvQrOtetxsozW78cudR/qPS/oFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kw1GeB/76SMHs4X2eEGCpejwIVUk5Sv2WZFAQCFAD875+Vx75ZztlLbKgfZNX7P4uAiTfaSRSaomfQ2UfvhrtGbTkD+6pXK4NyOISjZepQVDQoYrfMkSOz5KlzLesaLQgmugH29A7MmMUNsBTW+TQf8R6pDIQ/wBMe6yRlbKeiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4YLGb2i; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4YLGb2i"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-9906034086cso183628241.1
        for <linux-serial@vger.kernel.org>; Sat, 17 Oct 2026 00:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792223133; x=1792827933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xOJGjg+lvYDLo4dWg7JB5b8p1Kepu54TYn5d9QR27hI=;
        b=T4YLGb2iEqrswCiHicsrczWEZ1o98JuWAbRAF4Nb+mio8cvotu8S+mG1x7BggoKpqN
         BGn3dqIqmZyFYyYx/+y0JNvqL5c3F4Wbne7vcU5TgKIUXeL/w7M0ZQ81PZrVEl0o+9lv
         5TEAe2rq2CNBWq9aHpSicFymYQiq5IRuAfyIY32I2uLBBqACtVPIaA+X7fhwZf9RoIbN
         1jBbs3dQZJNSUTlU+Fagoi2E1B8YxeK/pOvcviDoZ1wpTjmMSTPI+gCNc3loVE77lRd/
         XIJ7QRUP/zFR0Zz0lF/beC1TVEASJDnEvEDz8d2bqaJUkjS0dN7mL/5F5/ZiaIhpXFAP
         v8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792223133; x=1792827933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xOJGjg+lvYDLo4dWg7JB5b8p1Kepu54TYn5d9QR27hI=;
        b=KnKtHf7MlYLVF2SWaLIFOgD11VWHD4cUmICrYdiPVrfqey8sO9ICJqZU312ISr8koX
         +xLSPRQouw669ULVZ2GeqsAAlzA8vPkeDVGdLNYHUGcJ2HoLvs/lpVLeCEC1WeUcD+md
         5nEGyLsHCcxQ9QuuzCKNYqqd1UNYFREAa66bZtHgH5UyS90s2UdezCQMOK6E2FGGZjrF
         kBxfKepqQ14BqhkfDNUwubcDR7eR6cvBnluA7hYcd8he3ea/RUr2ot9/hcp664vGF7ls
         4xWuEUHnaxWFJ98he+i26HEMRRKBHLida7dT6Ts8/IBhm4fEKyP+8vGm1PJ9i+x+nDc7
         wIWw==
X-Gm-Message-State: AFq9FYJ0LQWeFTMid6+EaHml0Xj4hWUd2ZSRAGlvBttJEzw3sAU3ufuA
	oFRv5caC9XbBDLrwbN8nyJt1Le8LNrO8GjRaVoPYkaOIlm4QT1xlyrNi
X-Gm-Gg: AYBFou2BGpF3Xl2R2BGGzksYR7mD7H5RRcbtB+jU4vnFlW9A2YL1/kl5riIPVQfsJuj
	Al708wBdYHsNq8ZXVhMbjlZvcfiM/31UPrZZze2FsHGt00BMQISXB2GqnoTBr+ItLkrnFQMxVEV
	tFGTRUz0npB9B+YPGIkzWlDaWoBktdsk4QR27hguLk3VH+QBAZ6bq7DURkPU+V+ikCm0MMFfNTV
	pO0WfpoKVlfKbEybyM7i1SYIJqZo0/q96HeTvApjQXEOIuJxAmYgVcTWklu498tRlM3XXZLZg+h
	r0lWEVlQn2uihGB2VttRDYLPrKhGtDjQ84LdXRMtoWdpZCwHq7TflZ4ipinyd389t3jmrscnRPn
	W3T+m5T88UBE5f1vePFdqBLMpm55rNETSEMIuPknuiqW4jcwbp8i8Wl800wOiwVTIrJuK3gt/Dh
	ByXsEqmMwe8M0A6ELiEDfkxvhZyZFs8Izrd6bakW3uaOSHgWvmmSmwJpCZEb2ZLQWi/cXUXc4pB
	DdRdH0qni4b+j9v3QDBN2COHQUD8VP431iQmMksZb60bArEQq9L4Srgt2D5B1PR
X-Received: by 2002:a05:6102:161e:b0:7c2:b682:606f with SMTP id ada2fe7eead31-7cc3672ad8cmr521911137.1.1792223132871;
        Sat, 17 Oct 2026 00:45:32 -0700 (PDT)
Received: from localhost.localdomain ([186.151.100.62])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ea9b53cfdfsm3701836e0c.15.2026.10.17.00.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 00:45:32 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	pjw@kernel.org,
	samuel.holland@sifive.com
Cc: linux-serial@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sebastian Alba <sebasjosue84@estudiantec.cr>
Subject: [PATCH 2/2] serial: sifive: avoid division by zero in the clock notifier
Date: Sat, 17 Oct 2026 01:44:53 -0600
Message-ID: <20261017074453.62645-3-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261017074453.62645-1-sebasjosue84@gmail.com>
References: <20261017074453.62645-1-sebasjosue84@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sebastian Alba <sebasjosue84@estudiantec.cr>

sifive_serial_probe() registers the clock rate-change notifier before
it initialises the two fields that notifier divides by.  ssp comes from
devm_kzalloc(), so between clk_notifier_register() and the assignments
a few lines below, both ssp->baud_rate and ssp->port.uartclk are zero.

A rate change taken in that window reaches:

  PRE_RATE_CHANGE:  udelay(DIV_ROUND_UP(12 * 1000 * 1000, ssp->baud_rate))
  POST_RATE_CHANGE: __ssp_update_div() ->
                      DIV_ROUND_UP(ssp->port.uartclk, ssp->baud_rate) - 1

On RISC-V an integer division by zero does not trap; the ISA defines the
result as all bits set.  DIV_ROUND_UP() therefore yields ULONG_MAX and
udelay() busy-waits essentially forever, hanging the CPU, rather than
producing a clean oops.  The POST_RATE_CHANGE path additionally programs
a bogus divisor into the hardware.

On the FU740 the UART clock is derived from the CPU clock through a
synchronous divide-by-two, as the notifier's own comment describes, so
any CPU rate change during probe can hit this.

Initialise uartclk and baud_rate before registering the notifier, and
bail out early if the notifier is ever called with no baud rate set.

Fixes: 45c054d0815b ("tty: serial: add driver for the SiFive UART")
Signed-off-by: Sebastian Alba <sebasjosue84@estudiantec.cr>
---
 drivers/tty/serial/sifive.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index 4a445d285..cd2925b6a 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -604,6 +604,9 @@ static int sifive_serial_clk_notifier(struct notifier_block *nb,
 	struct clk_notifier_data *cnd = data;
 	struct sifive_serial_port *ssp = notifier_to_sifive_serial_port(nb);
 
+	if (!ssp->baud_rate)
+		return NOTIFY_OK;
+
 	if (event == PRE_RATE_CHANGE) {
 		/*
 		 * The TX watermark is always set to 1 by this driver, which
@@ -1022,6 +1025,11 @@ static int sifive_serial_probe(struct platform_device *pdev)
 	ssp->clk = clk;
 	ssp->clk_notifier.notifier_call = sifive_serial_clk_notifier;
 
+	/* Set up clock divider before the notifier can observe this port */
+	ssp->port.uartclk = clk_get_rate(ssp->clk);
+	ssp->baud_rate = SIFIVE_DEFAULT_BAUD_RATE;
+	__ssp_update_div(ssp);
+
 	r = clk_notifier_register(ssp->clk, &ssp->clk_notifier);
 	if (r) {
 		dev_err(&pdev->dev, "could not register clock notifier: %d\n",
@@ -1029,11 +1037,6 @@ static int sifive_serial_probe(struct platform_device *pdev)
 		goto probe_out1;
 	}
 
-	/* Set up clock divider */
-	ssp->port.uartclk = clk_get_rate(ssp->clk);
-	ssp->baud_rate = SIFIVE_DEFAULT_BAUD_RATE;
-	__ssp_update_div(ssp);
-
 	platform_set_drvdata(pdev, ssp);
 
 	/* Enable transmits and set the watermark level to 1 */
-- 
2.43.0

