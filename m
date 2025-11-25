Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CD9327C0D
	for <linux-serial@vger.kernel.org>; Tue, 25 Nov 2025 15:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764083206; cv=none; b=V7L4okMzkmqTJC1v0k2YP8oJ8PD39+RVQRYGAue/a6dhQ/w21eb3T4XusSvmX1lCPiQXRAbvWftQTse8RNaMNz5wldCCrvAp8fgDd5chu3pG+etIrMX5pL4lKCzGoVfg05yBmlhduWogM8P6Fa1qeDXl3EzDFpKgYxI3/QguX44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764083206; c=relaxed/simple;
	bh=bvZGunteSrM/a/WIsIyYRGnLG558EPF1JJm16o36fLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W0Fbiq2LUcl3wWfA4ddvlOfKhvuIHUchBLppCwIeLJ7G09OAoaPAW1ZOMNDZHT0RXBk70TF8mN4wB+duxiYFO3e1fSyajtphnzrylE9WMHGswyGQtYTGwOOstujFlEVJlNCRD0Q3u4dNx2PtMzovPI9oUmnr5aAN4ywOFcO1TTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVQfRq+i; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVQfRq+i"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42b32ff5d10so3979824f8f.1
        for <linux-serial@vger.kernel.org>; Tue, 25 Nov 2025 07:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764083202; x=1764688002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTZQaQp1phCcJN1UymBMs2ZvVQGslFeouD+Q/OgyOGQ=;
        b=VVQfRq+i4LAfI5h5YX9zU8lM15uQM3PG/JBFiigrZ7LcC7xk0dv00sZODAu0kGHcD9
         TP8ImiwQcqh3w/fdneHPq0/haaLU+wivSang6cIEA/JzNNF4DFajs+6mIK/YMUct1JCK
         8dkg1XuKA51WSoyTBNYn0ks5d8vpuln3G4QxOfxIFGTG+NUt/m9cGk5Qse+Tz+cm22UH
         tsthKsapmN4ivArAhoQOYanOJWQEprk7jAdj3xx70/jpcSJ/qHALuCQJJ70Y5BO1LeiA
         5ccy0K+9O1xuNlW5q2+8NBVTVsA9x8ZzVgxpE87GapMKoRVLrPFRvRuyI2wYrP8M/5vO
         5IWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764083202; x=1764688002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RTZQaQp1phCcJN1UymBMs2ZvVQGslFeouD+Q/OgyOGQ=;
        b=GqrKmcrNAsMuwy+VleY4mip0rNPl83xcMUvSSE1y1GvDHq6zDXLCABkVfddtPREEa2
         WdQw1mTUMeIQhPznj+SinuyHsC93TsPwpWSQs7zcKp8i13v0Y9wA8b1Ww1unQXqdlm5N
         D94x5xdtbmzKqAGmDGglkNytIcVHwAAqf4LQbmz3JFnRQuiT9REJK569LD3BcNpuywwg
         k6vpCQjmW6X5++klXTMzXdXLYp2UkL57TMYDF6n3XNczL6hu7R8Y3+ATqYVeuEqcFjxu
         PzYO+BZriYSMMe6j+SDb5Gx58FrnzcpXaWq8mOKA2aREE0wemcPcszJTNTgYHbD4XpRw
         0VWg==
X-Forwarded-Encrypted: i=1; AJvYcCXNjn87RTVK5jMypNXlGXUaqVgnSuaLoCUXuCvqv7lKzRgArsUwsh//rbIo4HyUm5ymopDPb2kiWuVYkvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5Qn89CDV5nlhz9jBQmq13/wBScKmkhfikNrK+6b9n6r4OWxww
	/ns9D9HF21TUQZ9xoQ5R+x7tcnYvAPeXszQLG2vgsiSj+41Q0tiQba5f
X-Gm-Gg: ASbGncuA2Rkf7EJMOepnC1gvtR5/hP+kAOvv0+7+W6s4EzC6PaaSSJGMjQ5pPojxPl4
	KAwL01LVz0PkxJLe1nHPrZHkJw81LQQeTlqQBriqbty+rXbxe+Yeln2z7GyNymT9xtZ/iaugBhQ
	Gp6UufM0FPhXmp0FfxEjdPDQgmdr6Gkd5AsMyCGEvylbeyJVzrRibItRd53QII9+9nVDRjWntjJ
	fkbrv4prKcnUEr+5SZ6sxuogN4LUV+vcDfQPqny4OW+nHj1+SEQe8TnVWUQ15I65jmWf6pWzLWW
	hupF7uPZoih9VElIgVxKhkkx/AtmD9hhpgsC2dBWDqoERVmbix8xUwKqvcVWp+tKY3Fl172IeDP
	a+R5uy+ZQlhv3LkHmYlGbl2rVwipLh7/eoOsEyCdt4jBY1Cwh933zxR9g+MA0w8+u9gFMMZnENz
	QXMH4zCu7TDLe3AiTXELEdq2aKs2hveq540fU7KGzuWlqMseRgMi3SGAsj77216X1fCkdn0V8oB
	MJKxQ==
X-Google-Smtp-Source: AGHT+IH7BC1ZyxS8oRXsiprnT4CSaHhz6BZHzWN5J4GKslWr/kg1x38bb9Tm6SchIBbfW4h0mucEAA==
X-Received: by 2002:a05:6000:1863:b0:429:c8f6:5875 with SMTP id ffacd0b85a97d-42cc137bbe6mr17916074f8f.20.1764083201748;
        Tue, 25 Nov 2025 07:06:41 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fba201sm34797809f8f.32.2025.11.25.07.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 07:06:41 -0800 (PST)
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
Subject: [PATCH v4 08/16] serial: sh-sci: Update rx_trigger size for RZ/T2H RSCI
Date: Tue, 25 Nov 2025 15:06:10 +0000
Message-ID: <20251125150632.299890-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251125150632.299890-1-biju.das.jz@bp.renesas.com>
References: <20251125150632.299890-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

The RZ/T2H RSCI has 16-stage FIFO. Update rx_trigger size frm 15->16.
Currently, there is no user for RZ/T2H rx_trigger. However, the later
patch uses this variable.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v4:
 * New patch.
---
 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 8869c25eac95..ae76705baba9 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3324,7 +3324,7 @@ static int sci_init_single(struct platform_device *dev,
 			sci_port->rx_trigger = 8;
 		break;
 	case SCI_PORT_RSCI:
-		sci_port->rx_trigger = 15;
+		sci_port->rx_trigger = 16;
 		break;
 	default:
 		sci_port->rx_trigger = 1;
-- 
2.43.0

