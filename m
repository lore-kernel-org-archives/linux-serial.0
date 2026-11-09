Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794192908;
	b=3vpch+MB6DEkwP0XctFL+uBp/L9RMQkK7053QDcqLAXMEoNYkZBVqFKKGyINdxeb6hsV
	 poao9oMX8YdVHxogXF2ThVfzzyIMlrc1wcOkEcF3Bkh9ACGp0sstUj3G+CBj7oQ5I3mZk
	 x1Rkl1JQ7oujc7XMcSubDRPLXhb4+GWwczfELYW/rWCRUUyCqksWpSu9OZILlHEFaLDX4
	 LjH7WStcdCifllUBywgbYJPeHQiJso8b1Lpe3iF0qk+fnQ9R9yiv631/FfcnaTG9BPafW
	 PRsiR1dujgWVMxsN1ZuPmUUnoqzjhLvUYhjQuJ6TOjiU1q+/fBSTu4eArZTuMGKelTg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794192908;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=hCLJhCUS0aC39Klvw3MzzILFDtWzh1NJzG2j/NEt1UY=;
	b=WxxH8uXla81MNlbPAsAZYYR3dURerYDUpBgDoiIcfLzVNCHYYlKr82vU9l/9WUlv66Q4
	 yK3478e5c9Ma2FjliFDNVEcKDZg3AUBGURHEEWHtXs2g/hTO5JhhbdS8WxEiUU7GJS4ML
	 W0c4aOS/m6dhv3SAKleb9zPkyZmIMui0X5PJQEmhYrhAEtbX2SXwbIAkgEblwNOj2yAGY
	 fy2UjkdFL+FHz+RgsvcbEssfHO04LzRgNMGN/+YrYC1fjVXume/US9ei388msE6HmrOn8
	 ZHtCjEAgaXzYkiN8WsOSQ8CCI6PYQ3RPyD7GtQD3JZ2TlM2eS3/a9xMwUlz7X9Tf61A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=inlRNb6J;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868E3606A321;
	Mon,  9 Nov 2026 02:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=inlRNb6J
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794192908;
	b=jPikI2983IZS7qISy327+orS1iSm2Lv8rECkpMxlqfJ/xv1pYl1pDd5kPJ0fv2hqLnhr
	 Lqo+JwDKO+9Hd27siK2GvH7A/YRbf4HpCwP0r/xKNe11hnIYgp8QXv1seX2utk7eC+lR/
	 hqstP0DF5nlYL2HSkpz9PiTIs9SY37CAzVk4qS0mJcSbxiMYuO8nX2N8sTx1yjzV2xzSV
	 y0aysgFRUzH9NL6uIG7hZeUbnTB4TqRa+LXDHck3orZa01S+RE5t7lhO+CSDksYSmszJt
	 /U+0mrkVtgaZyzesppdQt8cCKzt8nbu+nv2sO/YW0d0bAEjVuYESOjf/UtOHy5+SAXA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794192908;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=hCLJhCUS0aC39Klvw3MzzILFDtWzh1NJzG2j/NEt1UY=;
	b=i2EDjFHpc97O4B6h/5++14ihdgE+n3PDzLrS7V6qPdfGNxBLhFwncK9yfPOo6GlRqvZk
	 z32SoaFE2bpyjwooG6jNTKxba6T8Qs8+oogSdhtdSHKJHfozwec+rHIKNdl2h+sqoqI9y
	 917tQCaHTuljOZJrs2W13s7xr3Ie3itLdPuY1sAExnoYMmQ+80KCIXcp+A7PvCPs5orlf
	 mH44a4TJWV3Hjf5jV59LRCSCwvlxtzzqXZtKz54kUHEGnPxP9TKzBIJzvpaP/LFRPjVdE
	 7omOKWZO7Lqsw/jkgpLKBjpz6pVOUSoUjbFkF6bRk9MeiIP+UQDtenvO8thMDrwI2Fg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 74B4C1F0089F;
	Mon,  9 Nov 2026 02:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794192908;
	bh=hCLJhCUS0aC39Klvw3MzzILFDtWzh1NJzG2j/NEt1UY=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=inlRNb6JcXIa1Et4WI/bw9Y/w+e57fBCkXO9OzaWOsDztv+dPgxO6fPImZqNXHsoy
	 a/LzKPJZUmD5qjgGHykXTf/ZFI99YHGkW09/fgeHdkyKY6FwkDUdBQCWXPMI38j8Cr
	 HlO5NnaOZ+lDVZDZ4+53QgJoU5SGZVxxBCTtlwEAQtg9696vAJVYLL3JNSR8ffbrpw
	 nec0n5LmpazuvjGK/ffY6OtpW8oYJlg9ta37JTaqZLc7b/OFvQjJMG5qZdOBIN7oex
	 PEQrigFq+chZ1Bq9+rw1ibgAcGsN6OO9LpCExbRygSALHfSBjfCwbYn5oh7OWlmMWl
	 349IDApKnsZ8w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E62CD4823F;
	Mon,  9 Nov 2026 02:55:06 +0000 (UTC)
From: Kohei Otsuka via B4 Relay <devnull+kohei.spacemachines.com@kernel.org>
Subject: [PATCH v2 0/2] serial: 8250_of: RS-485 on Microchip Core16550
Date: Mon, 09 Nov 2026 13:55:04 +1100
Message-Id: <20261109-core16550-rs485-v2-0-a15933c7b907@spacemachines.com>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNQQ6CMBBFr0JmbU0HHaKuvIdh0ZapjAmUdJBoC
 HcXdO3yJe+/P4NyFla4FDNknkQl9SuUuwJC6/o7G2lWhtKWFaI9mJAyY0VkTdbjiQxZctHG6Jg
 9rKshc5TXt3irf6xP/+AwbpnNaEXHlN/fywk37399QmNN1SCxZ2Ty56sOLnDnQis96z6kDuplW
 T5v6nYqyAAAAA==
X-Change-ID: 20261103-core16550-rs485-505af0ffaeeb
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, 
 devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 conor.dooley@microchip.com, Kohei Otsuka <kohei@spacemachines.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794192905; l=2791;
 i=kohei@spacemachines.com; s=20261103; h=from:subject:message-id;
 bh=f2A/H5VB6PfODmMTbPgALIZYZl5rfDVy8lpdMZKZsFw=;
 b=xXTMsbmJO+GrhRmRI8JeoCEMfKJHsfBZMK7rQZY6zEHp4BDcYYihqsapc1FnA+8IZRG2S4+h5
 55TDccEl5qZCaUjja4g5zvlcuSL4QTFUcVKpsWrrkRi4gfaRUjlpMfq
X-Developer-Key: i=kohei@spacemachines.com; a=ed25519;
 pk=1kit/vmX5JiLGH9NPcqlvT55ISWaLmNipdL5VrriRt0=
X-Endpoint-Received: by B4 Relay for kohei@spacemachines.com/20261103 with
 auth_id=1385
X-Original-From: Kohei Otsuka <kohei@spacemachines.com>
Reply-To: kohei@spacemachines.com

Core16550 is a 16550-compatible UART soft IP for Microchip FPGAs. We use
four of them in the fabric of a PolarFire SoC Icicle Kit as RS-485
ports, described as "ns16550a" with linux,rs485-enabled-at-boot-time.
With RS-485 enabled, RTS (the transceiver's driver enable) goes high at
the start of the first transmission and never drops, and the port stops
receiving. Core16550, like the original 16550A, raises no interrupt on
TEMT, so __stop_tx() waits for one forever unless the port has
UART_CAP_NOTEMT, which 8250_of never sets.

Testing, on a PolarFire SoC Icicle Kit with four Core16550 instances
on FIC3 (PCLK 50 MHz), linux-mchp 6.18.17 with this series applied
and the ports described as "microchip,core16550-rtl-v3", "ns16550a",
115200 8N1, against USB-RS485 (2-wire, half duplex) and USB-RS422
(4-wire) converters:
- All four ports transmit and receive correctly with both converters.
- On RS-485, each port keeps receiving after transmitting, across
  repeated request/response exchanges in both directions.
- Without the series, RTS stays high after the first transmission and
  nothing more is received.

This series was prepared with the help of an AI coding assistant
(Claude, Anthropic): the analysis of __stop_tx(), both patches and
these messages. I reviewed and tested the result and take
responsibility for it.

Link: https://github.com/linux4microchip/meta-mchp/issues/5

Signed-off-by: Kohei Otsuka <kohei@spacemachines.com>
---
Changes in v2:
- dt-bindings: rename the compatible to microchip,core16550-rtl-v3,
  following the -rtl-vN convention of Microchip's other fabric cores
  (Conor)
- dt-bindings: explain in the commit message why ns16550a remains a
  valid fallback (Conor)
- 8250_of: match microchip,core16550-rtl-v3
- Dropped Krzysztof's Acked-by on 1/2, as the compatible changed
- Link to v1: https://patch.msgid.link/20261103-core16550-rs485-v1-0-6d15ebe1e5b9@spacemachines.com

To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Lubomir Rintel <lkundrak@v3.sk>
To: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org

---
Kohei Otsuka (2):
      dt-bindings: serial: 8250: add Microchip Core16550
      serial: 8250_of: drop RS-485 RTS on Microchip Core16550

 Documentation/devicetree/bindings/serial/8250.yaml |  1 +
 drivers/tty/serial/8250/8250_of.c                  | 10 ++++++++++
 2 files changed, 11 insertions(+)
---
base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
change-id: 20261103-core16550-rs485-505af0ffaeeb

Best regards,
--  
Kohei Otsuka <kohei@spacemachines.com>


