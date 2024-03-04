Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC811B814;
	Mon,  4 Mar 2024 10:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709549992; cv=none; b=NJPGPraf15ACko0ap9gMULJrD4ZdyuCQdaxhuLCsW1erbpbsjJfwR9SPFVQlyhdtcSE5nc/57m4N0NuTPxvbTW8vaWYBq/2uC91ZgQSXY/oEOX5Yf/134X4AhqAuilia52N1NRLUpzRfuHhYClB0cHe1ED/BdUbWRZA4CPsDWO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709549992; c=relaxed/simple;
	bh=leeC2E/cW3eqj2EuioS6vbusXrw4fa8TOx7FCQEIBWw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fNNJOu0qpYZ+c/iQvT8we/ttEctgiUB8nE79Az57CXGAJB/uROKfaqmSchz8f8fWGyRoA6nuFDnqOuY5HTw0gcb6zjBkhuqdsZx1KNOVMXonHRQKya2/VAkLi87kM3k81F5aSfItTQJkPC6RCXTtI5Ov7RnE9UgNfu9hzVGO0eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sz6hKABR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U/BaWreY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sz6hKABR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U/BaWreY"
Date: Mon, 4 Mar 2024 11:59:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709549988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=bJAczLXjA5qnADN9h7hX105sDv8kQ1JSUZwi6qoU15o=;
	b=sz6hKABRt57mIiWwyViSNtb8++S2DkPP/S1D+knADJCErHSjaVSGxZYU253cW3b/LvrI/8
	gQoFoGfopUzhXJ5yniLzpeVgviQKy0ZjaYrcc3t5Cy3JHntXI3HxEDGS+UIU++0PurRsIi
	plRr485SeQlhuUO1zEsJmDDp7tQV8LKhePf6WAtmM5x4Qud7OXsesZFyarxs2m9edIPo2V
	QvBwlpXA+i5KhTXulM755DftHZ9d0WTAdq/W6r739E6uVwc3QDJODxnFGQ7ZsPEdIxe8eZ
	slOB1wyf1MThGpQyWUsMIV/Dv+cJ6hbDL0AsSpSfdKKWRWUCSet0aNXikzzKkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709549988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=bJAczLXjA5qnADN9h7hX105sDv8kQ1JSUZwi6qoU15o=;
	b=U/BaWreY8ysvTentpMECQbXLEHOGcbk3Ct8IievDgxYgw3YQyD7dEjEVLXQaW4Xr5gi25p
	Rz3a1CRqwG7EIWBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-riscv@lists.infradead.org
Cc: Samuel Holland <samuel.holland@sifive.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC] Inconsistent sifive,fu540-c000-uart binding.
Message-ID: <20240304105947.SJcVAdr1@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

| $ git grep fu540-c000-uart
| Documentation/devicetree/bindings/serial/sifive-serial.yaml:          - sifive,fu540-c000-uart
| Documentation/devicetree/bindings/serial/sifive-serial.yaml:        compatible = "sifive,fu540-c000-uart", "sifive,uart0";
| Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.txt:"sifive,fu540-c000-uart".  This way, if SoC-specific
| Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.txt:    compatible = "sifive,fu540-c000-uart", "sifive,uart0";
| arch/riscv/boot/dts/sifive/fu540-c000.dtsi:                     compatible = "sifive,fu540-c000-uart", "sifive,uart0";
| arch/riscv/boot/dts/sifive/fu540-c000.dtsi:                     compatible = "sifive,fu540-c000-uart", "sifive,uart0";
| drivers/tty/serial/sifive.c:OF_EARLYCON_DECLARE(sifive, "sifive,fu540-c000-uart0",
| drivers/tty/serial/sifive.c:    { .compatible = "sifive,fu540-c000-uart0" },

note that the driver has a trailing 0 in the binding while the yaml
description and the DT part does not.
The 'sifive,uart' has a trailing 0 where the 0 denotes the version UART
IP.

Was this also intended for the fu540-c000-uart binding? Should the 0 be
added everywhere or removed from the driver?

Sebastian
