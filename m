Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792588404;
	b=VNu1vWO5lyNuF7j+dB5KQC5p33GpfOUhhsPaGqCl3u+NYop/HuiR9iLKojWMU5FyCszs
	 /j8GKCBlcEaPIiF9FQh8FTPw6ZvcvxX2Zd8g3SbPG85cGpOcdHKAgSgZZL2ENRgNFKYcC
	 zGKS7BUMvLPSoB0fz4tCjhG/+SyzRCCmEz1wzz47fBnhLqlsZVsTjkfVR2UO41y0bDibx
	 tdAeqyADwnvVt42UqE5sqXhWMkYPLEzBv/hdXRYcMfLoZiQg6haH+mGb99nh+bTKRJswO
	 +MikArihoEOi7hKFqJmETxaSJ2xjYEzlqIPoUlPOf6OoqoJyC1zQ+sSbO/dmM2kqnDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792588404;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=N5RE4VrUqgRrVxPGuEVRRhHI7VFdRUfeZKkkzZJ3khE=;
	b=iPcV0fTBXaQ065XbFcr8RI5AJsiSl+V59y1l2YKmXAYKlTqJzwBBW7iV7nIXYNzs6SuP
	 Q/Nqk7Jle/1iXNR5tU4A8B8IB9WLrArMY0OMLYTjI1MjmgfBWCp0PX9Q+yv0e1DHqTnll
	 LM+e9g9IF+AXfcxxY6dFo1qsiKa4FZtCDAi30KtH/Hhhm6rVC8MoJJkZEoeuiEdc7RVdG
	 ROHn/2W01DouN7bXi8pW6np8YIisBag/AK0eM4Z6N3WhRysheyY9Eo+vhyns46fy1XiNF
	 gyQ14YJbO3XFx/N36C5kJx9R00yV0OLz7wKWLZgsWsQKEOBCIq2q3j1jv20IOfowpZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dftScbiC;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2289560A263F
	for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 13:13:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2289560A263F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dftScbiC
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a16aaf2067so8400255e9.0
        for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 06:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792588401; x=1793193201; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N5RE4VrUqgRrVxPGuEVRRhHI7VFdRUfeZKkkzZJ3khE=;
        b=dftScbiCP6a1eeHD6IgOv+dKCjqK1dz6x1afgj7VzlVqPUjsONvI6Q3epm+bf8uCm9
         DCSI1YdG54tNCbuIrxPP+BCLMm30oJ1Pxk20zK1EvYVfmoviRWhbxk842sdHQa23ogYK
         iM9UlyPPdCNuwdG8zQSw9vZnW0REm3+X0N5OS8G4r1Dt8UULxCpiEsSHbo+1nzL32Sev
         wtqp1xXvO68YaKo8vgYEFw5FEXt+CfU6k3fgF1DH6pPr1fsF8CdS7Jrt4pgOtue+R2ho
         YEsG/OP7Hknq6sDgOQ79L6++ZMXPv2kX+Wl2fFmJcxFpJETI1KvtI7LJBXzy4bXVPaSM
         HwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792588401; x=1793193201;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N5RE4VrUqgRrVxPGuEVRRhHI7VFdRUfeZKkkzZJ3khE=;
        b=138tkA93+tP0giv+gSHNj8bKVRWcfXmmD9KpYHbyxKmTWS6O5mpUdfnZJ3NGuVXrYO
         i1z8lJTBCZ8A1JZgfAMeP/IU8bM4vjbIT4tqHPIYJcieWDDyVn0HTRZAbXF9oDKhGjOA
         I16AGPvsJenNS7o22LxxTkOAd0dcrxsm8WTtgy0btaVStLv53acbPk4xPCWLfmcNd+tO
         0gCO6W/yNQBGC+zFvT3GgvitmaYbxEpdKgeN+Pl2uPA9Tyqntb00VHp1p9JVN3V6QYAK
         clKzam0o3IBEe/YA+TzZIsHAQUY2875sqLYLeiQBQiMAZFy2onNoeo6vgvx5RZSonicB
         Gvtw==
X-Forwarded-Encrypted: i=1; AKwUvBzslXDqZShjUq9e+0grIVJH0kYOeQWqDqCVsTNlN2ZN/0TzHhY+x7X826sDqc3ag+VFvQwzPi22QTScsrE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKWwyvLNiBnrdh/YyazXvYkWH/ruTkrNOuv/ys5DrIc49XlrqHP
	1cWh/g/CIwm66KuOkpqGAfSWn2UaM7vFgoAYmt7pt1GeCZHdhPfpZnL1
X-Gm-Gg: AYBFou3teomllObyOSZJDi6d/TYJrtAP4+2PVamOTyzq37zstcekkPEFvOqoMYwA4h5
	FfW1gWV2GRVSnifJQ7gcOISEsRQMuFHcLSeImPCj4pE1XjWsawAWegVTI/ms+oFnyOJWMRCp86X
	6fsW+r04puWAOGXl4ALL2yCOCyDlpMOaX3ltl9Ctlr/26kzTWY8xzlDX6lg2qC2rB0WfEJgrm6E
	eWnCiBpDNBgxbVJA04lZbox3s7L33F4ZKDY7ovdBGOsveUJ0VCX5ebjaZPBmEtxcYYIl6XMoB/1
	70dkMqZV0Kaqm01lFnGO03oXh1vXn4F+imBfAXAl4cxF8zuR7JwP4H/c4N23MobqwYpbM4MbSec
	yLV2mZHtgNqcqI/PNV+QnWaof2dpfxyFOhdpkXDK9rn6V3dpT5U7NJuB/qxTCnQseFEqDJijapT
	/ELzA3FgNdKpDCqSs1ld4/X5J9Ig56YmKAdU0gpmI91YqfGRXpRFT1MTVeRWejxf40XpKhyexHR
	PL+SGHEbWUA+F/iUHqd8roMSn7kDDfiTAgEH2lwJGQ3crRHy4VWPJOBRZE5hapLZw5C1HhTRmvr
	FsIm42RSGKXHad0w
X-Received: by 2002:a05:600c:6385:b0:4a1:e0d5:293e with SMTP id 5b1f17b1804b1-4a1fdb0d18amr43127735e9.21.1792588401415;
        Wed, 21 Oct 2026 06:13:21 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c4:a702:d301:39f4:e118:e272:79d8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e258358c1sm5655560f8f.43.2026.10.21.06.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 06:13:20 -0700 (PDT)
From: Biju Das <biju.das.au@gmail.com>
Date: Wed, 21 Oct 2026 14:13:16 +0100
Subject: [PATCH v2 4/4] serial: sh-sci: Toggle TE when restoring SCSCR in
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
Message-Id: <20261021-g2ul_sci-v2-4-b4e038220018@bp.renesas.com>
References: <20261021-g2ul_sci-v2-0-b4e038220018@bp.renesas.com>
In-Reply-To: <20261021-g2ul_sci-v2-0-b4e038220018@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Kiryl Shutsemau <kas@kernel.org>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, x86@kernel.org, 
 linux-coco@lists.linux.dev, kvm@vger.kernel.org, 
 Biju Das <biju.das.jz@bp.renesas.com>, Au Dang <au.dang.jx@renesas.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792588395; l=2226;
 i=biju.das.jz@bp.renesas.com; s=20261020; h=from:subject:message-id;
 bh=eBrM0bnW7fIX8UCFI1hlYQ/wtkJYAm4pg8SckFVkEUs=;
 b=exl2dPJM3XU3wI5tFcxqpq6psM/OOHvMBfuNGCmAkHHVsJCMgohqkx0TMdcopVTGQWyvYfu0t
 KyfEFkkCt8LDahY+xr6F+zNevV3lVMvOV6VbljzJgEP0kTpOCw/fEYj
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
v1->v2:
 * No change.
---
 drivers/tty/serial/sh-sci.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index aa179c787487..993f330e6881 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3445,10 +3445,14 @@ static void serial_console_write(struct console *co, const char *s,
 		cpu_relax();
 
 	/* restore the SCSCR */
-	if (sci_port->ops->finish_console_write)
+	if (sci_port->ops->finish_console_write) {
 		sci_port->ops->finish_console_write(port, ctrl);
-	else
+	} else {
+		if (to_sci_port(port)->type == PORT_SCI)
+			sci_port->ops->write_reg(port, regs->control, ctrl & ~SCSCR_TE);
+
 		sci_port->ops->write_reg(port, regs->control, ctrl);
+	}
 
 	if (locked)
 		uart_port_unlock_irqrestore(port, flags);

-- 
2.43.0

