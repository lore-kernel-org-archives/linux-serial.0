Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1993C313E03
	for <linux-serial@vger.kernel.org>; Fri, 14 Nov 2025 10:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763117531; cv=none; b=qX4VK7SB4T9im7/GVP4kb4PoFE73WUXr8Urv3Zk5+q35LQJF3tfUii+jjI8uiBLNqxQVOuKIm1fhtDnCHWSLelC5ZvmiEBh24BaatGd5DjH6ceOdV/uefYVS850gC6QEGKymMlwOezmST/Sjt8//k5Q1Lpa24pNXhL4HSN3HXLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763117531; c=relaxed/simple;
	bh=iDr+sjQfrHDp3DxxIo6LAV+CM7T5ZIZH8WpOIp7Dj7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oZ2RYFcRr15M9w0vH8jAPtpEWid5fNWvvSsAqEpW0cRJqDuvkUnChV6nMz2BUeEGuW/Aw4eFgLMN/mbtZ7wFuHsrhvj17B1n5Ftgk9rvsyVQtUf5GnvSHyvWray+qVhXoAIluPY+S1iCc0ew+U5nrwny0qtUXHKhFSfixywJtvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQrYut4c; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQrYut4c"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42b312a08a2so1449262f8f.1
        for <linux-serial@vger.kernel.org>; Fri, 14 Nov 2025 02:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763117525; x=1763722325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sE9iX1ursNOQzfwEha6Mc4rDjGJl4IqWi+8gkqilwc0=;
        b=MQrYut4chTP6Ud3I4s6YI2vVmEAGucr7ICqauo98zFsEDe+mpr8DLt04JRyE8uyixx
         kxSaogSkXd99wmuv8U6LoKmocHh/QTuGutEcQTHWqU/5GSw+ybQp1tnHSlUG/cu27v+A
         5dfzUHbwZ4C0106KjaOYUk2vHxUW9fVAlfxoy2Yn77NBrjXNWXHSjtsQiDr7wQb2c+Ii
         nLmctwGVhPTabZN4ncM3k3nGMEPY9ufWs2qZa31CR/Qmy9uA4FJBFOtQNukR7fzQQDZM
         +DuZEZ3G88QLJc6DBbDWGglm9ORqX9vrOG4TmU/B+jYmiedxmISWQFHFfkwNty9KG4bn
         LLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763117525; x=1763722325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sE9iX1ursNOQzfwEha6Mc4rDjGJl4IqWi+8gkqilwc0=;
        b=slkxJrTDQTbS3q0d04Ny9GzXnmtInZHvlvVi8+/aZQw5wE3EkfsK/k7vGRqd8Ou91I
         6WJ7wk9mLyZCaogrYpZhFy/JfqmmZ0cjMERNNFJX7pcf3xjobRqJ43eGIRXoZvsxMswr
         QnxGIJyGzTRMY/fFgoVsUmrkKtsuHVvBVQV5UZbWKmnYT0i434y7p/ItRk9HQTTPAl7N
         zbl7bosiPSePxKiMLkaAoaMrtAZ+X00/knx/GgPVPfxe9nJWh4qRoAbKlW+JZjjsWWLI
         Op0XzvPJyhXF+rJ51qxqhcaF+cRW77nBN3fsNBThVQOC9Kb6gzG5mOo7BEZhtSHC5c9l
         7vSA==
X-Forwarded-Encrypted: i=1; AJvYcCX3W83l1XPDy8MlVgpY/bPlJaYeshxutalPatH+5oeK3ykGkDPpzU5tL7RDZCitfK8d+sJ65lB7g07+ZDs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8XUQ6Y97K3CP60EsIaFEC/PrZS0aL9aKyezpihcFlxRbiPs8M
	SzvTQ7Vh2l/GRPokKVl8DvufR59VH4B+FKZk2mKSYDq+6uyQjl30YoD3
X-Gm-Gg: ASbGncvsoHbQHpllHaj/gvYDn6aGL8GQ9tj7TVuUh8N5Jo0PyhU3+361k7TSf4dKf7F
	7RLxz9gVoSHEiHcBZzxLloPo2lcU8hjxHGwSZGiM6BolQ3DU98v0/3Lsa6wzDE4fJlpf/QB7DDL
	Lp8vwlQpuOn7S7C2LaU5/1JcnDa1I1dvnkvFHfau2IaPRU4sDo5g/c43/TYTS1liKNqwU+P+0Fs
	/cxzIGrPZYVlNA1/gcuZz8il2Pom6s0U/VBWC3gCyvzkiT/wx7oAgTX6Gdv2++uYo+rvkdBeJBH
	Bp52EC/0xFZYFhPwZeBC893lFfGjlCWvhZGOdyIEW2XKaI6DmyYSVwzBFS/wG0UdgGG6nhwJRkk
	qt3Z0EohpAigjHZQq8alg6e1ZgpjLs3xcGiNVbchjVGn2lyFc1MRYTEOY85Wx4RgyJHEx0T1hL3
	IxxTCMANCxNHPF8Xkr4sSVe9aIFxhSwQvVfGInvn1s32MxnllPZt5zRWGNdjaD/otgIOWy29N8M
	A9E6QSPCMZ9M58/uRpQkJSij+0=
X-Google-Smtp-Source: AGHT+IHh5EhVhpsPi+K/X6iNqc6qBAFlJJgODP+ZykzrObwqlrD1Pj83VU22VCd8tYUDjSmwsdu2Nw==
X-Received: by 2002:a5d:5f47:0:b0:42b:3825:2ac8 with SMTP id ffacd0b85a97d-42b5939ce2emr2119323f8f.59.1763117525277;
        Fri, 14 Nov 2025 02:52:05 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f17cbfsm9031255f8f.35.2025.11.14.02.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 02:52:05 -0800 (PST)
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
Subject: [PATCH v3 02/13] serial: rsci: Drop rsci_clear_CFC()
Date: Fri, 14 Nov 2025 10:51:11 +0000
Message-ID: <20251114105201.107406-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251114105201.107406-1-biju.das.jz@bp.renesas.com>
References: <20251114105201.107406-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Drop rsci_clear_CFC() by reusing rsci_clear_SCxSR() as the contents of
both functions are the same.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * No change.
v1->v2:
 * No change.
---
 drivers/tty/serial/rsci.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/tty/serial/rsci.c b/drivers/tty/serial/rsci.c
index b3c48dc1e07d..9681e8ef4bfb 100644
--- a/drivers/tty/serial/rsci.c
+++ b/drivers/tty/serial/rsci.c
@@ -199,11 +199,6 @@ static unsigned int rsci_get_mctrl(struct uart_port *port)
 	return 0;
 }
 
-static void rsci_clear_CFC(struct uart_port *port, unsigned int mask)
-{
-	rsci_serial_out(port, CFCLR, mask);
-}
-
 static void rsci_start_tx(struct uart_port *port)
 {
 	struct sci_port *sp = to_sci_port(port);
@@ -275,7 +270,7 @@ static void rsci_transmit_chars(struct uart_port *port)
 			break;
 		}
 
-		rsci_clear_CFC(port, CFCLR_TDREC);
+		rsci_clear_SCxSR(port, CFCLR_TDREC);
 		rsci_serial_out(port, TDR, c);
 
 		port->icount.tx++;
-- 
2.43.0

