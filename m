Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792772858;
	b=knsUZN64ImjhQMLGNVieYRywx7mVM2LYeUnaHTNe7+n2NJPBXDTKaIAyueNjP91IB0mY
	 RI0HF5dcTeEh2tpKf0hk9kMYbZEMLNuWdeecUrtjZlAA+J9f4drzH76J6czJy4zEe15Vm
	 AZEJ7LOQfgfXiEkbx1JJWi8LMtfIuGdX3yATqqBitUpDgxdXaPIstA1FPKHS0DDz7/ouZ
	 HaoV2a2H0Aw3KD294wJtc/YR14mx8ZYPDtuJwzwxriwLdr7E52sQK7wCEcd2uRkhxETU2
	 QxGZS/8iH4nKKwoRIy/jcqhQXRHPpgAQpo27I/WITR03c896YnBJZqcsD0fhHtRpShQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792772858;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=NcEoJJHS6s0Ldxcf7QTPPdL5n5yIYzYW/l921a9eHYI=;
	b=fy7cH8OwmWYPYZnwiGxD5a3gk0v9r0INWeH1nqt2ggX9pDB7NzohwcF+I+uaSkNTpTKB
	 NclX90jVBgIWbVDzLMYRokZmgmuxJWwONhA9PmE6BNt8gmfvn5JBDRwmUyL8XuWhfvGYA
	 kHwk6VGY71Zq/EoRLkkY7PlLPcfNNxL3JSWXOOjaaShF3X33rtw1TR7CRwAtj2M96mW4+
	 qlAurxtaH83ky4aVzrSwclvzkb6hx3aHUSBKuhDUS/MA7JECPlFjLvxS1YacYn4NcoLnC
	 7X1wgBTX5I+ZkOTrdGnxAUOxCW50IZadqDR8QHjCcRSomdIBYszUWkogpk/RRWXxsQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bstAkr43;
	arc=none smtp.remote-ip=209.85.161.52
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3C160A2608
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 16:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C3C160A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bstAkr43
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6dd4f3f696aso647702eaf.1
        for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 09:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792772857; x=1793377657; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NcEoJJHS6s0Ldxcf7QTPPdL5n5yIYzYW/l921a9eHYI=;
        b=bstAkr43KzEfnOvQVvQpkrC8EZcMp6H2yQHgpP4YuHjnzJC+a17LoDM5bdUOUNW14R
         HMEgiATvdmlwKaaPHQqESqvPfVEEWC3ZiMmMAFGk6/Zn4oSNgmztKNNiyTt7IW/zV/O5
         Z6rMDPxCaqmVFUycbjRBX85w6Hegt/Z3CWp8SLFIs4wrlAhwK3f/uw1WRvmzsNkGFTHh
         xDNPJXpn4thBivAWoiAar5mDqWYGhYwUCC9TuD++5KpUkDGnmr7j0/t4oPdwO6olyMod
         cHDZA5MKEuAWrlB6q6F1VAPAmY5VqZiDyA83jr44FUA0obY5NInDglv2mqUQRUUqzxQp
         vtJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792772857; x=1793377657;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NcEoJJHS6s0Ldxcf7QTPPdL5n5yIYzYW/l921a9eHYI=;
        b=wVlTfKbTv/b0aUy/COOckmo3/Ym8jfDuXHyYJXksRuvWmAK3dvRPns+vhoaRHZRaqE
         jwatT6aqZeXj3OWb8J/6mhZDvgA0dpCMqx8Hefi8FOYvnDoBx2oKu5k2SeBRDjIc0qs8
         MHtXGHLw9JHdcprkthlG5cYR5TW2MUk0wgP1y6hqIStrAW2aSwLHW3TebSC/ELuqVHJD
         4EFVZgYvhlngKNWD72NMww9qQrwsxTxlJD3L1jUgz9CdvqYHmZJObf24aK3j4h6/9DDc
         UMCTrEU2XJVw1ldQwScUHf4JIAOqb1q4LmKAceD5u6Wp1vq3s8Ly5djJagKR9Ff7ND41
         veKQ==
X-Forwarded-Encrypted: i=1; AKwUvByIgq8LmxjrAEHGgk48dTpBL+MTtU/O4bvmhcGrs62YKpE6MbbhsolmwC2qx6NOuE+dWD/QjFPrl0P6T4s=@vger.kernel.org
X-Gm-Message-State: AFq9FYK5dxIFlKSRedlKQbqkussb+K0akDxlBT7KkE5SRa9pg9mgnT64
	SsIWC6eSXFSoOPaobY5U2m3KWhSUpGCs3TcTy97LjERVe5R/1m/uZoSr
X-Gm-Gg: AYBFou2Djnb279ZNqvFkeAjcLg5yoM7nkNb9hdwbLYwo7xRiqNP/RTSL6AZYQb1xhzw
	/KlwYL9b2dZonLvyTkqNNIhKFDfZbVaYdL2jcEHmJyL8TfaWscloylphkQalMEDdRN47oCRTS/1
	PA0ufY7WXNyS7lPRTBjd1I7Tm5yL9xodNjNULujhpV2L90sM/F4s+JNLwFeSq43LCo6qfp8dRdH
	MqJYRi+UTL1QxZ+VYhWmIolu34m8yWNXvYNwsY7g8p68o8ss6xasKaBbrqKPF0Jm3oIso4zhtK/
	IupBjKRIaDtWdrZ0WcMTr7Yg8skcZx+qZXf7XeWsBmlWnBooY/7BXJf0fNgwOl3X1szehTUWa82
	uhAfwf3pSFPWuP1rOOTew8I+UhoWsYLigiCwRQLs+j8xB3l1a6H9bFcP9Zc+raeHGvGWphokkJM
	S8TI8jwknbf6jQwaQR2DJPR91hvgAXDwkOdPVdbvbkMsS862bkx0FwXSRGMTm1S5JHXTDm2XiXJ
	nYqLarlf1MB4FfLfxuJtcqRBcLqQbE2NhaBjkvcVTeBJts4ELRSltTh18ZKoDDPC+mwv9fX3aGP
	TFAin8WHusSdpnoqJwasW/Cq9elRN6DiGVHPcFVrHbPpU6Obb+/sJuLuyrbygKsaQxt4bYYlPWj
	REv9h8g/ZScIyHFDWbknYzhwv+aZdersUVim/i8bdw5Rq+lrBXju9CBMbP/KdNvPqVu4OU/qnti
	+cWic=
X-Received: by 2002:a05:6820:1621:b0:70b:8379:c170 with SMTP id 006d021491bc7-70b889b7a5emr1671116eaf.27.1792772857121;
        Fri, 23 Oct 2026 09:27:37 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-70b9aed3144sm372801eaf.12.2026.10.23.09.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 09:27:36 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 23 Oct 2026 10:27:25 -0600
Subject: [PATCH v3 4/4] dmaengine: dw: synchronize completion callbacks
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
Message-Id: <20261023-submit-dw-dma-synchronize-v1-v3-4-c62bf048f5ce@gmail.com>
References: <20261023-submit-dw-dma-synchronize-v1-v3-0-c62bf048f5ce@gmail.com>
In-Reply-To: <20261023-submit-dw-dma-synchronize-v1-v3-0-c62bf048f5ce@gmail.com>
To: Viresh Kumar <vireshk@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Maciej Sosnowski <maciej.sosnowski@intel.com>, 
 Dan Williams <djbw@kernel.org>, 
 Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Cc: Serge Semin <fancer.lancer@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2

The controller tasklet can detach completed descriptors and invoke their
callbacks outside the channel lock. Terminating the channel does not wait
for those callbacks, and there is no device_synchronize hook. A client can
therefore reuse callback state or release its buffers after
dmaengine_synchronize() while an old callback still uses them.

Disable and re-enable the controller tasklet from device_synchronize,
outside the channel lock. Disabling waits for an executing tasklet,
including descriptors it already removed from the channel lists. After
termination, a later tasklet run cannot acquire another descriptor from
the terminated channel. Clients must continue to exclude new submissions
on that channel until synchronization finishes.

The tasklet is shared, so other channels may schedule it while this wait
is in progress. Preserve those pending runs: tasklet_kill() temporarily
owns the scheduling bit and can consume a concurrent scheduling request,
leaving controller interrupts masked. The disable/enable pair leaves the
scheduling bit and pending tasklet queue intact. Other channels' hardware
transfers continue, though their callbacks may be briefly deferred.

Fixes: b36f09c3c441 ("dmaengine: Add transfer termination synchronization support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/sashiko-outbox-180707@kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw/core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 6d27af3c0f2d..d80be93f0c49 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -910,6 +910,19 @@ static int dwc_terminate_all(struct dma_chan *chan)
 	return 0;
 }
 
+static void dwc_synchronize(struct dma_chan *chan)
+{
+	struct dw_dma *dw = to_dw_dma(chan->device);
+
+	/*
+	 * Termination removes the channel's descriptors from the lists, but a
+	 * running tasklet may still own a completed descriptor and its callback.
+	 * Wait for that run without losing schedules from the other channels.
+	 */
+	tasklet_disable(&dw->tasklet);
+	tasklet_enable(&dw->tasklet);
+}
+
 static struct dw_desc *dwc_find_desc(struct dw_dma_chan *dwc, dma_cookie_t c)
 {
 	struct dw_desc *desc;
@@ -1318,6 +1331,7 @@ int do_dma_probe(struct dw_dma_chip *chip)
 	dw->dma.device_pause = dwc_pause;
 	dw->dma.device_resume = dwc_resume;
 	dw->dma.device_terminate_all = dwc_terminate_all;
+	dw->dma.device_synchronize = dwc_synchronize;
 
 	dw->dma.device_tx_status = dwc_tx_status;
 	dw->dma.device_issue_pending = dwc_issue_pending;

-- 
2.53.0

