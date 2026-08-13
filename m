Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1FF40927F;
	Thu, 13 Aug 2026 10:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786617319; cv=none; b=u84zlAiAsOlnimxp2/8Gq2Cy+mtKUfMuavsX8riBfgEtpTb+0pxbFPsRC4O7OPwHy4qc7BuFg5/h0nELN5ylVnc7iOljIRlaU7OejgyGoZhQD/sHiatHz9jDbmPXok/OOp1DLOR3qA2+TgD9cwult2NJ1XGcvzZI/DhxJi+Zpkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786617319; c=relaxed/simple;
	bh=HuHAAmFhsnViNBOyFb1R8/0wMc3TeeTHz8YWaouugC0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rLDMNtXDGVySO61aSXlPZEMSjdkAdPXsgBPazvQoXp6bS3qZY2XSIOjtZh7NVvtPYIVRkmfnesoBstV9Yz7piiba3xLAffUD6NE+x2WodL+Z5wonrVLE1PJVv6ZIxhItMrBAvKjP1r/cCQVzSn+0MrIY1y2H/6z5ex1SOj7NNKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3gje18u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3gje18u"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C70BDC19425;
	Thu, 13 Aug 2026 10:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786617318;
	bh=HuHAAmFhsnViNBOyFb1R8/0wMc3TeeTHz8YWaouugC0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=n3gje18uSVLwU7Wcw7vN91Ih+wsVaZpLZTfRnNE0l9Xj/+pPdJ1Kay6BWChkFl14P
	 Z3HArjhbmYb4pv9XLuExKwXQ+IQ8sdouF2pk4p6VHd89JOiqOFhbKaK5lKPCHQS6Qw
	 Ja76TPR432IQ1UrWeyusE8lPPyJht10qW2yQ1ll2lySVX5n9qqdS4SCEj96t2+jKd7
	 0VCF6l0TQpZGnC/JV1Y22CeS1Nm0UKm49k2maQGQVBkq2mn0UlsUeOpvpAuXBAUkdP
	 fzhYqik+qXdz/8t8jAleEZ9NCO2pBBx+kmupO/YQZtRCNx4KML0LuOu17fWXHukuBI
	 EbjLcriCdFWOg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35EBC5CFEB;
	Thu, 13 Aug 2026 10:35:18 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Subject: [PATCH v3 0/2] Ambarella CV75: 8250_dw UART
Date: Thu, 13 Aug 2026 18:35:11 +0800
Message-Id: <20260813-cv75-v3-c-v3-0-9352b3fd6026@ambarella.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN+dfWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHUUlJIzE
 vPSU3UzU4B8JSMDIzMDC0Nj3eQyc1PdMiCtm2JpkWhpnmKQZplmqARUX1CUmpZZATYrOhbCLy5
 NykpNLgEZoFRbCwCOiWNObQAAAA==
X-Change-ID: 20260813-cv75-v3-c-d98a97d0f9f1
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 devicetree@vger.kernel.org, Long Zhao <longzhao@ambarella.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786617317; l=1249;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=HuHAAmFhsnViNBOyFb1R8/0wMc3TeeTHz8YWaouugC0=;
 b=VMOAORclmZq65HmUV7KltmK8GgBks9rZmr6JcV8hU7pvSSLiyrHr2bDnCg6RXEVcX3/lm+5mJ
 HUV217J71GkDqo8lmeXGXQ2E+HWxuMoFZJyQOmXm1Yk7VhWZ4mP5PV3
X-Developer-Key: i=longzhao@ambarella.com; a=ed25519;
 pk=/xGhPTOX0/eYsyTWzyjjgAIW1Z/YD+IlnOnvcdRozow=
X-Endpoint-Received: by B4 Relay for longzhao@ambarella.com/20260730 with
 auth_id=903
X-Original-From: Long Zhao <longzhao@ambarella.com>
Reply-To: longzhao@ambarella.com

This is part C of a 3-part CV75 v3 split:

  A: bindings + RCT/CCU clocks + SoC/EVK DT + MAINTAINERS
  B: pinctrl + PL061 GPIO variant
  C: 8250_dw UART quirks  (this series)

Depends on series A:
https://lore.kernel.org/r/20260813-cv75-v3-a-v3-0-cfdd20b1b4dd@ambarella.com

Depends on series B:
https://lore.kernel.org/r/20260813-cv75-v3-b-v3-0-1d82e18da09b@ambarella.com

Link to v2:
https://lore.kernel.org/r/20260806-longzhao-upstream-cv75-v2-v2-0-6b09707c5fe9@ambarella.com

Summary:
- document ambarella,cv75-uart on snps,dw-apb-uart
- Ambarella quirks in 8250_dw

Changes since v2 (C scope):
- drop custom Ambarella UART driver; reuse 8250_dw (Linus)

Verified on CV75 with A+B+C.

Signed-off-by: Long Zhao <longzhao@ambarella.com>

---
Long Zhao (2):
      dt-bindings: serial: snps-dw-apb-uart: add ambarella,cv75-uart
      serial: 8250_dw: add Ambarella CV75 quirks

 .../bindings/serial/snps-dw-apb-uart.yaml          |  1 +
 drivers/tty/serial/8250/8250_dw.c                  | 30 ++++++++++++++++++++++
 2 files changed, 31 insertions(+)
---
base-commit: 378c935cabe003ef440c1c79302a1f8ed7913778
change-id: 20260813-cv75-v3-c-d98a97d0f9f1

Best regards,
--  
Long Zhao <longzhao@ambarella.com>


