Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3876D180A86;
	Wed,  3 Jul 2024 14:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720018642; cv=none; b=kpXvgD9dJggCMW5/qgvoq1a2tuaCWwqaxlSyl1W3k2doJEmmAZTfgHJyWZiO3ztBdU032xLn7h52I1WGv+9YTQEX55sQqjkeoBTBSlbacbCr+qEdJlMulc2P45tuvq/zrUwEWtMiAkHhiQ6B4r2uGUAvphC0zOFX/wp0q5fhuwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720018642; c=relaxed/simple;
	bh=5e5axpOVSop7tU9RM2+kMzY3QIqZVpK1c93FNqEco2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XzPvsMk12NJers9okt8QEYSj3/uzWWu7ED05tAp3B4Xsh5AvpKZbE6qGJ6oXgjzaSTYsjqKWQUP59+VE+eaEkWGxREab/8wX6Adm4AUnpzZ/7sfo+9dZOq+dzJBgd3AJZPF6Z8hCp0IXeaG9V5IhKXJuKnKIZsJjKApkXNj2exE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Yixun Lan <dlan@gentoo.org>
Date: Wed, 03 Jul 2024 14:55:09 +0000
Subject: [PATCH v3 06/11] dt-bindings: serial: 8250: Add SpacemiT K1 uart
 compatible
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-k1-01-basic-dt-v3-6-12f73b47461e@gentoo.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=965; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=5e5axpOVSop7tU9RM2+kMzY3QIqZVpK1c93FNqEco2I=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBmhWaHMmSptOnr/OPT3AL7ue3HGBaaLS9L6fVFt
 SmnHVQleB6JApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCZoVmh18UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277TWoEACZ/cu+fJlqsyNJnx
 zb++o56J7JkhUx7IvfXl062IMdW/16flA0fZCuVznqtzEALWHEDUKMplkXcxyusxoytQjoSspAN
 UjKI5bO2a2R3995xsYewM63V1i5EEdGvs4IZueDzkN7dLOpQIzM452jeTNM6DOVQeJlOrbTWONM
 ySCgpQzVZ2Gb/p0/QyMLkhJeqV5U0DyzVzHAc7kUE+YOaJRFCoaiOPspL2sO2bhLAAKc/4xDw7l
 3H5aPMi3+gJ6xCtVKucV07OEbpgYp0rBKXiikZY9HvitxnAIMzgXS9CKIOsmvLAvH3PNutfUJSk
 0PQ22qQH6zx1C2maj1ojzOeUj9lGkALmyJKY9ivvETG75PrL/DlCUz+ozTuZkoKupLI+voy/rTz
 nycpbW/9+oxNtpqRPPQ8edTH6AhBLCzaMBZAgHBwo3nj0reF6UXJy6JrbRC/BgMUNE2w1MHMNTk
 m2VIRtmAhDzey3EjUG5UuVlhaRjHR6/6kkKQhJbzuJjIdBcw6/lgo/9saepI/nczXVe0YWDR1Zv
 EzRwIojWDj0tu0QTpEzInCvR+M7Lo929MNS2nCeBo2sgYHxNTXB3HytCTwgq4B+IycIZdoepjaY
 WSPmGv6TIW4soqf7gGWIt/a74+2T4n/blD8un74YnH2gdxDETiosG4KMjRSslAoIqARw==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

Found SpacemiT's K1 uart controller is compatible with
Intel's Xscale uart, but it's still worth to introduce a new compatible.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 Documentation/devicetree/bindings/serial/8250.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index 692aa05500fd5..0bde2379e8647 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -111,7 +111,9 @@ properties:
               - mediatek,mt7623-btif
           - const: mediatek,mtk-btif
       - items:
-          - const: mrvl,mmp-uart
+          - enum:
+              - mrvl,mmp-uart
+              - spacemit,k1-uart
           - const: intel,xscale-uart
       - items:
           - enum:

-- 
2.45.2

