Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A9710E3
	for <linux-serial@vger.kernel.org>; Tue, 10 Mar 2026 00:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773101177; cv=none; b=Cv64TfWsnqDTobfVdX/HiXVQld/qapG/seVk63unaKNkU3zfBFTZ3offuUCDxcrg/swg/jUp4OmP9FZEOrLMuHpyHIiwNWZjDlTndGmuKYnQKs8sFMUhxUBfUq40AxTZxeVlHd2ekrEqinF6a35Rtgmxfj2XGlVc8sda1sDZew0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773101177; c=relaxed/simple;
	bh=ld0DrMvQU8Ko50j0hkr+b6ItAjzhfHy/8Pn0kDki4xE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iRR+hncT9DO5C8HdizMLsl5wdEB71lbauS5mOEDBHeFCP9pTDr26YxIz4C09q8VXkpnySYaVVRqIQZ6GQbGRfZB11aFvers9oH9ex+CYTPEA6wmge+iTsGCMVUyG+lm3+HYJU1kECrTFLgCqrMq3Ugf2z6qft3wRb3TLu2O2Wjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VAywuMDX; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAywuMDX"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2be1ab1fa7dso5154509eec.0
        for <linux-serial@vger.kernel.org>; Mon, 09 Mar 2026 17:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773101174; x=1773705974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TxBEXmZ3IxqnfxhtIXFBTbR62Sv8OmJlWP3djti/sgE=;
        b=VAywuMDXoCE5uJ+PX/WoiYR1TmmVs27IDG6N2UBlldTHnUBh0irmPzuGG/5dBliYwh
         sXvGsG2xw44t+fr+cFs5So0W949lYBdHy0lFcVZb8v8aArzwGRUBLDctrMaRGpCURLkq
         DP7YN3ZyJcYcyBlR8KyTl0bDeqTSXX1GjtHKccTwwUbI6LZEFtYKdhQbSLIRkHdCTKzQ
         reQFiffinVmx9jp0SePO4Lg/tdBzMOpKTgDS06iKsoPrCivBh3A+3+NIB82KRWh/Z8lv
         lGJyp5zE+6HnreoT898+fpeCFn+KavXT4uY+LBLR2Sg2nr2aWSSkAiYoqSCEsEwbrrBA
         Sgmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773101174; x=1773705974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TxBEXmZ3IxqnfxhtIXFBTbR62Sv8OmJlWP3djti/sgE=;
        b=BXJJFJYEhdI1/kD1NsfRaRSLXG4nhqWqMcA32dLlgsehPPBD8NBD5RzA85V73vwoH9
         8fnZ7magNA7O3L/JpkFlbE58wbChWASqukvC2szJmHSrh/GuMrRuSRRtFgY1Ey+wgCCa
         8VTmSt+b0OUa8yUZd44PFvcA9ctbfKR0mgTJhfuGgPj8gKLouERM+z4ivEPXnRTreOsB
         HCAeiUblW4vnSPFIJUsUzhEU3tKPJRk4M/3ijdETxM6zkRLJNUw9ZzPV6ZKUipN7oNy8
         zwGyPignA3VaEFeWakV9JC62nfRKIjec/OElgi+BMMv+BwxaPw7IfWiakcA184IIQa8P
         bePQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIbYNFO4wv8ZjYHsMzMfCf1/Z2hWdQR/l8+0SmhUR20QsptWzp7GgEBRM5LGsMKUDnH7Q7VL7DPbvoZrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZDlT/HQNFNnMa8Cb9eKj34xU720gOmBFTcgdThhyKCglteaMI
	bZU7P9mN3entdoJX2euVA1u8M2sPIYpcbN1+ll+cRoXCZH4h/f7zHmm0
X-Gm-Gg: ATEYQzzMPC5o5bnYH3NCkpBhxKpFlkytP3seDhven6QrVHNV6jKO8thYpBsbQ37iZpP
	tiFMQpGpc8dsrHK+khShjCErEcZYpHnS3GN3gaY4KFUmt/1FV0I/FdfLhyHL8sbsILTqiCSHz0s
	gnjUwQfWxiNsV4OEuHGn+kg0vkkgzozdhrW7EBkQjQdye5b1GLcwBtLuONvRqzzg8FVrf7PTzZw
	DZIy7322JIdZ2Q79AsHyP7VDFP/bKgwyzN6GG1o06N5dGYqsJoLDRQWXCOVCoVDZrpvAFDS7dZa
	umenqrkVEkHrOe2FzW+kLLEV74cQU/hGZyuM45ZuSwTeeyAiP3y1mhG5sYW1R7HiFUHJDklgbHZ
	i16dgBrLYwUApUEtDJN45yiCwNpKJ4+O0mwZvfJRwNCbIwnauK1vnFsF+PmMH886tzy4fOV/aWH
	EObMvJsE0ab2tWhy4b4UobPzO+nQXF+qxM3jLmoY3bokODTIwnwjiUdWfek/oc+b8v2Mdo
X-Received: by 2002:a05:7301:658a:b0:2ae:5d3b:e1ba with SMTP id 5a478bee46e88-2be4e02c092mr4872425eec.23.1773101174092;
        Mon, 09 Mar 2026 17:06:14 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:1b3:a802:e566:5060:45a8:d0c9:5e8d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f9836b6sm10959358eec.31.2026.03.09.17.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 17:06:13 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: gregkh@linuxfoundation.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	Fabio Estevam <festevam@nabladev.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v2 RESEND] dt-bindings: serial: snps-dw-apb-uart: Add RV1103B compatible
Date: Mon,  9 Mar 2026 21:06:06 -0300
Message-Id: <20260310000606.415206-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@nabladev.com>

The RV1103B UART is compatible with the existing DesignWare APB UART
binding. Add the rockchip,rv1103b-uart compatible string.

Signed-off-by: Fabio Estevam <festevam@nabladev.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
Changes since v1:
- Make commit log more concise.

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

