Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9D9189BA3;
	Thu, 24 Oct 2024 06:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729750897; cv=none; b=D55E0xFklpmmXsuLLPEYIY/MQYpaOZY5E6thRTnMAE4qzSSHfO8PGTeVtX9ibPp7zXfSzX/ul9zknwqmkWu+KkpJKtjmxbYAXV4m2sF0jkQx9Y48kctGjST3u8n5DWGurjtAUxygD7SCHN3wy+8GAxBob+6loG92AmlHNABSJWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729750897; c=relaxed/simple;
	bh=uMk2Ly9uft+yRV5uGrrg6sTOLK0kwiDrxpTwEXO9AqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AxVj4ZVkVWhG6wEg8p4ypidY5QZDhtFg6DVmanPRfVWAJQr5bnj+rUTnuyghivghB8g6ksD/5Rb7hcmnTkQScZixeOhMZPJ4oYEJ4Dw74ClOE3KKjtzs4j03Mziga/dxpkJ3cAicRDmeHLukZgV6gohjdiw/6fZsP2zFBPYwRHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBPJBG87; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBPJBG87"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7e6d04f74faso334491a12.1;
        Wed, 23 Oct 2024 23:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729750895; x=1730355695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNaEe42ZAzTE20hSK5G675VpxmTUH3NRtwzoSeF6sBM=;
        b=aBPJBG87B5b7PsHCVa6CaHuGAnE0hmcXqMP/gOAp7vnY19s7amKZpKCePgGVwHQ7p3
         Ad5uVFEjjZ28BJ1JTe2T1vHkCPyJJ8lD3ulCF9rLYHFnzcnFB+WWr2vsgAjvnOFIiHf9
         xh8InAKNcwR4NlSEMBNIzJ+sTVt3+f+1/8FIj5QSZO29TtAShCvA1S+RKT4KFW19Z6J+
         9Yy5Qjj0YECy38o/HxZxWPyFNJKB3TCdEAeyNcfEmJBvatfWFDJrd+YRokI4RJdNJLG7
         NkFTdtMH+qZPui4rYDfzCJYVbWsFVMHMCX/g5QYeMd5xlJ9O4VMcPeq2ZN8w4qvpoGG5
         uJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729750895; x=1730355695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zNaEe42ZAzTE20hSK5G675VpxmTUH3NRtwzoSeF6sBM=;
        b=HX3e9JiSolUsk+CfmhMyqeWL+i1znmEZwkxsdaz01WT1dOd7rK+05olR4Oy3F43kY6
         RVzS/rrDHPv1jKa7FeU2KfBk4aHrpFJOCzylApbOJvBh54ynaqu+HiDvKfHXrYuaP4dS
         VOAsCgQfhB0Jt2pnL6Y/OPCkdPvQwG/aaGOH1tQOmUm7BZAShPWaAngPU44lyChdvEJ2
         eYaHpS0UwB57xh+KNTkdsIvvSosoCEr6dQvaXxqGMB8sskYCcbe/YfnOkMG3ZVHs+ZAJ
         egqraYAOF6t3B7Gk4HlzI/VVlzQBa5NuRPvEjtFARTn2uGSsJnErTUPurxvDJ4STDI/O
         +Usg==
X-Forwarded-Encrypted: i=1; AJvYcCUzAQM7xjk98IM6zS9yTU4bePcf1XQIyZeJdGKF9Nfoh/woEqen5tPNK9ZX0FPY1P9j1wTw0U4+VxvImvcP@vger.kernel.org, AJvYcCWPi8PevxmnyuUh3+wJ723g8LBkcb1KukukQDfpFRf/6FpsaFj9yJNv7F2clUXj/y6EiUzH4rGMGez5@vger.kernel.org, AJvYcCWrbIy1W36KfGXmSfUlhm+adpY23tVWNYJWJdXBlyFzTgyteFQUAQ4Qs/jCLO9NWQnMx7IY2EocdkwpyOIf@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0qP664P6ibR1Fk1RutxGlCf/sY4z48gIft/UY9m/QP8RjhQls
	MfSYuLQeZbMhntojynTdrLINs5PW/0Hp4+w2+xwl/aDD3QOiXbJJ
X-Google-Smtp-Source: AGHT+IHQRU9V34UpqwRA1tzGnoqzkiqVUWiURtkmVi0qK2Brilmwpf621cfDj1iFbZv2LGUH55P6IA==
X-Received: by 2002:a05:6a20:72ab:b0:1d8:fb32:1cec with SMTP id adf61e73a8af0-1d9887d7bdcmr2199256637.5.1729750894442;
        Wed, 23 Oct 2024 23:21:34 -0700 (PDT)
Received: from localhost ([121.250.214.124])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeabb9009sm7980110a12.59.2024.10.23.23.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 23:21:33 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v3 2/3] dt-bindings: serial: snps-dw-apb-uart: Add Sophgo SG2044 uarts
Date: Thu, 24 Oct 2024 14:21:02 +0800
Message-ID: <20241024062105.782330-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024062105.782330-1-inochiama@gmail.com>
References: <20241024062105.782330-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The UART of SG2044 is modified version of the standard Synopsys
DesignWare UART. The UART on SG2044 relys on the internal divisor
and can not set right clock rate for the common bitrates.

Add compatibles string for the Sophgo SG2044 uarts.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index c104bd8446cf..fc263e652280 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -54,6 +54,7 @@ properties:
               - rockchip,rk3588-uart
               - rockchip,rv1108-uart
               - rockchip,rv1126-uart
+              - sophgo,sg2044-uart
               - starfive,jh7100-hsuart
               - starfive,jh7100-uart
               - starfive,jh7110-uart
-- 
2.47.0

