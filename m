Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D222D201256;
	Wed,  6 Nov 2024 14:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730903251; cv=none; b=Xp2DGexWc9S89GAOAtNAgk0T01AUEUseHHgxPSM8HDpbJSE9VWbuYPIcYZ0GKjvCxQLHGlc64ZTDh9CFLnJXoE8hP8y2C9QHstCVBWjO7cz+SG4D2xAuG3BjOK4NPR0O5NKLGYI1kLBI4Mt/jQsOxf2wuTxU/RreKoverX+iliA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730903251; c=relaxed/simple;
	bh=Rv37NiT3+iDJ5CgpqJWaTOJjv4nw5P8z90idJ9ZnGXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kn4oCR5z7Soxq7x0erGxVdJvEGSfRXUjoYgVwfL+9iT9W9E+ubxBaTo96n3sR7OMjS6b/mpyaaUZVto1OF4hI4zlFGxWmTPMCEhWCH/CrxOf0Sa4b3gPZXT76VM4nYAdv0qlEccAEcW2WYm9gAGy5IVA8gplNmtUAIzEIqZjcFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d50ehJic; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d50ehJic"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-72097a5ca74so6364556b3a.3;
        Wed, 06 Nov 2024 06:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730903249; x=1731508049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0JcE14w5p6N0fo4tVcmmC31puUI/DV24DnItGCBT3I0=;
        b=d50ehJicInFMRGDh5UVL+kCMbNe3ZG8FgIKSHWDuqcJhydmdSe2UVJrS7LOVewAUoZ
         A1o/AcISTU5EQCQEcUMeU7LGpYgwsHk6236Ml+j2p4WwKxDNw8iD9qCX3Kst1PIr6FpA
         yf2rH9RFbo/0ZTuP6+9vppbxGmpZ2zgupvmZS/zhF95iyUmtLhKLNE0ePSdxPxTLLucv
         tPIA8/gcsW945jMRJjNCOySnUtFrpmddIRt+M8c8hcGAuzHZLAy6AbuP690pLQFkybLu
         0TMHNF2lKXMAv9K9vDmi2RYJ6kAyUi4IpmYOVBH0FqvegUAWjURUit2xRb+7V1gr8sFv
         t2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730903249; x=1731508049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0JcE14w5p6N0fo4tVcmmC31puUI/DV24DnItGCBT3I0=;
        b=Xc40sEhEdCn5jULHlTz6L/RldmpmE6tB0AFTmpHd6v2fQ2FTe1/m7doQl07J1uUXj5
         xvxaoR9Ct36OW3eaIszLBaCD7DFrHcQfjP9c4T4sVcd5ACy4wz70jwBqZobkPP/czY69
         gMpIkHCILeWQXduvXAYdPSNjxO3dazJk75csrtDTq5eztI79pB1DV/Jw3QXfYIQ/hBd/
         KnpR6CWLQUb7qQ2e5iX7VBv0zvVu9AsLPzbgxOK41o8+oqKRNJ9zip30CWCOKhZzwaD4
         xAKOni33OFjTlQUOtMqnN0CJqje8ynw5yq5LC9M52zSosTPfNPkTevinoWBvMhiQOi8R
         rphw==
X-Forwarded-Encrypted: i=1; AJvYcCUy4tWaZqMbqI0mTD/EVq5XOkKH1kZTwbVsvTfxm+WQg9sBKnlMwuNgWrlZr1DirfImanv43/Z9vtBHkQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiLoVvU5dLfGrrajXdQ1KK8RDAagiOz0x36HyRs0JTvtjmlQh4
	ENNpN8/NuYzxFmNKpDDATUIsPP2zeaLcy5UmrP8BVe4ZjEnfML9m
X-Google-Smtp-Source: AGHT+IFg06EqOdCF2rpOYxi14EtM+wTa5t4FQVjglGsXDwwnpcFEc0NFnQQneJknXwmLobufAnZm3A==
X-Received: by 2002:a05:6a00:3d51:b0:71e:cd0:cc99 with SMTP id d2e1a72fcca58-720c98a1bfamr29992840b3a.4.1730903248950;
        Wed, 06 Nov 2024 06:27:28 -0800 (PST)
Received: from Kuchus.. ([27.7.141.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1ed2f7sm11843129b3a.64.2024.11.06.06.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 06:27:28 -0800 (PST)
From: Shivam Chaudhary <cvam0000@gmail.com>
To: richard.genoud@bootlin.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	Hari.PrasathGE@microchip.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Shivam Chaudhary <cvam0000@gmail.com>
Subject: [PATCH v2] tty: atmel_serial: Fix typo retreives to retrieves
Date: Wed,  6 Nov 2024 19:57:20 +0530
Message-Id: <20241106142720.41351-1-cvam0000@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typo 'retreives' to 'retrieves' in atmel_serial.c file.

Signed-off-by: Shivam Chaudhary <cvam0000@gmail.com>
---

v1->v2
 - Improve subject line.
 - Improve commit message.

v1: https://lore.kernel.org/all/20241024172300.968015-1-cvam0000@gmail.com/


 drivers/tty/serial/atmel_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 09b246c9e389..bb1978db6939 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1166,7 +1166,7 @@ static void atmel_rx_from_dma(struct uart_port *port)
 		port->icount.rx += count;
 	}
 
-	/* USART retreives ownership of RX DMA buffer */
+	/* USART retrieves ownership of RX DMA buffer */
 	dma_sync_single_for_device(port->dev, atmel_port->rx_phys,
 				   ATMEL_SERIAL_RX_SIZE, DMA_FROM_DEVICE);
 
-- 
2.34.1

