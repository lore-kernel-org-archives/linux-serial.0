Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033D83E1209
	for <linux-serial@vger.kernel.org>; Thu,  9 Jul 2026 20:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783630629; cv=none; b=MrEfyEspLnW819JecUGviZyggk1do0hnBoU1bn2FY0mZOZDy+6T4zuuK+YHZLwB6FFNjC4T4LNkH4cp0eI2OvNO82gwD8DXlzT0zMLbl+4DrkWSKVPMd831NpnK1LlFnxrEyBraiceSh1aSEcPGJk+7MNGu3cybwXgFm9KMZBrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783630629; c=relaxed/simple;
	bh=MkIALTiwYNRzBP6xz9FDRfRK9pJHmkmoTpSIFdiIeUg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JpweWYYPvyT7EisAK1Itb1ju4QKcOKdKBxWB0MK7Mh0lOSTmr7+atXveDgkiiav4d2T5vtwGmGxggWuC7jabzk3vO+aHFhSFi3/lCHXO8c77QKCXQAaXEuH/xXOIw0Cwqbfhezn9AstLHb6dq8Rvs+aHYSEnT9nhLdsXtvgNN5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nuAzCPNF; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nuAzCPNF"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so286591f8f.1
        for <linux-serial@vger.kernel.org>; Thu, 09 Jul 2026 13:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783630626; x=1784235426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BFkdVnI4ghSRjKxxdbmuMyME2rVqkc2w5YQnI0fqGUQ=;
        b=nuAzCPNFVS1vY7KkRiP63G1S0GASLtDeDKeokv03g7pBAeamNElRlTsBtjMBxOclMj
         Wil+WkxXh0r+XdoR5ZagItKTwboU6d/aOBxcKY76dAbhH7KAGmjSuP7uK7mZfNRqzJKh
         hqEo2LU+P/UcUt8b2+r0unf5L8qg/7QbhWMsQgdjx8l3TxvD57rlQ0vaTzKoWIPiHSHy
         q9xW1xdGGrLJUCe9Q/XG3X88wFG/uRHY7H9jAuQnpvIhXkW86QxRy7SNI/y6X9RkMarW
         y3MateVXOM6KtiWu7cBhNHpMKgC+RwcSbLbea6wu/hs08VwBHaZDnd7cMBsf6MIsmGT4
         +nHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783630626; x=1784235426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=BFkdVnI4ghSRjKxxdbmuMyME2rVqkc2w5YQnI0fqGUQ=;
        b=Sdax4ZcQSmOQtXn/FXH8d0WbTvpK1fq+m80O3LADGSJjbtuI05Y4XSzVLyWyMiQgds
         m+oKVaALltLmzSTGojS7ShPeq/PEpVpDBivpsr2abNoP7p/XTrmjISiH1GmPk+L+fSSC
         ZYstS/WNHzQDUpGxuIXVt6WX3kjSOxczli7wPVmjPxafa9hcQnUtXAfnE2Hmtn0sRkbM
         0JNFx/vX2dhDrppdclwQVKB9PwN40PNTdCKaaLcp1ri3CE89XYw+DdNVcvjrIHoTYS7D
         TIQ14xThIaU9ORuaEWnVwD8KsKjd/xJIfgWCrczZJ61BCjCyChCGfNyIXC7+PebS+lPv
         +c5A==
X-Forwarded-Encrypted: i=1; AHgh+RoXCaWSMg76W2B3NpU2JN37O2UUV4RaXACtQgWPmxPsrx1noVgLy1iVaHses/qFRlAw/u51m8HLpjREr2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAA8q86/kVdEtEuGcWCEU/P3qjFZQrmc44zo7UV9RL0bzJJMlr
	VtHK6nAaCCUN/umRmOlqA4rQLBI3XTExMQrdncoLvoNFNl1+eNp8CdnC
X-Gm-Gg: AfdE7clbJUDbv1HvVSg1vGaG5s8mmuGDLl/1ybFp4tzmvhECITM6KnT+k7jpYIXmt9l
	LV7EmN22cJIWlDIC+IoI/LUehFVrarfE4o0I9w1gB30CL8gqHo+V7mcQHmzL/KF7Sa2GlmG3krg
	lycipkPYpY3V2WnrIDIC9ZkSm+ubyWLe3wsZX+V0NsdSZAh1+1bUWOJ2IHF7TtmgA3pyA9ukwe6
	nLgWLkdjVmLkTVZ3HWhd3QLstqcbhTiqFSQ7/GM0DMcNqw3rKLDvT9I1lRsgQeVwlIMR6IpA4se
	WyDyLsowQvLie+eWTy2oqulLIbSFAyeMyo9pDqFgLyPyARZR7VwHpP/+QIt0IgaX66cCCTZqQjt
	uA828B3S/43/SqpCS9CdVr7UBzGOqFlBKj/z8J+gAD6VoNGpZcMqs3hLEsnHiWva3K1BD0FU5vC
	c0enzSBkb0hgOnjH5SUntGPAgDjyuYgOxeXCJCIZ2m+TK793BEu0qyBgR6vF4Q0zQhE0JgOHXVM
	yxoXRBb
X-Received: by 2002:a05:6000:250d:b0:475:f100:35f9 with SMTP id ffacd0b85a97d-47df0778520mr9168072f8f.54.1783630626246;
        Thu, 09 Jul 2026 13:57:06 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-95-248-227-210.retail.telecomitalia.it. [95.248.227.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47a9de1d910sm52894965f8f.6.2026.07.09.13.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 13:57:05 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	John Ogness <john.ogness@linutronix.de>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Gerhard Engleder <eg@keba.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Rong Zhang <rongrong@oss.cipunited.com>,
	Lukas Wunner <lukas@wunner.de>,
	Lubomir Rintel <lkundrak@v3.sk>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: serial: 8250: Add Airoha compatibles
Date: Thu,  9 Jul 2026 22:56:49 +0200
Message-ID: <20260709205656.319531-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260709205656.319531-1-ansuelsmth@gmail.com>
References: <20260709205656.319531-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Larsson <benjamin.larsson@genexis.eu>

The Airoha SoC family have a mostly 16550-compatible UART
and High-Speed UART hardware with the exception of custom
baud rate settings register.

Signed-off-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 Documentation/devicetree/bindings/serial/8250.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index bb7b9c87a807..b6f7e093d8d7 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -110,6 +110,11 @@ properties:
       - const: mrvl,pxa-uart
       - const: nuvoton,wpcm450-uart
       - const: nuvoton,npcm750-uart
+      - const: airoha,en7523-uart
+      - items:
+          - const: airoha,an7581-uart
+          - const: airoha,en7523-uart
+      - const: airoha,an7581-hsuart
       - const: nvidia,tegra20-uart
       - const: nxp,lpc3220-uart
       - items:
-- 
2.53.0

