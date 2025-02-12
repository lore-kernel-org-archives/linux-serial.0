Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C46D262D11;
	Wed, 12 Feb 2025 23:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739403660; cv=none; b=nqYgCsZH699r1F7CGbLQWFIXGFlV7Ix2csB1BqVNk0EQUdm6nxG/wu2pd+/zz3HQ/i1GPTJUw+Kx7oQ64erXWHdR0I2XNYcjqvTIFa4h8UvVSLwxCDCBr/WevKgd7yatZLzN9DC7sy8r/gp8SiUsUmARRdivVj5WEWUemVNntC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739403660; c=relaxed/simple;
	bh=viwrM3yTRbsf+fJEgUfisjU26pUXf1A5OuxFwM13wQc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VFD7RT5f08h3bDq9nc58/cJ90AsBBijEM4in+21O/ZqAKzNt4EGEF/jQgBy6O51otYy3LsWZHooVT3TLfvMVrVVxTC7TaSgUJyUYIopiAnMbSD0V9NWgqWRs7SFDkK3AM3vlD2vyCyFSRQaUfu3aplFc6beEymnKsdQRtEQn1yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EnTtRwlE; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnTtRwlE"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21f62cc4088so3595125ad.3;
        Wed, 12 Feb 2025 15:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739403658; x=1740008458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XTqxdDwhoyrkk0ykc+A79xarZygYOcQGT3XPrS993bw=;
        b=EnTtRwlERNkcl2XZwmZbTOvrBHd6EX3baamL/2Qob9OSTnhvGe6nTTTDj66y9VEbWn
         7CIJKmP9kmSpDkymV2RHAlN7+x3NcQv4VKZIgViQNpM2f8pyH5aleNdSQt54tmkHlN0h
         7Y7UYueUjBojcGyGE8xOUNK7BiEfsX38svb3WZ3wMqN7E/wawrEFSMW49G1WszeFBY31
         AbNzmDdRg77sj0fFBMhRHudJzrU5N1pXGeZOFGkMagpEEPO1Nm0e0LHVREs0oM2tLdBK
         Z7ozMMwTxvQFYSYKsYCgy1xcdcFJX688hpZ8+VbEgfrRDDt2iPY9Lrr6RRRW2VjCrkPB
         uoKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739403658; x=1740008458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XTqxdDwhoyrkk0ykc+A79xarZygYOcQGT3XPrS993bw=;
        b=b4upVZfWAzHN5Em3VLVP/O27IEXMVqlHJ8ntmhYSbdVfkqdhW/NFfC3ftR5/7Z3PfP
         2yo0eR/oSHAKqWsSqu9e3O6SGDefuiMNUpri5it5w+9O9dFnlh7AuFGdhX/fpx/2Ra2u
         J+1bqC1bn9EzsaHpFChEFfI+VYPgbzqf0qY/A1iBcn0mtdkeZIvYGiadG7Or/fs9eRio
         bJXcZRpXSfb8Qh+IbG7BmudFn1iuvFRAQjVAhEkXJ0puuyooaMZIzfuxFnGhv4Ig08o0
         NOVCdXIhJz9ydd6QObtqfQ24fm9ti/jIjsq45fn0ucT08eJeJbJuk1xmyQNbGv8SzCA8
         I7fQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBUW4w+GJZ0cGUrlxoz+NYl9m6rOPfGOWCH035lu0gdyofpdozlXsia2VjHKxJ01iZzL6Lk8LE++2qCcVci9ls8+0=@vger.kernel.org, AJvYcCUlxpd6pk20I59ft17UeNX684uOG9FaFUrzHABBld79y47thvJQDYZk7sT6lmbm/h6vN6+Lmk2TTwXUDkbl@vger.kernel.org, AJvYcCUw/D9OTycnQIOJ5zMCiZHKFDmGz384on2+AUHV948MoNl1hW/EIgcar7+n4/UyhBMsOxuoiyZVr9FS@vger.kernel.org, AJvYcCXVdNWf9wlA0L4ZW+BGax07c+AEfFNLIBI6SC0ci4hWg1N1GuWkhwAHIL1w4zkNZefKvRhfOhWl4SRTOQfK@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6kr2nMssi4y/3lrylsKt4TQwajnXllvsRNtq7wbXs9Q9mu6aA
	rsSuie77a/10+Z7AHcedE4MjiNYeYmAWmZhA0kpuWviVPYPDFDn3
X-Gm-Gg: ASbGncujIH3ob0Oc9N+mAgy5XPyLHHxELTSDxzOpocjNKvDs7jzZ/GM/aMoFv0kS6hz
	FMc0fUmvu4bsUtIyBAU5oe30PSF0bfa4PPzPZNBqBX+o2CMlc7fxTpjZZKRZ00XwhiC22JuDhl6
	IpkBH2jr9fzEnvN8FbSEVdz0iONn2AbbPoR6Eh7qqvAtbbtQ/utNANiUT2VtuxcxsywN+jdSHuS
	QAR28akRGqPKcKn4axwfL8uRFckYNZppBAslxc5uaw3SrXLPlmvORo37seQVp9oTE/0gfIyBFsv
	ptbcdWX9luLw9crln/qDBH31SO03w5Nrmnf8MEWoj6BXp7bqw00fLgn2CSQgpHUqg4qmKtobePU
	rVw==
X-Google-Smtp-Source: AGHT+IG6x3yXfU3f1EnojPK/KNZbA3fqQ9DGcNn/oJNuX+crs/iAAqwec3I3G8I+oShWxVuS92ppQA==
X-Received: by 2002:a17:902:f706:b0:21f:7964:e989 with SMTP id d9443c01a7336-220d2368b12mr16223855ad.52.1739403657662;
        Wed, 12 Feb 2025 15:40:57 -0800 (PST)
Received: from localhost.localdomain ([38.44.237.182])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d021sm964155ad.157.2025.02.12.15.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 15:40:57 -0800 (PST)
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
Subject: [PATCH v1 2/3] dt-bindings: serial: samsung: add Exynos990 compatible
Date: Wed, 12 Feb 2025 23:40:33 +0000
Message-Id: <20250212234034.284-3-wachiturroxd150@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250212234034.284-1-wachiturroxd150@gmail.com>
References: <20250212234034.284-1-wachiturroxd150@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add samsung,exynos990-uart compatible. It falls back to
samsung,exynos8895-uart since FIFO size is defined in DT.

Signed-off-by: Denzeel Oliva <wachiturroxd150@gmail.com>
---
 Documentation/devicetree/bindings/serial/samsung_uart.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
index 070eba9f1..f38be8e95 100644
--- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
+++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
@@ -28,6 +28,7 @@ properties:
           - samsung,exynos5433-uart
           - samsung,exynos850-uart
           - samsung,exynos8895-uart
+          - samsung,exynos990-uart
       - items:
           - enum:
               - samsung,exynos7-uart
@@ -42,6 +43,10 @@ properties:
               - samsung,exynosautov9-uart
               - samsung,exynosautov920-uart
           - const: samsung,exynos850-uart
+      - items:
+          - enum:
+              - samsung,exynos990-uart
+          - const: samsung,exynos8895-uart
 
   reg:
     maxItems: 1
@@ -162,6 +167,7 @@ allOf:
             enum:
               - google,gs101-uart
               - samsung,exynos8895-uart
+              - samsung,exynos990-uart
     then:
       required:
         - samsung,uart-fifosize
-- 
2.48.1

