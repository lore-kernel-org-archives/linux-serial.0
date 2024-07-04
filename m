Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152171A4F11;
	Thu,  4 Jul 2024 08:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720081688; cv=none; b=UaTkvs3fBKOayYo7DCnPbzaVhi9ThktbsHjCJyOSiPuDgx3yV1rOGwO41P8PEd371TzmycCdPseK2Z39MJF8NxHmN8hy9xvy2dpHKiBlIX7OcLbOmcmLSP+Zs/3ZngRv9w8MsqqZMyalctwRvPsmbXvRDmTKuyauXkQGTujqk2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720081688; c=relaxed/simple;
	bh=aLX+cQ7ZMCPfMJJMI0dTwZLnxQrSI/CsTSLm9hXHCX8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LauiPWckWP+iymR/pwYFB6izv2egqDDTdkW8UTyl7cqDmPFWga+ufueIZRl+d071C6liC6r/SgRMkiKnQ3Fwubk8VZIlLizLby4ITc0MM7JXffxbr0lqUyeR5NXkP2YMd4PONNK0iPqYSmfQodcS7DXxYqqi/fywvhdOwmcgktQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FhhbiS9n; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhhbiS9n"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fa9ecfb321so2234675ad.0;
        Thu, 04 Jul 2024 01:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720081686; x=1720686486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BC+tk4kFCafFZXuwLW+ovs6K6GL9Zx5oLe2owdS+qcs=;
        b=FhhbiS9naJHCX3yQBKZDOFTA8/R7bx2JaCO3cBbabPgoRFZ84ydSuLJ9aQVbBVgiZO
         uqssYi6h6/LmTK845fLw+WLgUuUEi00Dgudkvbjqo+Du+4e8EnuV8lx9FHFSrGZAOkNh
         41eTrZLvFAvXDS5WkRu6naNAHhi4QFsPSdxEt4DUpyuNrSUd6CDbEtv8q/aWe9uMNQDu
         D751t+7Yk1Butzmy5zeCzHJtYJKChFem9TjuORej67WPinlBI9INSC5vH/5OtD6riSh5
         7T+MZ3IIsTcntk8NzH4i/6VDdNxPpBLxu7J/KKswQbvwEgH5r/rL+0FeuWZnMAfgzxNV
         muBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720081686; x=1720686486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BC+tk4kFCafFZXuwLW+ovs6K6GL9Zx5oLe2owdS+qcs=;
        b=efg6BWkLpVk3oaoz486Ae2b85+KPapnwPC1FX4gYoo5nXYZBFpisEAgwu+ecXnnfwD
         6v8u/RIRzuWgA0x40ZYMXh2On/MYDerI6GV9N652BIpE1+Az90Cs33tJuoSpHd3VNc9p
         IHhyob22EGwpbOqjl11JyGT1a5DoYp4L79WiJQeHexDTD/qKF7lj/hzLOgxvry9Oz6LA
         EW9CYYzEiAQk3yw2dE8aBqkCJtOctJmfW3D1b8qrgaQM3ne4SbgLElXHXJVdmukqApUm
         OU1qxN+DKDDYsp1D0NSNPXJXOxb8Pf+6+k+2ZqAXQ6pqPbFnqAq1EvqJr71LI6GXD1QP
         Mw8Q==
X-Forwarded-Encrypted: i=1; AJvYcCV8W1sgndS0E/kjY4XJOLMiEFofmXo9CFlwMspE+dwJ5HdqXbD5qYJG0wdoGzGAU7VHLSsV+Wo3prn5l+m+ncwQwbv4zeQrUiJ+YiuVO7XJq+VWGw2lsnVcLsNc7BtU5hRJAdRdrAFGLFqo
X-Gm-Message-State: AOJu0YyDEW7oDNgn1pGUH5aL5w+qpBSfmbIaxz6MtqvsXD1/CxbPVLpf
	agXPddvl0cwcg9vDqHBMCWA3W0RMAevreZvj1uQs1bZtYw8JaEUH
X-Google-Smtp-Source: AGHT+IEXOXaWIp5OuoFajO1WGvUf9znyJi+0ZEu+cWN2MdeSvi6OzBKSamv+oJUzJoJFU4kWg6tmLA==
X-Received: by 2002:a17:903:2284:b0:1fa:2420:33fc with SMTP id d9443c01a7336-1fb33edfd51mr8817535ad.48.1720081686196;
        Thu, 04 Jul 2024 01:28:06 -0700 (PDT)
Received: from oslab.. ([101.6.43.211])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1535b13sm117139555ad.169.2024.07.04.01.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 01:28:05 -0700 (PDT)
From: Tuo Li <islituo@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: baijiaju1990@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Tuo Li <islituo@gmail.com>
Subject: [PATCH] tty: n_gsm: fix a possible data race in gsmtty_open
Date: Thu,  4 Jul 2024 16:26:58 +0800
Message-ID: <20240704082658.189577-1-islituo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the function gsmtty_open(), the counter port->count is updated without
holding the lock port->lock, which may lead to a data race.

This possible data race is found by an experimental static analysis tool.
This tool analyzes the locking APIs to deduce locking rules about which
variable should be protected by which lock. And then the tool checks
whether a given variable access violates the deduced locking rules, to
detect data races. The above possible data race is reported, when the tool
analyzes the source code of Linux 6.2.

Referring to the function tty_port_open() in tty_port.c:
  spin_lock_irq(&port->lock);
  ++port->count;
  spin_unlock_irq(&port->lock);
    
we add a lock/unlock pair to protect the access to port->count, to fix
this possible data race.

Fixes: 86176ed90545 ("TTY: n_gsm, use tty_port_install")
Signed-off-by: Tuo Li <islituo@gmail.com>
---
 drivers/tty/n_gsm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index be35f7334ecd..b709f1a6bd2d 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -4307,7 +4307,9 @@ static int gsmtty_open(struct tty_struct *tty, struct file *filp)
 	struct gsm_dlci *dlci = tty->driver_data;
 	struct tty_port *port = &dlci->port;
 
+	spin_lock_irq(&port->lock);
 	port->count++;
+	spin_unlock_irq(&port->lock);
 	tty_port_tty_set(port, tty);
 
 	dlci->modem_rx = 0;
-- 
2.43.0

