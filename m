Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794727191;
	b=H3hEu7g6wDghuyon4u/mSI+KyEWqLfGH6vz+0Jo/fxpiZfoBRkidCdCMophFGbr6tg5X
	 8xFydUX/uQYCzkaDAqB4qHbNbYFzQ5HjpEMyCac8pS7L14W9QHnHB2XJZ52KQ5+Bjs9dW
	 IAxFlaAq2I5ySCc6FIGtgPYqFf/be8rSgRnHEuSbDX8laeQYMw5nXUmSCMRA7mMDjVAhH
	 wTNmt2cxVGYD5RGgzcCDqFqvq0NljMO13vfQ5hCuV5dORGq6KYIHVe14PePLuEWsfM5Al
	 wm0t24Ie4IiiH/oVA8J1nfAhkQZHT6JBgCkF0V4PF/rSNH+sun5ciS11D3CpAG1zUpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794727191;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=tEAC3AEP0gmVOZIrEp2K5naXDusA8lAF2Ew6yHoW5j0=;
	b=4LkSKCJUWSd6rZ31m05ldg7j99miRSAGAhpylk+Or6k+N1ZiLppjGkSx6epPK6B5k2c5
	 VnP4e4juqxPyevMzrojIFwVbOmKsgDsxUd2+K4fGKRvUiWawswdgZNtFeYbvjTNwNDI42
	 2oZ2+I1jQdXc+BuBQrmpfFOfchHFzTowq0vciXiE5eZdKxEo118Cn+XbqkY287zXuY/uH
	 wE+iKBkgEXBDIiQj0fYX/2et6tfrno1uXt1V9+Pzmseh3XulyDCb8W5Yf0R2GKwhv6MvY
	 TceNykITXG7fjAtR3CTysasdNWyOv1BgIpisyrmFuoRD/B7UyY7r9lRqJKtzvmqQkiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ErPm0KHX;
	arc=none smtp.remote-ip=209.85.161.44
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B260560A2625
	for <linux-serial@vger.kernel.org>; Sun, 15 Nov 2026 07:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B260560A2625
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ErPm0KHX
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-70b875f6f13so2871442eaf.0
        for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 23:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794727190; x=1795331990; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tEAC3AEP0gmVOZIrEp2K5naXDusA8lAF2Ew6yHoW5j0=;
        b=ErPm0KHXB4Mv060O7w91PxAQZnj4lSzJqaCrlPecymxQxZufCsxz6cv+hYWfhbtihU
         pdJqmR5A/OiXJ/6cVyyp6OOa9ckp4ZrXzfGv9ttSWI2Wer420pQOhk64kRy/kl4I7ncS
         EaF2NZJtozE1gSVbKoePM1btESFdANQr2KB+8S7+0x8y4BrZfEg6Sm24malWI/UyEst0
         +JWgrXFsw4Ondp1Bnr4KDxzb220OjFurLOOTr/hXUGDG18a0K+cMOCX5CGs6ZUQUGC7s
         ++h1hAvHkHb1fHmX1ASQBODhwj3+xSwSTDOC+huEIrHtHpTM8it1Ig3jrDHMh6j2iViZ
         L1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794727190; x=1795331990;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tEAC3AEP0gmVOZIrEp2K5naXDusA8lAF2Ew6yHoW5j0=;
        b=J+Lfz6V4hBIuV3RmOyEaBGCZKY7uoTF2AUwDH7CnqOxLyF3n67/OcJk1HViIOG51Nk
         dilw3gnUgaq+kCtaLPLackk0kAszZSwa4OcsQ7Cf24BJZYoxlLEsES3nTqfDYSkaFlFl
         /qTBL4lG6RfFjIAV+qutXFlrOrh8U/BK2nEulsXeCtx9z2odra2Q9OfmzAbW9r5QUk9B
         3T/Hwq4lyGlLZ0iCvJos12rX9atJTB1W9KSJnxAJUQOPLtNtatcF+ks9KFHrkL/viQ1Z
         Qy8nFTIzTl4KpgBcYCaTjsDg45qOcjwP66FEI4ASppVIc+1J22zwrY9KbmQaRZIkSRiK
         1pcQ==
X-Forwarded-Encrypted: i=1; AL+hErGTAdA1/OFzwna5CwjvjlMC4n9rT58UdcM9nOtGncAMWJKR35+oxXe6hWZAgy5cX6sr1sau21u4vMDxpNg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8nkc8T3f3GW23DnUYTvDrpYOhybi2ioZFycrcdwf7zu+cSJAa6
	edB+Qw3m4joZDpIaM6PHWVT8Ja//pBsOQHi+qURIs8l9RIjiaS/X3x7x
X-Gm-Gg: AYBFou3oPX8H268rG/6cYZ+IXoRHQvFCQjhyvsZJ9ZewO94GsbrUSdzGzqYFHqv59f+
	J40s75L2HWa0ysDDOqqm3krFJsDOd9M4ztrI7X5wxHm2Qild6y272gCn02ro6PvUinSkRxexy1p
	4PTsRK5j5vUeXERXTdOyQvYWy2Y8vR9XhUAQB/CJ0zQS8YZ9j5r5FZAKvCoryNPd1aaJDBxLora
	aPJMkUYudf2pXDghGloR/LSQXvgvzHqhJnfszNifQGfuUKlYlYzPnosaHhDo4z8EV0okDOQ7t4n
	wS1CyxeRviN0WblXQA4Zs89hZbYQUBj2aDzjab40EkOo9GHb9Hd1ap8+m/1VtkMmyqlNyM5LgQg
	vEAAvAaPOdG1FJie6V2aCn+vusSJGhvKTJnd+rE3xVGRGHIPqBOkUdWzsDi8HUfQrm+uVQBOzAf
	asYwlTCA7JebZNFA09QZt6Ced6oYzL7Djz7mpTGLsV1qr/xYwvpUdJxffbCQ+NTVvkQ/ZUBYQ/C
	bc4AMJiU+EzQnGywA0V5cnwVtPYiPi+Eac89Jfh6OsjfF2ht+elVmGQ7W8nK+2BGQZ22piQpGoh
	cjAMNtCtvwEmDG+iVJCdir73S7D8RJ1oPxF+5tCLtTE728AzO8n0qsQgKVEdWJDEnCGukG5OAHN
	IE0elcKMOqEvdQ+76kqd9gzED9Fpzq6y95zke/UpD+YDjBjS682ntog51lQbwKnQbLXuWKrYJDt
	8GAp9SYeUSN3FxR4v9x9YCmUOUlMMnJ9m9uQV0IBpEY4Z9AS5o8gQ=
X-Received: by 2002:a05:6820:1385:b0:719:204c:fae2 with SMTP id 006d021491bc7-71ab4fb81e1mr4716551eaf.28.1794727189811;
        Sat, 14 Nov 2026 23:19:49 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71ae860ebd7sm1145321eaf.8.2026.11.14.23.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 23:19:49 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 15 Nov 2026 00:19:40 -0700
Subject: [PATCH v7 07/10] dmaengine: dw: report residue for queued
 transfers
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261115-submit-dw-dma-synchronize-v1-v7-7-8d58f3d49e4d@gmail.com>
References: <20261115-submit-dw-dma-synchronize-v1-v7-0-8d58f3d49e4d@gmail.com>
In-Reply-To: <20261115-submit-dw-dma-synchronize-v1-v7-0-8d58f3d49e4d@gmail.com>
To: Viresh Kumar <vireshk@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Dan Williams <djbw@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 James Hilliard <james.hilliard1@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2

A submitted transfer may still be queued behind the active transaction.
dwc_find_desc() only searches the active list, so a status query reports
zero residue for the queued cookie even though none of its data has been
transferred.

Search the queue as well. The status getter already reports total_len for
a descriptor that is not the active transaction, giving queued transfers
their full remaining length.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA controller")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 3cc8579f8829..c602ea01cb83 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -927,6 +927,10 @@ static struct dw_desc *dwc_find_desc(struct dw_dma_chan *dwc, dma_cookie_t c)
 		if (desc->txd.cookie == c)
 			return desc;
 
+	list_for_each_entry(desc, &dwc->queue, desc_node)
+		if (desc->txd.cookie == c)
+			return desc;
+
 	return NULL;
 }
 

-- 
2.53.0

