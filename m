Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA41358D37;
	Mon, 21 Sep 2026 04:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789964612; cv=none; b=pTByUgzjIefvzyidG0mfnqWZqTuhq/kGOdBXFhQIhFvzaei2VAd5/UVKdpaVrlsiE5PEPglw39CIDaQP7h+bWRFk8AWX1CUh2MH0Az2pg0GeOe7RxnR/rIo5ku4ldR864jFny7OkIhEiDWapKNaBEW5gGu4mFB1bxn8A9ipU0Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789964612; c=relaxed/simple;
	bh=vqJg9MCrHhTQ3dSYeAuOSHwl+5KNi8MVa3c/QFLqYsE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XvDvp0eTPkGNKhR1vkOUKMZqtCzyex4NX0JKcl06BZGp83ihQSN5p2B8xx8TnXzHC4LckiTRdub+IZdXa8A5JW7Y0kWM5KxtNZdugxN6tM1n4q5awNsRRRP/GJPGtzel3pzZysuxYL2XRipzhPduSBksjUx0H7j+BOMAHkic6O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEnVPr+p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEnVPr+p"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48300C2BCB3;
	Mon, 21 Sep 2026 04:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789964612;
	bh=vqJg9MCrHhTQ3dSYeAuOSHwl+5KNi8MVa3c/QFLqYsE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=AEnVPr+pRJ3tdpUjiYAC9Y7RpjsUmjo06MfJptFDBTqP0Ha48e4QJDM80uitDGof2
	 lDKQM8AvbjQmWqQbhg/zppTP+raqhmGJ45DzbCNw3+q3kgFmMKLkuO9Ne3sHEFk5is
	 2mRXNKbn55/K7yJ02GjSEo7NrLpRxUNOnIOnPSe7MjPMicbDRuyy+W4cse2w91KOnI
	 /8FvIeG4Ek+4Uiqa7Cl0KxzNVImbCqsDY93OoFGx8RjbVSntjZyOieLW4UrdWNEtDZ
	 +Dpv1VcJBKa4RX2alHCIBl8dlTuzeCv79jIQ0tcTJfa+AP8JSS2M1PcFAuyqqe8kp/
	 f0cMOQgz4oa9A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324C8C982F1;
	Mon, 21 Sep 2026 04:23:32 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Date: Mon, 21 Sep 2026 12:23:25 +0800
Subject: [PATCH v8 06/18] dt-bindings: serial: snps-dw-apb-uart: add
 ambarella,cv75-uart
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-cv75-v5-v8-6-282ff5d98dda@ambarella.com>
References: <20260921-cv75-v5-v8-0-282ff5d98dda@ambarella.com>
In-Reply-To: <20260921-cv75-v5-v8-0-282ff5d98dda@ambarella.com>
To: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, soc@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
Cc: Long Zhao <longzhao@ambarella.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Long Zhao <zl020895@163.com>, Lee Jones <lee@kernel.org>, 
 mfd@lists.linux.dev, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789964608; l=1072;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=aI42/QWFrT0q/wEmjSA5wdZvhIPXU9faQz3G+ySJ344=;
 b=8KQp6zk0TUfhdEk2VE/BCaiOf+RzQeeu8ZyrQ1XCsEjYoqCSww3zBoiyHWZ/H2VFTOFDotiq0
 G6g7AsHZEONDt68uTJFXn0HVCjrcg9Wv+H7gbtBaTW2/1BSQi6RdQyQ
X-Developer-Key: i=longzhao@ambarella.com; a=ed25519;
 pk=/xGhPTOX0/eYsyTWzyjjgAIW1Z/YD+IlnOnvcdRozow=
X-Endpoint-Received: by B4 Relay for longzhao@ambarella.com/20260730 with
 auth_id=903
X-Original-From: Long Zhao <longzhao@ambarella.com>
Reply-To: longzhao@ambarella.com

From: Long Zhao <longzhao@ambarella.com>

Add the Ambarella CV75 compatible string to the Synopsys DW APB UART
binding. The block is Ambarella IP with a DW-like register map, so it
is described as a DW APB UART variant.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Long Zhao <longzhao@ambarella.com>
---
 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index 49f51b002879..cec5c679f1a9 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -51,6 +51,7 @@ properties:
           - const: renesas,rzn1-uart
       - items:
           - enum:
+              - ambarella,cv75-uart
               - anlogic,dr1v90-uart
               - brcm,bcm11351-dw-apb-uart
               - brcm,bcm21664-dw-apb-uart

-- 
2.34.1


