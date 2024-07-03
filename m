Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D71175555;
	Wed,  3 Jul 2024 14:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720018626; cv=none; b=QgZ+eQStFW3SFjq0QNTPtVYaWfya7Jg2TORcySGfW3Lzdf+9TKFmFsROvZ84AKYFWc3FJ4b9A+UTotcvzFKYfffm7IREw9Nkq2sUe/Q+4IKUt/mq6qMgxQ9mlN5QRVpgzTi+s3ZN8dcazitX0AqAbTuLrWV0V/zBqb1tXjoZrhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720018626; c=relaxed/simple;
	bh=VvnzgRDmEIAsq9Hf5Ry7MLnNkPx6PUf9JkUVFX7jVz0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V1i2lBB3oLJ05a9QBBlOGOsM88fZ4QqfZH450Edy2VsMnrl+Hka1ISq9ANTHdv6aL8MRFsF95+11fAJ00zOgn7vwoxhf1Z/7tHPSFZyMvLJ7oqp5pRrabqRnbjRY5nKl0zEZytHVg/7v2CwHosLuhARMIrA+afaXOlDWJZWwSHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Yixun Lan <dlan@gentoo.org>
Date: Wed, 03 Jul 2024 14:55:07 +0000
Subject: [PATCH v3 04/11] dt-bindings: timer: Add SpacemiT K1 CLINT
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-k1-01-basic-dt-v3-4-12f73b47461e@gentoo.org>
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
 Yixun Lan <dlan@gentoo.org>, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1027; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=wvQLp2j2KF1DXU6LoDgHk1K3AJ3TNpJmOxUxNu563OM=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBmhWaBQQWp2aqU7XrcJxPyTUTtEBp/XuiWNB0on
 QEC4Emvr9GJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCZoVmgV8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277eNMEACTWkcnPQGnphOvUX
 2NETv2ds+L7S5NhdBAVGxckgr2iZaoVn2Lxk1nDwMSP/kKkO0XIX/nXv/hDkyd2iEg80rAaO4iQ
 GnkaJVteLjezf92iSA+A2VIVCDuS8lao2ii+isw6bFW17zGQyfOPvauo+T7/d5RYg8EtbqcQXv6
 jnUTZmiyt4Exy3vFHbTFfdIs5mZwG2NYYwX6+P8cjXOalemLMUtDjWnysPfyeZ5a0wZtgyarlmU
 cV2j5glZQuiAIg+jZ46wNfqRa7l8SGiTqZOd7rr+3UFl/y/uYux0Suy0B5z0433EC4A6xqhTv4W
 mmNlt2EFUG6sYLxjPnlARyf6rSuG1UBA6JgS0CHFEtwkQHUrJZxqoC3l838at4j+c3Nu5FAlmcT
 6iWTwlqWV4ULGD9ASrh2UhQ4oiczgWUI/FYU7NtE/T75C5VMlkCPb7wWIREM8FBlfpqUADmIwnv
 Z99kyMn6cjbgDj31xwmFYVLAx2K4ZeCgHFWVR1lSYVMo/8Obbd6MFg/YvnBdN0UzyuLt0t2ziGE
 UkvK8daG+5RBcFbv1qvTlZ+KtZZhtIkQzV8dD2GiOqPvGxzBiG87WuY/dORM3b+FOQJ08JiG3ah
 bpB+EhfRFxHN6IvauFCds6cHI3sGs1/CyHgN8H1g1zSKJtScxxtQ9pwWoOXLQJAsS/kA==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

From: Yangyu Chen <cyy@cyyself.name>

Add compatible string for SpacemiT K1 CLINT.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
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

