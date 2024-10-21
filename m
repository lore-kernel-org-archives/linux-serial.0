Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE311D31B0;
	Mon, 21 Oct 2024 07:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729495611; cv=none; b=Li5QHvqkDwRFmuZSEaZm297JITosvyAdufPodaw+J/c64fnqhx/Z0w8SKOsvtgdNKZKpB08EVMuqXywsdnpB3tjKaLsIxkczlzBQPrm6kXIA/km5x5zsf51HsFMvb3xd/5MBf6BoeoIKh5d2cNP7JTRlreCtBWVQ1oYiWZO4xFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729495611; c=relaxed/simple;
	bh=u8QqHC3OcryOJSLDMPIj9MTxOH2N2BQ0dRNlnoxHUe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SYl97b9vH8bPA5bDv8QwU79YeiBMznb3hPuteBmKOTBxfz+kGVL9RADb06VZelxrCzBBpv7BYTlGP7k9AU4Fchxr6fQUPlzLScAk7P+lpZphfzVh6W0sdx5HZQzNN7JIrF1Am/KRZjBC+gvkn04j31UtnTQzwcEiMHmwdA4sQbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LdYNprDk; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdYNprDk"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20ca388d242so27983285ad.2;
        Mon, 21 Oct 2024 00:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729495608; x=1730100408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DhStVY7zbHyyvLFNMH69NpPsE3mDNu4WqRTVLLehUVk=;
        b=LdYNprDkWozguF0VIiJ49Cs1WZr0AXyCLDSVworYU6djcnIqyMpAMhq2eZR9bJsC8J
         gEseZxWasV781ieXu4J7MIZaAmb8nbEO5PGj4QrR0urgLYUTqKzQZM8TJhnJ8mxBw9yc
         NL8wTOy53gwmurllqa9NuHzVlaMM3M+V7keTnakMFio0JZJTaBh2/XeXK9slhrYUXDeb
         eXKhrMJEWOrgYVaoGSQCxu95DrObpFU+wa5T9sK8UKffTf9zu6gI01pB8cvmSVwn/E30
         ir0vMWb55F1v1wzwL9j3tTxcgsf5eSyck4hBoMlaur7N3Vcks1R6MiL1IIOcKrJnwY9f
         ZqTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729495608; x=1730100408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DhStVY7zbHyyvLFNMH69NpPsE3mDNu4WqRTVLLehUVk=;
        b=SzFe6VMtCH0sz+x1bdEEeJbFLTJgUPqyfGoVI80I+PhYiatRz+Mp3EmzLSZ9vSEjnR
         L3yMt9Fm5jwQBaMUeZk0Oij34ZDHkVfBxipiKeF/YIWr+zxAuHBHKL690Vq5ePzi/Bo+
         o6sDo8NPPpJJGOkup0m+ZGSJCINVFqnH6BWuhoRtsATuWY3+PkjoRAaWTvglNEBn3y7v
         buVZkUE4IQJnl+GFpLb1TpBgyngH0nnEI7BQmxCV/uEwmTJk2A7hSYA6nNzJ92lsOiBG
         9g4ubdd9rSIXPvDxTgy+DAN/YGtizkw4h6uFpUTEh6pKGK2KEN4T6eUz2WnNGd4GVRTR
         rluw==
X-Forwarded-Encrypted: i=1; AJvYcCVFPwFEPaUf6HrU55sYRxqeqgSTk8dzf3kceDVMVauRg55j+pK0Xp+KEvSx6gW5fxFUg8C3SzP2YuVersMH@vger.kernel.org, AJvYcCWAhxX9ED7+10/TkzwAd7oegULujWNRwdB8CBR6A3msYyLPh3QaYyuT6KIL4CLkswEQBX0AZj6ZaP+kV6aY@vger.kernel.org, AJvYcCWTl9SO1uL5OKxR8+iclPEU2uF3TXfErO/paHdtdSjr8RSQb1UTrDXJmvUW5ODW/q0z5BCGMzucEXL3@vger.kernel.org
X-Gm-Message-State: AOJu0YyuZQUFwM2tyMKVMyT0jKenmGQKwpym0MLsg4ss5abQoCLHoFq2
	zuckSs+4Z8BCDs9Te5c8F/E5C0ODzwIzCwAP3Hzq2p0lMNCvMTMb
X-Google-Smtp-Source: AGHT+IElw7l9bexTjRbhQGN1GGYDCG2sP7WGjiobMhjR/WMmoNpKUmysk1NxTimqII6uTjyiiEZ+NQ==
X-Received: by 2002:a17:903:743:b0:20c:89b1:e76c with SMTP id d9443c01a7336-20e5a8ef945mr118594345ad.30.1729495608473;
        Mon, 21 Oct 2024 00:26:48 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7eee89e3sm19723805ad.21.2024.10.21.00.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 00:26:48 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Chen Wang <unicorn_wang@outlook.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Inochi Amaoto <inochiama@outlook.com>
Cc: Yixun Lan <dlan@gentoo.org>,
	Inochi Amaoto <inochiama@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 1/2] dt-bindings: serial: snps-dw-apb-uart: Add Sophgo SG2044 uarts
Date: Mon, 21 Oct 2024 15:26:05 +0800
Message-ID: <20241021072606.585878-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241021072606.585878-1-inochiama@gmail.com>
References: <20241021072606.585878-1-inochiama@gmail.com>
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
 .../devicetree/bindings/serial/snps-dw-apb-uart.yaml          | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index 4cdb0dcaccf3..6963f89a1848 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -58,6 +58,10 @@ properties:
               - brcm,bcm11351-dw-apb-uart
               - brcm,bcm21664-dw-apb-uart
           - const: snps,dw-apb-uart
+      - items:
+          - enum:
+              - sophgo,sg2044-uart
+          - const: snps,dw-apb-uart
       - items:
           - enum:
               - starfive,jh7100-hsuart
-- 
2.47.0

