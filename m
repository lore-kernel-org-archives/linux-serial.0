Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793250398;
	b=GWVvwlUvboiBcPUufrgLCRhKolwYEo+tDS9sYj52hAP8OPqGQvBHmBQE7sSJKmahlvHs
	 E88vEg7pUTvbO3ViyBhWXMfOjX36eDjVmvwisCePLpZzDSWWqe4Nz3bLbph2U9Q/vfI09
	 EMpvNTIWPBWsrbgRbecjlQq+Ph4bz6UgFzYEGH9fg+LvTaaN4TL8nO+cOAkHELjfhq1xI
	 eQnqniQgMuKE2GyRS193ZJ6mSW4xitJZhJuS3rFPVotieJCRLG9nDUVEXWk9LTtxPNcn3
	 /YPrLT51yfZiVI4O0kkHBsa/h+8S/SEBDnR9j/r4logPAgsh5TCQkhr1yWi1j7yL05w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793250398;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=CrjcbC2vvSsIhs0KIikEko6Gkv8aDugjcrbnMMA8X9U=;
	b=eebX+WXwtGMpmYo0aR53IxctmhYtgY+LZTpZk8jmXC0+2+oqwCQB8kTXgXLtOB8KKDLb
	 rR8hXvcRNKPqACk+kWScN1F+Uk0rVLCLODuZ4s5vGT5FAl0vTLX+rE5annthTdkOx98TK
	 PRf2yReVXioAXWc7ivxVSScl4JQfIdirgcufuTpME5TUxbRaw7Mx4G+dhxfPzHjSQp6Fd
	 E7DnWBhN0VPm+xULoI4osrlfqBbuNthOozz7HyMVYbW/LoWIbTCvBRC/EPRWuv14LfElm
	 ng387gAXckcLm2ewZYJ10P24paG6zzROHx4e9FLdmppr4fYq0EChPRgXaCLhpCJ9OSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UyvQrkiJ;
	arc=none smtp.remote-ip=74.125.227.137
Received: from mail-pj2-f9.google.com (mail-pj2-f9.google.com [74.125.227.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAF1606A31A
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 05:06:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DAF1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UyvQrkiJ
Received: by mail-pj2-f9.google.com with SMTP id d9443c01a7336-2e97ddaf3c4so6054935ad.1
        for <linux-serial@vger.kernel.org>; Wed, 28 Oct 2026 22:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793250397; x=1793855197; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CrjcbC2vvSsIhs0KIikEko6Gkv8aDugjcrbnMMA8X9U=;
        b=UyvQrkiJwzXJc8eMaaaK0LEUM9ppujErOpcxkDs/qShRsUCj1CjjOu6r/RFkbgvpkw
         QctJjzbyQLUI8ZXwCQxMglGw4gtkQVeMNh9hY3f+RUCopw4KstBuNDYMr1l5wioScD1j
         y0MZb6EMJnGwHVtU/36GzFx1fsHUwFz4yWo5Ftfl/zyFrigUwFAn0ACxAjmF9c7848EO
         wC1Mw9jYPSgzUBApr8acU3ELgKEDVQap3NcnC74E+LuZo9/EElYA6bTPeG5puNbohGnp
         GuVeOOs307BbGvPyriIRh/nr2EjkiRrSJYceMkkaj8qu0nV/BpY0ZTtPUk8ef67g68cS
         4xWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793250397; x=1793855197;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CrjcbC2vvSsIhs0KIikEko6Gkv8aDugjcrbnMMA8X9U=;
        b=0yM018fNWUiwTb3IEL2iM3qpken4URgquZWDAYVRaFY+bMHUioE/fzsFa3TuLj6Ema
         sK8b/gsmqB0ElcGy9OSy+S17aD5rKifACs6sY3kfWnUXC773goufvxC/fl+XyVnK6QYF
         MAVv9k61IVZWv/n9HcAFRQq3G22kKAFlr/sykOp6wuZl1EOOYTdfsPIhcVKjR8jdODr2
         FQlA17YLGfaOUmg6KGbqJE7eH4oP4p6fx8WtaRqueLVd1R/ADkByYHmUij1JK0MSlNdV
         C2yw8t/PL5OE7C2KPcSPDKIYPCudVPTh3DPo5PX5W8SDA2AVy4bjQiRsa4VDs5Mmsgg2
         pztw==
X-Forwarded-Encrypted: i=1; AKwUvBx9lQ1HfMp6Evl8CqayeUuhNsv0Xo6LXx5HRzjn4Mk3zoa+2PoVOCXX4qOlryttbABqi+KtVlNgoqZx3Zs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJzRtquAEWVeFEp5VUJvJiRW7o4/6dlVIo7CIzWTDcUiKVT6ea6
	Fad5XbQWpN/TFFZwETHHid5+lMv0NLs1jPbNVVoRlZ3MoxsM4SOtUg+P
X-Gm-Gg: AYBFou0M9xokbySpIwS1UUYJJL9GCStJpMsp72+RO1t1+XAoX6FNw7/FkuXxOb4seZP
	wuqY1KdNXnDzyAhFVTTNYg3iOE+SvNjgR//f92ov7Lar4Z3lsXioGwl4L5y5EhQvk+j7bit/Qbe
	ceVKX2OpcbOzc/+ImXuRGljA3DU5xdOjOGfzeF4abb5aNwV0AdslO2PI9vQTtzwfJWWxEe5Sg2x
	4CaN2pq3hgefA2UTJ0Tcz7KaSylDCEMkuOpybd/xTGCQIQ4dbc9hAkc24NSW449i1dUYBumZmEg
	mAMuzG7P1bId263sDlPCeBB6ljDd6ZuNVmsQEHMwOQR+N6NkwIFdwU2v3vqMrxt02XVILh9CKIv
	MT07fhWr9mTTHbwlngt851SJ73t4iU+728qBrIINNcql71FsPczOlsu64eQ8cyOfjeBHYr7mB4K
	LlUBUfeg2R0HgfFggFUxVRHNlSyaCTog3aUlQSYMr0L7ZGlWSu8xCVz2aXP/Lovy//DV5EfH9vr
	Z+XCoP4Y5I02G+1f1JYUk1VaQMAFQXC/whZL5V0iQpykrDm0c7l773dKp/+245H6ngtrZiXbJK5
	Aa+q+aQGWh92LBXTPbLnijgHI7Hu
X-Received: by 2002:a17:903:3bc3:b0:2e9:5ec6:bfc9 with SMTP id d9443c01a7336-2eb00338d1emr39201665ad.9.1793250396614;
        Wed, 28 Oct 2026 22:06:36 -0700 (PDT)
Received: from [127.0.1.1] ([169.211.140.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c9d2cesm28159685ad.65.2026.10.28.22.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 22:06:36 -0700 (PDT)
From: Kwanghoon Son <asdfkwang@gmail.com>
Date: Thu, 29 Oct 2026 01:05:46 -0400
Subject: [PATCH RFC 05/12] dt-bindings: serial: Add BL808 UART
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
Message-Id: <20261029-rust-bl808-console-v1-5-b736ee920078@gmail.com>
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

Describe the UART register range, interrupt and baud clock input.
Initial Linux support targets the BL808 32-byte FIFO and reuses
Zephyr's bflb,uart compatible. UART3 is D0 PLIC source 20.

Link: https://docs.zephyrproject.org/latest/build/dts/api/bindings/serial/bflb,uart.html

Signed-off-by: Kwanghoon Son <asdfkwang@gmail.com>
---
 .../devicetree/bindings/serial/bflb,uart.yaml      | 57 ++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/bflb,uart.yaml b/Documentation/devicetree/bindings/serial/bflb,uart.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..df29d258f0a1c6d7bb283cf19c4157436991b64b
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/bflb,uart.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/bflb,uart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bouffalo Lab UART Controller
+
+description: |
+  UART IP used by Bouffalo Lab SoCs. Initial Linux support covers the
+  BL808 controller with a 32-byte FIFO. The compatible follows Zephyr.
+
+maintainers:
+  - Kwanghoon Son <asdfkwang@gmail.com>
+
+allOf:
+  - $ref: serial.yaml#
+
+properties:
+  compatible:
+    const: bflb,uart
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Baud rate generator clock
+
+  clock-names:
+    items:
+      - const: baud
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    uart3: serial@30002000 {
+        compatible = "bflb,uart";
+        reg = <0x30002000 0x1000>;
+        interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&uart_baud>;
+        clock-names = "baud";
+    };
+...

-- 
2.47.3

