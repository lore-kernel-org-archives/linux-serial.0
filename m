Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792770058;
	b=zsQtZMJv9hKL0+i8oTFn6o2FJK1+e8k/Voi76uc2hayix74bErU5Pc7nPbIRhlKyvayc
	 68OtinBfVWqw16B9Uvrf0qVzL+GRX7TVW9ipix5mIYEM3J4PDd8v1FeCCVudKDeCCup4e
	 NR03VW8jANYLVoPKTmUbvxLV1RxjVpemfNgeGA3yS+ALdiOxlyrig4ovAC8zcG9wzt9oy
	 PmdcFNPKG3JiplEgY4yPFXQ1/WEx3ohvO+RXU/HOQWS1t44wn/UrTiMD+71mySkquT6bw
	 oiVqkC5nY9IJ0xTOpEhnDE5tvwN4ONmRxNex9icRJboXOqUDcqLaE78RsFjJS5qi8fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792770058;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=o1wKXpk8uaU69f7z5em398pZg3Sc//6UJ87r/eL+V6g=;
	b=fWW6A7IWpTL9aXBX/DSIGfzYUQWbROehpplLuu81BHctnCY1ytpHUCEqMnX21dlgJ3Eu
	 f1kI5ii2CJCh96LqF7rSh5vl/fA49ePPf0uvmdHrdpL0GxLrBNlORBMDwfadVBlW5hLlk
	 62faw5TDR/Pl5pWm0Yd9B2i2N975mn52QZ5g9o9EZsJ06ZSZvvMbOGev+hpl/Exa+GQvG
	 83VJv2IBsPgkQEUdf0zdYEAQhWNeV0wrHsWivMLUiJYU0/CYNktsfnM64oz+37NVugnOn
	 9a/r7/fTC9W5TNazFP178CE91igJy1xcksm9La9Md90OgUJDQzOPeNtalbiobIQUkUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DAJ9Z8yE;
	arc=none smtp.remote-ip=209.85.160.41
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BED606A31E
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 15:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49BED606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DAJ9Z8yE
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-499f20c7054so591666fac.0
        for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 08:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792770057; x=1793374857; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=o1wKXpk8uaU69f7z5em398pZg3Sc//6UJ87r/eL+V6g=;
        b=DAJ9Z8yEtaq0BPZ6unE64Trh3XDNZCSYilPyb3X4iAKNyWcJRRd4jOi0kTpAbdiJf8
         rM2C4u5iS1IUBNC62tP98vNNvakBq6qpiXXTKaHygQGJnQID9feSq4MQr4KCrZPYRd07
         4ck8s6H3X8SyoulVTL2hzltRMX0S03aA+H78SfP4hKkVTQsc7+4DgovqJ32IPmQYiKAZ
         U5Cgz8ovqSllQjjLTGBDCdpPNg2y6fYbsrff67RjK+dWI22hZhIGnFgrO8c/9W13PGzd
         9KkXnejOWBcyX3dpGAK5Hxc/NMHP9kd6xQzAtlb5Ex83jNwOMjAnrjmSA+5qNeRTlK/u
         Kd9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792770057; x=1793374857;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=o1wKXpk8uaU69f7z5em398pZg3Sc//6UJ87r/eL+V6g=;
        b=1Txb0coUW7EnYs895i9Y8oCBzsnavHfsDzjOAw8wPADtzOPlohp++eXy2NSf2kC3uG
         nX4GGPWLChYHoI4RgB16mL5qJ3QIG+1RfkVHzCMJH+m9s0ppKLHhhkEBwt42uPsMn922
         MV8j1d3TqcEJvkwP91y3j+z/QVaPMWr5y2NCFbMYFBm1Gr3kAbDbRPp4q42RcmE57nqC
         Md4qzWQuOLM5aDYegTo2tKGuHLU0pu1BNpGWbT32EoLIatgw67/4PLuZgoo1xhkjDtrB
         FsPhUGSq1zgzWDtO7l0rypdzvH0IW5N2ow1jh9fJKaVBmSadpeK+khZ+bN9Dlm/77/2A
         4WoA==
X-Forwarded-Encrypted: i=1; AKwUvBz25N4KmUzhDU11PwAbnRy9S7A5RxLY1nnJsBLRF9EACohnMGgNkZJenZ6HN5VyL1XA0EzJLLQw0QiXrlA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKrernCtKWs6X7ajc8RSdsqshsCul7c7gar22FM7U708w6rzBYt
	HggE3I8++BiRO3tdDz3TOeMOVZJ+dWSONs8obq1oQZnuw6MKHZl1XG5f
X-Gm-Gg: AYBFou3AANYv1zF0eq8oIOwljQi8ocfd5TIK6U8bLQdYj2G0p9Fm8VHg5fYSPit4m+e
	5qRCm9tS+daIZ86b8MScqmQt1Fjdf5PU1wJ0hsOK2B4JzWmqjbAhKwmfIYU7Te6ipq0cWSrTmKV
	OyYuYeyjbzu7cyuu4kTPV9a4Rqagi8EkQytss5IE4doqhT0cv8pwiiIfk287DyERuNTW+pB9jse
	+MteGj0l9ZI3apUi1KMAWpVia5BG0mghrQTBrHoeWuaWB8y8gXjo2PYGURjAzf8lj8Ocqm5GrzO
	e4Bk8OGvsC6xsvzq+OteEW7t7meW8cWAzJqM0GRwiWrTQl7p59Ttw2fgx4l0FuHxK8JWCddktL9
	opwCeb5b7DgRI8vU0hiM8x6qqW3GcaQuAjS3ScoJn0fh7LmqNl0JrxRoHVPxk76lK2dOniWsgGi
	yHdUduHFZsnbFAF4idsh/xGBbeNDm2CmPUgYb8eo4/xHv+S+gyik/D/euVQTZXHPEYvhgjVpecE
	ppz7kltFFWd40ZuGu8GnsGolbYlo+qKNMTpTEJCC644mPqYH+qCfgF5lmJ9mqupK9KZjeOapwPd
	tmLJGCqU64pZ0po1JRcJZRQGPx74eIYxltU5BcGngPPIVQxUZuHyYZNezEMoBlcN5Q5UVUx/6nq
	YvQe+GyGPo35j4viwfaetde1FwGf36KANoS6fVh2patEezZ21PS6OxPuSVNLwkdUr6R3+23XM6e
	uWP2vDncSVgG7SXJJ/YqG65efj
X-Received: by 2002:a05:6870:252:b0:4a7:41a2:c208 with SMTP id 586e51a60fabf-4a821efc9e5mr1621601fac.8.1792770057105;
        Fri, 23 Oct 2026 08:40:57 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a838287e9csm351794fac.7.2026.10.23.08.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 08:40:56 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 23 Oct 2026 09:40:50 -0600
Subject: [PATCH v2] serial: 8250: calculate TX length before preparing DMA
 flow control
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
Message-Id: <20261023-submit-serial-8250-dma-tx-length-v1-v2-1-c3106ef4d2df@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WO2w6CMAyGX4Xs2iprIgevfA/DxRiVzcAwWyUQw
 ru74ROYthd/D1//TQTyloK4ZZvwNNtgJxcFnjKhjXI9ge2iFphjIXNECJ92tAzpTA1Q4TWHblT
 ACwzkejYwS2ifBZZYVhJrJSLp7elpl+PLo/npiHmR5oROG60KBK1XTpvUYl4vscDRwmlsbODJr
 4fLWSbMf4Zixqg0aV3VKq/rez8qO5z1NIpm3/cv81FP/gcBAAA=
X-Change-ID: 20261022-submit-serial-8250-dma-tx-length-v1-bf627278129a
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Raul E Rangel <rrangel@chromium.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 stable@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

The Renesas RZ/N1 preparation hook programs the UART DMA block size from
dma->tx_size. The generic TX path calls that hook before calculating the
length of the new transfer, so it programs zero on the first transfer and
the previous length on subsequent transfers.

Calculate the scatterlist length before calling the preparation hook so
the UART flow controller and DMA descriptor use the same transfer size.

Fixes: 1788cf6a91d9 ("tty: serial: switch from circ_buf to kfifo")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v2:
- Correct the Fixes tag to the kfifo conversion, as pointed out by
  Miquel Raynal.
- Add Cc: stable@vger.kernel.org.
- Link to v1: https://patch.msgid.link/20261022-submit-serial-8250-dma-tx-length-v1-v1-1-18cecc89a099@gmail.com
---
 drivers/tty/serial/8250/8250_dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index 1da605cc8601..2dc47adafec0 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -110,8 +110,6 @@ int serial8250_tx_dma(struct uart_8250_port *p)
 		return 0;
 	}
 
-	serial8250_do_prepare_tx_dma(p);
-
 	sg_init_table(sgl, ARRAY_SIZE(sgl));
 
 	ret = kfifo_dma_out_prepare_mapped(&tport->xmit_fifo, sgl, ARRAY_SIZE(sgl),
@@ -122,6 +120,8 @@ int serial8250_tx_dma(struct uart_8250_port *p)
 	for_each_sg(sgl, sg, ret, i)
 		dma->tx_size += sg_dma_len(sg);
 
+	serial8250_do_prepare_tx_dma(p);
+
 	desc = dmaengine_prep_slave_sg(dma->txchan, sgl, ret,
 				       DMA_MEM_TO_DEV,
 				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);

---
base-commit: 1184f87e2790e8af9be3116f608d2e86b4792d7d
change-id: 20261022-submit-serial-8250-dma-tx-length-v1-bf627278129a

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

