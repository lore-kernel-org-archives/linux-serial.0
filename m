Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793721117;
	b=CcpwJTB0B0+zEIvxbmpkl1CoemaKyswncRoyOQVe7A+5spZBnlcsgwCuP5xUVtWTZ5hH
	 DKwEUOKoOkdRVvNqnfdbl+w9zoeUmcvMh1A0V2kIYLePRpyNWvXUUoOHkxIXecyhLvtR9
	 tI/HgZ+1mJK3Il0lhkpOgsJ7hiEsitw19IDS9sY6+HppKniyzG7OS2CTo+74ze7G0P7a5
	 4NqBrTjUdBvuvtqRguNyNi819hQTFAroOctHUl0/J7/GMFuVR9kJRFon1ApPjRQ2dC3cK
	 TDreCiv7MaffIr8wa5Sw/r69JLanZ3kXf+YHQHOjRPOIbpj0OLUicZG2kyeCIuDlxuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793721117;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=48ZgMUAmWUootHlVRFgHd/O1MI4u30L741/hVXfoBok=;
	b=vkPMtjk4xRg8dPKXGrUvLvMMjpAXxb+o/rVeKT562neTMXO6BlSS5sLjqJNFuLeMwap3
	 hE9DT0E3XjDfVXtyk3A2fRbpdf3MDHgHK6ICYDtxRGZUos13DRoEo4MtLUwYn5YzGo2ib
	 IAF92XQS6L7Q08v8Zde1d7MYaTSbbtLcEMDZJjZMSuEbfDDVykj8fQcNK+lf9DUCGbjvk
	 DwKCt7LLjFTjwBf4+DFaB19cMly+Nox1jk+rciJgIf61K6PD5LFN8ohThZcl48BPSoRHe
	 /MdiVo+Q++6rRgrK4KDxwDFhZDwYQ26KmH+kUlI5wiH2YQdUMcv2q8YLJxVUkjqJWEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QnliSMnd;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C361F606A334
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 15:51:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C361F606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QnliSMnd
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48e0d1da913so718015f8f.1
        for <linux-serial@vger.kernel.org>; Tue, 03 Nov 2026 07:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793721115; x=1794325915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=48ZgMUAmWUootHlVRFgHd/O1MI4u30L741/hVXfoBok=;
        b=QnliSMnd3rlXtRor8SHtaOolv1WFVAVppgOyQH/qNf5MKmkOXTHkzQTiWRPaPwWA46
         cBb7O+UM5NyRBoA5bhBrtzYEyyJnOcP/jysxngd+AFlBAanf8ZsUY2chdshUfvDaS5E4
         Dg4muARPLfyIf6u1eZ2aAZUoKcWoZRK6qbl8XY1cWFKHUp+O4yjg8CrcwEQ2gySVONsK
         OHGjxF2W3FjFZecA6ehjE+NQPnGXkpQUwDQhBrB67/G2Bua6QrIc8y7ectJX1Amxec8X
         aMGsqkIAHx8ThqNj8J/c+DKYrXJLjHKwnGt2vrOUaZRellJCf+13HQbxVnZAc5zrmy98
         Mrsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793721115; x=1794325915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=48ZgMUAmWUootHlVRFgHd/O1MI4u30L741/hVXfoBok=;
        b=c+MoQV18uvKSEmQTmMR+oBjDguu0GGDITSDit8bSDuEexKkvPHmqWt6+u94SMwos4B
         yzxrj0JxrTHMZePeZZE/W2ClDQK8WsXQYDfYF/YTDXLOcH9LGEDQe5vJgznneQSt25HS
         Mu13IYxYQFJrjzgYL0zEkUXcsSlyhBQqNyKAMS0CyKQC2cKQGoJnks6VwQ7OwlDdKjH5
         LEYWN+6nUNZy3s9rVwXbwkWBP5EKj9RcXONmooD7TqjWuHDt/EhcPV3D85YEMsCv+Q9z
         EYst6AbXe7dm2MjuD0utiWXLdYSoziWQjFmg1ez+9FSIywN+s4pRGDDpW0lIkG0WeDM3
         xo+A==
X-Forwarded-Encrypted: i=1; AKwUvBxvjIlxN9SqJlvs1jZ5w4PiIYZuPPO9RGD5ckFA9T4BTdRplCpPgDn8c5w+NCBLBNn+1rjBbZoqVIQTmFM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Q3+WYinbUVTVjixCFhfW/pbAydhrCV/WY/2fJ9K4FsoriNJjK
	ph6Cx/du3jtYMHvMGi1+opGd2VgHeFsNG9aSa5a4aeoZq4+m+vTavPIB
X-Gm-Gg: AYBFou1z4CWmr2DK5XIRLP+vAkfKKUrnlOlz7avbTrHqlZdEn4+zRB4snyoGrjCTLXL
	I6+9m1M/Zwc6kwBmhkjMM9jtFpRXFZroTVXLRgiL1824qXy8uwJQz9GX+MobvB/CO6AmNe2QNkq
	fcoOkZ8Ev0/tPxRuyf9GdH2OBq5LYXANYr5V3VIiLDCcabpFRdKRD2Pf8b3q7Msuq8iVsGBBQaQ
	qp78NzEyvVFJiRCpm63KFPf4o6nYi7MuWbDih4MLoHgD4Tb2J7B2ZTWLFZDOIBhd3MBY7sixIX7
	zQ6pX99JQOUhBKIuzZmV3oUeMdciae0UDejWtrrgmlqgppi9MBMHYGLgSZuscwU8Ktluk/vLpla
	hzoOGBEJ/DYU3tW8YRV5u6anan1mfwl/uSlNvUevRh9Dcq9eInqgIBK397axmNHX9/EEMgoGvhr
	JkYQu8t4vSR/RiBgkqa2qGb5GUNjMRMod2kdiSdNOv6VS3NI/UdtgDYLw8iAY5UhFR2LdoaQZPh
	dLbY0k+DpWhGXPACqTsaa7SdQ6fv75YUPczsTZCDHz7oE+5zZI73opXdPsShUe2TmMnZYp7P5Qz
	7+mjiKt2wNFWk8eGcgMUpCaMMdwlR4P9MHnNcdjJ2cgpB5v4+7UUj5O5wv37xlrbGj0fnivUBeF
	DOir9Mbhv0jSa4P6L+ogoE7uI2NO76yQYkQGHM1SvplsENkcWx+rM
X-Received: by 2002:a05:6000:2c0d:b0:48e:661e:8766 with SMTP id ffacd0b85a97d-48e661e88c5mr40085813f8f.17.1793721114894;
        Tue, 03 Nov 2026 07:51:54 -0800 (PST)
Received: from Lord-Beerus.station ([93.66.71.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b964desm25680750f8f.46.2026.11.03.07.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 07:51:54 -0800 (PST)
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
X-Google-Original-From: Stefano Radaelli <stefano.r@variscite.com>
To: Frank Li <Frank.Li@nxp.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: luan.r@variscite.com,
	alifer.m@variscite.com,
	pierluigi.p@variscite.com,
	Stefano Radaelli <stefano.r@variscite.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Shitalkumar Gandhi <shital.gandhi45@gmail.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Johan Hovold <johan@kernel.org>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	John Ogness <john.ogness@linutronix.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Fugang Duan <fugang.duan@nxp.com>
Subject: [PATCH v1 1/3] dt-bindings: serial: fsl-lpuart: Allow wakeup-source
Date: Tue,  3 Nov 2026 16:51:25 +0100
Message-ID: <51b4d26521bf708d7f74f0ccb49fbe515d673ae6.1793719239.git.stefano.r@variscite.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1793719239.git.stefano.r@variscite.com>
References: <cover.1793719239.git.stefano.r@variscite.com>
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

From: Stefano Radaelli <stefano.r@variscite.com>

LPUART supports waking the system on receive activity. Allow the
wakeup-source property to describe ports intended for system wakeup.

Signed-off-by: Stefano Radaelli <stefano.r@variscite.com>
---
 Documentation/devicetree/bindings/serial/fsl-lpuart.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
index c42261b5a80a..5c1237294a62 100644
--- a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
@@ -74,6 +74,8 @@ properties:
   power-domains:
     maxItems: 1
 
+  wakeup-source: true
+
 required:
   - compatible
   - reg
-- 
2.47.3

