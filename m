Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A721714658D
	for <linux-serial@vger.kernel.org>; Wed, 17 Sep 2025 21:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758143066; cv=none; b=JCMVuhEMhwCY7wV8IS5tRkdd3iKMM7lwYfy8KTwVED/6/e2cFMSbjF8nmMUEsqECFC+U6UU2YuzrM2SrRg9Avv/MYOqnqtq024BHCsbEYWsFmjRhL6e45u5fvQAGF0BMX0V6KbZjLRtNZxy4dgjL7pknah/sQBOzwCOD0d+Qml8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758143066; c=relaxed/simple;
	bh=yHu4BWyc9HYj0iZyDR9twQCdVLE01QwMnBaBNhjZ670=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TMtgjXDLyd1LufR1etqwCLsYs9h/00IJDa9L3bsY6FWB+NF3ime9S1KYwbTkUp0a4pBV2dPUSpqNrKe6k8ebKK9PJe3qbE5bF3jyWnH9VlqT81fvLgOyZZowTj8TpospzBv/KBgc7r0qMgzIesrjUAeeWSI2lAIvW5Y4tStlMmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hurrQ2MH; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hurrQ2MH"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-71b9d805f2fso2292696d6.0
        for <linux-serial@vger.kernel.org>; Wed, 17 Sep 2025 14:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758143063; x=1758747863; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xzsfBuCTTaW8xn6XXMC6wEsOLDhpMxnwzj4356j3YjM=;
        b=hurrQ2MHcSLbhuEylLGCXryPVJr6bWQ7OfoVbwsHEu6/jtRiKOO5ckpvMtY70L+CHX
         gPg9nUX1majHe5+mcM6t1pe1P8XkEE7H0zn51ciL4zaeOQtv97eE9MVTnu3PFxTj8CdD
         VbvRi3AqLnmq9Il7XuxJQVXVgU2ck8mFxdNpPDd4KKUP+gavkfwGBfDJwFLG3Kb9feLS
         cHGDQS4wi7i6IMhK1RKjyQeTaL803g7fIgtuj0CIVbVrnCG1Yo5W9v+kfPioWgzplBqN
         Tj+AVee1WEdPXtMLg6On72fhuHYNbTlvakWT+F4usPOh3YZ/TqVrfscE9vC7KojYuANy
         9wtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758143063; x=1758747863;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xzsfBuCTTaW8xn6XXMC6wEsOLDhpMxnwzj4356j3YjM=;
        b=D/ES9UPGVGqceoT8GW8nlBexmtZzplGiPvOO2byenU6yKCVj/xp2cfrP7wAsJiOwMf
         aFCb2cHTHkZCCPpFglP5qas+g7/DTevGvJXv0IVrn1lOzgkhfDsyDX3oKcmOIMLsWCkE
         hEOBbUjQkZy2GdxkDM1DnUonX987qg+4dYOIZ5NIpVKEbcxHXEWAsXwxu8SeadDVTAnY
         Ip7IEt1AyelEcsLmYuXDt8VwXeo36RxjSg7HolGcvU7orem5tFix4GXgGerqpGzHtXOh
         xliMW3cR3BqhDCR15YBonhSE1NTpcSYHVp6IYf681BS2dBg4mK3F2zXJEgA2cA/fY5nU
         KH+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUK2zVz2kw3lbOhTI7zmb3MJHCVkK/Z34okn1mp29CSyXAPZg4jXDPlj3+3ksatlmkYCGTVQpNW9MQDDwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY+2WboxuilZhd7lgK3if5RqmJwre6N3h09gnLWm5Jd0tw6QdV
	TYtF6vDR7pVdUJs6hqpGooxo3Bc0tRBtQ+s5PTqI/FoDItwZm2fDbidb
X-Gm-Gg: ASbGncsLuD8qtYDrf/ejDzNSS1EAYecS4sfbjPw07g8fkvgNViFsVZ9t/fVEt6AIxrv
	xdKKNIj+oNqv3nAgY+fdT7NzIcISf5FkncUsnz/FRN7Og8plw85AIUGCxs0zxBHQarSHrAC30lN
	vtnbwfWYwZxVzNlDcg5S8cSgpyoQQRPBbMXJA4Nj6uDY+Nul1ZClOtcLe2AHqrFWhkffxNeLhKU
	eh7CPLF9dAHCwKO5uhFQI0W1enlRnTdhVC9fP/cOmeqc3qsb3t98z5jX6FBiQ6KNVF/xV/F4XGX
	rKEDDU91QSPj0qHqg+ud+gcWP+lNaD1vPmlKHf0r+H/j/taO+c9apZTJuCQTYD3ATr2Pr06AJq+
	5LO8I924oTtBYNKIRY+vVnLnvYRhasQ5JKcfgHrc/6VhD
X-Google-Smtp-Source: AGHT+IHnv8inMvR0MGYLXV31f4OfeVWLDpebkI2MOQJt/N/3XFYgiGfLh+fLfc8OxfXxmx24x5Cz4Q==
X-Received: by 2002:a05:6214:301c:b0:783:cc80:1770 with SMTP id 6a1803df08f44-78eccf0315bmr41285266d6.25.1758143063400;
        Wed, 17 Sep 2025 14:04:23 -0700 (PDT)
Received: from [127.0.0.1] ([51.8.152.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-793543ffae5sm1897226d6.53.2025.09.17.14.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 14:04:22 -0700 (PDT)
From: Denzeel Oliva <wachiturroxd150@gmail.com>
Subject: [PATCH v3 0/7] arm64: dts: exynos990: Add PERIC0/1 USI, UART and
 HSI2C support
Date: Wed, 17 Sep 2025 21:04:20 +0000
Message-Id: <20250917-perics-add-usinodes-v3-0-a3629e4666ef@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFQiy2gC/43NwQ7CIAyA4VdZOIsBBkM8+R7GAxnd1sSNhSrRL
 Ht32U6ejMe/ab8ujCAhEDtXC0uQkTBOJepDxdrBTz1wDKWZEsoIJyyfy35L3IfAn4RTDEDcACj
 jtNASalYu5wQdvnb1eis9ID1ieu9Pstymv70sueAebCOEdtLb7tKPHu/HNo5s87L6w1DFMKdOS
 +uaoEL9bazr+gFSZ37b+gAAAA==
X-Change-ID: 20250907-perics-add-usinodes-5ee2594041e3
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, linux-serial@vger.kernel.org, 
 linux-i2c@vger.kernel.org, Denzeel Oliva <wachiturroxd150@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758143062; l=1502;
 i=wachiturroxd150@gmail.com; s=20250831; h=from:subject:message-id;
 bh=yHu4BWyc9HYj0iZyDR9twQCdVLE01QwMnBaBNhjZ670=;
 b=im0qQZJ8AKGgXuNpTZxbO1fV8vN+QksxCGdSj1+fa4lhBFH6jgpJF5rbT4cPHaiRoXCBhJikE
 9D0TnXZWEGfBswCkVxsXExcCfpjpXAHtau1UtSXUsuMjRQk1l9W/36a
X-Developer-Key: i=wachiturroxd150@gmail.com; a=ed25519;
 pk=3fZmF8+BzoNPhZuzL19/BkBXzCDwLBPlLqQYILU0U5k=

Hi,

This series adds device tree support for PERIC0/1 blocks:

- Add sysreg nodes required for peripheral configuration
- Add USI, UART and HSI2C controller nodes
- Update bindings with Exynos990 compatibles

These changes enable serial communication interfaces
(I2C, UART) for Exynos990 SoC.

Changes in v2:
- Remove unnecessary blank lines in HSI2C nodes.

Changes in v3:
- Add sintaxis ";" for parsing error parsing input tree.

Denzeel Oliva

Signed-off-by: Denzeel Oliva <wachiturroxd150@gmail.com>
---
Denzeel Oliva (7):
      dt-bindings: soc: samsung: exynos-sysreg: Add Exynos990 PERIC0/1 compatibles
      arm64: dts: exynos990: Add sysreg nodes for PERIC0 and PERIC1
      dt-bindings: soc: samsung: Add Exynos990 USI compatible
      arm64: dts: exynos990: Add USI nodes for PERIC0 and PERIC1
      dt-bindings: serial: samsung: Add Exynos990 UART compatible
      arm64: dts: exynos990: Add UART nodes for PERIC0/1
      arm64: dts: exynos990: Add HSI2C nodes for PERIC0/1

 .../devicetree/bindings/serial/samsung_uart.yaml   |    1 +
 .../bindings/soc/samsung/exynos-usi.yaml           |    1 +
 .../soc/samsung/samsung,exynos-sysreg.yaml         |    4 +
 arch/arm64/boot/dts/exynos/exynos990.dtsi          | 1419 ++++++++++++++++++++
 4 files changed, 1425 insertions(+)
---
base-commit: 98ee0e036cfedf543c4728a604fd7870d0000efd
change-id: 20250907-perics-add-usinodes-5ee2594041e3

Best regards,
-- 
Denzeel Oliva <wachiturroxd150@gmail.com>

