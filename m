Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B582931E5
	for <linux-serial@vger.kernel.org>; Tue, 14 Jul 2026 19:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784056846; cv=none; b=jbPrgirVQUmnQCHgTpMkrM+8tar4U4tat0rF5svxQDPk7D2XdDI1/PluGI2mVc17hK5XLl07lPrRD+796HbvcSg09ylYUpg31X8gb89p93UQk8UYtRV1DWhPshsmmTQFJgviUQXoGZi7eYEkXFJuo3XrDvueDzWIZTPld6ICrKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784056846; c=relaxed/simple;
	bh=+a7dMFgf/n2MevzTFmfFzUf2OfUrlBy9Gq2CMG89zaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UDIYGZRu3Pph1axsvm/tJUTwRUTqfDGKVzoEhono0qvZ7xy9MqTczb7vkwIugq+u1e4F+fwTgh3A4LLxfleT+9YD02q+uLMu/84hE/XBNfGs8afzW59qaa3I5Ctv/cz9MUZr1kxIiLH2iV4CUlBMYsw3HmGr5mleSZqruGcQhhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gMrjWilC; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gMrjWilC"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7ec58fa3e01so23258a34.1
        for <linux-serial@vger.kernel.org>; Tue, 14 Jul 2026 12:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784056844; x=1784661644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KO2pL/LPzAk6bW0DPdWAZBSTIMWvqbQFEPPgH78ikCE=;
        b=gMrjWilCankaLnA1qyWFGlYPzSQ0kiBL4XbO3J5Sn4PBSfNAq51sLEZ7e+HumC88qF
         JYPnLVRSU9VwVXKA9zLyjRvUulxVOYFKfOCAfLiGUQeyQN0zJ6OPBhb5dVlDCYvEZj4T
         /BwsTMenv65fml5dkZJHjxISwJFosFY4e6/q8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784056844; x=1784661644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KO2pL/LPzAk6bW0DPdWAZBSTIMWvqbQFEPPgH78ikCE=;
        b=DM4uS0tl0y8BvZsSIT8k7nXkQxEiePBetl1LSfNSRTvg+HXWvtck2lHe2Jicw2sPsn
         rtAMPOMPM8E9i6acrFHMmjmqkxe4hsNyUpMOvBN7LK4Xv33RrueL2x0lVJ3bhnyJbb37
         P9K6Da0GPQ78p2+NMAPjpfrVHM5eYGiwCLZ+JjBChsplFj2fkn+X+xVGB8DPspqbJHTD
         T+boMus/GmkamhYwAnv2EbRJJwhuXXoUilcijy5Jvl4HtABu96/7PkgfApBSkexVdD5B
         tIR5JdSTTFazez7F+O5fuOc+OWx6xhnG5yDPPq7riUEubgJklR0lOj1cbDE5PbSOrAJ3
         PUaA==
X-Forwarded-Encrypted: i=1; AFNElJ/7/AvYHLACUq8xs0qrKBZ/QLr9tf7QS3O/Oh1XedCFRkOEr01U2GtMzuBu4Ukw8gcWJpFEDwjVMihvuxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdwEwlDWrXBL4Aui8yjXJp3uO1ri7G1P7p/2YCOPvX3cHgzk1b
	d/L5uXOFQVXMk6B75qhYcwWY7rf/GNkgSGDHg7SGQBBBCihDBesJ5m8qGZ5g0w2wuLuPgCvvnQv
	okx6OVg==
X-Gm-Gg: AfdE7cke6K8R+6/wQY5q4okW9oR6jNf5Zwg1CVD9o34CQFYJOOIzK/1FebNvIX8vdSQ
	m7r7Sg14noS6y0mgTC6bOYwLM8Yq0MojisunTgOtMHhtyEQ3pWBAERaZ7NxQNMLMoyVpKhB3ffU
	SjIzaLVzBSmGkNbAos3lJM6yO+Gn917ET6w3commwGIzEC4vysaZdNIqs7wKhTBQqqa07pXTVs+
	Ap5DY1yhCAmGN5QfijaIeIpYFtmJBngsEK2ZLS/IGxod86gXYFiZTODJtDvr4UT8mpcoWbjI1Ne
	zVN5toEx6HgGwOeQxiRcIjH6qsSAlIKFl8bD/mf7xrlATFa7DisrZmVVOz61vSto01dtvZHtZDb
	WUefa4suRLNRsIr52lFgWcllWBZHlyco2joREzhLZqBjTB7Lx+apWa2fSNs51ykSS5Jj19Pzn/7
	xe9+fRPbo=
X-Received: by 2002:a05:6830:4490:b0:7eb:d848:c867 with SMTP id 46e09a7af769-7ec095dba6emr9656696a34.6.1784056843773;
        Tue, 14 Jul 2026 12:20:43 -0700 (PDT)
Received: from chromium.org ([174.51.25.52])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcb3f27besm15476081a34.25.2026.07.14.12.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 12:20:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-serial@vger.kernel.org,
	Simon Glass <sjg@chromium.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: serial: snps-dw-apb-uart: Add RV1106 compatible
Date: Tue, 14 Jul 2026 13:20:36 -0600
Message-ID: <20260714132035.v2.1.c1d92213393f49330ec14d0c670a802181b4fcbf@changeid>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the compatible for the UARTs of the Rockchip RV1106, which are
compatible with the Synopsys DesignWare APB UART.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Split out into its own patch

 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index 49f51b002879..c0d0524458c1 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -72,6 +72,7 @@ properties:
               - rockchip,rk3576-uart
               - rockchip,rk3588-uart
               - rockchip,rv1103b-uart
+              - rockchip,rv1106-uart
               - rockchip,rv1108-uart
               - rockchip,rv1126-uart
               - sophgo,sg2044-uart
---
base-commit: 3b029c035b34bbc693405ddf759f0e9b920c27f1
branch: rv1106c2

-- 
2.43.0

