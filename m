Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B039A39CD16;
	Mon, 20 Jul 2026 19:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576059; cv=none; b=B/8q+k7DbZ+6Pu0Xp09iLNT9whvlgNn2/3i9WoeGK8QtS9TnXiLxZLcbRWKkfT3m5RldQSxv+c8k/0XlfCrvjeayxdwlTLuHMK1oFhXDGIANsc6zKEJ41iBA/6HcPZBFAR1B7MnPyR79oGdarIrfJ9LVLaMVpnRTmyaQ8Q38qJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576059; c=relaxed/simple;
	bh=iS5x89S/6YljNPUqwggherspiOAPZ6f1Ghd8jsisM1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Im4UfaXScEeXTyjVRpmLXljaIYInkyXPhktEv5Tlo8XiIqjO74l+ifbQ7MTW3Kefu06/VAGxjJnIgO6ANQ7OOVmW8MXP0Us/myQaVBLPywOIv0GhhG6pP8Vl3ZJ79LvuDVL01A8jMoP4KTYE6kS/6Ir/8ZvfF/aQofg9hV+0W8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=cpqrcR69; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="cpqrcR69"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:subject:date:message-id:reply-to;
	bh=ygWDmtbGerKI272ML42PV0e9vea5LeS5A4vYiIPnNn4=; b=cpqrcR69kNlwLIF7Tvi/4VH898
	GMxNGup6KTwkfxDj+VeOPXjwxwW+Pno44FxkvRAmBDWViynVks5NDmVXRXuouuB+186BJghvt53KM
	xY7AsCmdkbjhF2QldCXj5DkDt3FMGWmymh/hTBAI2h/cqWV7b+O6KVa2MGRKl32/+Id4=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wltkm-000000005oB-0PNq;
	Mon, 20 Jul 2026 15:34:16 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] serial: sh-sci: remove check for zero baud rate from uart_get_baud_rate()
Date: Mon, 20 Jul 2026 15:34:07 -0400
Message-ID: <20260720193411.3517484-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam_score: -1.0
X-Spam_bar: -

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

The minimum baud rate supported by this driver is 0, so even for the B0
case, uart_get_baud_rate() will return 9600, not zero. This check is no
longer necessary since commit 16ae2a877bf4 ("serial: Fix crash if the
minimum rate of the device is > 9600 baud") so remove it.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sh-sci.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 787e7cdc5e9c3..92193eb26abf5 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2719,8 +2719,6 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 		max_freq = max(max_freq, s->clk_rates[i]);
 
 	baud = uart_get_baud_rate(port, termios, old, 0, max_freq / min_sr(s));
-	if (!baud)
-		goto done;
 
 	/*
 	 * There can be multiple sources for the sampling clock.  Find the one

base-commit: 782f4dbd1794b4f30dc116a7ca42c5962c409be8
-- 
2.47.3

