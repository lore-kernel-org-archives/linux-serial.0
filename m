Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E733D71B4C
	for <linux-serial@vger.kernel.org>; Thu,  6 Jun 2024 19:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717703906; cv=none; b=cFj+fLLHG+MZVlgHxUBqsSkPO7ROQYJSvtCsMZwuldwuaZR526gDlvEBU6v+jmzfIGOHeeLJZnprz77XUmEcei582X513oNH7yMqu+6TG+4qSe67VEiOzJhpewjPedVq83vAy1xs/uPypESs7PoWFvad76T7034JEhFBMHbm1R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717703906; c=relaxed/simple;
	bh=Vs2VSZfdTFzFBYmrEYnYORUiXjngtp2QIi7p2bd1T9A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qPjBCKLQBrDTC9hhBAp1PF5S+q58J8D6vbYOjH3FIuix4dcUm/5s2K6OpgYz3sV4xPtSRHIPsobTKn44g4dWM/sRryOR2IsssG+N35HWRwwkmTDDfUmaR3wyL6yVSxK+UDMUVD+dZHD5NExgLjCWMh9is0Bb0e7hiAMwIVVchRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schmorgal.com; spf=pass smtp.mailfrom=schmorgal.com; dkim=pass (1024-bit key) header.d=schmorgal.com header.i=@schmorgal.com header.b=Zvfs0+og; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schmorgal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schmorgal.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schmorgal.com header.i=@schmorgal.com header.b="Zvfs0+og"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-6c87835b8c5so170729a12.1
        for <linux-serial@vger.kernel.org>; Thu, 06 Jun 2024 12:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google; t=1717703904; x=1718308704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0/VzEhoXRFXg030r8DGFCIJL7QCo862n6SDAAE5DMM=;
        b=Zvfs0+ogTLAn6S8GUz5ppAobvly5DGWEbwsXgGPmJ/Err3RiV+7H4sKbfGU6tKE4z7
         yrhk6VKN57ab8Sf8gPtesR5DQoTcEoRZrpskgpu09zRrsV4aCTz62gxBmdw5dbQ6MKpu
         vNH/Bq+RL3uZKbuh+8oeXWHhOCOi7AOueLaX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717703904; x=1718308704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E0/VzEhoXRFXg030r8DGFCIJL7QCo862n6SDAAE5DMM=;
        b=TeiNwJz7xV785/mVlPnzbtqF3DqprU41Kukg8mp+rMu77tIzNyq/w9dwM1awc/W95w
         MIRf4PiZFX+gRUYDCy62dlV+zwhS/wz5l3Tq46igyfcIc3sosxf20JmyHdBB4/TXetlM
         VY7fr6P+GEttsB9Sw69JQPRkfnVLVWnSZU5+ATW2Ad2vYNieh148lCdrOztdzQy65ByD
         LnZiFeyz6Pf2Ydxxsv4ZGpsKqRwHuwpXEnxEj/DfHWKdzZSOtVgCOE+jf3yqWWZwWLuT
         v4GHNV3u9Iic3OmHqz0y0B9hYk4AYXdcZteK3RYXZ3/AmXgJYmJXQRqvoRokEjcoAGmg
         Nt4A==
X-Forwarded-Encrypted: i=1; AJvYcCVs27i0D8xml9/B1ooSh8HEwjUJXyIUBS+6vklgmJWWLNJeVIFpB5Y6ZtR+OSr2FhReR7DqjvjXuX5dy8V/HBkpDtTzLNriQlzLK44A
X-Gm-Message-State: AOJu0YxoC8XlNB8bsyAhveeEk0ArD5WvuKzPtKrOAC5HFBTkP5C5I9ur
	ofx7Arl/oPJz4YSmPaYP3Py9INhc5URe09967KV0LT+h1d7F5JyEjnuYG0Lw6iM=
X-Google-Smtp-Source: AGHT+IHJmig2k/ZbzPrTMzdlYfQWU1c0lOnEnpHiDWCvb3lDcleTaZABQ2jMYmV09x0fOxrLqRXwNg==
X-Received: by 2002:a05:6a20:6a23:b0:1af:cc80:57b6 with SMTP id adf61e73a8af0-1b2f9c7e449mr731905637.3.1717703904014;
        Thu, 06 Jun 2024 12:58:24 -0700 (PDT)
Received: from doug-ryzen-5700G.. ([50.37.206.39])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd394f20sm1446787b3a.55.2024.06.06.12.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 12:58:23 -0700 (PDT)
From: Doug Brown <doug@schmorgal.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Jonas Gorski <jonas.gorski@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org,
	Doug Brown <doug@schmorgal.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] Revert "serial: core: only stop transmit when HW fifo is empty"
Date: Thu,  6 Jun 2024 12:56:31 -0700
Message-Id: <20240606195632.173255-2-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606195632.173255-1-doug@schmorgal.com>
References: <20240606195632.173255-1-doug@schmorgal.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 7bfb915a597a301abb892f620fe5c283a9fdbd77.

This commit broke pxa and omap-serial, because it inhibited them from
calling stop_tx() if their TX FIFOs weren't completely empty. This
resulted in these two drivers hanging during transmits because the TX
interrupt would stay enabled, and a new TX interrupt would never fire.

Cc: stable@vger.kernel.org
Signed-off-by: Doug Brown <doug@schmorgal.com>
---
 include/linux/serial_core.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 8cb65f50e830..3fb9a29e025f 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -811,8 +811,7 @@ enum UART_TX_FLAGS {
 	if (pending < WAKEUP_CHARS) {					      \
 		uart_write_wakeup(__port);				      \
 									      \
-		if (!((flags) & UART_TX_NOSTOP) && pending == 0 &&	      \
-		    __port->ops->tx_empty(__port))			      \
+		if (!((flags) & UART_TX_NOSTOP) && pending == 0)	      \
 			__port->ops->stop_tx(__port);			      \
 	}								      \
 									      \
-- 
2.34.1

