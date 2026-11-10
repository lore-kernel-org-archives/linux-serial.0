Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794280405;
	b=B3GXIfOvwRSWBA/RrcDS2POPdfPHF5RZO71mS4jUI9sBQkwcWhjKJuBV1PPp/kXzBg9D
	 kA1xAD8e3Qpd3/AKIyNIcAOmahKhjW+lptDwpIaQitp3ST+br0WpvHH7a5x/8T6imAhIM
	 yr8nkSy7DDvHG0Fog3HXrQZ9Noe+HJxLBmO0DrDtgb1o95SC5BueAXDGJ9rG/KUokH8j/
	 M7i44t9JtmvpNnuugmNSAAnlvLOv8mPovJHf2WhhPtt6Tnomyaz8h4q7EYTGh9NQXz/4s
	 XXDd5chS/lg3ct+SJ7dz8a3920OGUmgZPj/54TV4zlW9BeMogFYefSUVoikGp07N+Zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794280405;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=ZsGYkHSaF8D1INVVG7IqcJD0MRHplG6cSUzvau3umEk=;
	b=PzDSzyKZX5yHvpqvEOgZm3zD0pBNMiLfyoSaH8ZclYwgGtFVcFGF9zYTpqGq/x6bzbz3
	 ivqrPVJAhuezBAwNr+FDw+9h8KSZpk/dlFk+HZeNKNxRJTSF8qWbiPtwB4uBNQEaQf5Sc
	 dRYgBdhBDAIwcZGhUM7hvgrywQ0FdBb9nmsiFFrR33rukHQDdXU0+msL9aVVduQmops59
	 AcnZxCzpM7ChO4t+lZn/jgcSjGN3kiKYm6Y+tyWlh9hG0uW/j7k5/SxIDA6htJsh2m1lp
	 U9EcHJ4W0uikxkrFMWEC/nFxy4Y/fq6m+kGwfV9K1jpxvWNQwzfOWMPeKFSLYmqKHfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l3bjQbyi;
	arc=none smtp.remote-ip=209.85.167.169
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D4760A5BC7
	for <linux-serial@vger.kernel.org>; Tue, 10 Nov 2026 03:13:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8D4760A5BC7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l3bjQbyi
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-55e02e89f78so463560b6e.0
        for <linux-serial@vger.kernel.org>; Mon, 09 Nov 2026 19:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794280404; x=1794885204; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZsGYkHSaF8D1INVVG7IqcJD0MRHplG6cSUzvau3umEk=;
        b=l3bjQbyiXUB14A26wKcSv5ua9dacnx5+WhNFzm0Ki3HQpqBbk3Gsc0Nz29dnZA/MW3
         +MDpuMWMELqUVajxi3Fuc8EKLVIDZJkX4mgNrYWHtfJEHjsNckS/IIeia2rHTtotdyb1
         V9u/IserDlXT9tduNcT9PTYazDOC48j8+Q4T2lyHCsjBdMKbtRzgwWa/C2kg8g7rC4u5
         IHRJFfs/PiG6lfqzYOyzpqw2wdcEBdHRYdiSKXJqwvPBCpLeuFhNgiyXpzTc7t1vOhnc
         CXswg5b/5He5KGHzjfXv4gs0ccrZuxRD3DUXplwUvR3B87Mhp51lTloovxdNsxFA0Npn
         SS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794280404; x=1794885204;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZsGYkHSaF8D1INVVG7IqcJD0MRHplG6cSUzvau3umEk=;
        b=Rhg8XxB6fENVhzXXI1DA1/FzDeuHM0mpQ8Z70eITJ+eIutIomog4CH6vjLM6ziiZ5I
         J3suFuI4AmaP9F3zZ1orsCpGaXBXfCxQBR8C+E0xeRCkdUoQF0IQ74fNVW+BlxBaW506
         9owzKkVDE8tfyMKjqQ5bfqdxfvad8cBGH/BvMCYOWjT3vumUnba+7q/hQ6w1GnbLsoN4
         5sLGj9S6FnpSSzBmIb3OwJgwN/8ZpLzehdtWRGGLqlmvIB/bjBo2pIlu9qggwFELlD2b
         CDA2HLIx5oTLcpHsY/zT0hDh53TqYAIhb2rFqnlSsrlcZGuzJYIUj3MIN4ApmZ/IRKaP
         quIw==
X-Forwarded-Encrypted: i=1; AL+hErEp+8n+mrnWkx7QcMbB/bm5iUcxFrij1y6Bu4PeRJUgqf/AvIPGuLz1z+R3lEogXnFYenPXVDoZ4fJgq88=@vger.kernel.org
X-Gm-Message-State: APuU4Z/8NLWwyZlBu4OhAfc7/Blf9rqPEkUnVbgsOCyjjWfq/IGh9zXC
	3FWzTx8RxNYUG1NwgSarDe0VQu8wnM/uhf5EodpRaVdWW+xngj+29tLf
X-Gm-Gg: AYBFou3U4qQTcg8vP3VqyDR3xaVx1m3dQ+MMprzW2jtFrETcLYGyVr11iKHB6GUTJMz
	i85SHW9qfUDYOn9WSYJAjuGXSgAra+oso5rkEKtHjMFFzvvCXiBhF45LOlevfgNAjU+9USy2OCZ
	xvWfNGXRUNaooC+uD0gUOQzB19eFWlENxK/Z0guz2zzPdLcxGgqJQJsfzG9XeSFzSPC9E7LM6OK
	3eJK0klYIUEbdbCsVrOYpyd7sJHiIoFlFCF/HeGwPPjeBAtVuHjkm/7aS7vZmqmtfJHiXvNZp94
	OH6ISCxG6FDIr4yJeRi61LxsHRZOTfEltsN6pWQHzwvlg+ZM0/TdL/h9VjT2AoVRJ07sLEjYhWN
	7KNE0EKdFr5cHFbD1wEy5UYkInlUfWzd6DOJpJxtWLBUEyF6xPmDTOpu1SlQjYUBPvLVLm5VhAB
	/liaCCCqisjEm5Leo1GgpBoqTr+oiwMZJ7b1vZTZuUUHm4JPNmuNWDseMeG/exoD5yJnsvvqRNF
	w59TJmvD2Qr+I76wBUg3kPgPrBFDNMuLZBjnAiOitIggr+hs14VU+Purmzudb315esb0IlqBvE8
	1rVNc9tIdrw/hCFkHVfx6ffWUR7n/yib7pBP88N4vt9OuCfQD5pLEyhQ/vJHqz4noReO9bhnFte
	5/XN/K8+EPscWcbueXb/Fy11l+rE018zSfhoVUdj4vzaRDLjerMDSVeb9S1jHV8DRs27WTxkNo8
	OZ7hVTHWhTrgDbWS/GV/K7Xgv4DWvr3NRoq/VrvN8neVshr07HOf/A
X-Received: by 2002:a05:6808:509f:b0:55c:8ee:a9c4 with SMTP id 5614622812f47-5683cd30aacmr1359211b6e.43.1794280403760;
        Mon, 09 Nov 2026 19:13:23 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56905736b92sm1019236b6e.8.2026.11.09.19.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 19:13:23 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 09 Nov 2026 20:12:58 -0700
Subject: [PATCH v9 09/11] dt-bindings: serial: snps-dw-apb-uart: add
 Allwinner A523
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
Message-Id: <20261109-submit-h616-uart-fifo-v1-v9-9-3f03961dae8a@gmail.com>
References: <20261109-submit-h616-uart-fifo-v1-v9-0-3f03961dae8a@gmail.com>
In-Reply-To: <20261109-submit-h616-uart-fifo-v1-v9-0-3f03961dae8a@gmail.com>
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

The A523 UART integration has different FIFO depths across its controllers
and reports each controller's depth in the FIFO Clock Control register.
The receive thresholds follow the standard DesignWare FIFO-relative
mapping, while the optional-register layout differs from the generic
DesignWare integration.

Add a compatible for this integration, also used by A527 and T527, with
snps,dw-apb-uart as a fallback.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index fc1289073241..ea6ce99178e3 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -61,6 +61,7 @@ properties:
       - items:
           - enum:
               - allwinner,sun50i-h616-uart
+              - allwinner,sun55i-a523-uart
               - anlogic,dr1v90-uart
               - brcm,bcm11351-dw-apb-uart
               - brcm,bcm21664-dw-apb-uart

-- 
2.53.0

