Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793649329;
	b=w6vsA2izwlqfHJh/XZxE8MM96bUhjfQBmNHRVqXM9qI3+hFyRgGATnMgMisLbeuRhJqG
	 MGA8sbRsJd+rn3HYrm0Gg7Wf5f01SqDSf4ICFv/FfvPapgfrbg3IQ2vRJd9zvwc3BGNqw
	 btBGPuNKFuL8zgLHXB9B2CAli9Uwp2lFWlX8NpHia8VzVBJyLUkgufSkpni6y1AEFWv7f
	 aFndH/x44/livrVJkFJwuIo35Vf9V9EwF2B2MfIh2gY46p5ha0noCk4aRRuo+BTzZczfS
	 KmYY5gOrK8GMkvUD0z3XAbEx6lKLiN8KAWZj19IiNpZup+5rFEPnCxRUF8KAUezfG/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649329;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=HRoIIA2wpujQ0+Dd3LKXeU40GCpk4ukouOoolwO0ux0=;
	b=N94ZaCXdsZ0JCT45t5Tp8d8VyXYY0B2J+hEIaxEioTlPIZS8gxNs3GQl5fiqE0rpeWM9
	 rl2v0oZgYpMhCghp79zPYBFWT+zXIdYjV/makYKSI1D8kuUOf5voABVLfP330WljTOelI
	 lVTeOIFTAmXTfICs1Ym2dBOhgUUbVWJzCnCyrjK7oI2vBrRM6YUxjuE13fvuT1qHTjCKd
	 Lmk6Dswl0WW73YG0ez3u2Tq13u6Sr/sP3r9PHkcpTHP/KTsKEN87I7HiaCqoq2ixFXoRz
	 n+oJi3SEsIkClziOAakJ1PHrh5IhlDKSQAAq6aQQUvQmdiT0UDXdWbzqqeJ/382+ODg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SckObWPI;
	arc=none smtp.remote-ip=209.85.160.41
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8019F606EEA9
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 19:55:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8019F606EEA9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SckObWPI
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-4a822463a22so2208013fac.2
        for <linux-serial@vger.kernel.org>; Mon, 02 Nov 2026 11:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793649328; x=1794254128; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HRoIIA2wpujQ0+Dd3LKXeU40GCpk4ukouOoolwO0ux0=;
        b=SckObWPIPZ5U5QUaJScnIkW49LvzDzWqTzYMi/4o5v+UApWJzMyYGwD+zpGJpOKHEm
         IuzOmAPd36qMIawkt4/9gE47BRcusSGpcfV2qs18o0knGxVzJTV/I/vEq2VUwJbYIAAj
         LBDM9JRH+zTipoD2BpozV5cLIoMVR0J0a1QEyHS01Y4KxeqndfSPDKNYyLVALMX+0VK6
         BkPO5sQxZFQwk/4Pb2009G0bWdTg9Bwivf8rJ4ky5ZxOgJNEcZ39XUi8cgkpmqPmiEeI
         ijMaxjlFWyYOQ6YZHQVUS+hMbQaPEM+wwd3pk/RByx7BNS6hCRCEEMNVFFYzga7+tUHE
         pklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793649328; x=1794254128;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HRoIIA2wpujQ0+Dd3LKXeU40GCpk4ukouOoolwO0ux0=;
        b=OGw2WXbTtd3ZRm3vfuvXsUSrr2Esd/HrrgSRk79zG25OcQJKHQi0CLCmONYLaDUwBF
         LrkxpXDrX3mgcl9p0LHp27OdwGtVMjVm5fepdxlMNsycSfSuPBbC5uWq3mzfUCT++FiC
         aqh/1WfZi7iiiRoHVv/3r3nUCZZL5c+HZHT3o7SU4BN3uTqPFUoRwEZ94ZFcEu2dn+yP
         3ulbTOJRBsG2ljZLHGDJa1lSj/eht2tO8S+QwA9CB9p47wSAjns2m3Zi7MI0lST5oTkQ
         LpwBBsTOTldazcAB7R4/Dei8WT/Y6zJ+D87AQJ8vAICI/e3jr+zEM0EbmLgsGqf1/QWI
         v11Q==
X-Forwarded-Encrypted: i=1; AKwUvBxvwXkPvAgkh9W3w2A+B2R7e6ZEPudMqVYBQeUhuu0fIIIGTo/evgKIRiVqSnwSN3MBPrTP7ZLSzgDWdY8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8N5lZ35ejcgmPbXTxiOUYz57t/dHohEHaqjvVHCvGacNaGW4Ff
	Ay38IiZVUGZBLHF8k6eZ4kzsRXZoNR78dyowEd+Ko+jMx2G5F5KJdN9I
X-Gm-Gg: AYBFou1XuE7USx7+DekTuQ/ohzU/whyJyk+MGv8t13fylVVw1TGutsL8XTRL59LrIxA
	3YyRWYcJsKs2sOpIvqxFWZ7qV1YyWjTpujTFdVHnqOWHNlLJiTX2UncsKjbXpq/WKnAoLE1SVzg
	3YX5UWAGDHxiV7GpNG9gnqDhbr4yechKazg3QFzAc6LP0GOGAmfyCcEVPsqi8LwG5GvFqDGsRWK
	KbC7dyndpJKp2aHkK4fOl3J7W6kkjL3ZOrTuEbSGs86QSXDX+tj1kodQ4yUCnNlwkpDP343EB6F
	f0HQG7chQ6fmxLnaCM5YIxttvbU9w4CH9uL6RRx195NEgmle4pZ3/8xu6Kj3oIjtfmJGyRTJzde
	qjlVXugtqCxcLSA9FXTFaa/OcjwSVMpH51XqovniEygHjBlfQcps5jLBO2GJcto2SSiin1kj0Xb
	ba0ZzcufGIXiVmoul4F2X9S/xEVpG/sLWCCtE2na7V7qGfxZu1nV0k3K1fAkWeU1KIi1VhOpnVi
	nN3ePZamNu/uKfuSB0prPOad5wdr7YOP2buFJwOC7L+9xfpFhAtTaxd4APvB+Nx/ayqXRvEEFlR
	L3RHWCWhgi0pd1HA8KfpSfcqPhMF5NoKxVQdRXlklhuLwBwuwOjl3D2cPpHwbPl1xq2MC5FIs36
	zPwJ2tEAum+o/BdDMCPhGLPaSu9plMGMxu5r0+uthJjRVSWpOnTpp5OaS70v3MszyvShrBktFWw
	SR4fdLSEtSJxt9fInzHruTEVWlRigEzEMVim1pg9smrXCIsbgD4zE=
X-Received: by 2002:a05:6871:580e:b0:475:e2e9:4f4a with SMTP id 586e51a60fabf-4a9076b7508mr7711963fac.24.1793649328190;
        Mon, 02 Nov 2026 11:55:28 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a921353dcfsm7809249fac.0.2026.11.02.11.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:55:27 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 02 Nov 2026 12:55:18 -0700
Subject: [PATCH v6 3/8] dt-bindings: serial: snps-dw-apb-uart: add
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
Message-Id: <20261102-submit-h616-uart-fifo-v1-v6-3-25afcb346b0c@gmail.com>
References: <20261102-submit-h616-uart-fifo-v1-v6-0-25afcb346b0c@gmail.com>
In-Reply-To: <20261102-submit-h616-uart-fifo-v1-v6-0-25afcb346b0c@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, James Hilliard <james.hilliard1@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2

The H616 UART has 256-byte transmit and receive FIFOs, but its DesignWare
component parameter register does not report the FIFO depth. Its optional
register layout also differs from the generic DesignWare integration.

Add a specific compatible to identify this fixed configuration, retaining
snps,dw-apb-uart as a fallback.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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

