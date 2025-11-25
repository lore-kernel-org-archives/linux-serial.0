Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64453327C1B
	for <linux-serial@vger.kernel.org>; Tue, 25 Nov 2025 15:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764083203; cv=none; b=PMAoW7VNtxD90sJoa6Um/eE5BMZ07b8qgtIm5F1E6bkG/GWh5Lj36hihGNJrPbSd6z2MNUaDIT49E1pKPrqnGxJz3D2+G90yx4hfmJAGPjX7h9PjiukAMytlY8AJdFoCbFaAy2+doIixZtMBE9tE37YAtGvPRk+ch4rP/koQJwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764083203; c=relaxed/simple;
	bh=0XQJSgadsToJ4b5yIqyUB3R0b6zEChYhyXBoI9Dp4m0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RmynOGnFbfyIBIHHKUkhWJz+f/vWXN7jh5nW32hqGeeXJWKzjqfEAFodNUsjAG3JrQuik0WirOuBSLn1RQ3XvmN4tXwnsku+lSX4884IzbxE/omFqo9hAi8wASpLmfmtpXyph/FnljmHYT3NOQTnX4Xctr2mUutpUz/I/GYzUgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPvjpNL4; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPvjpNL4"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42b3108f41fso3426900f8f.3
        for <linux-serial@vger.kernel.org>; Tue, 25 Nov 2025 07:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764083200; x=1764688000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0NtGTkOpvHiixTJXzZ965OSOKBk0446FybRMcINNKk=;
        b=JPvjpNL4jNABCe40z6llPVEQExAFh2BVbkWsgagjeJL6Qv7i4zw0/yuhMGp//dbOa/
         rawrc5rGOniMYg54CXNi4YayVEroiaAq0/C42x7Bvph/hXssTkrDJPxPFvxJB4oNNImt
         ycqm+Z3Bsn9lc8Tzcp9zqjM3InFIZftPgHzQ7ZM+R38CGn5d3/sLQWYQaN+b0Xl9spnH
         M+o2G9Al9XFrjhom1JaQma0QvU/tBhyfh/2nUJaMbn/EjvB+2dWeHoNzCrYB8WG0Uv1K
         UFU4CEHQGdYyA00/tfc1Sll1537e61dt2/x90Y99mArDoQUJWqn6f/IFLU4n9H+KbnJ0
         pEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764083200; x=1764688000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w0NtGTkOpvHiixTJXzZ965OSOKBk0446FybRMcINNKk=;
        b=FhP9v+Qsjh2zeOLuc/9qAL+lqc6WtH+Hf8qZ3JC/gK2QA1LjuwzIbHTLGquTQPCBHm
         7gHlG4o5syCZq6My5lechNRbwUTe8Fy7B5KmjD1CITm3B6fx+3AFk0g5g1zptkKeCxzr
         9SAjC4+WXwpDOPIDbLMxIePunlwxRsLw0YE+2o4WTd9tDy6R3BJSIDBvt9F27JQTcCSs
         rqEbXDsd2YlXsEnEz1SN8/Thax12uUm70dKgLZ4P2xwy/auhyYqIyQx2B2guqAtTfEUy
         fQIhFX8vssS8EGELjqxGV3/q+0pCT04aO759kovdZ6mjbEloYDmn89x6rOmeWCf0ywSq
         CH5w==
X-Forwarded-Encrypted: i=1; AJvYcCWCDPBpQnIpLs/RDOMjd54UIuyj+24tpYMwLagTbwKq/VfzFqt6inhURcsPrWEciFARcR4OQGU1XUY7D5g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9pFouEuRopLcc4uZZ3HNRtoarCmfK2PfahNK4Ea2VWcxrGoxV
	h1YikRciRzlPv08gGzCtA6VXiMh0cDsbsbBJ/4jDn756x8ttx7b3+3BH
X-Gm-Gg: ASbGncudTRq4V/kAmdXSfuU8HAtq8aVgJyIKhWjrZ5Q5itXQ2nQ2MJ25HB/o25huoNu
	CdSjm0FmVUOaGEbH3FIvtyi0h2OlVVfmLj4OJnkFy0sd1HlNaFk9Mfoul95XzJjJ8mNjpCVScZN
	faTyP8w129qAqM3mE1cFnCoV02LvU/n5Lfx1k/NkyAJc6g7o9RK6987U3TtnDg13jDB6wJSm1+n
	6Kc/li+fO32kUcpLhuAx1mgpLpeSRMwHuORjet0fjo0SqxZG7MIVYhEx+cSquqVkKSyAZ48dkh8
	n54GzC8HupncBnORQlEYt7XhBhFvcn//bzXPcNmf+vBmcCJ4EncqNYtsXRIotG+kQiNOQZzdP0Z
	LZPiA04oTynP8kM9LbLLxjm3KKSXkwM6FxBlBvB177Ls1ArIikbo95bzGLugzmfXmlGHbzKhCDn
	icP7eqe2LYTp2Zk0DkIKPoUOu0OCVAUQzsT8Ui64l/j8YoDPANnyYWdAywqhvPQGlEsiWg07gSv
	w==
X-Google-Smtp-Source: AGHT+IFo0OhinOAI/UzHdmsqWHopeqG+0xTMeUG/vYAaZONgIemRGTkV9J/yAwaStUhaaQyLgihjhA==
X-Received: by 2002:a05:6000:4012:b0:40e:31a2:7efe with SMTP id ffacd0b85a97d-42cc1accff0mr17229344f8f.14.1764083199477;
        Tue, 25 Nov 2025 07:06:39 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fba201sm34797809f8f.32.2025.11.25.07.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 07:06:39 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v4 05/16] serial: rsci: Drop unused macro DCR
Date: Tue, 25 Nov 2025 15:06:07 +0000
Message-ID: <20251125150632.299890-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251125150632.299890-1-biju.das.jz@bp.renesas.com>
References: <20251125150632.299890-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Drop unused macro DCR and its bit definition.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3->v4:
 * Collected tag.
v2->v3:
 * No change.
v1->v2:
 * No change.
---
 drivers/tty/serial/rsci.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/serial/rsci.c b/drivers/tty/serial/rsci.c
index b5afa7b2a4a8..3ad6cb8e1d18 100644
--- a/drivers/tty/serial/rsci.c
+++ b/drivers/tty/serial/rsci.c
@@ -24,7 +24,6 @@ MODULE_IMPORT_NS("SH_SCI");
 #define CCR3	0x14
 #define CCR4	0x18
 #define FCR	0x24
-#define DCR	0x30
 #define CSR	0x48
 #define FRSR	0x50
 #define FTSR	0x54
@@ -119,8 +118,6 @@ MODULE_IMPORT_NS("SH_SCI");
 /* FFCLR (FIFO Flag CLear Register) */
 #define FFCLR_DRC		BIT(0)	/* DR Clear */
 
-#define DCR_DEPOL		BIT(0)
-
 static u32 rsci_serial_in(struct uart_port *p, int offset)
 {
 	return readl(p->membase + offset);
-- 
2.43.0

