Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793142350;
	b=WO0yl2+j+8yrgcODQQqDZvF82c5EXxs6IOwfY8kSNRY4nVBVZccYwWOfET3zAf9HYlsP
	 S9zmvk4o8QvsV0Rn4t7QWcyRC6ASVKmmd54/oByyj+q9i8Zc3zmZpIOT6/arLZG6ycipf
	 iOm9eMpiMmL8u5iUKwadT+//Psppg5YJbo1Ywm6bw+NbM7fJCRtoEc0R8tkQ2SUJ+///u
	 Kcc/thm4DsG7EJ7dXMUAqSvkhwRLtClpfFS2864XwFblWyr6+nvgJAyxstcjuEPAcVUW8
	 IdICCSwnErrwJHqDmbZ6IaE29UYYRssI+YYWERvJtVHqMRkIUTe82eboUaWcKANewag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793142350;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=EG6vB+d3AGeFZ6pBVrncqfS7pzggD8yTk6rsfUsHybg=;
	b=S2nGtTHuvH6YA6cI8E9YwaN35GGrTb0CF8utLem3V+veAjjx/E9Uker4qL/x4Z6ORHCG
	 NLG1/NkoJ2iOD/6u1ATi0htGp3CRLOU1U/iFwHYp6hsoMP6snY5GfiDcPC3sA11nnU+fz
	 OFyw+oV1FWD5JDImnOSqI4k4ZzKL05o5e+EjM2kiSQVY2WLx4p8rBwthhoZ8G45XWdWld
	 C1TCN8hVOE7HOiifOcnZOzz/hJuZADLiuHkB0YOwssCxHFUS/45WCFlmc+vMCBU/aVouH
	 CtLDaJl5Mf6iL2RldOi06LusLtMfqD//9Shr5rJPvsZuTrlQNq9i1SCTAj57SNn3jCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="KT/MDSGr";
	arc=none smtp.remote-ip=209.85.210.41
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0743F606A32E
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 23:05:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0743F606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KT/MDSGr
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-823e4047037so283229a34.2
        for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 16:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793142349; x=1793747149; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EG6vB+d3AGeFZ6pBVrncqfS7pzggD8yTk6rsfUsHybg=;
        b=KT/MDSGr0uiF36n1Qrx6rANybi1J/wRnns6SvuV0WRYq8HzMIRyyz4vdmpsUYZs+Yv
         9IGrgHrXaM/XarQ992vpIS8+mgYqJy2bht2+DF1Rvv+bjFeCLY0njrYrBseRwTnEfaow
         N++QR8p7TKYnPWFQC6IrtpLjL4lJxzeUmcWKgBiej1Eu8RMEZjtlEghRAFuw9++2i798
         t+AFefaWtQ4FBhJpBl3xmicKecKCGVsTq4xShRjQ2k6pdI4+N0glUEc3bwkveLIrivEH
         p8XL0deTfodNScRzHdgMmB+qY/D48qhU6t6jX1y5/F4No4hmKE8hNzIIxONybUrvKRhT
         rIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793142349; x=1793747149;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EG6vB+d3AGeFZ6pBVrncqfS7pzggD8yTk6rsfUsHybg=;
        b=ZtQSElOnfvUk+Wx+5r8K4yQk7LFH4ilXuuk3dmhvtKEw61ECrYzDM2XPG8ZDDvC0Q6
         EFuJST+x2KucO+P8PeT2IdnoLIfD2U8nqhbsdutttqnwkFqgPlTeDWsyQ27jjaZZuGGc
         kGYeJUeqryKa1Oj9iqYqqh10z0Nr+4uVrBh1mOtuZmzno4BhfmZJLpmwn09F9h82dChg
         NmA3/d1meeFNEZdEXhSqdAJSixWqopmbSZZ+vRydNoaeaNbCC/7Bgi/+QU9T2rPvTN5y
         aZO3l6tSSf9dhbMrBr+z+3Y3gcyPpWzA6Op/ye4loTiJxzsVq59RML6pEMp06yVNZ7k7
         RrHw==
X-Forwarded-Encrypted: i=1; AKwUvBxKFWz8dJ9D+oFqkSoGxtE/s/sQbAf00uYlODYv7cPqy2XSDuTGFdtF1VZ+skwC7XU/GeVLM/60WlGvJQY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKFnuSWEQaEOfVAvVhsIT8RWGBasjtRHwLRFpijd/PfjCY+ezYk
	BLGoSKpN2KVpJzdnrghASQ1Cr0KoNeUgr85RrrQ3JHB851vSKRR4LUd/
X-Gm-Gg: AYBFou1mP9dD3PCBMnnjqzm6De7zEZnsmtejNOH+rviUVLKwS5y5TneI0kNgQXMJc8E
	18IfHcBCORh9X/IRgbKP6/Oe6a/w63H1nxld18NLW1fV6x7fuq0x6pKTa6aFgCVY8mZ1Tww2RYp
	v3BZio0+5oFkzuPwx6iVcBLAWhtGN0SbEyLKo0AlK1LgI/v5qnLOFRdnTWI7gwYF5AgUFuqO3r8
	1m+cxA3L2iUnmWfGrJ4xYasQ279ALRefSfl7ZC8g3g+5r35WRdrKTl8+ICw11K6Lj6C1eK7jvem
	xgTHjBoSiG2mY46OzRJdrAKK5j0wV6IQytM9e3R0gxVLclj7y0VVypsUAAUkFdUbXbkyB09BWir
	o4xu+kBTMSlvMuoz2O13g5v7VT7yRKSg6eJTQEpVdzL8xcfuiCunjhWVFoSM+C2rKf8vSKg5xg3
	/vkNyFmnYGg/Dw25C9TQ+dFdPHcUrEjvF0PZMB6A1kGeMG/7nP98KcoqYWxrAQJBSTrmLTxY14T
	HV2NEQ1W7w8+qVFi3hJetb40vchIdh3HpZ7Bq/AZVghY+HNyn74rE+C8EVbIxOwQVgsfK7ShaFy
	vtsajhJyDVN5reOsn0aDCMdXZ7t5ab6AKvHkHR6DU8YV+k/1b+rmBjT35dVD4PAfOXm8kOx0YKs
	CzQjayGZw31LWg8RPZgsNViYXJhSJma41RcXcs/BryFzRwcLw6mKDvHghu2EQvhgRd9B0QeqiQ9
	IoBQ==
X-Received: by 2002:a05:6830:4aca:b0:824:df9:971 with SMTP id 46e09a7af769-85abc7246ddmr898761a34.10.1793142348950;
        Tue, 27 Oct 2026 16:05:48 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-850fb0741c9sm12093328a34.10.2026.10.27.16.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 16:05:47 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 27 Oct 2026 17:05:31 -0600
Subject: [PATCH v4 3/5] dt-bindings: serial: snps-dw-apb-uart: add
 Allwinner H616
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-submit-h616-uart-fifo-v1-v4-3-d37e018fd0a6@gmail.com>
References: <20261027-submit-h616-uart-fifo-v1-v4-0-d37e018fd0a6@gmail.com>
In-Reply-To: <20261027-submit-h616-uart-fifo-v1-v4-0-d37e018fd0a6@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

The H616 UART has 256-byte transmit and receive FIFOs, but its DesignWare
component parameter register does not report the FIFO depth. Its optional
register layout also differs from the generic DesignWare integration.

Add a specific compatible to identify this fixed configuration, retaining
snps,dw-apb-uart as a fallback.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index e2ca126d58ba..fc1289073241 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -60,6 +60,7 @@ properties:
           - const: renesas,rzn1-uart
       - items:
           - enum:
+              - allwinner,sun50i-h616-uart
               - anlogic,dr1v90-uart
               - brcm,bcm11351-dw-apb-uart
               - brcm,bcm21664-dw-apb-uart

-- 
2.53.0

