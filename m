Received: from lf-2-31.ptr.blmpb.com (lf-2-31.ptr.blmpb.com [101.36.218.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AD12ED15D
	for <linux-serial@vger.kernel.org>; Sat, 14 Mar 2026 23:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.36.218.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773531791; cv=none; b=pebu1JZcP6xv3CaNObASe0cUYoAzPnFpegNY1yLVh+NWJc3Vqh+v2Qfu9FKDYa0qNV9Set+YB75wglNFkTNoXWjYw80WQoWpyFGMhlXq0ULxYeVACu3U/ZiTru1haJbk6RCXnkgStZqJOenLT754o0jfp2fAHKdInS5EClHxvT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773531791; c=relaxed/simple;
	bh=jm7rXByn7R76HvNJnKE25FhL+cyLR5bGS1nz/RgRzb0=;
	h=In-Reply-To:To:Cc:From:Subject:Message-Id:Mime-Version:Date:
	 References:Content-Type; b=AKeFI8bRlGeFd5D8DpauaKJmgwDLjkFPX45iRpyBczGDk6XQHZ7DWNmpH15IgBswBx5rnhVaj+vgDEY3QZhbSo8fCwSgEobeu/HzeGjAzKLBzdbfEmDtU7AZEi3F3ALdgLg0buN/F4Qjo2Fq+7VJ/iSH0kyAHSAhx4vCsXscNvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cipunited.com; spf=pass smtp.mailfrom=oss.cipunited.com; dkim=pass (2048-bit key) header.d=oss.cipunited.com header.i=@oss.cipunited.com header.b=vlQ/m5bI; arc=none smtp.client-ip=101.36.218.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cipunited.com header.i=@oss.cipunited.com header.b="vlQ/m5bI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2303200042; d=oss.cipunited.com; t=1773531709;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=NuHxZnrmW9mfPVCNo1dVIioyYd9nuGxeDz8GheH7iCw=;
 b=vlQ/m5bIbb8C8UgcB8z0cE7F6mKN/tCZG5QHy//NZsYWfkCHIkCslNuVW91rtk/02Wwn6+
 /mVe6QzVxmtvijmbg8pgyX4E0fbj6p3R9GFZQ9Hxso+Z2RlaP6iERnvI20rBw11ZCc2QVF
 YHwa0YAsJrthg2Tw3AKFbBACDYIV2G986SBy3lznjOCHeQCXYQ/yPZ2hpNe8aGW8Ky2TEI
 pRkqWIBes/9vzLjpEvfJyUE/f2YbgOFgFbv7w8cAa+i8LPMVFd8X8YeJ/JD5aV2r8yGUK5
 wmZ0fl6NltvLcVOGEKEMu8Nvlra4ubywhAXjREhWINjfqMgpKpKs7LEpa8vqtw==
In-Reply-To: <20260314234143.651298-1-rongrong@oss.cipunited.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, 
	"Jiri Slaby" <jirislaby@kernel.org>, "Rob Herring" <robh@kernel.org>, 
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, 
	"Conor Dooley" <conor+dt@kernel.org>, 
	"Thomas Bogendoerfer" <tsbogend@alpha.franken.de>, 
	"Huacai Chen" <chenhuacai@loongson.cn>, 
	"Jiaxun Yang" <jiaxun.yang@flygoat.com>
Cc: "Rong Zhang" <rongrong@oss.cipunited.com>, 
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>, 
	<linux-mips@vger.kernel.org>, <devicetree@vger.kernel.org>, 
	"Yao Zi" <me@ziyao.cc>, "Icenowy Zheng" <uwu@icenowy.me>, 
	"Rong Zhang" <i@rong.moe>
From: "Rong Zhang" <rongrong@oss.cipunited.com>
Subject: [PATCH 1/3] dt-bindings: serial: 8250: Add Loongson 3A4000 uart compatible
Message-Id: <20260314234143.651298-2-rongrong@oss.cipunited.com>
X-Mailer: git-send-email 2.53.0
X-Original-From: Rong Zhang <rongrong@oss.cipunited.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+269b5f23b+1f9f80+vger.kernel.org+rongrong@oss.cipunited.com>
Date: Sun, 15 Mar 2026 07:41:41 +0800
Received: from tb ([223.88.91.90]) by smtp.feishu.cn with ESMTPS; Sun, 15 Mar 2026 07:41:46 +0800
References: <20260314234143.651298-1-rongrong@oss.cipunited.com>
Content-Type: text/plain; charset=UTF-8

The UART controller on Loongson 3A4000 is compatible with Loongson
2K1500, which is NS16550A-compatible with an additional fractional
frequency divisor register.

Add loongson,ls3a4000-uart as compatible with loongson,ls2k1500-uart.

Signed-off-by: Rong Zhang <rongrong@oss.cipunited.com>
---
 Documentation/devicetree/bindings/serial/8250.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index 73851f19330d..1d1f2a22776c 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -179,6 +179,7 @@ properties:
           - const: ns16550a
       - items:
           - enum:
+              - loongson,ls3a4000-uart
               - loongson,ls3a5000-uart
               - loongson,ls3a6000-uart
               - loongson,ls2k2000-uart
-- 
2.53.0
