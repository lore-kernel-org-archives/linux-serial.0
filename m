Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794727194;
	b=MDUWagiuX3PVTfkuI39QG39yLIkTly9OgImH0AGAorriFPF/gskhMXHCG1djPjg1HqvY
	 xGNrjl3o9bwIJjRXLB31/K1gFA6CzbsrW8v7tOo6pBoLdti9ypIMBIXPa4/4vcAZQKkO8
	 n8p1c+ukwa9TCZqPtrYNprGPKCMzBe38niMHeMGGPIhl6jiQEmfFB3JKpmyvpFObcsz5r
	 w31NQnL2FOrkUlr1FbJNmBp6WhkcMQu7mk0TycBiTJuSn0bQR/Ib1fWJmmDGwTadbHKDf
	 WMW1uQPR7gVNmnPHYJAU0ayTd4tDCJDCYx/CjnGuJ9+5PW8TDQcfHewkCbxX8tnXuUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794727194;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=5OFiyLgPB9gonzWakO9Dintvadbo1GwHe3HBflThFw0=;
	b=LdwbSHBjr/bP6y8l728kbA6HVOKVitnYDLKJ1HVvqUpcrBa+ZzfTM3sy/AVa3fxAt6Xh
	 1hde5PH6g8HKuZ3J6OnilZQV3L6hibqW65Qgan8n6XV2g57c1quGYblcTObFAVbu+Zh7C
	 Mp96QShjGAcuPAC7UnIiRLRyf2dm475vsrXnq91Ry3Ag2CndPvssk4MjU0hrcQUZmSNOG
	 dhnjivrdjwshCl+X+UfBoAEKxUpzaeRAW8wv/mb8ylWJSFx+TK4Q6f1N9X3V+nt8OPUbk
	 6V5gnk+hxeNkhf/OYxlcW4+6Rb9WJ9l+Bs/hN5/joltSx6yowq1zFBAH/yoWBZATZEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ceYAJYjk;
	arc=none smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A176760A3827
	for <linux-serial@vger.kernel.org>; Sun, 15 Nov 2026 07:19:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A176760A3827
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ceYAJYjk
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-716c0217635so3515241eaf.0
        for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 23:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794727193; x=1795331993; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5OFiyLgPB9gonzWakO9Dintvadbo1GwHe3HBflThFw0=;
        b=ceYAJYjkTQE+MYaav3vU0DXG3mM4qLnM/7WEl09HG8qfVIon/Pa2fjcGYoxVkzUJB0
         YSzh3u6CxFDsSXjM5oKN6+Lklm6zB+AxWgEielSZgXCO8U//Dw2SGyjY1h3Tu6PEQTs3
         NISiOlin3w/1Lh/8R2+ZtNnFfnf5hJ05lVbo7mf6uFOaXWgI9+ERgrZIItse+iKRWVmM
         a4Z6Tn+Mn6GYLFkWxckyqM1nOB4O5Y50OJA/nKmV+b53K/vOtp3PW8BJq5ggyxNpI1Hj
         yeaa/ydlgHLcRNwIsFAJRIXgyG44HWwNOJSDDFgVpllx6dx3XujIkbjCa3pcBIc3hxO3
         o4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794727193; x=1795331993;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5OFiyLgPB9gonzWakO9Dintvadbo1GwHe3HBflThFw0=;
        b=Q3dgo78vjM0AAHJhBtdJx67qL/5Sfq9ltu4v+b7J0hsqG4j5SSJ1ALnE4Jhf+g9asF
         0RZD3fJst/m8BS/3Gq7vl2sGo4nCorUlcXzMMkAlIFN54lfZ2AM2Ah3894gyeXqdPJxz
         IMdye8afH0CLioR0zqSHroAs4bzncSF6/41VQyByumWurbp/AECTOWY9hVe2K1eWRp8d
         cHXIVsZbQ6wu2FvBFLWHuCtG6oSVoZRLkfqgoCgkXnDwou84VB5hUCaLksHP5TqEK3cB
         hzSRWWpBxZRrbbmXzEhp76pQD9CBIUZET+nkJn3gXpWRHNRH7m7qVRlWeq/qZCPIq73K
         c0Hg==
X-Forwarded-Encrypted: i=1; AL+hErEmU3RsdVjCh/DIH0VbpI+yAPxpvuQIvhZqRTgCcy1FKFwXoW24TyQADjwsTZvOj+XZjDrux3gTbl//Vyw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+TJU0pkgMntXrUhxqzBu+SXpFuJ4wPyBXqLqdvHQLyCNlep5PJ
	sGcm1PoMyVqjxdFeUu/0hwCW05Sa4bvlDtx9ibigRAiwe02OY0rpuo4p
X-Gm-Gg: AYBFou2xShyd68tnuxNvVWfpmN/4HZ7oEowyIiPMoH+29SKKPaoffvtLcMnbDA6Bxxy
	sAqhFP5OH6ZDGdnPjgOzRohKGV5CRhlAaIIMKXKEGJAhZ/Eypv4ZQLhg1pZSG41IwuozbTkdZoV
	tmCFMQKli3PeSENQBd0t73y2sf5drOqqg5ZDeNasqWuTrfgMXx80yRNXe9AXt4LKL0qV6+UFEiU
	AtjIijAMnv0GurknULdd5+Sh9vpvqcpD/yGR1iy9q6EuiVQumJUYBqjBCPd8i5B4jlzrskdlXLM
	30wKCuscPwq9431AIcI1lvU7aFF8s47qNAmUlA7KF457VZ/14cKzXdcHwT/mlTcEv0jtK1poKG7
	LvAVJiDAKmHuP4/jnI6veBfdLcCaDvQx3P2hlH3MZQSY+HZ4ebcCIv2SN/xu6lw/eSZ7FN4m3v6
	dn/18Aj+y2Kb/O82ZPe8Sld8Ebop24N4D5KuSaYOiv2KnR5SnW7Ut5Mvjg7xWbIRaKdiRL33boV
	lc8TVsMotbOYJk1JpR5OW/6pzJipISvHtdSM61YToX77jwGxBL3OOvUaRlRV2JNRK/YnigxT0+Z
	0HLW6hqivdxu4APi+Bd3/SaNlACEBHz7DLGnhiiZZGE7pIs5gbAmSWblSOX2R57W4u/JfLtubSL
	TGkjq9mdnECzjfYVVWiBg5julrl/XcMPtEX4AWp9RBAYn6oinkK2jnzaYfJGdzf5GlWN+qomk8x
	RzaPr6T04jBXlLIC9HsdTHjZMLqnOvFAi6ubjRWJrBL+6QZtHRN5I=
X-Received: by 2002:a05:6820:5604:20b0:713:da3b:9530 with SMTP id 006d021491bc7-71ab5277f0emr2419543eaf.44.1794727192611;
        Sat, 14 Nov 2026 23:19:52 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71ae860ebd7sm1145321eaf.8.2026.11.14.23.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 23:19:52 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 15 Nov 2026 00:19:42 -0700
Subject: [PATCH v7 09/10] dmaengine: dw: synchronize completion callbacks
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
Message-Id: <20261115-submit-dw-dma-synchronize-v1-v7-9-8d58f3d49e4d@gmail.com>
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
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
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
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw/core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 56a422ba14c1..6f863fae7455 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -923,6 +923,19 @@ static int dwc_terminate_all(struct dma_chan *chan)
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
@@ -1290,6 +1303,7 @@ int do_dma_probe(struct dw_dma_chip *chip)
 	dw->dma.device_pause = dwc_pause;
 	dw->dma.device_resume = dwc_resume;
 	dw->dma.device_terminate_all = dwc_terminate_all;
+	dw->dma.device_synchronize = dwc_synchronize;
 
 	dw->dma.device_tx_status = dwc_tx_status;
 	dw->dma.device_issue_pending = dwc_issue_pending;

-- 
2.53.0

