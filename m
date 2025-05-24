Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E114814D2BB;
	Sat, 24 May 2025 10:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748084187; cv=none; b=JwhyXtSZAzMkLKJcVBk1u61ztkqvEip3CHti2nDqldkbLCkO7vvCMwucMDAF1v8UQwTndGiT5TIfa47pf1ualt2Tp9Uiy9lA3Jcwktw9ECsn92vkIE30E/fSD35MgkSnH17lY9rkRkORSfmawZH9X9ZoJKLjIx0lJhuBd/jyALk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748084187; c=relaxed/simple;
	bh=WE0kgvDITtZnrODEFSMQk9tKE5isb76hzJsEB2wuQaU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ajUWWYB5vSGddVgGik1dDet9Yelf4qsPM7qoNK2sKQ0yaOpde+hzFOHsmPa+VNIQDGmTZk//qb8+PZV+HHawei+TTwQxOFFYwDd4vb500ouUbtt/nRsHK0j7oWvNte/3EHZR0NyOqxVODAXIl5VcUcGq3HS0g1AK0iHaJW7x6iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=FsNd6aE6; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="FsNd6aE6"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id DE5A025EDC;
	Sat, 24 May 2025 12:56:15 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KwOLixt4QMCY; Sat, 24 May 2025 12:56:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1748084175; bh=WE0kgvDITtZnrODEFSMQk9tKE5isb76hzJsEB2wuQaU=;
	h=From:To:Cc:Subject:Date;
	b=FsNd6aE6wq6udj8N+rjdzWkzBDRozqG1cisDhowC5ztzn488hLCivy9ciumJNgnHe
	 x2j6xoEcibsIvYc+5UYfZCcd8dOVYmDBZDo/WaCmUhpyIiKIuc8wVj10VGoKEtwwHm
	 lxO21MvsKS6aP88cVkD7nAarnLtR+owzyoZzKtq+VWZWhCKVWRKOCHtYHaw4QIXzVc
	 /qKhU9fAn4b+tzgkZLT1mif0srTfIj3Zbq0k91DsSpdItrMofRugLMFCNCScwQ/Qf1
	 aS1imJjXQzyWVS1vFsX58dKA7Yi2ZIUNcgG/OGnwmoC/d9Ffw7V85PjzZvftzw7S6N
	 dqnu212JjH9pQ==
From: Yao Zi <ziyao@disroot.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lubomir Rintel <lkundrak@v3.sk>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH] dt-bindings: serial: 8250: Make clocks and clock-frequency exclusive
Date: Sat, 24 May 2025 10:56:02 +0000
Message-ID: <20250524105602.53949-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 8250 binding before converting to json-schema states,

  - clock-frequency : the input clock frequency for the UART
  	or
  - clocks phandle to refer to the clk used as per Documentation/devicetree

for clock-related properties, where "or" indicates these properties
shouldn't exist at the same time.

Additionally, the behavior of Linux's driver is strange when both clocks
and clock-frequency are specified: it ignores clocks and obtains the
frequency from clock-frequency, left the specified clocks unclaimed. It
may even be disabled, which is undesired most of the time.

But "anyOf" doesn't prevent these two properties from coexisting, as it
considers the object valid as long as there's at LEAST one match.

Let's switch to "oneOf" and disallows the other property if one exists,
exclusively matching the original binding and avoid future confusion on
the driver's behavior.

Fixes: e69f5dc623f9 ("dt-bindings: serial: Convert 8250 to json-schema")
Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 Documentation/devicetree/bindings/serial/8250.yaml | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index dc0d52920575..4322394f5b8f 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -45,9 +45,13 @@ allOf:
                   - ns16550
                   - ns16550a
     then:
-      anyOf:
-        - required: [ clock-frequency ]
-        - required: [ clocks ]
+      oneOf:
+        - allOf:
+            - required: [ clock-frequency ]
+            - properties: { clocks: false }
+        - allOf:
+            - required: [ clocks ]
+            - properties: { clock-frequency: false }
 
 properties:
   compatible:
-- 
2.49.0

