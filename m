Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793250381;
	b=StuRAoxtX5xOEnt3cG0bDpjggU71xHKMPMdkq3bHq/PW/Tx9jiG3uoTEiP0ZGhCQvXjr
	 EVIn1eT4M/xfIhZ7f8bCId0AAIoBxKklMCn2uGa3q9r+Q8IZzxbma+RYWgxu5HOo/O3RP
	 JEThf91AzEftgLHzxCZYvMc7cZ2XXiCdmOhlccpuQAqdjgAm7SONP425YOpc5wL6s+lbk
	 V+c6g1Za0WQvNBIjeBDy4ZsNUeTuaIktfndiGIOQhy/UWPqk+xQBIEze6eTQgXFP3QiFi
	 Ckwkp4o6Oq+aEUgwX3WGUu9vxiErmHbL0pzyyix0JKga5IG826v5DZD5qGsLcBi4oMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793250381;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=4pcGqj7EcqEBhg8rTi3U2rPWxfkoRdeov/It4k+I+Yk=;
	b=dGvXhkzaxjyMwURq3ptgJD+kbu8Gd3NRjBLd2F+/REpPTHh77zX5B4U8k+hlaARHigyf
	 Ek4uHbnUbF2GCpIUiFBfm5cuEoN1KEGbtlJ0wkn/CPAKfLOnB0pclyusAakR329BrnsOZ
	 Vm5m4sh4mSQ6MqWFj9eVA9PG+1aVCkH3KxV4MmjqRaB7u/S2pNQ9Nnno6S5Vx82/i0uls
	 fFrS6GKyMIPORZB4sF2WxbYLIlSgyCV+uTMxkhgMSvOGNF4DVX7wZ4ZAt762q1OZbFyNs
	 tzXk1DOIBsX8G1jBBO4Diyv/K6xvb9XY9axuGe8OUCX14FQ5yOOojpDp8SFqWxdNY4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z+O8EIyU;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30429606A31E
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 05:06:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30429606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z+O8EIyU
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ea138a3497so9966895ad.2
        for <linux-serial@vger.kernel.org>; Wed, 28 Oct 2026 22:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793250380; x=1793855180; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4pcGqj7EcqEBhg8rTi3U2rPWxfkoRdeov/It4k+I+Yk=;
        b=z+O8EIyUDM3BtcD1Yx+C7oAh11I9nR0MCUlgL3ALaofjFPr87O3qwTHMb0KwOteZ9R
         0cwM3kRXpkcEfO6qrZAvwIAcuKigraV94opIHJDWIKiTMpviMPbYON3NUoFaY+WaQP93
         6PEyAtpOt5C+yA0/Gg/CqAGt4oydFJKCV6/vsqxNYhjRfM6RBgikOTsAIR22StKRpk+x
         Amjxt+VRUPM2Zaz2nCnjzuWiAvSwLW5LyYUB+YrvkWE7Az61qyadK+F9l1psyB+MPrZW
         zdutJqgc+QZFFjS19kim6bzhO5GYFyUkwhFHVTGrPerT+qmNxMQFykUbqErajqkROqvM
         bF/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793250380; x=1793855180;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4pcGqj7EcqEBhg8rTi3U2rPWxfkoRdeov/It4k+I+Yk=;
        b=zeLS5R7db0aQYukHL4WbCiDs25CM867y9okOoMToqchm6a2ZcKJAoRbAukaUfot9JW
         MtgQb6QJtYoDTVNkBy6e8HwD0PdayIvSctWRdTOcsJUyicZppqTa0ImmgsYBk8uZrJxG
         UCEv6YKyU/QFCVZfULXftGcVVM5dYKzcUFmTziIWdmk09235lpms1k5iOaf7kMrh7TQ4
         kq5kylCNcyAQ/d4rM8lhjoO9HfCHQGoYSnFpqJEKMtiiN5oSZ5RqnkUDbo8DfNev8wmg
         tLYMseQD4gURaF+ONGmvbfnVSKLHpP/KckByRfyAAEnNY7QJVdnpMob39zY7Nfj6EtxJ
         Uq8g==
X-Forwarded-Encrypted: i=1; AKwUvBwfP6DTvrwOd+EbX6sCs0LSmd+DBan0XiFRML9cVFdbYQn+OPWHh/s32HXpN7Q2K0mBhuQP5P/hGn+AoZ4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJvsFSvOP8v0KCZzB05MUGXAiuEz9LT6v5euPf8qtdz7OFZ7Qn2
	WKgJsxwmxS510VVWEtP9+bEtqLn8j1vIPppkJD6orMzi2mRmbBnE94B2
X-Gm-Gg: AYBFou0AgzXm+RdormZyWQlw/ZsPNQznTu2IuZ1Zz4uYc3oadpQ0dIaaoA/jdqwLfQw
	C/1IAcFLAz2kG/VYKPYxSAeH/d7Y5lcgs7D6aFYsTHhjLfzlWQZdjnUCNjflYVjLM6D2ei8LgEF
	jUfseoZoRZ7+Jjg7SOs8yyscdrliCYjzNwUzDLcByKMAoc129XmHxhJgDhOar/EjmcLNCFn4yHs
	vRpru0A3vPUpARJJaBJ3Yj6/aErDmR4SKDmx+Z0ArabjpIcokN2S86LE/GLS1VUbWq/lTAo+8JC
	lQbTKCq9bkG9zzcBh+jYCPpYjZKMY2O9KYqUV4slkDx0YftI7v6YNcYruAeROqGJjn3+eRWqM/B
	8FE3KdLe2TDAPuosPfcmNs1hn09n372xTbSm7Cj0oQ1t7Mh474y8FSUTphMJmZq1odTZWDCuBK5
	tvsB3use1fY/9g11NyW5t7gb1dOnQSceLzMdPnrvlEF9O7wmz2VNOwbLbJPUZGYsFdXI/4B4FV7
	9X5ztF6dhnlt8vq6EkVs+Xh604zpd3jWAcG8d1tS8Dypzb/iLJeehiwD/fbNp2Ei25dcnGXyq0C
	pSIdtcPY/HZSl9hdtD5mt7UaeISo
X-Received: by 2002:a17:903:380b:b0:2e9:9c65:1aff with SMTP id d9443c01a7336-2eb0041ee21mr39673785ad.45.1793250380523;
        Wed, 28 Oct 2026 22:06:20 -0700 (PDT)
Received: from [127.0.1.1] ([169.211.140.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c9d2cesm28159685ad.65.2026.10.28.22.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 22:06:19 -0700 (PDT)
From: Kwanghoon Son <asdfkwang@gmail.com>
Date: Thu, 29 Oct 2026 01:05:44 -0400
Subject: [PATCH RFC 03/12] dt-bindings: timer: Add BL808 CLINT
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
Message-Id: <20261029-rust-bl808-console-v1-3-b736ee920078@gmail.com>
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

The BL808 D0 processor uses the T-HEAD C900 local interruptor. Add its
SoC-specific compatible with the existing thead,c900-clint fallback,
which accounts for the lack of a memory-mapped MTIME register.

Signed-off-by: Kwanghoon Son <asdfkwang@gmail.com>
---
 Documentation/devicetree/bindings/timer/sifive,clint.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
index d53f52e80d887b40c0d20049d86867c8a5b6fae2..3934c0842751e02174c1be6074548e3e1e8f11fd 100644
--- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
+++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
@@ -49,6 +49,7 @@ properties:
       - items:
           - enum:
               - allwinner,sun20i-d1-clint
+              - bflb,bl808-clint
               - canaan,k230-clint
               - sophgo,cv1800b-clint
               - sophgo,cv1812h-clint

-- 
2.47.3

