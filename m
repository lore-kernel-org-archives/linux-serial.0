Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792429313;
	b=2v2b2JcURbeiuk973Whu+Aq1mou6I7/UqT8kkXuQHuibV0im4G11YZPA6MtN2UsSS7or
	 teR3fCHevlYm4LVb+qGVLETva8kTfCfl5W/vBvRKCBomdWGWMD5SNJn/V7dENfjvZqHkl
	 MNLzG/n38fQ3bBjVBDdBvJg0bgVVGqE4a0XaywqkPlhBmCyOA6kikl2zlcTeyjT3Iu3G8
	 dBTwirr6cO4vvms2+0vv0x0a2zza0O9LNg51D5m5cofvy6z1/HBIEONelPro/4ETVuG2F
	 yOREQzzJSSN6w/fsytKYsxrIQeZB0/wz+i0f7TQ8FvTqqFX2BrwAhp7qurWaCXaI/zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792429313;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/Y1x++vnCQx8M1MrMrYzuhKRQBYLHw+2G0VMFlv/ouo=;
	b=xh8phpU5AS6FyNoA3StjRT3GNXgWpSG9ZOg8x3CaaPKhLy82nZi4G2h7c/BKIXHFdf54
	 VBGDaHHhzp3JqxdjuxywLExruHAUu51KVCOJl0o4ytpXPTNGMhODSrXO1JQB6mhfo6m6l
	 i54z6qeDA7SYjCUc9KCh4iWCYA6dUVjmjR0t7sCbBSvXXjqDf3Hzsr7Ky65R/QKq7h1R9
	 wVD278x+OuyToOr8y+uS26U0VduM1BxFBqZOGg+N8KBGzmAGNviNRfgC87FqeeE9GEKWt
	 OBq4/1ugoZ2aXgCZinckPLgT3tRc209e2ILZ74Hm8YliiPI1uFDEi/XAVL7LflZGCYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KFrQv4LF;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFFB60A3810
	for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 17:01:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FFFB60A3810
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KFrQv4LF
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c2dc63f8d8aso383151166b.0
        for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 10:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792429311; x=1793034111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/Y1x++vnCQx8M1MrMrYzuhKRQBYLHw+2G0VMFlv/ouo=;
        b=KFrQv4LFhCSJZrq85gLcTa5OLz5IhMYFH7n74va3Rub1pAVLCh2NDTvWoZ3HTe1ywZ
         hD0ES5nXX4OHJCaUbIhw0jYHDR85MJGN4AVN+9HLg9a/sriV5PNYXszZ5SJYSmC+PmzT
         xftPemQoB3H457tzQFnvjPorXiVO+tl9e7b0DZjtHM9D9sG1YkjHFvP4LWMASoayXEz6
         lbKe2va38HTnQVfhVsxWBbh5hN+Z9Q64AxDmtQ/6XYQOzXF/N5qJTB3HIymCZBpip6ti
         ebAcnVaMR7rbsAmWzZ2qOZgzBC9JjsS+VP7NbUxzt8Az1NgAnE8319cmbLeoz5CQZQ1s
         zOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792429311; x=1793034111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/Y1x++vnCQx8M1MrMrYzuhKRQBYLHw+2G0VMFlv/ouo=;
        b=gto7Mmy6XiZT7e4vIwMgd1qQrUHS+2zDzjzfszbjmyfucUTqbFpN8n/m5thVNlXh76
         VNp1GgqHs33SL1egS0IOoWOJyq+SCWY3WVcXa1ME5hh0ZfWQ513Vh7H+JRXkr6asiNfn
         yKzXQZBoF5henHIwkKbtoaomBSsTlqk5BpaG8otsFqxwGMHH5w7SplCAmo8G5F4Xmmns
         MNIbJS1wlrK4aQmXGrSZAbx64JiaYrdooZgbYgFkHZ9KhE4YbfPOzyRDdsk8Wap2eCMG
         nyIeAhPwqN7e4TD6XTCzYSJzBe0LljJbVGXgJGUqUSBUz4hfe82GLz+GvLt1cYHSRndD
         YSeA==
X-Forwarded-Encrypted: i=1; AKwUvBzaTeNOx44QzKl6q5MVTyGHNu4SgAZw4OBXatefdFAlXymvMuANZ0yGeNNfROhweQUV+ld55u3f1DUMXQs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKGFYhyV7fitQIDkgnG7yVwoYll7kZFgGJZPRbp+S69n68MNysD
	uf2WEPgqONRZStV6B4jULgLEOtuUPBdSzd89Z6jF7axP6DylA+Qb7Klc
X-Gm-Gg: AYBFou2G6WkgVuGwPEGe++Lj3CfL08IzW0VcNJr70pOVgOiSJ7rxlem+BrtktB+ugRi
	xB0XEiCMkkbCRjxaa0xVhCgyiRQYVYmJHSapM4KxfxGlpoj1wjrtirrwW8NwQZiIaANCM9x4fM5
	ZpGcApFAgACIt/gzdYYgWiQgq43hdkgTDVsch0TY21e6caFR2H1iNI7cmjRp01Jel/Oy2AbAoIC
	iqveTb9zDDjx+P1KM9oBFl0bZIIuxiwZjYfOHbl5fq07VzkNmQEjluN8Q9IzFn1k8qWHsP+pdQr
	h6ctCU9ZcZVn810qQhd5GYf1dxo1nUzCzQ3ao4s+KPVMF+AOiEEgAitfaMf2MgQMbXPBMeQpboN
	7YJLbdgpvVDQsBQ5NryDVKUcZesRtVed0SpNrrfpWsZAifMXtPGn/akuoNFJ8Gp4Xa/ifJgZIBE
	i48K+44KIZF02HRuj+9nEy7V++MocBwuXIRATVm0SYqBnAF2J6Ae1GoHD4LEWvr6SuShz49GsPk
	7gADeSZmtdufRboqd0/j2Sic50kIrRW01dUFPQ/cy/421YGfXD+gHHH
X-Received: by 2002:a17:907:97c8:b0:c25:4f7c:8ec5 with SMTP id a640c23a62f3a-c419e33b08amr627243766b.23.1792429311212;
        Mon, 19 Oct 2026 10:01:51 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:1439:c865:be43:6676])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d823b7esm101784f8f.40.2026.10.19.10.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 10:01:49 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Au Dang <au.dang.jx@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Frank Li <Frank.Li@nxp.com>,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH 4/4] serial: sh-sci: Toggle TE when restoring SCSCR in console write on SCI
Date: Mon, 19 Oct 2026 18:01:12 +0100
Message-ID: <20261019170139.473808-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019170139.473808-1-biju.das.jz@bp.renesas.com>
References: <20261019170139.473808-1-biju.das.jz@bp.renesas.com>
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
 drivers/tty/serial/sh-sci.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index e4c7a3e14688..94a34dccfe56 100644
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

