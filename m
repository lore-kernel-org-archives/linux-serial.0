Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793250440;
	b=GoylJn8gjHgXhv+F/3W/PG4sBZQ7i9UQ16JBopVwNvesGhDHMsJBBnO7z43yA8bcegEf
	 illxZ5uQd7lgrpKFW+MW5wEAWfMvjgMy0YyhLzXk7LWkrQ7VKaMmofWrZfm/vcrx0aVDC
	 F4DmoL+Kj7XQ7fdozvUyiIMiZ4lIVTTde4RJglpNkcvDU1CDVZlblwiLehnhtSOU7dvs7
	 u9bmG141N1g57+znh/ISt7OH7RS+LsySS8Bn7pjdHA7p+Uk6Pw+3B1TiAfbIATXWOF8Y/
	 Wh8kin3TOF0kaPjABSPVnNHsKpA/ddQ9+7jCyrksBDpBKmCiLTCGygin6D6WSJhQl8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793250440;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=zGV4hq0i8RZtAPVqoljw/C8+Ety28xxbkClqaDK3k9U=;
	b=pxK5N33Rcrd+nSiT5C9+WBbPa+iS+fw6TWjQSupzrRUeQJwj6Do4E24dFNKSGG38KEzh
	 +5gW6U5A+yzEDE6NFhwJuLImLCqSuZgRGDU76Dr8SuBCLoxgq+szakydhOyHKt6Bwp4ng
	 as/DbB+2krMnr642kigrILYSFgGLD7nWY5doItCgx/6pVCI1AJrl0oK2opsn55jfI7Ih8
	 Ar0aJRqgyJx662XXHE9NjOYZFZHlX6MKdvYAnZitFKW8Fuv0cvyaJLpVQdnvjW3NNjAm1
	 UkVO+GjGKVH1B1u5oxpGVkt+CgrAMLpQR9hPesSNsh0voYLaBa4Ei2CG43B/hKFcpAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EhB6xBKV;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16740606A31E
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 05:07:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16740606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EhB6xBKV
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e96502e447so15017855ad.1
        for <linux-serial@vger.kernel.org>; Wed, 28 Oct 2026 22:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793250439; x=1793855239; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zGV4hq0i8RZtAPVqoljw/C8+Ety28xxbkClqaDK3k9U=;
        b=EhB6xBKVd8era6ux3/LVclIs7SKXgBN68W0ZZxrCBjQ0dGTX2HkS91euvItz1VGzt0
         MpXWwxp00nvVOBAMLdVa+1d5fRvYIL3B5/2yQBd4YZYyICj2XuplDz7sFlMs+Sa8sfND
         phbZETaoYJtpXb9Z3nGC50NJsGfOLSLZBuojKXxhIOO1UJ64wHfAbXBRCXOX+Y5gh4/M
         uxMyZV+k/gpy8xevIGYJpgTXtNRLlavO1+A7ipbV1tfoFjhTE7WBOKI/qKcCM5SJymko
         m43lpO8xVMInTm/nrIMZIkkbd0v0YdizalBby4Gc0xAFQgEOWBLw3qP5dao/stPJsClA
         SSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793250439; x=1793855239;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zGV4hq0i8RZtAPVqoljw/C8+Ety28xxbkClqaDK3k9U=;
        b=REZjnxvPJhrwUT0lORAN2dJxzOHVBlgKw9ICMZsKnAAhGflKvQfqSTSnCf7Jz6mahu
         NdMI4z9e9gohY5EVapoeTr1PZkNesNTDgYNBNLK+b9bSRAJm8SOj5ojGoeDc8et0SO7J
         LYKrKhEFABzjybjAmDSpc5yx9I30o4BfYH9VNzX4yElddGOJX7JwywORPnV0J1ZUcxwk
         CEtJWBMcqPfDMjT6pg1mJql7i03yGOiPs+zEiNvKQ8xxwA+WshzfXd1+F2OStR0pKmV1
         4Q72PjhPovdjBsSQcH0WaqGE9FcLs2g2Fa6FDIYKJSEkadAaeuq9bGEO/hNUk1N8QYXN
         hUVg==
X-Forwarded-Encrypted: i=1; AKwUvBzwpHx8JS8NRyFpqmllxcn6BkVJLl2Zn5oRYk/zZ7F3ZgWdXBcrAr+M4BEPMvNVRH2lRGGhuAjJhvO7JI0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLF6wY9CVJ8JTSajmohv7j5bpyQoBr8ohgVBck0zeZrmtmlz9F8
	TuctrNOLAQby9ovl5aLBsw9l2y6wRQH2YTQQOROsfq3nkgucjprXaHkD
X-Gm-Gg: AYBFou1+keCLl6W41Vh3xFGW+uZBspdQogMLPkuaauQR90OKvUYKkrWwae0pGzcLmjN
	NWpEcXZBovXqPrmEjkOTisvve4XifOJICRptm5Cy92mRkD+ukFuC4lQ77cURoSWybYJkNnn6/o7
	Iqp3QvkHaktZnkVEVLwap1gcC+ThHJ6S4+VD6zyzUwqdrRqzSzKLujUZZZJEoBA08OUsNDbKcfM
	ZBIOXVB0MSyxGu00zKkyDQMqP7atGQ38C2hj0rwI8/wjQv/U6wQScnV8NyCoN6AEYlECSaP+MuN
	RWzVwSTtbz9x3B6+/c47Sx/NF1ZXxasSmSrVWbeqqDahyUXK7gpxBH9/qnTwmpWiI5Gw6cC7tut
	uuVptCITOfPGfCau1oFbN2wbsSQxqbpIhB2ZXWygtfhtMLJtQwM3BsQEk7zpSvu5FHmUcSucHRr
	TGxODCIJ+gfyrSVuSn0AXjIZ8YbSxF+yGmFU6WFVvO7gALTkgm/dBASU51lnaLd/7jeVS0LC6/e
	m3JYVU1f2ISV06E5t4iRPT9HuQdSFWsvOpB5ZUy47QgZyWbSHmkWU0UtkrQVQVi/35U1SK09Wa4
	ILVgkkF9YAmXSNOaQZ50nv3ULKk7MA==
X-Received: by 2002:a17:902:da8d:b0:2e9:69b1:1b9b with SMTP id d9443c01a7336-2eb0012c7f1mr38007225ad.8.1793250439420;
        Wed, 28 Oct 2026 22:07:19 -0700 (PDT)
Received: from [127.0.1.1] ([169.211.140.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c9d2cesm28159685ad.65.2026.10.28.22.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 22:07:18 -0700 (PDT)
From: Kwanghoon Son <asdfkwang@gmail.com>
Date: Thu, 29 Oct 2026 01:05:51 -0400
Subject: [PATCH RFC 10/12] riscv: dts: bouffalolab: Add Sipeed M1s Dock
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
Message-Id: <20261029-rust-bl808-console-v1-10-b736ee920078@gmail.com>
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

Add the M1s SoM memory and 40 MHz crystal, and enable UART3 on the Dock
with a direct stdout path and 115200 8N1 settings.

Boot firmware initializes PSRAM, UART pads and shared PLLs. The tested
firmware configures D0 TIME at 320 MHz / 380, represented as 842105 Hz.
Firmware using another timer configuration must fix up timebase-
frequency. The declared 64 MiB PSRAM range must retain firmware
reservations or be narrowed by firmware when memory is assigned to
another core.

The stdout path selects the native polling printk console; userspace TTY
I/O is deferred.

Signed-off-by: Kwanghoon Son <asdfkwang@gmail.com>
---
 arch/riscv/boot/dts/Makefile                          |  1 +
 arch/riscv/boot/dts/bouffalolab/Makefile              |  2 ++
 .../boot/dts/bouffalolab/bl808-sipeed-m1s-dock.dts    | 18 ++++++++++++++++++
 arch/riscv/boot/dts/bouffalolab/bl808-sipeed-m1s.dtsi | 19 +++++++++++++++++++
 4 files changed, 40 insertions(+)

diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
index 69d8751fb17c803f0efb8003e111ee24144c222b..294f9c119f8f1d608c878ca1f95891843301f07e 100644
--- a/arch/riscv/boot/dts/Makefile
+++ b/arch/riscv/boot/dts/Makefile
@@ -2,6 +2,7 @@
 subdir-y += allwinner
 subdir-y += andes
 subdir-y += anlogic
+subdir-y += bouffalolab
 subdir-y += canaan
 subdir-y += eswin
 subdir-y += microchip
diff --git a/arch/riscv/boot/dts/bouffalolab/Makefile b/arch/riscv/boot/dts/bouffalolab/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..4d63365edc095fbe9df31c4b12e29c4b624cbd1f
--- /dev/null
+++ b/arch/riscv/boot/dts/bouffalolab/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_BOUFFALOLAB) += bl808-sipeed-m1s-dock.dtb
diff --git a/arch/riscv/boot/dts/bouffalolab/bl808-sipeed-m1s-dock.dts b/arch/riscv/boot/dts/bouffalolab/bl808-sipeed-m1s-dock.dts
new file mode 100644
index 0000000000000000000000000000000000000000..c719a53c6e2de45f3718b48ba2116e99c70e559b
--- /dev/null
+++ b/arch/riscv/boot/dts/bouffalolab/bl808-sipeed-m1s-dock.dts
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/dts-v1/;
+
+#include "bl808-sipeed-m1s.dtsi"
+
+/ {
+	model = "Sipeed M1s Dock";
+	compatible = "sipeed,m1s-dock", "sipeed,m1s", "bflb,bl808";
+
+	chosen {
+		stdout-path = "/soc/serial@30002000:115200n8";
+	};
+};
+
+&uart3 {
+	status = "okay";
+};
diff --git a/arch/riscv/boot/dts/bouffalolab/bl808-sipeed-m1s.dtsi b/arch/riscv/boot/dts/bouffalolab/bl808-sipeed-m1s.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..ae54e6e301ed2c5a1448d52c530c5074515ee38c
--- /dev/null
+++ b/arch/riscv/boot/dts/bouffalolab/bl808-sipeed-m1s.dtsi
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "bl808.dtsi"
+
+/ {
+	compatible = "sipeed,m1s", "bflb,bl808";
+	memory@50000000 {
+		device_type = "memory";
+		reg = <0x50000000 0x04000000>;
+	};
+
+	cpus {
+		timebase-frequency = <842105>;
+	};
+};
+
+&xtal {
+	clock-frequency = <40000000>;
+};

-- 
2.47.3

