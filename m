Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793664699;
	b=YU8zhIDUP7imofsrr0FejTE9r0x6L6IC/bZku9O8v3aFWGV9OEE93/U6doW14D1bRGGE
	 eJiAZjjyuXk2AVzigRZ6R+G6yplj2VxeYfca8qTeDpXmKPdA3ZX9LJzHlsDA30z0sRgdJ
	 5LESGRrBU/+74MbGTiZKTLW4T7YOxJy7Fvsu3+eyIo/gRu7LtHtNbfWavKd0Yw8oe1l/W
	 0mVDGc3deQleXqIs6FC1tt1/EoxufS6NQN3Ma4sX9TJyrXuMql3IV5P4PxDwbrCH3nr38
	 wf7C67DaJp4XtQUcmOBeQdVXmG7HveSQNVQcF87Rkjc0NicJurRQ/8qtaaOHdmo1xhA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793664699;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=Tru9ersG6SW5IaqA2n66w12NJnuVIupxpBRJfMjZPZ8=;
	b=ikYwqoBgbSQtUCPW0jliX+xBVfACXwvkEgCg/GlmpjBy+oYo8cCGwVVusGkxeTtHAJTs
	 Xt+9CLGMBFeGU+Zt0tYTSYEim4BjzsORrm6DOtua2U40gNd71H3ehUwhDD/Hd2HFGg4sE
	 uqO+p01ZDtLFoXa54BghzPh5rg5hVeFCXDphmGiEpqsy2UcoPKu7pSyFpR573jk2g00EW
	 P/c1ID4GAa15e28yPgs2V/agb50pfboR21YU84Xi0SO2XaBpALQuh1V3DL455sjZYaGJU
	 a5LwChMVS3ppdIqd4QKrUdqJPe216uo8ZkEIoU+oAR/BUBYn2Mxh2mant7eQhYhCWog==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ohdj5Eq1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708F7606A326;
	Tue,  3 Nov 2026 00:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ohdj5Eq1
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793664699;
	b=WeUTE/VOag2XhlvxBVj1Q/4IPeFC3x1qdoJdy2D4kaRERG4KGLED8qxYSjKuPL0Vxr57
	 PbqIk31jFP4tZfz22so7SDgbOu+h4d2b1qUQzfNRrhamj/82tt7Ha9hjRKNhvwW1Fe8Et
	 B1R4eEZD62RwfPZV7xGm/n/nSq1hpnECh3DJdddDCUKD0g3FifPn6/3hypp/5iTAWsmbf
	 xoViCTc3397EwxxuNpq5tJ06EQ9hsqR8If9LgywBPwUMy9cFTIMAc4KLJT4X/97B+kAPt
	 ZQeanMoVE9GFL1OrRSt+H8ci6ck8jWWPJD5Tsj7kCAssn1mSewDHNMFgjMH6EoNLrEQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793664699;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=Tru9ersG6SW5IaqA2n66w12NJnuVIupxpBRJfMjZPZ8=;
	b=NFpPkUQu4kVA11nUZfqWZ33pbYKyNjjp+gC2tbJ5E8KhhbLTroXr6+R+dD+WXd05iGv1
	 oGZoWKs0pqsFyuodXgSPbzIkcCcYJPrd7dol/KOMNJj2zlDUeCGxOsDjLHVAZ49f4TVI3
	 EOxAC02md74/nv6FxsNXw7JW8mALckok5lYsY/hv+gqo3vpS5mqhtPrVlmqXP1BWPrxZY
	 JyKYmMmWWwXMt2q2M+6P/pTfdZ2HrHcutfY+RGTFsX2XCeqgztQGJhBkXWtxAKe8Ftnuv
	 DcSEmJnqfvDVUba+oueOdR3pYVoNW+uSCON9h1NQ6A205/LGJtBKxNhMksDeYw2QISA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 715D31F000C1;
	Tue,  3 Nov 2026 00:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793664698;
	bh=Tru9ersG6SW5IaqA2n66w12NJnuVIupxpBRJfMjZPZ8=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=Ohdj5Eq1Yipg99l3wb6DoeWkS6tqeCyFpY1Jy6o4J5+6axEsFrTV3ms6jNOH3yzHT
	 /5p/5zb2QSfwgRzNovunlhTVI712VyMgkP2R1LveVADlPWGlQ28nBv2qW1fStWf5dU
	 fkUH7JrxJqnxSh/gMn1puCGcG3Fww8GBTK295lXzLkdQDRMYpfEPiftpOCKLZR7Etm
	 OGTscfwzoz+Csl99P870E4L20P4rXZNmRGt6Nv37mkJ3/0HF1M/3jMyeU3r7GuyA6A
	 +uPj3UfUFDM2Bgdkosp2zDbSEk+A6cQexYQaUp8FkcgmJQ+vWAJ3bmEBokjfzSo5Fn
	 txpAUMdDMNj5Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 03EF541E25;
	Tue,  3 Nov 2026 00:11:38 +0000 (UTC)
From: Kohei Otsuka via B4 Relay <devnull+kohei.spacemachines.com@kernel.org>
Subject: [PATCH 0/2] serial: 8250_of: RS-485 on Microchip Core16550
Date: Tue, 03 Nov 2026 11:11:30 +1100
Message-Id: <20261103-core16550-rs485-v1-0-6d15ebe1e5b9@spacemachines.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CQAxG4auQrp2kA5YQr2JcDOM/WhZgWjUkh
 Ls76vJbvLeRwxROp2Yjw1tdl7kiHhrK9zTfEPRaTS23fYzchbwYYi/Cwfw4SBCWVLiUBIxUq4e
 h6Po7ni9/+2uckJ/fDe37BySp/CNzAAAA
X-Change-ID: 20261103-core16550-rs485-505af0ffaeeb
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, 
 devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 conor.dooley@microchip.com, Kohei Otsuka <kohei@spacemachines.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793664697; l=1885;
 i=kohei@spacemachines.com; s=20261103; h=from:subject:message-id;
 bh=VtVtaNmxg+V5Ozhf37hKbYQgTOiMqoX/CUGJRiLE/+c=;
 b=5TP9ZJC4rHLSGXK+Bnq0LwxxZrJEMLnpLSGHx67w8WFUxlPg1pEeAdS3Oqai9qEDy1iKClht+
 RC8pwrWhAEpDvFPz8wL0WAHD8HELKTYrgKSeplWE7IcWZYXXpcK7dkx
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
on FIC3 (PCLK 50 MHz), linux-mchp 6.18.17 with this series applied,
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
Kohei Otsuka (2):
      dt-bindings: serial: 8250: add Microchip Core16550
      serial: 8250_of: drop RS-485 RTS on Microchip Core16550

 Documentation/devicetree/bindings/serial/8250.yaml | 1 +
 drivers/tty/serial/8250/8250_of.c                  | 9 +++++++++
 2 files changed, 10 insertions(+)
---
base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
change-id: 20261103-core16550-rs485-505af0ffaeeb

Best regards,
--  
Kohei Otsuka <kohei@spacemachines.com>


