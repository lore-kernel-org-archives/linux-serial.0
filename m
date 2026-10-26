Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793013818;
	b=PuSSf+WuNg2HpZtvIWLiOrP6zlU5isiTqLM4Feku/A0W5uB2QqgYGtFqw2yOaGX/2EwI
	 CZt/DoOEkKnlx7nSeR1/XklYo3HsmkfosDXCgun/ABc8As8p5uwaiLWFLg/5u5XAY9txj
	 kEVnRXd8duPbO+bv/76sTuC4n5bLyL3lqkTR7gW3yyT2aIkGev+Lc/9fX3Oyi72Szh5Je
	 uujPBPGPhC24ii6Viv3pHPydrBR4Dqdnzw2Ej8Q1ta2XGdmMcU4h3dX/cLNT6mVONNpXE
	 KF6RenvIPQmwMeb+MCUCbyolxwARenNCLQzINNa3NStZjhVjoyltfX9fAO4Ms6G2fJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793013818;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=ABdqyAeHZvZveh3ZqFvCBY4Fgn7+If+125igGtBDhBw=;
	b=1FCzWZFMbs5E+/SyxGiqtSC6lTWHnXU3+eLPzQ702aePFDybUbcpqa1MHMTCOFwEv5X9
	 IqwnBSND19nPGMm1BXndD+2zPXc4IuteLRZR5ikR7bM0/pYHZaeM323OtoEO/lbEh7DAc
	 WKYXSAcKOASnIFmnjFW7ufLNF49vLpU69146pyCzQYe4m5XlrMiCIw7cVvWgQPbZ5uNoI
	 Gxaw/8Q1aOA8REn59aSunhuyDk5tbnHu43cOontdXC2kg7cKal0MGn8ovRo6Y730WmsMR
	 x2JsAN56gzx+1qqPjUu175wVKfN56nh4hO62E2G1/UCZLLur/uzw10jPxsdmPhX3igg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KR8VGpzR;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C74606A31B
	for <linux-serial@vger.kernel.org>; Mon, 26 Oct 2026 11:23:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31C74606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KR8VGpzR
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a2d6cf958bso9350225e9.1
        for <linux-serial@vger.kernel.org>; Mon, 26 Oct 2026 04:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793013817; x=1793618617; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ABdqyAeHZvZveh3ZqFvCBY4Fgn7+If+125igGtBDhBw=;
        b=KR8VGpzRcoJbMGE3hDYlf/800hJfTHsSb5HsFaYRtZmeMHHGtwJEBa1TTmsttW1ZIl
         4wYlNiHNSOcDxGnvOkqLtny6Rh1CFyl+0xOCPUwpT1X1vqB0wB2XiJ+26UlenQ39Kppm
         G+khUwxvCnESmNAJlOW8yIS40RmzMc3Q7Q6gjfLVHyHtrcPbLQD76pgOEXB1SNLb/54/
         M7jkuV/JzdTeaPJaxz6eIf9HHBk1cpsIN7eDqEFB8GFBmqgnmGcESKD7Aoj32/rx6GAW
         sibEeyLnx9s5k2mqw2IZXB63x1qsCe4I85qdshdNFcx6bNfNIG84az/ZDEOqhvJqUg5/
         evEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793013817; x=1793618617;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ABdqyAeHZvZveh3ZqFvCBY4Fgn7+If+125igGtBDhBw=;
        b=SyDB9dH8ZcUK8/xE3ESFvcEB/AxhClyyc+fuPjxoVreyq4Rz0nQOkXkIR1lY/9BUXp
         lWZ7+bcSl8PHuD7UoNHp1bhmXc6TLAttU9XhpmUZsshFqV0IUGWdUcAbKgpbBv+ih+02
         tVJGEndB2TNW69AxRyXSRD8OMRfPgs1l6G0P4KNKRgAepaE4E9dHYrDGiTUN/okLn0Bj
         oNZOVutZDDXUU0phvgdeMiQpbBR9texVzjp4KTAsHX+wdV0/8bX3Ly0JCmPMwp6+iBRG
         k1c667wleFv+DOxlM/UjT8Q19AyUjakkzgJ1KVwf16PfOKe0Vg3yd7if1iaAi6YZM16m
         nsAA==
X-Forwarded-Encrypted: i=1; AKwUvBwA0tGDW/KvNBAfhdwZLtZeFM37p337uvlFpf8hu0MKC2lkQCnP8MrKWWkMOX8erK4xcDxCoSum9ir2Pic=@vger.kernel.org
X-Gm-Message-State: AFq9FYIUggjEtmcL7MzisgkBYHI0P4etVNKL07eY4UshK+8/5/ulTtLf
	hvrqwRYoMQZ0LKjskHSrr3HhJ00VAXxM59GIaShoUXvEkM6x/9qMlsPj
X-Gm-Gg: AYBFou2LWmXeKeyGMMSzVz5scWCY/9VKyawRgTlU21tQ0YgtZfe8Mh2Evb3FhJUBdSL
	BPjaLm+5uXyNX6Pl16csBef4Z3fDnV84ggqkeOd7rwkMsDzgRVlRhmgQNjvP+Pbl/ZESjon9cJe
	NvhaXVlYUFg/E5QLR7oTzXcJzl5W1aHOVntc1AydQmH7qMb9nPuiR8bwj6OAg4HhgZrjxphagwc
	Slmm+/7w8mo1ahfJPCZ8FinbdHmbqg6NDjU/Jgz8e59RJa4bzvr7V/KOt/ZM5+aY2z7J6AZH/JC
	bRVQxkAqHcqZUjzx6ML1OBPqMyqnRJYyQLCwvDelRdHG+5uhBL343JqmQB+RJpGHvDNwOS87Xcg
	iAFoizqjGH96j0g3vIlFt4K5qa9s8NTnkhlifjy3I572/ctdFda/Jt6aW+jpDF5lXO0KW8bkyXo
	eSiL/accD+XAXUTn2TfU7oKYR8o/SM4IdWdKlZIC43jWYNY9vWdD7TGT3pNaMXaqHlPE0b4CTyL
	Pjx/tUf4y49PubZgtiFMgXFYse1bbdCRMNL3FfSZJHBe6jduGtein0qaU2y+FGuICuJaWOpBcsU
	KKrOVcV4XhVX3i1YAQ==
X-Received: by 2002:a05:600c:6098:b0:49f:ce78:356d with SMTP id 5b1f17b1804b1-4a35acc431dmr111151135e9.30.1793013816492;
        Mon, 26 Oct 2026 04:23:36 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c4:a702:d301:482f:657c:9770:475e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdfb8esm15959263f8f.54.2026.10.26.04.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 04:23:36 -0700 (PDT)
From: Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v3 0/4] Fix transmit handling on SCI/RSCI ports
Date: Mon, 26 Oct 2026 11:23:32 +0000
Message-Id: <20261026-g2ul_sci-v3-0-b3097163edd5@bp.renesas.com>
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
X-B4-Tracking: v=1; b=H4sIADQ432oC/2WO2wrCMBBEf6Xk2YTNplef/A8Radq1TdG2JDaop
 f9uWgQFH88wc5iZObKGHNtHM7PkjTNDH0DtIla1Zd8QN3VghoCpBATe4HQ9u8pwHTiFlMpEJyz
 UR0sX89hUx1Pg1rj7YJ+b2cs1/UhkITOQqhBxpnLIueTadJOoSye610GPwlJPLlA13Nhq8vizR
 vm94JED1zGByhEBZP63XpblDbRAkubjAAAA
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Kiryl Shutsemau <kas@kernel.org>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, x86@kernel.org, 
 linux-coco@lists.linux.dev, kvm@vger.kernel.org, 
 Biju Das <biju.das.jz@bp.renesas.com>, Au Dang <au.dang.jx@renesas.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793013815; l=3074;
 i=biju.das.jz@bp.renesas.com; s=20261020; h=from:subject:message-id;
 bh=zW64mN/4d2OmJaD7t1D7UB4oZpTj3P+t9X3dcAB7rtU=;
 b=gOp99iXwRCnJN0msXpKCv/GRpEYHrf7Os4oduYopAncMX/9qUjdeKcRQHas85XQ62sv8Yls1h
 dADbeEyGwleAPP1Llu7XjfmkxHVqzQXltxEDw0YYs68pre99kVhVnLC
X-Developer-Key: i=biju.das.jz@bp.renesas.com; a=ed25519;
 pk=yzD2T1OLS3lEYflbk64xhLlxhk75lZ+NoOtkTOqrlVw=

Hi All,

This series fixes several transmit problems on the SCI (PORT_SCI) and
RSCI ports of the sh-sci driver, seen on Renesas RZ SoCs:

 - Patch 1 removes the code that disables TE at the end of a
   transmission on SCI, which the hardware manual does not describe.
 - Patch 2 stops the TEI handler from turning the transmitter off
   while the xmit kfifo still holds data, which could stall or lose
   output. It also covers the TE handling that patch 1 no longer does
   in sci_transmit_chars().
 - Patch 3 skips the software clear of the TDxE flag on SCI, since
   hardware clears it on a TDR write and the extra clear caused a
   spurious TXI and a duplicated last character.
 - Patch 4 forces a TE toggle when restoring SCSCR in the console
   write path on SCI, so the TXI that restarts an interrupted drain is
   generated. Without it the RZ/G2UL console can hang during boot.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
Changes in v3:
 * Updated commit description for patch#2
 * When the port is stopped with data still queued, the transmit_chars()
   paths (sci_transmit_chars() and rsci_transmit_chars()) now also swap
   TIE for TEIE, as they already did for an empty kfifo. Without this, TIE
   would keep firing with nothing the driver is allowed to send, and TEI
   would never be raised to complete the transmission.
 * Replaced sci_tx_interrupt() with port's transmit_chars() to avoid
   lock drop race in sci_tx_end_interrupt() before TX handoff.
 * Added missing has_tdxe_auto_clear init in scix_early_console_setup().
 * Replaced to_sci_port(port)->type with sci_port->type in
   serial_console_write().
- Link to v2: https://lore.kernel.org/r/20261021-g2ul_sci-v2-0-b4e038220018@bp.renesas.com
Changes in v2:
 * Updated commit header and description for patch#2 and #3.
 * Take the port lock before reading the control register, so the
   read-modify-write in sci_tx_end_interrupt() is protected.
 * Extended the pending-data check in sci_tx_end_interrupt() to cover
   x_char and a stopped port, not only a non-empty xmit kfifo.
 * Replaced the PORT_SCI check with a has_tdxe_auto_clear flag in
   struct sci_port, set from the new tdxe_auto_clear field in
   struct sci_of_data.
- Link to v1: https://lore.kernel.org/r/20261019170139.473808-1-biju.das.jz@bp.renesas.com

---
Au Dang (2):
      serial: sh-sci: Skip TDxE clear when hardware clears it automatically
      serial: sh-sci: Toggle TE when restoring SCSCR in console write on SCI

Biju Das (2):
      serial: sh-sci: Drop TE disable at end of transmission on SCI
      serial: sh-sci: Keep TX enabled on TEI while data is pending

 drivers/tty/serial/rsci.c          |  4 ++-
 drivers/tty/serial/sh-sci-common.h |  4 +++
 drivers/tty/serial/sh-sci.c        | 71 ++++++++++++++++++++++++++------------
 3 files changed, 56 insertions(+), 23 deletions(-)
---
base-commit: 8f7df005a7564bd7ffa75da9c3085d5b996f1e16
change-id: 20261020-g2ul_sci-b610606ea5b5

Best regards,
-- 
Biju Das <biju.das.jz@bp.renesas.com>

