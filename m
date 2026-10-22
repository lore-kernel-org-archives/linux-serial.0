Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792695172;
	b=lpe/PAinifFQEPs6f9MJ0fXDB5uTEgbmQb0vdaZrbKgayga5DHREHtoPAIjFJ0vyIbD1
	 yqIeuCt4j70QNmszH24eopQn/WYCWWdxRlI9GD2qsgWx/n6BgqMshweL131k7+zZwzzf2
	 CdoRbUYrv4DM2CZji6xpf11KX2EgDlkwK+wmbpuaYGNc4YT2CjLszGmHSWs+6LJSUnQM+
	 Qj7xuQIWYuSYU9xaOFHjixx92BFEVkLJwKa1twT0UvKOpX7wwTlOVfCC1q9v+gju6pITh
	 w/FeapSCag9rUYeC6jQQv5lw30y+rLN8zXg2S579r5rFr7SKcVxvw/hURl/kp3m3x0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792695172;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=GJwkMjAm7gXYWbOMf+KJ0s64Seoh7DobYjpjpDcQVHI=;
	b=VS3USwP/aXCnR3cXoRgapnP6/R/I6Svtl0ZA/2Nojg0v587DIOW1qUbRz5O9dGLHLQL4
	 2mHXXCxGDbBUJsQs6KYDovH77DndV6HAaxYvz3iY3V/PrFSDGIVdNkYZNsvRZ2QYKeZ6p
	 jKFz/8LPwZDUzoUbNnsuswzadCXdpMt4ocPc3V6cFr7a48qN03ZmSAxSaIguHBhUhwqd0
	 grEclDggiQTbtz4NvROTKp26Ph6mDHmYyIv/HQe+DlTsdapuCQXjpJi2g4aThMIUyjuGf
	 XWL5Dq67LHWsiKEk4zPv/zoJEbJ2N9J0s1dQjpcc0cj//LgkFTh8aQY6aQSCMY4sUbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AmQXV4kn;
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BC3606A321
	for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 18:52:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97BC3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AmQXV4kn
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-823e4047037so51899a34.2
        for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 11:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792695170; x=1793299970; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GJwkMjAm7gXYWbOMf+KJ0s64Seoh7DobYjpjpDcQVHI=;
        b=AmQXV4knyfPNyYdXqT4WYHca76kVg2Svy55CUptNAUo8m7pAo/2SjaThOooPpj4Rlb
         f+FjDfqJOEHaSSwGzzbz0cTwo/pSyPSWQJh0z0Ve6XzlyDFKTcNLw6nWT27ydVjYepNy
         T8lhLsv53fMEkPPqks1CCO8thPzFj16b0DCxfVRAul3jv3D3gLL2EcL3Ti1xoKjWJZVT
         O4HMByzyRQI23tMPhi8MoukibCXAhB4wbj63P4eEaz5IaziIfKheg8ph9SK2KB16EWae
         4vqiQj8/TTkPOpm5gViTpLWsVjrjFjp2je4EWCn6S9FnjaRChNSQ26S21TEho7J3z7IB
         O+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792695170; x=1793299970;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GJwkMjAm7gXYWbOMf+KJ0s64Seoh7DobYjpjpDcQVHI=;
        b=nGtgDI7p5QB1klSEiRMHYz4vwvhpCC3SjTgKWlnbPNFgXOV3HytV5/6J02DXEr7prU
         KyBGYEzOzYWYFMdqobdRbggPQ8GMzkyCvut7i+V+ez7acnimqQDGC1jJxoJ6zQjBY+uu
         PX/sXJoIipll0Oa0ffxSR+zerjcYjyKq+4RQEtU290jL57GKy8MGRGiFs1z9PTlEp8sX
         UmkRASCvMNS7SxC0GpMCemGlMSP29Xn8kx4AVJVDEVWE3kuqfTwGPqLd7CHxfWysI1IB
         yQjJ9YrfEOG5GzuObLSNnLtTtLq26pFglL+kuw11V9wjbbL0oqoliVyyiiGtJGyE3wwC
         +7TQ==
X-Forwarded-Encrypted: i=1; AKwUvBxrOsUyZ0SOm+sURS5oeudcZPiLBo7zesw3NwpiBdF2avJIGhwE0MRUWurQQ99GCeM561nNT7QyOFfPEKI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKUFjQ8tp392PRgT7jHw0Aqrg9SC7/0GXDECAgUyYKNlH7pBIs9
	WlNTLxqmGutK83dXOZIIlBzpfk5ffqSQS3n8c5Omi6suDfi3l/fXj+F3
X-Gm-Gg: AYBFou32+HuETy9IVIswrg+d+2YuSrBkAPDcqOiIly4RAz6kZLG5/z8mKsknrSAPu5+
	GOzzZbM7xd1vXcSXqILDznckCpgDbjHvR0h0qTETEVAmb9YFifHNqMLeSnyua9dYxK6qadhDhIx
	hRYeUTwmBCSB2otHoNAmL6Jslc9TaLC3yiMCj7BSuEV7TE4UBedWvW8aHpc55c+2WkG/0UC5tyI
	mcPhoDl1i8Wk9h9ZlXfmmBai8ZR1zWo7jvCrTl02s6Fy06+I6PRc/N7Cr23o0vS+KpSPbTdUtiw
	IE/KVSlU3+BcD6JVyQZcGpYB+S/o0M1prQI+KGoO2Fm7O6Zfh4Sft41bsK0PFa5jDEYBcDIQRzR
	Ofuj62ZIb+r021KuzAdQe3VvEj54AWz5y9BP4BoguTLDNMOy6wAeASg4cGiXon6MWOMjXqia6os
	goGaF1VLXbvsyyE3XfkHkuT9BQ4qJfCyGB2F2xUTucLSjzqsbXbH2EscZAScDoCb4F6Q+6cWrnh
	xJstVN77PxWMXIsrUiUVqI9ntBLkbrYNX+NgbETGcoyCqerhY2CXlr/maNGWTru3F5bw/qbvi9p
	X77eEB5RNR7iBL/+LS0XS+6zyKI5bNHlJPLh+I++KMaEY2CNTbTIN4moJ/Bo8xzeLozKIibYLXx
	Q5UKGsxYGJnUIo6uuAmn6UfQIfxkCI87IvQtCK78yt1o3NzIkslOHyKeCBTwZMPtWql90wQZPPV
	QYEFuYQtjXn9Y6sYDkzL8C+BuF
X-Received: by 2002:a05:6830:4429:b0:821:c01c:2ec3 with SMTP id 46e09a7af769-84fa7fa0809mr27863a34.0.1792695170512;
        Thu, 22 Oct 2026 11:52:50 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-84f7703d288sm536083a34.4.2026.10.22.11.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 11:52:50 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v2 0/4] dmaengine: dw: serialize completion and termination
Date: Thu, 22 Oct 2026 12:52:47 -0600
Message-Id: <20261022-submit-dw-dma-synchronize-v1-v2-0-5244e94dca8c@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OTQ7CIBCFr2JYO1qIxZ+V9zBdUBjaMRYM1Gpte
 nehvYDJbL7Je1/exCIGwsgum4kFHCiSdwnEdsN0q1yDQCYxE4WQvBAc4qvuqAfzBtMpiKPTbfC
 OvggDByzLwh6O1nCjWFI8A1r6LPpbtXLq31H32ZkTtYoIdVBJk1/Jia4hh/u1lxItxd6HcVk48
 Gz6c0w6DlLZU6mFkVaer02n6LHTvmPVPM8/sjcp5fwAAAA=
X-Change-ID: 20261021-submit-dw-dma-synchronize-v1-e550f47fd1da
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

Keep descriptor callbacks in the controller tasklet and serialize the
ownership changes used by completion, error recovery and termination.
This lets device_synchronize wait for callbacks while preserving tasklet
scheduling requests from other active channels.

The first two patches carry Serge Semin's fixes [0], with unchanged code
and the collected review trailers. They make tx_status calculate residue
without invoking callbacks [1], clear stopped-channel interrupts and keep
normal completion-list updates under the channel lock [2].

The third patch fixes error recovery separately: recheck the error under
the channel lock, stop the channel and detach the failed descriptor before
starting queued work. The fourth adds synchronization using
tasklet_disable()/tasklet_enable(), preserving pending tasklet runs while
waiting for an executing callback.

[0] https://lore.kernel.org/r/20240911184710.4207-1-fancer.lancer@gmail.com
[1] https://patch.msgid.link/20240911184710.4207-2-fancer.lancer@gmail.com
[2] https://patch.msgid.link/20240911184710.4207-3-fancer.lancer@gmail.com

Assisted-by: Codex:gpt-6-astra
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

---
Changes in v2:
- Carry Serge Semin's two posted fixes before the synchronization change,
  preserving his authorship and revision notes. Add the requested stable
  Cc trailers and Andy Shevchenko's Tested-by tags to those unchanged fixes.
- Add a separate error-recovery fix for stale error status, empty channel
  lists and software-LLP state when terminating or restarting a channel.
- Use tasklet_disable()/tasklet_enable() instead of tasklet_kill() so
  synchronization preserves scheduling requests from other channels.
- Explain descriptor ownership during termination and acknowledge the
  shared-tasklet scheduling race reported by Sashiko.
- Link to v1: https://patch.msgid.link/20261021-submit-dw-dma-synchronize-v1-v1-1-6af85c2d6f69@gmail.com

Revision history from Serge's series:

Link: https://lore.kernel.org/dmaengine/20240802080756.7415-1-fancer.lancer@gmail.com/
Changelog RFC:
- Add a new patch:
  [PATCH 2/2] dmaengine: dw: Fix XFER bit set, but channel not idle error
  fixing the "XFER bit set, but channel not idle" error.
- Instead of just dropping the dwc_scan_descriptors() method invocation
  calculate the residue in the Tx-status getter.

---
James Hilliard (2):
      dmaengine: dw: serialize error recovery with channel termination
      dmaengine: dw: synchronize completion callbacks

Serge Semin (2):
      dmaengine: dw: Prevent tx-status calling DMA-desc callback
      dmaengine: dw: Fix XFER bit set, but channel not idle error

 drivers/dma/dw/core.c | 180 +++++++++++++++++++++++++++++---------------------
 1 file changed, 103 insertions(+), 77 deletions(-)
---
base-commit: 93f51579e7df248780214094418f205253383cc5
change-id: 20261021-submit-dw-dma-synchronize-v1-e550f47fd1da

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

