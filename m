Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62229460;
	Tue, 30 Jul 2024 00:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722299342; cv=none; b=TOLRrwKUmYPKd/TV1LrYEVQqeZPVTemS1YlUWP7FQwLhajsDAJgfj/S+zEpkKhcnu7zW4zUvyjen50TicdgnSs9nJctRktj1HHoP6QOsFr5NNgLTBZuZqhKQutRR23qCfunbe9eCkai7j8HpTYHm6NOxWTOLevz1psOA/yOtT0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722299342; c=relaxed/simple;
	bh=Js9ab4URZhWNgePC8zJilMKKJ/AryQyBTHQSX5byUp4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qTlNEnGJ4CZueRl01KL9x+Y1z+xZSuL7rDHCdt4IQW3+Yy4BLJNtzNQ63WBoHFBdm5X7U2hVopBTuw4nksponoSJn8BaDLqnlkzOOMWg9Rlh2p27aMj9DpT73xLHOc+Vp8wXG6/iauh9VyY7Biibd/BPXIxS+mG3xbC7x1Y1qUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Yixun Lan <dlan@gentoo.org>
Date: Tue, 30 Jul 2024 00:28:05 +0000
Subject: [PATCH v5 02/10] dt-bindings: riscv: Add SpacemiT X60 compatibles
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240730-k1-01-basic-dt-v5-2-98263aae83be@gentoo.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=904; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=W8eM35e/PTpqsXXOCfHverpbl8e/pGr451VH+m26oA0=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBmqDOhfX0Xrzy0z/5lq7e6AD+TZMqsPXdTaQ9PT
 yy5IH4xgHOJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCZqgzoV8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277ds+D/0bI9pzmp5cVVSPdS
 ZC+vFW3Mcg190dl1qRTCiR0ouSU80vI3l6jTXMQzeBC49uz8+2w9ANm37dtmAWsx+Y7jLTgFVoA
 fkMixKGm9pYoE9oB0ZJlW3PWm3mbJ9WckU1d5ysPJ9EOhkEs36s2uX4JQzEdtaarPX2156vfMte
 ecFuNQoeyjSid117hwtvSvYo/7Si2bQ/wIw4W59tpov6641yAFXYeOPaqO6Od2PIjVyrdz9kaR0
 FxGCltGLSzifNNrPr03URC3S+RcXR0096aOq41AKG3pnwB+aZAqmdyUvgzrcZtKoGPK1shgBnBU
 6F/YrifFZHqx1pRMymFrgsbFQyVn8cQ26VkgKrXlDdGnfRf3TA0qbcBADoStituAc/6NhwzGA5v
 jhvnSBgoAbttMPFwy3vNa7W6//xzTF6IS+m0TL/lzOlp9Y1h83imJamle67Yorh4XSP454BHDQ4
 dbBm8uXuy0oQ/s/T8o+Q4e0ol/CrMsEPhedbfEaWtYH0/NcGM9ioC4pijiFCFTGFJW7ly6vMdX5
 lkd1y/Xy3s08oMdA3LzypQx/599RwKTDFPFHRUaDRuzQHtqo/ytBgsBZ+U2Rpbqm2Zhq23Wf7X9
 C6sap5IMGt5EyoosbkrR/z5rHaSWebnrQgUjORmvPS2CF1pdaxsELNvwCeLiXHkxPbVw==
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
index 8edc8261241ad..acb5b9ba6f049 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -46,6 +46,7 @@ properties:
               - sifive,u7
               - sifive,u74
               - sifive,u74-mc
+              - spacemit,x60
               - thead,c906
               - thead,c908
               - thead,c910

-- 
2.45.2

