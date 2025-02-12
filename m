Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE45207650;
	Wed, 12 Feb 2025 23:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739403651; cv=none; b=kO9Gb3RPHK9n/nQknj/NhY8GiODySq/oTs/XtJKwPsKqaLzrZueG3QIhO7VocgB/k7/42nLDeKrbCnibu5BKfTyAix4sjlMRgoRMCoe4Yj6jbhWjTeu1i6oYVSPyWaj7UdueA9W8aEC1UlIYMW4UcdSdAJgUP3yiPCUo63pxhUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739403651; c=relaxed/simple;
	bh=Pd/0rcMHZmDuc0o2E82MEQ+3uXllhZO5CarU5miQgOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TclvknqVwfrq3JlNbV+tte5jh+/RE28udumKdSwwWFAU04pjdpDf0b4cPQzxl6fnAaKQabqeXtcdB7lhc7LLxq0YCxxr8UwTg576aukLtBirLgAD9LOXVPIfkXsY4AcjheZmzhwlRvpYFaxBtDEcESE8tkMsDCYymn0IM2v7is8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4eTPRx3; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4eTPRx3"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-220d601886fso486965ad.1;
        Wed, 12 Feb 2025 15:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739403649; x=1740008449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CVcFsp2axQVfidtPs1ObjaNf4Nt0uTp1iDy8yRGKHwk=;
        b=m4eTPRx3Fyd3hb1mTfro6AcQqlRKBMOH1lXRy8Gx2lfRy5FesPk4PRU/qq66WBzPZu
         QmGH9CGi2xms38jlKf3daMwwnzRsDK8GKpnQsGeW5daJmS2xnpky9CYwgOCKZkUb2e/V
         t6V2xbUa+mJWxfQiUTFh/EMh/0cPgq7saaGTQudkStRndt1Ih9ZdwmcsFL2UbgkyIf2R
         34OSzQVw9h6ZaPC0b+7QI2RAK7eGhKlJ+GCZJGGRUDQRQlSwwa/XaF8hINyNouVvWwYg
         lV/38ylaizPtqQy/cQplH6WQ+i1j+0rt76ZD8oFvHWIybhmKFybaco7xHszhdSz2IExl
         Chug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739403649; x=1740008449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CVcFsp2axQVfidtPs1ObjaNf4Nt0uTp1iDy8yRGKHwk=;
        b=s7nRMJR8WEwdNA17nmRB2v2iJsjJMbkGpysz9QUz7foBnL5qC6/TxPR/l5NFp631af
         I3GR3eZPRWj9f1aeKss2l95sMqJTjfZg63+uU0ouRTBClA1nZkS+fK//3NqqcVBQTP24
         oLH5haHFEtuyrjLQNBdmPEalB7t6IYaL71s4BBiO9Ax0yGBP9yX8EDAO4fru9tSh/HHO
         MGjJDed8SZH2VTT9MVDXDFGHVqxEham1QirT/PF1rpNuYXMf+VvMk1DxdKRrWbKfTGHO
         +ePYhGJDbBy9assbTKdJSJqU76NUW2B2HTPUNGly3y3gVCgnKcG59wIK08C5LQ+Vvvga
         ub8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVpCZV7Fc+zn5NqnpYOghEQFlb1V2pydXrckxur9oksKHbogc1wnNkKt/nyPVbYobeSbbAl0LgU0yq8@vger.kernel.org, AJvYcCVwzJcjujFtGBgARdVMj46Ib3v9SiKygbvGSG89jnUgap8BlJS9JzFKCj6kAD1YlhEicQPNIKhQAx3uzA+8@vger.kernel.org, AJvYcCWmrsTvaMOts/7iWXXvXYNf04LS48cRF/PtHcBeYao/FHIdgCtHw5JoQYcLcqYHElOW3UD0H1l4vcZzrVPQ@vger.kernel.org, AJvYcCXzZCVDPOW6a7QCuCMySMnkkunjr0nCTV0RdaA3L8mux8If2/V9yGLm50clI0bCE/5/v43Eyti5SaKlLpdsNb9aJeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI1Dtk5Q8cpdTR7bRPjhGV4H+rEv5pFh8Y5J7nNUF3cLy99SBR
	jeNMIfKFJniaXRYmCG0DzGwUlD41DtPJDKo9T04UqhuW5uN7ak1b
X-Gm-Gg: ASbGncv5/3gJ5NvSSWng4Ir/r5FMp/TLTGaEP3Sip4e4thBjCYBWIkpLviVIewZiMD0
	Oovfu96+Q2oOiH9xK4/hZbQxFoDKebUAn7OGbB9YNuMCTvJ+J67Y3ar40cgOn0cF19uVJc4avHE
	lVnCerCc0uqQ6LZ+QWsfzZXXNbkJzqWvmi65mGvR5nVTnBS56ZeKuhRNJkjXRJNMnw8IC1YMTKX
	TDJchFbTJRHjSezQIFcm74+AKYCLdnUGlN6xjBM9yGXm8M9/GToO2VENPpS/VW7TNkJuOnT1CN7
	aZ/MuJzULkiwo65WEwTbrT+lN9i+Nh3e8iS68DTbAO5kBz7ybC62jpGot3VUdD+YT1j+LaxLuIY
	kzQ==
X-Google-Smtp-Source: AGHT+IH/zoQ0cDlj82q0vi/Ewd3EwjOZ35/p6rjGR2yDCOP9SHDBIMXEqqGWFjjKaJ5OGXOOAn+nFw==
X-Received: by 2002:a17:902:e74d:b0:220:c94b:83a7 with SMTP id d9443c01a7336-220d20e9098mr14481345ad.29.1739403649333;
        Wed, 12 Feb 2025 15:40:49 -0800 (PST)
Received: from localhost.localdomain ([38.44.237.182])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d021sm964155ad.157.2025.02.12.15.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 15:40:49 -0800 (PST)
From: Denzeel Oliva <wachiturroxd150@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com,
	semen.protsenko@linaro.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Cc: Denzeel Oliva <wachiturroxd150@gmail.com>
Subject: [PATCH v1 0/3] arm64: dts: exynos990: define all PERIC0/1 USI nodes
Date: Wed, 12 Feb 2025 23:40:31 +0000
Message-Id: <20250212234034.284-1-wachiturroxd150@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds device tree bindings and nodes for the
Universal Serial Interface (USI) and UART controllers on
Samsung Exynos990 SoC.

The Exynos990 USI block supports multiple protocols (UART, SPI, I2C)
through shared hardware resources.

And also add dt-schema for USI and UART compatibility.

Denzeel Oliva (3):
  dt-bindings: samsung: usi: add exynos990-usi compatible
  dt-bindings: serial: samsung: add Exynos990 compatible
  arm64: dts: exynos990: define all PERIC USI nodes

 .../bindings/serial/samsung_uart.yaml         |    6 +
 .../bindings/soc/samsung/exynos-usi.yaml      |    1 +
 arch/arm64/boot/dts/exynos/exynos990.dtsi     | 1693 +++++++++++++++++
 3 files changed, 1700 insertions(+)

-- 
2.48.1

