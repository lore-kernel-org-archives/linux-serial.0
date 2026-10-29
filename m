Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793250423;
	b=xO2ArninJ7gYAimn301SpA9qbdbQZ3UOOKWP5muT2BZvQHEQU7eaWd02Z+tjuaOlNnWO
	 NEXHiA2WtfZ+3HbkIW8MP+I7ycQoTtZNJ8q/GkYfUnwCeF2ZCm4WRQzbaw2k9zSLYtR5b
	 vMqQWjjCGis1MLO95darxHw39jlvugWg/mDij9y1wHHJcK0342f6prbvQzxYwWFdDEoS7
	 YmJ+dnISr2VUvvTna7fhX/X5j6ggByWJWghacjdCWkAGTWeOmj0Fnemn6+tqjllU0Cg/j
	 U8NH+gyO+BvrvT6JBbj+pmQPIOTq4X96s2q96YEm3L7hK+tqr1hlavfGyI6F+PRvJNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793250423;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=Qf62xHUcdwxTQhTGo7oUzUtykTsLWeHZ04Gslg9ulB0=;
	b=kSBgF+CytWkDy5fikXJ+xq03NiW+i/gc9IxK6HJJlF3tLX5QCFLKvwPKA+LEFg+WCkmD
	 Izv5dR38V52IE5kyQSigXYC7yWtgECevSBrCN05wjMzpI/AGXtzVLwmkhsH9hNyfHzQ3h
	 cVJvQilpEpU5Vr8NLIy1RlvnxGI83jKS8jWFHfMdKhxigHta1ZuAuo+DGghECXA19qvyG
	 YBLOrO9BLJtl29UZG6EF8hwKrjDfKG1TwTgz3RfGBmAikZ4o+u+y2PdVznSRIae66UQK8
	 YFIoPLBzJRG0otE7KJZUN63POlbllpWcLm+jtrYX1wQLlYfUIOf5h9X8HitczO+dOxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jwi35f5T;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097B6606A31F
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 05:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 097B6606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jwi35f5T
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e946155442so13511415ad.3
        for <linux-serial@vger.kernel.org>; Wed, 28 Oct 2026 22:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793250422; x=1793855222; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qf62xHUcdwxTQhTGo7oUzUtykTsLWeHZ04Gslg9ulB0=;
        b=Jwi35f5TK9NEOrvRXbIbHQzmViWwUkuV5Yy2ISL3C1ivrmVTCemVIljYoOy17cn6tr
         JpellHJL0zQ2nZkUX3/lgwEsUKH1BYRMQMIOsP3IslcYVdkK8PelyG84J99oY2ImCKp/
         55ll32AMYAjoWN/vskYDkhwQXaWxDKazw31V5nbbsQdJINvYsITVg01imn1HCcwPlRJq
         aBMgGbvl9K7u7gZKwBWNZmEHSCVJJ20ApkXi5XJqIsPHH7R0GJqbOEs1zj3ndDEh1Af6
         GrDz4L1HQ5WSRC0GzdaQATInrIFjtfW5Py2Iz1/GTzjdm3V1u/2N3AUZIn/G/n1lvNHL
         s3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793250422; x=1793855222;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qf62xHUcdwxTQhTGo7oUzUtykTsLWeHZ04Gslg9ulB0=;
        b=S8hX8/ptpfz1BOdXx+MetMCCTZy223OrN7zZthLFiWNiba4CVnk998L+840wRoEPyq
         CA1jfDyRsgWt/rS99XoNSPHIzhxztZQTo0bOVPLvvuZCDgwkFiECjET9MITxmTtkm5ws
         WQHAUD0gq5oUuIt3yINmDj5p4SssgPGHsaGA1x6WrH/Xk8pLTFPWWPxLRFeIiLQijORK
         DBYvwqBFjumqiMtYo9nkuu4OEl4K3Ce8SWIwUsu3j2Wrr3ybS2MznckWOHDo7xx3fFsG
         XO11hlnYErRW++sOwCNAPhTHZwDaO+9ij3VI9/PsckTftGJlxw5eam1jjykuZGjNrjmZ
         8oJA==
X-Forwarded-Encrypted: i=1; AKwUvBwxdwatpvylHkqqq45cz5+qxP8xQyJmWYHd6Pi6D3ZN61q9zOKRzotu84VdadUmo5iq77vM5M4RvxxDszs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIetqKZ+h6ex4/MOKrkF4Ib0/uAjSvBB2o9neq6TdrfCPzG761A
	EREsOPDz03J1PtztcG2ounQxYMY54ptNWBalKD0LYj4eptPY37BMn0Gm
X-Gm-Gg: AYBFou1bqkqNpy2jdRz+ZlIfWAhQ6yant65ougYawHjI6GJImdQ8/nYXWixTrG4pzvL
	legPijpDdKHoHw7VXfgSgG2ng4NIOlQCbnXqi0bP8Z6ALRNAWd2ajYZyVwKljSh3pozWOw11dlg
	ewKNC4MOomPKmuzDNDfaOLZGRBMrGNz2hWR5vOIUB/GQ9ZJm587qFM6/cO0KU/mGVS0nycDG025
	RokBQ/0tqUmC01EO12RT0DUYg7Cu5nQycQ6zE2VO8j1FMVtX9JnZ1eejwlspKbbSmQEmERPV2Rx
	gBO0gWmFP3heSj0E9xzAznvmi5gW2+PYyy5p45mS66hLcJY4GvZ48bCuFYrxhiwxlyHctjmJ+t5
	F8FrBbo0f/e2JnTK41FqUHCmzlnPFqq9+ZmcVMatB2+4ARGGGKNYPcm4MNXcZwKkS7JgHhZd4KB
	XCfwTKzO6H+XzVQXLIRYdf4sVtY3KDyNHnIpnfsOavwdKB7zSxBfR5HXKJbHD7Fut/Mt8rRMVnE
	jEu5ZTxoUigb4G/9L8P1yN5p1nviZEGTo0TqgKnDzmPKJZwH4dGxjT7WOsBGo2VxMUCkFcp49QB
	l2IyX9eNmBmMRAY1tje9gTkuR0EC
X-Received: by 2002:a17:902:c40a:b0:2e9:4048:3031 with SMTP id d9443c01a7336-2eb0054029bmr40770025ad.39.1793250422229;
        Wed, 28 Oct 2026 22:07:02 -0700 (PDT)
Received: from [127.0.1.1] ([169.211.140.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c9d2cesm28159685ad.65.2026.10.28.22.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 22:07:01 -0700 (PDT)
From: Kwanghoon Son <asdfkwang@gmail.com>
Date: Thu, 29 Oct 2026 01:05:49 -0400
Subject: [PATCH RFC 08/12] riscv: Add Bouffalo Lab SoC selection
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
Message-Id: <20261029-rust-bl808-console-v1-8-b736ee920078@gmail.com>
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

Add a platform selection for the BL808 64-bit D0 processor, including
the T-HEAD errata and common clock framework used by its UART.

Signed-off-by: Kwanghoon Son <asdfkwang@gmail.com>
---
 arch/riscv/Kconfig.socs | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index cecbce0c498384d3283ed23cbf2514391eee361d..ea4667da7716a9a8d2ae156c422b277064b42530 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -12,6 +12,14 @@ config ARCH_ANLOGIC
 	help
 	  This enables support for Anlogic SoC platform hardware.
 
+config ARCH_BOUFFALOLAB
+	bool "Bouffalo Lab BL808 SoC"
+	depends on 64BIT && MMU
+	select ERRATA_THEAD
+	select COMMON_CLK
+	help
+	  This enables support for Bouffalo Lab SoC platform hardware.
+
 config ARCH_ESWIN
 	bool "ESWIN SoCs"
 	help

-- 
2.47.3

