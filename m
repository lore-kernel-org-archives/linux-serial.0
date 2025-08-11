Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007D42E0404
	for <linux-serial@vger.kernel.org>; Mon, 11 Aug 2025 15:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754925488; cv=none; b=RDEPtWB22GzW4EaXKK8UhdWHwanwB2pcEk3dj62yTLUbFcD5dxQqG4/3zTzMaLwwdZP+HLOTtTDY7FeLD/VQ8kXVr9kPzfWrrfNmW0Rk5qNvsqHhD5fO0DsJ0BBO42FrweXZpfglJoyyMvoclFRg48EzbUkBi2ahiEdCI3y0feo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754925488; c=relaxed/simple;
	bh=cplGFDqmgtSpbjmRX3cAoVtjixMSRofZ7eAFWsu8/iY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LqYQNnWAFiz4KX6k4uBQM7KDQrZNsppdaFNhlsttLnPeOpPJMwK5ghOtDpJLDDjwmi8TyUr/JdW7bbsAID3XkuNBm1w4KwuGEZObmfbSc/c6k5anjQuPsiH3Bzc1fMwTeBJWp/xUv0qGV/eEmLgxIAOGNLnFscR1ehjd7FDYe6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gPErYFnw; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gPErYFnw"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6180b9e4e74so4153022a12.2
        for <linux-serial@vger.kernel.org>; Mon, 11 Aug 2025 08:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754925485; x=1755530285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gr8F9oLlUMXE4zHvyjlznjcTWEkXwUVRTFmLoor2DC4=;
        b=gPErYFnwb5l1lGHPEc+T7tH2DFgqS/lFV/3TftgpW1vnjPPazJnyGfVnE7vGJxtq2F
         0ZQ3FwD4fIu3w/FZyj36xFptt98ZC1PHWGfhyTn0X7PGjKU2h8OjHSdwocanla0MkbvW
         f8C6ifU5L7i3eBY+bysaWbj76c+0EfsSZ5G3DaNGVxP1WOszPZdgLnale9Pqqc60YKiz
         G37ZSEKVFYuYRN0Fal2v838SbFLiuouB2W8yL515BQSsxrLTxWtbntJPpV+8UHTuvXHF
         POFShPmhH7B9oOCUgZ+wlVn5g7oXxsNnI2QdGsBtiG6aJ0PAlUbqEUDEfbCGqahKSPP3
         NoPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754925485; x=1755530285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gr8F9oLlUMXE4zHvyjlznjcTWEkXwUVRTFmLoor2DC4=;
        b=jmPcsiWx06H0yWhW+uOSHx5FYdJtVnmNG1Z5J0n1anp0J4RD5dO1qzW0rbf3ZUu5P4
         cMSUJRDru/+TaVZcSl4Kts6e53WkVxZrD1iP3ARJxsbJ9bj+zrDCrJi6HSWdabEkc91r
         hIA8nD+ul2Z4l/TiyOOcqUmMqjszWAFTMIpuXD3ZJR6GL8WlkU7AnenlYfB1LVCgDgRf
         tX3IHg7KwBtnbzAYKzMVkGCLQ2SLx9i79vypv9io8Ho7zxvp9esKG946ljiWnOmy/GhS
         nO6w9FIfOcCs9iO0jUTh4aSapglHI1lQUit5rIlMQBQstckl6AD0boKCsAtrk8A5EzEZ
         0kdg==
X-Forwarded-Encrypted: i=1; AJvYcCUQx27KRtrnxkDNyMjVZW6YUaPNPhTVcqdb272h/jPXVmvlhf8Td8ri0/fCITi4GUjpY2Beu2NvXTpaLVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgyOCq7lZHiVYK+tKJDkkSppRSmg6Xn6leXcR16j9IgRJeLyef
	s7O5LDd2O7VLGPUkR5aXe1WT506OMxJ5dfnlORN6R1u1Wn25vFAfSR1t3IPh6bw3OrU=
X-Gm-Gg: ASbGnctPBp9zaMbApEcVTX278w9WOha3SIFs5Md+d0dCNaiJXvaAFdyeTW2gXjXnAL3
	pE/Nahse9VbnkYvCXAxEctwNRsYYzjWMoVcv/9r5g2hjtC7bD0QL9rypb7S2d00nRll8wrMQHdi
	nqV9ftbIOwSHYz0Xk0SHfpexzxIYSJIXxgRDzSgSTjHoO11cF1h6Laei9IT1AQQ+xAqiLR5pnQZ
	Af6Z+dILZcTlg6A+KweD79ztKhViHY3Ka0CvbFe2+efgWG6snGI4oPVErYIHPQyCAXECVFNfc6i
	nX1FSRL7+g1+Pv1k4DvqPtgd1YQcTCFG+5+H2gN4pUWpzT8Z7HaBnGGNwel7FizyS2/Tj1L1t1E
	gkRBXeMFOsXyp7asO0ysNbHz6IOuUH3JYNqgA1/9hoQK+lKawu9CrSQuxjCDrVIVInSYEfv0Qaz
	WA
X-Google-Smtp-Source: AGHT+IHY6hHjl0ohw0BhRb2M7W6IV/iJBLaLg4s2DYOzsYCD7hIoPswY0Mvw0fvinMbPKLlE+Q0fyQ==
X-Received: by 2002:a05:6402:2810:b0:615:a62a:feca with SMTP id 4fb4d7f45d1cf-617e2e9deb2mr11476569a12.31.1754925485240;
        Mon, 11 Aug 2025 08:18:05 -0700 (PDT)
Received: from localhost (host-79-44-170-80.retail.telecomitalia.it. [79.44.170.80])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a9113e40sm18638282a12.57.2025.08.11.08.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 08:18:04 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: linus.walleij@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	florian.fainelli@broadcom.com,
	wahrenst@gmx.net,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	iivanov@suse.de,
	svarbanov@suse.de,
	mbrugger@suse.com,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	linux-mmc@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org
Cc: Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH 1/6] dt-bindings: mmc: Add support for capabilities to Broadcom SDHCI controller
Date: Mon, 11 Aug 2025 17:19:45 +0200
Message-ID: <57dd103c430f1a064b6c55809e4d2be54fad0e11.1754924348.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1754924348.git.andrea.porta@suse.com>
References: <cover.1754924348.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Broadcom BRCMSTB SDHCI Controller device supports Common
properties in terms of Capabilities.

Reference sdhci-common schema instead of mmc-controller in order
for capabilities to be specified in DT nodes avoiding warnings
from the DT compiler.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
index eee6be7a7867..493655a38b37 100644
--- a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
+++ b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
@@ -61,7 +61,7 @@ properties:
     description: Specifies that controller should use auto CMD12
 
 allOf:
-  - $ref: mmc-controller.yaml#
+  - $ref: sdhci-common.yaml#
   - if:
       properties:
         clock-names:
-- 
2.35.3

