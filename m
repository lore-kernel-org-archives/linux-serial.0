Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793250389;
	b=mG7b13O1p9uaCFxY2n0I5mV8gWh+ta9rAv7iqdwV1vlJsJ1H3qH2NxH+jhwWCd77GYof
	 0NYa2opMEDhYiBu/1t8wzRy0zX8yw36SN0WWOypw8B4QuPmdgecVF+U4fdDtysRV8AzXt
	 vfMRbTN+eGwfI5PH+6shbyss4x4SFRegiC6isCyoOD1IlUpOdtaw3kFtMYcWS7MNQscub
	 6BLIIARBsTkj68Pi/KuhK5VSq0w8JywLl1gkzkODPtZ7AhVrxgQxsNH34IKNmyDFhjoGo
	 JxvB2eeNHU9Le4l2qxq2gxvNvIaaJDdX9c7+XPk0/c7XInuhcNqlqP4bZZgvu7wPTDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793250389;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=CovTA5I7uRtS+rK/MoAKpr4q/R4ofKrh6kdcg3ZjsRk=;
	b=ASG7QmXwPdAmuSIAVm+zZ6dF3DaU+pDbRJL7g3AHdcaqDF1PdV1wmRKWLTFl3sNURgPQ
	 +tbvkgXOglPqXFIrtPvzKpqlbACR56ZuhB1Ywsyiq8RJg0e3KFoE6lD1hwulSYyCdftEx
	 oTu1RVJR/RgwLD6pBTHMiERyybqMx3VBCqLoOdlwB/cqOHQQ4QHDAHSoK9tHQi3+nDfo8
	 qoP0ztPsR17p9vrXQ2Go0q5G/oNee1naPGPNxgptlFQWg4CpnzVea2tIabhLHZD+Sj6lE
	 KvtP++Jisgvpf35JdN2k7YVk+4KTo9gU3u1biHkT++0uO5JdR8Rsm8tifq3Rq547/KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iwxsLAlm;
	arc=none smtp.remote-ip=74.125.227.136
Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A87606A31C
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 05:06:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20A87606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iwxsLAlm
Received: by mail-pj2-f8.google.com with SMTP id d9443c01a7336-2e609985789so4997955ad.1
        for <linux-serial@vger.kernel.org>; Wed, 28 Oct 2026 22:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793250389; x=1793855189; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CovTA5I7uRtS+rK/MoAKpr4q/R4ofKrh6kdcg3ZjsRk=;
        b=iwxsLAlminzYvBptDnBRm5gwKSr6xNCJXMFvGuDNq0B6sxOcBReZ34X15VYNkogTLq
         BCsstjXwc94FjXK/lY/5Fw2+rM0edRohKTYo8s9Trd3WGF0eMK0GFUxCrw5yDELYHMk9
         hwMJIh1iNO2j0n3YzTWCHRizeFEpMoCD8Tqoa2k0BXdriokc3guSNz9e9UYwqB5oGwLH
         L/DcmDcwMTXWm50BtOe+zbUtX4f0y0yP8mNAEveiEDaL0xuzoP/IAhmvy6/u2tDm98mH
         10LnEZGfAFpQaU9stluVmRqJQvLJMZAnbUf3c8x9DWNqYQbq/R35LQVUnFG4XQoTvmlo
         +2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793250389; x=1793855189;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CovTA5I7uRtS+rK/MoAKpr4q/R4ofKrh6kdcg3ZjsRk=;
        b=FXRSH8jogSOCa0tCqN/bFY9Re0kdUfDilKV3qr5U3Zp8CLHnFIU/RzHxlcY1DIo5BC
         UugavtmksgVY4mBzEpzDDZUWKbkjggegXyjxnyuVrOBYpJkSF428N7BEwmrkKx6hnxON
         iptIDxl6wpB3+B1uVrRftxqX/yxvA/I4XpY8JuRgVSH5WAPuP5vS7xIw5m8CmKTDeeFi
         J91NwfwTBGpoGIRu8PV3GQ7LTRge/OTMD18X/gb0cKEMoMaqgIzcgtjAjO1J3weN16va
         w53VeA/8TB1wpm6AEdyXiM11MwhcgL8nVgQVspl6nzrDXm+PxFU+6RaiI7WlM0mUUEZ1
         w6AQ==
X-Forwarded-Encrypted: i=1; AKwUvBxwP++TV5cI3lWjcBKz++0cU/IM0AjDr4QLR4ZDgsnxm+ZdEbBc8dXNFTVJmt1NEtTCkFsh0sZYbW98exM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIhVQx598CnoCAAo7powkwijZCcS5LtvuFiVSpb6MdjuoJlqlMk
	Vqk8SiOprUXOXTAoA4XFTS9BMdgGPbzaBCZlFn8ykAZSSyxYAb/94Guo
X-Gm-Gg: AYBFou1aQ2EMiH/+NlSyCegOmMB5N59/DwRjX19TFpmUc/fY5m1S4MF/PeC4Tnvx+O+
	FjxcZEIpAs5BcJHBipe5M1rTjMSFZEiVCxfpT9mT3sN131plmUY/2rcRadLvf5JXdKUImsgEApS
	Xpe9YJZyXVISfhFzAVbdGjOfRqHkLoMJHaEZc8cXvSXJsjlZL37gvI7oqGoEDKscHb9+qtEQ49S
	q+iu6jXjMq5y1kyFt4t5Ncx+E8sFv9k9iywRL92wJBPBbYpasFternegj0D2lRdzil/jCsJ3tdX
	HFjzo9bLekZ0RgWwzeKTTNtWJR2DRW2GC+2nOXXdwf38sKNb7AAYJV5LFR83E5V8nqPFXuSYLYX
	YeYThwDoHCXecUeadW8Fxyn/CvIqrgpv4vlvK4oBCKXCLo0oeKhf5NRXo+OWxnRxuux9RI/gZm9
	BjSb3sqOQgcBJjKrOCEzriW9MGCgP92gFVg0NACIIAZ5iQl8nJoYN0srSNM6Rphdmqnqlgcn0I4
	7GQsJI9mRbtT1U5E1OBzEG+2NMSOv/scVKLKJUP2GEBsFqKIjLscmOewLQn4LTBFIOHUf/g3Wj3
	AhFHJ04dSF5glkLGreY3/jBDIQQy
X-Received: by 2002:a17:902:cf4c:b0:2e5:467a:7a6b with SMTP id d9443c01a7336-2eb004f2a79mr39853755ad.10.1793250388648;
        Wed, 28 Oct 2026 22:06:28 -0700 (PDT)
Received: from [127.0.1.1] ([169.211.140.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c9d2cesm28159685ad.65.2026.10.28.22.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 22:06:28 -0700 (PDT)
From: Kwanghoon Son <asdfkwang@gmail.com>
Date: Thu, 29 Oct 2026 01:05:45 -0400
Subject: [PATCH RFC 04/12] dt-bindings: riscv: Add Bouffalo Lab BL808
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
Message-Id: <20261029-rust-bl808-console-v1-4-b736ee920078@gmail.com>
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

Describe the Sipeed M1s Dock carrier, M1s system-on-module and BL808 SoC
compatible chain. Initial Linux support targets the 64-bit D0 processor.

Use the bflb vendor prefix shared with Zephyr.

Signed-off-by: Kwanghoon Son <asdfkwang@gmail.com>
---
 Documentation/devicetree/bindings/riscv/bflb.yaml | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/bflb.yaml b/Documentation/devicetree/bindings/riscv/bflb.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..a3c14fcc6c2e9fd6297cc2556c1525f4bf8e90c4
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/bflb.yaml
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/riscv/bflb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bouffalo Lab RISC-V boards
+
+maintainers:
+  - Kwanghoon Son <asdfkwang@gmail.com>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    items:
+      - const: sipeed,m1s-dock
+      - const: sipeed,m1s
+      - const: bflb,bl808
+
+additionalProperties: true

-- 
2.47.3

