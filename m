Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFD8260A42;
	Wed, 12 Feb 2025 23:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739403655; cv=none; b=cEZpS0vUgi7j7dgUSmageVzCnk19vFhEU1TGIb13UgHhgSE/XEb5i85dVHeXUezjmN1pLbqcmnJu2fYfdW4H61/6sS2aNAgZ/RAy8m1Ga+4zt9OR7zQkNycN2M3jLk03YZFgmyWiOi/k0zl83/j1dmwA+aQgvTzSC5JHbx248dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739403655; c=relaxed/simple;
	bh=1BzRsGRJERy+OuzGFX13belr09V+/dsAjmoTN89CF38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sal+sw0jtCu2Gc3fcz31m8iXyMwnfogqgXAVueWmBdwV4rDFh/apGdn052gDqM4bk6dTbF6z1wNDBUtP4oa9vZ/q/03IKG4nstdWI2d5r5yUw0MvUN2+/RZ2bau6F9/Q/p4S3WSAb+AT0cPmoFWVZQKBK3oNGJ5IW/1YC1RXDvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d1KaVtT4; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1KaVtT4"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21f710c17baso3972045ad.1;
        Wed, 12 Feb 2025 15:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739403653; x=1740008453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wciJYnr73z5wvVJef6M1YVVBFJceLq6/8hy8xOSw9Uw=;
        b=d1KaVtT4zrcQfKADMzZyEiaqjVY2B5Lzlfn/28BM3gHxlAVnGvb1rPTtgFitFhqhhx
         4kEzW87GGywYA07KpvhKCCeucS5IY7gtBtyxu1bDW5QlL7hTTLlnmP9mWh4QIS+qAx0S
         37l8d3QLpUR7BOPr1d5AEkBEUYqvmJsM3T9lX0OrGrgqx0P8Vrn+ZamAEeTcLNDmXiRL
         wYOYcRhIjsoPJvMcSyscpXVEobLDDAuzsJZeYCb2hcVCbCu+ZsTXEOvtFiEFFYu10GeQ
         VYzvtO7J3PVMmdkGXhphcX5t/PlprMaUNKqJThgh9ipZ9F6Nmo30nVpgPCqCcsd4QqOH
         HV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739403653; x=1740008453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wciJYnr73z5wvVJef6M1YVVBFJceLq6/8hy8xOSw9Uw=;
        b=Sys5hQf3AdIbMY/q/YDKxipsYvp4VHCxOMrBBSetCskQL0kY9+ptH70LEWNHyvHRe+
         xTlPy6evFhXjx7/jbS7v2pIxC73qigCU0lQkE0toBb1U2oOxKIAJI2fTKPPV287n1yBq
         +H4iMl1X2JxsxYSIsTDRwuDKyf5UvfW70GRoNfA/L2ExR1ue1JIbnJyE5EOxdBFKqcle
         isduEgGDUTZEEhv/DvRDe315pxuzJyMXt9Ej9dvcITjQOa38bcSBeoHzOtoPU/+GwmbK
         /SwGLFJBGnfkddG0vP/gbov9TWXrvvzXB0/kE0GyWL+CQ/qFHUnsE36/UTdauvrylK7b
         Xf7w==
X-Forwarded-Encrypted: i=1; AJvYcCV3bRr5wa0J11VYVymRVa8Oi9H29TuNISdCYK9YAs9O+oyI0GXvaA5+fwIjaBFbHKdMA1kN2MUFlUhZB5vY@vger.kernel.org, AJvYcCVc2ya7k1Ih+S4D9dl+Y6Gj1g2XPoF9GYx/NrpMShsR6qudWB0DoDj0kTtTbYBvq/cXmIo4GytMRsyZ@vger.kernel.org, AJvYcCW9e3aMNUtXa5sIdp4jwx1Zgp1iO3NRaebHZFjMNU2OknlN5hToseTVf7zPmfFkkI1rTU8Bd0vm1czZ31Ak7KveiFk=@vger.kernel.org, AJvYcCXCTpXFxIaNnU4C7YPXabVdJdOm9ZQPzXEqEdgF+m8pHaAOPiOsbRKoqSZ4nAbUJBxJOH2lPDUcG6aGFuyu@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd7eS0Q9A0jb2M8WQBfIA51Y9cy8YdtMKXBN1WKsHIU7SOQfsp
	5amnYWdtswhPpGtDi9NZ3nMAvVyZ1iibDOxWRGjp+6tixIyjF1Ig
X-Gm-Gg: ASbGnct1hlLPOq9iljl1yQzjzZVbY64ZqfzxpItyHfLV9bDxgZ6xtanLeqLHVfiElIC
	G7OSAokBjZpcgPkh8urE6NaRJXzHKr18Vq1yUKXojodP5VEYSjc9/vyFdV3uw9zis0oXWVFSgwu
	H9uY9pu8LVCO0/Icsfg/xGgemYP0a89mA3rQ9c46ijiar9M2CsnA4YCHCHA81dqpeh/VOsQwGbu
	ik0YQvBvkE5w9Wl1/5FsRm9NUsy8EFVHZN+YLFOrEIcfQPr9kQUWXF2X4H8s/8ukcYd/w2Gwh12
	+AAeH4MqDO/uLrvtXYF2DMW8bJ1Tlt05Hxxy91UuYMwr+NCrQjUniODrOBS0T6MnfOf7GbfCY7l
	C6g==
X-Google-Smtp-Source: AGHT+IEBbMGuIkaDTqoOxBGRTGuBbS9VbBd2kajgnwpjR9QNqDwY2rDkejN/mIMWNeUS+8/hnW4ytg==
X-Received: by 2002:a17:902:e850:b0:220:c2a8:6fbc with SMTP id d9443c01a7336-220c2a87656mr60192165ad.34.1739403653473;
        Wed, 12 Feb 2025 15:40:53 -0800 (PST)
Received: from localhost.localdomain ([38.44.237.182])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d021sm964155ad.157.2025.02.12.15.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 15:40:53 -0800 (PST)
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
Subject: [PATCH v1 1/3] dt-bindings: samsung: usi: add exynos990-usi compatible
Date: Wed, 12 Feb 2025 23:40:32 +0000
Message-Id: <20250212234034.284-2-wachiturroxd150@gmail.com>
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

Add samsung,exynos990-usi dedicated compatible for
representing USI of Exynos990.

Signed-off-by: Denzeel Oliva <wachiturroxd150@gmail.com>
---
 Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml b/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
index f711e23c0..29786b780 100644
--- a/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
+++ b/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
@@ -36,6 +36,7 @@ properties:
       - items:
           - enum:
               - google,gs101-usi
+              - samsung,exynos990-usi
               - samsung,exynosautov9-usi
               - samsung,exynosautov920-usi
           - const: samsung,exynos850-usi
-- 
2.48.1

