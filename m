Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794727193;
	b=v9xL/YT8+xJbDmjSa2VjMmTEJVpQILc8eqqc+Ffj9dd1yIfPweL5THQLiY9N+bO0ii28
	 PDO3sVBT/nZIvKhKrzuaYrFW6LWNfsuhFUyeZYehvGZF4MICFgj53CiWycyhwfPAQneBh
	 JODzRpYAwfNMldJynv+RP+Q04au46PRssojhD7X2OGAgE2483WP/jE1DkUg6W2cPLOjDZ
	 QE4k1cD8AI/TsaXPp+aCdMqujoLiVR4ZzJiLKshPRBEndzEdQ3Pjpv3kl8fhyfV9fvlX6
	 4rtUAlAKRuC84nJVFbbPMgBwulyk02kYxWtcji+MYqLPaR/6wXSmNzkOcHHpGeNxFUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794727193;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=7xV7K67o452vhJBNNJkVqcceAfykbkpk6Y6a+s1Bbb0=;
	b=0BTGTllwMVe9SaJmj5PofantgLyQ/m4rjI03+lzHco5jssUXfo899CLYzkfLp/QlK2qW
	 z37FAjU4xYSe3Ui1Rf9pgsltRLnHN3XsT+Mt+RYdtBSgeRwbYeQKHEXEeSUDtJsWEAF42
	 i5W5DkBGTCvauEJUSm0w1oCOZGkXDm9p++/KYpAxNtQhMamhhzS5/9wsHfiW2PTEz08sS
	 /IOvzLCUlwCcWGx9CVr/lkhRcKXu2tpPA5shdh5N5SLYhA9mwty8+FQoNkBcwGyA+SxPL
	 J8eClYxyiz1DwePON7eaBbbvQcYeFbNkFvSa+CXlBUS3r0zEhiE291N0mYjLneO13qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w2YgrPrk;
	arc=none smtp.remote-ip=209.85.161.43
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD5660A380A
	for <linux-serial@vger.kernel.org>; Sun, 15 Nov 2026 07:19:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FD5660A380A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w2YgrPrk
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-71aed54d4c5so64469eaf.0
        for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 23:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794727191; x=1795331991; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7xV7K67o452vhJBNNJkVqcceAfykbkpk6Y6a+s1Bbb0=;
        b=w2YgrPrkqUsnRysCkNMt3GErNmxcugHUhCjZJugSCecv+b145Mg0blwX9XY84sOBNZ
         kHi4poF3jcKjW+SLuPUNnpRvHfw7fg9sdry5lgGZu/27hvwM5i1rl7t98kY/dGs2VooG
         RJytCHNMMaKDvgiStjN+6n5nho0U2El1KaOixb/8s53a06CXKSh5AAQc/QnCkhemfnTh
         Cd8T6pbZa7kuLIpYgJo92wipYNH+qyfEaj9nPqmpsjz2dmYKeedxVWEOqafLBLfCkMbd
         EopS2FBcglZdJ4oAxwhXjrriBhDUnO0GHVm6yy6AkPHAYGInCeZcH3p4fEoBjUe1GtSA
         bNpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794727191; x=1795331991;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7xV7K67o452vhJBNNJkVqcceAfykbkpk6Y6a+s1Bbb0=;
        b=gnl/seIecbwVb+F9Bd2O4+UrzTPoJL1Dcvj3YmXGKKx/mWkmO/e3Zu4WPK1b5S4Q+2
         ICasNW4FIYfT/wZeEna4DmaFtHU1e3FSBZM8gSq0iz5Lm7QbbpdtrCnCLRAYuYPfAYRl
         KGtqY5xoKVzNa2wsj6dfK309kCpOMHI7hxefkwUmuXjMDE9Uov/3R9KoRV0E5g/gmFMX
         n1hme5083UayXzaM1jCbSnedkdVRYQkqiLM/PKFBt0tx6YFM92QD3JGrRvlizcuWd3aD
         yHMiyDU86a80uHC+HqcMIXkB9akkma5ZGnvw6L9t2ldCn+AvWUBX5vH2RjQcBeeC+F9H
         pzNw==
X-Forwarded-Encrypted: i=1; AL+hErGuL92aOPmLuIzD4hAKkrGOK8IHk2eCSDPpUnxiS8RYU9i0wk4HnqbnLmm5cJoJWGvx1/dDoPY4A+EqVKc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+miMt+iHo60IhKG2KpOhwAG5zRUrs7407wb9V4dahzy8o/7uV9
	aLlSqLZWtRh7lCFkxAnVC5n57JDlUQf7UpEIIK5Xvtwlmj7+yfvfKkhb13hO4A==
X-Gm-Gg: AYBFou3INjNSAsWDMjb0hilppfPX7wPoAYyI2G2Pucl4exRWwKZBukR8FOq6ibiUQzD
	nqhPhEbIffZlGWlM1fzqIN+KLeBkjrPb1ooMhfhO7/dSagusesJ0o4TsIpc0rL3mQEGxdJAgSye
	gjlPOvwBnwVzfJ3sS5PiJetYPZSj0j3PkLyjyhWv2ERzK299pKdlWKlvoDPV1Tps6HeDll7ZW59
	qxm55cLkZPzYehio5P4aYLTec40t4JRdwIWUDFuF4jCj/71iULBu52yGiqGjMketWR6NBlpgRRD
	z4axdZqVQ2P/NrnoFt7Ae0Xvckfk7kpjewMteZZFAGp3v4XbKcXkbmtO8Aeazwp6m13m9U1gh9j
	bJBZ2vnPzmmJa7lHMNt2vvq7CE5EAMlDX+9BJAjrYYWqcHBozB/MWJUCODSBfMpDddPV8j7XWpF
	du2rpTDM3grHjJ2uUJQokeOMyYmLtqAH1ms2Q4ZQ6rWJBUGNmr/6sXst6SRA97OwaQZKCqgQZEo
	JB/Q5FMFEszV9GE88r+wKnPRcLS9TdEqL9I5VGzTzbXhfV2P5OfZb5sii8dKCSFj/40MQt33svV
	Ma1SNteeNcbgxBHpVx58E+gdhav0U3qlq67Io6qrHhso0mKlwvSPhDDgV2vh4DZN/y3orbdjoy1
	fOIAM3VcxLRyudBSVuBtvfW3Lcy1CRBB72fDmRuOhz/GAvV2Wbwuf2Bp+6x2i2OnV66sGXvAF9F
	Gsk19MTdv6wHbyuhhWriW8HTZsN+0ttmSipiZaE6c5vWIi11F7D2g=
X-Received: by 2002:a05:6820:3385:20b0:716:bfdc:a084 with SMTP id 006d021491bc7-71ab50d4472mr2939790eaf.60.1794727191190;
        Sat, 14 Nov 2026 23:19:51 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71ae860ebd7sm1145321eaf.8.2026.11.14.23.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 23:19:50 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 15 Nov 2026 00:19:41 -0700
Subject: [PATCH v7 08/10] dmaengine: dw: drain the tasklet before releasing
 channel resources
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
Message-Id: <20261115-submit-dw-dma-synchronize-v1-v7-8-8d58f3d49e4d@gmail.com>
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

The controller tasklet invokes callbacks after dropping the channel lock.
Releasing a channel can therefore clear its configuration and disable the
controller while that tasklet run is still using them.

Disable the tasklet before clearing channel resources and re-enable it
after updating the controller's in-use mask. This waits for an executing
run while preserving pending schedules for the other channels. Have a
pending run return before accessing registers when the last channel has
already been released.

Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA controller")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index c602ea01cb83..56a422ba14c1 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -419,6 +419,10 @@ static void dw_dma_tasklet(struct tasklet_struct *t)
 	u32 status_err;
 	unsigned int i;
 
+	/* Channel release may have drained a polled completion before this run. */
+	if (!dw->in_use)
+		return;
+
 	status_xfer = dma_readl(dw, RAW.XFER);
 	status_err = dma_readl(dw, RAW.ERROR);
 
@@ -1062,6 +1066,8 @@ static void dwc_free_chan_resources(struct dma_chan *chan)
 	struct dw_dma		*dw = to_dw_dma(chan->device);
 	unsigned long		flags;
 
+	tasklet_disable(&dw->tasklet);
+
 	dev_dbg(dmaengine_chan_dev(chan), "%s: descs allocated=%u\n", __func__,
 			dwc->descs_allocated);
 
@@ -1087,6 +1093,8 @@ static void dwc_free_chan_resources(struct dma_chan *chan)
 	if (!dw->in_use)
 		do_dw_dma_off(dw);
 
+	tasklet_enable(&dw->tasklet);
+
 	dev_vdbg(dmaengine_chan_dev(chan), "%s: done\n", __func__);
 }
 

-- 
2.53.0

