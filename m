Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB4E190697
	for <linux-serial@vger.kernel.org>; Wed, 10 Jul 2024 13:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720618159; cv=none; b=XTiLO0HlPgVvl8M6iryQWx4mCXBGM4altUSxwgPOTXv0rlTvfzwld+Ai+X3WRFp+T+VgiVq45MGwohzpPwPhzfiM9bmzFC/GOv+tJn3OoD9oRfD11w/IeQUTNQ3uA51d1ABW/wm3AUVn52jmh3lDY2MVgRm4iM1QN0jog4pRS4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720618159; c=relaxed/simple;
	bh=hmDdPq+Ml7N5KSGIoFc3upULiXo/C6/HEWo6DoDhM3g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GdK1i6mNBpsegEMYPGg2XF6vRn8k5Aa30W+PvBxCErWi4MuKgRF8sFf5DuhlQ9QvKeYH3Pet+5H+pYzkjveTQCHv6YO2jWpn6n1ImEsN+0EaBPLuUprgoLfTKS+Uc7mG916E29vFWOCfknHYBZFxw9TLBlc+di1x7I7wideRKf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P+eqcgPg; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P+eqcgPg"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a77c0b42a8fso127232766b.1
        for <linux-serial@vger.kernel.org>; Wed, 10 Jul 2024 06:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720618155; x=1721222955; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fqkUDQRLOhVOBxGwhtG+94Ov7Hs2ibJxuA1/lSFMk8I=;
        b=P+eqcgPg8DN7B2J1lsAezXzy7DoZV+BbKEvMt5gR570V2VqXnvYylJ+/0zwEt57OAf
         9s51H5Zc5t7r8JWDjuuF4pCJU5hsaTzPxle/5fSm4MV9zRCwYEO51FiBvvpj2nAbTp80
         wQfkp0+2uscnFvcH3MD/wBC7AsoVUgO+vx2L0E/qM+fDkcBIqa8Wi8exYlltqhJOaILC
         eKA3f/z/cVcp8dZlwBdxLb0NniZYevZVC76TOYa51cZ/tibUQO3hxg0+ARZwZEVpz1Zo
         93IY50Mi9JQMwZqqEfBaM7j84sXetO9tTGHShf+HP3Tv+Y1XHuSu6hwgtK/Kw7EmL9Vu
         PFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720618155; x=1721222955;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fqkUDQRLOhVOBxGwhtG+94Ov7Hs2ibJxuA1/lSFMk8I=;
        b=XzH+Cj+i3pd0r280DeydbiMbVBxBPszvoZfTvnrvkX/1nt/Ybd23svSsN0deH4d8VW
         4n+fxTkwiuqkV1SBFTFWNqwcQ1c7lzQF3Fuhj4ikLm0HfKJLpGF34HcwCSPi25AooAet
         OqAary2odC6urOAQG5XM4iCidkfpkkWW92ga4YSnEHq5/j8+qc7fo8bMdMDGKBeRkBaw
         20Zy0J3A7pDYjwUpOSqRw4ne45zbgs15rzt0Rg65BvFfWWhfhyC2qCNb0EKuKT7A6VGY
         bZW0B80ga6v6+miQv18b6JnvMVvYojbG6TByqLqnZtPqbA7I5NqrDM2JEO8QymBXHwbH
         wUHA==
X-Forwarded-Encrypted: i=1; AJvYcCVOFFPAM3rIoeD/6/eyLuy2G5OWm5c84lpl2Avj09MznHix6jI6qvf6ERFwi8qhToRNXN1pS/jT7ESQUiKx1B9Qxyqb2jb1ujhXxnNm
X-Gm-Message-State: AOJu0YxjfkX61iCio5KnEkz0QMJmlFs/yUWTfmOGj6ZrtMZ95WrLGdph
	XzSF4KUh5NlO2AqZS9oGwelACSE/kJHFx6e0cyeIyaJ1fpV3AM2AypJ4iXH/ZxTQ0TBVQSCVRnu
	XGtY=
X-Google-Smtp-Source: AGHT+IHSy01Wy6Dt26CFpsV4fBDVFgMdKfVhr2nI8OmMjxpgSQCjsvn8YeKN5v4jdEUlosAgoIYCfA==
X-Received: by 2002:a17:907:9710:b0:a72:4207:479b with SMTP id a640c23a62f3a-a780d205cc9mr468422466b.5.1720618155461;
        Wed, 10 Jul 2024 06:29:15 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bd45a162sm2204844a12.68.2024.07.10.06.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 06:29:15 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH v3 0/2] gs101 oriole: UART clock fixes
Date: Wed, 10 Jul 2024 14:29:13 +0100
Message-Id: <20240710-gs101-non-essential-clocks-2-v3-0-5dcb8d040d1c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKqMjmYC/0XMwQ6CMAwA0F8xO1uybojoyf8wHioUaMDNtMQYC
 f8u8eLxXd7ijFXY3Hm3OOWXmOS0Ie53rhko9QzSbnbBh9KX0UNv6BFSTsBmnGahCZopN6NBgIp
 iqH1HeOfabcVTuZP3r7/eNneaHzAPyvRPMXp/ijWGAo9ldcAACJRa5aJVso+Ml0kSaS6y9m5dv
 5yNNMCyAAAA
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

Hi,

This series fixes two issues in the gs101 clocking / uart handling & related
device tree binding:
1) the binding omitted specifying the required number of clocks for the UART
2) an incorrect work-around in the gs101 clock driver

The 2nd point is essentially the last remaining patch [1] with all review
comments addressed, from the series [2] that was sent earlier this year, see
lore links below.

As requested, I'm also documenting (in the binding) the hand-over issue
between earlycon and (real) console driver that we have on gs101, see [3].
While doing that, I noticed the omission mentioned in point 1) above, hence
this series.

To avoid confusion, I'm marking this whole series as v3 because the patch to
clk-gs101.c had been sent as v2 previously, and this supersedes it.

Signed-off-by: André Draszik <andre.draszik@linaro.org>

[1] https://lore.kernel.org/all/20240130093812.1746512-6-andre.draszik@linaro.org/
[2] https://lore.kernel.org/all/20240130093812.1746512-1-andre.draszik@linaro.org/
[3] https://lore.kernel.org/all/d45de3b2bb6b48653842cf1f74e58889ed6783ae.camel@linaro.org/

---
André Draszik (2):
      dt-bindings: serial: samsung: fix maxItems for gs101 & document earlycon requirements
      clk: samsung: gs101: don't mark non-essential (UART) clocks critical

 Documentation/devicetree/bindings/serial/samsung_uart.yaml | 14 ++++++++++++++
 drivers/clk/samsung/clk-gs101.c                            |  6 ++----
 2 files changed, 16 insertions(+), 4 deletions(-)
---
base-commit: 523b23f0bee3014a7a752c9bb9f5c54f0eddae88
change-id: 20240430-gs101-non-essential-clocks-2-6a3280fa1be8

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>

