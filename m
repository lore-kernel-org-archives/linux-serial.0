Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647D020E6F7;
	Mon,  3 Feb 2025 20:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738615146; cv=none; b=TJLncsK3XR9SGPdk8u3I1ccHA87LW+XBatt6Fu+bpsuv1IhA/wX2v/pkQG1FajJMRBCR7cMvo9RkEoAHOCFvhB9/NgFjCGrvIvdFvg80gsV+FIP/rZcnZHZ3fS50G6ipTtnxb6ILQTrbpAnHO/cMEjxLjaKHno3zBaLRFcy1xbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738615146; c=relaxed/simple;
	bh=xwtOKTUBcQC4jWTBtIrOtPINitVO/oGKezfgJlBjumg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=btumCfyVZtVWjiwVNhRXI6g8bjTSCpIrF2E/aOH6KCx25RVmkciCNet/R5ITz/AAOLzb9kmbE4+/KGnaElENQwjE8ya3J1kSJZHbkrjrfLE1FEDGfsW+8tkeaZy4bzQuN4D/G13tEXzxpKtu2Zyhas77UHJ1LdxHnN2FKF661JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=WwX+eU7L; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="WwX+eU7L"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id D9D5625A84;
	Mon,  3 Feb 2025 21:39:03 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nnfpxlxpcAtI; Mon,  3 Feb 2025 21:39:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1738615142; bh=xwtOKTUBcQC4jWTBtIrOtPINitVO/oGKezfgJlBjumg=;
	h=From:Subject:Date:To:Cc;
	b=WwX+eU7LzjIdxW8NZm1GvF/p6BdvTzUTYlFmdaqWIPOaqSWdt8TAOU0wi35fi30Z4
	 CjNEnCbcuTPcm2Vb/PGdtZ2uaNAhIdOwgyyUbeZnNhPuEQQtl2OjEYcbWwQjqPuoL6
	 n5Zjts93nSWE4C7OiUztnWW5NyrMGTY6YpmZK4P5bCy4yJunnI9qXIU+rALUiS3TvX
	 z9eQ+GbaWKnG2+XZieoCHfPeKMvpqcE7oZxiRArBr4fnNfvT/LDay5fjLU+0oDOE/8
	 Lq1o414YESIq0gqjO0n4LgC5S1qkinCV6G3ZNMxFBj4wGAJXap+u3WLL/CmJXUlHcV
	 SmSg9zIN7nsLg==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: [PATCH 0/2] Introduce UART support for Exynos7870 SoC
Date: Tue, 04 Feb 2025 02:08:44 +0530
Message-Id: <20250204-exynos7870-uart-v1-0-06be6aa96284@disroot.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFQpoWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIwNj3dSKyrz8YnMLcwPd0sSiEl0zozQzk+TURCMTC0sloK6CotS0zAq
 widGxtbUAR5S8w2EAAAA=
X-Change-ID: 20250203-exynos7870-uart-62f64cea2489
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Sergey Lisov <sleirsgoevy@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738615135; l=722;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=xwtOKTUBcQC4jWTBtIrOtPINitVO/oGKezfgJlBjumg=;
 b=vzu/LdC3pxEnkiUAtVWL36omc+KNCQgDuSraq8ILeDY5lO4KG3w/LvzL5zDzq7tSal5tH20+u
 899Cg6H81zfAZUzdRBg0VS0hzJD7Svh5e19SYGRaaGKjHmF5ZWB9L16
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=

Add support for Exynos7870 UART. FIFO size is expected to be present in
DT.

This patch series is a part of Exynos7870 upstreaming.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
Kaustabh Chakraborty (2):
      dt-bindings: serial: samsung: add exynos7870-uart compatible
      tty: serial: samsung: add support for exynos7870

 Documentation/devicetree/bindings/serial/samsung_uart.yaml |  2 ++
 drivers/tty/serial/samsung_tty.c                           | 13 +++++++++++++
 2 files changed, 15 insertions(+)
---
base-commit: df4b2bbff898227db0c14264ac7edd634e79f755
change-id: 20250203-exynos7870-uart-62f64cea2489

Best regards,
-- 
Kaustabh Chakraborty <kauschluss@disroot.org>

