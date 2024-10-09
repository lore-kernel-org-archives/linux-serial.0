Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A491E47A3;
	Wed,  9 Oct 2024 23:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728517161; cv=none; b=HsClEhvd2g20QPCzor+JkU6vr6ufyhWxoZLG9w6ZRTkXyefhk9xdc8Auy0SV1H7Ar2wbZXo2gToJ0iTVmakyaB/Fqerk6EuNCrTPWS/mZ+zoJ8uQ3sHSAduAJX4RL5XZpLUBzjGO3stCAmAzzIuSuQxsOjDgWkoeum2mASOjx/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728517161; c=relaxed/simple;
	bh=VC45h8aiDzuQDLFCpyW7Ug1PcFuXNplx30cyRjsa3SE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cm+/H0/4oW6DkarfU9ffob+5vWpEhzGLJIFbsM/19tbBEO7St6TtOriPcA1M7t/ZIoMCD1IuaX7CsKd8Pd5+PtUZcddk9f44U/eC68n6q064ZZy8t6jxeQfsgqfLxguvqC328jY+e8OM81NjMYXZiTeA8TiSNV/GWS/A9nRysrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNaA5qdB; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNaA5qdB"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20c714cd9c8so2199305ad.0;
        Wed, 09 Oct 2024 16:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728517160; x=1729121960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XS6nHTs+CYu3MZQvLET0ZTJnGicnj+J0x9QOSJ0z3N0=;
        b=XNaA5qdBdWjvO5cu/5paPVYyBc4bvUypSgPdJxf1vYc/nrRB49Q6RCTUD5mI1WrSim
         /386TgK59Nxnp0cR+82qu0mMPdffzldc2C8ynWZKGqbuWPr01RRtxsbM9x6iS5vaQ75I
         hPfvAzkeVGpkuBHx9FfM0mTF6z07Uq1+xXEi8ij8eKJphlkQ5lmvRIyFpQiOVepmCXwX
         /UImXhqYtE6jYD2+BGv+7sreNBnrlmcmj4sJLHSr6NS5BCkYs9xx+fFTzhtq5zl2kwvW
         gFlgkH9C1nfW5bPuGYLWJuwZkI/j1MGQSSTP2YkkejVXSV+9vpMZZL4UoYFXrXdm0q0y
         UR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728517160; x=1729121960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XS6nHTs+CYu3MZQvLET0ZTJnGicnj+J0x9QOSJ0z3N0=;
        b=cN2QQBuxVp/SsGHgr+597wR9q/ZNus6vXCF1U5BUiI1T3RgUoM0i7Sd8wz+UnHtZ9q
         szkIiTf8g8M4uV0lZlr4Gih89xvO9Q9ojNRX9Xqb8TJW9/Ex/xA/LdJJhBEejrFwjyDg
         yYxh0jU5hLa3k4OsNAJiw/hiFNisNSkP6HKWB52Dki1146c+rGFjCA0RGJzsr5LQMRXK
         N0+twl3Avkjy2gDsX7q02NadOO50wEvSRNj0NchQ4krFQ/1tdsNAVRr/jeuFFlAiCHXL
         4jehlVnIS/DuIA4Vw6G/w0wMzI1kQQDDk0rGSVajyr5PzECo7iHUnFqEcLTiB3P9I1yf
         zBZA==
X-Forwarded-Encrypted: i=1; AJvYcCUP1OrfjVBgMEkov8G/Jd+7PzT+P41gIyef3o3EaixrKtNrMEwiz76RiN2clEzARD05Bs087M9TS0EG@vger.kernel.org, AJvYcCURux4hKrHxmCu44lFzyEYDdZJVRDpD3c58pCsOjE2a+gDCzP4ISQo+wRBufVPwoUw8HHYzFuGqt/nDKY6l@vger.kernel.org, AJvYcCWvuMFMXZEwymlr4RpJmMQFmgFL1GL+SZPqa0oCRJMl5u7duVOlS25MnXvkmwYXPff9yP6g8aCpPEsVlIup@vger.kernel.org
X-Gm-Message-State: AOJu0YztJQginOPJ/Tlli0ComRkh0oC18MgFzEsI3d7C1GeLHuSENaFc
	qBgjRzpe0YQ+OaQB+UmewkUDnGvttHkoNaa2uyZSBFCSC+i7v8NH
X-Google-Smtp-Source: AGHT+IFeHxDDWwtM44WoFuqKZw1OrZKNaBo67+5TxpVcropwlCeMJk5C2dzNNCX0vmLdD+IA0lAcIA==
X-Received: by 2002:a17:902:d504:b0:20c:7d29:7280 with SMTP id d9443c01a7336-20c7d297486mr25667025ad.22.1728517159680;
        Wed, 09 Oct 2024 16:39:19 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c7b63fe01sm7230995ad.298.2024.10.09.16.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 16:39:19 -0700 (PDT)
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
Cc: Yixun Lan <dlan@gentoo.org>,
	Inochi Amaoto <inochiama@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: serial: snps-dw-apb-uart: Add Sophgo SG2044 uarts
Date: Thu, 10 Oct 2024 07:39:05 +0800
Message-ID: <20241009233908.153188-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241009233908.153188-1-inochiama@gmail.com>
References: <20241009233908.153188-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatibles string for the Sophgo SG2044 uarts.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 .../devicetree/bindings/serial/snps-dw-apb-uart.yaml          | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index 4cdb0dcaccf3..6963f89a1848 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -58,6 +58,10 @@ properties:
               - brcm,bcm11351-dw-apb-uart
               - brcm,bcm21664-dw-apb-uart
           - const: snps,dw-apb-uart
+      - items:
+          - enum:
+              - sophgo,sg2044-uart
+          - const: snps,dw-apb-uart
       - items:
           - enum:
               - starfive,jh7100-hsuart
-- 
2.47.0

