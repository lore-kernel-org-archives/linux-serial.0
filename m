Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792879638;
	b=seXEACA28QGr27Pk1+LWsJWwMkBnL1804S/u93l6TqspiQr7w5IWN0dkqYMlQXAkMY0W
	 HQUgqHPyG2MpmZYziILVTzcNKpKDNa1Qaaqi5os016EtHdpLTZD5R9pNTSmb9rZUeADrS
	 A9Sq9nWwLIic6wm03s5phv3pYbIsdoLCrdmrzoZrkllsjgCQ20cBWCQ7dzaGgtj6aWFzy
	 9c66AqF4utkJdRvditsEUQYGBrvR2VU733Qp0crcd0TIIX+cEhcKB8n4QnPyQn8zh3niF
	 Wrm4GU0TKC1LMOpQS9goZl9bVyLF/2lnc5iJJlJ7HmjjJCCng80WvYS1y3fdUCvQhHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792879638;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=tQ3jUZJIzHj6BmefEU8b04rCHYVmSDvqexKo06XbRm0=;
	b=ARiLnI+QhSbZ2SKocL2mGIdHmDY9Zj37xYxODnDQAGXQR+IFM1a5VcyaQ0UG2oHN2c1v
	 IB+o8Pn3wEz3XzBQiRoPFyM/dW+LOYLmqJpiiJQqnW46VC/QG9653ye8R4llYB+TAQFdB
	 s/FaTz+4vm9sYW9GO8Pi7BSwv3sfBxxuQ2T2GFs+Pw7NdkSZKe6Sfw+VR2u/QQ4ziwY8t
	 d4FH2RvnXkQ+i7cxmcem/v3eHkmG60z1CmRaKCCYT6lP7K3h4AbepZ/HUA6xlRB3enlIw
	 SWDDDUoAqU6SNbVm8KKonT0LnmbBj0XuHTDUudQBzeR81MlLB0wbI5PQtTATbVqy2Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=mgcrea.io;
	spf=pass smtp.mailfrom=mg-crea.com;
	dkim=pass header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=J2pjKcHm;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35AF606A326
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 22:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B35AF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mgcrea.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mg-crea.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=J2pjKcHm
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so17972445e9.2
        for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 15:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mg-crea-com.20251104.gappssmtp.com; s=20251104; t=1792879636; x=1793484436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tQ3jUZJIzHj6BmefEU8b04rCHYVmSDvqexKo06XbRm0=;
        b=J2pjKcHmpyNpyYak4hiq1SqLoHAF6XZ35w75hkj/BumakTFlBwBraSHF2PagBbWmip
         W3Dk43oauZBfj1Nh2zbRvGi5ZPCe1peDeMDB1S1xj1IBuT5Ij2JhjA3cCE/su9ELlFMK
         MiRaxrm1HSw5V8evkCV4PZLumnDDXTq8oTFpVesi9wv2CT41uB16F8mFkOWBui/lnjL+
         pWNT9PKZox+11oMfnZOO9gGsZQzPxIdAhBL3d95XUuGIW33n+n9Fu4NPXThXPSORGoBi
         O5E39mTTHrUQfoFbuhnXXKHz4DvtOBxe5/VsYbn4MBCFI3OHLKClt7luQKEnUaSCVleE
         32bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792879636; x=1793484436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tQ3jUZJIzHj6BmefEU8b04rCHYVmSDvqexKo06XbRm0=;
        b=RLN2bn+bHmUE/QROpeicf1ppqEyjiBKeiXAZoacWRGCDDZJ+WjbN6GsVtm0zQUCJG1
         P75u7HhOyZaBGkh16grDVo37wyVYMnCW1NCykE2K3GS/2oAo4UAhctxQm50BYGNWK75+
         O7ZrEN3YsidRaejUjryH4VJw6PlOk2OGWk03cv4jWFApsArmjnoER5dCVuunz/sR26Uu
         KK7ZeEFteDbEGRbL0NdX0sHnIj6HueHj7kSsyCXSjxbsRJplR5zV9oXkxIeCcdfwEF5h
         OHzekgLagOSwkRZ3vPqEmorHXWupooItb2YZkO2eNTlGCWRHkPmOOaiCQfyvMBURgmjm
         MNlw==
X-Forwarded-Encrypted: i=1; AKwUvBzbbzSGadDnNVmOtttx3SOb+Rim90/B1vW0MEp8YCXA7iTg87KM9UMmaaMesSKYSrQkCkapdAxbXC/y+CM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJMJYbljkwRbK259wUPCwpJclj0B44R5I1lCw/LnjNR8nxndi07
	MKXbYC8eL3S7UY8a3CJO1x9F2Djhyz+RTbxHP+8YjNe0/dnrXHeXz2hCPvpv8VpcB5Y=
X-Gm-Gg: AYBFou08zSmlVQMYZaZhdFUlnETKmhyJb/qv98ck+iZaWYNMhaNOjlwUzHHwz8+LkbR
	blp3auG3GZj6h6QWkCTI03C+pjBfCZF///7AwD2V000Ibc/7vTN9CnZPQPNp0orx8Qv+kDUrUpr
	dVABEn+Ha9T3pUUAd+KryKMQWGGo9Qhi68ydCMteQ9ukzec5pWGEXlGzvAP3km2vkbQN58PuQSF
	yS/lTQWNIx19XWC6/PBAWskAXwYg9OxvZaWchwEDDvcIWMxz7x0Bwn2ysKg16LEhYA0Qd8X3FHJ
	WOP3KX0kbFU0Tq0IDoBa5/5qcHLjqGm8e7snn+2nAObkYeJc6xOKUQ8py6JcYC0pRtL/XHZj0Xi
	x+lYlskt6OEWELgXdxy63FaG8RmuOwagDfKFskcnswiAM6FxMBiGub6DerNRdGT/IbRCMzkBJhS
	65v46M3eYy+8OrS4yn8R0cTAobcM48hOHkhUNiUIEXYKxL8c6luYdviE3iaQ8dYbDxTvwTtBTBC
	DSIUrozLCV9iy3Ss4QvWq0ICl4dkYhF25p3koqNtWOuVj5bfxSRMPRXNyA1q0f507zNfTzgo3wj
	uzHxOZV8n3rCsDV9XiGxyRAg3dIe7ml3NSNGSuVRs6dOjiHLpmszmExobO3pR8Hiy+vWhlZuIB5
	zJ1dkNS4qyWRNAqE=
X-Received: by 2002:a05:600c:4e87:b0:4a2:cbe:beac with SMTP id 5b1f17b1804b1-4a35aca73dfmr47824675e9.23.1792879635309;
        Sat, 24 Oct 2026 15:07:15 -0700 (PDT)
Received: from localhost.localdomain (2a01cb060184ad00bcfbae5efa3e0f0b.ipv6.abo.wanadoo.fr. [2a01:cb06:184:ad00:bcfb:ae5e:fa3e:f0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a06da5fsm53466635e9.3.2026.10.24.15.07.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 24 Oct 2026 15:07:14 -0700 (PDT)
From: Olivier Louvignes <olivier@mgcrea.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Olivier Louvignes <olivier@mgcrea.io>
Subject: [PATCH v2 1/2] dt-bindings: serial: ingenic: Add the X1600
Date: Sun, 25 Oct 2026 00:07:11 +0200
Message-ID: <20261024220712.23250-2-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261024220712.23250-1-olivier@mgcrea.io>
References: <20261024220712.23250-1-olivier@mgcrea.io>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The X1600's UARTs have the X1000's registers. Add ingenic,x1600-uart,
with the X1000's as fallback.

Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
---
 Documentation/devicetree/bindings/serial/ingenic,uart.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/ingenic,uart.yaml b/Documentation/devicetree/bindings/serial/ingenic,uart.yaml
index d5f153bdeb0d..635342d43ddb 100644
--- a/Documentation/devicetree/bindings/serial/ingenic,uart.yaml
+++ b/Documentation/devicetree/bindings/serial/ingenic,uart.yaml
@@ -32,6 +32,9 @@ properties:
       - items:
           - const: ingenic,jz4725b-uart
           - const: ingenic,jz4740-uart
+      - items:
+          - const: ingenic,x1600-uart
+          - const: ingenic,x1000-uart
       - items:
           - const: ingenic,jz4755-uart
           - const: ingenic,jz4750-uart
-- 
2.39.5

