Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEC03F99FA;
	Tue, 21 Jul 2026 01:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784598631; cv=none; b=dUNPp7vbuEDupDPUP9ZTFgB7JIw1uaf82kMNIqmujmTKCYxY21mywlzI0k1rCzZpbgC3ni3kXAfs5xDgaY1ucf+q7ruWjt1PG04Ec6AennNVhD1k+wLaniqw6ItnZqDDiQLtLAn6hG7oTz61WEFjZOkGBtp+As+w4yyh8h2YYyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784598631; c=relaxed/simple;
	bh=lTntWyTl6avbCN1RfulOTEOhcKWdMhAjrbYEkpJBN2M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=jSZCioLcg7r9FYO46da14FtzPEeFibqnFC6IIl9Wq6/alkWNR8ohHaIAUROgpf/QyOVV9RmWU3cl9sENzx7WD5BVmt+Oj5isdDcMrhfuq0bFySXpPkLNriTZY8Fe6dDjT3HmMBFeSvvVjfkLyS6o4IxRUQAGs4NZRZ5FqOYklrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 21 Jul
 2026 09:45:19 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 21 Jul 2026 09:45:19 +0800
From: Yu-Che Hsieh <yc_hsieh@aspeedtech.com>
Date: Tue, 21 Jul 2026 09:44:23 +0800
Subject: [PATCH] dt-bindings: serial: 8250: Add Aspeed AST2600 and AST2700
 uart compatible
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260721-upstream-ast2700-vuart-support-v1-1-b4ed612b1aa2@aspeedtech.com>
X-B4-Tracking: v=1; b=H4sIAPbOXmoC/x2NQQqDQAwAvyI5N7AbsCv9Sukh1bTNQV2SXSmIf
 3fxNMxlZgcXU3F4dDuYbOq6Lk3irYPxx8tXUKfmQIHuIcWENXsx4RnZC6UQcKtsBb3mvDZOFN9
 DP0rknqBFsslH/9fg+TqOE7Xg3llwAAAA
X-Change-ID: 20260717-upstream-ast2700-vuart-support-d21b85ce1a52
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
	<jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel
	<lkundrak@v3.sk>, <devicetree@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>, "Yu-Che
 Hsieh" <yc_hsieh@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784598319; l=1472;
 i=yc_hsieh@aspeedtech.com; s=20260717; h=from:subject:message-id;
 bh=lTntWyTl6avbCN1RfulOTEOhcKWdMhAjrbYEkpJBN2M=;
 b=tbmLQWpUhjRarAtgM+ML7C86yZBUi7RA1ZVfBGexzqaDBlyXr8hdg5vfogkWPUJ0fcLEGlFR4
 qVtJV3JQ7S8CWWfFphwMkOiyVup+0UMeNgyYP5atazA42Tvy42e/IVm
X-Developer-Key: i=yc_hsieh@aspeedtech.com; a=ed25519;
 pk=ah7wJd9O1yEvNiwJM+jX3RKAaMjb4uwyNPwYUIgEkRg=

The AST2600 and AST2700 VUART controllers are identical to the AST2500
VUART controller.

Add the "aspeed,ast2600-vuart" and "aspeed,ast2700-vuart" compatible
strings and fall back to "aspeed,ast2500-vuart" for compatibility with
the existing driver.

Signed-off-by: Yu-Che Hsieh <yc_hsieh@aspeedtech.com>
---
 Documentation/devicetree/bindings/serial/8250.yaml | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index bb7b9c87a807..8c2c177faf89 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -23,7 +23,8 @@ allOf:
     then:
       properties:
         compatible:
-          const: aspeed,ast2500-vuart
+          contains:
+            const: aspeed,ast2500-vuart
   - if:
       properties:
         compatible:
@@ -188,6 +189,11 @@ properties:
               - loongson,ls2k2000-uart
           - const: loongson,ls2k1500-uart
           - const: ns16550a
+      - items:
+          - enum:
+              - aspeed,ast2600-vuart
+              - aspeed,ast2700-vuart
+          - const: aspeed,ast2500-vuart
 
   reg:
     maxItems: 1

---
base-commit: da7b5fd4e17f8e44c5590f2d603c01d499f056e6
change-id: 20260717-upstream-ast2700-vuart-support-d21b85ce1a52

Best regards,
-- 
Yu-Che Hsieh <yc_hsieh@aspeedtech.com>

