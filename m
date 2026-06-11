Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11DA32C957
	for <linux-serial@vger.kernel.org>; Thu, 11 Jun 2026 03:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781149157; cv=none; b=ZqmXeOQzcDh63vudkZZXde615B0N+ZsPmqQKqsF9iNAoIMei6kj7ABI7oGaT3BNuBAKbXu3L03jctgxtylTDDZu519aAK13vXEsl5GExGpFbTOFbUux1pzz+nlAAKADobkkMfy/kZQ76uxn+K0sqA3xnasAfukItCbNLkWTezQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781149157; c=relaxed/simple;
	bh=p6T47j0sgurR4ZBcE//kHSmTLcJbYcotQm4TC59HSdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mWB7hqFyJ8/+unUKmDo3VyxRLIs1W9D+PHJDa9aElwH/wzGu0dxZvV27AsQDisWS/p8s05jkRbuyABITVYvNsEp/JoAtwfv4W71xH3r4mmzRgKKhh6iI05W23Vqd0NQNE/GOgm4+MgI8vqGBPIFnYyHYz8sf/hRzdEABj30YS1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUAsfJvG; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUAsfJvG"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c8588ec1b44so5138177a12.1
        for <linux-serial@vger.kernel.org>; Wed, 10 Jun 2026 20:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781149155; x=1781753955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyOCvdsh8YypBK5E0bOL+yIMik+oVX3UIIjhIbRiDp8=;
        b=BUAsfJvGi9lRNENoSs+Phcb08o4r6Z4uaAir1sszoFcgluWpWUrtB6zq5TSWsjPW5h
         rdRtMbTEWf1brTGF09vwQDxQVdp7uWBFL0qJpF6v67DgbjRAvT0a9KR9Fp8wk5Ztrx1T
         qAQYCgFAWI8SUwpFIZ38VaEgqP3Rp+gTUvhzHXkzRu5GShZzFXbcW0mx2FCY2Hsk/ciD
         LmB2F35nij13BxQsO0ArAEfIK/dqTZJGzMe9iexejFICqWuFdrnqi0IWJnAyR4bTkqZb
         lmgQfHX8Ke5lSWgP0B3f4VNagoBpBibWHjkdgOGyNNh4XpeMvKBnVr5IT7Fy9pBwwXs3
         ys9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781149155; x=1781753955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VyOCvdsh8YypBK5E0bOL+yIMik+oVX3UIIjhIbRiDp8=;
        b=RtJXJqAE640FZJVtqXmQCofnri/ehduUvvGZMNHUcK6TPLbY3MlxDvjpVc6SmOAlps
         vh7zHjWMplZkyiW11urez9D55oNkeM2SEHX8mybH6jtuT7EVTxoV7XSCJ6NuvMc0i3kp
         ZRIVPfkRdXWiRlr4FSxF8rskdaGNag1IEB+KKJfvQzFu3fAb+uOjNMIzOlY06V3ek8io
         teSsudq4UQNxBbcTFsw+/74T5mcJTCmFeOZlkFCqAZ4zpj8tM3dW79tYekohPS5VGNgP
         5B5JSfKzqnCyYlI+0l8ET31oyawA+er9M/jS14MB1CKF0M1n/52N+eF6GlpIJjde3nDG
         pLCA==
X-Gm-Message-State: AOJu0Yw84ZNsIFE0xq5OwepbIsS01YYS8xMtgjuFQwiakXZPPbliqwKu
	5aUJs/8DhxlmXfZCcH84Q/ONdhINyZmaS2kvcla22cqhnH5tdMM3Tt0djritIw==
X-Gm-Gg: Acq92OEatYrs8xvd/6CjS5XbP0W2MgkEiIa6Li+naZdo5Mc7vtellBXYtrs/Qz8g+y8
	aC+vDIsXMHp6hLtpKwLVoXaaxdqN9hOEyQThIfjG7iQwZxbSc4SRtOmQikaeKEV7XaDMNvWMHj4
	gi+tAUH7h4fF4P0Tp0fTD5k6IjvuB/WLSRkOgcvJ/mln6/TnCWkQ43EMBabV6G96K4VnIQm4ClA
	B5pdzFr+r7SxXdRPPe82qy76IT12Sy6/+oQh1J5lT9yJ+Mj38zoxbrmu+DOtI5CS1c3/hdVQvNT
	ArtZ6iqeLkO4i08pDKSJ0l3tlDE7Q2zDvkn6Lqmk72E/da7caaGLwAsm9PW8vbn1FcHrpZW3w9Y
	2iIQZF5G0/6dkUQJHb3m5grafpxtySYcEGzzeLb3Uj6TQ2fQtr2qflPwX2cgumSaVvh3OTzsR9v
	F7d40T7sX9gejneFWEv+w5OwZy7jabM+/uyOjCesNoxR+TYG0nSahYIAHM2EYu0fAf/hi83ToRn
	8BhaS9oye1IvWRlgiRQDf5axQEuFWmjlxJ1xNV6gLvTCVYBMaLvu+od
X-Received: by 2002:a05:6a00:1905:b0:841:dc8d:8066 with SMTP id d2e1a72fcca58-84336bdb046mr915556b3a.39.1781149155261;
        Wed, 10 Jun 2026 20:39:15 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84337bb47eesm334548b3a.13.2026.06.10.20.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 20:39:14 -0700 (PDT)
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
Subject: [PATCHv3 1/6] serial: mxs-auart: fix cast type for of_device_get_match_data
Date: Wed, 10 Jun 2026 20:38:51 -0700
Message-ID: <20260611033856.6476-2-rosenp@gmail.com>
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

of_device_get_match_data returns const void*. Cast to unsigned long to
avoid implicit integer truncation warnings. All the data parameters are
correct anyway.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/tty/serial/mxs-auart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 697318dbb146..de97c0f74e7d 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1598,7 +1598,7 @@ static int mxs_auart_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	s->devtype = (enum mxs_auart_type)of_device_get_match_data(&pdev->dev);
+	s->devtype = (unsigned long)of_device_get_match_data(&pdev->dev);
 
 	ret = mxs_get_clks(s, pdev);
 	if (ret)
-- 
2.54.0

