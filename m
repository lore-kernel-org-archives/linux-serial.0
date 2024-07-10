Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332CA192B7B
	for <linux-serial@vger.kernel.org>; Wed, 10 Jul 2024 13:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720618160; cv=none; b=hwQ4QLAlx2K2ft54i+SrnK+CQlFYx65xiW1zREkxa2Qoda483HNYLI7Pul5FvdCxQjwkrob1nrO5SXqiZRwgD9RM/u5a5Et8eHrQBA0LsPfBtRnYlTReGeNH+hD6b4HF8Dromi9JqiPRfsZRZkC5kxb6Mb2EcvGnhPOdPp8uj7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720618160; c=relaxed/simple;
	bh=AwciVWBN6o5FqHKJ5LPF4pXKyx3wKFnc8wjZffp2tFk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O831WxcjAB6LjaEGjjsGySTHB7uyZF/qdmVSP+ooteaI/Wdxf5BPJ2ciHfd8zIrjN58QhbAUu6wEO0oCjFILxwN9JsRgbqqQ1dvTK5LXgW2EpQuotDtNx301AFBuaadbsBghC3fKf8WLqdO5hAtTbKpcp2aWEeyvLnezr+b85hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l8eIPKS1; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l8eIPKS1"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-58b3fee65d8so7410906a12.3
        for <linux-serial@vger.kernel.org>; Wed, 10 Jul 2024 06:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720618156; x=1721222956; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B1ovYW2wp1YdZUcVm4+EsuNX58Iw+I3DZAQaUJWfuBU=;
        b=l8eIPKS1i8Pdf5MeXmKBdw1LgaZiExhpyNpbFL1SJs/RTH+H3DdMh5/VqI8OydKt08
         9l+eNDz5tYRD0RkAPpoTkltbgNSzwRjgWHQkwMr5+vlpHvxMg1xlKdPPokwNKtuWRq98
         X5kTJPZqw4dIUjWKEosen+HadEkaJUy7QAOnIiyoG6LRIKmXw8a574DkMaijNiMsnm6F
         QP62FxP0PzWSp3ikCp3/TS8PyE43nsCihhHDbQNgnpxfncJ+CLQaUC3usW0ONmLgy37u
         4uMGvyrkCO1G/Zbk+s6OqpbNYMLDtvIj1nO98aFAC7fkpHmsjo4PwUBpsrQ3AvPsQYxl
         BrUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720618156; x=1721222956;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B1ovYW2wp1YdZUcVm4+EsuNX58Iw+I3DZAQaUJWfuBU=;
        b=NvEvrVTD+905uEI8FhsTNkG5ZWtQ3L04KoVOI2+wzrkYCIUE2amGIXjRp5oHDOqUlp
         QpBrMSKR+COPaEvUcfA8Xnq5xezKJU9dTFOC1k16ne5114XCQ2xavauiQOtVGctKBC3t
         EkIFyb+lFr3neFhrvg4f+nP2p9gq1SHZ6v50tl+Yv2ywVt/nJ2X7/JXpp+0SV4xizgmD
         MhknZt/J6SLpV5fuaJ/L8HfaLv/XbDZ7k5mmIXn1hetiSt3sKGKnpZWlIDeR6NMFWn4+
         wiVERnzWTvRk+8dkU+gZbzoEzh4SI2DjLjZ0pIl6BiBWVLHoWdUf2l1xqZOPnNoJ059S
         x+MQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfxbHxJ6jz03GzkwxgTFf6lYlrU8nCoA2e6hSnQ/rT7kTIfY57f6h+wVgP+DYQ9gX3U71eCVEeRUOynA03hypDTJBaDNpKinJ6qEX4
X-Gm-Message-State: AOJu0YxODeyM8PGsZRPPVU85xT+b30g4HIXG/9ocJv6HjX8yd5B0uD77
	QkYOS78ugPaoL524IB6YBhJwQJAtix5jl92mW7X/LtjVC09kPh2nW02/82HZncY=
X-Google-Smtp-Source: AGHT+IH0wfyOVdRhcW2jRiu8H4odPRc9NSHsemNyYVnlGxE+R2CgMqKnHWhRuSXSeVw2EKEQKgf1Pw==
X-Received: by 2002:a05:6402:31e6:b0:58c:804a:6ee2 with SMTP id 4fb4d7f45d1cf-594bb56ea1cmr3092624a12.20.1720618156425;
        Wed, 10 Jul 2024 06:29:16 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bd45a162sm2204844a12.68.2024.07.10.06.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 06:29:16 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 10 Jul 2024 14:29:15 +0100
Subject: [PATCH v3 2/2] clk: samsung: gs101: don't mark non-essential
 (UART) clocks critical
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240710-gs101-non-essential-clocks-2-v3-2-5dcb8d040d1c@linaro.org>
References: <20240710-gs101-non-essential-clocks-2-v3-0-5dcb8d040d1c@linaro.org>
In-Reply-To: <20240710-gs101-non-essential-clocks-2-v3-0-5dcb8d040d1c@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

The peric0_top1_ipclk_0 and peric0_top1_pclk_0 are the clocks going to
peric0/uart_usi, with pclk being the bus clock. Without pclk running,
any bus access will hang.
Unfortunately, in commit d97b6c902a40 ("arm64: dts: exynos: gs101:
update USI UART to use peric0 clocks") the gs101 DT ended up specifying
an incorrect pclk in the respective node and instead the two clocks
here were marked as critical.

Since then, the DT has been updated to use the correct clock in
commit 21e4e8807bfc ("arm64: dts: exynos: gs101: use correct clocks for
usi_uart") and the driver here should be corrected and the work-around
removed.

Note that this commit has the side-effect of causing earlycon to stop
to work sometime into the boot for two reasons:
    * peric0_top1_ipclk_0 requires its parent gout_cmu_peric0_ip to be
      running, but because earlycon doesn't deal with clocks that
      parent will be disabled when none of the other drivers that
      actually deal with clocks correctly require it to be running and
      the real serial driver (which does deal with clocks) hasn't taken
      over yet
    * hand-over between earlycon and serial driver appears to be
      fragile and clocks get enabled and disabled a few times, which
      also causes register access to hang while earlycon is still
      active
(A wordier explanation can also be found in [1])

Nonetheless we shouldn't keep these clocks running unconditionally just
for earlycon. Clocks should be disabled where possible. If earlycon is
required in the future, e.g. for debug, this commit can simply be
reverted (locally!).

Link: https://lore.kernel.org/all/d45de3b2bb6b48653842cf1f74e58889ed6783ae.camel@linaro.org/ [1]
Fixes: 893f133a040b ("clk: samsung: gs101: add support for cmu_peric0")
Signed-off-by: André Draszik <andre.draszik@linaro.org>
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

---
v3:
- add git commit SHA1s (Krzysztof)
- add link to wordier description of earlycon issue

v2:
- commit message typo fixed
- collect Reviewed-by: tags
---
 drivers/clk/samsung/clk-gs101.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/samsung/clk-gs101.c b/drivers/clk/samsung/clk-gs101.c
index 85098c61c15e..9769c00b6ca8 100644
--- a/drivers/clk/samsung/clk-gs101.c
+++ b/drivers/clk/samsung/clk-gs101.c
@@ -3946,20 +3946,18 @@ static const struct samsung_gate_clock peric0_gate_clks[] __initconst = {
 	     "gout_peric0_peric0_top0_pclk_9", "mout_peric0_bus_user",
 	     CLK_CON_GAT_GOUT_BLK_PERIC0_UID_PERIC0_TOP0_IPCLKPORT_PCLK_9,
 	     21, 0, 0),
-	/* Disabling this clock makes the system hang. Mark the clock as critical. */
 	GATE(CLK_GOUT_PERIC0_PERIC0_TOP1_IPCLK_0,
 	     "gout_peric0_peric0_top1_ipclk_0", "dout_peric0_usi0_uart",
 	     CLK_CON_GAT_GOUT_BLK_PERIC0_UID_PERIC0_TOP1_IPCLKPORT_IPCLK_0,
-	     21, CLK_IS_CRITICAL, 0),
+	     21, 0, 0),
 	GATE(CLK_GOUT_PERIC0_PERIC0_TOP1_IPCLK_2,
 	     "gout_peric0_peric0_top1_ipclk_2", "dout_peric0_usi14_usi",
 	     CLK_CON_GAT_GOUT_BLK_PERIC0_UID_PERIC0_TOP1_IPCLKPORT_IPCLK_2,
 	     21, CLK_SET_RATE_PARENT, 0),
-	/* Disabling this clock makes the system hang. Mark the clock as critical. */
 	GATE(CLK_GOUT_PERIC0_PERIC0_TOP1_PCLK_0,
 	     "gout_peric0_peric0_top1_pclk_0", "mout_peric0_bus_user",
 	     CLK_CON_GAT_GOUT_BLK_PERIC0_UID_PERIC0_TOP1_IPCLKPORT_PCLK_0,
-	     21, CLK_IS_CRITICAL, 0),
+	     21, 0, 0),
 	GATE(CLK_GOUT_PERIC0_PERIC0_TOP1_PCLK_2,
 	     "gout_peric0_peric0_top1_pclk_2", "mout_peric0_bus_user",
 	     CLK_CON_GAT_GOUT_BLK_PERIC0_UID_PERIC0_TOP1_IPCLKPORT_PCLK_2,

-- 
2.45.2.803.g4e1b14247a-goog

