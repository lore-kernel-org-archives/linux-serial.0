Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB050187844;
	Thu, 24 Oct 2024 06:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729750894; cv=none; b=aAV52ip4xB70tjPJViQ1VMxONGnnZpNejrKIP6HcHphxsoysHlP6M1CWGVsJivu2RtzDY4VyKDc0FOnZyqxPVuatP/RE6siBZXohU0+ZAJDH6Hr3hiohvv7+McoOT+g9jJ5O5mmXa4C3vs26pjvq6rR4KCo+quhp4kmLvPTN2XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729750894; c=relaxed/simple;
	bh=SAL1ZFOKz54xkX7if3nDHhZBFUVe/vx27KllaIc9ORs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pDLgI3RAzQdhbd3xQ/YeDGNpixxotBHF0Uj7sGLhKh/LX0o2oYL8+5ELMHuKv2VM0u2dxzB9YGLkr+WjYmcmwchVxO7KfeDcqzivOGCl9pOdLxp2a7f2sYq95GNosXHgJZG46jtDAz3PudDuxMhBHakX6jtATD7k0WRD0GhNU/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mV3wElXn; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mV3wElXn"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7ea8c4ce232so424783a12.0;
        Wed, 23 Oct 2024 23:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729750892; x=1730355692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fDgtB4TxYaCxnBhpqg+CpBKlIVuputp4+NjyIq5WWQE=;
        b=mV3wElXnQadwz+3jpohr7LkXJPbrMCnOttvZhZ5gVkkYqOf8ieMvRfzAvGQWrQ5h5u
         cH9xWFZIXe0ca9r2SWZ/MGamR+3L96PJF125SDmsIK6cTTjCVKPUW1T4Wh+e9qNSo8M/
         9i++fzWH0o62syTXV8DGBvGs5BEolGBTuCxPM/TYTpZYS8wdo4NTLLTF/7yXHB6WCRo7
         XZVFY70DqEuAmQrzy8ZY3gnb5dNiiaeGE1gmv6ndzBbhiS0S6VVQT05D0ThEj+AilXRz
         S6Vicf2QDfxbbY2L7X/sDvQDhzwi0aKzVEJT7y41zq5xXC+0nLnUdviy3Odw9kUZ0/Mk
         qj6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729750892; x=1730355692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fDgtB4TxYaCxnBhpqg+CpBKlIVuputp4+NjyIq5WWQE=;
        b=Uj0JIh/3iZJ5FmHJ7+2y+/Waj80JOyZEoiGWtlDwvrZwj4+ixNWhIk6yLSSdeQIaRl
         1ee1aZwY5mYOo49TKFynN38UiuAgYnfHrP8+hfBet0TejnTVYGS8nJG1tGTTXhHk89vM
         iQEFSHGsJTV/ArAG7sWztZMQnbEtPfDG4WwkQMWspsI66fo9jxtU8RVoO5A5aTC2Dqxc
         KsDqsh0z6KQxKLIeE+nrWr+hFpuqk9c2tl2Bk9O8H2zW+kdNXXn/glGFSONOT9xvJibs
         4sjhnm83HL/9z+ywS8lvnyFjIR9vJ+rfsvmx4FGjK6QbsMgIiHFseBLs9Ebyblji3mxS
         CkkA==
X-Forwarded-Encrypted: i=1; AJvYcCW5NjShFwMebNsXjvaadVcSoQigbi7s97WKLizYyR6mUQKHkQMCTivNUJ4FzqYYPamEcNivOi+2fnH/iFx2@vger.kernel.org, AJvYcCWyVHfU4nqlBt8ifEhbeHfezSSwPBTQ+bDpxRoS1GXR32A3x9kDc5844NglT1UWedieJD8M8laLpOpP@vger.kernel.org, AJvYcCXAXb08ebHWJBb79zGW5B4kQY8V/V01Q/FcMCQZ+kj/Yl6IoFw4rv1RJtDH46a29/7+5nGjru/a0dInKsvI@vger.kernel.org
X-Gm-Message-State: AOJu0YxawkefnxOFx2SF7XgFyMW4vNLJWNLzDrnszC3oeaY0iMC4zc4P
	a8SK/1u86XfS8BtyXGukgkQ1u7dStlOFSQ0sMpcUx9s5Ac5f6kq/
X-Google-Smtp-Source: AGHT+IE931KoYITeAlNOY36KyowbgknJ2iPC5xPTo043o9G/IoVNLfyPn6c0ijnCAxbiXijJANsByw==
X-Received: by 2002:a05:6a20:c793:b0:1d9:23ab:470 with SMTP id adf61e73a8af0-1d978b35328mr6450483637.29.1729750892094;
        Wed, 23 Oct 2024 23:21:32 -0700 (PDT)
Received: from localhost ([121.250.214.124])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1312df0sm7315711b3a.20.2024.10.23.23.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 23:21:31 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	Conor Dooley <conor@kernel.org>
Subject: [PATCH v3 1/3] dt-bindings: serial: snps,dw-apb-uart: merge duplicate compatible entry.
Date: Thu, 24 Oct 2024 14:21:01 +0800
Message-ID: <20241024062105.782330-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024062105.782330-1-inochiama@gmail.com>
References: <20241024062105.782330-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each vendor have an items entry of its own compatible, It is needless
and can be merged as it share the same base "snps,dw-apb-uart"
compatible.

Merge the duplicate compatible entry into one item entry.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Suggested-by: Conor Dooley <conor@kernel.org>
---
 .../devicetree/bindings/serial/snps-dw-apb-uart.yaml   | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index 4cdb0dcaccf3..c104bd8446cf 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -37,6 +37,8 @@ properties:
           - const: renesas,rzn1-uart
       - items:
           - enum:
+              - brcm,bcm11351-dw-apb-uart
+              - brcm,bcm21664-dw-apb-uart
               - rockchip,px30-uart
               - rockchip,rk1808-uart
               - rockchip,rk3036-uart
@@ -52,14 +54,6 @@ properties:
               - rockchip,rk3588-uart
               - rockchip,rv1108-uart
               - rockchip,rv1126-uart
-          - const: snps,dw-apb-uart
-      - items:
-          - enum:
-              - brcm,bcm11351-dw-apb-uart
-              - brcm,bcm21664-dw-apb-uart
-          - const: snps,dw-apb-uart
-      - items:
-          - enum:
               - starfive,jh7100-hsuart
               - starfive,jh7100-uart
               - starfive,jh7110-uart
-- 
2.47.0

