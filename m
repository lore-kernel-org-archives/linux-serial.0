Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CBC23E25B
	for <linux-serial@vger.kernel.org>; Tue,  8 Apr 2025 17:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744134713; cv=none; b=qONWd5F5jK2ddS5Xjml5BdPWu7CpiEtYVHsGzh4NswLnlefLS55wfIgDq5pGIFCAgpFkrMaBfLDvUIJmkVRHBnkgxMal256lO/kLWMw/Xz84C2Yjb+PYZQ+UG3OAYEJ/gM78+rBFRB+YheEeVMGhc9zRzUH7bKb4se7m0+oXeOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744134713; c=relaxed/simple;
	bh=pfNiNb8Fe/zcwQj8jQmkgpYm3CZKoam63wk0H25fTyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=imi1wVFQZSdHFwfErpgIUKtXUOwMOFHKQs67Bxqfu8EwWgtU4p0u/4rfCdlYNq6ci3R0pO0TJBAnlVOA2xincuOHRe5vx8jq86UZEq4QXFkYnM2ZlLgkcbDZ4/AzQTXk658BuhK+IaZZ/UmTj2y1+AJy+cec9Ea6YIDaAAZQXqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=ag4ZO0o6; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="ag4ZO0o6"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-85b3f92c8f8so528745239f.1
        for <linux-serial@vger.kernel.org>; Tue, 08 Apr 2025 10:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1744134711; x=1744739511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXZ0+VsyT3ItyrY8CgiqoYB+yPWPKWB+ae2oWOWvhgI=;
        b=ag4ZO0o61M7o/cV47ct6rJR7RnMvZyYnZK8YvTvri2+iGPVp95JX0DuBqKg2Pp3/HG
         iURoLCsYBdri1agZI3VSs0e/uThFjVo7ZJljNZEAj5afuIGUx54thzQ1xXBpMjd6Cu/A
         6FNifwFG75MFSkQKrRyU+nTy4nm5srHh8RlXGZnsLWjWGtYThzw2si6GDcNbRp+F9e7m
         +aCDKEHzozcOPuIh9UZWIJUC3ZGsqO+nZ26zgCNderBziI4KSM1ZkG/kvmDzED6bEAzc
         YNXP7nnlRPqh+bQZ09TFgcKkPqBZfG+CcxMBOdccP9/YIjPnadIVz02ABpBz7RORI4KZ
         /mxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744134711; x=1744739511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EXZ0+VsyT3ItyrY8CgiqoYB+yPWPKWB+ae2oWOWvhgI=;
        b=GnwkWGYGO1BumMF8/RkFK3kf9E22Tx9lM69jWKyc+LLqBTceWHOvIfrTno/kHpo4yF
         hbkvqyx78RQkuyiHh59DsqTQV1S5eoKYDrRtaqdLo39/6ZzvVZI0wa/RedXOMvY4Xigp
         WRtqnLh9RTRdorvDnB1ZENwAnG9AHNFk1/K8QCk1xGEJOYQRXpQr25rzZkDHAnls7Kx7
         FkkUn3+f687bT/cmrmK7EXZ6PQC8ER2rJxfahvCQ7AoM6WcNI+3YpemJ57xg8df/lWNo
         f5pLdPRayXuPGR1h5mn1Ly4WBavCQByAGqzI1xk6bsvV5GOWEABoCdWZQoooWiNGGdJc
         thJw==
X-Forwarded-Encrypted: i=1; AJvYcCWSiMbWS4qYZGLybM5sr5ohTBuR7zBTyh2aLnOTSGGBOr47Ec+Hef+wBjfpD/kd5+CLv3koSuuuV6K4+1k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywymve6VxCb4G/eZTaIm4LGAQVZ6CgNvDxe7m6K97DXcMlNqADR
	EKPAJV5yRi9LlgmlecXG02Wk5LmwCAtJaHiBLGrg2L6/5miDAdkvbez2+QhCXFA=
X-Gm-Gg: ASbGncurIVqfEbJvDRX1q/Fd6Duyr7ZMJAbWaPJ0gf4zbrsLVWwyJyx8PmAx5D8FTRU
	HXhJrIil+5HpGfhzqW62L1SX3Tt+pU+qOL/+8+eEF8il1ACdIvcGRyes5HlJZm/Whbha5qx2YPe
	yLJD+LcQE1gZZqAMOopnSJGhZmPCozvKQExNsWT1ZZK1Ez7abq0aL4eds8LpMsVA+Jzng2+VQT6
	4ZtblnURb+kCnEkRmoKDteYg82sbI/KX6ABpRCHSdIBmMwQSwAdeqVwq8DhcxWkW0Ot/gFj7oLL
	ipih06d/RrOAtQX17hrekvpXZXzpCjkAkT7u037lFhlNJU12O5QJlz9N35/Do15Ku48OY5nyLYL
	bKvcGj4Ztyj9NCBvx+ouITfl9VhYC
X-Google-Smtp-Source: AGHT+IGVxxwmqJkqflwzOHKjV4l4VlvMzZwjLfYihFRtDlDdDH3ptiChk4kVDxgr5Yqkd4y8bj8J5A==
X-Received: by 2002:a05:6602:3995:b0:85b:601d:dfb9 with SMTP id ca18e2360f4ac-8616118207amr9274439f.3.1744134711088;
        Tue, 08 Apr 2025 10:51:51 -0700 (PDT)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f4f44e26fcsm595914173.120.2025.04.08.10.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 10:51:50 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: benjamin.larsson@genexis.eu,
	bastien.curutchet@bootlin.com,
	andriy.shevchenko@linux.intel.com,
	u.kleine-koenig@baylibre.com,
	lkundrak@v3.sk,
	devicetree@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: serial: 8250: support an optional second clock
Date: Tue,  8 Apr 2025 12:51:42 -0500
Message-ID: <20250408175146.979557-2-elder@riscstar.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250408175146.979557-1-elder@riscstar.com>
References: <20250408175146.979557-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SpacemiT UART driver requires a bus clock to be enabled in addition
to the primary function clock.  Add the option to specify two clocks
for an 8250-compatible UART, named "core" and "bus".

Signed-off-by: Alex Elder <elder@riscstar.com>
---
 Documentation/devicetree/bindings/serial/8250.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index dc0d52920575f..1adf935b7f36f 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -135,7 +135,11 @@ properties:
   clock-frequency: true
 
   clocks:
-    maxItems: 1
+    oneOf:
+      - maxItems: 1
+      - items:
+          - const: core
+          - const: bus
 
   resets:
     maxItems: 1
-- 
2.45.2

