Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792695175;
	b=yJaw/k2a17DDHCvuayOQZ6ewKS7veFnlDXztO6myDP3ws0hqWv9ruq/MP90+NKbYLpfz
	 5mOVpGSGYTYipeZ5OhEoLa0wCaYs4z/mXNQpOcTWJQy2tUu8rVsZ+WNqV7arVxGjwyJPQ
	 U3g4rwJ8pdBpkiAPvJHbfI4qxu6Q6zs1gX14BWOWlcK7oq48Y4bE5mUIA8uIopOg+QLDa
	 o9oNaUnxb+HeQntn1x1COfTuc2PX6ckHmMQbhIQkZd+vUTwznCuTYcTasxSwoLWJSVf7G
	 ofCt3wCkyyTJuIXzsIkuEpxkaYk6BBUQ1k4bRpHuUL2MOyUd/hGL00avECyGXhG0R8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792695175;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=iUu/R+fBQNIMW0hUqQNheGWUYLG4zuBOi30rdtyLED0=;
	b=32dKZi+HjRv6h19YCI1w88v3mV28SAQAhYJK1HIHEl/g9dVq4tue5NARPl8o9KDsXK9W
	 c6WI5FUJWtunypP+Rpw/wVHMQVnZ7L523whBhRxgpQR4mUofGL5ppJt3Xuv66fF3N22bA
	 X1/T7+VroL9d50njQ4/GMfZAAww3tInrW7bmkosQaLGfjaScPm4Uj8sjQ5064EELCoP/x
	 StrqpzF4m5BCu+RbbGJq6UadzUBWdTdCwxTlOnYTAKhCCDTB5KgI1XXQdhWfHNJoMMJvT
	 Cn3S6wWgzVPdLTXrDCmaTWnNj4mvG9O0y4sOU6Y9CRecttT3siSXCztvcXrnVLPA87A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=P9v8HJvl;
	arc=none smtp.remote-ip=209.85.161.42
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4859360A2620
	for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 18:52:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4859360A2620
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=P9v8HJvl
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-70059e4dab6so78398eaf.3
        for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 11:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792695174; x=1793299974; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iUu/R+fBQNIMW0hUqQNheGWUYLG4zuBOi30rdtyLED0=;
        b=P9v8HJvlMMQn/I0jrZo9LW4QekCfzsbPcKDzCG5Gzku+A4Z0mQP+5wl2UdUnmSaSEz
         oK0TZgnRqOE8h3/SQL1R8vbvgzqU9bmZ+lOJZyK+r33IJIhVFSgH7qCeXIAeHRcDCUy0
         rgqVYwjMOPf3bx2XCmkFsvAPjdeGhsRk904q/4wv2Wcjle5tBOda1jvYlimhAf6kwY6h
         amrrKPs5g3BsZiFR0qA7NcQ0ERBn2L0gLhHk3TTTR1XdJVhA9kRprO7gmGbsnSAEkYc8
         8wzHiU0Ura/HV1Ipn4TO27c0qvzjUSb4v4PLPmtoKHftkogeL718sDeBg7PxYHDIwvyg
         baww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792695174; x=1793299974;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iUu/R+fBQNIMW0hUqQNheGWUYLG4zuBOi30rdtyLED0=;
        b=wFUTviGmPV4n+S5MT7jUyfm3AIhV9Cjb9Ny6OjnlqUg5C1UhcoLREBcs2WT7Pt34Br
         w+T1PcehBf0P5w1USPPKPUsCDQ5aPsO8nPYvMIePF0UypDQWrb6UZbTKZyyc3QoZzU4q
         8HE4G31oyx/V89iHGYpSPP0xl8iJJnckJ7XbLZ5DZSHLpQM7k0tCmkB+xXZK79kRh1d0
         QTjkG5lfX2s2g/cdUMSiB/EhW41rMN7APHdsyDVgmokO0k03E6L1SC1bKJtpHcUqmNbC
         gYXA7J6e9cidIPpiY29E2iSvGX3yAooJI4LP8KRkAer8g9QA2+Nmmo0qwOW7i2qhAlO/
         J7Kw==
X-Forwarded-Encrypted: i=1; AKwUvBxTLsGrKDL8BxKKQEEdTOOQ2fwIFbHqJfhnIBlzC8NXAtCHgUcCmRUDDzFKdibfXfG4CGtn/KpA0de4SEg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLwMdp6VDzMjoioV3oYbGZ+zHkTJSBi7z3G3/sNZPTJkTVAew1i
	igNc4JCyLfFmP9nNl8Lop0hSPaygHjxGofFRcnCr/IgBft4/On3Tvx+D
X-Gm-Gg: AYBFou1RLu9LG/SU0U03RadeYwJKcIQymphcKL8KJkRQvsCLCqbC4XfnTtu+wLVblw5
	kBTBtM03bt88crkMuFK/YZT2BDQ3uY4/t0BG1Ca5veOHPfmjg3tC/qdjJCKPuItRQd4+K4ACfHd
	qwZmOZTJ3o8wC8Prt5W54Ydsbmx3LcKwy1AcsG7IIxXPwNwwPO8DPHQjBLh240AzndD+yNQKaaN
	Uox2/sjNSgTTBMLq3s/0KU+VNBDNEU7hu8+NPkpQeg9NW2s5jlv6anIsL1FZT1UdkZdAKBCz5i3
	guamOvc/PoQXvH7+w0Wu8Ro9PfOzKCT5siSN7l3RJYRAD5qqXrhGULNf9dwtoSWWn5nHt2fa+MR
	iKVYQ91uycpeCit+sf6HGANZsMfYgGUDZXSYa1HORsRc3L5BmAnJsadYNygBfGcQjk1LnuvAG6H
	kPuKqpejS/QT2Dpd9g3Jyk1He/gMnCaMRNQv4dZA5qQFIUfTXDMwWuHP8vS2PuTD5m5oullpRy0
	/zX3V3qYCArn/aokx1DcbHtFQ7wcwtp96vYBqxLBQSNHgJCccyn5a92yp6TyaWnRR4wJTnmSWI7
	W08hXWWksuiaV9O7xuH7uXGNGhScP7GyyIqMyuA+Yjnw6k98Cht1iG6bKzegkrIhYHTVFCQJfcW
	1FnFy78UM1GIbj99D5PBufJyaFoPwc+flVKIHOWFmN83ELpl4uvvgEXI8WZDKEv2pVAvBBE7BPG
	RqDfE=
X-Received: by 2002:a05:6820:5601:b0:704:4ad:9c5e with SMTP id 006d021491bc7-70b88a1cf2dmr160306eaf.26.1792695174166;
        Thu, 22 Oct 2026 11:52:54 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-84f7703d288sm536083a34.4.2026.10.22.11.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 11:52:53 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 22 Oct 2026 12:52:51 -0600
Subject: [PATCH v2 4/4] dmaengine: dw: synchronize completion callbacks
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
Message-Id: <20261022-submit-dw-dma-synchronize-v1-v2-4-5244e94dca8c@gmail.com>
References: <20261022-submit-dw-dma-synchronize-v1-v2-0-5244e94dca8c@gmail.com>
In-Reply-To: <20261022-submit-dw-dma-synchronize-v1-v2-0-5244e94dca8c@gmail.com>
To: Viresh Kumar <vireshk@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2

The controller tasklet can remove a descriptor from active_list and
invoke its callback outside the channel lock. Terminating the channel
does not wait for that callback, and there is no device_synchronize
hook. A client can therefore reuse callback state or release its buffers
after dmaengine_synchronize() while an old callback still uses them.

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

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/sashiko-outbox-180707@kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw/core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 1df028970c4a..9e5e526f7672 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -942,6 +942,19 @@ static int dwc_terminate_all(struct dma_chan *chan)
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
@@ -1333,6 +1346,7 @@ int do_dma_probe(struct dw_dma_chip *chip)
 	dw->dma.device_pause = dwc_pause;
 	dw->dma.device_resume = dwc_resume;
 	dw->dma.device_terminate_all = dwc_terminate_all;
+	dw->dma.device_synchronize = dwc_synchronize;
 
 	dw->dma.device_tx_status = dwc_tx_status;
 	dw->dma.device_issue_pending = dwc_issue_pending;

-- 
2.53.0

