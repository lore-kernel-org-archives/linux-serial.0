Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73CC3E8676;
	Fri, 10 Apr 2026 15:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775834447; cv=none; b=CG0PA28vzsF112Pg0+2lofO1hBsHqHoxbbVRQSQtzxk/pxJu5rX5/82I71ejmzJvfuLq32ysnTvERVrcl5iH7ZrF1DY+TNTfNkpJdU7ffrgtYQlbwJ8ca8eoCOCslWMqzpYZRufRGeAUmeZqSgW10uGVBdzRZmDwVmHgkhoSwmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775834447; c=relaxed/simple;
	bh=mRlKMaYbmvEt/EhhUAqfvw/bHBc5DdnsELRV/lnGmdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nlTbwTPMi/043GrVy2tXbt4cwrg9PNy2qsl0lsG3MKmKQIqjHlucUa/14m0gWpCG0Ol2b3OM0yhWhwfZDoy5q+pE5ou6og8ugpNBeKBbZsq25BCty60YqHYGo/Se2ZJCbRfXtgCeVVvI64Tzs52Se+mTaj4xMKROGapbALqrMnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=ZJ2duZyL; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="ZJ2duZyL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:subject:date:message-id:reply-to;
	bh=frUl2/N5c8FQBGdAuzQFsb9h+FkYcMGoBn9caKJfRxs=; b=ZJ2duZyLsdowmDvYpjbLASauWs
	j7xOEoJoHkWlDbtaPQ3W/SmYcFShZtv7r+r7oS3zhVsvrxT3hrhpcddhzevFbU8SdvpBFil/Uqb+U
	YwwyMzXHGQMhGgashKQgM3G0WPuFE3pv2RtnMEwhjeoMHVyZAuV0LNbBQaz7uJH/9SeI=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wBDex-000000008Ub-1fUE;
	Fri, 10 Apr 2026 11:20:40 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: hugo@hugovil.com,
	biju.das.jz@bp.renesas.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: [PATCH 1/5] serial: icom: remove check for zero baud rate from uart_get_baud_rate()
Date: Fri, 10 Apr 2026 11:20:09 -0400
Message-ID: <20260410152022.2146488-2-hugo@hugovil.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260410152022.2146488-1-hugo@hugovil.com>
References: <20260410152022.2146488-1-hugo@hugovil.com>
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

The minimum baud rate supported by this driver is 300, so even for the B0
case, uart_get_baud_rate() will return 9600, not zero. This check predates
commit 16ae2a877bf4 ("serial: Fix crash if the minimum rate of the device
is > 9600 baud") and is no longer necessary so remove it.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/icom.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/icom.c b/drivers/tty/serial/icom.c
index bcdc072084860..b6399d86a0bc3 100644
--- a/drivers/tty/serial/icom.c
+++ b/drivers/tty/serial/icom.c
@@ -1396,8 +1396,6 @@ static void icom_set_termios(struct uart_port *port, struct ktermios *termios,
 	baud = uart_get_baud_rate(port, termios, old_termios,
 				  icom_acfg_baud[0],
 				  icom_acfg_baud[BAUD_TABLE_LIMIT]);
-	if (!baud)
-		baud = 9600;	/* B0 transition handled in rs_set_termios */
 
 	for (index = 0; index < BAUD_TABLE_LIMIT; index++) {
 		if (icom_acfg_baud[index] == baud) {
-- 
2.47.3

