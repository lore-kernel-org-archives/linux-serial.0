Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15DF53BE;
	Tue, 30 Jul 2024 00:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722299360; cv=none; b=pZkkQ8xwHs9dcwn79axaJuSieCvd4cY3LeTp1KDl4xmnLCDfB042rUHt0CtJdjn98OhCn0UcIBMLBr/4TGVTMPPCgSVrSGbDA//aliiWJAV6DU83cupyswfuZO2AoIp33jj+uq0cj/U1FWxFI9ZFqg+UePZfsdgtK1dw5MhX5aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722299360; c=relaxed/simple;
	bh=5e5axpOVSop7tU9RM2+kMzY3QIqZVpK1c93FNqEco2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qRciP0oq/Z5jWs/TjmaR6arJ+/75c5c6M5Shqf2l1bELMSMHn0qRN43ve5tuQccpf9oUQHHuDqLMdbNg1H7lLRvbqwA8LVCvY+UtjP+5Fle4O75x0Z2w1M/UcfIcocy0d4UiV9XhvIHe1zvyhyrymhS9Wp8/3m+dxupMiVm1wIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Yixun Lan <dlan@gentoo.org>
Date: Tue, 30 Jul 2024 00:28:09 +0000
Subject: [PATCH v5 06/10] dt-bindings: serial: 8250: Add SpacemiT K1 uart
 compatible
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240730-k1-01-basic-dt-v5-6-98263aae83be@gentoo.org>
References: <20240730-k1-01-basic-dt-v5-0-98263aae83be@gentoo.org>
In-Reply-To: <20240730-k1-01-basic-dt-v5-0-98263aae83be@gentoo.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Yangyu Chen <cyy@cyyself.name>, Yixun Lan <dlan@gentoo.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Anup Patel <anup@brainfault.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org, 
 Jesse Taube <jesse@rivosinc.com>, Jisheng Zhang <jszhang@kernel.org>, 
 Inochi Amaoto <inochiama@outlook.com>, Icenowy Zheng <uwu@icenowy.me>, 
 Meng Zhang <zhangmeng.kevin@spacemit.com>, 
 Meng Zhang <kevin.z.m@hotmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=965; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=5e5axpOVSop7tU9RM2+kMzY3QIqZVpK1c93FNqEco2I=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBmqDOuNXR3NdHbzKjlSS1pwkQ+g3hHoXXLyABN9
 wZ6kr3zqkCJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCZqgzrl8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277QebD/wMAI2kHdel9DrnTv
 ED7niiWiEgrQhvXvWMbYbqZjR4d7J1G71a3qHtw9FKoa0iEZpWnI0Y6lWY9LJZNycCKepSoHQjI
 SP3cCNCeeFfKxcB6aMRd4tl1L3Nn4umbANH0zrohviYOzKCFqCHGuBcIktMQCZsVNVQm6tyvzEw
 kqvhyeEajh8nIeXdyJcJ5gIcqtaVYHPfLoefDOfaYK1TiqdQMk3+PAsV3PjJASI182elhDCnE+W
 nzgxK2EIVdnDshUeZSNsGog9CWY/IKHym+ZNfZWqOkWH3d8Zx0k5wrfxmMvYVf3X+czhKwAnyMM
 CarvDADQqLJJQKbGVb60E8egC4aX9uH3o5JkwDvGxdH7noW1CfZ3YLNWU3lAScspInaD4CsZzMd
 nzTBAMudXWmyCyn3S1fG0QS90OHfs1obVtTrEPSbBNSVfpefGfsZUOwAf1s9IUnAKxTPE8BiELD
 7RZ3UviAySbnk7rJUtspQQc/O7O6PcvOgKAC6dMqCXJ/U99neXfFdRQiCj/gZmDwfUXABRXTlep
 jtwG3bIPkaqCggqdZDln2k1Z7iqq/8Pc3IFrCFbLCc1xc+nHs94CGWEpwumUL9crnBMCYohuMfX
 Z8OpwQG7d6W2wFvhCeQOoaP7sE9mfPMfaxEr4mRWUyBOpHgspNzCgS3+AKp/8npBg9QQ==
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

