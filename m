Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903D1426D33
	for <linux-serial@vger.kernel.org>; Fri,  6 Feb 2026 18:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770401623; cv=none; b=RltqYBB8LY8G6g2MxWn9oqud3N2NMnWsLYLsD++cTdpT7a7N4ZSLa0xS4sBuC/p08vms2eGHIp40q2V+xYCBabK7UUsse1s2DWOE+0ery7AT4nXZkRlRZEx4LT6WCecAbcQ41ywEG5/clqbjiIPDr/y8TeIFAlUNgadCZP2xa9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770401623; c=relaxed/simple;
	bh=AXvgsUCaF1FG8wPSsB4PShKdluoSIOzjC6gXHZSQCRU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J1xSUTB+noe61JwnmpkenRjmvvlSuLpJOi4OFHPgDumrv+DDCm0xFiZYZ/CeWjKHh0YS2H0TGd/JIlnV+HCH28zqhtycdtIL6AH4uUneFJ7dEaOg3P9d2wlyrpFoeKjjOCmX3Nn4ZzWJ4gHv+rSQigrKujxys6IUth73+5C30UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6e3VDxo; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6e3VDxo"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1270adc5121so643478c88.0
        for <linux-serial@vger.kernel.org>; Fri, 06 Feb 2026 10:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770401623; x=1771006423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgXGBSZoBFQqX1EttjH60dA2QMgCjVJpHFXppYJ+DT0=;
        b=V6e3VDxo9oqvdmpey8OremBBGlSIT+fRT/QQ5HJG16dhCei/k+t/GGhLpj4Oixh2Pu
         mcXkKmmpw4hZby1OyeLMYk24uLPQLjbRpQhcMEmz4yAHhVap8jisFRj7ekgKvFeSWXpP
         B3CmpAWm1i5THW7xiIAwf+jE01ZHd8mqChXRO7BylH6fBHoyq1o9GrVKXGixemVwuxdU
         bZxuPB15MrOZeeorIGRGeNiFtd10641qLs5jXPZ5kJrFpsXQiQ+KH+XoNs8cpZa9maUc
         dT7FmcDNqWzOETZ94cA+SH/i+noZRcqKXKG7xfO5gusDykTGs5QMNnKprAoaL0oe63oJ
         9wZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770401623; x=1771006423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tgXGBSZoBFQqX1EttjH60dA2QMgCjVJpHFXppYJ+DT0=;
        b=JQ51f26hzJLc2QmVchw7IZ2LV34MqAAtTM/c07JEOZngoKdFYM2n8cpSRd4jTCQgL8
         N0f0QmpIixkNhCWv3NzP4v30/bJVDCu/EO/Orcgfv/j/v1Zxu5RALrdg31x6a/fXkabY
         /4uACdgEPMBgqDxzWsoy9+92tUbIMma4KuhCm82FfIMaX6N/O7HrDM4Xo1qUDze5SSbQ
         TYc47o+/nF/jxPGL4tzYOSNm2j5u2rodvmj7tH9/YiC4qZd+hTG8MeiGDyf8xsnuq/eI
         E4LXaKtBioCku3n0IENME+ZFTbu9JYZv9XbHiMIQnOk5xGsd3blKDkgoUSS3xEZUeKd7
         CK0w==
X-Forwarded-Encrypted: i=1; AJvYcCXylhdzyUxTlQHHVCq8QMzbToqQ7xKmHLBgKbwFg/4HHdyRJQMmUFih2JLL2RMXewmSim/a01R8fnPCB0k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrs0vVnn8wCLxPTG1ioonHH4Ig2oDr9+BWSB76L2M5gMF8braL
	7UfWnF2sj2G2P/PwlECR5I/b7eM9rX7D4nnNdXAB2FQFQVZcQ/IhlWVW
X-Gm-Gg: AZuq6aLYqJHd6AlXeBvsP1dJQmTslAjDcbzhlQnH9fbnZG9nVR2y6hVqfqfEx51sPGe
	lBLsYIEMT453+yO8fBhfEUId08nJgSF3swPYOjDWYjm2rf0Ax+NkUi28dUO7hN9yxAEMg+ybx2z
	1qmUR7NKEnTvbmM7c3wc6ot3g7KTZYrPiKkLISAMCY17OGWE5gX0McMm3hZ2lpXDuk+1TE87V0N
	fb2zGogi0+Qn3kBDWq8glUHWGSJMAByyYub9TALnoBzDq2BFJNw19p1y1LWRJ1ojBDUuSMcot/U
	XmKjQwl94JWXrFWz9q+oYUpNCBrkVkCq3mFXA8KcpB1LTxqkwcBy+PsMcPDU8+up2f5TzWodfMV
	An2KEgqe3vStnmyyWdxkMoyH7gUoh+h03Psh8JkFJ8S2KDJM4LjzBfNPAnIClfG+ABtsG6Xc0wv
	n5pfySc2XvXgaZ3HgUntko+SmIRrF3VTw3rNM=
X-Received: by 2002:a05:7022:49a:b0:119:e56b:98b9 with SMTP id a92af1059eb24-12704048c3bmr1984751c88.32.1770401622642;
        Fri, 06 Feb 2026 10:13:42 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:44a3:2bb7:a035:fd7e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1270433ab31sm2782500c88.11.2026.02.06.10.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 10:13:42 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: heiko@sntech.de
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Fabio Estevam <festevam@nabladev.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-serial@vger.kernel.org
Subject: [PATCH 07/11] dt-bindings: serial: snps-dw-apb-uart: Add support for RV1103B
Date: Fri,  6 Feb 2026 15:13:05 -0300
Message-Id: <20260206181309.2696095-8-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260206181309.2696095-1-festevam@gmail.com>
References: <20260206181309.2696095-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@nabladev.com>

The UART used in the RV1103B SoC is still the same dw-apb-uart compatible
type as on the SoCs that came before, so add the RV1103B to the list
of variants.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Signed-off-by: Fabio Estevam <festevam@nabladev.com>
---
 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index 6efe43089a74..685c1eceb782 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -71,6 +71,7 @@ properties:
               - rockchip,rk3568-uart
               - rockchip,rk3576-uart
               - rockchip,rk3588-uart
+              - rockchip,rv1103b-uart
               - rockchip,rv1108-uart
               - rockchip,rv1126-uart
               - sophgo,sg2044-uart
-- 
2.34.1

