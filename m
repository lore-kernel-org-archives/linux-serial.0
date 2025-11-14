Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374E131328F
	for <linux-serial@vger.kernel.org>; Fri, 14 Nov 2025 10:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763117532; cv=none; b=jp7V6Cz03eVmYCZ06rslLmNo0/+uA7RFxWeufq2amclNpgBHT8ed7WLmBXZp1432H6t7q/IVsvOWGYrDAY+0y9rtbZ8wtG6yiANVQGK0Vir00Uo9Vw84rKTrHXG0rXi3gW4B1mfaZNvcAxU1EW2dOq0Rnw0DQJMNp21PTk6YwGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763117532; c=relaxed/simple;
	bh=iJIaTUJBE/UoXRoL2SViHoaSHk5UckBwxok5OzHcObk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jUBUxes+Y4/e+ZUUVNyOIwI9ZMklmuFGwEW8TEh5EoVv0c1N0PPCYinsBUV0YVipYbfSrKIqQtWQkivBjaYcHxGusOqPdAavt93p9FlQZU0aExvh/PSX0upYHl0qKlCPkQezgJE0gEkKmgKap+YtyZIYlnsFgVgCOszfYBCUa9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9/dx3Va; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9/dx3Va"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42b31c610fcso1575951f8f.0
        for <linux-serial@vger.kernel.org>; Fri, 14 Nov 2025 02:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763117527; x=1763722327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYLtJc6vLB0VyHR1vBUsYK5ND0Cpm4eLmmgWDk1Ci6s=;
        b=U9/dx3Va+j27Re9MMMCh8CY/uJxXCrEF+3px10Wc5hUH8mPejPq3hBl+UguNqY8zeL
         YDeEM/ojwwP9/HVzpr0CEOGGte6EzsnptHgsT7exnvvkcqJ752NGY7YEh/+coA1AwZpJ
         gQj/IN7pnkNBQ8+kAUpaCYp2R21eFgp/pmZiNku8XRAclwklaQNx6zyYMArSOsXGSLYp
         L17y5/0FWUW5gfwFIJ3yaa+TVGgopQnQ/ePN8WylkvZdtokPsxPrWmhoShnlTkeHpMcm
         Qqj8cR4IgKp8y36dcA6tIHKsIaFicGqytflNPmh0mhrQw0H68IcFj3VuV0ixu2iNvGAv
         XhJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763117527; x=1763722327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lYLtJc6vLB0VyHR1vBUsYK5ND0Cpm4eLmmgWDk1Ci6s=;
        b=KXhOwULfFWU06qqJeaGXDXAJb7XzavIzbXiWDi0zpC5eA3MSht5a6oXxAFe23TZyIX
         zyyQS/RcHOlSv7Qmz9EcCDmDYC9VjHd/lgsEcg6LU8RDA/1dN9LUpKX4SYfnYu6se9JX
         8zI9Gz5IRW+PernJaQZWfW+v4/afa1cJ4c3ESNB9o/mhyxZ2vmGqF/uLXzy3b1EOvJrZ
         C+cGm1t4WYCPzpMdoX2b/iQxRISp/UmcIFvb1kcgvqrSVb690OZM/Atb1moNSiJQ97Gh
         9G5vscxxyobwJMRTzsbYvXGR2sV6Dx0Z1SXbs0iqMLRJCl+mhyc4I2zw/gQ0pPcX3J3D
         MGow==
X-Forwarded-Encrypted: i=1; AJvYcCXHGN+OYjH1XYudOjP/ll276Zh7H436zDRCV5W7Qpan0eimBMuX07t19XRmvOzCFejPUbI0jIKaSo1OwkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YznzKFHveqaC5v7OnHcGTHA59g59PB7rrCkl5HSAbdZ7IfKJWIs
	tJVBEXwwzfNPH0e+sn83N+HthyAkY9lHZFVwZgbYk4fb73zqd+j/hWEd
X-Gm-Gg: ASbGncvVRLogoOgeHGkP8sNM4a688i/oRiWXoKz7lAKs4qrgLbDhaMhwQBfW062zGxY
	T2TSXX8rxWoSNgj8P1n5r57y2AaSWOrmmrWb3gOj9gijV9nEUfFM6K4AA//5DxOuCAfLq4yHn2z
	u3323xSwG/frlE0wmLQJg++AcwaJ+UTRi7dFLTssu+v72cjh3b8dy/k0TO2xlfLS5+cdG47v3/P
	Webh/ucArKpuspKBEheJIbk5IJ9NAPGxwdfAKEBtrjBvunITlw2YgSFdusU3Udd3QV9uZD/GnLd
	h/atei5KBf/EzR9LssZmgTqKVJxe2gEMMJi/Da0FWmLMWP5feoLlHSZ8VmUhTmVc3RyY3J0BYiv
	/65+g7F1PhITzomPry3HGQiewsGYggOWTBWiAXIeuO7xvjBv+e6vmSr6TLMxKxkIJPIg3MQxxxa
	edf97OOZ6tVP4+tBQWfI3DvJeH5OLK/L03G0hdmzGv8gFBNr0q4cQgYdXqA1I3uI/pdqo7I/UHw
	8lMQaAjxttWIrjS
X-Google-Smtp-Source: AGHT+IG1K5JXTh8BUK8ltjLvdxEwkLX/nyui+CPvlrYOREjldOz+kK+xtG6KakDboynQZMVOzMw86A==
X-Received: by 2002:a05:6000:2585:b0:427:813:6a52 with SMTP id ffacd0b85a97d-42b59386b4bmr2223729f8f.41.1763117527156;
        Fri, 14 Nov 2025 02:52:07 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f17cbfsm9031255f8f.35.2025.11.14.02.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 02:52:06 -0800 (PST)
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
Subject: [PATCH v3 05/13] serial: rsci: Drop unused TDR register
Date: Fri, 14 Nov 2025 10:51:14 +0000
Message-ID: <20251114105201.107406-6-biju.das.jz@bp.renesas.com>
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

Drop the unused TDR register-related macros.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * No change.
v1->v2:
 * No change.
---
 drivers/tty/serial/rsci.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/tty/serial/rsci.c b/drivers/tty/serial/rsci.c
index 9fa5d387d7db..9609ef73a0d4 100644
--- a/drivers/tty/serial/rsci.c
+++ b/drivers/tty/serial/rsci.c
@@ -35,12 +35,6 @@ MODULE_IMPORT_NS("SH_SCI");
 #define RDR_FPER		BIT(11) /* FIFO Parity Error */
 #define RDR_RDAT_MSK		GENMASK(8, 0)
 
-/* TDR (Transmit Data Register) */
-#define TDR_MPBT		BIT(9)	/* Multiprocessor Transfer */
-#define TDR_TDAT_9BIT_LSHIFT	0
-#define TDR_TDAT_9BIT_VAL	0x1FF
-#define TDR_TDAT_9BIT_MSK	(TDR_TDAT_9BIT_VAL << TDR_TDAT_9BIT_LSHIFT)
-
 /* CCR0 (Common Control Register 0) */
 #define CCR0_SSE		BIT(24)	/* SSn# Pin Function Enable */
 #define CCR0_TEIE		BIT(21)	/* Transmit End Interrupt Enable */
-- 
2.43.0

