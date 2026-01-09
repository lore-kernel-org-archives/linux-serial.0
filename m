Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4DB3644C6
	for <linux-serial@vger.kernel.org>; Fri,  9 Jan 2026 16:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767976951; cv=none; b=eYat22EGz9cWp6PYzzUNw0Rhq+wZgHlcMsExZd3C/kC02kjEu4qUI/eJb6o5sjVVcnto5/nve2sIpl2G6HLW4LN8KXa39aCV8JwBTXSNu2j/2q9EVGVvMSXeGJYKqc+S7nywvRuPB2HbNJWQKck8vkAhQvssV2su28niOqjE/Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767976951; c=relaxed/simple;
	bh=ujjrCeYW4Gws3dC552q2XCMpqxd2pU0ffvvLryV2FnY=;
	h=From:Date:Subject:MIME-Version:Message-Id:References:In-Reply-To:
	 To:Cc:Content-Type; b=B1lyVoo4pLFFNgQ2okkHrpQ7kUPSb5Rpiei/8HAgiQvHEPL9yTxW2FlQPev6ONeRgihGSJ6gaoUnuWL/JkvBWVMN9V3hhBMW+QxvuaDxvDWBH+4Dc2JZDwopQHdy6KYFbkhjj1+GkrQhEiAiQV/SnlLiiu/P8wK7GVfkV3Wm3fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JVg3EQiC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JVg3EQiC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767976946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xPVVsDO6rA1DUsYXI1T3bEgIhuRr3/ZOG3IZ44Wx0sU=;
	b=JVg3EQiCsvVA1KnI1PI1s3EcCO3l9eef/7paCGEyPKEKzL6g5c93Wwax/uFi22y6O1SybW
	grKY0FxghYpzHt6tYtllnFkFbmg1Vt17cr81mbnjGpOIiNt0ZzfRacmtgC5Wd5BtVtt+dT
	XpzASJbZxENOI03U2sRaLA5YdQTKioI=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-c2PJLnIrPTexjtfwZELQBw-1; Fri, 09 Jan 2026 11:42:24 -0500
X-MC-Unique: c2PJLnIrPTexjtfwZELQBw-1
X-Mimecast-MFC-AGG-ID: c2PJLnIrPTexjtfwZELQBw_1767976944
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5635d204db6so1109396e0c.0
        for <linux-serial@vger.kernel.org>; Fri, 09 Jan 2026 08:42:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767976944; x=1768581744;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xPVVsDO6rA1DUsYXI1T3bEgIhuRr3/ZOG3IZ44Wx0sU=;
        b=vQI4BnT1N+vIMjHxJcEzBtLgv9tqsGp++4XxHcjqioUY5tgZQW/teGfIiKLurrhc0O
         pzk5/DJaEXvoFsS0F5YEjm3S7fmQHEqPRETpLiYRtOHCnON+ezktTuX+zf5STYbIeP2i
         LHgwl1Auxzczo5wrjuvMXQOtrI9piD6shC2GvXxOaURvv1tPdcfuaJlwmLHcjaN0kJv/
         h0xxlGtOA487W9ulMk9VwebNcVk5ZMU/GBunu2sKBCt7mo2LZkec/B25Gl4xw8tRJ8jc
         CEjDiJ7KxmD+X2cTPaVtkpR6Li92jgrFNa3EXYk7ceYHDiAYv1QERBRN362EYkju7Bn8
         v7CA==
X-Forwarded-Encrypted: i=1; AJvYcCUr9pEvlpDg0YZbML5hzNGAZn7eYYYdH4ZWO/7mmYGZqnBj8YYMCauL/nZ1ZjWXLxiWOZEjzemzMFvs7Ck=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwxiEulfrRPCSAZHrTNEryjkNDkAAVeKH6VIl3rXY+0+OoPCEB
	D8ovnOyAP5QtafcvVzO9/zbNK5NrvZvRc883r4MBvmnLOOFHXQf9Gh0EMEMHgavFvNyvoAGeTvD
	t4qGriJLJ/2iZLslGYXOBjwRt5bxLnvdwYnl9Mzz2NbTNlb3gvqVUAd7ZnkqVPh4DefVtyoE+jp
	JaePnIjTh4pnmVRifgtASnGF8F7GvvWV+aDG1Fjbmul9Pt2c8M
X-Gm-Gg: AY/fxX4kWbadm4FZpvGVrINNEkvBeq5Z1fuWhoIxJZpg6UYULt1bJ2/zOA3vJY9zsbc
	nEzz/UWDlD43Ao1zrZ47Lp5CGA6A5sAngpDWgLbkPPaAB7zujtRwjFK+egvTFTb1KcuEQquvFLB
	wAfQyaq4j1iqslmmL7ltzaDBU5BqEgCLTmW6aB8ofSkwBcnCL1R2lXmh+BcEG5olvoeTvR4iGgh
	3EV9ENsDqPkqY4PddJ1e7ONahGPiOtEHJQzEwmjfqQB+bVU51vyFLYyX/x6oVTpiEla6fwxt/7c
	tTdXc0teFl+LLscwjt+o7BmMPID6v5/G80MF03826ONXBIzv0ETn83zlHoii7Cjze4xCdXA8Xnn
	CgzoaOeo6LhkAeQfU6p3mjCnaksiROfAfy3HzXAK1PjsKaXeA
X-Received: by 2002:a05:6122:32cb:b0:55e:4bcb:6bca with SMTP id 71dfb90a1353d-56347fc9816mr3106320e0c.10.1767976943991;
        Fri, 09 Jan 2026 08:42:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtnDxUMtxUijRDlzqlFp61IGR9PYQbFmaTUisWeimfwTT5wuJtWjZKVJdLH/522O2LT6I2iA==
X-Received: by 2002:a05:6122:32cb:b0:55e:4bcb:6bca with SMTP id 71dfb90a1353d-56347fc9816mr3106299e0c.10.1767976943117;
        Fri, 09 Jan 2026 08:42:23 -0800 (PST)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5636c753392sm1267752e0c.6.2026.01.09.08.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 08:42:22 -0800 (PST)
From: Brian Masney <bmasney@redhat.com>
Date: Fri, 09 Jan 2026 11:41:22 -0500
Subject: [PATCH 09/13] serial: pic32_uart: update include to use pic32.h
 from platform_data
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20260109-mips-pic32-header-move-v1-9-99859c55783d@redhat.com>
References: <20260109-mips-pic32-header-move-v1-0-99859c55783d@redhat.com>
In-Reply-To: <20260109-mips-pic32-header-move-v1-0-99859c55783d@redhat.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Brian Masney <bmasney@redhat.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1095; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=ujjrCeYW4Gws3dC552q2XCMpqxd2pU0ffvvLryV2FnY=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGDIT9Y8+nfjb6YR/b+3VSf+kbk87EdP5xfCJ1+VZp2UkH
 +Z4J9Re7yhlYRDjYpAVU2RZkmtUEJG6yvbeHU0WmDmsTCBDGLg4BWAiprUM/6P/H35mMH/ugr7f
 +w6F5U6YKOLpLrD10eLdp/byTclOZJvH8Id7U3WNwIPS63NYA34acBlnvAkxert4U0WEe/ihK+v
 aznIDAA==
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bonqNU1MzKbmdTCFlIRLKGjPo4-IOSbgjJXmrVuk1TM_1767976944
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Use the linux/platform_data/pic32.h include instead of
asm/mach-pic32/pic32.h so that the asm variant can be dropped. This
is in preparation for allowing some drivers to be compiled on other
architectures with COMPILE_TEST enabled.

Signed-off-by: Brian Masney <bmasney@redhat.com>

---
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org
---
 drivers/tty/serial/pic32_uart.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/pic32_uart.c b/drivers/tty/serial/pic32_uart.c
index 14d50bd7f1bd3575e60e51783bf5b2d821f9168d..8407f85776c07a7495688fc4f95b8672b1543bd0 100644
--- a/drivers/tty/serial/pic32_uart.c
+++ b/drivers/tty/serial/pic32_uart.c
@@ -22,8 +22,7 @@
 #include <linux/tty_flip.h>
 #include <linux/serial_core.h>
 #include <linux/delay.h>
-
-#include <asm/mach-pic32/pic32.h>
+#include <linux/platform_data/pic32.h>
 
 /* UART name and device definitions */
 #define PIC32_DEV_NAME		"pic32-uart"

-- 
2.52.0

