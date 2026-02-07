Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7679E3101DE
	for <linux-serial@vger.kernel.org>; Sat,  7 Feb 2026 13:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770469740; cv=none; b=mXBCVcjhDQulWTmtfrPF2f3TXt5yRu4uPkjAIgYAtj5Cnxeg8QhBKdnd/GHchcT4lbHXKwoytw8YzOJiRpD7GEl0rGzK9cbEYgd9ZepTarw6S1tsYNnqRBzhW5MXsqflQ2w1qXWmbgsGojvrDEvRFwaviKofdhCFjnuP6JHZYwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770469740; c=relaxed/simple;
	bh=luQk0DerAVF25F8oYa5dPXRxiY1DpjkvWwyPxuw+n5g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JcN1dzUALqTsvreG411aQrMxqbwB3dyo9Ww1ioLWBj+PIoE1UvP9r2W3/BBdmucBT34WB8K39f2L9wrsfW4r1mbxQFqKwfNRI0EDu3iB4piIiVib+hSOyFshuni+Jln85DffO7K8DPKSh1mkFRTYLPwdutvnmdk51hMPlHG0cSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zd5BzEhU; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zd5BzEhU"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7962119ff2bso13276417b3.3
        for <linux-serial@vger.kernel.org>; Sat, 07 Feb 2026 05:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770469739; x=1771074539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nQ+/85pWHhHQTZFmm+5xHUX3idtLaulzxY1FbmAsiZk=;
        b=Zd5BzEhU1oVEh/s4/5Ip2phNlLy+C+n1715i4fWw/vy5bSdSDAS7vpPsVCL9GJJAkT
         u7BVQc+5KjlpQUh3puZXFEXwzl1VNtDaJowHzboYQ7ZwhH62ihGGJ0cV12HznlWx3mNA
         HNptpUplQmW3IlRbYiaWXiX65NgweZfiVa/Qf+ypDCGQyVnmj1aPy1/zkNO1WhladLGq
         elS7IkzApzs/4YizlorCdKt8bOooRBG3OagYZAmaqMaSvF8oMmr7/MrgpHAMRsA1YYbf
         vsQbWugadqiSc9M496ICBwC1AqZuvtcwU1NAYsZz+r0g3ldqMQI8U100fhG/kWmXAsMs
         IjcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770469739; x=1771074539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQ+/85pWHhHQTZFmm+5xHUX3idtLaulzxY1FbmAsiZk=;
        b=dDCBgoFYVmjBq7fkQDV+ZsFoy+yJ+8yba4dGv8erSegfKF9wPIEg07PMAOlYk20gp+
         yYYiQafJvhv8y9d7Nde6siCijdXhVU+3fcApq07C46n9MGtdXdeO586YuS45GOKULkvG
         wkHFIsjkwLgkjV2aGJpsG6w6H8hu6HeuFreTSgFpUxqWv1mmzy+R8TjyJIHCZd+XOs+b
         c4qq+0WxjBCx+0vGNBJ+8jnQKWa6g+N9VaEUm7TBnuw51KjnZIfazDN9Cc+f256T34gv
         X1W1tGU3scMap2QvOrKzxjD0xA+KyAdIdmUJFlECv68+OfSFxKLky3aYdadMecunA4j4
         PQiA==
X-Forwarded-Encrypted: i=1; AJvYcCWRWmDt+DqT8voJeUSDaLVjIQzkrKl9IU/HQEnA67G67DzZx1mrzLZV0kPRn1WahkLNnYJGPDpWLIlsLAo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq/QoMQ+hJjf8ji2/+nLEwXch1D+9UsDOskeia3z8EQPq2EpmK
	WGVCtpl4uWy/HCvD4P1ZSynXznJMudbKohMNlBTDJJepqpHqPS/gfKIx
X-Gm-Gg: AZuq6aKeNuO5t4w6j7lWDCjaVMScrUTPyccvg4TNCPTGscY+nfXFHVndVszWdLYeu5s
	vJ4PA+hg0DJBS4csbUsGtnbGt3Mko+SLIcHSNwRchBB46kPnq3O67qCtnkwzuVapEbc+6Y2XAyL
	BdLQc9GHXrcjOPMwI7LTCkbzOi4gK6fJEMVyVyicsM5SqZ6E7t07B0XgyFS7KgQ3F4XAV7DG7Q3
	w39pop/aZuROiV5mI8F6zoBL7Ztr//vZ6cLQT7n8JJApe2AdrB76kLy4z791/ACsa5qj/jlHMab
	kDiOM8b58Rm0xWqhuuPM7d+USLWa4MhwoZueVHSCoF1whOwfZfC4og8ymtjz2ePyLRCp0gX8LSt
	SAXLC0hkhd7U7RyLZPtj8vLdcrNrQ5RUjwV11aflq95F/OLon0TPlxmn4WrOFWVd5VDqxACGvEk
	jQS8kXUE65a3Fzkmbr4P8zGx1d
X-Received: by 2002:a05:690c:22c1:b0:794:ee65:6ab8 with SMTP id 00721157ae682-7952ab62aa4mr59344667b3.62.1770469739467;
        Sat, 07 Feb 2026 05:08:59 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:b1ab:5cb0:a2f8:764b])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7952a1db63csm46228197b3.33.2026.02.07.05.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 05:08:58 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: gregkh@linuxfoundation.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	Fabio Estevam <festevam@nabladev.com>
Subject: [PATCH v2] dt-bindings: serial: snps-dw-apb-uart: Add RV1103B compatible
Date: Sat,  7 Feb 2026 10:08:48 -0300
Message-Id: <20260207130848.2833599-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@nabladev.com>

The RV1103B UART is compatible with the existing DesignWare APB UART
binding. Add the rockchip,rv1103b-uart compatible string.

Signed-off-by: Fabio Estevam <festevam@nabladev.com>
---
Changes since v1:
- Make commit log more concise.

 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index 6efe43089a74..685c1eceb782 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -71,6 +71,7 @@ properties:
               - rockchip,rk3568-uart
               - rockchip,rk3576-uart
               - rockchip,rk3588-uart
+              - rockchip,rv1103b-uart
               - rockchip,rv1108-uart
               - rockchip,rv1126-uart
               - sophgo,sg2044-uart
-- 
2.34.1

