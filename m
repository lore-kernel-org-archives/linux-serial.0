Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793250432;
	b=VfU+0asdA6IIZ16wC3HqgeHLRWAMI8V2BopvsV5GKZkR2i1wFFWoZXR0nHjnrSzoBuHw
	 xYVD6OV2ljNEbJIAf+IF7g3rogfeRHBE4YrEZ68rzgUcEIdCTwsbtHXXkR0zCE7326lrN
	 v1TUW5gi0uMM6yByODuZ9+u9a7lFI2jTFYX+TgYUlVBQkTSMe79w6Wve0I1FjUXQ9UQv7
	 8UbF4aYNRvxwS/SOcLdvpLYaXuwqsWRnwYqKgUY6BuCZq9cI3FrOnoARMDkf5AVdZON/j
	 ARMX0RTeQTWmikcRoTEi6bkBRaKkeme2FufEGs2eEr4NPZ0XmW8IguKdO/H6+AOiD6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793250432;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=rjNfMp/WtzafGcb6uGtU9HJkhzqRTyKQwukVNkTGdko=;
	b=oa3nw/HkdF/jHiTCKSOuB1FCUNwFFS/uRvARftmnesUpjgYJHlzV9mxS9tDwKk0OJgm6
	 GlxEpGHteXGrPj+PZRdlGVCfSIKG6BjtpviOa0mui9ylJRDIKMKgHanII4C3PJI6bjInx
	 3+wV8n/xb6Zz7JqfrxBLpiqesB4i3LJJsqBepUHD0O6UqN8yqNkKNLaY7u+1P0by6vxk4
	 SCf0cOnl5ukK9g0N/wx4q1AYpuRJWETCY3ARbKgEFaT5xLHlLQjbc/g08g+qNH/MI3D2G
	 hwTTUSw/Q73osnsNj4JJ5/ZwvHMLzSUOgsHYTJzS3KoR7w+ZsEyPm6Y733YbC6gKdug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gxXBWzOI;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034E5606A31F
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 05:07:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 034E5606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gxXBWzOI
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e987b4a710so1882495ad.1
        for <linux-serial@vger.kernel.org>; Wed, 28 Oct 2026 22:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793250431; x=1793855231; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rjNfMp/WtzafGcb6uGtU9HJkhzqRTyKQwukVNkTGdko=;
        b=gxXBWzOIzzYbbu6ef6LGYmLO8fWD6f0eljqy64TeJkzZMhV0XUHIcnw9LU4bReY77a
         naHCdoXxYHI4UkY49em4x42TiVquywCZf3why4XjZ9wmk3fkxQ0BQJoFBznNDeuQivh+
         g5V6u5REf8JcdbMq4jiXBNa1vOFFVpdzX/SRPF1GpdD2iQFsDXpdc96DPh77RJdl+Fvu
         7f+acoURMStFLIeC0rnxbsQq32wMFfFekoojVjAPRDV1SGiYdrto7tiBORSbnisc954A
         4dLySoYXUWBh3yV4B7TXljbtbC4/s8NlPS4c5j0j4/AofIkRLy+J7axNwsC8bSudtHiB
         TBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793250431; x=1793855231;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rjNfMp/WtzafGcb6uGtU9HJkhzqRTyKQwukVNkTGdko=;
        b=RBT0N5ODKIT1yLH5o2cZNQh+1FSsXPhFYJ2dx4POUk6jmL2fozFDQJewY5Faz+Wqz/
         WYjM594jGO028NiIk0i5npmMv+UxXTXF7t2vOPsBgnWHJo1d51osR7bGIQ+hIhKes5N+
         bfywPFkScIegw05/451pYP2Y3xEgRLp1GbP8MjAA2Fr3KZbSkaoTNatDO9+kCYfsVMH4
         vqT5zOTBTrX+mrHLxfzeKQWRzn4hyfXdk4I6Jvf2lELmIPKnVaRQ9fL5ZQqBnVeKm7Tx
         IHNWEvp8jhA4nLnvu8RMfBOZ2wqc/hZ0yMoiU5jtf7JoF9pi0IMK+3qEbHnwDhMCyR97
         9GKA==
X-Forwarded-Encrypted: i=1; AKwUvBxVmKQUWMBl+iQixjXI0GoCpsFLW9A5D/I1e2Md/5JZEB54y1OBmD36ogYlElqyxn5cTfmFvkiI7KP9Y6c=@vger.kernel.org
X-Gm-Message-State: AFq9FYKMlCLjNaTlPacb37VolQrX+85T47YlQj4BnGz4RglAgTO7XZ0q
	JiFqE8ezXcYJe783fAvYfT8X5wI0yuwtY7eHIhKdpHp/4v2TQqrHMt58
X-Gm-Gg: AYBFou0S6rupn8Nf3vvMege9A9x1j/WXTatCp4ok47VJarkLVGOKrqqRTBeiXAE3/6z
	iiGHS+3S4clEF5bLiRFgcS8P9zhQLS967kIb7zhaZl5rov8jrJZm4gg+CZY8HPb8qvZxff0Wamf
	d9km4ByaOPO/y2Dc4nhSpFO2+AdBqxfnT3eY2rXtjxuBWCUjSkj076iDFYSQD9Kiy96W6D3uBYx
	SeaDTZP0yq4Bz8BhxaRcHepHFOKtamiYBXS93N/2VSswUmOGe5kDzUP4OvgJKTOSSOZd6PCD1Ux
	s/2nMHPVxy7+ZvIID1WbeOKLhrWIq5Seb6mCHdZAbapLYxfiQCDPw26VdqXi9SeutTQ8hH0NHLU
	Q+8WBHQvNSA7oK/XqMRhlaHWEmAp3WsEsMEV97fPEwaKvbJo2pKwcan9yxLJxsRzDGaSV9mf2Xh
	KE52tcI5Pyp/0yPdTFqeLDaysznhK6TNZZjZxyRaYIpHEGm0EIpxs5Aiq7MU1UlKc2or4mLcYfA
	bbqlpAUicR5VQDUQqqmcRF1czh/2pVgLtUJyRfQQJcoDjxdYWU21rub3VNksSDQjXNOw/2vH0sz
	0CWbsr9JZZVRe9Vp6yV1XE1Lm41y
X-Received: by 2002:a17:903:11d1:b0:2e6:f3ed:a551 with SMTP id d9443c01a7336-2eb1aab257bmr10272905ad.8.1793250431325;
        Wed, 28 Oct 2026 22:07:11 -0700 (PDT)
Received: from [127.0.1.1] ([169.211.140.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c9d2cesm28159685ad.65.2026.10.28.22.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 22:07:10 -0700 (PDT)
From: Kwanghoon Son <asdfkwang@gmail.com>
Date: Thu, 29 Oct 2026 01:05:50 -0400
Subject: [PATCH RFC 09/12] riscv: dts: bouffalolab: Add BL808 SoC
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
Message-Id: <20261029-rust-bl808-console-v1-9-b736ee920078@gmail.com>
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

Add the BL808 D0 CPU, PLIC, CLINT and UART3. Leave UART3 disabled for
boards to enable. UART3 connects directly to PLIC source 20; firmware
sets up UART clocks and pins.

Signed-off-by: Kwanghoon Son <asdfkwang@gmail.com>
---
 arch/riscv/boot/dts/bouffalolab/bl808.dtsi | 70 ++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/riscv/boot/dts/bouffalolab/bl808.dtsi b/arch/riscv/boot/dts/bouffalolab/bl808.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..c739c77960c4578b87fcf2bc096ef7c8cda089bd
--- /dev/null
+++ b/arch/riscv/boot/dts/bouffalolab/bl808.dtsi
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	compatible = "bflb,bl808";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			compatible = "thead,c906", "riscv";
+			device_type = "cpu";
+			reg = <0>;
+			mmu-type = "riscv,sv39";
+			riscv,isa = "rv64imafdc";
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
+					       "zicsr", "zifencei", "zicntr", "zihpm";
+
+			cpu0_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+		};
+	};
+
+	xtal: clock-xtal {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		interrupt-parent = <&plic>;
+		dma-noncoherent;
+
+		uart3: serial@30002000 {
+			compatible = "bflb,uart";
+			reg = <0x30002000 0x1000>;
+			interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&xtal>;
+			clock-names = "baud";
+			status = "disabled";
+		};
+
+		plic: interrupt-controller@e0000000 {
+			compatible = "bflb,bl808-plic", "thead,c900-plic";
+			reg = <0xe0000000 0x04000000>;
+			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>;
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			riscv,ndev = <82>;
+		};
+
+		timer@e4000000 {
+			compatible = "bflb,bl808-clint", "thead,c900-clint";
+			reg = <0xe4000000 0xc000>;
+			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>;
+		};
+	};
+};

-- 
2.47.3

