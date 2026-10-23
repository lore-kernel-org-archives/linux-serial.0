Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792740840;
	b=hmKUPWDkqTemy6TIqryNJAizxDeS8Ayf4Slt5nWeZq2F8DuLVX94yWco17DcXjDbQKsU
	 TfUiwTRx18kqP2pUOOyIOVenalTEK6/yQ27duYb/ytWs91OF1DUsxvezvg9YRBOcL1MZx
	 WVvm0fD6nLckBeR0uofCzTuqP8aip8lEtv4yQDHrl2ybUG45G/T8CQX0MBhSOwovK8A/K
	 WKjQde93AlfKVnNrfu+aGrbWLd6Mq2yt/rzZpRUUUXmPQQfr1g4L8helzp/N/LQWYdX8E
	 OjZLOKhz0tL3zxDgqSxcxJyXLPtQOCDV5oAbOaPHXKkvALCWpOW3YRKdKO7Q6UmutBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792740840;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=me6u6Bbs0ItISJiR06k4tVQKPfQkaZ0ZoYAv0UWBdnk=;
	b=puAyGHHPOZD0Ex32wa2CMCyxgEOv4Js56xVQ/+BSI3yNVoqQ3HPVGzduWZNDsOexejV9
	 3ouBnUxEf5FEb4HxuPNenCd7ZnqNMMANN8C158+nsBLXUwUYCk67jcTla2NpQNHRLrJNF
	 Yqr/u1cdta5demEj6ZX9oWd5FscJPmEsSuGbFteT4JisEgU9V98sUx0rihWBbKMdrmPtr
	 xgu0TDU4nyhu5Mk9n8eIoOakysI+RyEj9Rnu5BZ6STTEVkrdO+gu89j0BOim3c4e+We70
	 daLE+uXd1fJ5WM1zNGPWQa0U7c0SCAgHcXA1rpXAsm+TrOrYDUs4iUzt1LdjstKuE8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EnhbhvY2;
	arc=none smtp.remote-ip=209.85.210.52
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A16E606A31E
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 07:34:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A16E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EnhbhvY2
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-81ae6aefdceso531730a34.0
        for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 00:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792740839; x=1793345639; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=me6u6Bbs0ItISJiR06k4tVQKPfQkaZ0ZoYAv0UWBdnk=;
        b=EnhbhvY2XbYfTl7qeP9r6CgcCUsceSgFL9mfHJXMPEig/UsejZrlWzzKmLih8QUoAJ
         NxcLvphld28+mFu9sTIfbP7CHWA2F9AXJmwxAMHc0RXKfwQ3SWuI+ApEN77IAsIS//v8
         r6OfeABoDDEzRsOTV2ksscTv6KTL14Ov/o7S//qIFTsQf1iyiOoBwWFiBlDJ30cgFeW4
         STFDE6e6HNiOlOFVuuQlnrz8oZPDR28v+N9VjF0oCR27xjOLSqMXBVw8HhDZf2lpfyAn
         njfXd+RnM3y3A3DxS4KcF9SE2jHztvKs3ZgdnBSSLAbnoaWzn5ic06yD/hnpB4CRqEGY
         Jpdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792740839; x=1793345639;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=me6u6Bbs0ItISJiR06k4tVQKPfQkaZ0ZoYAv0UWBdnk=;
        b=0W33SjPl/4xlYH0TtFPtwRVRKtdlXD4BWBcR8KeOZPBmNQ5AnGER9MMh014waFxDQf
         7k+kwzsyye71akaGerxqF/Mf7E9OlAxPhZt8Tc0raxc9F577stdmjw7P6Bhye3t4nhfO
         SN0iwM6FOXQBy4E0lrsqAmPVhRFRW0xhK189cldOxYWemo792aXswlUTzsiISG1bhXoo
         hVDFfK7iQ04WdlN+NYSSDZBPUhaF0SmO2VUPuh3tF8SoXLDUh14Do1qtADjucgpMDNq3
         TaXXdkfOFTi2V07k8wWHu1w8ZEd+8wA/98YlHmpjbXnZCLmfe8Nv8H3K/wRia7ACQH00
         ZfoA==
X-Forwarded-Encrypted: i=1; AKwUvBwFUo3xQmMD8YbTyVL7NWV5K9EHY0jZcSbrMrhx3gNXfL4SrPj5l1Y9it8cOPkr90a4zFzp4ases8tHaGs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJTkMdePJsVulbG0X8Ty5ZIQIPhciOnN9i6c3iv17imAN+NQBEW
	82aFC2Z9o2dtFfbPwoOSDaJBwh0NJ217KtkgAwz4WNbRZ5lABqscQEAL
X-Gm-Gg: AYBFou3Q1ZgCdToVj5TlnxX1R+ZggvVkjJQfJwehUrJz9L/0kYgWVp/UOUQJ9uD0KU3
	xM/+XX0gMya1oFLca0hpccWRtWo6SCdMn6dcZ5Jgv9DPd/U3+n3iWwCchRLMC16SBdgugUoQ/D+
	5ZehOXC2i6oSlLeo4HUNXk1iKKg54clp7JZ6d2EwS5x5ebupFaSjkU4AqunSiklZe8YBjZBVb7+
	8cFrqgc7hy5kkSLvhk7gj4eWiPHTf3jAMpvKth4vQTMPuzAFr6kd6cX7bi2EMlRl9uuswPkw94n
	0aIpy603nkHM/dEuuG6urFtBGcQ1bV49PzTDJa0o18XmloUAXx7pi64QXKAmycWO1DuB1Zs75pS
	tBw58wJNesHICet02YOeapF40RRHxrNBDworWXtb22zfnTa0TVRImb6MsT/YlUZX/Y9l3lFbznz
	dk721xQBNjCyVqOYk1F5i6vGBJgMIr+wT5qG273taWGzgVL5NoeRSoKGlaUrgDrWrUtIHHU5NUP
	LslmD7vwI5zILnhyjtxqj9HmAyNhPnDzRUE0yxYEnewd+tT0FJCw5HtV4C6Bf2zMiUnBBzVIaY8
	cLb80//mtZAHDOvFKGRSkRi9nlfCeF9PALFAkohL0UEhRgESwB20uacOyxeQuyZhySfG8WYRc9+
	DBDGA02yLJ8eiFv8tY9HRk5fghblMC4mdgCQCxzqpIEuLv/S2Ny00qOrxl8AErhv/EMPXQ8qBto
	g0evQ=
X-Received: by 2002:a05:6808:16a8:b0:4d5:27da:a496 with SMTP id 5614622812f47-55be873584emr874475b6e.48.1792740839404;
        Fri, 23 Oct 2026 00:33:59 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55be9880a99sm909562b6e.14.2026.10.23.00.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 00:33:54 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 23 Oct 2026 01:33:49 -0600
Subject: [PATCH 1/3] dt-bindings: serial: snps-dw-apb-uart: add Allwinner
 H616
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
Message-Id: <20261023-submit-h616-uart-fifo-v1-v1-1-e4a3bae2eba8@gmail.com>
References: <20261023-submit-h616-uart-fifo-v1-v1-0-e4a3bae2eba8@gmail.com>
In-Reply-To: <20261023-submit-h616-uart-fifo-v1-v1-0-e4a3bae2eba8@gmail.com>
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

The Allwinner H616 UART has 256-byte FIFOs but does not implement the
DesignWare component parameter register used to discover their size.

Add a compatible to identify this integration and its fixed FIFO
configuration. Retain snps,dw-apb-uart as a fallback.

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

