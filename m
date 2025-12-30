Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4492DEA74
	for <linux-serial@vger.kernel.org>; Tue, 30 Dec 2025 19:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767123718; cv=none; b=iuutOlOud4zjyfAa83JKr21BGchTUyJrNIAOaFAbmrqABMYTs0YYu6KH8OrMog7I3nSVinY7D+vx6PNoTyPW0Kqw19UzCFJ4dnPv3uKwQxR+TdRoVtOh2dRs5b30n9DN3tU909hT3eIWJrFOigZbJum5nv0NXerehxQVdBJMp8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767123718; c=relaxed/simple;
	bh=UfuU7YANuY2DtAb1JPJwiKh/zNCqLQCQAfbDrFS7vE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CwVnOZHqdmOGfGLVe0yaeW9sPO2Wf6lGGuKfHmz34CcZpaYGfqt7rvEnjW34HcR0aDyyt5VSu388f4uAU7pxeTbq9F3/bEbESxNhNRZKuNqpQkpCkZcwrnZtjjDuhuia7E1Ik/NqP8oJP4JaUr/TRM2z/g62uIKGBLSnQTkf3lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TcV5x9jM; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcV5x9jM"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-3e37ad3d95aso7002102fac.3
        for <linux-serial@vger.kernel.org>; Tue, 30 Dec 2025 11:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767123715; x=1767728515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=83p8xxawIJkmopSMpAdalPGsHw+uQLv1ciZtoS9EH+c=;
        b=TcV5x9jM+O1XKNF4de3zoVNArhfSLvTrnUwwHNJLqeS1YPPV8rGMb+fYV2HgXEE9le
         eQNJwTAiZzE3n+qWp4BQk4v9JabdMMb4nnalSY7tNHkHZx30geHd/TxK8HZfDzX/Bcxf
         WjuuOlctiiIJ32FM/Pam5Ch0XukktnZZGW6yb0Xw0wEdPliZcFS8A0YJXmNREPLTVrrX
         zmrh2YIciWMIOVQ/2oQynqCzXW+/UwxBrvFuquxLXH/iMHlzbGPhMOo+v4UG4O1TxA/r
         0cg/9b0tY/dTm1d+yqnVlXHcVpB9W+Jw1Y+ymhrsgHY3t2KHERVQiErg1QcJohbvN6yu
         XF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767123715; x=1767728515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=83p8xxawIJkmopSMpAdalPGsHw+uQLv1ciZtoS9EH+c=;
        b=xKzMaHHzKCE6ZPMua5k52I1b9fBN6yopp9h1WoCE8FKSl0pSivO1oVAB5XyZ819+lk
         qLmPA4epk3qaPs1Ci1o++L+tZjxHmlMEsalT1ptE1PXIAI2qlcfSB+m8RZ+nmScKbPDG
         YvdofxxXIeu/U3tStx77ohvALfUSKSKJ7Vg0aBFtPjmtTd2qbPhF5RYdqGFx7Ca8xlKU
         MNXhZr8YSsziZHWV6h8tiRT0iz9j4nwXOJgJHZbdW+eJnlezqulwnBUQUsvOYArf88KA
         dX2EircyRgoCGN0BnIp8D2ksxfsAnOIrfF5yp/A4+NayL8fzSgpIHXt+UZv4A1eN8Fdp
         5fcg==
X-Forwarded-Encrypted: i=1; AJvYcCX/rX3oB1SorjkXlUISSixfE+BROJPfkEgL62mywfRGIOh7ShWQMVziAlkvfjElpsULx/Yi9f1rvaE3rjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC6llg/+C9hbxxrNL2+xZ1nsFXewbJuqgQqe1HeDwIAvX9aU2m
	7Q1Mgp+i2/UIGv8xolFa//bWYmllmlIpWntK0TtFTxBEl5ILHB9WiD7VU5NtEA==
X-Gm-Gg: AY/fxX71D309tpnSImBu6zXmasYJkLpiMLhHK30nYOTOyesHrEDVxat2uXRpdXiRn3n
	e5Ete5A1a9Bd97aiXFTvx+nUGtHSL7bREr7paxbtroQK7ynH/sUnTSuyorHRfAFym2kz0eoNObr
	YHKtWPZjiBe/c3BiRBgzOMD2KZc903SdXzNHx3Ox1ZEqSgR4McB99C2o/nPxDI4zDzotIWsgTX4
	nCahFKbgzO3GQ48+ANbDqLz9tAH80avWwnceCfeyvuFq2Je0jyJPCV9hVO5A+BM7KeybdFH4s/Z
	jUO7kWTNk4DU8Q813rdDSkAMst8M4xjWQ7b0CxNwVVNG6vHRxQBx7oNMBcJk8XDVNx2qqlH9s9J
	bsf6JuDO/4VWaSnZ9Cg0M11HDGL262pSX3+I3VAwjITCwPDcr9i4mTl0F8C7YypE8rWzx3S0Gl1
	EUgJqamiHEW7O4FqZYsmQEqRDLFMHZR6TnQqKASj/MN2Nc/O4Jotrkz1JcmRjvYmWEmNyloMEhd
	T2lHixP+P3lo7Td18XugPkoWo7w1EfC
X-Google-Smtp-Source: AGHT+IFIRsb1yFLdQjiEzch59E2/VO7Id1WJQzqg0S6DL4+slVXOXOweBZRKfGEK/PtM3/p1UkcWag==
X-Received: by 2002:a17:90b:3f08:b0:341:8601:d77a with SMTP id 98e67ed59e1d1-34e921ccb3bmr30732436a91.29.1767118270582;
        Tue, 30 Dec 2025 10:11:10 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7bc69728sm29598278a12.19.2025.12.30.10.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 10:11:10 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: airlied@gmail.com,
	simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dmitry.torokhov@gmail.com,
	sre@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org
Cc: jserv@ccns.ncku.edu.tw,
	eleanor15x@gmail.com,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-sound@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 4/6] dt-bindings: power: supply: google,goldfish-battery: Convert to DT schema
Date: Tue, 30 Dec 2025 18:10:29 +0000
Message-ID: <20251230181031.3191565-5-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.358.g0dd7633a29-goog
In-Reply-To: <20251230181031.3191565-1-visitorckw@gmail.com>
References: <20251230181031.3191565-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Android Goldfish Battery binding to DT schema format.
Move the file to the power/supply directory to match the subsystem.
Update the example node name to 'battery' to comply with generic node
naming standards.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 .../devicetree/bindings/goldfish/battery.txt  | 17 ---------
 .../power/supply/google,goldfish-battery.yaml | 38 +++++++++++++++++++
 2 files changed, 38 insertions(+), 17 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/goldfish/battery.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/google,goldfish-battery.yaml

diff --git a/Documentation/devicetree/bindings/goldfish/battery.txt b/Documentation/devicetree/bindings/goldfish/battery.txt
deleted file mode 100644
index 4fb613933214..000000000000
--- a/Documentation/devicetree/bindings/goldfish/battery.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-Android Goldfish Battery
-
-Android goldfish battery device generated by android emulator.
-
-Required properties:
-
-- compatible : should contain "google,goldfish-battery" to match emulator
-- reg        : <registers mapping>
-- interrupts : <interrupt mapping>
-
-Example:
-
-	goldfish_battery@9020000 {
-		compatible = "google,goldfish-battery";
-		reg = <0x9020000 0x1000>;
-		interrupts = <0x3>;
-	};
diff --git a/Documentation/devicetree/bindings/power/supply/google,goldfish-battery.yaml b/Documentation/devicetree/bindings/power/supply/google,goldfish-battery.yaml
new file mode 100644
index 000000000000..a7c98ef56201
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/google,goldfish-battery.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/google,goldfish-battery.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Android Goldfish Battery
+
+maintainers:
+  - Kuan-Wei Chiu <visitorckw@gmail.com>
+
+description:
+  Android goldfish battery device generated by Android emulator.
+
+properties:
+  compatible:
+    const: google,goldfish-battery
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    battery@9020000 {
+        compatible = "google,goldfish-battery";
+        reg = <0x9020000 0x1000>;
+        interrupts = <0x3>;
+    };
-- 
2.52.0.358.g0dd7633a29-goog

