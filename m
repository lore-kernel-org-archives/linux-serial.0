Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AB54F6477
	for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2026 12:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791893338; cv=none; b=I04rM9qBhJ+TEE9vISo5UizxOs3bgxZGpla/XxoYH2oduewQ3grKHnUcd/RmvCnofvptaQwWpdUt9dKIsn0rqfdJ6H/NjOuaZKo6ok+hkdqAQNuQTMfYh5HUVazFcq772wR2n+eFJTuAQOJu79GyBiKAs8IzaNkMwZEasCcS+88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791893338; c=relaxed/simple;
	bh=PBALWC1OrzXlrNThhw6DnFYPw/+t2E9n8UIn4ARMX2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iR33K7euCPDOr4HutHV15lUhlm6pC7bYejpPq/sfw9PGN1R8iNby56gOzzHjw69UgzLj6uFy5EqgivtOffPhoQXmoDTwWX0PHPkEYGuLM31osE/POb/pnLLpFwLs36hnwRNmx2xVmbzSC8w2B0g5BxNk/9fZvlJ7SK/I9/0uZ5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44FE31F00893;
	Tue, 13 Oct 2026 12:08:56 +0000 (UTC)
From: Greg Ungerer <gerg@linux-m68k.org>
To: linux-m68k@lists.linux-m68k.org,
	linux-serial@vger.kernel.org
Cc: Greg Ungerer <gerg@linux-m68k.org>
Subject: [PATCH 0/5] serial: mcf: add devicetree support
Date: Tue, 13 Oct 2026 22:06:58 +1000
Message-ID: <20261013120831.1046590-1-gerg@linux-m68k.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series is designed to add devicetree support to the ColdFire
serial driver (mcf.c). The m68k/ColdFire arch support is not devicetree
capable itself yet, but this is an important first step.

The first patch is a cleanup, the second is about normalizing the existing
platform device setup. The third changes the driver to always use dynamic
memory allocation for devices, the forth and fifth patches add the
devicetree support itself.

Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
---
 b/Documentation/devicetree/bindings/serial/fsl,mcf-uart.yaml |   43 ++
 b/arch/m68k/coldfire/device.c                                |  179 +++++++----
 b/arch/m68k/include/asm/mcfuart.h                            |   10 
 b/drivers/tty/serial/mcf.c                                   |    4 
 drivers/tty/serial/mcf.c                                     |   93 +++--
 5 files changed, 235 insertions(+), 94 deletions(-)

