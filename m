Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E3A4CCDF7;
	Fri,  9 Oct 2026 11:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791543604; cv=none; b=vAt39wyI9N97AoZKw/JF6LIwQ8OiMzbmJN3qZeFgN5urdLQ9S+yxRltGMOcgboWqkwns9T/zlgMe/odjs6I79WIw69KOdH1vgmdHKyXf9DupiTlBdGm9YaNNwhXFMpRAMEKwc6aiEIvH/TUAyimr1Ysf3BLVNEk9JasyUBQyn0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791543604; c=relaxed/simple;
	bh=neVZVTGq666oWAg78l5pu/vXnnOetgC6TABJJdn6H6U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=c7hSL2bZDRh9YxIp01biTt8d4ILbOPLdeILprLoww+omI0SNWwJr2EUk6nRTUgs1uYBq3JmYgrNJ086U1h/KnN00FEiguKZC4UrlfmmtuC8rEdbQnf4cbLzC3HP/QtS612pVzBeK4ammzHKCUEqaX4RzKpavfZi55vZFekOoJIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uogObXJi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uogObXJi"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D222C2BCF4;
	Fri,  9 Oct 2026 11:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791543603;
	bh=neVZVTGq666oWAg78l5pu/vXnnOetgC6TABJJdn6H6U=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=uogObXJiR8xRxnnlKQ6Rgnq4vwp5qA1SQKNHoATsEarbDUDBKR4EgjerVbW5YOUOI
	 y4v4GdWRAKYmescq0TLfsURzbFt45fY+rVds6nDshBETklPYi7vxyAFmfD6/7WCGp9
	 EqUpssRYELWaEUSWyoJZgUYzW3attmD4W9zg+xalw80OLmfn/nCiK5z3yGE3A2/rod
	 rxuHkVYmwz9ggytdqnqUbhg5/FJvCR5zWv/1712qI5e/Jywb58t7xYojXy+ZSDelPc
	 +VyxTsqn504N+tObx4VMUbS8FCSddQGHqNVaTvlv2ZhvXOriQ/9X2SZPRZ6vWhNPUw
	 /gYvu9cgm7ZDA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296F8CA6019;
	Fri,  9 Oct 2026 11:00:03 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Subject: [PATCH 0/2] serial: add Ambarella CV75 8250_dw quirks
Date: Fri, 09 Oct 2026 18:59:57 +0800
Message-Id: <20261009-cv75-uart-v1-0-38c098efaa99@ambarella.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAC3JyGoC/yXMQQqAIBBA0avErBPUzKirRAuzqaZFhWYE4d2zW
 j74/Bs8OkIPTXaDw5M8bWuCyDOws1knZDQkg+RSC84rZs+qZMG4gyllNJd1r20hIPW7w5Gu79V
 2v33oF7THO4AYH1MDUtVtAAAA
X-Change-ID: 20261007-cv75-uart-44a6029b6c31
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Cc: Linus Walleij <linusw@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 Long Zhao <longzhao@ambarella.com>, Long Zhao <zl020895@163.com>, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791543601; l=1588;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=neVZVTGq666oWAg78l5pu/vXnnOetgC6TABJJdn6H6U=;
 b=UDsqMyCeNg+ceA9+UGB3+s8T/RKumgGDR1bj2HJxvAUybi0k6HA0umzSTH8mMAFDByMHfPa4s
 y5Nd+VU1TdeCOOSBzhqSo2BYIg4XLI/HBf+5s69cAhW8AyfTIukmAvB
X-Developer-Key: i=longzhao@ambarella.com; a=ed25519;
 pk=/xGhPTOX0/eYsyTWzyjjgAIW1Z/YD+IlnOnvcdRozow=
X-Endpoint-Received: by B4 Relay for longzhao@ambarella.com/20260730 with
 auth_id=903
X-Original-From: Long Zhao <longzhao@ambarella.com>
Reply-To: longzhao@ambarella.com

Split from the combined CV75 bring-up series. The 8250_dw driver does
not depend on ARCH_AMBARELLA. The binding uses the ambarella vendor
prefix, which is added by the SoC series and is not in mainline yet;
dt_binding_check needs that prefix.

These patches match the UART patches in the combined v9.

Link: https://patch.msgid.link/20261001-cv75-v5-v9-0-486cc289a4b8@ambarella.com

To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
To: linux-serial@vger.kernel.org
Cc: Linus Walleij <linusw@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: Long Zhao <longzhao@ambarella.com>
Cc: Long Zhao <zl020895@163.com>
Cc: linux-kernel@vger.kernel.org

Assisted-by: LLM
Signed-off-by: Long Zhao <longzhao@ambarella.com>
---
Long Zhao (2):
      dt-bindings: serial: snps-dw-apb-uart: add ambarella,cv75-uart
      serial: 8250_dw: add Ambarella CV75 quirks

 .../bindings/serial/snps-dw-apb-uart.yaml          |  1 +
 drivers/tty/serial/8250/8250_dw.c                  | 32 ++++++++++++++++++++++
 2 files changed, 33 insertions(+)
---
base-commit: 34cf6dafc47441dfb6b356a095b89c3585a93714
change-id: 20261007-cv75-uart-44a6029b6c31

Best regards,
--  
Long Zhao <longzhao@ambarella.com>


