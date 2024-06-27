Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870301990BE;
	Thu, 27 Jun 2024 15:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719502359; cv=none; b=ndTmyLsT1iQ7xKLtFRJ5FNiK1+MfzVkjyMGmmN+1yBiRkCM3L0+0wMBTyPhKE1HX6i/cwAB3Ld5VtrpNk1e/2UFwhFFL0E7iFk360B+sXWxFsQdu8JjsOplX8RFmymFzLMlbuju0OYnDGdAFDNE2ZuBGr65DdGHrOQWfgf3zGXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719502359; c=relaxed/simple;
	bh=e2VERBSC3hvoUe3+71zYxaKEO87k4x7VETYOMNHFzPg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BPEezY06TAvNZxBShg5XN9YHb8NhkcfA4NkzSDl60IzyplXw4w/L9WBRMA70HbQifwxGos5r7YctpzpfXO1sDjaMGj/mnDTeR48U/lQt0Z+LC5Y0mYA5wnW8SZqHvWThrkEH13wAGYAUwXizy+T4I9hlV202uo0WuRuo8MjqYm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Yixun Lan <dlan@gentoo.org>
Date: Thu, 27 Jun 2024 15:31:16 +0000
Subject: [PATCH v2 02/10] dt-bindings: riscv: Add SpacemiT X60 compatibles
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-k1-01-basic-dt-v2-2-cc06c7555f07@gentoo.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=853; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=oiadtAT5r7xDGzsCnaCGPJ2frMTxz+XpkwmHxkPFkkA=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBmfYXjsrZOKxCkQrojHnkDrw7pdrxsCq7ycSSsn
 /C9MT4rJyWJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCZn2F418UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277RwQD/4hzCsplIb2vrQt9n
 5IXGzH3kWcO5Wtvxw6BcBTbWTVcA0hMvgoxjVeVIOlsmUAcrtJqKuK4dskwimO6KOVhXekrZzxW
 Lv5YMu1bJnPMNVvEnNdWFKR2PLk26ncFYAA1hO/1Fk3MRXwCFsAzMTpAgnVgeDg76lucL8pJpkY
 PtcZI5NATDRsxPvvgiv2+UziB1KrFd2hUgel6BTFo8GAY2fNDJNxstMtpDAz20xCwEwQwWphEVQ
 rDT0pgrIjCExeRud32LcP37hWNT4Y3vLiceZepRtl5C/GV0wIvVuRy5eFQfVzij7KT+nxR1OwtI
 RxgzzsVhhla0s+UNS2uyZlLJe4pSfSZ+q5Ow16LuoXrIR6OPE1oNQXxn+zggYHVq51vnGISfzJl
 Szx7htGmM5WskMVzQ92wSMhiGVukwfkS0l+ew40E22OqvV181B/TOQQ+uSbNaGdpgb56pL9FACn
 GuRRCs3GMIveibo6psuy4FN0Y7p+2oUyrBumBMNu4Y0ebKQB9FWoOqtMp8jmm1EsaHQvLlJbxR+
 naEblORmjEiRmE4G1KmFs20mvJqr4YUj5KJY2j9lVMsX9U7ESNgxkwbS+Z8boltEiiKA+WOJ4ih
 Yysj4umnW23flwGzvqopfZoZpj6yJNvcmt02bn553k4ZzdCO2QFiAySGpS/i7Mls8wKQ==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

From: Yangyu Chen <cyy@cyyself.name>

The X60 is RISC-V CPU cores from SpacemiT and currently used in their K1
SoC.

Link: https://www.spacemit.com/en/spacemit-x60-core/

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index d87dd50f1a4b5..5ad9cb4103356 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -46,6 +46,7 @@ properties:
               - sifive,u7
               - sifive,u74
               - sifive,u74-mc
+              - spacemit,x60
               - thead,c906
               - thead,c910
               - thead,c920

-- 
2.45.2

