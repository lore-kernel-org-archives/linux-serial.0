Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E7A4653A;
	Sat, 27 Jul 2024 12:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722082497; cv=none; b=fLxbIkXKkPHu+uPHkZOhAZxpC5pW2GCpBMzLQ7OQYztVgbG1hmVTXbM6J02ftd54463gVlSVt3eKDvBkZblu4p0HMsSXND8sveU/HJ30hzVKAR3XJNa+YnLaXMe8Zjrwdv2LOgVUt8OYJ5Xr8g5TWBv1AYav4t1Q+rKkjQKUJHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722082497; c=relaxed/simple;
	bh=b6Da9uxrR4UyJRF4fvh8QbN4eQVeb6Nk4qWqno2klCE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=gwxFkO5ca0QdOeCoC3uE3G1r1U9Vb+nId4Gu+ngl9tB6OPSZBCYEf7AfAt26pbiyonMjE8VsnWRkVw9w/kA/uKx0fnn3XT0D8u6HD6PdlTU7CM3MXNbN6cSPCW/rPESSb9IcJczDlQ/CSUmmWmFzXJGWvGCWBLlmx9a/7smzyDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQiWKIsS; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQiWKIsS"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ef2cce8be8so25826551fa.1;
        Sat, 27 Jul 2024 05:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722082493; x=1722687293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5i/RPAEt+X5RN+U7Llg8eBVQiQiZ0+jhsIvicw3bLk4=;
        b=ZQiWKIsSzjS4/zRnAKEz/ku/Jk9PjVT57ENPHVlIhcJZqV6UhGug6rC89QcvfZQipv
         pTTEiTpV3hFJ9f3M77PSjyr9M75Q/SEo1RgWwKNUwH44z+oIvujeiVlDPXHmJdvGcrnd
         U0EE7gr4zS3T/3LKed8gRe1uWAges1u73EqIPAh/3htEjsoPMUvCLSNFC8tzPF4gRjnD
         Gw9NOUzTs0/KT4JRBvdO3oBSoa9E4h35QPru5BWj1LDWYlJJcOQJ71/gMwSBO2T6HH0b
         Vof10g2wj5r2U4YOtolPea9YZx8WuHeNoyq+xOweQr0ONhzw9GL2emidxpaK8APdHxgC
         RxkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722082493; x=1722687293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5i/RPAEt+X5RN+U7Llg8eBVQiQiZ0+jhsIvicw3bLk4=;
        b=CyLOU45Sp0vWOT0rpy1TQzkNXBvasUVw7jpUaBqfhrspF+ZDpIdLZP7sqmCVmh70qa
         3sXuXyFFlzmqzRqLK+7wk5PiWE7Z/dDkvTsCgHmhqYARzyhHNGmbgY5nut7844TMsrE8
         Tc4miFJFX5WscoiqY/W3+SifXT0jtR6rcEHJilaj2SvJqxly2rsvKNtU2T29QgHKPuQi
         WYLN7/n/ZmhWUik0wgHXBDdS19s6Q8vH+ZxqVyge5qMkWeAn6nOHYbeOYRetmmlzHd/T
         tZixcOBMrrsbvj0+3+cdER6B9x9BuTsji8nfHMXIinn6M3nc29413DPVWhGXTdS5fCfx
         XY2w==
X-Forwarded-Encrypted: i=1; AJvYcCVU8si+4+GKklsTtvrTq3io7tGgqe/O9pQiFYe2sadv8zBUy+PUi3EDAVSEmjaVJLj/8AmAOCFU6oHcPXp/pqcfzc+C7dDHtFRD5A==
X-Gm-Message-State: AOJu0YxtpgGvCx3BH9fsnCoRQinOeDik8dtv5XCLFizPEDyji/7z/EEw
	arXrRzCFHGMG9U4AfghnaQpmmoEYKd3NeD7XaY7yllCH02YtJJQo
X-Google-Smtp-Source: AGHT+IEk8TIJM9PpIVUJ/v4T39HeP7HfTLORM7kK3IUCwmiPBpyqRdBIiMVkQeuhuirbkSdQ/m5+KQ==
X-Received: by 2002:ac2:4acb:0:b0:52c:d27b:ddcb with SMTP id 2adb3069b0e04-5309b269d13mr1645499e87.3.1722082493171;
        Sat, 27 Jul 2024 05:14:53 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63590e73sm3005180a12.35.2024.07.27.05.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 05:14:52 -0700 (PDT)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	John Crispin <john@phrozen.org>,
	Daniel Golle <daniel@makrotopia.org>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 1/2] dt-bindings: serial: mediatek,uart: add MT7981
Date: Sat, 27 Jul 2024 14:14:46 +0200
Message-Id: <20240727121447.1016-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

Add compatible string for serial on MT7981 SoC.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 Documentation/devicetree/bindings/serial/mediatek,uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/mediatek,uart.yaml b/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
index ff61ffdcad1d..1b02f0b197ff 100644
--- a/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
+++ b/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
@@ -36,6 +36,7 @@ properties:
               - mediatek,mt7622-uart
               - mediatek,mt7623-uart
               - mediatek,mt7629-uart
+              - mediatek,mt7981-uart
               - mediatek,mt7986-uart
               - mediatek,mt7988-uart
               - mediatek,mt8127-uart
-- 
2.35.3

