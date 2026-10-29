Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.134
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793250363;
	b=kpLiL9IcnL6/5lHvh87cXDxvv0zUQRibV32QTf5lFnNyhmG5BYeCLKtDBuQzA55oxXPz
	 Oj7GivNLDOHIIn/+7ef/t/zlYc42csbobdsxhWhfADtwNDfmE9pIPnIOEkB//x1yywgjs
	 kRq26r52y2cC77icDbDG3HzCfQZIo/KH9/Hwe5as9VIRgWffNEoZcnO4GGHtpl7+7sp6C
	 4Amu5aM7PKuZFPQRbR9hnCV51HffONIayAWUz9aoidBpuXHV5viLIywZpjLH2OafcIY34
	 GMUcsruz7giC0GRhn+BhZQN2quBlsX/Ve+h0gWbmCIelDFKCg8Pd157go/J9UsRMIUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793250363;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=D8F/HdGuSu6Gc0aayMmmYPmWYbhMQ7jikJBXSJ8mNwQ=;
	b=g5jRJVN9Ag/oUmZOs1W4LadcVTFPoRzpEIAr7yRn20hjR+3ysEMZ2BLH12GjOpSjSSSu
	 li/xx2AUMpDorRtghCf1ZjVUBvCv7Aa6Q3D86f5gamvnbpXJxuS7/92z673rEkX6UWord
	 FJfhvSJlAPv16F3WL2vFeUxNL5IbFros+hiY0+QxWAevvFgGItHgaGc6Lo16nEgrCDC/x
	 l36JOauHhhRirRrjgSzSkQGr8X5rGvO6XVz5VIF+xEgEi+pVY7aMp59XcgPMTdY66o9ob
	 QBDtofo9rQxP34dU1VNfkiK4H1i5OMhpa09KqbOcuLnHA14TykVjOH8JQY9WxdF11Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gl8ey3GB;
	arc=none smtp.remote-ip=74.125.227.134
Received: from mail-pj2-f6.google.com (mail-pj2-f6.google.com [74.125.227.134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CA2606A31A
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 05:06:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13CA2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gl8ey3GB
Received: by mail-pj2-f6.google.com with SMTP id d9443c01a7336-2e987949882so12404385ad.0
        for <linux-serial@vger.kernel.org>; Wed, 28 Oct 2026 22:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793250362; x=1793855162; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D8F/HdGuSu6Gc0aayMmmYPmWYbhMQ7jikJBXSJ8mNwQ=;
        b=Gl8ey3GBmfht7cSiQpmGNQR7xbwxpuuCKBlHrmofBx3tYVS09O2r0+HnIp4+gY7eQb
         wVQTGz8djp2TKsDRr7wy8f938wlJDT0gNIDUcgLF0g7YkAixOl1Y0bJJhi82SYVnn8/M
         TsTd34RjtjMt8hACDdnaHMbxL8GCwep6ZN5HmMiMPTXMqKj/HMx6BDQ9NvDp6qcuiFZ1
         kS3Zd1977XVul4kACm4u0F0kGNRhBP+YsnyhWmWDNlEyhNLn4phCpAWx/hn+7Qxta/6x
         uNMlNzL5Ppj1aNieFMykIoMPwGCx1qS2CNO5TldnIcnGVEWizAOyryoFETmlD+L20m9o
         SYGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793250362; x=1793855162;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D8F/HdGuSu6Gc0aayMmmYPmWYbhMQ7jikJBXSJ8mNwQ=;
        b=iQ2aIOnCo06JkJGGiZf+qjrLw0/aQO7+epls/NyfhypLfKsBLkF15dFdVCKPO/S0HA
         TeEpB6G39/DyZ+TxHX2uIgcq0JWm9T9HozGTsen5KtQ5eqzR8uxOtQaAn0gRoZa0ytFI
         AvP/U/+jNxGIE1oSuDLkKk8wXIKFcP3Eo+oiDSjdGWuoNXOLpeVUIj1YEtD4giwTlVno
         oWdm8wYNA2mO69lOJugjJuqK8zv+CWMobqXM6Wc0yl1kkaltvaAvyNEjY9KfSkvB6Yqu
         D7i7QomkcT//HqDOSguV9JNmrst+LgQ3422okn6ouO/QWk5608MEOXB09tRqMay+0nbZ
         TFUA==
X-Forwarded-Encrypted: i=1; AKwUvBx+n1s/RsdeVPCeX9bmlNb7VCDTYkmsk43qWgDGEpttvg5HOvQ11qvG4fCD7FlszQofmt/crWX+Lr8EFH8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKfbuBEi5Yzzrh4wDaQdNir7cgPJiveFIlMGJjMnJW6U+nbPsRc
	oJ8cI33gRCv883OaNjbPLGmPNLWG6G70LAMsrTCGxurFcspXB1fz83sS
X-Gm-Gg: AYBFou3BWiO3QGLh32VdiW+2millo6HY4n6ksv0kOmift14lLeAPNLnDbou9AWgjUHz
	4fIwxRtCUnH27rpdulgxQoUE6EGkm7Zb6SMQEddNlyg3jjZV+9tjtWjjkHf2+BWBaR9Yuz9uGhR
	6EqViX4aoB6Z2u6W6kVsQvG+lvomdU1AQ48dvudeWtH2YNSlZtq4mI0tZ1GvwGdUay7eSmqLL/N
	1kPT+Jv2qTyp2e0vomFFBXdzhO9cfkG0BtTbYl9WLI8ZAFbQyj86/tlqbhuZUPN6s6yLih1PJqr
	a20GEGlGugdJh1FKNLdtOdtoydAevdQP63Q5BrXugEV6ruCyVfjncJqWBPbT3vtPcljs/GxvYB8
	XqGTNVOUBq7O6FnJmZneOZNBk8l6f8Y63G6CGHnZDD9xXdUWuzV1L/4s93OkjZbZRxiu58IqJyx
	JRKQsX0ZCV7fCiAfOz+p3cgzY+AUElyCzUs+fetL96oTZXroqrZ1p5KI5nM10XFGMYeKrGnNv8i
	E5aitEnICZXrwwS5SUgviNV6EOJB9ZIxtcFrKnW+uxFaxYjRZhUe+HIfFxASqehWIgfdl/6WKkB
	tkE9QdFTWhqWd40BnsSJIGccPvnC
X-Received: by 2002:a17:902:e88d:b0:2e9:5714:6081 with SMTP id d9443c01a7336-2eaffcc020bmr39772385ad.0.1793250362514;
        Wed, 28 Oct 2026 22:06:02 -0700 (PDT)
Received: from [127.0.1.1] ([169.211.140.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c9d2cesm28159685ad.65.2026.10.28.22.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 22:06:02 -0700 (PDT)
From: Kwanghoon Son <asdfkwang@gmail.com>
Date: Thu, 29 Oct 2026 01:05:42 -0400
Subject: [PATCH RFC 01/12] dt-bindings: vendor-prefixes: Add Bouffalo Lab
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-rust-bl808-console-v1-1-b736ee920078@gmail.com>
References: <20261029-rust-bl808-console-v1-0-b736ee920078@gmail.com>
In-Reply-To: <20261029-rust-bl808-console-v1-0-b736ee920078@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
 Paul Walmsley <pjw@kernel.org>, Samuel Holland <samuel.holland@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Anup Patel <anup@brainfault.org>, Kwanghoon Son <asdfkwang@gmail.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, 
 linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org
X-Mailer: b4 0.14.2

Register bflb for Bouffalo Lab Technology (Nanjing) Co., Ltd. Reuse the
prefix already deployed by Zephyr, including its bflb,uart binding.

Link: https://docs.zephyrproject.org/latest/build/dts/api/bindings/serial/bflb,uart.html

Signed-off-by: Kwanghoon Son <asdfkwang@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 5471a06f93f1012f08e26f7f105ad846ab3629ac..24c670ff75b6f482ede1bda3b59c70ed9116042f 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -249,6 +249,8 @@ patternProperties:
     description: Shanghai Belling Co., Ltd.
   "^bestar,.*":
     description: Shenzhen Bestar Electronic Technology Co., Ltd.
+  "^bflb,.*":
+    description: Bouffalo Lab Technology (Nanjing) Co., Ltd.
   "^bhf,.*":
     description: Beckhoff Automation GmbH & Co. KG
   "^bigtreetech,.*":

-- 
2.47.3

