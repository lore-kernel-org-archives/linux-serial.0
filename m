Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E1A4A35;
	Mon, 17 Mar 2025 07:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742195815; cv=none; b=IQnYgNtUdBral6F3H1qluIskJzF5p8NbHUFBZ4zv4IdAuZkY+WTVMV2w++BgbuIX0QJD1cYKgmjvAFtpgKrFz0VspwU4/bBTlAQKVTU39rIySJbFZYF9nWos79EgNbVV/D1dwy59DU1h4rHLlJDz3LVox+CMO6IXXdh8o8ek56M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742195815; c=relaxed/simple;
	bh=u4jkOfC/hxCuvSMEnh4rOp8tDLt8ar9dDX8YgUSaz5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kmHmd+/AhrGlIveUG+JBmkYMhl83VOO4fk6Qx79zv2Q65eW9+VuHWLyMzy6C6t9rQZHeheThjPeMgc0PUTtgyCITMRYxQup8ie8seCnFX9ECo3TrmBMiDlpkOt2mMHIwtoZic0fmKizwzAgOKJTDyeGoitTgXAxLrgoFAec+zuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2vF/o1R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2vF/o1R"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 837BEC4CEF1;
	Mon, 17 Mar 2025 07:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742195814;
	bh=u4jkOfC/hxCuvSMEnh4rOp8tDLt8ar9dDX8YgUSaz5I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=b2vF/o1RqS8kgpUGUlEpWyQ7OiN3pW+tlL0hUmJoh0+zpFm1UETVXrfySKfs3dA/t
	 fGsxmah7eOm2KU/+a0ekPxgO0UGKBkCVk1V46+Zp5q6gE/s4UFN4qBY/BiosS7UgAN
	 hytJ0EqlBMphSDaYDYr7CSfbGANax0hKnGAeNEnVagH4L/3VeaH0Oz57BC0WKFlbdv
	 G7dLP47L5Ph4O7OCFj4eCXclQHoGhicDOorr8zld5/JkfZHlBg5MJRFpqFynYqMmQ/
	 FH6kW6vnwjsthU3koKJnoINt8/1dTYQT9s6UqzPWTaTrsVWElpaaDU4xsta5vuqiF8
	 nohb5x8+SmkYQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C26BC35FF9;
	Mon, 17 Mar 2025 07:16:54 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Mon, 17 Mar 2025 15:16:54 +0800
Subject: [PATCH 3/7] dt-bindings: arm: amlogic: add S7D support
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-s6-s7-basic-v1-3-d653384e41f3@amlogic.com>
References: <20250317-s6-s7-basic-v1-0-d653384e41f3@amlogic.com>
In-Reply-To: <20250317-s6-s7-basic-v1-0-d653384e41f3@amlogic.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742195812; l=1003;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=pjx9R4pQY/G2qimVqYxYvsz5cP8LfLzhAKQdoOstkBg=;
 b=pSlkqVmPSwOyI8NpIjVdzmM0dF7bSEPgnLscuEFlUkDSM3oqLF996v5JXdwA2Dzp7BCGd74C5
 FwUzPNVY4OlCN/I/JnTZue47di5tx9sjO7N8/SId5Hu1POtgPNJrtQm
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Document the new S7D SoC/board device tree bindings.

Amlogic S7D is an advanced application processor designed for
hybrid OTT/IP Set Top Box and high-end media box applications.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 9a6e98b55685..0c84c56855ba 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -249,6 +249,12 @@ properties:
               - amlogic,bp201
           - const: amlogic,s7
 
+      - description: Boards with the Amlogic S7D S905X5M SoC
+        items:
+          - enum:
+              - amlogic,bm202
+          - const: amlogic,s7d
+
       - description: Boards with the Amlogic T7 A311D2 SoC
         items:
           - enum:

-- 
2.37.1


