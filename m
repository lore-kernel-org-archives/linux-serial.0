Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858B61990AE;
	Thu, 27 Jun 2024 15:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719502376; cv=none; b=GG0wOQH8pdLI9/bIv/wPp7w2GI7sV0dhPJjWdPAf00Upy671UR/T+Zeofm1f5Ib9xfWKJwz2CNyw9yJ95uPkrK8cho59YyJvoCjnhwX86NqFhW5w2lD9GcX2bxn1qZO7JgYTMXMrSRwN6FI9tOToN+oCqB1pW2pjVL7ww38IfwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719502376; c=relaxed/simple;
	bh=ryEHU26hC2m6o+qKz3yQBlyDRFU6B17IZTG4/ovqvoY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JKtz9q75AXukIw4AkU2iFmWzSRz+0WvTVYextLs7VVUdQL2qUgYYhnAcZ7RmZVV7RtGGZ+emunVTnh/bIilhU41B4yNmv2FLcSrNWfeAbKDTZOjQRC5mRpazEM/W6JlRfmEmQOvd+AML2gqXECT7py39sFNek26bSxKsF0WNm4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Yixun Lan <dlan@gentoo.org>
Date: Thu, 27 Jun 2024 15:31:18 +0000
Subject: [PATCH v2 04/10] dt-bindings: timer: Add SpacemiT K1 CLINT
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-k1-01-basic-dt-v2-4-cc06c7555f07@gentoo.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=974; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=jlJAxtgKZpcQOsCvH4z2K1QJ+1Ic6ECnm70OutsapPk=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBmfYXpKAR/bCQvjdy9lSXYBFTh1lzfuFwG3ENLm
 sU1PZ2NnVGJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCZn2F6V8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277RIbD/0Ypzru6itSvvzThA
 fWnHbEAURPxmubhKUNVrGutgsOcGFV0xKw8OnXD10MizThQVF7Q5oGNR98sxYvaZW9EpGTDJBr/
 uBoLaZCeRoRxQykUGlvr73BGDwxEkcwbPWcF/nbncR06D1OMCohfmFRIESVb/K+a2bRtbLkZGPn
 vXljDi9wqbyAD8BkzM4chLs0BhntIGF2SzUJjddJ1fQm+Z5c4nUqECALKbNKVoko4jkF1Ih8z9v
 WDEswiKS8J0oLHbf1U8w2ZoLYgO66BejC2/RhxwHI2MNAhWex+n2MHAi0GCbX1FHAOU39uotMtD
 YPLB3fzd/lpdA9D+hypeEaQWf7hM41+qHrMYwaJtbK45nMzlHSPkmNA4LGHVc4+HGNcydwRK4+g
 SbC4e3e9Pihj3ZqtKGu1WWs6Qme7g1QM7y0k0hAlfIxl8dk1oFcpmVQkZoajzHHAZI9aEsPVoPQ
 szwRMfWh7e02hhbp+R8BjKivsq1Fm9JmYGZnRRnBoogsZRqdQiSdMVdmfsdSqZJtWVEk0ixexfg
 Q6YoaeiVnGNKQykAANUgx4gaqhVKRrLGJkVq3OlTPRgN0jB2WPyBd7nGcJLWYHkNhioLz53vbjW
 kPZA00kuCTmPa6s5B0BlYO/x5oHSfGOXNIyQAVRBm8V/5iG7IeLEUZf+gTa8NvUyHxeA==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

From: Yangyu Chen <cyy@cyyself.name>

Add compatible string for SpacemiT K1 CLINT.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 Documentation/devicetree/bindings/timer/sifive,clint.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
index fced6f2d8ecbb..c2e68587a806a 100644
--- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
+++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
@@ -31,6 +31,7 @@ properties:
           - enum:
               - canaan,k210-clint       # Canaan Kendryte K210
               - sifive,fu540-c000-clint # SiFive FU540
+              - spacemit,k1-clint       # SpacemiT K1
               - starfive,jh7100-clint   # StarFive JH7100
               - starfive,jh7110-clint   # StarFive JH7110
               - starfive,jh8100-clint   # StarFive JH8100

-- 
2.45.2

