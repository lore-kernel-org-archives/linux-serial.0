Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAC718C325;
	Wed,  5 Jun 2024 08:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717577693; cv=none; b=iDa+7MxqT72L6U3s+POFUrn0PylCj/gH5cXo9ScyArfexFP7y0NTfEpEJeezvzRmpqHrHJ0cRQmNpTXWOcY0xKz8WOfZ98wXqEFc3BJ7jt+L8jEXA6zGITb4m4W2ijfs+73PiHt2CSelm1jL/dkqoiuVULXqCY0JNbhn1OjP3EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717577693; c=relaxed/simple;
	bh=j1VeNoj7R32aELiytQuofZab1h4obOWcSxP6MAJkbeY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=atsv2dd5dmPV5ad1iVFnHiWaZlEnE3/i6rM+uaTpPSJKPpP4SLNBCEek4ZoPgrZGZ0vjb6J/p8GE5/OScdN/qbnevArcHVuS/zSPFiec6DB+ncQPhc9Ec5BSIwjUTiFVpy6bHg5ggD84q2HZzqFRtja+x9J3EQUok7R2h/Hptqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IvHmQw0J; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvHmQw0J"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57a30b3a6cbso2484457a12.1;
        Wed, 05 Jun 2024 01:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717577690; x=1718182490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pPVdkB+pK8vyeCGT+ND71XGGj9LFWm9WJb7b3YJ5ouw=;
        b=IvHmQw0Jllyzlm/KZx6gYVZzKdtgJ5g+NQpwrja7lKSvKqhd1qivePw6kmglC2RM5O
         CRa3IKVP0/ndaOx7NFTGP8dIrtviZqpgeUE6KnV1D5CUEsZQOwnWHFh7pR3jd7+DRXR6
         Hxgnu0dZgaDJnHMVQfams4XngV2q1kCw/VXLI/MLu81jXIFjc/OwexjsYlDsFc+E3MDf
         ejVHJN6LasLWcrahCuHwTVbkyfgtnjPAWBdcZwUJPeYIuCFkDdIWXvm06A1EJrLKoA81
         y6dwWvFvQY9vQiO8XT2FMvBMTK8mJRBzAA68FC5sMsVB5S15mGyBYplquOLuz+L1s/2l
         s70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717577690; x=1718182490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pPVdkB+pK8vyeCGT+ND71XGGj9LFWm9WJb7b3YJ5ouw=;
        b=XB3OjSRd2gLoSNeoshR8vpmyQ0DkYs0/WK/fKEf+tQp58XRIQR4XAjYJeZKKdIkfuI
         aA3ZwNdn1gzY+SAlZ2UEuF0jClmobZLS+YqQJU4cxyfEiW4UYiJ2jlISfvb4QC27wBsJ
         06AE0WpVFJHEcTSIWHHATSF50yp+JHtUlGf3BEPqKhZqATxYUybkVj8KADAZmZfUelcZ
         wVDO2QZtiDZmogor53OSiFD+kXrh5u2UTY/Rs0FzLYQ2o0ahEXI759PdQBmTFOioWcXH
         RWY7wbL7i78QnPGvzuHXp2d+JWTPuXS5kfd/WzG7fUSYFPpsGw6K7yN9h71gUNxxYlGI
         r+iA==
X-Forwarded-Encrypted: i=1; AJvYcCXokS6T0mE/qYJS+Et+j/MCZQ52sgUX5/2ywAVy0mkXDmeC6inp3pQiKSlA3SdGm4q5pf6GCbpKnmnNVW7vtoRlHL2Cz2eTwXgdwA==
X-Gm-Message-State: AOJu0Yxg61ab0B8hfTX/w2+UGipOWPfiHV19zrCpaY+8H79s9/x4TL3O
	ebVLPHegv4AnAWVq+BgcUMoKNubVU1iFWf0fhYMUtJsIYIFwlRpM
X-Google-Smtp-Source: AGHT+IGqKF5PNj+xnr+4M7kJ25iQkjtQ7GBoDWpJYm9/t1zTf4oATxXyIasJ3eML47Xf5OpG0jY+vw==
X-Received: by 2002:a17:907:1187:b0:a6a:44d9:7d15 with SMTP id a640c23a62f3a-a6a44d9810dmr64892366b.58.1717577689757;
        Wed, 05 Jun 2024 01:54:49 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68bfe84c67sm586249866b.62.2024.06.05.01.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 01:54:49 -0700 (PDT)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 1/2] dt-bindings: serial: mediatek,uart: add MT7988
Date: Wed,  5 Jun 2024 10:54:32 +0200
Message-Id: <20240605085433.26513-1-zajec5@gmail.com>
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

Add compatible string for serial on MT7988 SoC.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 Documentation/devicetree/bindings/serial/mediatek,uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/mediatek,uart.yaml b/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
index 303d02ca4e1b..ff61ffdcad1d 100644
--- a/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
+++ b/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
@@ -37,6 +37,7 @@ properties:
               - mediatek,mt7623-uart
               - mediatek,mt7629-uart
               - mediatek,mt7986-uart
+              - mediatek,mt7988-uart
               - mediatek,mt8127-uart
               - mediatek,mt8135-uart
               - mediatek,mt8173-uart
-- 
2.35.3

