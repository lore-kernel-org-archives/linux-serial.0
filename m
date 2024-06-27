Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C20A198E81;
	Thu, 27 Jun 2024 15:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719502353; cv=none; b=J+ltHuwR+k7JYHQ+lF3Ekm2MwLPFl06subR/JM7zBU2BEaUqL1RzNtanyB0hcW2uDAhnxwVH7s3D/lUP2+865TS4EspAI7LtVl9nSVvrISmipGo1xbNyHfbAcSvo4AR7XpQ1v2+OXaZ12xo+OcGMCWPS3Av9w2u4nfBCuDEV0h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719502353; c=relaxed/simple;
	bh=AmRVyrrnbky9NGM25IDJL98iq6w0qLUaV8yzYOFQOrk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UBxcGyKHlPahXcQuLf1Rle/9ErgscHVbsLg1j2At9ElqW9Rv4L8YLgH5l6zSMUCBNALc1oBrM8ukDCoa0gzHdAd0pKHfNSYX6OdApeRO+LMriCc7mw/pyOXcHuMr3zQY/Qz0jAhs4PRZ0z9uRxWelSphuaV6cY2HCK3NLvWi0pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Yixun Lan <dlan@gentoo.org>
Date: Thu, 27 Jun 2024 15:31:15 +0000
Subject: [PATCH v2 01/10] dt-bindings: vendor-prefixes: add spacemit
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-k1-01-basic-dt-v2-1-cc06c7555f07@gentoo.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=920; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=EJxb7EeTC9u7CCdTJTxx28CPOGa+wgjU03pSv3TtRsE=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBmfYXfZMfeOnLAd+tWnxhngeusAefsZ+c5pev+Q
 Okj1g4AdqyJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCZn2F318UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277QRgD/98O7jkOqAavN5KZS
 lMvJzyEW6LAEmNlyCJyxwdyUayJtH8GIZJgUWRVdt7ZX7j3De/gRwkjRmeVuzj10B8q8MDGXHNv
 3TCZ0F0DFhJoWtByqxbIkKNXtGzJF82Zy4kIOhbsTS4Tc25wvUiSqM19my2DeR18Yu8O4AY6Rgw
 AA2VZwFTSFu+oK87nwdGerGGQUCSY/YORBN2+pGMLa3+NItSvRyd9YAbo7N6h/smGaCnGFFwFHO
 npkERepOD1AZipXwXNJ6coqrqqBJ6Hjh4ljZJ+OgZTLSUTdGb/2aY+VclN0AF7saAFQYr/aMe2d
 vQ1yHOd00kQyEOegy8PT+SYEd2x+8C1/zSFPVF6PLpBo5GS+Kv3VzuNwFqtpAuvc0QM9ajr5Biq
 jxCCQKn52dnx+s7wLLh1rgAb++1lEBfEX9SrWpMY/cEavhNEw5j5ONYSHQEE1zvRt5XqrZ2AzpE
 jZ2Im+ZEfkRIwGw62CEGOKzhNID8XnwadTDPYomSGJwLWQnlo0/v/6gekxutdGo2PuE/IelbyCo
 oIWZg8sTFab16kVerHXlpvCcPBVdlOSgru0NFHArR7f5+IML/U1eg2Jc1/M2v7edcw9ZUAgL4E2
 Rg7Y34eUg8WOWRB6hBU8RhPCRCsO32WySw9et6RwPkqJ0t2uUxJ6NJcMg/uJf9oDW3pA==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

From: Yangyu Chen <cyy@cyyself.name>

Add new vendor strings to dt bindings for SpacemiT K1 SoC.

Link: https://www.spacemit.com/en/spacemit-key-stone-2/

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index fbf47f0bacf1a..7ee6e4a89376e 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1362,6 +1362,8 @@ patternProperties:
     description: Sophgo Technology Inc.
   "^sourceparts,.*":
     description: Source Parts Inc.
+  "^spacemit,.*":
+    description: SpacemiT (Hangzhou) Technology Co. Ltd
   "^spansion,.*":
     description: Spansion Inc.
   "^sparkfun,.*":

-- 
2.45.2

