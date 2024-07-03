Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6F417D889;
	Wed,  3 Jul 2024 14:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720018612; cv=none; b=eg7N18xYoYm8S8o+7eZjENLkQ8/ps9OgrvvofOfMzsE1sdI2i3vb/r93NCzdOeMMQ+DL3C0m4ck2nTusJSZM7oqVSorCxNw+IYHEhMRzZV5A2nKPeZHkp8+A4Swk/oWGX2cvW3tAXfcEwjTbvvp3fYLxS7l/JE+sk6fAH6q40xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720018612; c=relaxed/simple;
	bh=72bJnK5OkxGeVX2TtnufaHxre6755qvj76r1a1oE7nQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fUOs5Q+0ff3jLE4BORfTj9iOgeyiMC2JQ7lwoh9t8VACBmuIYg3C0pi3CcuUdoZpXxtCx5JeO6Qz5so3v15JijKCQrj7y1J9tq6EJSRKuvX+o1IHRykIt6XRqnMPfK3BJKFy/ayFnbPJAk4Ife9W5DB63RfetOLxwdGY8i7GQBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Yixun Lan <dlan@gentoo.org>
Date: Wed, 03 Jul 2024 14:55:05 +0000
Subject: [PATCH v3 02/11] dt-bindings: riscv: Add SpacemiT X60 compatibles
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-k1-01-basic-dt-v3-2-12f73b47461e@gentoo.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=904; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=93gTwTFhHhqvEXaieSxNaeTfBJ+zIc4/WjCpYTUJ8uU=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBmhWZ6BOWdLH/QLc/royb5wev72rML7G+Ho7uFl
 ROY8K15QEuJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCZoVmel8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277aNLD/wIfqDJLqXrGyCjcv
 DIR6Gl8JStyWL4TYkpc8T/hIfXyubsyfvFb0KYM9IDwgAiituHgIFk8faTZVxi45CXxwipZCfj+
 kTJ/BquGC6ycknuig3AqjKY+UcIxE+mfQrQtez1VPqh/CVY03Cswk3a+85NpaWUUkPaq1z8JHYD
 JV2CMsf6fZAx3K5cQx0fICNU6gtHLCJFGyQwi4vzO7dqhx9WOtl0lLsKL6iaqJwqqL/Vw7iYiNj
 8boll3lynP7TFkUM3imeZJLtoviIwl8DcvMr4ffqNUvFBgcCoYRcd7EhrLrKCFSZso3n/qetVhg
 3bwdgVvEWvFFEIuG2HIn/H1YCYjHnwQ9z0EnkbDgoHW4TabapjOCctdEvi+EtOqunJ1+OOMZV02
 5oSLLpHhfgQ7A8tMAUNZOoqjEM5MzCz1ev95mhlMKbXub27pHcaBQpWggb30usubOZ5ymcnMT1h
 zmqpsp/ChcvId6BPhIkVoEKfpSsjxhxpWFwb3Sccd5DhrEKV9K6IRc2q09aw6wxWAWFmkqIio2F
 CAHuzvEIpSVMXhp+M/AWm1jJQZK/DX+7cwjzo6X3pQP4PehXOzVlU3weN/Wu8Y8UFREZCVtUWXx
 txKQLH7s39LfyBbViP9/09KYC1lQxOuiEPnzjM93OWZPapbfVIklgLSAL8REWMe2nGDw==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

From: Yangyu Chen <cyy@cyyself.name>

The X60 is RISC-V CPU cores from SpacemiT and currently used in their K1
SoC.

Link: https://www.spacemit.com/en/spacemit-x60-core/
Signed-off-by: Yangyu Chen <cyy@cyyself.name>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
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

