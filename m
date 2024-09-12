Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749DC1BE84E
	for <linux-serial@vger.kernel.org>; Thu, 12 Sep 2024 17:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726162751; cv=none; b=rZrpzT/9ra7q8i5DbDzr02/jI/TTVkXaRq0CRII+/dxc8zPnRRiNwfdu6Uleji1vO1FcwH0B42rj7J2ouBp5EOLlljATrxVEX/e9R0O0+oLRLr3MudpA9quCxakAZbz7Lp9iRe0qL9WbLb7zh55oDjCA8f7F1nPMJjJICe2sKSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726162751; c=relaxed/simple;
	bh=0j+r3D4/vHRDqFdTBnrhpTncxEtjKeJFxIg/Fe+um0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gq9iHreiMNuF938Qpifq+DAoq2LnKhYdaFpaQq5say+LXFz1OdwLhauyz+hocut46F2gBTvHRfs1xHqKFbvzzIyWP/6uMbafur801YgbZLSX2ACxrsQn+z8TUP0EHLIguzNVbP5Vn1Pnl6NOzeCme1fsgVIIt75toB/NocILQNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RqaS7sMy; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RqaS7sMy"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-39f4ff22a49so5922225ab.1
        for <linux-serial@vger.kernel.org>; Thu, 12 Sep 2024 10:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726162749; x=1726767549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYt+A7Qz0DxrKrXBCekZqUkGqVOmvoE4JK6g0PIC+r4=;
        b=RqaS7sMydEkCYOirmNM7Whci/GTagfhO2yq4vhK5viG6xyd6gubbCr8W8H82GTx+RP
         GG75kX3nweaodVvlQWZcNNttBSDQAuj1aLigluu27a9tAFab3zvxdtCCzeTltO5fa8sk
         vA7gA/2GQayUeFs0JwDLYUzCsBrNUGn4x2cm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726162749; x=1726767549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RYt+A7Qz0DxrKrXBCekZqUkGqVOmvoE4JK6g0PIC+r4=;
        b=vP/iTCel+8JYzk6RE7oAwOkgAlvCffbnh7WgWZ1+X7c35Hm33fZ1oa1gM1nnL/L+fi
         +93Tywtagn9EXBO0lOKtVBq+UlsT0pGAnqam2LpPAieub1NV79eMfYfCGLvHTQQnsU76
         i+h/91lRWPF+4taqrD8fPDkIA++B3Rt1PDAIX9kBcSr2saq5YVnAKshhEbL+7MYqlN35
         DpCAW1/zHhodKrgi0FmrW765J12UpcxxuCmokI8le8U2/S3J4uteg5S2fgidPsVmfM46
         MRiDhip0DFL7ODGHZasR32WnfgZzODBtyWH8BcxeVGcoZiIq4iiZvf9qYDC1bSzqN+xV
         PZSQ==
X-Gm-Message-State: AOJu0YxPWpR/HIl6oZiIWNBRrmttv5IJAwjdtzHdP6tMBs4ccXAbF7eV
	vxBP+smc3CgkTl2CHkqDolSW+/h2yqb3UTl1jgrtO6jOVR0AWhEAQ+OGUIyr7Gc2YjYUUeYTUBQ
	=
X-Google-Smtp-Source: AGHT+IEqzTdHtHBgFzNgHRzsE01wHflT3gH7y3dm6Xqs8f94BX69hzCdMeg7I8pPaKSZ66QnBGr95A==
X-Received: by 2002:a05:6e02:1d01:b0:3a0:4e2b:9ab9 with SMTP id e9e14a558f8ab-3a0848ac8efmr41082335ab.5.1726162749028;
        Thu, 12 Sep 2024 10:39:09 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-226.arvdco.broadband.dynamic.tds.net. [24.56.189.226])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a05900e618sm32570135ab.55.2024.09.12.10.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 10:39:08 -0700 (PDT)
From: Raul E Rangel <rrangel@chromium.org>
To: linux-serial@vger.kernel.org
Cc: pmladek@suse.com,
	rafael.j.wysocki@intel.com,
	ribalda@chromium.org,
	Raul E Rangel <rrangel@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] earlycon: Print a notice when uartclk is unknown
Date: Thu, 12 Sep 2024 11:36:20 -0600
Message-ID: <20240912113616.2.Id2235082fc6c2d238789dfc3ee923492e9ed7387@changeid>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
In-Reply-To: <20240912173901.3969597-1-rrangel@chromium.org>
References: <20240912173901.3969597-1-rrangel@chromium.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When trying to construct an earlycon=uart parameter it's hard to debug
why it's not working.  In my specific case it was because the default
uartclk earlycon assumes doesn't match my hardware. This change adds a
notice so that the user is made aware of that this assumption is being
made. This should hopefully lead to them adding a <uartclk> option to
their earlycon parameter.

Booting with `console=uart,mmio32,0xfedc9000,115200n8`:
[    0.000000] earlycon: uart: Unknown uartclk, assuming 1843200hz
[    0.000000] earlycon: uart0 at MMIO32 0x00000000fedc9000 (options '115200n8')

Signed-off-by: Raul E Rangel <rrangel@chromium.org>

---

 drivers/tty/serial/earlycon.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index ab9af37f6cda35..5a8fe0cb3b1986 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -145,8 +145,12 @@ static int __init register_earlycon(char *buf, const struct earlycon_id *match)
 		buf = NULL;
 
 	spin_lock_init(&port->lock);
-	if (!port->uartclk)
+	if (!port->uartclk) {
 		port->uartclk = BASE_BAUD * 16;
+		if (early_console_dev.baud)
+			pr_notice("%s: Unknown uartclk, assuming %dhz",
+				  match->name, port->uartclk);
+	}
 	if (port->mapbase)
 		port->membase = earlycon_map(port->mapbase, 64);
 
-- 
2.46.0.662.g92d0881bb0-goog

