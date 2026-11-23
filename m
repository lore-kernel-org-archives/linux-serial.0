Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795432746;
	b=ej+phrgBOnRp8dVo/1csp97CmzukFEdALk9f5uQkiNK4squ4vIqzEt0DbbMHKrr9JC2x
	 K733FD2toc+tVomHz0LyiqKY5lfLG0voGWdr7NuLzjqWW6j80n2BqQd8QL2hXpBMyZxjo
	 QsAsd0SmgbUiVTKuWu2Nj76tCrnq7+MdB1ksXKU6CIILfH11koJUKdZ6Mwc/3Y7ogVvUB
	 XZ58AtWOYouO0GXwZmdKDVA9qyXST+Hi+t5iAuX6vHiXvU/+WcqfXJ/IBXPbfkB6IdOLu
	 M1KULcjl2kgO/PX5PJJKvoF0z1CZ3s5L/VITIcJAulfwFR5oKXKAFFqNGOh/pbtLjcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795432746;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=EtVDEEY+1Q2B+PJRdO/nFO/tm1fJ8wXwnQSpYA2WKh8=;
	b=qn0wuupT80Z2IVdO+k2RqJVuKp5n64e1luu+cHsbm10lXOObpiyWZ3qMrPmuIh9fnSQ6
	 YPdHrjV8V33GyKGl0QbnP+SN0fM6HpwsrM1eUHGNq+jKdlzT+pqnUWeOdJ/TPvvWSvkZO
	 vVoddtiA59r4MBP0LzTdDqQ9IqGVBGTEU/w/9jgc0jq/kcKzhpQxhT27UEGB9ao6ZOC2h
	 jjTESEkjWCCe+jQwIg254DoyngDDxqvR2d2Eew4rtx4pNlKp57tjgSL3319lt8oJHezsH
	 0onF37sXJVja5ke50FfrMV1iPWvDUM/Z5QqStKrlMpfQmK3cTFKa/mK1cSDZPxG2Ieg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VfIg7S0N;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23F2606A6B4
	for <linux-serial@vger.kernel.org>; Mon, 23 Nov 2026 11:19:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B23F2606A6B4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VfIg7S0N
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c505b2e1cb9so600586766b.2
        for <linux-serial@vger.kernel.org>; Mon, 23 Nov 2026 03:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795432744; x=1796037544; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EtVDEEY+1Q2B+PJRdO/nFO/tm1fJ8wXwnQSpYA2WKh8=;
        b=VfIg7S0NyjDFiESdcciLc42EeZNUHkJFW+yGCnS+PA5FOZnFbalkEzBPwAkLuIayTa
         eRr83rB0tVsFoar4KBae9dFGYMZVX68eI4RjOO0yq+tVzl2VhYKSok73vfwwVjZbSg6H
         d6ewwLont5tR6xs0d8c2QiD02Y4M2y5Y02DebZ/RuAAl5cc1HPD8id35r3iMfrsLug4z
         MijCMWgZ2iXwVRvzNp7hJH2BQXLmLsLnSHzmlnWqZq/sjECnDCsociBw6WQ2fZU1z1KX
         zmfHulnVN2dQYmRqS/w3NZULcuK1a7Ac/Y7lAXMV9j+jf3FA7SbDfrxoGfY3rN+z3yX2
         SM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795432744; x=1796037544;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EtVDEEY+1Q2B+PJRdO/nFO/tm1fJ8wXwnQSpYA2WKh8=;
        b=m3LKJLMMOSCMTYbvy1FuTpv5ebn2VpD6Y3VXsS+dpjJxOmn3rieaUxxZ88Ou+Dym1h
         Ix768f0NcbrxUji/fJtueoV648/8DpYhnjjzVvS5fJjsOjNS+Mjf7rtlrzYTUJcR8ehL
         YJAeeb8skeRIwL6GbFbkNes8oZKYQBpXWCRSnw5NBXNajN6N590y4eN21d0T9XA5mCkP
         RA5SZEB0qNZxEvNe6TWhLBrk3fZ8hvM9k9wSu2+eXVNSFeccACEiPLb/CFOXWjeElEVd
         WifBsilMMzySiRwdRzSMZBhTOU4OAhewnpsSlhCTFqDqjebrMCB7FETL+mPXTOOC9o3y
         dpLQ==
X-Forwarded-Encrypted: i=1; AL+hErG+WDjZ0a6wjQPbNxAUfSqojlg/sB75mkZtyH5VtEv6R4VGd4B68ZiXZObwq556GpkvFKZHW5R0XIJQujE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/EQutEReANjKpeOTgOox2K/TB3SyDY/V70OnszpKxv5doulzic
	v9WAZATydXNurOD7ksCY01Y40UVlaAdJGJp40IPgQ7S3vPwd8B+zAzQD
X-Gm-Gg: AZFdTZfiS4V9rJwx1JkQgDI/E4O7afvJs8lRxvhLryRICLhcgWf6Fndil/FHuxmyUn+
	b/yTSNEBIOyKcgIWpihWDS0BvAk3Brmt79wPAcThWvgAUtrvUpnadBrcWxV7wIX2+dgdQXTdET5
	KoUtPk7GOT9IPh22FhLqMWJC3pTwTFtRMeIgT0xb3ciIXL8m2qYMCkqJXVQcOlmD/e1E8wdePSy
	W93N9PGAfJRjRxoKsEmMP+9rguVD5OkyC1yUk0/KlP+8AKHWMCKfTEvtrRWFl7Jz6GMNP75Y4qC
	nlMv5KIMVeACDmab+TQ9FxQ6a0dgR9GaxLB2Xy3jq5qGdALQ5wSReXb6z+0tQD+v05KN6bNoVd3
	4CY0laHjjs4+jlkLCWiii4/d06h0fBaAOfnF26vClqWdAV3pqutJTyPxb0R4B0BBgmXAyHhqa94
	9KRBPLHkrbjNDQG1+K2k+K5S00dYj4pww6dS+Q8r3zMlLTxahzbIQeeQVehQADDAvN1bE7UmbTr
	l5MELGzYmG6CRS7EygQL0gVXcmxVDZB1Nu6Ef17V9izTzjEC17H4Ks6ozAD3R+0StwaIZe7OmXX
	XW99/8e3FdscEFTaBsWfCncWz+ZGdbsqx1vwn4YIVAL199W57gD/FQI/CNaXWB5X8A==
X-Received: by 2002:a17:907:948e:b0:c51:3b09:f7f8 with SMTP id a640c23a62f3a-c513b09f8eamr826376566b.25.1795432744060;
        Mon, 23 Nov 2026 03:19:04 -0800 (PST)
Received: from [10.120.183.232] ([50.7.123.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afc679bsm392442266b.63.2026.11.23.03.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 03:19:03 -0800 (PST)
From: Alexander Letuchiy <asalde.le1@gmail.com>
Date: Mon, 23 Nov 2026 14:18:35 +0300
Subject: [PATCH v3 2/7] dt-bindings: serial: mediatek,uart: Add compatible
 for MT6895
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
Message-Id: <20261123-initial-mt6895-v3-2-95c46597e63d@gmail.com>
References: <20261123-initial-mt6895-v3-0-95c46597e63d@gmail.com>
In-Reply-To: <20261123-initial-mt6895-v3-0-95c46597e63d@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sean Wang <sean.wang@mediatek.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-serial@vger.kernel.org, linux-input@vger.kernel.org, 
 phone-devel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
 Alexander Letuchiy <asalde.le1@gmail.com>
X-Mailer: b4 0.15.2

Add a compatible string for the UART of the MediaTek MT6895 (Dimensity
8000/8100) SoC. It works with the existing driver through the
mediatek,mt6577-uart fallback.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>
---
 Documentation/devicetree/bindings/serial/mediatek,uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/mediatek,uart.yaml b/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
index 5bd8a8853ae0..a3969cfdea7e 100644
--- a/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
+++ b/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
@@ -35,6 +35,7 @@ properties:
               - mediatek,mt6795-uart
               - mediatek,mt6797-uart
               - mediatek,mt6893-uart
+              - mediatek,mt6895-uart
               - mediatek,mt7622-uart
               - mediatek,mt7623-uart
               - mediatek,mt7629-uart

-- 
2.56.0

