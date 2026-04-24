Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF6818DB35;
	Fri, 24 Apr 2026 05:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777009234; cv=none; b=JPAzwKTVz1A5LggS5l5Beift86BQCsSzH1ms1j0xTQCZu4Ser9hP/Dzmt7aGXyF17d3O6vmb0+SgXMwREKEGi7ReoI6Yw0pdw5u3sVmzVNcnJw8Ju94Yx1DqJlt8gnvhA1ZsULv/OGiR3rcLrqZ3TyppKIcL7iOthTMgXdKiqSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777009234; c=relaxed/simple;
	bh=HTHcMLZd+/gml+w6WBkPnmnH8R279yZcH3zi2ysECik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HXbPrSqcAaM2fUicjDkzgwpaIFxTweILBJMb49lZVeA4gXT3tDOemIqCb5UJDmM1g9fzSkKhIZFGFF+AE7kGRbWgvVvYolnx6PE/suk0E3XjB7ptrtaQ3QXiyLsf/+XaKRt2g4MRpaHFib4xH4nvkIWKpwNWcE17GbrfgT0qtw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=pass smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=Dwjm1rh9; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="Dwjm1rh9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=8wrob9Daxto0frjCO9kTiDmebSamY8F
	0wvOiZo2Wv/A=; b=Dwjm1rh9Y72sdhjNTkxyPk21cMoqrvQHTu+KOH6UzPVq5Vl
	dpiLDzyRgiDkXQqv1AkJxPbkZXQGnf+xEDCbPVOGfcj86nRkjNiFhoERAy4XXTho
	hetmlqK8sj183qHGJszug/yiWJWF4nn6MsIP/V2xY21xi7UboH5tjRyM5hqQ=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwAnYUJlAutpm8gCAA--.1607S4;
	Fri, 24 Apr 2026 13:41:01 +0800 (CST)
From: Jia Wang <wangjia@ultrarisc.com>
Date: Fri, 24 Apr 2026 13:39:29 +0800
Subject: [PATCH v4 2/4] serial: 8250_dw: build Renesas RZN1 CPR value from
 DW_UART_CPR_* definitions
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-ultrarisc-serial-v4-2-1765a0b4c4a0@ultrarisc.com>
References: <20260424-ultrarisc-serial-v4-0-1765a0b4c4a0@ultrarisc.com>
In-Reply-To: <20260424-ultrarisc-serial-v4-0-1765a0b4c4a0@ultrarisc.com>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 Jia Wang <wangjia@ultrarisc.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777009209; l=1168;
 i=wangjia@ultrarisc.com; s=20260309; h=from:subject:message-id;
 bh=HTHcMLZd+/gml+w6WBkPnmnH8R279yZcH3zi2ysECik=;
 b=QGIhKX7pZzdyO9ol3x1IAjT1O0fwef6z/6u5w9ldLj2mK4gRr9hxSu3IOK57oVxxpHRaq6iUw
 WcjaEeJuCQNC+5hFrzkCmYoflsBpUInmdef4bHnlFW2rdpTFE+muYoJ
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=XvYkrelqJIIzobY7j+nIg8rsfv5kzaOzuc1UPhd087U=
X-CM-TRANSID:AQAAfwAnYUJlAutpm8gCAA--.1607S4
X-Coremail-Antispam: 1UD129KBjvdXoWrtFWDArW3XrW5GryDAw43ZFb_yoWkZFc_Ga
	ykWwn3Jr9Fk39aqw4kurs3uayFkwn0qFs7Z3W0qa4qy347Aw4Du3sxZF1DG3WDZrZ8Grn7
	Ar12qr9ayr13JjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUUUUUUU
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQAHEWnq6L8ACQADsJ

Replace the magic CPR value for Renesas RZ/N1 with a composition using
DW_UART_CPR_* bit/field definitions and FIELD_PREP_CONST().

Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
---
 drivers/tty/serial/8250/8250_dw.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 467755bf0092..d3c2c9c84d9f 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -937,7 +937,15 @@ static const struct dw8250_platform_data dw8250_armada_38x_data = {
 
 static const struct dw8250_platform_data dw8250_renesas_rzn1_data = {
 	.usr_reg = DW_UART_USR,
-	.cpr_value = 0x00012f32,
+	.cpr_value = FIELD_PREP_CONST(DW_UART_CPR_ABP_DATA_WIDTH, 2) |
+		     DW_UART_CPR_AFCE_MODE |
+		     DW_UART_CPR_THRE_MODE |
+		     DW_UART_CPR_ADDITIONAL_FEATURES |
+		     DW_UART_CPR_FIFO_ACCESS |
+		     DW_UART_CPR_FIFO_STAT |
+		     DW_UART_CPR_SHADOW |
+		     DW_UART_CPR_DMA_EXTRA |
+		     FIELD_PREP_CONST(DW_UART_CPR_FIFO_MODE, 0x01),
 	.quirks = DW_UART_QUIRK_CPR_VALUE | DW_UART_QUIRK_IS_DMA_FC,
 };
 

-- 
2.34.1

