Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793312996;
	b=zuDkyeQFRr9OawEDuvlyXWn0XkdZ7C2rqhOX9M0XZpIMX9EYc0xvHOaNB1VSpjCOwgfz
	 uJGbiqOR3rq23DZMGkCl3Y0Uwgj+yQTq7NHfYhm8PTedQAToAuwoF+KxbcICiXlubaA6t
	 uBHE6Vrg3JgA4zsdyaTDi2iMA560GQeyxQvFMTtzUdKc4o7jqOyGDclYziNtpUeIrT0Q2
	 HPjckTmZcoNDoDLFArjgmztJ9IVEyihjfu5QK48ar82swn9rz+OP0HsNtwakr4DV4oH6c
	 EhUfIpnVL5so/9yEso9Lmy3+VRj3ZaGo+cF27icDicZit3R6KHg2qkvgzvf+JeAjv9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793312996;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=wkIhisdDZBkDpi2Ngf0GdoFEgXXogA5sytIiQ5NQ4z8=;
	b=FcSTaDLvcCQck4jl7puc3vkjtdE/xMNmVmrMtKE6STGLeOM28RjrF7Px7VVtTqqp8PNz
	 zJ5F5p146iXyqgEKiO3B3+81dpAXG3FirBpwmzo9fezvyDhuMB3xEUT0VfIcVHjbumiN/
	 Jyg5Fmael7VcHBR90QhSyWB7h5OBZXlLGNd0cP5Pc7yNvKzfU+UYEPf5fJip4LFh6kv7k
	 cxze1qM8NMVefW9tCNIDiMiKd/XR4PH7iBSZNJYqkeFk8e/zUp/q0Wr0+JJL76p0dv0lT
	 bgYyF+JT+9OPiNb3AcybQ3xJklxEVVIEQKR4SjMRG7m3iTx6ZC11BKNLcyX+y47uq3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RNR9Efno;
	arc=none smtp.remote-ip=209.85.167.172
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE28A60A2619
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 22:29:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE28A60A2619
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RNR9Efno
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4b21f71613fso74545b6e.2
        for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 15:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793312995; x=1793917795; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wkIhisdDZBkDpi2Ngf0GdoFEgXXogA5sytIiQ5NQ4z8=;
        b=RNR9Efnolrr+Tv9pm9QqjboB94rb3QbKuu+iJXO4ui75czgSEYX97arGLUAsN9mwo2
         B50CHn1wvxCqxQCsXAFdR+7ydwiXXqH0SYNxsKZp6tGp+lzWZBCuGO7d6NaT6SWqAah/
         4oh5JKgWkM6Mn4xhGHrO/636qy3uWRezfa2BPyUK2oVVonW2O/EQe5p0bOJ0CI9J0n9B
         uKvmM+L6elc+Qm+WjsLg58z2wgo/+S2tZiMvIJAPe+Dgz8dWV8WyL/smx5HUOKvydH3w
         lowo1cfPCa8eR5h8J4jeIoEziEYkFV7djX03DDN1ASjBCGAAarILZr7aTW+aQ25QklH9
         dMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793312995; x=1793917795;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wkIhisdDZBkDpi2Ngf0GdoFEgXXogA5sytIiQ5NQ4z8=;
        b=Aek4WIErULYiL555dV4ys93kLdq4SmYDShBFP9bTUlUY6dpY2uaeVGNKEk5nlemSjN
         uIuNuS4+sHAjS3ndGxQxiJgPkCFPsYYTVBEWnxLa3Gk49XqIGzSU0dW78AI2fff6vxXc
         S9LROtJjNON0B0MBLeH7eGhcLMMhWwPvJ09SePtXsPS54z071njPmU6Z+xJlLmv7AKMQ
         KbJhJoC7cm27pzU67ejTTG9/HLpcbM2fept/WaiTW8bXVRXjeRvVKh3tyL8CVI0vtLbj
         t8jnMQSNiufnn48jVHrNpcUi1zbSa0/6PA/PEYDbGDN2OpACSjrp+uaRQn3JvQBwVkBG
         0vHw==
X-Forwarded-Encrypted: i=1; AKwUvBz5nSuYHEeBzXKPI38H2HYrYhp8NvebF85d5xckgos+izHOyZ+iTJqqqdXjdPR+PMzTLysBGt9hsYBvnow=@vger.kernel.org
X-Gm-Message-State: AFq9FYJzyVWEY/QXNH7BmRPCppF8K7OZ9bjOeO6gIpPOMCHwf3QsoMzZ
	PeW3WmExLGeW1jkBimJldU2ZmyXMXLgb9zY5Oq0EyKKEV2X/xjcgNjyE
X-Gm-Gg: AYBFou38JVzGhfORwzDo7QSZcO62UXVQh7xX6OzJqM6//Og6udSgDe3PcxvgJIgfBoW
	ymYhgRt+qrs5p/lybd2985CntsmQjjySmB0lkzZXaaNFhdv8Hm26Hka0VIjX0gu8AdxyUWlpa1e
	qzdB9mIs2R0eeqzEym1hoVKGgZWVZL+6eT4Ll1M/lzpSWrH9aaozgLYyOt/OtEX3IuphB1rQq7o
	5ekMWPBh831uQMBayu9pbj4KZ5275BpSn5tzKnZXqUhJ4N1Wm5SfB1beYeNw77OSulFZfBhNFpi
	5wWSyMwGDGBGQWiNpsFm5eByuDoTdcg0W4J2I/n4+SIUTHaUgDWXv4JT6tuQTQmLWRjpXmK+ydw
	RhL+vNmh6Lb/um8JvNb+1I0/5tlzRrQJgu4D5rbwS222F5O+GNIa+D6XvyXtgsmpxctR9XHw01S
	lLgbtj3cfWmkrEo2M6VE42JAD1Zz+WG6XlrNTrmacJwVyVpea4DnRDlxpbe67fFXH98RnucwHqm
	SoJBQ5SOD/G52zC6YiscFGVdW1h5nkoiNv1LmO0BfN6FH2Krylh5dGlMxhBbdxUClmk7I5zLdzk
	nNEgb9ho6Q/gCjCaUCKzObeOeQkrMiQd4DbzxjMauP3p49fVXiNm8z5JBeIuo7ChE16eqGzmDKs
	1ffkLpAthMQk04ELRD3JxQdXf6pm/03MsP53JAKolcMFmyD80tg5RKFkh7FYaVWNSDj+VZH+Pgm
	kG2sStdudi4A16M+WrQ/cmUHBxIMJXLTY7dLH5FrSsxS0EVPLbZE1J
X-Received: by 2002:a05:6808:1383:b0:4e7:3fd7:2752 with SMTP id 5614622812f47-5640e02af93mr409218b6e.54.1793312994747;
        Thu, 29 Oct 2026 15:29:54 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fc49880sm236130b6e.2.2026.10.29.15.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 15:29:54 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 29 Oct 2026 16:29:40 -0600
Subject: [PATCH v4 6/7] dmaengine: dw: synchronize completion callbacks
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
Message-Id: <20261029-submit-dw-dma-synchronize-v1-v4-6-fea447d9f285@gmail.com>
References: <20261029-submit-dw-dma-synchronize-v1-v4-0-fea447d9f285@gmail.com>
In-Reply-To: <20261029-submit-dw-dma-synchronize-v1-v4-0-fea447d9f285@gmail.com>
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
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/dw/core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 3bda85adbeee..66065d7b26ae 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -902,6 +902,19 @@ static int dwc_terminate_all(struct dma_chan *chan)
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
@@ -1295,6 +1308,7 @@ int do_dma_probe(struct dw_dma_chip *chip)
 	dw->dma.device_pause = dwc_pause;
 	dw->dma.device_resume = dwc_resume;
 	dw->dma.device_terminate_all = dwc_terminate_all;
+	dw->dma.device_synchronize = dwc_synchronize;
 
 	dw->dma.device_tx_status = dwc_tx_status;
 	dw->dma.device_issue_pending = dwc_issue_pending;

-- 
2.53.0

