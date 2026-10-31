Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793407662;
	b=kV7iUQE4Biuf16S7JB0Da8Qh97EphcHufU1s9fNddYLev27Wa9+BlFBuq0WQTl50g8CB
	 7MKCSaGSeRUgUBcEgAavE+A9nDmcLaJ+/b00KFZQHfyRSvU7CmqLstIBTVwcxVNWmP0P5
	 0AQWRCWEqNroU1C7gdeWxydBOsezD2WKyCKHqI/gJ/56wocNvXPqTUkBigL/mLQYjyXkU
	 3auzpUNoiIiH98myldseiQl4sUe7KQGN2fXT/Vr7mOv8Q2cLuMpehXISauO55RHqLFCkr
	 AFRTfNnarYw8PDVnQlNFIjitbimA0Mpn1UtZuUkX3ZPBE8SEpsOQCzkBQ8t30oQbsJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793407662;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=268LSzP9pfFwdbgVDxMqdS0o6I6QpSICZ5YPTlGbOXk=;
	b=Att/Dnsy9PGBCUZHRFDXLoPpTHKatONFVgKt6vuPYxYwT1sg2sk3+8JazZq6jsPF8645
	 +CuxRV/le1WleFuViFgLcJm69fH55sZdG1J+HFB057l095heOngpOF1CD60xowsTExgmm
	 0l7S1Ze+mfyt9Bs5wq9oANGYkv+5L5gpjqcZFWRDgynPgS2UCzEggBx/P7XcQluC73ctY
	 mgKYj05oboBBFqR8J3mistxq5Yl5S3HeJusbyXt7WKrkB81XkVpmEhCLVIOO/yAEH0H6G
	 0DM1QHPS0MtZtbk9DNYfSh0e2UB+Xm7lFdAGi5FBdVhBnGa3KBN+w+3k4aDbFHYA/MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IJRDK+mR;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81998606A31E
	for <linux-serial@vger.kernel.org>; Sat, 31 Oct 2026 00:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81998606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IJRDK+mR
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-353804b591eso2014634eec.0
        for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 17:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793407662; x=1794012462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=268LSzP9pfFwdbgVDxMqdS0o6I6QpSICZ5YPTlGbOXk=;
        b=IJRDK+mRMeVNqm4z8zkrrkm0GNNjwiXPX2+viPyOK8zgiaefP8s19h7cOcU2VEcWoU
         PqS1XRCbjdYh8/g0znLNQU0essI/+qfLqU2xlyBU4DHp3tNzHFcvrLS2+rOiIVaJCWem
         kEaYuHo6CAuPnj+kPUfjxxsg/uCUZVeAq6n1gCrgRG2swHABFX5Ao65TGHmfT1wmdlg8
         x1WzbkGgr50xX0yR2P3DEtnPnCv35Knv63DNLVKWeUKLGcj6G31LaDCsMW5PoGfP+lrS
         6/DtObogIU9qrRnwiZhPWD0X3MwiZ+ZazfKSBeAVBoGiXe3giW9oRw/gjKDHqMDTKgir
         udqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793407662; x=1794012462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=268LSzP9pfFwdbgVDxMqdS0o6I6QpSICZ5YPTlGbOXk=;
        b=cs4l7Xor0RpeiOgQ1/ZVXdkzhIb0zE+Rm1+dnOk5sX40V/NP2kNRYMdvHtuKib1fSe
         bNNKatpTCOfyiAyPIL3b0NLicdGQwGsZvNwX7YgtpR5lHyWAWm9G8KljtfODAM/Dkgnu
         KlYIzj7ZAd/JuQ5DOqo38MXzL8O/+/bviXLKl7hjT398aOk3XhC1xB3AsscXSCZorFBX
         imRHrrcHlXMn8tT2zxVJGcJSalovoBnCSJyQ1ClrNTSAEVLncBO7YmNwRZLpLqDlWJW3
         IvSfz2xx0VOEmYbnzM8sclS3BeIrEnjcJlxW2SgCjvAWVsyJLIuSESpdFNfchDBuREn9
         0piA==
X-Forwarded-Encrypted: i=1; AKwUvBxsIoY/5GaG/11agh1scKstMBUZnzkrUaxs+wkgQ4yJDlNewbPOAwKs1r9Cg6mnWoTRrfxmg+Fa5CYtmT0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLU3PHjdrPm0fSo4B+JQ7sme5bifeduMU6IiZNq7PmYLFJR1l4g
	VNL6ER5vp3Rt2G6vmmTEj5eO1TVLDqjH6A/FkXGa1tcVlDSwgw3IE1BO
X-Gm-Gg: AYBFou02s0VQDqI4kNSf5knn5veACQDm4GUl7AofM0mJP3S9a5zE0T2C6wRofNqtH0R
	VjNBoUsjs2l5wV5vqdHsN+2tLMYbiguNL4Y/RhnEZOiqLSA3PRn0amqVDkDGYYzq3Ell4NFm2V4
	Uv3Mx4T3X4km07RlQo/oJ5Pp9WzoDyQA1XGnoBqAXQu5f/GZFqXsi4pexf7EBHF1OCdh4JAy+I7
	IGEiEnz4EAI3KdF+B5SPX2pDYJk7cqpAtFkz7Ju3W0EdraAUCNpf5ivrBSZJzQbkRBy8UNrRZO6
	qnIO7nHzWNgApuW/il0UrKKmJwbK4RQZG8AJtxiQHAzuJqXJl729FFqiDI+9qk/TQtmJf0AOSOa
	D81ML7lPivsBHLlSj1CohfO5E0da+2EW/Al/wMudBd+zudUo/5fNREauhaDSdW101UY9Nfh1l+8
	UIirpyQWggrctip19GW9F0lzKt5sAvfF40W2YbU+81Ukeyiwb5m01Dqvk3HYy1cZFQh1eAIoBK/
	s0Uz8PzDc4gV+7vZR5lu0/rB89C3rxEIj9fZlkH6xbWmhuutPr3ZZIiivaPP40VB+UNFsuX4Osh
	DQLQDVSJHVRLs6dxK7iTy/6Bc0QCxzycLjJ/Y8mZbm6mUyDXPgbJsw0Tjlnq2C9gSNVWyMx6SUE
	cgy6kC3nBxDlnkfUI2QcsodhCZzmqr4t88RbjIFFq4AfJ4UN0isVwTvVNA4/jyKYS3T+9OPkxdF
	xeDjzCEAcX2oh7atg=
X-Received: by 2002:a05:7301:e105:b0:36a:15cb:30bf with SMTP id 5a478bee46e88-36a42345851mr5374853eec.13.1793407661421;
        Fri, 30 Oct 2026 17:47:41 -0700 (PDT)
Received: from brev-9gdpyq8lp.ap-south-1.compute.internal (ec2-3-110-210-194.ap-south-1.compute.amazonaws.com. [3.110.210.194])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a77c0dsm12703100eec.26.2026.10.30.17.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 17:47:41 -0700 (PDT)
From: Samarth Narang <samarth.colleges@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Samarth Narang <samarth.colleges@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-serial@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] serial: TX kfifo underflow when TCOFLUSH races with TX DMA (samsung, sprd, msm, pch_uart, tegra)
Date: Sat, 31 Oct 2026 00:47:33 +0000
Message-Id: <20261031004733.3345841-1-samarth.colleges@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The TX FIFO underflow previously fixed in 8250 by 9e512eaaf8f4 ("serial:
8250: Fix fifo underflow on flush") and in qcom-geni by 452d6fa37ae9,
7ea38c49e717, and e3c04834ae1a appears to affect five other serial
drivers. The line numbers below refer to mainline at 83f32c773255.

uart_flush_buffer() resets the transmit kfifo under the port lock before
calling the driver's flush_buffer() callback. If a TX DMA transfer is
still active and the driver does not account for it during the flush,
its completion callback may subsequently call uart_xmit_advance() using
the byte count from the old transfer. This can advance kfifo->out past
kfifo->in, causing kfifo_len() to wrap and the driver to transmit stale
buffer contents. As shown in the 8250 fix, a subsequent close can then
wait in tty_wait_until_sent() until it times out. The issue may arise
when a large write is followed by TCFLSH(TCOFLUSH), or when the port is
closed while TX DMA is active.

Four drivers have no flush_buffer() callback and therefore do not stop
or account for outstanding TX DMA when the kfifo is reset:

1. samsung_tty: Neither s3c64xx_serial_ops (line 1679) nor
   apple_s5l_serial_ops (line 1700) implements flush_buffer(), while
   s3c24xx_serial_tx_dma_complete() advances the kfifo by
   tx_bytes_requested - residue (line 342) without checking whether a
   flush occurred.

2. sprd_serial: serial_sprd_ops (line 944) has no flush_buffer()
   callback, and sprd_complete_tx_dma() advances the kfifo by
   tx_dma.trans_len (line 276).

3. msm_serial: msm_uart_pops (line 1547) does not implement
   flush_buffer(), while msm_complete_tx_dma() advances by
   sg_dma_len(&dma->tx_sg) - residue (line 482). Its check for an
   already stopped transfer relies on tx_sg, which is not cleared by a
   flush.

4. pch_uart: pch_uart_ops (line 1518) has no flush_buffer() callback,
   and pch_dma_tx_complete() advances the kfifo using each scatterlist
   entry's sg_dma_len() (line 756) without holding the port lock.

The fifth driver, serial-tegra, implements tegra_uart_flush_buffer()
(lines 1272-1279), but only clears tx_bytes and calls
dmaengine_terminate_all(). Its completion callback calculates the
transferred byte count from tx_bytes_requested - residue (line 537)
before acquiring the port lock and advances the kfifo afterward (line
540), while tx_bytes_requested is left unchanged by the flush. Although
terminated descriptors do not invoke their callbacks, a completion
already running when the flush occurs, particularly one waiting to
acquire the port lock held by uart_flush_buffer(), may still advance the
reset kfifo. This is the same race addressed by 452d6fa37ae9.

The existing 8250 and qcom-geni fixes provide possible approaches, with
the former clearing the outstanding DMA byte count under the port lock
and the latter marking completions as stale during a flush. As discussed
in 7ea38c49e717, comparing the completion count against kfifo_len()
alone is insufficient.

These findings came from a research static analyzer that checks whether
uart_ops implementations using TX DMA provide flush handling that
accounts for outstanding transfers, followed by manual inspection of the
reported paths. None has been reproduced on hardware. The same analysis
found flush handling in the 8250 core, atmel, fsl_lpuart, imx, sh-sci,
and qcom-geni, while amba-pl011 is not affected because it advances the
kfifo when preparing a transfer rather than on completion.

I would be happy to prepare separate patches for the affected drivers if
the maintainers agree with the analysis.

Thanks,
Samarth
