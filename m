Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D6B1BFE00;
	Fri, 22 Aug 2025 09:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755856583; cv=none; b=bHU0WYEMjuI3sF7BCM+MUpJ9+0RltVjagujjkRzZn//W3v7AkHs8ldd3IVuM4PdS5lD1Kch95+sB1lNT2BirZlkVMLFddWTeiUoa2eTQsVWVMuC3oK8q/qev6y+pugpghC1OYpULGgStJ6p0cBZefqVQNaoMSXkr51QRJui/jQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755856583; c=relaxed/simple;
	bh=2givOylEnr0yX9tChhm21ireUXa6/Th9iVp9vfknWMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mb+FXJR1MLmOlfWWxKEnUsZDUKFZUoQ62rUCds2pkTV2k2drg2BUrnCC4JQH1N+6REuEkja/iFl7Vz9WAY9W1XGyaktvCfJDUKbsRJvws+QFEQPtablXCSJFJzdl3O/4pAGyO25wBcGjEFSr19bu6DRzj6meHl4epAixGzYAWzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Npwpj4Dx; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Npwpj4Dx"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-61c20e28380so754019a12.1;
        Fri, 22 Aug 2025 02:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755856580; x=1756461380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JtaeRXCFkR+O5mEXivZeTbeJaIoLBp/G3PsDU98MzXI=;
        b=Npwpj4DxpfNIoMcd4YPmt/Nm8dA+ctJkUMLVUjkU0fHuYbcs2M0I0Zb5skaMFLIx+g
         1VRwhyRtFd5M6RGCQM4tpFUB62QDISkwvC/I3EW7bK+AgrbApm+X8ny3WhdvgEjzHUzE
         egS7g9H9bcCq/e9ZV6+qOkN5SmrbaFRuR5mUvz9oqC6/wThHAfLqhyu65GCV+kzGlFOk
         TpBvWEGlgpgH5M8PQP0OiSWuyn8HHAuIXHgyERuSz6DX0zC9V7eQl7UJbeWTIbtbLhjd
         ngG6J6qByxLCXdv47De0qVVB48RN4d20t+ISIvmIW/nLBtr6Z3PbD1/IqV6AMbSqe6FB
         n9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755856580; x=1756461380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JtaeRXCFkR+O5mEXivZeTbeJaIoLBp/G3PsDU98MzXI=;
        b=tGeRSAQsoHa8IgA2hwVbqU1XxTwoaLdkxNkxMWs3Q2LDs2t+iAJD/ZYqXbjB9+g7+d
         HbpiNIONMpHGZua7awrWPhHAfgDCtwom5zXuCWETsesjR2aXcZUG9MSlx67ByEKN3L5Q
         vBUSmZIcm5Qf8fJO4BKDrCGh2Hs/nVEv4iyHmBJvmKtRybILpjaW8oWxPXanSig2R3LT
         WlLQO/lUOFiTWNBYAhgfu9e2ior81PMuv+0fX05dXanD9zN7U4s5i1GB+g4XoOINeEPg
         0zvLl7VNUK6P8jOzuRAJHmKBREvYJLqAl+TsreP/N3SA61LKc9grovgMX7Q+S/l6dQ+p
         jrLA==
X-Forwarded-Encrypted: i=1; AJvYcCWc4dccEfj3YOrz1aPV5/viVcpQ1pHxkMf1kMz/lctqOUtdRgwr91YHzEHVBTpO8woJdK7ixvNxi8LQ0AA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHkx1vDW5oocMRo+9SmY93FZFBpW2LFPGw3PJGZ7Qd+z18Zv8l
	jnq7qs1PGhoZThOYvB6uIigwBYNPpeysdg763mFoVIASJRMmrjUvEO5a
X-Gm-Gg: ASbGncsQOOcRvjTo2JJI5CJ90AyqgFR/qjAHOFxrLmQUdPH+kM4HNoWO09BvPNz+fdf
	t8F3s+M5CW45E6AYmhMbKgZorj6MBOSh9aelABA4WzXulB3g2xz7KWHjmDgubAb6IxB6NxScI0Y
	471k6Gsk1Pn9qVkUKJOEHUWc670xKklJnKIPL9XOrEm0Vkf+xsZs/zbdfzWPLMEtAl+PVWtLD8j
	rcq8z87fU/NvdGAFjdSMYtk4fWuLC9odGDg5uGx24s8myiP73sS0b6AOWzMMEWD4aViohDqwgfa
	C0dVdHXeU0+W2l1l9A24i1ksj3FDl4wvTIAhxTItsAo+pcmmUXFvch49zhFKYeN7LBne3OLBoQ3
	bvwUzl01PJ3uh6ZltVjLrVmVTbuo8wnod4o+cCCu74sXDHRZ2vkLf+GQBedKwfL4T5G/ZLwbPOK
	wsoDsX
X-Google-Smtp-Source: AGHT+IF/k4XTcpzBgvkI/JGQTo9MzSpeL581PIbIAwXl3racEgZAtIwEgGrL4eHbKYwnPJcSn6Q/AQ==
X-Received: by 2002:a05:6402:2787:b0:618:8702:522c with SMTP id 4fb4d7f45d1cf-61c1b28ab9bmr1899232a12.0.1755856580063;
        Fri, 22 Aug 2025 02:56:20 -0700 (PDT)
Received: from XPS.. ([2a02:908:1b0:afe0:2cf9:d2f0:ffe6:6e52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61c25709d66sm399027a12.22.2025.08.22.02.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 02:56:19 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	mingo@kernel.org,
	john.ogness@linutronix.de,
	tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH v3] serial: 8250_core: fix coding style issue
Date: Fri, 22 Aug 2025 11:56:13 +0200
Message-ID: <20250822095614.18108-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a coding style issue in 8250_core.c:

- Remove redundant NULL initialization of a global pointer

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
v2:
- Dropped extra blank line after gpios declaration
v3:
- Added changelog to commit message
---
 drivers/tty/serial/8250/8250_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index feb920c5b2e8..225bb7e4b89c 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -307,7 +307,7 @@ static void univ8250_release_irq(struct uart_8250_port *up)
 		serial_unlink_irq_chain(up);
 }
 
-const struct uart_ops *univ8250_port_base_ops = NULL;
+const struct uart_ops *univ8250_port_base_ops;
 struct uart_ops univ8250_port_ops;
 
 static const struct uart_8250_ops univ8250_driver_ops = {
-- 
2.43.0

