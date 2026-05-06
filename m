Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEB63382F4
	for <linux-serial@vger.kernel.org>; Wed,  6 May 2026 19:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778096044; cv=none; b=p186epuWUpTDJrNZdrFhjqOu3fj0t7R0eAXMCW0B+19csunXfqZYxtFu7PYUkunPGryDaLVG320Ux3NQPKeJnvIh4vyETJk1q+W9Es9LIwGDiBqMjtSZSWWqFqb0FzcVFNYpnbQYimy5qHoR26bCnwdWjNMGKL1Ou4AcZ9Qyr6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778096044; c=relaxed/simple;
	bh=+GtKlk1K7hr83CoqJ8aTYEzO+TXa3ITFJyZ/GejNafo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V/SGb3rP3wGNSXesJRTD9G6mr6+kBtAiKWaMyBkKz+Uuf46pdIaRocuisLGckyBExUmvFaxi/Hap7wqhJ827AVRIeAWoEf6+uEHIBL/u+HuK2FimTgqsyQ8HtjBn6vckml6zRS3TwBlew83+gH1YXkW9sIPV81YmyROQug2RiQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PBv0vXcf; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBv0vXcf"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-44e1860558fso61822f8f.0
        for <linux-serial@vger.kernel.org>; Wed, 06 May 2026 12:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778096036; x=1778700836; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9lu2q2P2n5BrSSlxeogaqEBxGB98cpNlogETzW0AQwM=;
        b=PBv0vXcfWHtI5tn/wIMl9ja+dnL5rG4NazLUtwWhkFWxPIGQLu/A/2Hf0JOhxlkGJV
         P7NG9tBq8VJeecj6zJah0rdcbl+n2abu5y7YNDBxzBu5iOWXnqgmeTpDmJsb7sRkz4Xd
         PJamaUODcbtY92kerBOucLIi4r6MqVU9cT9ZLmAOdEwJ1BmqeiBOGhgn7Ac2IS5wA4aW
         aHvgraqpypwqJSybnLiWYe9ZfR7/lnunZbPpSIerPY3pNItSRlz0MLLrryeCsuVagmEr
         6IS3gKY4AJ38qgD8sxP8ZS5D1ZP0jGxyKaYJ3b7LBBZ6APEGmADRyCHJ5Tw5TjObize3
         trVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778096036; x=1778700836;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9lu2q2P2n5BrSSlxeogaqEBxGB98cpNlogETzW0AQwM=;
        b=bl78ySWDP2vgrjf770hOKYGwYmZP83JOm8041CSka/bgK0c9q19ShS7W9APmpULAlL
         3teCIOm14WO4d69c99Lwj8+t9jX2clz62kQlg353ZddrO1Pr339J6I1efbW1JyhvrkD6
         zsupgjfmY4ONmFO5XkNquLZlv3p0QIi6nrPC4dd4kSG4nYlzmX+z/FLMskuN/AfMdVfc
         oO3YKYjIYTrjCWqldIUFuzrwZVON1RAZrhMvcP1gxYCNTlekLXi0S1V3eLGBNqwEkYle
         Nu1PJ6sCnRtrQ9Za4SwJ9tF/NVkMGApDC0+qrmUb2dbA1V5nU7N18SUZ0ifuW3KJV+bf
         +vUg==
X-Forwarded-Encrypted: i=1; AFNElJ+1pNlDZMldlX+OP4FlwhQmX5oZe5xPVW/apOOWTgE3sUxWdXBXfcWOjcuzZsn8tvKPvufzWW+1VN6u53s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUivkc55H4QUlgl8BSWGuRycMtac09WoXREDNJC6UxglXbfvRn
	ecy9re3DKkLyJ58LrstRRNtaDXUjo7gh+qZaNOimlF391A+0EjKuHDvZ
X-Gm-Gg: AeBDieu6pu6fVSTjXexO0nnndsUB+UiBvHO+MSLFcCtOkAbQJwhatFVnELUnMZxa7mj
	IJVtPQkC6rBD0lAar0pljhuJLRkBEu2ynfAguGdrLcVpwIQqNAnY4giiO98z/kge4f6dPARUn9T
	XLPIT0uI7TXQdN3ewBFVPb7FGcxh+xj/KzZ6gdobpgaglr9Sy7DrfTA7IkyS8asUiw3UvZrUEc2
	xH0xZtXWSMq1ai75KadLIUmT+87X0ktRNEdwEWCwhHjLsa8xDO7t4/eNjLeojTj7v7abaueyL6T
	CdWHeJelvFsEQOXbE1BxqHG07308HpCq95Cb9sJYw+1a/8L+3aL+kEe7xaGJFqb8Hx7gqBRgenl
	3p0Zz3ACI1sQcD6iFrl5IgIsq7qlCCoCmp63nK0Jla/O2vYKPDdxawbnmqR+kDvqSLUNWuQzdBr
	DWQR2cmybEMKZ5u0q/zMeVCjwHSnLrpH8P69Q8eNGA9EHESwN4URwO45olB1PypTzC
X-Received: by 2002:a05:6000:200d:b0:43b:4136:1e6f with SMTP id ffacd0b85a97d-4515da9545cmr8271440f8f.38.1778096035758;
        Wed, 06 May 2026 12:33:55 -0700 (PDT)
Received: from [192.168.0.2] ([197.250.51.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055960022sm14895673f8f.26.2026.05.06.12.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 12:33:55 -0700 (PDT)
From: =?utf-8?q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>
Date: Wed, 06 May 2026 22:33:18 +0300
Subject: [PATCH v8 1/6] dt-bindings: arm: zte: Add D-Link DWR932M board
 based on zx297520v3 SoC
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260506-send-v8-1-f1bdf3243b34@gmail.com>
References: <20260506-send-v8-0-f1bdf3243b34@gmail.com>
In-Reply-To: <20260506-send-v8-0-f1bdf3243b34@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Linus Walleij <linusw@kernel.org>, Drew Fustini <fustini@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 soc@lists.linux.dev, linux-serial@vger.kernel.org, 
 =?utf-8?q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2213;
 i=stefandoesinger@gmail.com; h=from:subject:message-id;
 bh=+GtKlk1K7hr83CoqJ8aTYEzO+TXa3ITFJyZ/GejNafo=;
 b=owEBiQJ2/ZANAwAIAT0TvMhUTxoiAcsmYgBp+5eWK67X53SzKHIlBRmKN+YIbH0e7b6j2TyOr
 aCK6GX/DqKJAk8EAAEIADkWIQRDFvS2qgVbJ5UyXWw9E7zIVE8aIgUCafuXlhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQPRO8yFRPGiLe9A//QrlJoD5UHF8Jyl3id4evXsfCSOna7s3
 a3Vr2Eb2zkTlTOgcvpkjxjQBSgKu11wh2ipgdAHyWoxfWLzWOKvt0RRzEkMMAyfciXMLOZ2lI6/
 7u2PAjwtrWX3JRhKTnAOVZBOsffj6E65JWWHL1i0MTiNLaTu61zqN7EDsm23ie/t8UTRXlAFIm0
 HNQYjZUG34QM5alJ3LONrFEo10wxrHMLX3IiOubh5F2bfohO68yy/+lsaLM0Y7n6j5/OAA0IZUa
 VBK7uePl8d63Gq3B3FBKGisV+kIW2mMji8qCcaDL/z5eP9pQq1lw4y3KERIQdrlbgnLyRz9gCO4
 s/y2zMkIsc0DE18qeMPMBv87Q+8S80d52TzxfQj02CuwxGhHmD8IEmp0ysFNgQnTAmw7WD9F9jQ
 ogtoJZND+ExSKF1+wkWfIL9r2fV0ljl9pCiCvBaabvbhBdlJk+dHTxYsT/m3yGRTpfl0JTj8B3t
 Q/8AmjcT2gf/z8DsedC6CryNtvrwhDuia/jlS3Wzp9wl2oUNWAjWTk9QJQWyBGF5TbXYW+VOCdN
 fsjmv6YkM7LafxHSL+kqgzH4Mjez4BDNb3rcFA+G0dOvxZ07cZuwjn7+4SjsFiRmnjZJzp1PB8n
 jBgulpoL5cVbuVM1B3TVh21UGevB9y78NqWrTGAYww1yLQzAEJbQ=
X-Developer-Key: i=stefandoesinger@gmail.com; a=openpgp;
 fpr=4F9C2C8728019633893EBBB98CB81F9A72BBA155

This adds a new binding file for ZTE, containing their zx297520v3 SoC
and one board (D-Link DWR-932M) based on it.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Stefan Dösinger <stefandoesinger@gmail.com>
---

Changelog:

v6:
Removed extra boards, I'll add them when submitting their individual
DTS files. Rephrase the subject to add "zte" and remove the redundant
use of "binding".

Moved the devicetree bindings patch ahead of the implementation patches.

Moved the MAINTAINERS section from "ZX29" to "ARM/ZTE".
---
 Documentation/devicetree/bindings/arm/zte.yaml | 26 ++++++++++++++++++++++++++
 MAINTAINERS                                    |  4 ++++
 2 files changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/zte.yaml b/Documentation/devicetree/bindings/arm/zte.yaml
new file mode 100644
index 000000000000..f028d2cec7ab
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/zte.yaml
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/zte.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ZTE zx platforms
+
+maintainers:
+  - Stefan Dösinger <stefandoesinger@gmail.com>
+
+description: |
+  ARM platforms using SoCs designed by ZTE. Currently this supports devices
+  based on the zx297520v3 SoC which is found in LTE routers.
+
+properties:
+  $nodename:
+    const: "/"
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - dlink,dwr932m
+          - const: zte,zx297520v3
+
+additionalProperties: true
diff --git a/MAINTAINERS b/MAINTAINERS
index d1cc0e12fe1f..b768b9da37a4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3772,6 +3772,10 @@ F:	drivers/video/fbdev/vt8500lcdfb.*
 F:	drivers/video/fbdev/wm8505fb*
 F:	drivers/video/fbdev/wmt_ge_rops.*
 
+ARM/ZTE ZX29 SOC SUPPORT
+M:	Stefan Dösinger <stefandoesinger@gmail.com>
+F:	Documentation/devicetree/bindings/arm/zte.yaml
+
 ARM/ZYNQ ARCHITECTURE
 M:	Michal Simek <michal.simek@amd.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)

-- 
2.53.0

