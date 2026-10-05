Received: from mail-yx2-f37.google.com (mail-yx2-f37.google.com [74.125.224.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1AE4E021E
	for <linux-serial@vger.kernel.org>; Mon,  5 Oct 2026 17:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791221176; cv=none; b=F/sJjzjjisqNEMnTIHpV3lsIuNyvZMG0bj+XHpc5KW3MUokB7h1iU6izstqaQ+HeABkqwtUhr2XXr7YS1/73RCi30yeod97k/rePJ5YFmMtGpHq/o8YCxGZELwidt88hywSbzkx3ry5xiyZq8Gl1a81F6kk+rVVZmO8fW8k65A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791221176; c=relaxed/simple;
	bh=RteOrGLlQTXAnYWg5zjbSnYFrD1pgoJ54/qMOu/aInU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S4iBSDMKwUHDR2Ph42xeGP4iWTxe6M66GkGeBWrBRq4WueffgXovYRaWToCfdixyGKLg0A7MVNVuKTHJPNOWJbBqp4IIe4s/3B7Lm6iFdTbMsjjoqnzcz8gpsCovOtLE+MYnkW1dxVeESkFQ2ORJdp3zhfgvQ3hq8gZkM0cfvYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ssoQqnrS; arc=none smtp.client-ip=74.125.224.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ssoQqnrS"
Received: by mail-yx2-f37.google.com with SMTP id 956f58d0204a3-677baaef644so1822086d50.3
        for <linux-serial@vger.kernel.org>; Mon, 05 Oct 2026 10:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791221174; x=1791825974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mcdQtERBvEEEhQkX7i6RjlhDSgKxE0CpVxD5Gi87UTw=;
        b=ssoQqnrS9oZqdE2wLjqbCqYpW3uaMGwbUYtTR216b31V+vSNQf4RrWELEdaNBW/5rI
         VlSL41I9SIvlDz9b3p/lZsNNzV+lMNaf88UKyEMxK0gZ8NrtJEa3mflA+SOxOJdZlZWO
         MbNr0cHJ1scG40NKwLqOsS6kNtvzCl5JCiJPAn9VVnXnQWzZO/+ONpwyefwbRsHRi+p3
         RKhKgnK8UGBhyKXLUhbbsECt+eIdWJl4GSwLbwCO/Z5ATOSJMq2i6pW3qKpO/6frWPZa
         E2qbmBqoVULvaUyT8rhV/4rQTSjoF7UET5fvpKWibY1yF7GocBYDvzUUV/7xsUvaJj9s
         8RKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791221174; x=1791825974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mcdQtERBvEEEhQkX7i6RjlhDSgKxE0CpVxD5Gi87UTw=;
        b=QP9NW1V1ZKNbJ1GyHKznNulRNg/tLz/ZB4gmT7Do4RtHERdSelgBwZKekAbKE23KKt
         u/vz7n/V/ntS0HdDVqhRNLhkVW9jBONTYk6+4N+JR8VWc5eVgfhWXpQcAnrZNrjCUxIl
         BUcHVbm/qCz0svPJ9hmWnTR09bhGsMX7yxzrBQI57+YHKVeBwF4z99ZUxxRCG6bCwYtD
         NUJVEsLr268UPYHFMLuBQRSxZwOmiVI0mAsohrFyjuQqBlmIN4AfpHghmyIDdu9xQ1eR
         FJDr6RVnFBBa8w1uywQFUhwVK1fwoepqFWfVsHIgUf6T2XZYqa4bVe9+V2vgxYn7uZW3
         pK4g==
X-Gm-Message-State: AFq9FYL9TfEZBCr2WFmkup/chVi3OkN3LNPXp3/Mc8ro0UCl68FioFu/
	2YZUEYgfSBS/fZmaxXJt8Ls7tH7gMxFZVoSNJjKMYBhdmkVY010+KZctR8shb9TQaZk=
X-Gm-Gg: AYBFou0WNQ6sXJVMYuPi3CuQgkgsywRY+qcJyrf3wu8TJ/G3AQJykrF0Cuy3MpxHorO
	JxLX3m5sn6OqsEisbsBYLLCr9WRstwRuH9P/RNZ/DhFtZ0n15EZBR2end9MpGSyMPCXqvVV13AY
	NkI8AlBJktx3hEwcDTzS+uvwWYtaQg5IkA5y8A2YoOQksLRcrlHshq+Y02pu7JCPZadfxuHvOR9
	+7hsoiyI9CCYR0EExkXXp7z5N3lVcmMfjcPY04voCTHRyQhG5eLYshSEq0HxLcC5saw1vv0e7Xf
	gMbJpy6vH+MWRKRKopfW6Zq4SpLJNzHujKZ0q+nE31xeziled9xfSLtb2JvmV8hYolYpCT5Qpd3
	O/bPY60ey7n7uyW3SPo2AXXhlr8cVWRNfra+J0nQoMk46jotCrK24kEkLkRUVmAWSd6NB5ernB3
	Ve5O0TK10Pl88NvwAXbAYZBstMEeG74cYOFXHXaY9w9S+N4wmYz4Jq8IMwSoVg49XRfA6/EWUgq
	3cTH4Ohs+peg5Fo44W10MMsiCc0OzlIWnzFjKbp8gJlue5BWSzxtK38J1NAzSfyLOlm4tQ6C9I0
	iemPuQ==
X-Received: by 2002:a05:690e:11ca:b0:675:5ce8:f037 with SMTP id 956f58d0204a3-677abf9bb0cmr4946331d50.35.1791221173929;
        Mon, 05 Oct 2026 10:26:13 -0700 (PDT)
Received: from MaquinaLab.. ([179.179.237.181])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-677c1b1b585sm3449969d50.5.2026.10.05.10.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 10:26:13 -0700 (PDT)
From: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
To: linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	Enzo Adriano <enzo.adriano.code@gmail.com>
Subject: [PATCH 2/3] dt-bindings: serial: snps-dw-apb-uart: Add Allwinner A733
Date: Mon,  5 Oct 2026 14:25:37 -0300
Message-ID: <20261005172538.398522-3-vinicius.eduardo.pedrosa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261005172538.398522-1-vinicius.eduardo.pedrosa@gmail.com>
References: <20261005172538.398522-1-vinicius.eduardo.pedrosa@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Allwinner A733 UART is a DesignWare APB UART with two SoC-specific
differences. Its baud clock is the bus clock gate, which can't change
rate, and offset 0xc0 holds an RS485 control register instead of DLF.

Add a SoC-specific compatible, with "snps,dw-apb-uart" as the fallback.

Signed-off-by: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
---
 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index 86dc25919311..aa8cab5ba3d3 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -51,6 +51,7 @@ properties:
           - const: renesas,rzn1-uart
       - items:
           - enum:
+              - allwinner,sun60i-a733-uart
               - anlogic,dr1v90-uart
               - brcm,bcm11351-dw-apb-uart
               - brcm,bcm21664-dw-apb-uart
-- 
2.43.0

