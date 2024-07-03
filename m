Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C1217D8A9;
	Wed,  3 Jul 2024 14:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720018634; cv=none; b=TVxEQA4K9bYnSckRDr5g8zoXq4T3y3RtckrTkeNL5a/hGUnY/QNN0tDXviz/ogfEyhAzQvePQ3Af8Q34XvQKYzfMXVtvBKAF/TJTwMuLTImM235ywzkVPqMUd9NnvBfIYL/GM7qlXI61e/7E4erjutLQfDm9Y0BOAxqttXcP4FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720018634; c=relaxed/simple;
	bh=7bPf74c93KISG1l2PpPGtKZFZIcEcKvCKOaP4od3cEg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ehIKdJIIcPRKk/QqKFy9RTpRF+TjFcTTx7XNa7oVQc0mpBCLG+TrduQL97TS7CSrUFlO/1dtg7/u3ZlsPWDPS6c8yR5vGJmV07a9spxguS0UhXkN/esPo2wYJayurp7u+pJ/UjrioVsicxSIkDo+H8rJfWxFrzWB1lKinJZlPNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Yixun Lan <dlan@gentoo.org>
Date: Wed, 03 Jul 2024 14:55:08 +0000
Subject: [PATCH v3 05/11] dt-bindings: interrupt-controller: Add SpacemiT
 K1 PLIC
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-k1-01-basic-dt-v3-5-12f73b47461e@gentoo.org>
References: <20240703-k1-01-basic-dt-v3-0-12f73b47461e@gentoo.org>
In-Reply-To: <20240703-k1-01-basic-dt-v3-0-12f73b47461e@gentoo.org>
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
 linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org, 
 Inochi Amaoto <inochiama@outlook.com>, Icenowy Zheng <uwu@icenowy.me>, 
 Meng Zhang <zhangmeng.kevin@spacemit.com>, Yangyu Chen <cyy@cyyself.name>, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=938; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=uRDxzRoYQ7f7fJazlLn1rqbODikLZ47/5BjNLxbuT6w=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBmhWaENPQj8iXtrdapEWZeKRMe8hkFBF/6q52xM
 hpXpz2JlHmJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCZoVmhF8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277drnD/sFlyiJvOUffW+pp9
 06mCWwC4Jprn2bPlLQrl1NVJHukpthpKNBHVfB7Nz1PwS1+4XKMQpxcZd7uoR1QMOzeFF3UjVnz
 NQLwIMQli9f8Qbg7+OyCatDYjSRxfbWjUwSxHsN9WBr7HPnNnzUycddyWZcThY1GppqeUMxRxhu
 vTePyd9Ykb4V0j/AozyzaWcYBlYQgx6tdyNLTNh9Cwz28uTvWdZZhlfRbolr9WPHl6eOcnqH9NB
 NQvvu6s7ToLimuGAtIoPEh7W/iJehnnPeY8qIGcxbyDVmaOKY3fg0ZD54qn5OUcFJU0acv3FfjH
 9/zDFLRp7wJZabC+mkqDcs+fQgKRgoyiB29nvZ6IHvYwfdOYs91fizOpYGqAf3c6d+8yc8Rd93V
 Ms/I1DSB7mIYDDf7uTIV2P1To0cBFJLvaIts0ZF6MnW1HJdaiNoG3L/YAlitak6TICB1VBMnYdB
 0wQ/oUeTFI2oOmkZpD5m3WyRVfZK9+J+4pM5ZJ0dzLupqbzUTHkhidkyCooJJOjojZpxMbW2SlV
 s4pho7FgGZ5evKVeJcX3WqHCJpnjzB1QqVvMGmCjkjdNgn/nIGf+8a7tKBoLROWYrYKAman3RRB
 5JxeoEdcA6BwIqjaMjK0HfnHnw0O2kiii6nAJrMPGUPM6l280mwV2/5Ez6yswC3CNckw==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

From: Yangyu Chen <cyy@cyyself.name>

Add compatible string for SpacemiT K1 PLIC.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 .../devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index 709b2211276bd..f473ca3479efd 100644
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

-- 
2.45.2

