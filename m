Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67961991D7;
	Thu, 27 Jun 2024 15:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719502380; cv=none; b=L7G+52OZ2OfbOJ9f6K1Sj56DpcNhHFZOgyw9NTORYfzbGVtCkIJ38EzsHJ/nx0Ae/X1Ap8fEBKJHz0WDhxjxvO+AcXkfWU+/LPqoUl8iiGZ2T03TUw48dntrwNj5UhWenneC7nibSExILrLhPPsBuWU1v/NRw4Z7po4/nT9++ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719502380; c=relaxed/simple;
	bh=Xq3EPz3Bewa4lpONxr7fD/RU/vsUKnqdk0lFgB4kADA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SK60CKinfqyAMba8Ad6q+uUtKHanTrAL121lAH0H5nSGjClOE8LVdcVDxPvs5qRHtZj5QNtMoNoU1s2jEFxCszi7nDE7KCKgjQKOpxLFVmBoljzrSyjImSJ9ZlkBG/qROOcsmsOy8V/+ro0h2UvwQXVSmCYCkqw5M46rykoS84I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Yixun Lan <dlan@gentoo.org>
Date: Thu, 27 Jun 2024 15:31:19 +0000
Subject: [PATCH v2 05/10] dt-bindings: interrupt-controller: Add SpacemiT
 K1 PLIC
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-k1-01-basic-dt-v2-5-cc06c7555f07@gentoo.org>
References: <20240627-k1-01-basic-dt-v2-0-cc06c7555f07@gentoo.org>
In-Reply-To: <20240627-k1-01-basic-dt-v2-0-cc06c7555f07@gentoo.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Conor Dooley <conor@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Anup Patel <anup@brainfault.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Palmer Dabbelt <palmer@sifive.com>, linux-riscv@lists.infradead.org, 
 linux-serial@vger.kernel.org, Inochi Amaoto <inochiama@outlook.com>, 
 Meng Zhang <zhangmeng.kevin@spacemit.com>, Yangyu Chen <cyy@cyyself.name>, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1319; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=Sd2cefvtLvue4VbNU8TlhgwBKtDTSAfC6Dit7xBpOS8=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBmfYXtHABiNrlEMZ8H8PALGClDGbpzYcf5kjII5
 gjtZqMg91GJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCZn2F7V8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277cTRD/wL9cUA+WtRnqxAtx
 pPkcr0X7+bD8Vm/RB6GWmre4+/fQQjJvnxmwXjgIdPdMZmbY6ZmvXZxX93QiuOp2prCvNZkn7T8
 nZaDWvscXO0pjnGTWOeDpIWx0PZA5ZEkgBP5NW/PL9TVPvFydVF8kQ52Y4Xpm/sp3mEvNWhg7id
 uaXN+sdt7FTL57nEpx79gqWh1N951Mn7q7YsV/Y+f0pOdhrO/AJCnqU60+z6eYyiTbRWA8weq58
 1hduSuS3p6I6RxhjL1WSW1NPkhGhOQyUQhw/5ZbfCdfA2BBfHv4txaXerbZu1qev1E8fiyHMqN0
 aR5iGUUaNhhNJEAeiRmhmIIBtBBvVBuQHpbD+Z8T49ljE76LPsg+BwSyPLgoI94zLuyOLdTXtV/
 uoyYgFTRXvCXo2WxTtXEHDEssgbLdlpZOszXc+lLcvwb2nc0jeuFYUe9cH+3pYg6fwRRsn7fSrt
 pKKIDtgUe0BG3y4BYINqUziWdt72MWRJZoRszv9ozTmA3wBnS8Szeg3IxgO9dXRH4YS6RL8I32T
 KRh90JCOmJakUjp7KFf+pKACEPjyWiHEEw3BK5NHUgqLkDe4lrdlfXWy/45rTYarHbjaP8ThlY1
 p7ymVah3Qz5a27uqqA7h0ysWeGcq2ysI8NpsIfDBEvA5nmLX/r08zQDpg6xVtfVjE8hg==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

From: Yangyu Chen <cyy@cyyself.name>

Add compatible string for SpacemiT K1 PLIC.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 .../devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml  | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index 709b2211276bd..3d0426b569042 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -59,6 +59,7 @@ properties:
           - enum:
               - canaan,k210-plic
               - sifive,fu540-c000-plic
+              - spacemit,k1-plic
               - starfive,jh7100-plic
               - starfive,jh7110-plic
           - const: sifive,plic-1.0.0
@@ -71,7 +72,9 @@ properties:
               - thead,th1520-plic
           - const: thead,c900-plic
       - items:
-          - const: sifive,plic-1.0.0
+          - enum:
+              - sifive,plic-1.0.0
+              - spacemit,k1-plic
           - const: riscv,plic0
         deprecated: true
         description: For the QEMU virt machine only

-- 
2.45.2

