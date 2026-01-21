Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE42B48167E
	for <linux-serial@vger.kernel.org>; Wed, 21 Jan 2026 15:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769010861; cv=none; b=g8yfJJJU8KmB5es3VmqGCeZtw0uSdROO4AJJJXye5GYp89PNY59TfjJQSEzq5uLsbSUzoHOj4vP5Kg+N4W5SUY3CPpAwV26MI7BwOxLeWH6S2iwNVCRW0Cc8RlztLcCbkzbE/cHqSjQExqi3aKxOVQdi+PM0wuIfFPIjJrsE7bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769010861; c=relaxed/simple;
	bh=glartZGclAK5FXJvyFUlJJGdosWEu4ppdxvjpVhv+5s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rc/w+jGQrYq5GHuUY4+o+pG7Sfyl4EH3UZSD7rSDbBxKfbZIM235IfqcpDBx94CI5FghI3fN0705WXFhRNxzCE7srceUJNBRUUdwr2B9ZdaFlP8uZ1Yz295ywn6+RAxhlPuHY1Ki1D6eV5uD8pG7JQGml6CPcaoVJtMadXlB9x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cGeUl8f3; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGeUl8f3"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c613735d3b0so106990a12.0
        for <linux-serial@vger.kernel.org>; Wed, 21 Jan 2026 07:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769010859; x=1769615659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nuD0SbQcxJhlrMah0Jeffm4oSmypOkZ5/qjE/QZj8s0=;
        b=cGeUl8f3t21nCxElJle8iVybKvYBAEwFDJcjaSp2wWeYGbPS0UkhvZ95/nvBFwtQiT
         rZD+6r4H7GRhEc8w0ATq7hXJewswUIUMvFd632TJxpNqaE2t+nz/DaYUI4AoyP2st+Oy
         h9nPYvrBuYGnWy6bvRIIGIQ/m2yawPLSZI/H0xnhDVMbrGDlXZ1S2UMU74hTQErsLOHe
         GKWavd5/Rs2oIfRy/LGDXKKBIGHZfE18Wc72PnDrpBbZEH/RDqK617z4GXoDdPwvvwrF
         NRfLHdIZZkkBlRpaKp0E6Z289xxlyXVwL9kZ+1UrNk7+bzrU9zr34ngTVfjAN7ZMW6wk
         cmFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769010859; x=1769615659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nuD0SbQcxJhlrMah0Jeffm4oSmypOkZ5/qjE/QZj8s0=;
        b=MTgDADlk20UnrDdnyQbwmu9dZApxgvJDLEUVyefwY3+O/mG2ZqZT4VoGhRJ3tumDl7
         spFThhv11QFDbA8tKoQBWm9QNuCGPa0dj7DvvmZImePJzGhyG1Ui6maG/T4Fx0du7R4G
         ex3dGWjqvMwX+CRZQC8P08idIbE39t71O4bUue/x/OQ4ChtkGCvFdMMx6N7zgRSQA2ri
         9uUlguy3j7UxzSZ7Fqhj2EtEcq3LYq0/EyBnCUmFakrpagmwOd1nzyyhjaENQuPRFmf5
         FwQuricOZhmbN4yLalOXf7oGqrdfelLfY226RlSPVY0FIq9WuqI4NA2pz7c5tbvEQr8N
         IgaA==
X-Gm-Message-State: AOJu0YzIonR6GMGbXh+Ciu31UlQVEGR6fHyeQ26caHzpMGVwG32zHFj6
	92KDssz4T/jMHU+HKPgVabcGX5g3lHnAPWD3Qz0TsElxOh7a/pskF4eE
X-Gm-Gg: AZuq6aK71PywYc61kySAr43VXmSNZs5lMbE5sUOW2q+HfiNUzj9DgoF0prtSCbAwfyc
	Qf20+zTErvUOldJBA3iI38BGEV9on7rXOKWA7ncXN7dY+CeZScgOhpHzzv5LjYcn5DuNfjAhRuL
	6aDj3pzCBzKsuvFm77x5bKxO7PLveHOjTBSR/bMvT6LJy940qRoBusMZJn+UeACHP+SecEO4Y3/
	3lKFbuJChPdXdS0hrbuFxJrlURYmOcxq7aaN34wQua6IgK+n/feabZD3DdA86F8Ad35AFS5MlGI
	i3j1PBFtOoHkFrxvExOMpi1RFqJC8yMXAmarepkQwu7d9sDPpQN+Sb7wwOb28/trM76kvOKJ07F
	T4z+0gTun9GNS6LsE79nfzPB8gU6a1U0wzeb7CKiWV/RDl5FRpWab8WwY0kJG6BvXolh4Yd3owv
	DGR6fR9A1d9ZnhnE9rMfE=
X-Received: by 2002:a17:903:124d:b0:269:7840:de24 with SMTP id d9443c01a7336-2a700a32cd4mr156255585ad.21.1769010858813;
        Wed, 21 Jan 2026 07:54:18 -0800 (PST)
Received: from localhost.localdomain ([58.29.79.238])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190ac779sm156336145ad.21.2026.01.21.07.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 07:54:18 -0800 (PST)
From: Lee Yongjun <jun85566@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lee Yongjun <jun85566@gmail.com>
Subject: [PATCH] serial: 8250_pci: Fix uninitialized variable use in pci_oxsemi_tornado_get_divisor
Date: Thu, 22 Jan 2026 00:53:52 +0900
Message-Id: <20260121155352.52489-1-jun85566@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Smatch reports the following errors:

  drivers/tty/serial/8250/8250_pci.c:1246 pci_oxsemi_tornado_get_divisor() error: uninitialized symbol 'tcr'.
  drivers/tty/serial/8250/8250_pci.c:1247 pci_oxsemi_tornado_get_divisor() error: uninitialized symbol 'quot'.
  drivers/tty/serial/8250/8250_pci.c:1251 pci_oxsemi_tornado_get_divisor() error: uninitialized symbol 'quot'.
  drivers/tty/serial/8250/8250_pci.c:1255 pci_oxsemi_tornado_get_divisor() error: uninitialized symbol 'cpr'.
  drivers/tty/serial/8250/8250_pci.c:1265 pci_oxsemi_tornado_get_divisor() error: uninitialized symbol 'cpr'.

These variables are initialized in the if branch or inside the loop in
the else branch. However, if the loop finishes without finding a suitable
divisor, they remain uninitialized.

Initialize 'quot', 'cpr', and 'tcr' to 0 to prevent undefined behavior.

Signed-off-by: Lee Yongjun <jun85566@gmail.com>
---
 drivers/tty/serial/8250/8250_pci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index c5a932f48f74..b32d7e03c29a 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1200,9 +1200,9 @@ static unsigned int pci_oxsemi_tornado_get_divisor(struct uart_port *port,
 	unsigned int sdiv = DIV_ROUND_CLOSEST(sclk, baud);
 	unsigned int best_squot;
 	unsigned int squot;
-	unsigned int quot;
-	u16 cpr;
-	u8 tcr;
+	unsigned int quot = 0;
+	u16 cpr = 0;
+	u8 tcr = 0;
 	int i;
 
 	/* Old custom speed handling.  */
-- 
2.34.1

