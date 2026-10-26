Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793013822;
	b=5RgTi0ic9LyH3bNa/hUWXgMQJKM4xHmJGAJkPsHYZ388mW7Ck1Bg8Q6xhBVaIU28dE7T
	 B917Vytcn72l7vievfnmZ/6xiiVyJFDfKa6o89JEg53Z3OSs0ViJWUyIf0o3vis5aONvO
	 IbpCf/WjREm7aAi8DUvif8GMbp7aGnK5FbJDOe8s8xhfUI6Yrubjj5wzQaJRgg+E4bykh
	 tQOKrfVv3uH6ZAtPluN0QsKcmBtYYHJ9YUoJsuNpPSEI2+osdjHedW3k722gY/POQtSGK
	 TcvLVQPYVLs8B7gBf2JQX/OWUckSv898L2XzitChx7haiaZWH+EdIOvaMvLgeufGTag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793013822;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=ZVnVrRYLB+qKKrukA39OJ5KX7KFcwt/Dh/drOtJ/Eyo=;
	b=GI12vUTnOv7ZQP/DpXwkHBOdVT7e9Jxq8lB9v9lChdMkbaf/w/8Kh5QbjFqyUps+q9BQ
	 qs78clhOxq+RIByoVslSt0vUIGB2BbqW0jpSN8dJChX3rkuXHtsX9GRstJCpFhgso7M4e
	 IHomESuXvf0qabO0peen+eEiZRxeFsT0LAIEcbSXYzk+h2HoMxq9a7IUckxNcVzJmchYl
	 EdqxNvTzgFEatzvR7pTIihaKwaiPBk+YitzmYTiT7ZlQeF9E6gh5yHO4ch+0wii7ZwVl8
	 s755recFJoenFY7g5o1uOKrRrnJA/dIuqKXUjlw6MpMjDljc9D+nDKqQhWIQZ74E4SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iDTtyrE9;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5509C60A2630
	for <linux-serial@vger.kernel.org>; Mon, 26 Oct 2026 11:23:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5509C60A2630
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iDTtyrE9
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48e10a70540so1574426f8f.1
        for <linux-serial@vger.kernel.org>; Mon, 26 Oct 2026 04:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793013821; x=1793618621; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZVnVrRYLB+qKKrukA39OJ5KX7KFcwt/Dh/drOtJ/Eyo=;
        b=iDTtyrE9BVqqKPSXE4cXO8eADEeCatz8AddAjfjI/JB/R7KGCfZeodzaZwAlz34hXl
         l0UAS4jSeak3Yvm1K5KWk0aDOJO/WC6D+AQnWVSt/P8ccuf+2FTLlDJ76zxoUo733Ep/
         IeMQRF5OcIClCU0e9RldG3qDyKXb7mw5dWiVv+2pIJLJihFIxtuGVK5b1q4/amsyH7Xn
         gyLvD+5zjPO4HIrzWY5TYn6QYRy2PaD5o1BJU++JZ7s94zcCT0moJ6Dd5YY44TJU3nRj
         hqzsJ4GZxThKOIG63XI5Ks5RKAFcYCzFpdoNYc72BuvdBPP3+mWrBMxLEq20phZq1MB8
         g84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793013821; x=1793618621;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZVnVrRYLB+qKKrukA39OJ5KX7KFcwt/Dh/drOtJ/Eyo=;
        b=lYRu5AwuODwL8Mr6JZpL0NUGf4Crj6iWOoO/VRHae3OOdNa4jvyhxkNZssZ3vabG8Y
         rlJM0hkDtcXUp3Z8cLsIP1Bzewdj9QiW4lQJ4c0NPt5LZT7i4xW+/HbgetdKE2Y5l122
         TB65Y5FctyGn4zPEm9hblXQXktk4xUiubYDrmEp5lacHPEw1h4nvrAo76zCciusw7AHW
         siFILhiy95QrTF8mabyivQXC0jUUf40kgdqBKRag6aOWi0zegv8iHSzDrK7JYudgfLUz
         VP6AKw4bPgDcK2RtQPQxLUsPkqoeg70DejShYRZ/sHpDeSqPbbbnYOohLjVrmL3tWugS
         875Q==
X-Forwarded-Encrypted: i=1; AKwUvBz9DvPhWaRokLdA5w9yNGnnFaSxpVlOgoOcgkGt3n7Vkc0ej3IE1fGCncxhCEoCingpBoMBIyJlSQ0KsVY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ0sJmzBM0C2SCr0AW1CKShrO3i6a76m2oARKZhEZr9KmepHR1H
	PrSWmHGaCr0knHQ9bJZovZ+DXF8wGJeWuSl2k30miE8p5jDGtBUTD23z
X-Gm-Gg: AYBFou0ftHNJmiArj5iiNtxFIDkN2oTW0cVAKRCoSkuS9JTUbkakAquy2+ZZMROVchk
	gSrrQhSra79t4EEUQtuzc2c4hxejpmxRXAHMhZKhgxwV2K3tbE5EJEjGFLCRTUTxuYjdNw6sD9S
	8VvXSBzRppzh5mDYRLXtPrx8646toyiuRTFaIkLzEGkW+MMCTmCK5BZhHvj9PS2+0vqBTf3c5oO
	k3ywIzyVs8RMF5PZd4dhd+JECWJKt4iMFumpkr77UN58PM3wTq17y8i1Ct9e1pwclung4/yy+jS
	u5xQmtdAzrkVUKm1ZCqMWkoOh9FahkXTLSULI34gLjpG5bK3/2YkiGww16YsYSiBkY84bJoEW18
	Sd092JfgvcGE8q59xjUIgLw+ESNBw/YAbIlo9bU53dO5otymR7/+ASsuZPTc3x5Xe2uBmHp/CMA
	j3SpYm7p5Iv4lYfAiSo+ExQ5/VPrJVbm1l4edcA/lvdfirM68owCnFgu32Ak4dfHfaEvVB1xzGz
	e8982n+7eyo7iFZ+i4lFAmJbxrGGO78V8Hpwo4+eLkl03y95NalGu0zBVNrHiw3HaS1RdN/oehX
	bRoio3WG8XdoiRrD3n2JIs4EGuxlnf9JFkARJ6s=
X-Received: by 2002:a05:6000:2408:b0:48d:f5e7:bb77 with SMTP id ffacd0b85a97d-48e3eab5a61mr14950329f8f.0.1793013820776;
        Mon, 26 Oct 2026 04:23:40 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c4:a702:d301:482f:657c:9770:475e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdfb8esm15959263f8f.54.2026.10.26.04.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 04:23:40 -0700 (PDT)
From: Biju Das <biju.das.au@gmail.com>
Date: Mon, 26 Oct 2026 11:23:36 +0000
Subject: [PATCH v3 4/4] serial: sh-sci: Toggle TE when restoring SCSCR in
 console write on SCI
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-g2ul_sci-v3-4-b3097163edd5@bp.renesas.com>
References: <20261026-g2ul_sci-v3-0-b3097163edd5@bp.renesas.com>
In-Reply-To: <20261026-g2ul_sci-v3-0-b3097163edd5@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Kiryl Shutsemau <kas@kernel.org>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, x86@kernel.org, 
 linux-coco@lists.linux.dev, kvm@vger.kernel.org, 
 Biju Das <biju.das.jz@bp.renesas.com>, Au Dang <au.dang.jx@renesas.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793013815; l=2314;
 i=biju.das.jz@bp.renesas.com; s=20261020; h=from:subject:message-id;
 bh=05m98a4wCXyibckYyionDlpRiTiYXuxhqxZ1PhGSbGg=;
 b=bKAOy583UIZlEm+R8TR5tzfEPZMqzZolU5PmQM9oM2xSnSvxn5og0ZRbtXW+xozXhpatxmnaV
 xcrrVCu8raAAVgRgpEfD7LcDkqXrqE9q9R84hWIaIqRheB6OTl6ciuw
X-Developer-Key: i=biju.das.jz@bp.renesas.com; a=ed25519;
 pk=yzD2T1OLS3lEYflbk64xhLlxhk75lZ+NoOtkTOqrlVw=

From: Au Dang <au.dang.jx@renesas.com>

When SCI0 (PORT_SCI) is the system console on RZ/G2UL, the board can
hang at the serial console output stage during boot.

ftrace shows the following sequence:

1. sci_transmit_chars() is draining the TX kfifo through TXI
   interrupts with SCSCR=0xf0 (TE=1, TIE=1, RE=1, RIE=1).

2. serial_console_write() runs in the middle of that drain. It saves
   SCSCR=0xf0, switches to polling by writing SCSCR=0x30 (TE=1, TIE=0)
   and outputs the characters with sci_poll_put_char().

3. It then restores SCSCR=0xf0 in a single write. TE is 1 both before
   and after, so there is no TE transition.

4. sci_start_tx() is then called repeatedly with SCSCR unchanged, but
   no TXI is ever raised again, so the drain never resumes and the
   console hangs.

The RZ/G2UL User's Manual (section 23.3.6, "SCI Initialization") notes
that changing SCR.TE from 1 to 0 or from 0 to 1 while SCR.TIE is 1
generates a TXI interrupt request. Without a TE transition, the TXI
that would restart the drain is never generated.

For PORT_SCI, restore SCSCR in two steps: first with TE cleared, then
with the full saved value. This forces the TE 1->0->1 transition while
TIE is being re-enabled, so TXI fires and the interrupted drain
resumes.

Signed-off-by: Au Dang <au.dang.jx@renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * Replaced to_sci_port(port)->type with sci_port->type in
   serial_console_write().
v1->v2:
 * No change.
---
 drivers/tty/serial/sh-sci.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 1a4d9467d2be..35a2f721bf56 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3456,10 +3456,14 @@ static void serial_console_write(struct console *co, const char *s,
 		cpu_relax();
 
 	/* restore the SCSCR */
-	if (sci_port->ops->finish_console_write)
+	if (sci_port->ops->finish_console_write) {
 		sci_port->ops->finish_console_write(port, ctrl);
-	else
+	} else {
+		if (sci_port->type == PORT_SCI)
+			sci_port->ops->write_reg(port, regs->control, ctrl & ~SCSCR_TE);
+
 		sci_port->ops->write_reg(port, regs->control, ctrl);
+	}
 
 	if (locked)
 		uart_port_unlock_irqrestore(port, flags);

-- 
2.43.0

