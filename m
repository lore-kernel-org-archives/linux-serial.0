Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795324322;
	b=gM0UzIL2nyEqWJcWi2KSy8aHrH5lwrs2sRV+qvmJ5PtWFv1zqIr4MaDVjJlcsacDr5Rg
	 D+DzyCED86x3WmcaPQHsMa9UhI3FcXrSN+EKPS3wW+lAcmV99oPfEXbwsomJSTUrR/IL9
	 XJYYLN/k1PJqSWiTwxu2SOnJif0HXmyl58DWQ2BS4P9gg5G8RWBCvAXoM8c9I5hX1mVEg
	 ZJ+wkrmen6lT38N+W6+68XgSYUAVrryYj0Ms7rSnN5+gOy+0lTWBO7kZMU0VT0CUUp4p6
	 PZijnubTrTxt6BNz9UsiO7Tt9tn+jE3Nksx4+rJJVjrF/Ue7ZFT079MnJyPIvLE37yA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795324322;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=h3aYzkwsAVHixWxdwIcvCBMP8oi7l5lLZeHXkqI9rO0=;
	b=zmqUi3KWj1xbZgXHAAH50uxmkBjZq4SEUlcyRbnIMkFQhxfxvVtBiEiPOqo2UK7D46E9
	 zYFI4JvZVcSZaUlz6eXSs/oI4/bMDADEChC3Gj3rvmbv1r13wZTyszAvTDjl2TbwUpZ4u
	 3NhmdmW+H/fpX25yg5j98zUuvOaon67b6oC7/2fH0yNC7JJGyCy/hpFj0ar+ZYJ+P6kIt
	 1buMYokFVUXggTwnqc2hPy1lgfBhVt+EeCf8i5OQjmKpTiMDlU7oo2Fu7xWLpXoEGq4zs
	 cLfjr/Hx/ZHU5Hhl2kjHT7LyPE63WnQt5wjT2SabVOXiSpvn1QXedTxkYHa3CH65idw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VTmeRHw4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB9A606A320;
	Sun, 22 Nov 2026 05:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VTmeRHw4
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795324322;
	b=JmAfGXx6Ppu7VpoITvB9LjzmPfBKFOFUV4SMMIRNHiQ1uJsdQ0qKyE6MrbAyUzisDE39
	 7khm1iGyxzitX4TbWFsfSshoorqVVCB/Qp+Zl87cwvVx6IQFH4cDEJ0FAhFSHdzSwvpUs
	 G4NYoFkB34txKN4AUo+nmThPcHt/XjnBBTTT6hQoYTN9qwuRZU3VQl4/wNg1jgqdT1pWA
	 eUKFFuwuxUqh6bXVt2iDB0LOJ4IiIRBJuq1QsHTfh2lgWqjzH0p1QBykFVyPhXjK1ebqc
	 cqj4/hNJzXS1OMhJGFIwSizDmzwCQb/wzr60n1epvjlpET9ohP4xWIjkL8X2LocCcRw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795324322;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=h3aYzkwsAVHixWxdwIcvCBMP8oi7l5lLZeHXkqI9rO0=;
	b=cPx4ULf1kRAnlWQ4HLP5abbncy8ScaqkJLn27+kyrcOuJNqkO2mz/T9J1B2IJ0mlOlHb
	 K4vkeQyyRReRKKv0arV9lAQ3NQL166Pe56Rp29HzwreoMiIq7R8ODDOKbYjpsdLkXSWJP
	 OVKMSs8Ih1UbCHZinxAmxWMQgbgkduJc7+mkNjVSKXTXxBMMcVCJZUaINR/uop5hjhPgZ
	 cFxdD/jLZcuowSkaDdBbfc3vwaAfZ57qiH62rUrALLpv2Gzd/UetHPfSDkDq8bxqv1qLB
	 IVTpeBb8uXBZC7w7157OjT/dLVdsd3hcZCvYhy9UMzYGscmeJ6Dsy3YDoeUAe2ZpcLg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A04531F000C4;
	Sun, 22 Nov 2026 05:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795324322;
	bh=h3aYzkwsAVHixWxdwIcvCBMP8oi7l5lLZeHXkqI9rO0=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=VTmeRHw42pTGl7pabUOoROQnmP6vI8MpZk/8K9WsR07gqf+h7iUvL2TkKC8xiXLsL
	 WRnovDBv/33RrlGsJicn6pQXF3nkkDvB23yExtWzDovRJZNZXy7rSFTfIaXaG7k9mD
	 40CqQx7vwM0zNqavkxf8elicQWpM+uGhZ60gfgPG3ATN+a41KJhQfGPkRFs3cbJBEz
	 ZF1qeIuJ8ED72l6K20TFmo7y6lff5T9dEXMUJScCu9VPGSRFviBmTkqgLlP1iyIscb
	 VKCAyhm0LG56B7O11alLJquZIiWA2imNVYs86mmwtYQJhIL4njn6qzEibkTPrHkr8o
	 cQp787O0iJabQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 019DB4BF16;
	Sun, 22 Nov 2026 05:12:01 +0000 (UTC)
From: EMCP333 via B4 Relay <devnull+emcp.enser.io@kernel.org>
Date: Sun, 22 Nov 2026 05:11:23 +0000
Subject: [PATCH] serial: tegra: do the baud tolerance math in 64 bits
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
Message-Id: <20261122-b4-serial-tegra-baud-tolerance-v1-1-39907382281f@enser.io>
X-B4-Tracking: v=1; b=H4sIAHp5AmsC/yWNwQ6CMBBEf4Xs2VVam0r8FeNhuyxQQ4ppCzEh/
 LutHt9k3swOSaKXBPdmhyibT34JBdSpAZ4ojIK+Lwy61VYprdEZrArNmGWMhI7WHvMyS6TAggP
 ba9sRd2wNlJF3lMF/fgeP55/T6l7Cua7WhqMk6Ko91ajiZbudDUbWcBxfsOFZvqIAAAA=
X-Change-ID: 20261122-b4-serial-tegra-baud-tolerance-fc6308ac8c64
To: Laxman Dewangan <ldewangan@nvidia.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Krishna Yarlagadda <kyarlagadda@nvidia.com>, linux-serial@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 EMCP333 <emcp@enser.io>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795324319; l=3906;
 i=emcp@enser.io; s=ultron; h=from:subject:message-id;
 bh=GXIk9AQVC2K8tTVlGwvFv8h3R35+N798W5Ucf2ARQvE=;
 b=G/EK8deCg7wtRnWgFOWfHw6ZHJdTUxTHk9IExb1Hv0blbsDDDpfAiqpVu6QkkfQKOSwAbdcP1
 S/HZNlh3NuCBcJO0Y/rrs+31xMe2Wi3Jftk2RnFdORd89ryHdXoeAi+
X-Developer-Key: i=emcp@enser.io; a=ed25519;
 pk=5sG48Lul+Vn7OzXu3VZrCWk5uvEFPYMXYnAV0TZR/tY=
X-Endpoint-Received: by B4 Relay for emcp@enser.io/ultron with auth_id=1598
X-Original-From: EMCP333 <emcp@enser.io>
Reply-To: emcp@enser.io
Content-Transfer-Encoding: 7bit

From: EMCP333 <emcp@enser.io>

On a 32-bit kernel both halves of the baud tolerance logic overflow
`long`, so a Tegra20/30/114/124 board whose DT has an
nvidia,adjust-baud-rates entry runs its fast UART rates at the wrong
speed, and the range check then reports the wrong speed as fine.

tegra_get_tolerance_rate() returns rate + rate * tolerance / 10000, with
rate = 16 x baud. For any baud above ~986 kbaud, rate * tolerance
exceeds 2^31 and wraps, so the adjustment comes out negative and the
clock divider rounds the request down a further half step. On a Tegra
Note 7 (pll_p 408 MHz, nvidia,adjust-baud-rates = <1000000 4000000 136>),
read back from clk_summary:

    baud      wanted uartc   got uartc     actual baud   error
    3000000   48652800       45333334      2833333       -5.56 %
    1500000   24326400       23314286      1457143       -2.86 %

Both "got" values follow exactly from the wrapped arithmetic. With 64-bit
math the clock comes out at 48000000 and 24000000, i.e. 3000000 and
1500000 baud exactly.

tegra_check_rate_in_range() is meant to catch this, and cannot: it
computes (long)(configured - required) * 10000, which wraps for any
delta above ~215 kHz. The -5.56 % above reads as -0.18 % and passes the
window, so "configured baud rate is out of range" is never printed.

Found through Bluetooth: hci_ll moves a WL18xx on uartc to 3 Mbaud after
the firmware download, the host lands 5.56 % low, and the controller
never answers the next command (HCI_Reset times out). With this change
the controller comes up at 3 Mbaud and scans. Tested on that board with
an otherwise unmodified driver on a next-20260422-based kernel; 64-bit
kernels are unaffected, as long is 64 bits there.

Use div_s64() for both expressions so the result does not depend on the
width of long.

The code and this changelog were prepared with the help of an AI coding
assistant. The submitter has reviewed both and takes responsibility for
them.

Fixes: f04a3cc8d455 ("serial: tegra: add support to adjust baud rate")
Fixes: d781ec21bae6 ("serial: tegra: report clk rate errors")
Signed-off-by: EMCP333 <emcp@enser.io>
---
 drivers/tty/serial/serial-tegra.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index e93873a1d1..b5973c0a95 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -18,6 +18,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/pagemap.h>
@@ -365,11 +366,13 @@ static long tegra_get_tolerance_rate(struct tegra_uart_port *tup,
 {
 	int i;
 
+	/* 64-bit: rate * tolerance overflows a 32-bit long */
 	for (i = 0; i < tup->n_adjustable_baud_rates; ++i) {
 		if (baud >= tup->baud_tolerance[i].lower_range_baud &&
 		    baud <= tup->baud_tolerance[i].upper_range_baud)
-			return (rate + (rate *
-				tup->baud_tolerance[i].tolerance) / 10000);
+			return rate + div_s64((s64)rate *
+					      tup->baud_tolerance[i].tolerance,
+					      10000);
 	}
 
 	return rate;
@@ -379,8 +382,9 @@ static int tegra_check_rate_in_range(struct tegra_uart_port *tup)
 {
 	long diff;
 
-	diff = ((long)(tup->configured_rate - tup->required_rate) * 10000)
-		/ tup->required_rate;
+	/* 64-bit: delta * 10000 overflows a 32-bit long above ~215 kHz */
+	diff = div_s64((s64)(tup->configured_rate - tup->required_rate) * 10000,
+		       tup->required_rate);
 	if (diff < (tup->cdata->error_tolerance_low_range * 100) ||
 	    diff > (tup->cdata->error_tolerance_high_range * 100)) {
 		dev_err(tup->uport.dev,

---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20261122-b4-serial-tegra-baud-tolerance-fc6308ac8c64

Best regards,
--  
EMCP333 <emcp@enser.io>


