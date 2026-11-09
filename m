Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794262011;
	b=p0d49s0X5+hftTAxmLggoPw0GQ5Q21ZNbltU8b/efRXgzYOPElLCZRRIrL0IM1/vnrJW
	 LtcWZ3yfCCUsSocnNeiNC3vKmL63JtnaoUDOPEhjXWvsaybinas/zL3MWHixlASdwHlf8
	 C7rR7UxJe7Rh+YfvCLb4vP1eCNFBGbRta7RC6oiumr3n7egF/vKWQh7n4A/HYSO5g5x3W
	 RWjyIOyZXkjmILOeP8EVDyc2GNroo6Kr+0yR9mOrUc62ysMEVF7JE0OGH5oTFTZTgpEOV
	 8P0dlaihQnoY27sB+31nzOoTEEIcDJuOe1T3GOd8O0k+7Y0Fk//0cz7TTgSmjpH1gzQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794262011;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=julOl1oFvNKWuVZCMIKiVAjKH2yRZZMh0SHPffPbthU=;
	b=SVQ2piybww8O5p5Z8KQsLHbF9WaGvgith8mKjesK7O42iNqtkirkrReeEZFVBWNroI9B
	 3m0dDU6hnkEgHRED3WhQEgwX+upSq8pi65RLpBrPHykPY/xVKa+jd3nrN0+dBDgx9B+d1
	 uB8rlN+PIxqIGLqyWMRWoWOHn3WI/TnQt5mFdCbs/w+ayFK2uH5UTsVOJ40+jWiBSXx/w
	 yUnWWwfJGjFr/BJ1xqtKgohlPc1iA01AXUdKWXF83LOAC9tgebSkmSZp3wW/JdFZgeLSJ
	 K/Gy8Cji7zkAPIgVQT1hR67At/vMld4EQ8b9v3G7c/GMFLExwVez7fz1g34GZoilhEQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GRnFaBJ0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4779B606A330;
	Mon,  9 Nov 2026 22:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GRnFaBJ0
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794262010;
	b=DgRsQNes+OyboIBgBnGES2c/qRHEUGWQ3LCoQ5AlkfPZIN7a0rod9Ok2hI0giVgki2bg
	 xFJh+wGWJSkzKfBTSE/HuFtI9/S0Rd7KM9EnzBXhyx0INfTbfh7C2MyGVMFcHI35+FSQQ
	 MKHBkS/+yl+HRztHEw/TKM4UO2hTPVVw3LAeHtOI85hIuaxh9G2at0cLepaw3I/Urelgf
	 FfYbz9YcPGpNWWoxfZ2FeHXpYjw1AkaIDB06ZNzXOey9WW3mcTifiMJKeglNCmoS0xXzY
	 HJlI68VD1BRiVm0ty+ups99tf1gUvziN3liKqCzBHEREEhP0KpPm2KSYPtTMjGK7Pdw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794262010;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=julOl1oFvNKWuVZCMIKiVAjKH2yRZZMh0SHPffPbthU=;
	b=w/M9MB2GWqAEiia5dLW1PgCs7CpnWoOVBblCisTF6Oq8lqfcaxfXVz0pBkMXUveoN+aD
	 p7dHPUV9lKH0h0hOQnaqo3eDHV9+6JV3vPSnlSNW36/MJZTV0RCDDARq3RR0W8oE0Glc/
	 7Fi/YiOClqFbqTSRz1QfyjhCj8Tli/TRi5jiVs5xQMQ18QunCc7Nf7MDfLl4TiN3uUw58
	 lgCn5XQFEIz+V7NB1Bh0RjX0eikLjGWnwYk0mr0QumZ5xMHU5mQCmGcrDl4cddaGu2KEu
	 RbPj5+aqZUFItdHOHTX3fMzwljmc+AxtIc4Er9EqlWiAoS/ksp2MO8gWu8poPUsehQg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E678D1F008A1;
	Mon,  9 Nov 2026 22:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794262010;
	bh=julOl1oFvNKWuVZCMIKiVAjKH2yRZZMh0SHPffPbthU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=GRnFaBJ03sv69iLvPI9BLxNh1NBZsvYAt7oKnwkTlLq/JUY4cmbKOgP7j1VPEG1Nw
	 VVeamgLMzUnyNWjJV7W3vGMwaLeV78iK7Wd0zxVsbBLeYYPrIfDveo2bjdvjMrum9z
	 +9BuZFvzsd2uuT2oMi3xhMcY//CyH8ybrotYTR6LKKYEIRAPCxOfSnuzbZrEHzJ+Z5
	 oaVKvODdttx41eqtbHGwBl8jqkGne+RHEN8bUZtn9Ip0ct1HvI5wQADHWOVXlHXFs4
	 V31bBq5s5S1CSGdXXqwp/Y6p/wnG4i+rlFL1Pi1L0KwSLw4aOR5vJNbi8rWDmaxEZ2
	 4eflDfN0Pj3Ug==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7928348690;
	Mon,  9 Nov 2026 22:06:49 +0000 (UTC)
From: Kohei Otsuka via B4 Relay <devnull+kohei.spacemachines.com@kernel.org>
Date: Tue, 10 Nov 2026 09:06:48 +1100
Subject: [PATCH v3 1/2] dt-bindings: serial: 8250: add Microchip Core16550
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
Message-Id: <20261110-core16550-rs485-v3-1-4294334243fa@spacemachines.com>
References: <20261110-core16550-rs485-v3-0-4294334243fa@spacemachines.com>
In-Reply-To: <20261110-core16550-rs485-v3-0-4294334243fa@spacemachines.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, 
 devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 conor.dooley@microchip.com, Kohei Otsuka <kohei@spacemachines.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794262008; l=1343;
 i=kohei@spacemachines.com; s=20261103; h=from:subject:message-id;
 bh=P6b5LxeKt44ojzycxPDqJDbVsMSKh3hqrwdQXDsuWEE=;
 b=k6lG0Qy6LBCfz+oi7oN+A5oALoJbZx3rHkGblMRYxCm8+e3WyPVuBZDEAPekRPIXGqbeuvZsK
 EypjAYHP0ScBw4S4rsHrjjQB6oexiF650YMx2tCuBtrTH5mMHT36tGK
X-Developer-Key: i=kohei@spacemachines.com; a=ed25519;
 pk=1kit/vmX5JiLGH9NPcqlvT55ISWaLmNipdL5VrriRt0=
X-Endpoint-Received: by B4 Relay for kohei@spacemachines.com/20261103 with
 auth_id=1385
X-Original-From: Kohei Otsuka <kohei@spacemachines.com>
Reply-To: kohei@spacemachines.com
Content-Transfer-Encoding: 7bit

From: Kohei Otsuka <kohei@spacemachines.com>

Core16550 is a 16550-compatible UART soft IP core for Microchip FPGAs,
including the fabric of PolarFire SoC. Its registers follow the 16550A,
but it raises no interrupt on TEMT. A driver that knows only ns16550a
waits for one in software RS-485 mode (em485), so RTS stays asserted
after the first frame and the port stops receiving. ns16550a is
therefore not a valid fallback.

Add microchip,core16550-rtl-v3 as a compatible of its own. As for
Microchip's other FPGA fabric cores, the -rtl-v3 suffix is the major
RTL version of the IP, Core16550 3.x.

Link: https://github.com/linux4microchip/meta-mchp/issues/5
Signed-off-by: Kohei Otsuka <kohei@spacemachines.com>
---
 Documentation/devicetree/bindings/serial/8250.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index 50d5c977afa3..d9ee14f7b694 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -111,6 +111,7 @@ properties:
           - aspeed,ast2400-vuart
           - aspeed,ast2500-vuart
           - intel,xscale-uart
+          - microchip,core16550-rtl-v3
           - mrvl,pxa-uart
           - nuvoton,npcm750-uart
           - nuvoton,wpcm450-uart

-- 
2.53.0


