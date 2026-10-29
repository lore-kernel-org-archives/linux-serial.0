Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793299660;
	b=l1zrN602gvPQI0gM+Hpr2U0Vv51F7OsI7vV/3QSndfTliMhGqlRQrTcjeGar9GnQ1fNp
	 1V/DHapyvfkdNvnaPGQ20ezGYvd0IozVU2FquSnkEVFletXvQHV6pb2QLVzWb+sZgQAiB
	 9YiCRCtrYmX2K4SHXbVu52rZoKpNKQuijtQ9cNrVFpzFmUOr16tPub84qLOzVX5ogjE4w
	 Bw5rcbvqPJVA4V5Mk6w0kXoxVOpWHQN+baIVQFcam9pnIk0/VbCEvo1ETeN3lCw5Q8zRy
	 gOfWRwKPIVr5LxRvCo5bHFWAu5YptVkKzKl/2LdCmXyA65QLcdx7njiHTJNmkTnO0hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793299660;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=ZiExINcBxtPR/Qkmd5Xw5xLQgpBI2Y90lv+3jQt1oog=;
	b=yl5w6S39Xv+KWKQbjVdKYk3HYnSzdMCEE7lsmo6R5/SqeBVFuxGpHVVswNrc30F0USfL
	 +Z3xG0VB0guah7godEbIIlmCJx1SGsbWYatFfnO1JkIokhHwis0kHCGBl9DUwlzCScRAE
	 Hx8QYdqcfDf+ROKoaOukDSniH9+jsQ3y6giuoSxeMsH1jstz0P1yfGS5m88yufLwv28pR
	 dwKPxyQxT6RpM3WDISp3Uth+08tlaOG3GnPuC1zpSbr+JQvP15k+2xoE5l7qjZKHIsZaV
	 fs8V3C/jIyjGjblpcpGf8rZAfDif/TcdSDH979dNtDfmyH1AhHH0mGRVV0zu84r++6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H3l0uMc8;
	arc=none smtp.remote-ip=209.85.210.49
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7055460A2615
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 18:47:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7055460A2615
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H3l0uMc8
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-843b6f8e2c7so2775249a34.1
        for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 11:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793299659; x=1793904459; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZiExINcBxtPR/Qkmd5Xw5xLQgpBI2Y90lv+3jQt1oog=;
        b=H3l0uMc81HJcpPRBsywanbMbUnGdCuNIr2O7sufq6Z8PqEpFB5X0btCbPE/TdARDBh
         9kSGajs9GDRZXaveRdkg/z63lGQOMQNGajXTe39Orx2zN3WUYlrc6EcS38zyMhEnzFeX
         WTDpQ4quOeVVTFbep6szXGXMMlLIjs2mGrFz7yTe4i61t7yLR3iUWF6HnExXc5OiPEv2
         yT6PXCxybLvwe8InLzlvztmydU+pJlQtQcqsUhz4vbALr6kC9FsqlEuEc9rUOUuKspjZ
         8DcLmRVSKZszIIGaBLRToY1a4gQhkQRPhU/Taw6JiPqyeZrc+WnVuRAB+VB9EbqjvmMd
         i78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793299659; x=1793904459;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZiExINcBxtPR/Qkmd5Xw5xLQgpBI2Y90lv+3jQt1oog=;
        b=DZl+6Qxt2pLxZOMvLNMjLNaAnuqPjuGo/pYaPTSeAnPabdCZN1+gWkdk6QsfLDrILW
         cdFqSTRmeusEu7XBUc3muAcHW1hOM/8a3D6KYDEKxOowLHLBYdA3mdg28bzfAHF1dyJc
         2dygBeSDZcuhr8Uw8xR8GrZ2k80aSV9AAjk+1216ejPpoXl55v3z5YQcvPZ8iCUuUvfP
         nKYGxcOltGA5Y384R9rZ/iAbKFhpp49sTuRY8+XStGtVNjlhpA5Kvqee4JHG4OSBe6j2
         W/WZjw3Hr7oQEy88cFJHDLY2nOhpjWLZ6iLTE4ajrURgF6CRLUxGWCYaObk6ONx1pYy1
         34dQ==
X-Forwarded-Encrypted: i=1; AKwUvBxz+S6kW1EgjerNWNoxzbc1TWB0jFjOWSDsPi2oY2z31tJiM6lI6WJRBc83wN6UXK/b0Ru/+9RAKJ+JeQY=@vger.kernel.org
X-Gm-Message-State: AFq9FYISYp2Pa15YqWXr45uVulgGL7FtNIjGV5rwGzBnHmyPn3qqy02s
	yTBNUvUcewzuNj/VDIPf/JLL9cgoCY11Q2q9v1GMjK994CG1dZTAmU0V
X-Gm-Gg: AYBFou1lEZQ+L3bzwYQxEPjlODlDY1gpBzjDn9TdLOXO7gZMXP1eN6VtyClAxCYf8Rm
	muQ3wmHmaj8jhxX756oSCEG5U+rmM/rHetLXH/8v3xLqhcPVO4xzSqPl1n3CCOjN3u6oL7/RkyJ
	IxdAhlWKmn40UwpDDIgJVeLMJ9oJ1mX017LyqaO+mIny2zTbyofH5halJSvh5vbEUuSvQ8bmK62
	xvweV+K5cCHK7EzdJ/8MQ/e/1sHwNSG4PxG1tpwnKG8395v1e9+MZePZyhAvs8YtuzltXo50+J2
	HGl8rMlF0ALJyvCnsGX0OBSM+ia9HWlxYcUo9qpdox7JhfitlsHNAioXgzgjcEPy4CyXoM/9Xga
	zDfMUv6x2ZrwnBck4GIw4jiisfXIfU9KVU0nb9EshNdka7iokdDl2mLk0H485CzWIPYaT0imL+b
	3mi2FSb7W3r1Njp7tDJ2f2Y/uREsBV/QFcUpg9QQ65bputUK5fEO79SKC/oJQ+KyLOlfi6KkMir
	ISvf7dT0yY69WpCbDOpTnA0b59IOBEmBj3k5ufsaXX6DC7AQ7+0DwBEDqEpPSe+cuWQLqyauvtN
	z7MgoTNv2sLivO0xoDn8LAibjrMf70RIoZ8zCOOxAGIpmXh3VKALt0lU0OWo06MdvplpKlANrD+
	0cUYInwXerrJ9wb723gPGj3chJSLBtT/Vmc9VKBDBDYEksMQNuwYpPWybKOadja3Y9ZXezAjzmg
	PJr5/y/4hVLuEtKZjlbZMehVg98I09tp976NPJMmVWVb5QioPcTlw=
X-Received: by 2002:a05:6830:3153:b0:830:43b8:72db with SMTP id 46e09a7af769-85d365ca9a6mr29214a34.24.1793299659371;
        Thu, 29 Oct 2026 11:47:39 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d354cfb83sm221871a34.14.2026.10.29.11.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 11:47:39 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 29 Oct 2026 12:47:27 -0600
Subject: [PATCH v5 6/8] dt-bindings: serial: snps-dw-apb-uart: add
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
Message-Id: <20261029-submit-h616-uart-fifo-v1-v5-6-53b433aebbf8@gmail.com>
References: <20261029-submit-h616-uart-fifo-v1-v5-0-53b433aebbf8@gmail.com>
In-Reply-To: <20261029-submit-h616-uart-fifo-v1-v5-0-53b433aebbf8@gmail.com>
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
 linux-sunxi@lists.linux.dev, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

The A523 UART integration has different FIFO depths across its controllers
and reports each controller's depth in the FIFO Clock Control register.
Its receive thresholds are fractions of that depth, and its optional
register layout differs from the generic DesignWare integration.

Add a compatible for this integration, also used by A527 and T527, with
snps,dw-apb-uart as a fallback.

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

