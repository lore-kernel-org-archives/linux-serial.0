Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793250456;
	b=qIIc2udPbC4Lhc5NS/317Jw9ovzZWJ8mpSnSVkkUKsEs5lNn6m2m6EwHLPRH7ZKxnW20
	 McI7VNMFoGiy6Pm5Hhu8pK/F0q93H/99Rgl3gN7kAj1XHjLApXsmYkL5thS/3f8uIUh3C
	 NkryylvaCa0tgYrDH3XprhzR74qUdnGs7SgtW5KX+RyREWE+SsEFtBEVFZ7az0MwVdrJr
	 Gzep7ggFMrSZS0w7qlef8RyrP5uv0UR+Rc7ZmnoN7ZSBe94Zz05nKci2KAQBqW/5cjIEH
	 lWFDFY5WYTq1DQj/QovICaHI3RyU6BS5f0rn9btDzTsVoDJt7UEwzA5BWgMqsksffUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793250456;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=kXI6IHEoyVt3a8/+pcNKwK7JZFFGDNWx/cQqbNDN63Q=;
	b=5noBtvr5wgl8wqsVVsaEsil7kfoi/j678C10Zkn6rTbZTPa0OQ3ZWN90QdFTPI0U+Cct
	 O42V4GsroZ15+A/bO7S0PfM9aaktqX6lFh6nvBHYsXytAOUrMA6AitZ7zGKohyX7QKhje
	 00sFdHc9Sq6cF0wXLtEb96REleSecsdsFU/iikdxDxiKVNLVG9e+v/bllou+L1uFOSaku
	 ySfS+aG6JMDZ87QRAgf82wUwb0XMegehQ/5Go6+1EMBbaoguYgvaZhhdUNGGeWtDsFjeL
	 GxJH16VHQ3s95rk01Q2Ct6rCk5UmIJakpbaKwBPdFYWX86MP5W3PMWv74wuALvvmWog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m3BbByNv;
	arc=none smtp.remote-ip=74.125.227.131
Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40618606A320
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 05:07:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40618606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m3BbByNv
Received: by mail-pj2-f3.google.com with SMTP id d9443c01a7336-2e831901331so13447115ad.1
        for <linux-serial@vger.kernel.org>; Wed, 28 Oct 2026 22:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793250456; x=1793855256; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kXI6IHEoyVt3a8/+pcNKwK7JZFFGDNWx/cQqbNDN63Q=;
        b=m3BbByNvwVTB61CMHLiYJL8DEUQo3qdr97nQ+INggGQWNXYxuBhs6564SGou9mckbf
         8rMZ6mAEPe8pnfrrQDQvfoTRvLcbLdErwvhuvdZ6fHAj5OtYZaU22cn/PdKdnt6BbpNe
         XDodhGEIuY1dL6zQy5GTOyiA8zlLyZmN0KeofYJzI+GnLqLaPSJj//bcdLzSUsJGAw/L
         JKgR4xGuvprCIbFeUgmWsfX8a8oCH3GchhBPHoqA4aYG7FNiiJSxW7GmwR5+3Pm7SjHF
         eDWtTVoKG42ubA8r5DEbt80e813z+LbUxlbgs5y+DyZwQA/cV/40EsNXmladHSMSfkcx
         kXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793250456; x=1793855256;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kXI6IHEoyVt3a8/+pcNKwK7JZFFGDNWx/cQqbNDN63Q=;
        b=WRuEqgEo1EQmTDArzJppQWYhHymepX7ARZnHpE5idnqb1uj2WTy8/WpVhF9bjKbuR8
         ljCo7CqeOKZx2qiDnUzTdjCG/qUBjVDUPrBoVjfDXZQQ02R5UCqTsEVElNhXaW5hfbFo
         cPUe7LNoG+maS2KLhBgO/PVya6gE5K0onGAjHrvOy5QlCDtE5Z9O+8mxhCShD+pn+2Sl
         hy+b2Qf7Tu0dQWJMB2kHdN9zeT1qziGktSTiBDq3xudq1Z8aSZ2IsWPampDtB3f8T0yU
         pqip0/88nWdi1MdWtTO4cy7/inadKwA+4ZsGsKledUjMaDfNHuF0pNdjLtO58DRI4V7k
         4/EA==
X-Forwarded-Encrypted: i=1; AKwUvBxCf2HALPDrfsPZv1df+69Dadx7URiO44G2IWdROyDcfIVS2skW37YCyZdMT19moV1VOKNrrABlds9u9ms=@vger.kernel.org
X-Gm-Message-State: AFq9FYIUgrkDP4V1L2zX2GRPBzpXJJAoHgN9F/qeFqgwZ4p1NvaRnZuc
	g+cbq4gMIoIr0bzv57DlF4jh2zmkanoAR2kFVexhNsb7JwINNlftXS3N
X-Gm-Gg: AYBFou0430oM2Dl440k5z8sy2sOtyttTsyrokH/dD+JoJrzf1bGQXiHVtlGm8SlhwTY
	YqivMcCjIoYgL54hkKGxtq/JES7WDvy6WEClnjJCZDOadW7Gw1kziFgKfIPs7gXOt/vF2/IZOen
	FVQrMlu041Dy+JLYUGeE5adjm//BTDu8WvZtids46VSmBmVdJBd/Qnc7vBSa7cC/Pt0yNGffY+s
	dfUWalsjFw8ELzViuCTSMkuP7OCmyjthN3tpQr0bASVjkyZvzZh00OUUV4SoH59Qbv1lbiIB1GU
	nr3PDyK0MO2eI2/Ltzwk1DFcK0wsaS0mTdW4jNQxKYc2STXfUZDgxRDlRtZ0VFo4oh7sr6ZNFta
	dHANvTghlNrjh4uwANCNJkoq6REYUg203VqLPNuuAoaJca7V/LHNYgmMEtOz6WtqsA62mtG2+yj
	9CFpIiW5tAoZHdfV0cz+7vDnh0YZbHbVB5eHaaQ+LyVBi8nehvH9aK4uHH/dJ/FZDYGFuha5qFl
	mB722ViB1DFuvWSFA6SmO7abzUPgWHfcpeMakwdHNNCpMvJvgBeQiUOyy6QsvNflprjyHfV22CV
	I754YvG4cP7tEulUS+D2qUapRLTI
X-Received: by 2002:a17:903:38c4:b0:2dd:ad73:c93e with SMTP id d9443c01a7336-2eb005025a8mr38954575ad.31.1793250455691;
        Wed, 28 Oct 2026 22:07:35 -0700 (PDT)
Received: from [127.0.1.1] ([169.211.140.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c9d2cesm28159685ad.65.2026.10.28.22.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 22:07:35 -0700 (PDT)
From: Kwanghoon Son <asdfkwang@gmail.com>
Date: Thu, 29 Oct 2026 01:05:53 -0400
Subject: [PATCH RFC 12/12] MAINTAINERS: Add Bouffalo Lab BL808 support
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
Message-Id: <20261029-rust-bl808-console-v1-12-b736ee920078@gmail.com>
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

Add a MAINTAINERS entry for the Bouffalo Lab BL808 platform, device trees
and Rust serial driver and abstractions.

Signed-off-by: Kwanghoon Son <asdfkwang@gmail.com>
---
 MAINTAINERS | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 801f964899ba790a8f71fe61f9b3777a494dabd5..b76d3e168468bf6139c958a81b626c73b422c0d4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4926,6 +4926,19 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/imu/bosch,bmi323.yaml
 F:	drivers/iio/imu/bmi323/
 
+BOUFFALO LAB BL808 SUPPORT
+M:	Kwanghoon Son <asdfkwang@gmail.com>
+L:	linux-riscv@lists.infradead.org
+L:	linux-serial@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/riscv/bflb.yaml
+F:	Documentation/devicetree/bindings/serial/bflb,uart.yaml
+F:	arch/riscv/boot/dts/bouffalolab/
+F:	drivers/tty/serial/bflb_uart.rs
+F:	rust/helpers/serial.c
+F:	rust/kernel/serial.rs
+F:	rust/kernel/serial/
+
 BPF JIT for ARC
 M:	Shahab Vahedi <list+bpf@vahedi.org>
 L:	bpf@vger.kernel.org

-- 
2.47.3

