Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBC335BDD5
	for <linux-serial@vger.kernel.org>; Sun, 26 Apr 2026 11:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777204493; cv=none; b=lm8PwjHET5MuZCwPkjl3ABNnQBs+k/JgBjVSlIhtY4z2vECb2QLCjoqojdu7DsdVOX2aD1/uPw8k2jNgXcnSQ2akISFf1MTa7+j7sy5c1HHOQCcDHEUTpKTRNVL9hrL7mIUxpKm74bii2sjc09dKpdr+H1Fcm49H0ybqYzdaXHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777204493; c=relaxed/simple;
	bh=bXEAu8dm/Md2Hoo00nr0sADiZPaa3JrZAFzkbiCSNFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nUlS+K5E4Vb/z3ZFMcmQl7Nu7rNC1bTwZJR4td2U6kMOtWOJt3hLpMmlFCunL4f5C8EA5pDZsnSTLId7GKnr0J16GTyKpixF3wPbIAiViGtzGvSGTIjrKVWzNDMcxzz6s+tebF/tTGFX5Y/lNCkHJTPJjKRA/eAczFDW/SzqdLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEaUvsk4; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEaUvsk4"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43d7650202fso7097871f8f.2
        for <linux-serial@vger.kernel.org>; Sun, 26 Apr 2026 04:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777204489; x=1777809289; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aFRtYnMfqIjWbEB7Nm5EvqwrTpEBb8Zy5pR0tbdz/Oc=;
        b=IEaUvsk4N4gSFGGOeQNFGcAFcindjpIpEHeosXEryJgxIhMgKIEFJsjLxzJw/CpbQW
         OBZtSMNnxfLQfqZQSFs91cyZNBysIsR0V8UnCJ0HbxDCqxHj/hkJ5p0joGEiIzeJchFA
         L5A9GSTI8eTxKKRb/78NtDNQeFarbj4AqFC+scZxh5/ccWbtE1qQQeXGztvFvpA3wnFO
         OOQbg0K/6nrj631toc6XYragFfQKoxeFfNrGQS8Q4zqBfbo09yUGA8gVzPHsyB+je31Y
         ZL83OUlYHfaXarJC0dO28WD8fNkP72U1IK74LuUahzTArZDlQPsczhlGupt+z52/Ax4K
         rRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777204489; x=1777809289;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aFRtYnMfqIjWbEB7Nm5EvqwrTpEBb8Zy5pR0tbdz/Oc=;
        b=S1MKMBA6rWaByqTT+XTXH1XLbcGue1rJCIXj1MJuLnjZz7IBu0TOklVzD+L66iDawz
         rD7VIsyAboSvBLzttP5zy6wmFhtJ8vECOEDjFiqpI24FOhJdkQSAB9pFkYonPstEDaDw
         lBV5fx14VR/nvomdcH++XYl6DY9/Z1g4EtZm4cohXTfqDFBMR3wi52A4x2+RvFRllnkb
         2MA1TMNElWqB6F5wN8YY4Vrlt1aA3ySMm1zeWWJ1F8yS+cJndilRrk4m6JMrq5EdX7KT
         4tEDk/lD+FLV2EbW5mDIE5hSHwdJMAx3GK9iDkhs6w1BGztL9Lz3qwjfBd3/DCyyD6XZ
         eDYQ==
X-Forwarded-Encrypted: i=1; AFNElJ8AhYSHj8Rqfxxy4GvDPWOGMMca7Ai54mq5Xo83JYSyVSTKVRRawvmrR2j20ieT1HTEEIfV1qw9wo11Ric=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVB2yl8X5ZCOVTtawn10nG0f5ZlgOatoLeX931Sj+mQgx1y8xg
	nSJI2uk/QUyREoHD2q8BnCgKX5X1GZ6zzGc9voJgjBH+RlD1GKLzbfGj
X-Gm-Gg: AeBDieviFnieGz/iTMVWFhtSeAp0l9bYWz5enrmxfapJ7mwKGqfy2yHonqfvYThfpdd
	EdmpgJugbWlMdlw/Ycz/bWmjOcx65SkQSAB+BYMDjdGiBmtDUhUCNuxhoNAyOSTvQH9D1RREtc4
	dcDsoTk+G1RjA7/pRUG7LI+yQR/j0FovtA2UvUCwRctokNjLIs7BH1Ii+XGofM4Y5o50BL5r+Po
	XL7NJZD5gpvUrQrtXS4MsEZXtcRCA2RmMHCWYWbmy1ZKe4zfg77G+H1fVj75YjpTsg2srTt2aDY
	2FK/CFcl3w3z1csBztLT7zk1BUi1Iewj+LrVzat7GcBVBRbqfr/HxnQ+SyvUwR81y/Ib8cIo6Dt
	yTO84tUBR6G7NKgHcAkUwYc67v5S0POfJr38EYhq5qH72JJhp2v68C5e/dWkUvzJepaVhUwG4+a
	d0+Zq88tZOBcK3elpoVxEEyr1afSJI/J8JkpiCLZxevq6UUKBMnHc=
X-Received: by 2002:a05:600c:5295:b0:485:30d4:6b9e with SMTP id 5b1f17b1804b1-488fb77facemr543233015e9.21.1777204488689;
        Sun, 26 Apr 2026 04:54:48 -0700 (PDT)
Received: from [192.168.0.2] ([197.250.51.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891df9e50asm424018575e9.0.2026.04.26.04.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 04:54:48 -0700 (PDT)
From: =?utf-8?q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>
Date: Sun, 26 Apr 2026 14:54:14 +0300
Subject: [PATCH v6 1/6] dt-bindings: arm: zte: Add D-Link DWR932M board
 based on zx297520v3 SoC
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260426-send-v6-1-d49efa72bb09@gmail.com>
References: <20260426-send-v6-0-d49efa72bb09@gmail.com>
In-Reply-To: <20260426-send-v6-0-d49efa72bb09@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2142;
 i=stefandoesinger@gmail.com; h=from:subject:message-id;
 bh=bXEAu8dm/Md2Hoo00nr0sADiZPaa3JrZAFzkbiCSNFY=;
 b=owEBiQJ2/ZANAwAIAT0TvMhUTxoiAcsmYgBp7fz+L8bHJ3v3mQmorkdJFu/1k1Q1rxfqFwIAj
 RcmfDEnmGyJAk8EAAEIADkWIQRDFvS2qgVbJ5UyXWw9E7zIVE8aIgUCae38/hsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQPRO8yFRPGiLSCRAAkC+A/ax7hQyrpCuXnczMhBdavq5k6nz
 1/7GrMB9U2uGk0Uh7bfp2ryxtObfOnxC1ru8NJYgmIGzvvOAZHwLxugoladVsQ9V6PeZK0y6MfY
 KlFVoq0xjVECtaycoCLPkbPG8HZ5V4uAy57OARxd9M3r2+uqGamoYfcD2K7QiSv728ioT5CKmhZ
 lewVdrF8Yek6FpDtgyLHxRpHs3PqgrhhobbTQNs+SG2uawCvPOr+gKdA0MoWHcccb7N9Bn5uAAs
 1KqSciDeXRZ2kuPoiWz4PapElCh9ghowPPZrOnb/iHXlZsPuW5+9RM0tut4GluqeRDv7o7BSQiK
 +EacECiBMZK3EtelUqe2zT6z+25iieUVP20mcY9QvcoDWyWw9uDgthKQQbJiJfXRXq62InRtRpf
 lZYQmIrCeqrmz5P36pttfbGJqT6v86264RCJbfVi5l3VWNqW5LIQ+Hq0qef6sb78Ajdm3+2D9yu
 FnQvDmEacrLwa+oc3wvHRUcBkkTIVOXqRHoJBfI7S0nY8yuzurgzbeqSbMg6snGblGDIslMXg4d
 7k9DhlZc+O/DNXSp7SoEhFWwQNcpCgPwpJaeTOZYrIvQYlmRXx7m0NUFvG9TPXwJfB0/vWFFsVw
 pbDWd0/wwhkB/KMUJv3mkDG1s5usMAJNDOdSRAjIERTcz1Dvb1mU=
X-Developer-Key: i=stefandoesinger@gmail.com; a=openpgp;
 fpr=4F9C2C8728019633893EBBB98CB81F9A72BBA155

This adds a new binding file for ZTE, containing their zx297520v3 SoC
and one board (D-Link DWR-932M) based on it.

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

