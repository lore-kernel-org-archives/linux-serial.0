Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE8D3128CF
	for <linux-serial@vger.kernel.org>; Wed, 29 Oct 2025 08:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761726068; cv=none; b=VKmSM/me7C8m8oUT3lwuYP6nvKS4LVK3fRm21GK+Ceaekk334ktAFFBFixHFnVM5F6w5q1gHUO6fiz/rqbxuORDFtaLN90p8iwcq3AQ4hT8byMF1zLp/Drb7gQZIt4w1v1QMAfhNP0g4hORtfWIGlSfQoJSrQMGfk2tGMHuKyIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761726068; c=relaxed/simple;
	bh=z4QNcF9Eyw4gYd86FpxSeDFA3Dt0WD6vaP2DFa/zU38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KWD1ZfesvdCc3k4CBdg+5V73+fHbHIUXUn+4eLywDJ8/lOF1erSuV5r1JXwPkmkRPk0dprZzi4vy3bxcNDl7mln6DQHAv7/zcSH7/XgI93hCLE5EceRNCsjB3S0DOT1lEZQeiE8silaRbU9a/JKGKNdJ2F2+UDK7FhV5BWu+wMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0HLRTty; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0HLRTty"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-475dae5d473so42207245e9.2
        for <linux-serial@vger.kernel.org>; Wed, 29 Oct 2025 01:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761726064; x=1762330864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QS4cXKd9nHCeMiJrsvhtqK1LgpajA4mb3ahi9ySMK/o=;
        b=g0HLRTtyOyd/pRIoNTaXTJTZZFwHoiOyXgWilj8PYDHbzm1opaHhRCVAK6NWkwJYRL
         K22y3szhtgy9+feOF3dkV2KHj8vtNBZMGRZyCx6kSWH0FUUkLXPtxt8r/SNFofaHda7y
         M9DkJwGm8pWZQ99FYWOqWTJnYvfaflkHKqfbYEOPaGaQb8IPn0j6jADYZrsLPnx/tncT
         XQAqoEl9nE9PIZpn3AaRjtdOGitzpn9IIPj2mrzhsDAQnXAPwsD8iI9I00Ob1XG5iQ4x
         hkDDbEcWERb3r6QkPMCvf/QzrC10uKYQ+59haizha5CHroq4yfpNfz68Vsex7L5XYdyJ
         c8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761726064; x=1762330864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QS4cXKd9nHCeMiJrsvhtqK1LgpajA4mb3ahi9ySMK/o=;
        b=Ee6OC8mnOLa1aeaV0nxx0DnbhTcnhnmmpXhRPg2oHkQYe9NI+l8D4Yc8Je6XpKWh8h
         ncg3C/5KAEOKAGpjNq0liDVQ6IdpUYX5KIGCzi+nyhyduJ7ly19n7QPvGc7KybBWfdGM
         yDxKEwrbMlyGXyNc8swtPBfhnzj2D4AIpIDREIkQIRrxvDIXw5DmWfnT5QFlH09CywLE
         fyJQtAQ3Vpz2kboaBzFJ4EHhEdu7B/OWLDDGkJPkGRBznVeTDCPSDpPTbQ4kVkC6hUyB
         /bzV8dNLHR8RHb9axF+o99iXrwng4V/jK8oXlGAckU1YOoVPwM7GdnQICexragoFsmLq
         8hgA==
X-Forwarded-Encrypted: i=1; AJvYcCXxSsmgu+jxM7Y1uNr3WyGzEqh6fSpS8i6dSWUiAep2BEakboXJ18BWpfZYfnNtRfqo6dSk09c33lIS6VY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzydCKLBoPgsPEXP/QEYA+vAL+wV5Zw2WUFC7YKEHqaCFz9DFOs
	7l3FrfMREeKToXavaqDOuev1cLpu1Vgtu5sAZpmfcuuNw3QSAu3U3uMA
X-Gm-Gg: ASbGncvdTCT4JqW9K9tPXLdeOhWCnjT+f1Jv/Pw9GquEQUGxjhM1Mbtu2HmaYFLqW3u
	sxONd80Rj1FuHWntEz1jK9c9LHCt8pkRDunSqpBhmU91SVtdl77fRCDuxdtPKRLqehloMwwJGlb
	Pqp3tIAEmk633oLOONoQbyuXcCVSuR6ZQO1vc6P7b8vTPNZI23rcL8YKSyUi72Ss1lPRuq8k5iC
	c8wt06/O+UacvM1vqKDACPoOqaLItvpOJRWy/avsNCKwGUxzVk2oZSJChU1HKxSw1Pscv0d4VD8
	P9d//41X2YZRGLTTkGAOAcFVmkNrDlN4TlXTuvE+3cRnNzkdlzoxpc6uidBUwsFfzPCnR3+E82l
	HZUO7abDskOxe8NIOoHRATBZzitOJGKo1agIuZD90QCjpjha8o0oYr7yw6b++RZMDgQA1s1XW0N
	Gsf1aND5HQ1+fTuQeZysTPoFpn3Cc2eZR5003yr/cpq0q60G++gmvUt7yJs3hi
X-Google-Smtp-Source: AGHT+IGpz04tUrXPPdzvPALWiB03f2PPa2ldKep1ogo1wBz96/Sv/MlNxLIMNVL8/snHnNzdUBSogQ==
X-Received: by 2002:a05:600d:8389:b0:475:da13:256b with SMTP id 5b1f17b1804b1-4771e3cb77cmr9172205e9.38.1761726064072;
        Wed, 29 Oct 2025 01:21:04 -0700 (PDT)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e196a22sm35191915e9.5.2025.10.29.01.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 01:21:03 -0700 (PDT)
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
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>,
	stable@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/2] dt-bindings: serial: rsci: Drop "uart-has-rtscts: false"
Date: Wed, 29 Oct 2025 08:20:56 +0000
Message-ID: <20251029082101.92156-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029082101.92156-1-biju.das.jz@bp.renesas.com>
References: <20251029082101.92156-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Drop "uart-has-rtscts: false" from binding as the IP supports hardware
flow control on all SoCs.

Cc: stable@kernel.org
Fixes: 25422e8f46c1 ("dt-bindings: serial: Add compatible for Renesas RZ/T2H SoC in sci")
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Updated commit message to make it clear that hardware flow control
   supported on all SoC
 * Added Ack from Conor
 * Added fixes tag
---
 Documentation/devicetree/bindings/serial/renesas,rsci.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/renesas,rsci.yaml b/Documentation/devicetree/bindings/serial/renesas,rsci.yaml
index f50d8e02f476..6b1f827a335b 100644
--- a/Documentation/devicetree/bindings/serial/renesas,rsci.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,rsci.yaml
@@ -54,8 +54,6 @@ properties:
   power-domains:
     maxItems: 1
 
-  uart-has-rtscts: false
-
 required:
   - compatible
   - reg
-- 
2.43.0

