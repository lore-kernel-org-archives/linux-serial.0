Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA989314D1A;
	Sat, 21 Mar 2026 11:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774090823; cv=none; b=aRSoeT9UYOSzINtfVcTniLZs3E6glRU+jxbPreZWnFQaKIbKZxSS99mue9xNYmT5fgXEt/lP1X5Il+tbY/5ef1TMUZxuiTAcKKUGG/71K70pQi+ie0ovAQ3WFN9ajiTzmgOjE1qiYi96/wUfKduf0zXp2Hn/n0jI5C9EarbHs8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774090823; c=relaxed/simple;
	bh=nJFWXH1Yw+Okap4epgm+RMBt0nQQzrlNLx8duX/PMyU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DQR/8ZhojTkVnPUZ7TIHVSfeRSHmFmpJ2HCQ7a9k/GuYeyia+cGsE9u8hbbcwRl0dzpbFlGaqj6isXoCQE69oeyyXDnpECB5gpaWOe3N2T1UW8rVZLuAFhZGZZBdbBMKnubDuaoLXaxOl2twbkCFs1+NkwjMYvjiMKoxfr0Bo44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=TOj6ewfo; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="TOj6ewfo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1774090803;
	bh=UgY+bZ2Pi6QuHNfOxNlG1hBhelRVpcsVVWMlo73lQbk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=TOj6ewfoXWmHXq+zEYstE28wYicA98sch5hMpPc28v0a9XXs7V9RdUVdqoPvyCVg/
	 ZFAGvpvr8vS8p2wuWSveSFjcbvv8kHH35Trc3b/d8Jt+/NO9nCYkXKG9sVPBZVvbdu
	 2YkOQOjwvfHyHaUeHkcoMcuetYgzYxeVHODKA09Y=
X-QQ-mid: esmtpgz13t1774090799t5668526a
X-QQ-Originating-IP: ZrdkgHjjMhQNONcsOHs5GV8Jhia1x2+PRCdOqvj8ShE=
Received: from localhost.localdomain ( [116.172.93.199])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 21 Mar 2026 18:59:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4747820319854510971
EX-QQ-RecipientCnt: 14
From: Kexin Sun <kexinsun@smail.nju.edu.cn>
To: richard.genoud@bootlin.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: julia.lawall@inria.fr,
	xutong.ma@inria.fr,
	kexinsun@smail.nju.edu.cn,
	yunbolyu@smu.edu.sg,
	ratnadiraw@smu.edu.sg
Subject: [PATCH] tty: atmel_serial: update outdated reference to atmel_tasklet_func()
Date: Sat, 21 Mar 2026 18:59:56 +0800
Message-Id: <20260321105956.8401-1-kexinsun@smail.nju.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-0
X-QQ-XMAILINFO: OcWb5bwj7h2b99SD7OedsNJ64JWT9Ndbg4jw5BK8j2+VbaWnifXC/u96
	OPOnQKxHxFhpRM56T1HudNj0zSBMgq4RrAuoqKD4pjA8R84x5gSf+O1dXo9q1QfXDw+o/9c
	/ziQku1dgoFuiT4PCttFF8UPJ0WmLi1kSjoV4JPntiktrfFu/5G5anJA29IMQCP4jrXfOFa
	9oDpNT16v2hFAOE4zS2F36Vidx7b3t0dipOvVw7jMF7HjMbOp8l16aAAokroBDadNGjzhZA
	U6TXwoVX1xlxYPmW/u5wjD8Io75u5iMqNCkhhQ+51U7Y/jc/dWeKnDMvMR2BYvlYGhjqFtA
	fhtBN5kRFT+wAgtdfywiL6mp3K5FGqdXojs9ObIl0X5KEYoa95SRH9M14XJH654v+uw79ER
	2uets3lkSoOzWUXfgrBZ5VX2kHQDDKNRQXaNgUMyLCGy6t/v1LzanyZKrxLGwS5NFs2fYi2
	TOHOR1JhUxvBVRtz9d6i9kdZgcs4bKoyjKdMeCKRtG68FCtrUZK39jps8BiUSiOqnYyl12P
	7NyJiqDoW6Pp9+snwZA44XypJyPt+7a6bx1oQ4CYTl4oCGrB3crdTp0lj3kuavtksDT5cWr
	yY47tOV5eJdo0wW0o2Yqirzw3tn89Z4fBHJQvBezC6XSmKmJqmcDEAIhtfsQu/A4EDCPzJE
	XvvDo91brkv34z2i/Bv8Bm4VYcGwQRzOyU05/XmrLqxduwUf2apQD+BCtfVjvRs6QLF0XoB
	mU3acPH/vG1SLquYof5TM1y8hNd3jPsCVgXgdH7Nn1EG773sk1S2pWctj9a/ztk3ATnXDMe
	IEw716JLBV5Vu4HcXytlOSf3/gsJTdGnDC5V2EKGhWSrCpY+hI1QAFjY8pekabds5FMdHco
	XBD8mllMrs90SPGbu3E1N6sRGNkM7i0EfZ3ZbY5ArpE+wa2CKusxR+0K0NmgLPbCD+9uGCp
	ESAD1lUUEKrJW+TdxxB68J4W9Gtbe3ZkCT4heOJ0WwZTTgQgZw/vWukzFdMRucsocma90Xn
	zkr2rc3jozejCWYLosP4Z8K6En07a7jSf0K0ozSbIRkqPbWqBCZO+vpjUwj+uLW4C4Hx0HH
	7nvDZSZ+GI141a07Vj2JSLGtTWb5NXO6Q==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

The modem-status comparison that used irq_status_prev was
moved from atmel_tasklet_func() into atmel_handle_status() in
commit 2c7af5ba65cf ("tty: serial: atmel: rework interrupt and
wakeup handling").  atmel_tasklet_func() itself was later split
into atmel_tasklet_rx_func() and atmel_tasklet_tx_func() in
commit 00e8e65870cc ("tty/serial: atmel: split tx and rx
paths").  Update the comment to reference
atmel_handle_status(), which now performs the comparison.

Assisted-by: unnamed:deepseek-v3.2 coccinelle
Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
---
 drivers/tty/serial/atmel_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 08dd8f887956..5d8c1cfc1c60 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1927,7 +1927,7 @@ static int atmel_startup(struct uart_port *port)
 		atmel_uart_writel(port, ATMEL_US_FMR, fmr);
 	}
 
-	/* Save current CSR for comparison in atmel_tasklet_func() */
+	/* Save current CSR for comparison in atmel_handle_status() */
 	atmel_port->irq_status_prev = atmel_uart_readl(port, ATMEL_US_CSR);
 
 	/*
-- 
2.25.1

