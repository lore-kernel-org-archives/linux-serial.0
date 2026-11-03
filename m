Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793721121;
	b=4hxMPArZwOfuyBRu96xSl3K2OXoT1wRZXBgWhX3Xr8+XWbJMPiHsmhIWrxGOyk6ONFqS
	 fSjuVde/qFpAsBMdNZ1E83yuMcylOpzAMGgc7Zorm0k4InMOLLLFDONQrd/DXyjZ98qbG
	 +mT/oXw0SHZSgw1XPjKU7MRpLKE8fKP08RvjWnA/M9zGeQJhLrfEIo0nsaphQja4Sf86u
	 QfoH6MwF/nTX5NuxZbkXlUKvOC8jmC6eTg1Lozr7nYCss3vwOziJcLe6+c3WO8ZM45YQR
	 1e8xO7rLGYIaQM8AmilYW6W1pzf+K9RLjCj68bm52ADNATEtJnmWL/bO1+5fA2F0CtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793721121;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=oxH63X4dAorJkZztMsnQ7q2lWTpXKUKEQkHtJyrOa4s=;
	b=whAHX56SoQn9enz+TLmSGlR9MSQMLp1GRg1hqyCwCXUWT3ucW0mAtAqCwzlwuHq9WxuT
	 NU3UqfUmXHzpwXc0B1qYReaiLmMBlXcBhxIu9GFWI5jqMaIDcRDL9I7ciUGWvupYk2Xkb
	 CEFXC5eiqM5oWx5Ic6g/T6nRCPe/ct6owVDrry8L/G/R1mej5dd1VRTr6qDcvsEpIdvlE
	 YJDEzMyxy2k1due+zgmwTufQXEvErD63RdQ27g2aSUeqWUq6tDAuCN6El+zgG4fXLsOL4
	 ZbJkiAZz0UxqGKn55PFmXEpSdg9WEg/qJIOs/Znuc3AvMrh0Nu717PS0jthjOtTYLcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0UQbTpRt;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2905606A330
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 15:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2905606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0UQbTpRt
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso35524995e9.1
        for <linux-serial@vger.kernel.org>; Tue, 03 Nov 2026 07:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793721118; x=1794325918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oxH63X4dAorJkZztMsnQ7q2lWTpXKUKEQkHtJyrOa4s=;
        b=0UQbTpRt5x4bFKA10POaXWgH7o2SI4d1Ye/f1CT+wpxWVp2oFRjQXbm1r+VxoUpzL+
         dctptXzSSZXP8mZmQjwCmrPtv09cKw6ekn5h1gLKabZpAbI0+SX/3+lktdnjEj4IAtyM
         Hg5BnLmXUuXMt5oiL5KOAMcPK3MPMTztSWnbriOe2R3iYtr5qTf9iu2SdG9P3l3uY6zQ
         FybEjfEKMnYetiIUeFltwHyzgdM7aGyw73b1OZsT3bHcXUNGO7bAaELgZGd71KaYoi5x
         lNHacUUFUMH7gRdtMya0yVhDHvw571QfrkAmorD+cdwFBL+tbEFxeIWpubcPt9/g2ALC
         9E5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793721118; x=1794325918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oxH63X4dAorJkZztMsnQ7q2lWTpXKUKEQkHtJyrOa4s=;
        b=bBmKQDydiKajEbhIC8JIAHq+6gS/d831oMIm2FaBifh9m30ts7qYPXzBA2f5MSWp34
         wAgEKecoyt9CTfZgDnJgzD6sLrANIch7leWVRUjmfTyhKhKhqMpnCAP0DNxxlrvQ7w2h
         qknlQ+XyDDeuAZmQf7ygXbNYI//thuoL/p3FEruD1YnQJUxzbzJTa2QESg3B6FAk2Njd
         SigKdZevtRKXEfPdpF/KenU4jVHwOnOIO5TY0oYZvcAFWDDzJuAgI6nwtXAxAOI3MfvG
         nX/6gdYYA9KniJTW9zWKuI+pnnsEjmfrz4ugRryky3FnHr/gpObBmfPHf0yAmAHobiw0
         M/Dw==
X-Forwarded-Encrypted: i=1; AKwUvBx0lkjzVod0wPXwBXAOyu5DuV8Z93PFNnjC+sCQ+DgpvwrCu/+aKSFKTmfnjIYP5hh/3h3v9a+6FwWfR8g=@vger.kernel.org
X-Gm-Message-State: APuU4Z/AlGOne4gLjCsSVAy+G2Tnqe7cciFUptjDHDC23ZYP62Jcs/HU
	Bpwgo/WHsrFDklfR6hHBbpSKRXNrIcZdlGDSeMiExPqyV0YA8LRrM7v2
X-Gm-Gg: AYBFou3XYbcd3KMsun5CRoKtevkx0JQuma3zC68LRkNKFxzytk6vfSJRFHcmNZ8rJjR
	fAi0JBgRVvj5ZUWNpFs+uFXBp7fCgV2bDJx3oDZxA3WbXb91k9OUn0p1Dh4MXGH6Bk2tdw/BzXq
	3r404+FFk9u8LBpr4tivctZmA9ZLZzq4m6/Z6v/wId0+SsPVf0hneIcdUiDV0FuiaGMg/EIIB/X
	eaxkUi49SWScNzi2xyFHCqKT+AfCWJz0s+YgnzU0QidV/KW9nz2YR31xV4brInhoyJSqCZ6etL4
	+voEY7v/0h34v4Ul+H/fl1l2aIiQ7mrzA4eRwCFkTx4dcxS6LfpVIS7KK+zdLq/Z1CW6WQ98m7x
	jT9mlLf79uhAMQ/E/t/fMqKr7Qzj7N/SaO4/xBMi3m+SxGzsz3rkFXc05MDBB+0fTickQW8gIaA
	1/htOtsty5i4OCHRD+UVRxhnzR8eodX8+i2cPomeq+CF+SoDLHpAGlPWKXbUPUatazMZuMBush6
	Dpkh2wN3EoxfDxr1B1cmDp3riTKOv+G5sNA5tIZ7SNL8PnMfsLYZvl1j7do3rr4ZqewCYoLHisk
	fElWAuP4ddOhHtkB2owjrT4Ixl6gopUn25M67kfEuGa1XCB7TO9VbJ5XkIbVPOIgSlk7J+ZCAGx
	CYcspFU8HJfLmE2Vt6JI88fEb5OUsiuBm9Ai+yyB+8JZvNU9umBU1
X-Received: by 2002:a05:600c:46ce:b0:4a6:7d6:821f with SMTP id 5b1f17b1804b1-4ac189928e9mr310741055e9.29.1793721118269;
        Tue, 03 Nov 2026 07:51:58 -0800 (PST)
Received: from Lord-Beerus.station ([93.66.71.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b964desm25680750f8f.46.2026.11.03.07.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 07:51:57 -0800 (PST)
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
X-Google-Original-From: Stefano Radaelli <stefano.r@variscite.com>
To: Frank Li <Frank.Li@nxp.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: luan.r@variscite.com,
	alifer.m@variscite.com,
	pierluigi.p@variscite.com,
	Stefano Radaelli <stefano.r@variscite.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Shitalkumar Gandhi <shital.gandhi45@gmail.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Johan Hovold <johan@kernel.org>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	John Ogness <john.ogness@linutronix.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Fugang Duan <fugang.duan@nxp.com>
Subject: [PATCH v1 3/3] serial: fsl_lpuart: Enable TTY wakeup for wakeup-source ports
Date: Tue,  3 Nov 2026 16:51:27 +0100
Message-ID: <58d65b44ca054ea83eb835bf5decebd688cad04d.1793719239.git.stefano.r@variscite.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1793719239.git.stefano.r@variscite.com>
References: <cover.1793719239.git.stefano.r@variscite.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Radaelli <stefano.r@variscite.com>

LPUART checks the TTY wakeup policy when preparing a port for system
suspend, but does not currently use the wakeup-source DT property.
Consequently, userspace must enable TTY wakeup even for ports marked as
wakeup sources.

Set tty_wakeup_default from wakeup-source before registering the port.
For TTY ports with the property, the serial core then enables wakeup at
registration. Ports without it keep the existing default, and userspace
can still disable wakeup through power/wakeup. The port must still be
open and initialized for receive activity to wake the system.

Tested on a Variscite VAR-SOM-MX93 with a Symphony carrier board using
LPUART1 (ttyLP0) as the console. With wakeup-source present, power/wakeup
was enabled after boot without a userspace write. After requesting deep
suspend, the board stayed suspended until Enter was pressed on the serial
console, then resumed.

Signed-off-by: Stefano Radaelli <stefano.r@variscite.com>
---
 drivers/tty/serial/fsl_lpuart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index c8575c965203..35397152a39b 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2905,6 +2905,7 @@ static int lpuart_probe(struct platform_device *pdev)
 		sport->port.ops = &lpuart_pops;
 	sport->port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_FSL_LPUART_CONSOLE);
 	sport->port.flags = UPF_BOOT_AUTOCONF;
+	sport->port.tty_wakeup_default = of_property_read_bool(np, "wakeup-source");
 
 	if (lpuart_is_32(sport))
 		sport->port.rs485_config = lpuart32_config_rs485;
-- 
2.47.3

