Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB2E37D133
	for <linux-serial@vger.kernel.org>; Thu, 21 May 2026 16:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779380502; cv=none; b=FVH17iqrKEd3uNWvaQG6E8pztvrobjcOKsRLY2+/YCvJNFNRVnq+IIed6jSYdGns7EWSYMyY04N8kNgkF4LNRTl2Itqhz8qadaQNY9Rdt5dW3QNupL05+yH55cmnKlFP8KLVSLF23qPrKe2ZbESkBlbtcbCPUUf8JMzkHvHFhL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779380502; c=relaxed/simple;
	bh=DgWFXLtzfponnnypUw4/tj4fR2zGxcUlWHS/gPBJB8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V+kdqVMEthmQSyEiIrkS2hyQb7gVD+wGz/0PsiWOLZrYD2j36d8ONVpHtQpsSkckaCGEoX/Q/zK1TAvAVbgELIBnBXrH9SOIsrnTaZUp68kx/cAMPmGU8TToA4TvOrqcO7K2rWaSYYKkVAMlrBdKAlmcglruVGm9y5mSNXiQos4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZPHR5tM; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZPHR5tM"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-65c7a459105so6777666d50.0
        for <linux-serial@vger.kernel.org>; Thu, 21 May 2026 09:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779380499; x=1779985299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cL1sPLr5+ydzzDiEyMNfe2AK4DMdgM92vvCAubLu19U=;
        b=SZPHR5tMugU3d8IAO3yOMt0TdcJcv454xd8dCsiOGXZDCOkvS3QdR38CyRsRsxmmez
         lc7Dbw+xyMbnNv/qUozqhcpWq8je5QJt6QKVnSGfXh7/ulsFIrd4boLbgpBGZRJJxha9
         b+qIrE0Kvro7KG4J7jGa7jH9BW694dLpTMbhSXO71ixWQ7v3UG0vzljX0ejILAlptUJq
         Rne/CccigFxomC9t2Jw6dpJHLN8L5LfMsRvS8uAGaJ4wSCCn74Sz2R+g59pD7pSQqCDk
         gwoWH9w82JQo8RRsrUrJ18z3SFxr5oQilBJywyFqnQydU+D4x6R5TDuxmf1HEJ8DqoVw
         IMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779380499; x=1779985299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cL1sPLr5+ydzzDiEyMNfe2AK4DMdgM92vvCAubLu19U=;
        b=dVrUYen5SZckGSlurREmcYuwEY/f5zwObBEAVPYPrVyK1DWRW3UAydDgkOIpXHCPq3
         cYvLh8v3XCOC5oJlts9qJOY/NLjMKho7kqbju3P6fsbWhaGu9LVuql8ya+d3YQz+OPLO
         hi4awdNYYKH/1e5mHncet5Z5GpsTTLdsjDALmhc7LncPenkyHvDTiP+iUpS5BVWA8vVj
         K+8vLFffmuFARi6skSsQAU5H2lIIC04jrLysAagj47khrbjGdXrjPvSnqwgJ1Ockxmw9
         +dR/I4M5sM9lx/kJvIW+FDDe9g17hu5hN8ztLhVwmfVR7DRaMGPW9qhvcyLMdQvI5Oi/
         PFwg==
X-Forwarded-Encrypted: i=1; AFNElJ8sVcd/zU56F5oLJNiO/evq/gKALU8wVfC9WNXFZp/H641DiEIhaDJlZHJ+TITMZJPAOqpXDEtDBFnx93s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw8UzaJ2xOgw/ej84OkAs6QThMxVhoN3vWj8PRf9ZhIvnIGhFD
	RApwU6DkAH71HUy0MwTlR7uTVdZHTracXETzZIDMnj5dH9sN0HAQXmF+
X-Gm-Gg: Acq92OE267JFOrnoCZeD53JSLf5fjZiyO0XDJ97avcwJVjSpD8aj/lx5GkHckJGADGp
	a1b2meeAomvGyFHzIrTKN9hZLtIENH0XBAwteICDUAc8YTRVK61+bxOO4uRzTHdBA2i7kWZwrs4
	mLQAvwXjXLUU5QZZrpkM1y9TKSfouyozA3MUKWgjRmCMtC9I+awJI10nMAg8Isb4GacUSj423ly
	4PyBflgGyYh1IBv6f1Y3362DlwZk08uX6YRPzwK1Mu5Qgii4NJgwy8DeAavhqPpsxG2yRkOYHxK
	beGW0LJZb7Cg1QV3m1JYWY6ghoD45LG0Qiny2FTgSNnuFHMYQe5N38BwsZZOe+kOjPNBxUGaWP1
	9zbEWRUIbwXkiZ5V0lys/0FW2BNH+pSKQHmoHmdwn/hV+yQwknvkGOBxlZAZnX9exsOSu1yw7pG
	FNjVTQ316znoGBjDueMZRCyotWZFBxqvTl+yb1Tcj/2g==
X-Received: by 2002:a05:690e:bcf:b0:65d:29e1:970b with SMTP id 956f58d0204a3-65eacd52f6bmr3179382d50.14.1779380498797;
        Thu, 21 May 2026 09:21:38 -0700 (PDT)
Received: from fsh.attlocal.net ([2600:1702:56e9:4b40:ed8c:6b8b:1fa3:d14b])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65ec1beb3f8sm391186d50.7.2026.05.21.09.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 09:21:38 -0700 (PDT)
From: Akash Sukhavasi <akash.sukhavasi@gmail.com>
To: krzk+dt@kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v2] dt-bindings: serial: rs485: remove deprecated .txt binding stub
Date: Thu, 21 May 2026 11:21:35 -0500
Message-ID: <20260521162137.6325-1-akash.sukhavasi@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The plain text binding file was superseded by the YAML schema in
commit d50f974c4f7f ("dt-bindings: serial: Convert rs485 bindings
to json-schema"). The file now contains only a redirect notice.
Remove it, and update references in serial_core.c and
serial-rs485.rst to point to the YAML schema.

Signed-off-by: Akash Sukhavasi <akash.sukhavasi@gmail.com>
---
Changes in v2:
- Update references in serial_core.c and serial-rs485.rst to point
  to rs485.yaml (Sashiko review).

v1: https://lore.kernel.org/all/20260521150748.4816-1-akash.sukhavasi@gmail.com/

 Documentation/devicetree/bindings/serial/rs485.txt | 1 -
 Documentation/driver-api/serial/serial-rs485.rst   | 2 +-
 drivers/tty/serial/serial_core.c                   | 2 +-
 3 files changed, 2 insertions(+), 3 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/rs485.txt

diff --git a/Documentation/devicetree/bindings/serial/rs485.txt b/Documentation/devicetree/bindings/serial/rs485.txt
deleted file mode 100644
index a7fe93efc..000000000
--- a/Documentation/devicetree/bindings/serial/rs485.txt
+++ /dev/null
@@ -1 +0,0 @@
-See rs485.yaml
diff --git a/Documentation/driver-api/serial/serial-rs485.rst b/Documentation/driver-api/serial/serial-rs485.rst
index dce061ef7..f53043d21 100644
--- a/Documentation/driver-api/serial/serial-rs485.rst
+++ b/Documentation/driver-api/serial/serial-rs485.rst
@@ -132,4 +132,4 @@ RS485 Serial Communications
 6. References
 =============
 
-.. [#DT-bindings]	Documentation/devicetree/bindings/serial/rs485.txt
+.. [#DT-bindings]	Documentation/devicetree/bindings/serial/rs485.yaml
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 89cebdd27..df4589880 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3496,7 +3496,7 @@ EXPORT_SYMBOL_GPL(uart_try_toggle_sysrq);
  * @port: uart device's target port
  *
  * This function implements the device tree binding described in
- * Documentation/devicetree/bindings/serial/rs485.txt.
+ * Documentation/devicetree/bindings/serial/rs485.yaml.
  */
 int uart_get_rs485_mode(struct uart_port *port)
 {
-- 
2.54.0

