Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780FC26FA4E
	for <linux-serial@vger.kernel.org>; Wed, 29 Oct 2025 08:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761726067; cv=none; b=oLBvHGUWgH3LKIPYuwojpW+R5cFHHSRbgqh8pw+WRxaycikJz3TmFkMPae8gxkfqo10ksM0l+M1Dx1NHhIboEYeA6/i90xJbMEF9bFUo2IW9yQ8N2vkJtQdjb5XN1DGAMVyyirlxBstdNxxews88TlKp8DXc10ae0x+wrXJSUpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761726067; c=relaxed/simple;
	bh=qZoW7N0sN2JRmXRUOLhAa6wR0SjQGEcDLutTGWrtq4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UPVMqloJpupcTSyDV1ku58BwNBcKxFbD8DJCY5puSH1IVBILl/on8k+/XX7qx+JJT2zXNs9OjhtMM1+9vWqyZMo+JOHtlUMEWSG59PDWB8tH7zIsrXprfHjyInTLvTCGjF6bDyFeon7kwyx32RQiIcEgjV9Qt3ziQ4nK3ke5ApE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBaLoI6F; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBaLoI6F"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-475dc0ed8aeso37983955e9.2
        for <linux-serial@vger.kernel.org>; Wed, 29 Oct 2025 01:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761726064; x=1762330864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6pJvu/AhBQH/Vqyc2G8OkoZZLbCOtPgyePdybPKTWJk=;
        b=XBaLoI6FmnZ4QW/331CUZpS4EexBHt/2D8+y6ePD0kETOZjf0893sAgjvBGcftQ8nb
         QJUSzCzC6VohBkDK8fZ6WOYyIDZQWiKX3SmZcwGh1rSxgtxCGu6+V1cCrUOh1WI1cw1i
         G/PEOzBmm+BRKbOH9uiagSmOVWmyBV499W1E5/nN/LrYZqvHUXP60ezCMVUXAghE2ZZp
         o2aSxku9CsOxA//EwggqEx4ZVsJuaR8wJUC+CNVcX7uXechBSHdh8RtEqRfOHCVqCLgT
         iyUHQHQvC1CKI92QBLW/fSHnTmB85rsKkfEntZrzqJ8gXiZv0yf6XNuXaA5VdHjBmxyo
         4WPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761726064; x=1762330864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6pJvu/AhBQH/Vqyc2G8OkoZZLbCOtPgyePdybPKTWJk=;
        b=VxzIgdbsfHQRiTR0PdZhfvcOGm6c2GhDXTEHfI9VJFupl+FSiEYnC7l8DrxOQpNyFN
         WOKb6t03R68zSm/0NTlswwnRRXE9ifgkuEvCEktWMAZXoCu4EsPBso27zkvejOpS2XmI
         D6Wao79K90TV9lur5/KzOMM6Ev9K3vAKGCRkffZalJzH++7U59vqr9h5veI9gJHf7NiY
         BMuFN9lwrZoU7/W+N7RKTbYY75jT2PWCZWbovQi02fsZ2HraWJ/SW4BRMoD7CnRj+rdO
         wungnOBU2IrJmPrcWztm2pMlbzISlMDkR8sqoNVh26WjN7VJquWRvQ2ewnfj1ie3e2bS
         9ayA==
X-Forwarded-Encrypted: i=1; AJvYcCXPweC2ljt2Uvz7KICRw4ByrO8ws5suFrXmnRCwGBpFMpenvh1GiRde5jI+rJJ4d2U/vIWXcfBbmsf5FzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZBKtbzj1rjO7yUR8tQ6vvZlr98Z2tWqmN3e46laUcJU9ogvm2
	rDGvX1ckwIgX18WQer6wKmeaydyrDnIJaYlBL7a3Rlz0hgG2Wjw46CC7
X-Gm-Gg: ASbGncts9MzdLj7pFdgpayTwBt4fxwL6HaHERq3xeB1fbtthB3IX95Qrre3GPG9dkNi
	bIzSF/e9yj3/bszBYqAgyE9X3qjhHl7qGmejq5XNFfIhvUdf53OPDJgqk+wF/8tP4fmJaeFXC/z
	ucFFvJdaV7KkdEojrHKcPqhaNEf1ZbyTqkW4qv/X32oOYbhb4JVQL8Jy52iHtyJwXYvsqd8tq+r
	M5JFq5F/liQ/SzTFpH2Gx0rguUPegADhGCp6NSNZ1bt9oED8u8dI/XSn0R1IxwyTo7De9wtpLnf
	ViFegfLR55AvrlOhyIsgSvBGfBaseIea6i5KZhkXN7kaLRqOZnZx8XCY+gY6seglC6y5dpeAPNb
	rimg99N1+A3WT5+uF9R03sXtJveFGkk6pls/eDhE922htZl34xc2uDdtAWbXDNyAu3MyPnLnESZ
	W6PcvNzZN1WULsmy9bJM7yaLIXmS0cgp9yiGdw3hj9Sb2w1T8DyUqtBB/BTf1e
X-Google-Smtp-Source: AGHT+IHuZVrK8iLdLDMqrJhiJBdDaaYTleDzT7XKu/JdrTppl/2IYxy2VXVcdkJYm65pKirVPO41JQ==
X-Received: by 2002:a05:600c:4511:b0:46d:cfc9:1d0f with SMTP id 5b1f17b1804b1-4771e1de278mr21430785e9.19.1761726063434;
        Wed, 29 Oct 2025 01:21:03 -0700 (PDT)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e196a22sm35191915e9.5.2025.10.29.01.21.02
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
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v2 0/2] Fix deadlock during RSCI FIFO overrun error
Date: Wed, 29 Oct 2025 08:20:55 +0000
Message-ID: <20251029082101.92156-1-biju.das.jz@bp.renesas.com>
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

 .../devicetree/bindings/serial/renesas,rsci.yaml          | 2 --
 drivers/tty/serial/rsci.c                                 | 1 +
 drivers/tty/serial/sh-sci-common.h                        | 1 +
 drivers/tty/serial/sh-sci.c                               | 8 ++++++--
 4 files changed, 8 insertions(+), 4 deletions(-)

-- 
2.43.0

