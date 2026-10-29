Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793250372;
	b=sl3VHX1IS8sMd2S/ltLtgQrqhmpA+ZKirPrgU1n60KEJ9Lc0W/9Wq+wk8Rm7m7omW6eT
	 yH6pk3f7K05yEQvk/fPtoWCH+/ry9t3S28kHDlU/zKIaePEtrsJIA9h0WbwhfV0ZKVFMl
	 N0fWISJjL59OQQX/1d35NuhHk9vHf+7u5OY7t5s/zMz9kvcEj+6IqLuxugPC6sMBHY5jy
	 zEMI7TDOPRzbU390OjBtQRccQqopWhPGRoReF3QocadGvJErsX6q0VSyqZjoK4u/XeGdZ
	 Sre3fZgFQLjbHzrPavi/hjhggDY8LEvj2Xda65Tio8HI8k/Kme5tUrLlQHWnZ5/gYkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793250372;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=JRnZbRztbK3uQmcjPiHrls6jXuhvcHYv7zJm0Q9BEjQ=;
	b=pvvnngd30ofksLSFWRWkbfUMeHQTHR7IA/plDJRur+P8dNg83uiT7YbC/0rOOTOhghWT
	 xKuMGXd6+gdkpkVjbe3Bt6JwjF/HK8mrpabPgeGPorzbZYlwdaxvNVLwBYB1e9oRkWs3y
	 YixhPUSekO5pz7QjaEI6hLSSNtJW5Qel9raabphaUUfTC9zyn4PJIc/0Za4BPjXhhGtYi
	 +e+2eiWjeb1SNigZC0RrDthoQDFhGHsH7+vjLgTI2MTf/QdoZhxl3/KZxRItQtcTxjEb4
	 b56xY22MfvZo3DhEBU3SPAmHLxcjldkQTiHpLk7AwHgsBdOFQr23iGRVZkZbTcdqxPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G8fxqTXT;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253F3606A31E
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 05:06:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 253F3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G8fxqTXT
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ea94541adbso7636895ad.2
        for <linux-serial@vger.kernel.org>; Wed, 28 Oct 2026 22:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793250371; x=1793855171; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JRnZbRztbK3uQmcjPiHrls6jXuhvcHYv7zJm0Q9BEjQ=;
        b=G8fxqTXTTNESyQXKDfIY5Xm8WthtTd3j5AumXbjcPreruRzIvJMDLop8TkQXZylU3o
         IlEvSfcyGjWpqG5HLBexfP/zaWk5YYU3eDReWFuHsG3VrgOxLwqzhNxYvrFdaiwvtCbt
         /arHNvx02yfHlnSJ1jjO/tDYf/1o3w6+RJ7pGCPCqu3JILVZ05QQ83cPE61xNQHWd5nC
         HFBB2Q17w4/zRv+jCWFodkiXb3OrHw8kVX9cxRCiYzEr3xxF9zkYljFcUt2R/Yjqq8dg
         M2CFYURtpKrc4PkoREBYRaO4xVAgS3cWp7BxSi2Uy9RCLdpmE0h3DIPREbo3dcklQkFQ
         V76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793250371; x=1793855171;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JRnZbRztbK3uQmcjPiHrls6jXuhvcHYv7zJm0Q9BEjQ=;
        b=MR138CnJft2FjktqF3jMRByV8HKHL/RU8uVEkCV1KbP7+yEwPrSEdklu+YYfY4OozE
         p8P3X66i+A/KSv6BYAD2uR98ipld4T64cWxhkcig3DJmGadvlP6lO1/upcmw59cCCQfH
         SSbq4Wx17u1MHYqBLFU4qLO4CYB2pXvHUUsbBALYWdwgmhBeXYsZMCNg+YavzMS8nYVh
         7pqIYlknoejjlEfNcBWyn/ME24TDbGi/2d3Fuumpw1NJmASmoo/e3eNB5vVCzdPjdpYd
         dD3iZVf+EQNV7xDsbydXnzhx9voeGgo9IFNIfpHkwQsN2haROox1gHL1VtEY8twQZJTb
         ikzw==
X-Forwarded-Encrypted: i=1; AKwUvByV9LEFZEVjCRKUxrwKfDQFdzks3AaZmpvxf4+2YhEKSlqJDwImPyMTYrhBbenC+FOkIw7kHLg8ZYnRLX8=@vger.kernel.org
X-Gm-Message-State: AFq9FYI8TXfTPsH6Knu8WUIr2T7HWI8nW8zaRaSxhttjvzvD89u8tjpO
	hkh7oqvWfllBU155pAh8WxZhBsXfri5XrWzyiOK4bogzXV5ELubsHCM/
X-Gm-Gg: AYBFou3Qq2tQ1p0R6BSMbrKR7GDp08edoO9rUfuDeyUhFSfPXki3xxjJIcmoHznEnut
	MsqQEIWWoB8QVQnjdZwZMuHT7EIzaM/r9nI0fkQIbmKaJABK8BZLVa+v0I7JjSpdOXvrKVnJqOi
	AxAADvHwFH6+9Wwy+UT//KJwajyL7qMWTLSiGbUlcA3bxCHEycfkzCxmOZQ+Kt42kN8mUeTmZLz
	dddSYEFO430z/7xvuUFfudiUeH1N8/JI1lJlsoXwh8jYPboKzpuTmJ0eGHx2wb0cey50irKNxTU
	FAaGvzfZWJbQuwGfw06ZHbZPJVDpWsG+3XTfMpISAAwGPvC3SE0Mr3eXmcHf6OTSGIsTPNDShoh
	8MMIwf76YS/ZgQQ+o9dGH8cjRso99s3C8NrjFDiie2D/C9olyBK1kAHbBSIm16md9XbRaOHssNp
	slpAv6zyS7hkMEEfpbWFJqnhFAzgffuxgcxWdcrcU9krYBd3Yys0L/LXiLmq4Czzqog93fxc4Ap
	RBSSyk8/3bf4w7wVNkx99BXP7ukeFmODu4PeJ/h/rS1HWeZrMFpCJnYmY2wTRPkz/575kBd+mhA
	w/LuZnQyOgH3AsaMI5RDztEM1YHTHg==
X-Received: by 2002:a17:902:c950:b0:2e9:61bf:6591 with SMTP id d9443c01a7336-2eb0058dfa6mr43576915ad.45.1793250371450;
        Wed, 28 Oct 2026 22:06:11 -0700 (PDT)
Received: from [127.0.1.1] ([169.211.140.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c9d2cesm28159685ad.65.2026.10.28.22.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 22:06:10 -0700 (PDT)
From: Kwanghoon Son <asdfkwang@gmail.com>
Date: Thu, 29 Oct 2026 01:05:43 -0400
Subject: [PATCH RFC 02/12] dt-bindings: interrupt-controller: Add BL808
 PLIC
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
Message-Id: <20261029-rust-bl808-console-v1-2-b736ee920078@gmail.com>
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

Describe the BL808 D0 PLIC as a T-HEAD C900 implementation. Its
interrupt specifier includes the source number and trigger type.

Signed-off-by: Kwanghoon Son <asdfkwang@gmail.com>
---
 .../devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index cde4bb6918978b40037774269cee85212d39d4aa..9c625dff1968ae6267b0ab65ed8d4e771c70c3ec 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -72,6 +72,7 @@ properties:
       - items:
           - enum:
               - allwinner,sun20i-d1-plic
+              - bflb,bl808-plic
               - canaan,k230-plic
               - sophgo,cv1800b-plic
               - sophgo,cv1812h-plic

-- 
2.47.3

