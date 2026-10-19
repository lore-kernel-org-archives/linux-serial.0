Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792440422;
	b=RlmWkNK3U5c89Ex8RD7KC07OduCtk92R+BClGiba00kMJOV/q+4roEBPj+Zsq6A3nSVe
	 5vhdbkbSpdNkrgFmdSbJat9rywo6Vgi8DKsrMcrIymLvUAL2RWxcQK/smVu23WotpSviL
	 u1ghTUjjpmEunWO61TUhYAvO4wtPGBSzkTEYkE0scIaeb/VP7vqCkO27soLrli198GKBv
	 R+w3fU/azMwb5gXaaNitJtjLFIs1/i7xcVbYqEvk9CPcN6aDC3RfzJ/Vnd6yz1LLLbAGb
	 z/dTklVk9+Cn3RAXaLWon0tEUkgWPPpBTA4CiA1exxIyfKPqL9kOiDaY7g4IEZlVmKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792440422;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MQXVI025privUEtANhdwM89LTKKhsWNz40cUmpuugYc=;
	b=hBK/RF2A/uUS38SM1J1Af8Qjdmg9ncbYg++JpIMqw39iRvkYuAIzc+sVme31vkfzC6Li
	 sfXo3TfgrWZ32n25JzoaMO2rw80YwqE5b5FU2EGAOi8YvqzA36scOwN/99tkIXRMacAih
	 XHcKk9jIM1vzpcjuUGYh6fUsM3Sxs5IP5DOj6Ifb4wWv8so1sDLc8DGmGb1K3vC8gdmZ/
	 pPs8HRUYbRcSZ0iwHjbsonw0HdcIJFS9dAyUvihtoL79w66LmAdWnMyEcnwNE+QsdUaPz
	 iExFjrOdRhxCfWFaaqjD/J3lB9ZhkH7X5SXXL5wODTv33yjAeqfD7efvZWUJXmaB9ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Z0mwdAZT;
	arc=none smtp.remote-ip=209.85.221.181
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542A0606A31C
	for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 20:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 542A0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Z0mwdAZT
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5ead5ff47caso584979e0c.0
        for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 13:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792440421; x=1793045221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MQXVI025privUEtANhdwM89LTKKhsWNz40cUmpuugYc=;
        b=Z0mwdAZTrhQsrFAWnmaf4+LGT9x+W+BMs8zyNOThm3icLQe29j1vwCnAgVBH7Mex1m
         qhEbE9zybpU8dNzkTLgY6FEQdhAf7T6SV99GuPvFIKAThCMUA/Sk2n2AQZJeUqVY/R8O
         ou1FNzc8jqXtQvheh6k8uBsZ3znXwiWPjX9GuSi4Dq2l/byJfkt23I2AWc3779v7m+Vc
         0crrNiS4Mn+DD3+6x1PebiNwSl6PpxID41wJ2bUtMuq+GUyyQ/h/lzTN4ey8sjwOS5Nd
         6rN5vyPCrj/wngt1DZN8S99qFLMYh5jQH8MLzJSAqx1Iz9KQZcSNHuBynkL5j711TuSk
         Oq7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792440421; x=1793045221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MQXVI025privUEtANhdwM89LTKKhsWNz40cUmpuugYc=;
        b=UNekxa8QfpGzMPzhVDaH9e10iRGBtKV/AzOANY5sBTjmDBxjff4OXVWOJ8kI7to+IH
         jgOyoALihi+MmczkqtIkspdTl0Gdq6fU8lTj4PeRRLI/p9MzJYaqiKqfyIZOOZfQm50f
         UlPn4NHa9sLqMC0PdSl8wOj+MR5ednihME2e3a6DkH6SUB/zQmmdvhNSi5GEU1oiuyOS
         pGEhRnRVDocxfaEZ2uzHdACvD9DKekbk8OIt1zvs2xSMVD6sWIYWkTVS/3zAbCrydZIn
         5o5KvyUkKQjkTsjI58n1u1nfJ0IosbPjfos9rESKD7YVExQnEmCkAeh+KBLl0us9KV4K
         sOiA==
X-Gm-Message-State: AFq9FYLiEYw2g+RrQbcY9s9OgyU6idlfeq5BS9lmZu/wtG5RDC5mLQ0Y
	uwld61j8hLPTztbcKA1K+X+G3DrYhK4X06x0mMT0XA3UInTxvsi97HL0jqbBWxyiOe4KFg==
X-Gm-Gg: AYBFou1ELIhcUOZoK9nPAQdJeLGxxhfvcK6jBhsdj0A/lbibDlXoOwbzK9dfwDD98rE
	i+wAeNFpMKjIhOc9ZqwrCk5Fd3vAIGTtXJxCP6dlwAggg3j/DraB9ydITI8dQ8EbRKeKSKPRZmM
	l0GuOdJULv+AAQYx6KRC8OaZuzKP81PNJp/L3ZfDCcqhvZJhcoUN/7RxDrBtHWFO/QVXXmm8YNa
	/dFD30Mvuc64jg1e/dGyoR0Wvp2m4S9sV6PJdqWaMtfX61LqNgormkmaNsh1yEF4q/eqDkg0l5J
	7EFi8ZiAC6fQLKzSeFwVl+J+tbEhSZ+pAnBFrAKXERO2hrlp0rJto4b/5Jvbo3wRlsmcQ/hTSaC
	GU5G2M1sSC6OCoiz+S80MUdNI57HriKHZeJfGXyPdiXacLUj3r6tvyUzn0gyUh7LEfGo873BmuC
	LyRbA1XhA4M9d9Cdj0cgwhD28bQhynWH4p6NZ/RUY2bUbxsX3RsM3B/XbJFkSMT4JYcfP7o4oGQ
	GuXrXTKFpLr+Yk08mqj/ZV3L/AQEM8SMXqSTW1cNZ0wwKot+jP2CcFlQN9fu7rMQqIWwUKPukMz
	5Zuw/+Y=
X-Received: by 2002:a05:6122:4004:b0:5ea:7126:38a7 with SMTP id 71dfb90a1353d-5eaaa62c43cmr2437882e0c.13.1792440421005;
        Mon, 19 Oct 2026 13:07:01 -0700 (PDT)
Received: from MaquinaLab.. ([179.179.244.163])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ea9b4776b5sm10451611e0c.3.2026.10.19.13.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 13:07:00 -0700 (PDT)
From: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
To: linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	Andre Przywara <andre.przywara@arm.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Enzo Adriano <enzo.adriano.code@gmail.com>
Subject: [PATCH v2 2/4] serial: 8250_dw: Only accept a contiguous DLF readback
Date: Mon, 19 Oct 2026 17:06:11 -0300
Message-ID: <a79114e72d029732db6764935dde12aa5d497706.1792439398.git.vinicius.eduardo.pedrosa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792439398.git.vinicius.eduardo.pedrosa@gmail.com>
References: <cover.1792439398.git.vinicius.eduardo.pedrosa@gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dw8250_setup_port() writes all ones to offset 0xc0 and treats any
nonzero readback as the DLF register. DLF is a bit field starting at
bit 0, so a real one reads back as a contiguous 2^n - 1 mask. On some
Allwinner SoCs offset 0xc0 is the RS485 control register instead
(UART_485_CTL in the A733 User Manual), whose implemented bits are not
contiguous. The probe still takes its readback for a DLF of fls(readback)
bits, and every later divisor change writes the fractional divisor into
the RS485 control register.

Only accept a readback of the form 2^n - 1.

The probe itself is unchanged: it still writes all ones to offset 0xc0
and then restores the old value, so this only changes how the readback
is interpreted.

The A733 reads back 0x19f, and Andre Przywara observed 0x9f on the
A523. Without this check the A733 RS485 control register reads 0xb after
boot; with it, the register stays 0 across 300 termios toggle and
restore cycles.

Suggested-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
---
 drivers/tty/serial/8250/8250_dwlib.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
index 325793f20256..1b0192efe162 100644
--- a/drivers/tty/serial/8250/8250_dwlib.c
+++ b/drivers/tty/serial/8250/8250_dwlib.c
@@ -225,7 +225,11 @@ void dw8250_setup_port(struct uart_port *p)
 	reg = dw8250_readl_ext(p, DW_UART_DLF);
 	dw8250_writel_ext(p, DW_UART_DLF, old_dlf);
 
-	if (reg) {
+	/*
+	 * DLF is a bit field starting at bit 0, so a real one reads back as
+	 * 2^n - 1. Any other value means this offset is something else.
+	 */
+	if (reg && !(reg & (reg + 1))) {
 		pd->dlf_size = fls(reg);
 		p->get_divisor = dw8250_get_divisor;
 		/* Keep a hook the driver has already installed */
