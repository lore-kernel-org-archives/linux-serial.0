Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D083D9DA0
	for <linux-serial@vger.kernel.org>; Mon,  6 Jul 2026 19:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783367970; cv=none; b=vENLjDLkYSbAzMRUEb/ygm/2X8qQJWbxZbhGZBkkHi4uYsVm7Y6UVV2sMQ56TOtPR2PPQjfbfYTG263Bnjtn2lrBHFaYBsdQJwejbEa/uR3lKjjXGQJsE/lmKq0N9oBxVkoSviCTYcD5fVgRWFRjVlwidsPF/RjwVfqDSiJtdnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783367970; c=relaxed/simple;
	bh=ZcGfbAq4udlMGUkHha973st5OT0QKeuHdOkUwEkoq5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n0J7fpbZiN6skcUw4VII1PUz0c+3O5zXGt9f/XMpRWWmUjokqVOQ4W7xCwQay9ky2+M3Y0OEgpuuFh+64H3XD+tE5YPWAz/fE3t3EOBsUQ+MXm9RWbiZ5lT/5MyH4p1Q+0REAJgHVczCMp411SG+ycoxLecyrW/7enFZRSh2AGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nJsIkTBE; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nJsIkTBE"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7e9ed64d490so1046410a34.3
        for <linux-serial@vger.kernel.org>; Mon, 06 Jul 2026 12:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783367965; x=1783972765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OhHQ34ucfgP3gbwbph5XNn7ZzhoehEkZZGHdIdb2gNk=;
        b=nJsIkTBEdWhOoxc3JlwmBGOMm6QH6YMBIFXC74JG/YVphHxMbKrkv+CmORgzAl4n6+
         T9wFfiaSeXg8PEO7RoNzxHi8702BGNHM/e994BFTv8S1yaWgtYS0KfRr273fO5uDzcOd
         qxbZJaQbcwHG5qsRw8a/wqcLpyiyk3ACxYJLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783367965; x=1783972765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OhHQ34ucfgP3gbwbph5XNn7ZzhoehEkZZGHdIdb2gNk=;
        b=ex3oZgxj5GS3OkS/LfnkgP3uXwjDG5Ysb3OMDy8cDKc2XPtV+WxIu+8hM7awe783EF
         /fOcmxQtJtzGxr1OmlnILkXE7CxOWnTP/f0GSnvsQ2ovO+kJp8KnxRSExQ4ZO2NczANq
         6dCpOjUBDCTJVkZNSEs7VILYMMNm6xB+bO9g7vw8DINJH/GoRkangCAaEm9wC218dLQb
         lMixYLEcrkJza01G79BXyEIoIqjx6xAo23VzvniAO/z6OIBB6vxMEJIisqO6aGPMtvF8
         3J9ImvbLhg5mVUgFQnSCKz6Ry9+F3S2uFSICQFwq2l3JgEnBhuNqppGHobORzzZOnLJD
         AnLg==
X-Forwarded-Encrypted: i=1; AFNElJ+hEYLuEpoSQJLAkRz9nsxZ0RAuILLxSmbWBVfkA5wmTnrtVKlLdk1PbEaKn8vde/aOeu14pju+NF+nkGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWz6F8ZAG74xQtVComNScULdJesF2gVPRlw8jn9WSSY137CwhC
	W37FbBM1O2odbr5QwfNdb9iWef/IG1KigUZfuFgsgw6OxjzXR94kGmNyvH8ci6BiBg8DZC6ChNr
	iVGnXQg==
X-Gm-Gg: AfdE7cnU/2VuUI9409Zl541RGsBfZWi5BzlPHhLuXvSeYrhf5jb2acW0dLO41X7AZHc
	dbUJN6JowRemfrJreUtuHOH4JN1k9LAtuMkqs3w0cZVqusVdy9JZsYW8iGJwmmoaMnDJjEbuUQM
	ebqeN3aRZpT18DAG1mZ+VDKOJGqfKQfgGL6qUBI1RuXw/U6YjqY/uvKaaZw17TJ064c2grXTwAH
	/MH+E1qC3JtmkykVMALFoG+CwCRb0K77iTsWQeg5NabNN+aCCHILoNUri1CUMVyzUFeDOX5RNfH
	85jA7MBzb/az3G4ubXOUgKitEe5pIMkpi+zG5SAk6fOFrxZu1XVy7f1r/Sx67rL3xCXVjDEO2rV
	RSQwYn6mST0bhZ4a/82AbOUz05whorub4rcXiiGlt9ZZqw8EG+bIXh8YSIljkGdeEdkZIDMj36i
	+q8soAd84=
X-Received: by 2002:a05:6830:82c4:b0:7e9:fc62:1e0d with SMTP id 46e09a7af769-7ebb233afd1mr1278586a34.18.1783367965005;
        Mon, 06 Jul 2026 12:59:25 -0700 (PDT)
Received: from chromium.org ([174.51.25.52])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7eb542d017csm12161834a34.8.2026.07.06.12.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 12:59:23 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	Fabio Estevam <festevam@nabladev.com>,
	linux-arm-kernel@lists.infradead.org,
	Simon Glass <sjg@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH 06/12] dt-bindings: serial: snps-dw-apb-uart: Add RV1106 compatible
Date: Mon,  6 Jul 2026 13:58:02 -0600
Message-ID: <20260706195818.3906949-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706195818.3906949-1-sjg@chromium.org>
References: <20260706195818.3906949-1-sjg@chromium.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the compatible for the UARTs of the Rockchip RV1106, which are
compatible with the Synopsys DesignWare APB UART.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index 49f51b002879..c0d0524458c1 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -72,6 +72,7 @@ properties:
               - rockchip,rk3576-uart
               - rockchip,rk3588-uart
               - rockchip,rv1103b-uart
+              - rockchip,rv1106-uart
               - rockchip,rv1108-uart
               - rockchip,rv1126-uart
               - sophgo,sg2044-uart
-- 
2.43.0

