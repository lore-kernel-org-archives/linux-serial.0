Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6933421CC79
	for <linux-serial@vger.kernel.org>; Tue, 30 Dec 2025 19:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767124372; cv=none; b=qQv/QfJtRaX0QIwYcaXSe472ly3BmtErwtBj4MlhYsfv6F7WTD1BczUVVvil7h0Gau5Qp5MHRAor+4pkT+ypLYLtS4XxyDcN9RNiydC+KmpTjbSeIE7Q+r1TW61fNroCAa2tUsixv7ZiRqhX2aB5Da02wAX4V+3VKbcOpFf+a7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767124372; c=relaxed/simple;
	bh=dBZA5ta8Wg18huaW0x593dUQGODH+A9HatruQgqiYAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cahuYQy09trhOCoAG6fYm90J/QNmFzkmTpfMgd4QtlwrwhTH0r5AcWeZleIZv9P8POk8TC5qk+inkXtQs6VfONFZ5XQApJpMSol9eFPcDJSJzaBcNWN/HasyZcV0VVZ5u635kBTwzLM9iKMyG1gDq0cyEzKruu0Yx3syYIMFSxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+gTwpKH; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+gTwpKH"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4edb6e678ddso154775031cf.2
        for <linux-serial@vger.kernel.org>; Tue, 30 Dec 2025 11:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767124370; x=1767729170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cweyuKIwKmSRdsl/r/hQ+dHMBlDfUCmP+2wWQS89QfI=;
        b=f+gTwpKHH4WwqrLxOUder43toZtQQvkgiCOq/5NnE8mH5XKaojuNKv6/GlA3k08jCd
         /DkvghkYn8yOJs8+gtgFnaHIAclaU3wVX6pfegmMWI8KXKuaGw0TZvPRAAhx4Cvn3gvG
         vkFG/Pm1C5xMw9K3iqIaTj7mtjB0+lHmHddZufjV571jISd26CjrQ+ys8j32IBURvGV7
         qlKdoP+s6jWdQnIYArbsJwnUKdNSHNaeUlsURx67gLtBymBdrHBHkX5M4w7doZZy8E9U
         KskCNy0U+GhNeZMdrsxQkYtyaH0aLRpMcbMNJ0RZlZcjECXxwdnm+NaDwVGFOWSVJxW6
         OnRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767124370; x=1767729170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cweyuKIwKmSRdsl/r/hQ+dHMBlDfUCmP+2wWQS89QfI=;
        b=oQOFW9sze9wN6Dl2N6/IYlDf2zH4za2Ftdv0LguS832LZEFN+FGlkseLvIEgVU7PqB
         LfjqSfqPGrzjEMgEvYDbVfayTQEzzCEowVfSoE16mei5DQc5H3wL4Ni3/bmev8KDBFZz
         UnmTC0RjK8ziDB9qEMfdgw+eLMdOKoCVlKrl5T05PFngwq8L+qo90wUsWe+UM2eOb0l7
         w6sjU2D2EnKfvg/LL1Cbr7cJU5KU05ed9KckWjbrGB2VRrH95BWQeK5gdWqkDagSCgMU
         n+tX9v/CEOETv/+jWGyAkT5Ow6j78QiM4SR+tuuxpncIprIoe1ADN5dTjjveCUxk7AjZ
         b9FA==
X-Forwarded-Encrypted: i=1; AJvYcCWjoaZqU2FSE3n+ry16EuDZrYZ1Yi4gatwBQca52TBDo7a4vcYc9f2wPDG09kZPnckiXIOBpjNCFxVKZuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YycTDrKrzVzhOiDT4dwkAW3YGTSahpmNArpHMqlKQpF9TLnF3sW
	7duNb0RKaC3rCrVB+fiUER5kC4dDfAuDx3QytBZ8NK/W0qWx5qLCIUrjPqPsIw==
X-Gm-Gg: AY/fxX6H6A4CW4rVNCw5LGFs4GUNpUIJVacVxcQvhMsvBNBI4dVBDDzYEeuVMTPndlg
	qrtZgtxBPaghk7IyYik7Zfm2kPq1gFeNya4gBan9TEyjp8BI9utT05+aNJOgbuf3ag17jcPlB0W
	QcCkl/R1cnx+iMosAZhrH2QOHLvZ1Yp/U2lMeRrHis0aaB9KgoE73ITvPpbk2MOxTdCLi27xXrs
	J8d12vFcWDd58bKtIcDfK9NC9Svh2NT/Cn062pOr8aeKMzCtuMbXqt9T/R/079Jb8whefcmnWZy
	+IsJGtDh5rSpX4T2cZLjF3bs4m06TJVUYv40ZQT/3Jx8Zp3WkEsRaYEdxhZiON3ehwmRVkdaHOZ
	LjbLsJufiz9FvjGcjmyl2qUHrvGQT/lTNr/OGJJB0iuXAtOkv9XAtr390fNBw2czxncxivse3Gm
	47dpeex/wOZFhMzG04JUH6jv3+BHFlcaRawMvsW/Elm8NXMkNFioMDSfzmsQCksXRfqR1K1WqHk
	pcMj6fGevmaWSnW6+M92p6kXheHqVxY
X-Google-Smtp-Source: AGHT+IEV2tPzXOwPHApBAgjAbkeJhyeb+ZtfRECHHa+IQaEP0X/+BdIgcNvcf3mgMft3lyGdkE/kaA==
X-Received: by 2002:a17:90b:2584:b0:32e:7c34:70cf with SMTP id 98e67ed59e1d1-34e9220204dmr25951440a91.36.1767118265942;
        Tue, 30 Dec 2025 10:11:05 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7bc69728sm29598278a12.19.2025.12.30.10.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 10:11:05 -0800 (PST)
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
Subject: [PATCH 3/6] dt-bindings: input: google,goldfish-events-keypad: Convert to DT schema
Date: Tue, 30 Dec 2025 18:10:28 +0000
Message-ID: <20251230181031.3191565-4-visitorckw@gmail.com>
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

Convert the Android Goldfish Events Keypad binding to DT schema format.
Move the file to the input directory to match the subsystem.
Update the example node name to 'keypad' to comply with generic node
naming standards.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 .../devicetree/bindings/goldfish/events.txt   | 17 ---------
 .../input/google,goldfish-events-keypad.yaml  | 38 +++++++++++++++++++
 2 files changed, 38 insertions(+), 17 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/goldfish/events.txt
 create mode 100644 Documentation/devicetree/bindings/input/google,goldfish-events-keypad.yaml

diff --git a/Documentation/devicetree/bindings/goldfish/events.txt b/Documentation/devicetree/bindings/goldfish/events.txt
deleted file mode 100644
index 5babf46317a4..000000000000
--- a/Documentation/devicetree/bindings/goldfish/events.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-Android Goldfish Events Keypad
-
-Android goldfish events keypad device generated by android emulator.
-
-Required properties:
-
-- compatible : should contain "google,goldfish-events-keypad" to match emulator
-- reg        : <registers mapping>
-- interrupts : <interrupt mapping>
-
-Example:
-
-	goldfish-events@9040000 {
-		compatible = "google,goldfish-events-keypad";
-		reg = <0x9040000 0x1000>;
-		interrupts = <0x5>;
-	};
diff --git a/Documentation/devicetree/bindings/input/google,goldfish-events-keypad.yaml b/Documentation/devicetree/bindings/input/google,goldfish-events-keypad.yaml
new file mode 100644
index 000000000000..348cf18d3d24
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/google,goldfish-events-keypad.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/google,goldfish-events-keypad.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Android Goldfish Events Keypad
+
+maintainers:
+  - Kuan-Wei Chiu <visitorckw@gmail.com>
+
+description:
+  Android goldfish events keypad device generated by android emulator.
+
+properties:
+  compatible:
+    const: google,goldfish-events-keypad
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
+    keypad@9040000 {
+        compatible = "google,goldfish-events-keypad";
+        reg = <0x9040000 0x1000>;
+        interrupts = <0x5>;
+    };
-- 
2.52.0.358.g0dd7633a29-goog

