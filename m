Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2FC194C95;
	Tue, 24 Mar 2026 02:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774320564; cv=none; b=SoCLq0RsuMF0hsQk6nRVnzE5R/BFb/uaylmYB9utNTh4WFgzxDPa4N/A2MUHUWbfyDXbSX7/MvydTAE7rDZHA8ASfVxREGwn4yjnNnzu1eIgjCfHPpU8wuwmGod04Fd16LgfAHPEiMnXm2ogz1j8rA0XvFJoS/BElgzOCOSkd2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774320564; c=relaxed/simple;
	bh=QKGHQPu96SUjjXJWz3Q5Kk+rY1e05/U4ilwyoqTMJHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a46Nvj+7OKO8DxyrSEAckdi8vv/e1QQ23GiNl6RWEwu05DY5w/sF9Esu4mVktwU1ccay02FJXbOWfMa8jOlNRx//EM2/oMn7XTG38V/2znpVx5oRuNF0To7UOSIEriHdLJt8DU5fz3/UH+wK/m1mgOb8Y1hqddNx4CEtpC8xFP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=t24doI5Y; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="t24doI5Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1774320546;
	bh=MwnzpEmV001Lnwtrm/+xTMEqD/Zl5WTJLxCkJF0RDWM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=t24doI5YTMBN3G6Qt564YiEV5A2NstglGO/7/5Z4SzCjtCCv6dfBRuMoSI7+zRP9N
	 DF2JBL/4u6ajEivIYfdPrDtLWNFiIAvbxHOxsBIT3HW3bfcMDSdOpk4LuS1+L1nMv6
	 ASwPwu6ovy0r+VqxKdw5Kdj0vSlX/GA8Nhye+6tk=
X-QQ-mid: zesmtpsz5t1774320541t42f9849a
X-QQ-Originating-IP: GXYWvu8OfDyrTQdsRFvpq2WHWIUNA8jI8zvOen2e8QU=
Received: from localhost.localdomain ( [116.172.93.199])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 24 Mar 2026 10:48:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12893628811713433287
EX-QQ-RecipientCnt: 14
From: Kexin Sun <kexinsun@smail.nju.edu.cn>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	richard.genoud@bootlin.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	julia.lawall@inria.fr,
	xutong.ma@inria.fr,
	yunbolyu@smu.edu.sg,
	ratnadiraw@smu.edu.sg,
	Kexin Sun <kexinsun@smail.nju.edu.cn>
Subject: [PATCH v2] tty: atmel_serial: update outdated reference to atmel_tasklet_func()
Date: Tue, 24 Mar 2026 10:48:57 +0800
Message-Id: <20260324024857.3244-1-kexinsun@smail.nju.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <3bd295ee-1607-49db-a12e-5a4d4fc81c5c@bootlin.com>
References: <3bd295ee-1607-49db-a12e-5a4d4fc81c5c@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-0
X-QQ-XMAILINFO: ODcDgdcDagQKQw7AyUw48tthoW26QR85q/Lkwo8aal5kuAUaIrNkOxqw
	jOGhUGLbuhPH/y6ExvOJ+IMey4sS7wqREaHlNygIz6HAid5fPLy3Fya/VHagPERDzWbmVdf
	Y7Zm9da+Z4vu/nQoYHj3kYDMV0mKo6llnIsO6VXV9RGzqI10mI2PATgezuA38CdTvjMbp/C
	vu0lj/vkBv2oZU7OPOpLAuZAaRjj/82OeEjcDdPyZjKGsmYbl7nqbE4VTSzDGfuxf0knliX
	YRT1PYzTZVRCALnzfU+riYD1eiGXkDxh2SAI0rqVQjMtxfkL6kZpXR7lgW4SiUkHaPWxoSM
	PHCcIdVeWSsEmM4ztGe+SwYaoJpebJHCMh8QM5BE9TTJIlv8BM8jKRGRCPbvWdM+1bdx3Wr
	0+7jZUpS5Z++mAsvfb/zJ7Jt5AGujBNMSQ2Wu2fO8c69Spu4AvX06Fh7IzfUR8kM7kf7fAj
	BwNZHfgGfnI28UC4IzN0gIijkazesbeQPMV7tdkguSbml5bHCzWuU7pzFKjtUD+HdMiHAXx
	jYUxKAajRsXBYa9rj1FXbGjSj7/dE8o5SH9BmdEQvFEeDCClPb6Me61J9BgD4xJj0l+XMpQ
	/GWeU9eAtFprWADHAb6xa5PkSCC8z4t50z3GZmzIouG8jUDiPC68Vr3zgWADs4BocsH13mf
	ckYg7q6liQCBlUkyTjOr0Ih5Cd2awrSd3AznCpJT0trPiyLnVZ4C96U//v8kLx6Ek68UNAo
	x9W5WYxY4iMxewTrfuIuT3HnLUtgb3VonzY44ecMJFsCNoK77tmjevCbkfZgYps8veiVL7p
	EUNj6MY9H7vO7rSdWhavQrA+F+/AuJNK9KbQIH/rBG07iiWPSF4NKmvHwLoHJ5RXHAiytER
	ACOjdZYf/W1BrsVieSJmSx1tnxvg1TgO/gsP/pjN6YxNGDrfUIJaECwKzM+onswrPksbtjt
	G7FT990kSaQ+id+/AkkN7TgAFwMmp+kbOG25tA7FPf6jd/8Zjhrg0Lgm7lN3ifcvl5nia0w
	wUj42eTtvOVYIxndiA
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

The modem-status comparison that used irq_status_prev was
moved from atmel_tasklet_func() into atmel_handle_status() in
commit d033e82db9a5 ("tty/serial: at91: handle IRQ status
more safely").  Update the comment accordingly.

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

