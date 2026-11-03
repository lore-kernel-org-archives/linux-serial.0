Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744787;
	b=MLEPRBBQGc6G9xzK6HIm/58unye4CHuUt6A65SwGClCjknwLEMUgKmqpJYGNsuJzoZlW
	 WQax4EgWVOrMm/LP90hf+fB+mYXqthruta7hnIxkMAzqwA6ZeTJcdRHSLJUbdU2zmQhs9
	 4UOFhE4dw3AEnwSZKn7g4J7g2wmsCWFHvAlfcWLlQRGeJ0TYPwEei+j4wMFRwYGXj/a2D
	 bIB0UZZPkPWnASBK2x7hS7go6MZaSKgUDUrviBCZ7mATIwI40CBeDwxw1yLXWO1PZNQ+D
	 MNTVbBBP285TgyO8BNeifMEjm9uBY2gC6qmQzLyb3UpaSnz5Z2x936LHLAv1PeTAdsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744787;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=5OFiyLgPB9gonzWakO9Dintvadbo1GwHe3HBflThFw0=;
	b=mcgsbm0G2EhqGiWdcOhn3uHHGydvjjOP1aXWfVr+10Z8tJVblPzimUw00kRP8nFD1rGN
	 NX7BHfeCgKFBGY9QvGGh419YmTwCCzR8/VBhWraUOnWx9U1nk5REhP+uemuMYIVtUXJuR
	 S/CNIy7NYoStQI+sCw1zITxx2EyLk3lqLWmtT17m9du4Mr2YKdnBBD9RSCWoQaxXK1+hr
	 n8v6PUTxvsE1F5LGh2VWUjGUrVKi3NIb2C01jSgNtFhckA1Ay4ZDhwZlwe+Q0Awxnk77t
	 woVRrpmSDsIVkWc5m89WOUxi5OLOaSHswxAa7lobMPuYwJ9EEqmGbLaWahZ+LZysWOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oDSEy2y4;
	arc=none smtp.remote-ip=209.85.167.175
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E02D606A32E
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 22:26:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E02D606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oDSEy2y4
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4f48d91ba7dso48346b6e.2
        for <linux-serial@vger.kernel.org>; Tue, 03 Nov 2026 14:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793744786; x=1794349586; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5OFiyLgPB9gonzWakO9Dintvadbo1GwHe3HBflThFw0=;
        b=oDSEy2y4mEoyput0d7HZH2+P/CQt1HWNoVOHRzV7uXjZRzBiBfrK280iUJNwnrPmCY
         adEdVT9w+OEfyqm1bRn66R9kzEta31zqSn7dNPQH6jFVbLWMMxif2s+pPcJS4lO7dy2A
         kftW40Lq0X8YxXi0eNL59JdGlQ2J2i/+OxPv3CG4kIzjhFEmGCAtE4bTDFm/9O+pcrt2
         I/jQyvzgpQBv+wW3bdk3UJi4RbfNKjpRSUt3ZeNM2EkDjiFyxPow152UY7BqlI1YMPao
         XYhHgryLEJuiNUgeVoHJOJ4Z9tEhfByrBlWvEoJeO/tMafA+u9ig6YxN4MwPEpdsS7IZ
         hi1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793744786; x=1794349586;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5OFiyLgPB9gonzWakO9Dintvadbo1GwHe3HBflThFw0=;
        b=DYAHQmyKMHEUBB5fHwyys9KdUSs4QF9t7+Nd0JAByCLgtQ3hc4raV0CE/gAwspoXFk
         M7Ty/yOiuMLuAKoLpHTvBKUX4hD4jF9aUeUKiH+heFBj3w7uKfD1JidAtU+Y4RUSdJbm
         tDSkNsYwbCgshdwN74Zh1O4KF1XEYd0HEciY3WHV5Ze7Dce2JczD2XCOMAh1Dc/16jLH
         Jt6ixJ9SRiSPoYTD5lWJtQn4aVswk45jBtnhvDqv8BBRrsOCLhxsgwJObXu0r/5B1TMX
         dgjn+V+6k8Wv4oU6/7/g0ZMCSMUAFBYCVFWjxCwQqEf/kMeg+A8XDEduqMOLZpeJLYY+
         udfA==
X-Forwarded-Encrypted: i=1; AKwUvBz3QqNR4sq6JRY9EfTxoQDygGoFMnltOcLGaaHugLm3nUg43Mi7ImeUUjZ/Pg2mYGnzk6kxvLnLFi09g+E=@vger.kernel.org
X-Gm-Message-State: APuU4Z9rmRcRIyPU6sZBRrB01Lbdk5uElHXssd/Parjc5F1V+Ir97mxH
	4ONWhr2f8TPYetcaazGIm3aCuIQwjduuUOpQqtH8+YRRJiiYJv14Viwi
X-Gm-Gg: AYBFou3OVZmpjGvL91cmJOpw5CsARyijCWlpqhBXI/rMYug2M2uhBjwxRFgmu6JUaZC
	EnqzijtbToA0H1bEcJFj/khmdjeB82FxRLUOhbOQxB4Nx+ohBcP09rQ7XpzHe+JH1aI4ulbM+G8
	f1eIlc62yxomMNza0ohnvL+LSu1bEKEzpAfpiZBK1OKVE5XSnHn4uj9tcP7jtL+yqmISghYZPNd
	8erNKoX4lDAiY0V9UWwnIETjd60pTv4UQGb+5hG5tkhuTY2D2MTc1/DnPc1dn93lc1xLtLyQzre
	yJC4/xx+8WjE56KKbtzTI0ZRn1hpOK3UI4kdnfP/Jf4AFPTWjxv6BUpTGhldnnHxiPtF4wmXcRG
	V543KdPibK2Sgdpp9tNTVJFwisaraX34TA0n1uBy3hKTiUEzSFlMZMokSmD5C2ss7LxvhTiGM/O
	bOL+sZS6VAJFq2CoHi5bfPIBeU1mj957PG1EgcjQWneAtOU49NnIoAGiCCqHIRJC2rGguTIO3aX
	oi3VW6hnc2tfH+GwIyXkMaNqNPNou3gGXhs6PsweGOCgRNA5WvcIMbG9yV6Jdo0y/bc7ybRIH3p
	zbG8KQ24ezFHOn2oPufHqGlhv+mJm6LiimWMvrGRygyY0YrjgvoTJ0StrHewE+iOPc/NhWFgBwp
	nJtZbA08I8tz019gR2iiwa+1U3wfmdvIZbhjSBE7ZVxXoNQu3quDg7ckuZl+I2SF8+OcSBmkzJo
	wiAL6pPp2E3Iattpao5LbcuuFimdFyCLEkCEx8cb6EOdGKgewrUIA=
X-Received: by 2002:a05:6808:10cf:b0:4f8:4a95:9b3b with SMTP id 5614622812f47-5640df9396cmr10547961b6e.68.1793744786246;
        Tue, 03 Nov 2026 14:26:26 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9ef58b1sm128435b6e.3.2026.11.03.14.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:26:25 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 03 Nov 2026 15:26:11 -0700
Subject: [PATCH v6 09/10] dmaengine: dw: synchronize completion callbacks
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
Message-Id: <20261103-submit-dw-dma-synchronize-v1-v6-9-2ee0c348224d@gmail.com>
References: <20261103-submit-dw-dma-synchronize-v1-v6-0-2ee0c348224d@gmail.com>
In-Reply-To: <20261103-submit-dw-dma-synchronize-v1-v6-0-2ee0c348224d@gmail.com>
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

