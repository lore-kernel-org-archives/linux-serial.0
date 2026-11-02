Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793648071;
	b=KUe3CnJbL6zMTauqdvnWw77655qyfzLmRcKoipboZDUROy7km8gIUrxTae4dg44yaUqc
	 C+6+U2Z71GSRXHVJ1yclICJJA6vb9y+WlDRm0+j0pYtRpT/wzA7JF9RFm4d4ymIS6zIyt
	 MviFzzKFDvP00vGcI5vqIlF6joorZZWytqxNI+46q7hIYaXzrpDWdXhVAQFN9t+x42MxY
	 hhrx8Btn3CmlENyThN5MYJdtuO2dH4Ee1IgmamV/CLmZiPOPcDqFTNMltV37i2lUAoQcF
	 plOuelh+ouAOvqzhSjbn8DUOz9T/BOo0TA8/UyJ1s6UMeZTcoXVmC0HhbiXxWs/Q6TQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648071;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=oUn0wNxtDa8bpouBdwU2UFn6Se8GBim30o0tIkBNdNI=;
	b=Kxph3mWGF6V1BH/ljV8anEsWcIo/d88iIpsictyR5XaRD0V37BoqttcN1ISUvz8SdfYB
	 C0O6bU+klYgp9NzoGXm5OTLC7HpfMN9MYW8MWA9GeM8K15QYaeEYeC+DLjmWeyLGJQaa/
	 CGkgsQG9J1Cvogo2xPK9CG0OoqMNQc1jT3U14/22msAhOw+Kb2H3xLWzRGYnLWkjEh13f
	 kJg/ASyOdo69hEBmUVIOLev5mbyIwh+GUBEVG7W3ItPdJ8w3WFwS/g+OI6JHQp/dBonCO
	 6uv68Z4E940sQ0LlvuYSBJz54owhoyrU+mXQMYoP7YjUvKFdDX76wODvUMwon1jOuiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hhM0ad6Q;
	arc=none smtp.remote-ip=209.85.167.182
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1576082BE2
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 19:34:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA1576082BE2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hhM0ad6Q
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-53ec9237600so1954119b6e.3
        for <linux-serial@vger.kernel.org>; Mon, 02 Nov 2026 11:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793648069; x=1794252869; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oUn0wNxtDa8bpouBdwU2UFn6Se8GBim30o0tIkBNdNI=;
        b=hhM0ad6QHyVqiEjyneE0zJvRxpNSObqwc3qxsOSrjU1K3PjqHOTkJE8dvYU9YcSNK1
         IxfVhKRrOX/pGJ7bnvR5Idy92TGHuqMJ0oGG5Lw3MYTIlzG0Cby65e1NytNHwrL8kbYg
         Harw+Jy6aA4WPDNsRmZqRODsgdCvqtfuoVAPXtNmMm1TnPOIb4AxPBEapIpotaR3m/wl
         gX9kAYscBUbUh9ez0s1LdrK1rajxcPWOxFL6fAk1FPzapf9UIZYtU22UvCZCE5k/Q9/l
         EZT0x67FMSUvG2akiUPyNUqMwCBz/Did+1cPHcD5B78z5w4481VQM8MKhgrj+z3FgJpV
         utXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793648069; x=1794252869;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oUn0wNxtDa8bpouBdwU2UFn6Se8GBim30o0tIkBNdNI=;
        b=ltVN02QyfBKmQeigZXQ+SN1bZP/nE+JR0IHbIPkcXZfqkaVhN8pUvGJInGSMAvaIC/
         HFGk7sSuLDVrKOXtNA3HdOrgUFKyl6wYyNPY8cUazpinQp+0xHfOr9Uqk17ypdZCoWlZ
         C3Cwhva81C849Hm9j7jL8r3MWWXFa11PWeMz5aoHO3zOAkFDiQ8Dl+wKN7l6ncPQn/eD
         ISrcRPQUUb2n8yQTSadBCNDd7O9t0c686QugWLPLRDDFe1RH5MOj1Hb1Hf7rNOkeUWcY
         yZVG90hd8K413J1OcnRlZ+BkiNrq8+R2JnUFr2AOkFHL3AihOnzyRhG7zcuAcjwYJApB
         vWEg==
X-Forwarded-Encrypted: i=1; AKwUvBwxRNSzxFUhgPAivgOzm5PueZoAXM9OUMdUiEg91V6ypVxXOxGMfGTH6mD3EXSFEXSdDhjC0nqyOHCYKAc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIfmNqMl5idYxIG8FEyOokSn+zgbPBYO0oqv6mLuL7M1RMqAH8P
	8x/ca21ceJMxC6KPCILn40H+g6yeeAe785373CpMGp6vN4znAwvW/w6m
X-Gm-Gg: AYBFou0df8WM7FR8wlRYSRoNSrhzLUfCAjp3zDMBWJ8lOIw15ILZVSd9OMm17dcp1wp
	eFUHWfugEQZLu2XZ8U3U2vS7cdZubLzjwNXaiOkKKPpbK5N0k/rRZVpcDjDfVvgb1fW29fFQl3s
	PI1Qdz3JDkC74mpQC24qxwDAeTsrNHKajafzw5K0eZ1C8N39fQ8NByhLTXFN7ViyGMfEZOUIcRz
	Ethhl/f0eEn3T3LWrreaz3xWhC7vSkl29619ZkEnyvmg9hPGq5nDWh3VFLy3u2MfsSAJGVI66f6
	T+oClKFXTuQkaglhBE4OaPYFZpivtMbxGc8IVyOWnrCSgukKIKHR28YQ1Jc6FCOsmeUeywoEDpK
	7kNiKAkHtWD5Sv+YaQIUOjUAsxKSD/Ow7sAuzqefdb8fFtJ0YM0aqJmzqbskk8schhZ8WSS8zi9
	9I5aYzaRYseE6Z37SSosiFSexKfrgsXAyK2mcGF3cia96r88bKfI+iEnW+YI7DaOYZPczpm4ktG
	nGekQ5fZ/XdSs6io2IQmG+92u7ciOxJGKPEz4aJ3AeUeua9Doy/CdLwa20neF/6woUZJ9HIYObf
	m7EXSkWu4RkUfLcUkbFPlc2m7l3lxge8tpEwwXFRFduwjvD09s7l5XJuPFNLFavN8nvYOuiX7Iw
	nm2k7OxZ+tiwsJVmBx1Ibar1ZLPK1KS/+ecObf0fzg3E/FKLwIc0pV/DGU1/H5wjduac960N20x
	7RFgQCBrIjlnDJ68TdAB1w0E2fHRHaPna5d8NQSBBOOqM0nEtw8ZM=
X-Received: by 2002:a05:6808:5395:b0:55c:836:5955 with SMTP id 5614622812f47-5640dfcca02mr6963810b6e.44.1793648068831;
        Mon, 02 Nov 2026 11:34:28 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fd93451sm8558249b6e.3.2026.11.02.11.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:34:28 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 02 Nov 2026 12:34:21 -0700
Subject: [PATCH v5 09/10] dmaengine: dw: synchronize completion callbacks
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
Message-Id: <20261102-submit-dw-dma-synchronize-v1-v5-9-d3207758fbf9@gmail.com>
References: <20261102-submit-dw-dma-synchronize-v1-v5-0-d3207758fbf9@gmail.com>
In-Reply-To: <20261102-submit-dw-dma-synchronize-v1-v5-0-d3207758fbf9@gmail.com>
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
index 339ca85952fa..6371b9156882 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -897,6 +897,19 @@ static int dwc_terminate_all(struct dma_chan *chan)
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

