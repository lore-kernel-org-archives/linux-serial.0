Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8715521FF2A;
	Sat, 10 Jan 2026 02:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768013212; cv=none; b=HAPC6Rf5lIdt0D+snUT4FaLfIqB844tNrv7qLDss+3iqNQA8pWwfjA1Ho3QYbvmgNISkw9+gaPWZDlYE570pPqWm/j2+5AynrJBPJihCrhP6lIZ4ZQSZaVoHCs7SD1sjwxkaSfUq1dzyprc+WyR+c1elF27y4RxVAoJQzSr36rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768013212; c=relaxed/simple;
	bh=7aOrMixf22cms3+N44ctElI0QO2xH8FvGfQxgKQtJs8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YthCLHuNpPG1ymZCyfpvFLaKDsjodQby0vNfdm6SheYwvA0CSuo9zVrobp/3d7fa0Yhb6koAxQPhI0/2mqUlVHC9awWWeIYFck6x+z6HJpko2mnkUiiina5akO49hC0atVUBbhYzae+kOYJNhC3fLmg+5cMo38TqQkAtotwXrW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=mfb1KUYV; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=SJzLhJnO; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="mfb1KUYV";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="SJzLhJnO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1768013210; bh=7aOrMixf22cms3+N44ctElI0QO2xH8FvGfQxgKQtJs8=;
	h=From:To:Cc:Subject:Date:From;
	b=mfb1KUYVCANP5spC8TQ2XVep9wmwAmXx7gtsxxRW4DJSfwpo3nn4SYNTTqiG2D5pu
	 3GZpCbld5oEiPMhQLdqzEAv067iQxYQRkaSzX5t9RNL2K1kbSaeSUUsMrF5tmXaqj4
	 0Bv61rwlucf5SSi96v6ZrZFmZGsQ434IPXhVOUTb6dJwdmNjaCloS16AA/o375S1YK
	 VVWg7bVZ2KM9ImnWMdgTq61LrUqRrqRnER8xb0U4ocHddpgz+nh8RudIEh1tIBL7dM
	 0AL3LU5y+YVzrF2/DXh5gpe/PiKXRKBF1+DQaisRZbrwqfE/qBC02qcxmsRXqAVf1j
	 3RwzUITVxggyA==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id 06EFD3EB7E6;
	Sat, 10 Jan 2026 02:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1768013209; bh=7aOrMixf22cms3+N44ctElI0QO2xH8FvGfQxgKQtJs8=;
	h=From:To:Cc:Subject:Date:From;
	b=SJzLhJnO0zSUsVgEtbT1n0D/KBaWnHLCAL0bOKLIt9p4jCj7P/HZ6aJ2tI6nO0W42
	 VWARIMhcbdAxKnyL/lx7zAlst7VEaoJashIOLqbd31o077//6GxfIX8LCqHfDoIxe4
	 8NO96Ccu1Nklf4PxOG+Bv54Wn600VHhhBbVtV5/6xgd2cw8p3AZgfBMoc8Pz29kvy2
	 LgRauXAvbCPxiIhQ0yhEgc0SCEjaSLeeqL+eQtd/CnRxnVla1o5/IzdJr54+FydD4B
	 WYcuBng8Vm1E0ze8PZvryC5/GYdfOp4vb1Lh1qmNKtGNZQ0Erq4GiLM/lrf8tAqsk/
	 obA8Fvv7dyLug==
Received: from mail.mleia.com (91-159-24-186.elisa-laajakaista.fi [91.159.24.186])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mleia.com (Postfix) with ESMTPSA id 498B03EB2D5;
	Sat, 10 Jan 2026 02:46:49 +0000 (UTC)
From: Vladimir Zapolskiy <vz@mleia.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Lubomir Rintel <lkundrak@v3.sk>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	devicetree@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2] arm: dts: lpc32xx: Specify compatibility of platform UARTs with 16550A
Date: Sat, 10 Jan 2026 04:46:45 +0200
Message-ID: <20260110024647.3389345-1-vz@mleia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20260110_024650_047016_9F1A678B 
X-CRM114-Status: UNSURE (   7.96  )
X-CRM114-Notice: Please train this message. 

NXP LPC32xx SoC has 4 16550A compatible UARTs with 64 byte TX and RX FIFO
sizes, and the platform UART hardware is well supported as a standard
16550A UART.

Vladimir Zapolskiy (2):
  dt-bindings: serial: 8250: Explicitly make LPC32xx UARTs compatible with 16550A
  arm: dts: lpc32xx: Add ns16550a compatible value to UART device tree nodes

 Documentation/devicetree/bindings/serial/8250.yaml | 2 +-
 arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi             | 9 ++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

-- 
2.43.0

