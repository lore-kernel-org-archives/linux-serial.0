Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793664700;
	b=1a/e/PmpmvAq2o7R5vtuJ8XTVeDx1tl8g522YLOlK+yX6oAJO+92h9J/UjoaBt1kKdvQ
	 nwGZS1tV0ur1CWZII9kBjZW34MfjzylLOSGAv5LQ3yXqPs9Pllca9c0xNx7g3n6NK7OZ4
	 nKxU6xnERg7sH2QgB5nu4tGZ7f14NyW7y6xr+kbAurgVj+xDNTHJPWhR6zAFrwMJbkZl/
	 wH4G+AzGGglor876K/iamKQ+Fd15ZLB/hj9SoQEBrjg+7a7u9mC82yz8GxYkA64gZyKvH
	 yW52nxggdSPuoklsPezvBYQ3On9n4IuI6b1gHWm7qA1ZrfFME75gJjQLf0YbAF+A/hg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793664700;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Rimijeo0hhgQ28xN8m2LpYnhw4hO4T2xabx+eRVXKqY=;
	b=goKURu9mOKrAzeifWJXPoOEPIDhP00WsQNI5a0Wi968rZ8+Xb3NZJT52JXe/TC8kGvdK
	 rV1iNWATyzYzKDJ0Eed/frfcBeikEGAhOtZHE1csmBv0DQUtDn6+i/14pShuzQVhBbM96
	 8MF8Z26ZlT8b0TN3K7kftsZZuQBlk2jgX8gjMus0u3bVVfg0Ckj5x744qBHVTQlsKgOYd
	 Z5h6bGLsVxjDcsJxpVvKoOblCzA0VXV3Fwoct2bGWa2RuAcbEJQh7VF97LuB62hEj4Kju
	 KC4XRU36Lro6IbHgRti+KbLI2UGy8qJySZIs7qPZLS7onx3sL95hQ0oyjtabOIq7WxQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HT2gWqIJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70849606A324;
	Tue,  3 Nov 2026 00:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HT2gWqIJ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793664699;
	b=RIUtYjsQdmC6LEnb164tBMGWDdifM6Il7eIDMzRZ57d396SAYjP4sMUh4q4pPs5W0NGH
	 +y01xSoRNqKdafT8UgmNDNVRUGQX/s9m/Vu0mVHVwvw78afuB4jLhJdRhHjD3XpAbmAg1
	 y6YeI2yWrZ4+L6cvHfjoZ1FawgvodrJkdE55OObpK3SsxR9fkXoZcifRaVJVQ5VyvnsF6
	 /XP/AbONnsApj/ZD821EMPxsR/PBLworjjNtmAa4kI1dndiWkI/ljkEWeqxuToHTA9R6V
	 CR/GIWlrivhqwoITRtfbWlpP9Okgo93kU+MZPdG55Yxjkca70FMLUmTuWZBTI0K7Wtg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793664699;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Rimijeo0hhgQ28xN8m2LpYnhw4hO4T2xabx+eRVXKqY=;
	b=fREo8shFh5u7NA+l4j/1HKNbGcqWz/6vvaA1ilKhGYbppiGBxGK8qiSYQ5SyVnF8SS4Z
	 ipeh9hIcm3vu27kIB0Sgh2WyfAjAq+38HR4k6GsdIAlvSG4d0eetAxt+Q6aKv2HiLp+iu
	 7P0qaA9dbPSKW1KThq83rU4M5dGN8pamp5rXxMPSvPZfdDy6o8suX1UesxMyCyP3+M7r0
	 n1/5E1eS4UW2OMji9Xf5Te4LkUkqBBlyjMEcEH0CJVgs+9nDnewcj5Vky84lYVDEKyi+7
	 5k6uiIzPfC9Nq9cjhJWyqGG8nwpiFMQAzuqtwM63vaJJaCTMEIfCbtTOUtgDMpcShPw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8035B1F00919;
	Tue,  3 Nov 2026 00:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793664699;
	bh=Rimijeo0hhgQ28xN8m2LpYnhw4hO4T2xabx+eRVXKqY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=HT2gWqIJcie6EgkFkGzzUpd+b0IdSD8kziHqPQfH1+4kLyctxdQrV7uC8f+tsSecO
	 cebGSxk1VInvj1x9YDX9VjsUBiL00oKNJExmJC+WEhJbi9irY+sZPn3YK0Z6ftlqbk
	 w/lL41WwsayUD/ElJ1WNbQTRe21hoHkzQnzm0vRGIE02Z5jau/eK6TLA5Se8HqD0Wv
	 CUMhShMuWGYhRs2DaJtDOlAQFashCngvGaVmhep2cEtZArJeM/UhGXIgKrDqdtFb8X
	 rFJ2Ke1rag/iuwpb2Yh1HmsTCTVrY3euvsk4iNCgV/WByjSNEaI5qyI6HX9DKGak0B
	 FFqTdm+YArAHQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 13992466BA;
	Tue,  3 Nov 2026 00:11:38 +0000 (UTC)
From: Kohei Otsuka via B4 Relay <devnull+kohei.spacemachines.com@kernel.org>
Date: Tue, 03 Nov 2026 11:11:31 +1100
Subject: [PATCH 1/2] dt-bindings: serial: 8250: add Microchip Core16550
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
Message-Id: <20261103-core16550-rs485-v1-1-6d15ebe1e5b9@spacemachines.com>
References: <20261103-core16550-rs485-v1-0-6d15ebe1e5b9@spacemachines.com>
In-Reply-To: <20261103-core16550-rs485-v1-0-6d15ebe1e5b9@spacemachines.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, 
 devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 conor.dooley@microchip.com, Kohei Otsuka <kohei@spacemachines.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793664697; l=1092;
 i=kohei@spacemachines.com; s=20261103; h=from:subject:message-id;
 bh=5TXl591/YzqcOSELFalYpXwEI+0DMkNWmIZ4V551fL0=;
 b=+enBIazHpUREEwhYKyIiaqaWTCMaO/lY47NrchaLaXzIBuAE3LAU2vQfh1AfMT3mPZf1nj+ca
 2hEZDtprBBrDgOn5xu5WykMIW1bk9zf6IiZc8/qpqOI0hqZXAOTVGMM
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
so ns16550a stays the fallback, but it raises no interrupt on TEMT,
which the driver has to know about to support RS-485 on it.

Add microchip,core16550 with ns16550a as the fallback.

Link: https://github.com/linux4microchip/meta-mchp/issues/5
Signed-off-by: Kohei Otsuka <kohei@spacemachines.com>
---
 Documentation/devicetree/bindings/serial/8250.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index 50d5c977afa3..33a5929bdaa6 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -137,6 +137,7 @@ properties:
               - ti,da830-uart
               - loongson,ls2k0500-uart
               - loongson,ls2k1500-uart
+              - microchip,core16550
           - const: ns16550a
       - items:
           - enum:

-- 
2.53.0


