Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F8032C957
	for <linux-serial@vger.kernel.org>; Thu, 11 Jun 2026 03:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781149165; cv=none; b=EvzwF7Va7eh/+EYw2L56Kznz5COT46THHOA5hBwAjO3Ibruy2+EQBByNa3YniR/d1fWr9F8x05f/pnBEgA32Ug/3V8DvZ2n/23D9gL3/fPzhqCSTWCLjwsLj3nAte4dbK/Dt5V+AXpottf/3POtyoO6Od4rzc7FBGL+vIFn8rfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781149165; c=relaxed/simple;
	bh=Vo8Rw9tt6g7PrwiZR9y054LqY3f8BJvLsPe/+9ij88I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cVbik4mJdTHnlF0vkrqSChJR8vlUeX5imn2e+BpqVf26/YxTw62wwNr5z42IAREQcrEQr3vE+k/cyst/NpB9WZrl/Xa8s52bmPnp4ZsbN9zw8eoSUh5CfmmqFmWnMjl2IcznQErXzRsyfLzkYx2gKicFg3KscPUZH1DVtUtuCVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHfCfuMX; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHfCfuMX"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8423b08b293so3280624b3a.3
        for <linux-serial@vger.kernel.org>; Wed, 10 Jun 2026 20:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781149162; x=1781753962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JnZoQBUpFkHjuMRCFUnZLcjmhUm98D04lIrK4n/JyBE=;
        b=LHfCfuMXcxiZDYxX7CxebGjOxEhPAj4qqXg3UstkN7FJS6xDwG8lQq4ONRz3r5kWU+
         5zo43Vw5Fb8+vPGfHZLoh06+vw8QPo4bKgDv9eKnvTiV4rcXQgI8AkICq3C0abc/T+dg
         qJUVTcvgz246QnzSMfooSCoK6UHmCDogreYCEpg1MJqF4Af2Odly6XgrMcjqnLiDbfOX
         xa0OxJguP57KTod2NUsAecI27ZhELuE91Dsiu8mp8+2rCEKonWtIKIxe81WLHj7bAINi
         03XAZ3k3C2/4g4M0c5IUsPIyzTSDh2c2cWOYnqsoaAwSj45aitGa9D1xVX1uRpf74hSr
         Nmog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781149162; x=1781753962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JnZoQBUpFkHjuMRCFUnZLcjmhUm98D04lIrK4n/JyBE=;
        b=O9lcJ66TfatuFpmIhM+/qPHPwt95leEGl1QBboxsoK0u716CTVVCCP10pOwD9kft6z
         wYkDhxol88xrLQs63I101Hq46RABFQe9Njf86LsePpXgKSzN4Al7xiGJ2CG2tsBnQ/I1
         o2E0nR9jerF3ZsSIKdR1agXlNCnLt/Km5sDWdn72LqPtA2dJ8ZDu2LtBxO5HE3FqGTSe
         plaaJVjza6GDEy8E1ZOJZIAAK4vpOhxA3mg5wCf5aJ3OwqfyW3UIb5RMR7VMlfgcw5SO
         GJDFRfd7eE6ARWlSnm3gkXG+6giVxoou5WqHzTDE2I3QOzcdQ2rpNbVcXvBFTaMUBD1b
         B2nA==
X-Gm-Message-State: AOJu0YwJkCGdiVQ9gUWo7hWjNWZsS1DpsMQfjwdpJngrlMJiv1asI204
	c88/9TVVzpVv/z2uGBBVu1LNSCZCAcimBEk5Pd0+EPFNzgDzPVuLTapU/GJn0A==
X-Gm-Gg: Acq92OE6S9En5LYdXeR8P4QgPGujbb2UChZh5iWDJr44XHtD5cdT7RWhrFalJfjnosY
	Nvw+hF0rjIE1TvOi0r1AmyasJLnlj8NDRceBFDzEiSbABdmut/ImtB9x8/eJItVQZHa63jluSgO
	a968cNSGfokVCs09AXKidptYfW1j8tTaGMXvZ8U14AuYHR4p7Gx6isUXk5uXG85VJMDaLlTntkC
	jUZI9SQtZozGGDT+wWhiqtNch2HRUm/pVXJSbI7ujv+146p1NiqpCcRzeruLeBCEQXcZ02n8lyT
	YTCI2aADGjPcxJFQZ2B0SFOQ7lqOL4RpaCF9dHuL2xb2KIsYQ6Bo1WZnvcCo2/mHDurAOJOcjXY
	xBl0caxSNGGAgZKn4zSQszi0tHRQ2ehXDeHKlrPGXgyerNWt5zPK7xjLHq/VRolFkfpIB89qaiS
	vMH/zP6Zgry1I3yaL5pWirISybBiSWntrxwXbXjpmBTYxRtzh6szEWTr7kqFcN54cBRINbeGRBJ
	PqlfDib0aV0LbEAUMvtCuP0W7jDWKzAmrIuipymg8uL8g==
X-Received: by 2002:a05:6a00:1705:b0:82c:6f07:299f with SMTP id d2e1a72fcca58-843367cc762mr976724b3a.14.1781149161619;
        Wed, 10 Jun 2026 20:39:21 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84337bb47eesm334548b3a.13.2026.06.10.20.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 20:39:21 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-kernel@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE)
Subject: [PATCHv3 6/6] serial: mxs-auart: terminate DMA before releasing channels in exit
Date: Wed, 10 Jun 2026 20:38:56 -0700
Message-ID: <20260611033856.6476-7-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611033856.6476-1-rosenp@gmail.com>
References: <20260611033856.6476-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mxs_auart_dma_exit_channel() calls dma_release_channel() and then
kfree() on the DMA buffers without first terminating any in-flight
transfers. If an asynchronous DMA transfer completes after the buffers
have been freed, the callback will access freed memory.

Call dmaengine_terminate_sync() on each channel before releasing it
to safely abort pending transfers.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/tty/serial/mxs-auart.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index fe48a372d022..ec2c60dd0f52 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -872,10 +872,12 @@ static int mxs_auart_dma_prep_rx(struct mxs_auart_port *s)
 static void mxs_auart_dma_exit_channel(struct mxs_auart_port *s)
 {
 	if (s->tx_dma_chan) {
+		dmaengine_terminate_sync(s->tx_dma_chan);
 		dma_release_channel(s->tx_dma_chan);
 		s->tx_dma_chan = NULL;
 	}
 	if (s->rx_dma_chan) {
+		dmaengine_terminate_sync(s->rx_dma_chan);
 		dma_release_channel(s->rx_dma_chan);
 		s->rx_dma_chan = NULL;
 	}
-- 
2.54.0

