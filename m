Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4788233933
	for <linux-serial@vger.kernel.org>; Tue, 30 Jun 2026 21:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782855653; cv=none; b=VVbC/YCbuQ7C3AoT2tZHi4AmG8QrCrisEkF4XqnPxXru9SYoiBpt3mIjNzWiKdpp5sztu54XdZC2db386WQNHzn3owFFyOuj3tRvQchsPb+qlaUDGgeap6aVJ7GgKkVpoXuCZzXY7IKDeYqmpqWZuc/4vbhpoSdsSfSsDjEaLkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782855653; c=relaxed/simple;
	bh=9PdbBDrJosyX5pVhkoD8q4hALAISiVxkpmummc8kLpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VxwdtNXdHnYJ/G73w9C3JsSv13rK5IXg2mQqTm9LzI7WF8xfD0mkiaaOwk7AO1gDgQ4cOGwy+MTwr+WK/HFED7B30TPZbNe6f+M0QVaFcuZavEVLQTSGjmOmaOIWNiCn5skCowLXL1ZHsIthfahVfK4ARXPdfhEEKaUQ91RxeBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=foYhm8pt; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foYhm8pt"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92e67555e24so104796285a.3
        for <linux-serial@vger.kernel.org>; Tue, 30 Jun 2026 14:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782855651; x=1783460451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kfP/+/XzENqIHs8vBadMsBN8LHk8zW+7QrwYcaSOfQs=;
        b=foYhm8ptA+UPJIDnegnFsMg/caIzaZdS5qkMiVoAFAmqRV8qdYQg95MJTAwVkHnDh8
         zyX8+6ZU1TsLsexIxnZfuWpV+PSHoU30nXqAJG4tl8EEfnKPxae0bffebRdul2rwWSQ6
         ob9Nf0B0KGOQIQPlJfr9pBR7Kxxy6Lo18wp/bU9K7aIttA2eFc5zQFQXsV/aqbxlp/Xv
         W7kE+zfFA/A0mCCiOuefXv8yKVniI7RiOM6s57REhYDU/q+m6jXWeDRFc/hzAHzansGq
         LkR9D4gjCn4/U4rXU1WDqOSibATZFwmOXYSyhsXdL5Hv7ruadNsGnX6DLoYP1KtcU9C2
         B7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782855651; x=1783460451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfP/+/XzENqIHs8vBadMsBN8LHk8zW+7QrwYcaSOfQs=;
        b=CPC6Ua7zMybnJjTfcgOPMKO8AMVUTdfxHhtjomCWaR+7pfJbVsLRrNXBWylCtvj33E
         jhKUH3N+pEZEjzyirCb3bzc5Be49PL28Y9emmnB1pqrsJB/OZFSebqueA8E3gwFE24a2
         A9gpo0tPu2oLYiHYMsFs0VvOKCadbZGwjuyFu723qkqQpXvT8vWFUWO2cXUM4H9gxDbd
         F+Qlpt1kR12UVO5QsrghLY02Dmmf2nc6WdLw3CeyVTsR+I3OA/pEQv7NwBNP51jnL1LT
         97cu3TUcrzaMKY+QFyu4ntY+siqUTd4+BSUb/QpQYgj4jtXATtPXinrcnj0eCpwxKcKG
         CwFQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Q1eQ+r2HoCzDuIPE5GQd9BbXEoPtY691tDsp/o4aMNov0sB63G8Q+WsK9d7zqs2ACXLRq8gHgK5IVMXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC3alYsHG3xkxjLeK+cvjlitMDL80w2eX4MuW87K1UVTHXjY6R
	L7R8aiAqEAw8qCN6FF2x45KJDctdSiw6SP2bYNUNcJxs+7JLSh/IDJku
X-Gm-Gg: AfdE7ckigvpx2HCGrgVXjrMLYhGb8ftsuduUqRxmZAD/ev1BqzBz1svyjqN1nLY9DS5
	AX8JGGUvyV8z/ulRLpWiuA7L0kexjv0bE/kz/HLFEe8XY3hv+30wkgnLL4BOQooJf9lhaQ9PJSE
	vHhXQesk690Xz2+xLnKjaHDgUmAtVD5xxkSzMEGr2e2ZwGLSzpPbNihh0Tmptm2b6aBkC1ut5Vz
	SBN8FkqFk9lx/yVFl3/m3t5fyCf18CzrhOT3PGhO1B5YuMQ2L963zJjaUdauEggDIJG057Pz/wM
	SNu+TujuwxX/68YuXKssJt8xt/ySKRj1gfe0qDhFRf3Wj071YhRMtNK4yruOJQm91uIORfZ90Ya
	0DkBw0daKh40/UGACuZkgMoXr3oXTmPm9AGcZXilICR26gilXIv23aNbfGIf/CNdR1aqFVJOtvV
	lhN4PtuFXHV0HpbtxwnnJL9JR4Dfufo4/uE5EMnkux
X-Received: by 2002:a05:620a:1a01:b0:921:83c6:f948 with SMTP id af79cd13be357-92e6249fe05mr848255185a.6.1782855650630;
        Tue, 30 Jun 2026 14:40:50 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e6213bc35sm341819685a.1.2026.06.30.14.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 14:40:50 -0700 (PDT)
From: Yuho Choi <dbgh9129@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <dbgh9129@gmail.com>
Subject: [PATCH v1] serial: ma35d1: Fix OF node reference leaks in console init
Date: Tue, 30 Jun 2026 17:40:43 -0400
Message-ID: <20260630214043.1887351-1-dbgh9129@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ma35d1serial_console_init_port() stores matching UART device nodes in
ma35d1serial_uart_nodes[] with an extra of_node_get() so that console
setup can later read the "reg" property.  However, the stored references
are never released after console setup has finished using them.

Drop the stored node reference after ma35d1serial_console_setup() reads
the "reg" property, and clear the array slot to avoid leaving a stale
pointer behind.  Also release the iterator reference before breaking out
of for_each_matching_node(), since the normal iterator advance will not
run in that path.

Fixes: 930cbf92db01 ("tty: serial: Add Nuvoton ma35d1 serial driver support")
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
---
 drivers/tty/serial/ma35d1_serial.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/ma35d1_serial.c b/drivers/tty/serial/ma35d1_serial.c
index 285b0fe41a86..920fe7ff5083 100644
--- a/drivers/tty/serial/ma35d1_serial.c
+++ b/drivers/tty/serial/ma35d1_serial.c
@@ -608,8 +608,14 @@ static int __init ma35d1serial_console_setup(struct console *co, char *options)
 	if (!np || !p)
 		return -ENODEV;
 
-	if (of_property_read_u32_array(np, "reg", val32, ARRAY_SIZE(val32)) != 0)
+	if (of_property_read_u32_array(np, "reg", val32, ARRAY_SIZE(val32)) != 0) {
+		of_node_put(np);
+		ma35d1serial_uart_nodes[co->index] = NULL;
 		return -EINVAL;
+	}
+
+	of_node_put(np);
+	ma35d1serial_uart_nodes[co->index] = NULL;
 
 	p->port.iobase = val32[1];
 	p->port.membase = ioremap(p->port.iobase, MA35_UART_REG_SIZE);
@@ -648,8 +654,10 @@ static void ma35d1serial_console_init_port(void)
 			of_node_get(np);
 			ma35d1serial_uart_nodes[i] = np;
 			i++;
-			if (i == MA35_UART_NR)
+			if (i == MA35_UART_NR) {
+				of_node_put(np);
 				break;
+			}
 		}
 	}
 }
-- 
2.43.0

