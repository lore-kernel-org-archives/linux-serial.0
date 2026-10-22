Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792689286;
	b=Y7eZ2/Fz6c0pnT8Yo+PQC86JuSaZWiTuHCl/cTjTdqOExBvioKaaj0n73DYgBP58WNXF
	 ydrEn096ZVX4EERtkL1ZWkIS+XCUJDc5rUtRSV8jI8ozi67s3hPJ7z9MkgwqYg3zm0GJQ
	 4tAaU2UHmblkq6wqNsSDhHs+0MYG1DP4HBVcAey8URaVjvifE4SlRNnvPZG2cdnxMHGcI
	 aWcqA6K10zFzbKyluEv5an+O6Kbw3iMojQWZGejbyiVfJxmBw8saZeIFchqyo2SgGRaQM
	 sJssUd7Bq9Paou+iwDhkZlKGG3XIF4Kyj2VLBK+0M2LmXDMuxa6OUxHz4KkYiSnaWOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792689286;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=3DFHN/osUdzyJRwdOHyKkTlNrKLynKFcwarVbxA/Iho=;
	b=ZESD5t7/qspGuJ7ejfsn0/tDXw6fxYVCix3BpMW0sAXHv4Ge/k13w7I4ZYYKeta0Gynm
	 FAgpWjPbQC2slEa36ZLGQEL8IWeX8sPamfj7VUeE80YqFUXRmPORY6ct877Hy3cl68eIm
	 0L39WTxnDa9f6zzjXEYwb7bYCIx8BzZfC0GgP9zMpszxw3eETu6fAKHgldK0K/JIs34t4
	 pQ2hpg136nYYyF8B2RICK3m74Lgwh7CCH0Ur/2Y6gt0yQe2Gnv69ky/G2qBgST6DCdeE9
	 mYAVnVMh2pck1aTIr8y9pfQ5FmpCW7uSKcmtu65QEwmNip9+FxS7wswNSN84Ye7VuSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PmAP2l2f;
	arc=none smtp.remote-ip=209.85.161.43
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0F2606A31A
	for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 17:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE0F2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PmAP2l2f
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6aa9606ddadso26991eaf.0
        for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 10:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792689285; x=1793294085; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3DFHN/osUdzyJRwdOHyKkTlNrKLynKFcwarVbxA/Iho=;
        b=PmAP2l2fgTOlTs7Js+AOQ0lKPXSwKMPjR4pTxJ+C7QzACp4jbRhJJ4pbDv9s/bfAqw
         g+RLeZPhJrDH+jPccM7dyh4WeC6wI00zY2nd1QGxJgWBDub6ifWx0edBVBjBX6D7fJd8
         GXFqzYrL4IvRNsRY9CjB3pgKUdP2foPfiK1VYFV1yKPlNdgi4nkvTThGUulEVZ/1UwcD
         g9TmBOmATybrseMzhD3BlgD/EjzK277/R1OuYfrF+mRDMurxqUkpcXb+D4XWYVTLgOMu
         cAT4pNfsKbanDKvSkkV6m6iiRF0fKP5av++FqGJwCyUmYxK/CWzGC8bPtqdPVJhgcaXf
         gOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792689285; x=1793294085;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=3DFHN/osUdzyJRwdOHyKkTlNrKLynKFcwarVbxA/Iho=;
        b=LAH6y17ADUoe6cc/LZnakohXVW3dpnJotUWdqWAldmXiNqS1dTwUnPdOiwnf2Jg7g7
         mVdfYKbS/YT1QWtYxIvmGfkgcJKU1Ouz6dexUI78bSUQ68j4gV/nELpqBrH7GH+TrtK/
         xBdZgWeZ0+u1n8laG0FRuY4DireoqIR7kk7ux+dPYmNInevalLfJwOMYkheSICbGRIvu
         EP5EB+sgiHEYnreWes1+2iaoJrQ7VoOhz4BzPa7odi3192f82IWVW5rz4QKFzzTJ7tvz
         M74iWedz5bUNnvby5u9D2FDpwOHMIZg9OLFr47hKaAFNXD/+u3N453ky3L7N1Adw9ghJ
         lhLA==
X-Forwarded-Encrypted: i=1; AKwUvBwn5S+1YlXuncF6y9g2uD4ayxZnFRSmv+bmqFLfnx9q2MFVSQDKwpY/dKkTc2d8dWxT6Fvqw1ooIt4X6lE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIWAVWJkVb5Wu89cOohgsK+bkM3tAlOtnvqYkwnOpXqf2AhDwoy
	Vk6BtFOGNwX+6wneDj2Nm6cUWD2NU7b4mKIto8E2Ah5yIDTI8swfL6jj
X-Gm-Gg: AYBFou30/zejdnn15nImE3MmbvhK+R3uVwkXdAmNIkcLaj5JQhXp9XxAnTDHYFie4vv
	IPqxfxmYctXZbQtXZBIbNzhLkNhy7R3shfovGL9QzArcyunQTozIAuiB6JkKmVyWiSktZvv7Z+P
	IOY7VmBRTpxB8giEo6X2o7bKo/Fc4lfPj3uRjl8UCt3rYC/5nw2TqFgtDxgchCl/d88fccLXy+8
	rOzVlpi/g9nD8IW+68bdnSyViAhrS6NI087R7Z4DbUgRGxObbIi7fJ1Gza5HKoz+wXNysAJWeNw
	Ivym6xSdv42BE8dc8M9HulIYryVTazq10tXA05HveIB3ThsOrNCS9Qad+dNUhoREoj5sAOGqmwv
	R8auvQPlxc3m7jkEbUhTF+wYarkRb7wcgew/QglyZwQdCGsxfSHlILkJdvXxpPucsvIHwZtSSC/
	8Q+GyaK/zyfj9g0iM++X5xw+GeGKnYf6jqdk0Wcg051uQoKOq3i1yDh6/sFVJxHYV5C7aw4SpQE
	tm+cHpBs53APmV/4L4VgHr2DoI3nmF9PPPCNfmRgEs29eY9NR4fgwQfgnLi3hxeMXhorFgXcCZ8
	eTe4xgwYP10rVblGW62pmAHsqUV4skOVs3oYLB0Gz+CTficblyG50I8sv5I9R3yRM1sjYRqn85H
	gwH/rGeFiOGcH0IEnM2/9qGH9AZUtKT0TCTM2UVgeiC9xEYQw+57T/Rmusx5FEPLM3DVudkXN89
	Q6soLRL1btxmRMrOWfCMOkqiXs
X-Received: by 2002:a05:6820:2007:b0:6fc:373a:176a with SMTP id 006d021491bc7-70b88af0e4fmr33116eaf.77.1792689284805;
        Thu, 22 Oct 2026 10:14:44 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-84f788ec31dsm270811a34.24.2026.10.22.10.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 10:14:44 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 22 Oct 2026 11:14:41 -0600
Subject: [PATCH] serial: 8250: calculate TX length before preparing DMA
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
Message-Id: <20261022-submit-serial-8250-dma-tx-length-v1-v1-1-18cecc89a099@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNQQ6CMBBFr0Jm7UQ6iYBexbBoYaA1UE07khrC3
 W11MYv38/+bHSIHxxFu1Q6BNxfd02dQpwoGq/3M6MbMQDU1qibC+DarEywzvWBHlxrHVaMkXNj
 PYnFTaKaGWmo7RVcN2fQKPLn0+3Lv/5w1Dx6kqEvD6MhogvaDLZHI55wPPSeB4/gCSLEWKKYAA
 AA=
X-Change-ID: 20261022-submit-serial-8250-dma-tx-length-v1-bf627278129a
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Raul E Rangel <rrangel@chromium.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Phil Edworthy <phil.edworthy@renesas.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

The Renesas RZ/N1 preparation hook programs the UART DMA block size from
dma->tx_size. The generic TX path calls that hook before calculating the
length of the new transfer, so it programs zero on the first transfer and
the previous length on subsequent transfers.

Calculate the scatterlist length before calling the preparation hook so
the UART flow controller and DMA descriptor use the same transfer size.

Fixes: aa63d786cea2 ("serial: 8250: dw: Add support for DMA flow controlling devices")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
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

