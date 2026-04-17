Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02443314C3;
	Fri, 17 Apr 2026 15:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776440033; cv=none; b=ep4kmwBdsvM0PqllYLSWS2I6/dSvDxPeyozCxNlqjI588ZRPP4Qrf/1d5AndInNK5b/EdEGKX6qJzivlAgM3JToTA2GYEoDVXMf3urvy7jq2eXP6ShMfzdajQY0Fz1szKi3FyGsUXSrUsNyWf2As7vqU8TgbjdiZo7rzoOAdyG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776440033; c=relaxed/simple;
	bh=G1/C2+OJXrbp1b/vTRImwESyawyH0PGepnCv9IgnW88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nr1lZnTpVO2yfIib6lMQajzg6Ad+uR2wHDBoJ3UyxISfOkIcO/eXmXC82sDonRmlfhqJHjoNmD3nftgfB6B6RlXPYS2phDwdc+bdtZHnkoxIWhJJeXRC6Wbc7vSx8q8l6WlaN9FiZyWLwktwRGQaRJ5X/0VRi5O5CID9nZhaYF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=mv7Zkotm; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="mv7Zkotm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Cc:To:Message-Id:Content-Transfer-Encoding:MIME-Version:
	Subject:Date:From:subject:date:message-id:reply-to;
	bh=SrOuTDRQ+SPwftrBjxPzGmOX6OSsXdLvn+A6nL4ojqc=; b=mv7ZkotmJSLi+Q2fAB5/USojXA
	EM0kR2Cd8Z6loN1cUYDCQor8rpbV6Ta1P4jGSE+UfuegV0t3XW9dPF5zM7F82J8XXWiBMlqcSFV6A
	M8Se17rXdQ9brAn5+Mn7Yi2LDnrLnkpfGHfW6vNDABh2cffPjlid2I6cwE5BeohlXaJc=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wDkZl-000000006G1-2weW;
	Fri, 17 Apr 2026 10:53:45 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
Date: Fri, 17 Apr 2026 10:53:31 -0400
Subject: [PATCH 04/10] serial: max310x: update baudrate comments for err
 calculation
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260417-max310x-2-v1-4-b424e105ecac@dimonoff.com>
References: <20260417-max310x-2-v1-0-b424e105ecac@dimonoff.com>
In-Reply-To: <20260417-max310x-2-v1-0-b424e105ecac@dimonoff.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: hugo@hugovil.com, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, Hugo Villeneuve <hvilleneuve@dimonoff.com>
X-Mailer: b4 0.14.2
X-Spam_score: -1.0
X-Spam_bar: -

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

The baudrate used to compute the best error was changed from 115200 to
460800 in commit 35240ba26a93 ("tty: max310x: Fix invalid baudrate
divisors calculator"), but the comment was not updated, so fix it.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/max310x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index cf27e597ea41541331c8786fe4b4ded39b53d291..f689958736f71b15b7c113214cda60db4aa7c593 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -547,7 +547,7 @@ static int max310x_set_baud(struct uart_port *port, int baud)
 
 static int max310x_update_best_err(unsigned int f, unsigned int *besterr)
 {
-	/* Use baudrate 115200 for calculate error */
+	/* Use high-enough baudrate to calculate error */
 	unsigned int err = f % (460800 * 16);
 
 	if (*besterr > err) {

-- 
2.47.3

