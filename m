Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344AB30C62F
	for <linux-serial@vger.kernel.org>; Fri, 14 Nov 2025 10:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763115236; cv=none; b=WDk4A6kNKPuqBU74N76pNTzdzmIVMiMyRGfS9osv6L85HWzYRb4nJAb4OztCAHvpeMOb3BfT3Ro1HDKqHwQhw2qV3pMH4LtrugzSCzsq07i4A4dKDiTeaS0uAiYflsSWXhraB6c3E5HMoEsmllZPSdumSirm+GUpyY6fy3z7G6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763115236; c=relaxed/simple;
	bh=80tND+lvNj2i4Qe20utjqahY1P2Ql9GnK85Gqo9FknM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gL2tUkX1STfHgOvvj9KiJ5v8zolu3BTtcu0JqpvL3PDfAZv/utq8pedp8QynmRPjs8ECay7A7OK2Ha1exmq2B5bUTZ6b4pwvn3l1z6znZtJnNyjQRPPT93x10OnQJRmeJikgeuponPQADbIn1Kbl6NvAi2G7BCDTp7wKG2F+esg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/jgR11D; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/jgR11D"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47117f92e32so14931405e9.1
        for <linux-serial@vger.kernel.org>; Fri, 14 Nov 2025 02:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763115233; x=1763720033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uyQOUFUYuxA3AMkkTAfOVziTArOJRDBqIJ84aBAoAyI=;
        b=f/jgR11DxRUzlo/M/m5SVIuRQhP3e6RF6x/FclxPqA0/5ggba9xSCyQBCoVG4AbrvT
         EETzqtQk/rgBUglwxGuHkfKK+B9bbM85K9YLmnKbcXfg9bgw6AYhX7GdZCebr33X+4N5
         OplYpyrwX+5ZjEogTLeZu4TIt0qpTDCmgR8isY9LkvehwFb2bCf9DcOaFYA9ZT0lleo6
         peZZ2D4w1B2E5MgI3EzEQhcDNBVn5V0Ld0m2BOjVlCPx63EaLmpwBVK3QOUfKCHXkdYD
         tfLeQ1XlsMKYySEb/HaXOcv48851CkdnNJDii8Omyl+0xTVlkQzZc7k7bX79VRJiwC/E
         fqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763115233; x=1763720033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uyQOUFUYuxA3AMkkTAfOVziTArOJRDBqIJ84aBAoAyI=;
        b=mEfgPHn+wXxn8neTTe8OYQlGmLtV8laKfDlxjtLegOdpgVEqPnNalZYIRsGb2/d4cm
         W4fuGGRTA8vCwlWlXUGopvbqjlUpC1KVOHmfyRDIjcTmf8DxVeA+Fwe3fsxMK7dF203y
         crkafCegwekZK24HBftkVhyH6ymBed2pgjL6yfi+pJyskjsqtAv+DuJwxS3HVE/vWepp
         WFM51+zWnhXwhkPtXL5NuiTPBTmTsyeDK5QxdWuX1CO2/pWTdzBJTcgw4nDcBHg1I2lr
         RW6u/eggFYHVewq5gHvG/AF4l9e1E4FnlndyehlPmK3PwNciMkWQgpnwdotTbZ3tebER
         JTaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVO62CNp/Gmtnx70T3jFp8f4WxzUhvXm08S749Ehm80WT7OrVHHDNbhq21SDZWw0E7evdtE3MM3wT2qlZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPwOfMOaTXmnvBUPLOan3RSPgeodYt6EMsmSYzpi0BvQAgl/ZA
	sK7TpRtyFyNDvXj4XPWtPeN0o7Yqi2kuJlEORwqENX3LzSwQC8JLi8NP
X-Gm-Gg: ASbGncsKY0+yxHwrxo3e0t38oYAMPZ/6szmzEd3kAhMFjkyUvdqafEaOjzQI/sqGEmO
	RkzYKcykka//o+DjSGVLEqh2qHCGVR2ja4wVgn/EdUlfXGiBzTL9aykEP+58Kx3dzps64VehA9z
	Qk2Gq6AO0tQi9aHXx40RrySPw/5TH16i9wGuQ0UsTBqMh84tdnj8BCTPZQNgK4PWbHLhFx1tOZV
	nvdcqTlAKS1Ha5lnrav3JbUTeyn2MaInG2Zk7mWFSc/6K6M6/cSpt1KMFPadlv1pLWqBLArBqoB
	2CKLZYqcKma1WA0w2AV5aBCpTD7lwIL9uHAuyeSik7WgcoHPsLWIcqdn/eqPYgnApT17c8snhcM
	d38fbpC0HBEcVEhHSapTe9zPQ+dGCB73Ma4wbCLVoZa2p1CW4QVZJM/9QnGrfaU97oT1XFcSHQk
	ZmzLwKFWujLjdwxn5ny9KinV1bGxlp3ycFyjsZE1M+kPRS8/1VNo25TJoxT2dwPBjK7kBIx5q51
	2752EOxjMODhQXw
X-Google-Smtp-Source: AGHT+IHwQRc+3WyYaHuW2eDqpuK7VEQtbvn7J8+LySD9iAVjl3fw46CiL/4mZbRZEV1FnK5/AdofRA==
X-Received: by 2002:a05:600c:3546:b0:477:7658:571e with SMTP id 5b1f17b1804b1-4778fea2df4mr25190315e9.23.1763115233221;
        Fri, 14 Nov 2025 02:13:53 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778bae816bsm40685815e9.0.2025.11.14.02.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 02:13:52 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v3 0/2] Fix deadlock during RSCI FIFO overrun error
Date: Fri, 14 Nov 2025 10:13:45 +0000
Message-ID: <20251114101350.106699-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

This patch series aims to fix 2 issues
 1) Fix deadlock during RSCI FIFO overrun error, as wrong register used to
    clear the status.
 2) Hardware flow control is supported on all SoCs. Fix the binding.

v2->v3:
 * Added Rb tag from Geert for binding patch.
 * Dropped overrun_clr from struct sci_port_params_bits
 * All of the CFCLR_*C clearing bits match the corresponding
   CSR_*status bits. So, reused the overrun mask for irq clearing.
v1->v2:
 * Split the fixes patches from original series [1]
 * Updated commit message to make it clear that hardware flow control
   supported on all SoC for patch#1
 * Added Ack from Conor for patch#1
 * Added fixes tag for patch#1

[1] https://lore.kernel.org/all/20251027154615.115759-1-biju.das.jz@bp.renesas.com/

Biju Das (2):
  dt-bindings: serial: rsci: Drop "uart-has-rtscts: false"
  serial: sh-sci: Fix deadlock during RSCI FIFO overrun error

 .../devicetree/bindings/serial/renesas,rsci.yaml     |  2 --
 drivers/tty/serial/sh-sci.c                          | 12 ++++++++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

-- 
2.43.0

