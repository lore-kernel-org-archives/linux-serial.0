Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2AF38644D
	for <linux-serial@vger.kernel.org>; Tue, 23 Jun 2026 14:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782224985; cv=none; b=Rt3Vv+2rRwxsXKMEyAtUxCYaarkh+HhCcHYfREDUTaD5suv24Q+lo6+NpLGUG2gjV4BQjF0khIw+IYD9U0OPkhuzbv1uaW+9CWj76gKIZ/xyF9kDb0H21NkJqQhKuTXJ2IYzOT9CTM9BmxypHyLBImiZvHqluyKliCFEjQkQEzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782224985; c=relaxed/simple;
	bh=gzxVrSlF+oqYC7gNrpUHnkV7T7qb4UmXbSF3WGqTClI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cu4zP34UEYkI10KPU5YjmeSqIvCixOwDOltcI9EzsziI9IdEHrN96vt5iB7MkMPwB2HVotcnWK9Buzg7tGu4MtuAC5TwgT0rywporFhJ4bqUwvOFPwjUtNs63eWgZRQ+uquAR2R8jMZj/+ymCg7a3VrbgrjJ5sw3nlimrdoSauU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=LnWggPg/; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="LnWggPg/"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49241a577d8so29742235e9.3
        for <linux-serial@vger.kernel.org>; Tue, 23 Jun 2026 07:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1782224982; x=1782829782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=srD079C+hrmcly29x/1Ya3b2fC/C4R7QLaFAjvjgVg8=;
        b=LnWggPg/uSZ3nqO8n7hSXQ4qVm7rznXHy+IChvWK+X1tXe8bWRe95s6tl1eGwJzmQ6
         7df8GQtdt0/+P+gGAgBo9DD6/NUJaYhJVlGnYdbW00/zDUJ3hRCIu3NL08G92/zLVZMU
         68/eXKQelm/sJuR7ol3GuLUztQAT1aVvtDoXNyQ8gtGY9TUvcxEB6Z/V9t2QlHKUYqL+
         OP4/Z2QU3SLrkp40eVMwlIL7APQG/q/i4noo+RbVxwGPF2s9YU4rISmfOKuGJ4APTXPO
         I3ugfQaKVOdxYKVdwNb79OQnuk9d1iELURvJfDHft7fptygaNtGlQZOc6uokxOXXL+GJ
         5MEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782224982; x=1782829782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=srD079C+hrmcly29x/1Ya3b2fC/C4R7QLaFAjvjgVg8=;
        b=Xy1apsbDhpPjKcXdmwMDNgn20PL3pRlxrjX4Xi+Z/821p3wqaUD/tfYuEFtLItNKG3
         /kJk7CUYjXPIlI5nVQQGwB1Jv/Q5APdmhxumcojMXZGvnGw+BJVWKlXP+FgHWfED6TQK
         b7ntlKxQzjDNWc0yKLqiReGO+c0D4nyFO2LMMBSyvrSPoMGZ3YLAXq6jWM2k9EvGc627
         Ro9msuYROMQkqW+uKFZ9rou3xj/CyRO43ZtdhWSaDvZ7twpNBp0IhWuOsy8Wg4RxEjb4
         yCzvQiVtwrAO0NzOcDX5gUGZbubAGhJLute+X84nsMBx6a4oN1X7Mfcw3UG1SvYv/Hk5
         bezw==
X-Forwarded-Encrypted: i=1; AFNElJ/hTXn7EDPgw9T69+o+PWwm83aCJGmAeEjl1DwYpLOfI6jNyyZm8PJQRGLxvWr4pyGYGzASVgx6tXZSIcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxHKpmdV1fTyH9N9C298XbIQHngIPmjU80eY9de2ElZaiObRPD
	tmiCx8O+4CI52nMmF8osJtlFxtLDDpG+GYgQeHfTvJ0mok9j5NptK7sAOwZKTjyj9KI=
X-Gm-Gg: AfdE7cn4hD5CH4ruipd8eOedzst5IK95mbWqMmCg3XLEgQ08u2BfOen/mDcEdlBIAO/
	HtN/zgEMP+o089hJFJVKO+sm/FMzYn6fX+f+vS4fCGDlEuINeONEQ+iLIj6OJ6exePEB/dF1zxZ
	JK19mQckd5G2QB62Bzl3xutIBb3X8mtHbP84RY/WTa8YU79nhxifyjucqAR4CpLH1yrHK/GFDry
	DtxywDCHGjNk66nwaXgqWIDNqnFcmhulBPpCKLyI0f1YbZkNQs6+mm5E1oPOOq2+A4cOksDIN0z
	iYMjdAFS/yjHMlXzxccTpeiJjbX4Fia0cPj8EbyJDRpeRoqvNZdR1NM3JJdkIYgyhPrOwnPQtKO
	OhOT/pFy/dquKTzA3B+4i/FlEAtUlCnUO835CeGIO4Jspk7dFEX90BMA5AdJaqNHeuKWVU4E25a
	sWKJDJwgOHQ83UNVgo/AlmtwUg3MVaXg3ZAz3pHAM2gDLPPDpDOhP5CSjso7p7Lk4HZyLUQ+8mf
	K1klL4FCeKMt09vGRtViqn6aRqU
X-Received: by 2002:a05:600d:10b:b0:492:3237:ddf with SMTP id 5b1f17b1804b1-49240e9544dmr224625985e9.28.1782224982083;
        Tue, 23 Jun 2026 07:29:42 -0700 (PDT)
Received: from gregwork.sec.9e.network ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49240efc160sm362507805e9.2.2026.06.23.07.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 07:29:41 -0700 (PDT)
From: =?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	lkundrak@v3.sk,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: andrew@lunn.ch,
	jacky_chou@aspeedtech.com,
	yh_chung@aspeedtech.com,
	ninad@linux.ibm.com,
	anirudhsriniv@gmail.com,
	linux-serial@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
Subject: [PATCH v3 2/7] dt-bindings: serial: 8250: aspeed: add aspeed,vuart-over-pci bool prop
Date: Tue, 23 Jun 2026 14:25:40 +0000
Message-ID: <73b2bd81ce70814612e6d3cb689c3296de742aaf.1782224059.git.gregoire.layet@9elements.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1782224059.git.gregoire.layet@9elements.com>
References: <cover.1782224059.git.gregoire.layet@9elements.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The ASPEED AST2600 has 2 VUART accessible over PCI.
This boolean can be set to specify if the VUART is used over PCI.

Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
---
 .../devicetree/bindings/serial/8250.yaml          | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index 3cbd0f532e15..b03797f4674d 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -26,6 +26,14 @@ allOf:
           anyOf:
             - const: aspeed,ast2500-vuart
             - const: aspeed,ast2600-vuart
+  - if:
+      anyOf:
+        - required:
+            - aspeed,vuart-over-pci
+    then:
+      properties:
+        compatible:
+          const: aspeed,ast2600-vuart
   - if:
       properties:
         compatible:
@@ -312,6 +320,13 @@ properties:
       polarity (IRQ_TYPE_LEVEL_LOW or IRQ_TYPE_LEVEL_HIGH). Only
       applicable to aspeed,ast2500-vuart and aspeed,ast2600-vuart.
 
+  aspeed,vuart-over-pci:
+    type: boolean
+    default: false
+    description: |
+      Enable the VUART over the BMC PCI device. Only applicable to
+      aspeed,ast2600-vuart.
+
 required:
   - reg
   - interrupts
-- 
2.54.0

