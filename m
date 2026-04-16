Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAE838C400
	for <linux-serial@vger.kernel.org>; Thu, 16 Apr 2026 20:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776370788; cv=none; b=Kt5znnDs7YRiZaVNYo1wTQhXqE73Qgj41WdWNV/RfFZOSNKiIM2FQItEKTd+w5agP2ijo/D4L2HJWbCCYKlv/hnm1mHTFaXEOJNA3kwc+2aCn+ff1jnD6T7wmG4gEL1L7PmzLzdWte24IZCCQORsEH01koy3RKXIwl4GPfUCWcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776370788; c=relaxed/simple;
	bh=46b0d4orT0aFf/zmndY3q3fyMYlikWkR7T7rELFj7TY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SppbXbi3WlfBPaOcHvWThQGvwvvLgvxJvtF3c+xyJODNZjaReDB6bOiX0pjNpBi921IFn2jCpw7V4Cz8kgqiVh3Aq6repORBor1L84Exw2syOIFamCCNZ9lQa7nB975hdtM0oh10AxgEmuBqqzVHTZpbWhpE/OCEkngZ54KN5LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ohgl+9er; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ohgl+9er"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43d7650202fso3964259f8f.2
        for <linux-serial@vger.kernel.org>; Thu, 16 Apr 2026 13:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776370778; x=1776975578; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DSDzJLueNM5BDkJGvQ06iAymY05gESKPpDr8vISvvJs=;
        b=ohgl+9erTxEhQLISBlxzceKBi8vWfAIAb/dbkLAa9+35V4Cyfslr8B1BUn34VEbQ16
         Kg13SBRkNZmAYO05VfbDzPuyZGtF0EJAk4FAkrfQ0ZWaM4dZsx5+AfJliQ0D1Fgp3yBI
         HE0mK3LuZiNEzIRYYqhLqBBC/9Vop8hOQCvOpU0IuuAR1IX+Wqbv3hFgYfyv9ikRvZcG
         uoqs8uWYFyqcoMwu0zoIR3kR2odnp0vRi/LhzyqVXvHvs2r1uFHNMMjoBqTh7dRXVyPs
         e7kvsx655Le2Ep2t2krIN9nTXUmODTRJxOD4EdIrK3P1Ps0rq6JEKNbFhS2weiBN66RB
         Pf6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776370778; x=1776975578;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DSDzJLueNM5BDkJGvQ06iAymY05gESKPpDr8vISvvJs=;
        b=pqKZSohJhXo4ha4lydG+u45z96sJejzWAEeqMumViF2jkRDTJYDiJqELqx+T7nphVy
         EvovWEviOoGz0LFKqOQ3uZ06P+Oafe7fMy+v0ym+C0o2yX4JeRQorfu3W7aS/9dmeEkR
         uaFowSaZp8PiaWAMPP3j7iBF78wBlUb1SYWpSEwOBTh+7hfKY4Dk4LeQC2mmKVqBKQKA
         QUS7rW89pEL7rrcEYyRyI7iA5V8zOiboyc2waOAOewiH6GjWaHvJFhBtYVF3v3XruySZ
         WDsOfekyouE3IeHdsuBJVW/e4G+Jp859Oc2TEvNps5bK8O7w8GgAAnxJCCx415Uitxgq
         e1JQ==
X-Forwarded-Encrypted: i=1; AFNElJ8aMA927xDkEsGkrVMp7AsYTt0ogpQGFIZJ1NPJGKJo8/lIBMv0zK6OTmjborVwzXjN+OTge12ZsnEhyJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYJrrebeEcTQ2p8vKGghXZ2FrmdWSIShBsTgrULIllPHoGPAQX
	ztPzJ9XqghYX986sDoEs36u1KFPcEyT+4dS9RAA4ECjsaoBR8Lo1QiH1
X-Gm-Gg: AeBDieshBQ20mRF3BsOwYYFZXmtKNPVqYz8YWUX+dDkbBg/Si4JzNDNGC4y4/EFcz0X
	1YSCv1dvWoqQRyVSl2wi/r4qPgOiQ2MBowEqdw+MC1x7pYKmZXcbrhspml+qoosV1ilCiZ3i3nG
	+y7ODhbbUOlk2EWh7TMBAA8/p+lzawq1fMwuLyZHPOntoMbbRFPttWuwUudvFHDUaIuxo8yj+nu
	k4ZV8B+gqPAywFiavcKheNXJHooCqb3wbzCMF91y4SWkNohW9xFuRi6IuRfT72uAo5h2bU8eieD
	VnA4PQ2EWvEqZc31K2Q4/UsKlsJqg70yJM3EaYPQoqcbrtGw36pBX9PhHKV9BXs2Xy33LFSO1zz
	GV4opUHXdR4bLikd4yHFOl6pDNx5ubBuqi2wzwn6uGR3jcYQ1TRUkCgTXl+8JbZYhQxpXz+4rS6
	muO0MlzU9giiVcM3cNb/tAOrJnVETA8/AnbaSXz7IBQv6h0g==
X-Received: by 2002:a05:6000:144a:b0:43d:7854:32e7 with SMTP id ffacd0b85a97d-43fe1392aecmr1108057f8f.15.1776370778227;
        Thu, 16 Apr 2026 13:19:38 -0700 (PDT)
Received: from [192.168.0.2] ([197.250.227.196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead35c026sm16180624f8f.15.2026.04.16.13.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 13:19:37 -0700 (PDT)
From: =?utf-8?q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>
Date: Thu, 16 Apr 2026 23:19:10 +0300
Subject: [PATCH v4 2/8] dt-bindings: arm: Add zx297520v3 board binding
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260416-send-v4-2-e19d02b944ec@gmail.com>
References: <20260416-send-v4-0-e19d02b944ec@gmail.com>
In-Reply-To: <20260416-send-v4-0-e19d02b944ec@gmail.com>
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
 =?utf-8?q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1764;
 i=stefandoesinger@gmail.com; h=from:subject:message-id;
 bh=46b0d4orT0aFf/zmndY3q3fyMYlikWkR7T7rELFj7TY=;
 b=owEBiQJ2/ZANAwAIAT0TvMhUTxoiAcsmYgBp4URKNXItypZCu+0613kDJOV5XH377NxspoqvX
 ektAEKCaPqJAk8EAAEIADkWIQRDFvS2qgVbJ5UyXWw9E7zIVE8aIgUCaeFEShsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQPRO8yFRPGiJTsw/+OzuVq9TxsOikjXZ/JIJLrvVQWw4U3G4
 lFVXZwrJ96neS2IhLYGs5ckWpmoublfmEre09aaZ6mKnC5jENPA92KpELewz3m7NDdSf8PJvbfF
 fMWoLHL82F9gFJNMpqu5dOpRmpqrTcx8d/iXRl/cmiFyE0D49uPMWVZpjIrcky4fKIbjYSDGGs6
 Vm3r5QAtjq5nflrL/acVTVNWrPkTRkLFDxntlj2iAHJFeI3l3Qh885HR83Rq6UflGUB3QoyVQ/+
 5P4Z8FzAkJPS8kWxP1OjcexDP2dD5t/QniwflyHIBkFaPV83mjcsU9OZQ4f4m8KuhwUOtPbeVNX
 +7bFP7dBC7nKrl2x39Ab+Jc4QXhYNprHJUPGvYelRsGyDdcgSII2xojIKlJ/riLl6G049StRNB3
 0EtIqw7Sfl+oEbVV7vpNquivq/rNc+Mo7Lv7GSzPEXFYJOoxLD8XgyBE5A6HNmyVy074XADzU3H
 tEBhks0B7h2rIetyIxQ4GYzdLlSTYYt88zeB209x/Bi9m0E4QvGR0J7wUJEzpuqFazRexblTE4+
 LHts/uYe8HAs4GcQszFFyxZkTpQySVAvBteSAoma/TDumkjdBZGcq05/icfPJxAeJg62oGYzSwO
 S0QBR4ZrLatyv9ivQBdfS5kVWx7zTF6Q/1/BQq5Pd3M0+CzMiCmw=
X-Developer-Key: i=stefandoesinger@gmail.com; a=openpgp;
 fpr=4F9C2C8728019633893EBBB98CB81F9A72BBA155

Add a compatible for boards based on the ZTE zx297520v3 SoC.

Signed-off-by: Stefan Dösinger <stefandoesinger@gmail.com>

---

The list of devices is the devices I have access to for testing. There
are many more devices based on this board and it is not always easy to
identify them. Often they are sold without any branding ("4G home
router") or with mobile carrier branding.
---
 Documentation/devicetree/bindings/arm/zte.yaml | 25 +++++++++++++++++++++++++
 MAINTAINERS                                    |  1 +
 2 files changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/zte.yaml b/Documentation/devicetree/bindings/arm/zte.yaml
new file mode 100644
index 000000000000..6eba09edd2c5
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/zte.yaml
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/zte.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ZTE zx29
+
+maintainers:
+  - Stefan Dösinger <stefandoesinger@gmail.com>
+
+properties:
+  $nodename:
+    const: "/"
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+            - dlink,dwr932m
+            - hgsd,r310
+            - tecno,tr118
+            - zte,k10
+          - const: zte,zx297520v3
+
+additionalProperties: true
diff --git a/MAINTAINERS b/MAINTAINERS
index 974d7a98956a..bcade90ca14e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29202,6 +29202,7 @@ F:	tools/testing/selftests/cgroup/test_zswap.c
 
 ZX29
 M:	Stefan Dösinger <stefandoesinger@gmail.com>
+F:	Documentation/devicetree/bindings/arm/zte.yaml
 F:	arch/arm/mach-zte/
 
 SENARYTECH AUDIO CODEC DRIVER

-- 
2.52.0

