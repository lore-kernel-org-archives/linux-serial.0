Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792873355;
	b=ahNLf/xe8jTXVy2nE6pAR6YsK6GPanPJeaorCmbRPm2OMHV+MK5UyqVyLfWkvFK02ldw
	 1Oh++//KuK3TNwD7tAimwa1vUYxk3f3ecI1FMBW/ocUK3oQv4+juCzLHVATtAoIXd1aE6
	 OCf0M4r+74Gmdg3Cm/Mm3fe5/M17C+Cwe/Ow6Diq44JBUSXuW3y6SywAHpatXnDqAyW6U
	 MYj+qF0PFC8bZczy/MiFLEKDqlgRJsjVKRh3VnSeqfFNq3jKusqvX+/dGlDKKicL//7Gu
	 HVTOcyJIVyc1MSD9SEB51yxBIzquTu02hJfcUb5Gvn9rGjvM9r01Is977na9VYiDoxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792873355;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=75yyN+wYPmh4Hv6W18LTzVXcBapZ5SC3mIWHEkYwJ3s=;
	b=b58KokgBBhPAeAuc3XWGZfW6qL97WRqEZAlsjgaQ/9VMSFCs+U7NdVzUccK0pkYX3dC0
	 jDG1eK6XKbH+6N+ruPHfnOw61sx9fZ+A03VB8wAaSqcrkKNygIU1k0wOXPuddK9hCuc1P
	 xRFuOtwFp6mxT1ciWUMNwaEafmVs91gt/I8hdoS4Esxbw5+E049ApfhGgzA3YvYmfatDy
	 Ab/OJSjB4oMeGwQNTmNW0TrMCCIUOrrHuiwxa1BUoXQdjsbp7GryfFAF70gTfPvslng90
	 wuvsWbJFO5QjSyjysb++gWJgWWGpiIWLIt4AZYaPjpY7+xlO8YKNKrEOa5WOtYXxv2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eccjtITm;
	arc=none smtp.remote-ip=209.85.167.169
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0720F606A31E
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 20:22:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0720F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eccjtITm
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4f699fe49b3so1250817b6e.3
        for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 13:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792873354; x=1793478154; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=75yyN+wYPmh4Hv6W18LTzVXcBapZ5SC3mIWHEkYwJ3s=;
        b=eccjtITm1UfZSzudPeVCmHScSnrc69np15qAK+549zjy1PUkucqP2mQV7UTbSNONhW
         dC58PVuByyMEPfl44WC4sFWS01cDQ1C3jtg1SsRs0BwkOa2WUlbPH+o3ehCmqj+bXz3M
         8doWOrTujdaBjbPuEQd8PmFWEwaHPt1u498R0zoVTNi6ybhE1fPjGi1940frG6qG4ETZ
         au7OPSY8mJJ0Xdc97gJ1HEZ5B3h6a5LMYtoAuBPWQu8P/iakggDnTy4p5kjxk2o3F6hK
         dTufrYG1s4ZNr0/8/KO/ebruVxTuGzaltSo0aYWxD21qk07ZeX78CPw7KyceEbXJL1LJ
         NVyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792873354; x=1793478154;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=75yyN+wYPmh4Hv6W18LTzVXcBapZ5SC3mIWHEkYwJ3s=;
        b=pPD0FYsQceeltGGjIDGoxfZNT6eXE+etDpQEWUNYcKNPjxWZM9hPfhqjp/u05a57ze
         0xhYbaY2bmbBhvUMyc6050Qw421TSs+hyCNnvmhO/2ot6RCqLxOWGEfrt5iQko/oKS9X
         7WHQkAuFvGehwnIMvvjAM0d36R4STEcdZ+rrUe+qOgt9o5jOa/zx0SREjeXBSKaTvR8I
         DmuKfbyfI+nk1+DJiD4qQzGvNe8Dfsw4aXnIMA+iQQeDmc4lOlWK3Z6717OwkWJ45nX/
         5kQ01hKQ72ea17rHropbxqxD8SNS3EvAhowYTzP/HO/smmf4yQnB7ZiD/nfPWtkxA7Co
         zJ0Q==
X-Forwarded-Encrypted: i=1; AKwUvBwpYUk61vKfxD27a012QwqrjZ4cSHy3Sp96iQR14IpqvizUlzJ7GoE0DKLfXJ/+yzdI3xQQt2LkDNV5lhE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ7V6uStEfrY4fCfRu/hvmf2Dh0XGtCpLLHQ6ObTTvVwo/3vEwK
	bS754i0XJjdmUHRaUQ9NCQPdJBvh8NGxUH0pDllQ/qy/BqDYYruNm/Ht
X-Gm-Gg: AYBFou0RzmsorMDp7E2mJxybq2z0OT/a4vugX3cOHnakg8WpjXI5muT3YojMNIHVxAt
	h7AxFnJtN6NWQUiThvbygEYX3E0CKLhraQcq6M7TOCRk/MFhKfDpbekHTwwjN6J358NwpgjV3C0
	oxdlo3l8dQRgtboy1MdpfeBYNE0rChf0M+8VDQGulvmMOuNf6bxPil1gdO5ifPujlOE1NilhJU5
	mn5Dbk0kU6kqHNmsmrege1Frun41+s3rmpWhOJXj8LzwCTbNoT64drE8jGQ1/zrE8aqC0LQH90E
	NniOxZyMrZyqIspIIf77OvU+n8s3EdZzHlR38kkFupKEfj++rBQtG2XdnOV1H/Jo+nF6mPt4Tqm
	mWGrRVcuKT9hqzQgbhuzrlgpzYpmiclbdxwTyCVqyAD0LAUAO7yYBYSLYDxvIz3a5JuMd2Amean
	IpXIKFktTO4NS9+UVczYfi0LID6W4A1GnAAaSSSYJmN3PvMzGzv4DmWocXhd+l1jWmVJBBfZfa2
	U5r5s5gWSqHI/b7EgAaBJm9gbY0zKAxhgIRkOfNawcrl7V760afdv1kJAh8W+nLOqodH9Nx3qsg
	BAE6uDGOL3Z51qksbUFzYrIXnLfYn8OY3D6seSQAczdcoBGEnnbs+vEHkT162LWFmmXVbnFqINM
	U1iJzGmie8wNz4cYKG8+ejoKcvuGK0ZSJ44A+g7MTrgG0wXS5fk8KsSXvK1l6UuqIIQRQeeqHCP
	7EIuh5
X-Received: by 2002:a05:6808:14d4:b0:4d6:90f4:48b1 with SMTP id 5614622812f47-55c0038ebe6mr1678982b6e.51.1792873354005;
        Sat, 24 Oct 2026 13:22:34 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55c0424775dsm1815063b6e.5.2026.10.24.13.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 13:22:33 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v3 0/4] serial: 8250_dw: describe the Allwinner H616 UART
 configuration
Date: Sat, 24 Oct 2026 14:22:22 -0600
Message-Id: <20261024-submit-h616-uart-fifo-v1-v3-0-286fc1b8c3c1@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42R3UrEMBCFX6Xk2pH8NGlaRHwP8SJpJruRdqtJW
 laWfXfTdhe9EYTcDJn5zjkzF5IwBkykqy4k4hJSmE6lEA8V6Y/mdEAIrtSEU64Y5RzSbMeQ4ai
 YgtnEDD74CRYGvTS+dx5lbykp4x8RfThv6Ne3vS6z79jnlbd2HEPKU/zatBe29t1lxN8y5VHA2
 ghrkKM1+uUwmjA89tNIVpmF/xfEC8h4Klshaa2E/A267oYjfs5lJXlPQaxJCOW/ALuKMV173SB
 vWora+NaiYEx5RbXjqJWtm5a7xq1JR0zJbLvsqqebtfpubb2AGUBzSSGecwwHGILHHEa8BWbQC
 GYb7SSlwv34fC5Gr99XjTWUwwEAAA==
X-Change-ID: 20261022-submit-h616-uart-fifo-v1-c5afcdfe5cb0
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

H616 has 256-byte UART FIFOs, but lacks the DesignWare component parameter
register used to discover their capacity. Its debug-divisor and RS485
registers also overlap offsets used to probe optional DesignWare features.

Describe the FIFO capacity in DT and add an H616 compatible for the
integration-specific setup. Keep the existing 16550A port type, preserve
the firmware-provided depth and derive the Allwinner receive thresholds
from it. Configure automatic flow control, preserve the BUSY-safe integer
divisor path and keep the UART gate enabled during termios changes.

The series first introduces platform setup callbacks, then adds the
binding, H616 setup and SoC DTS changes. Based on tty-next at
1184f87e2790 with the posted RX trigger callback-lifetime fix [0], so the
custom trigger handlers follow the registered port's lifetime.

[0] https://lore.kernel.org/r/20261024-submit-serial-8250-rxtrig-lifetime-v1-v1-1-731b78d5003d@gmail.com

Assisted-by: Codex:gpt-6-astra
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v3:
- Introduce a platform-data setup callback in a preparatory patch,
  replacing skip_autocfg and preserving the existing Octeon setup.
- Describe each H616 UART's FIFO capacity with the standard fifo-size DT
  property and use the value already read by uart_read_port_properties().
- Derive the Allwinner RX trigger thresholds from the FIFO depth.
- Use an unsigned trigger index and conditional runtime PM guard,
  preserving error propagation when the device cannot resume.
- Rebase onto tty-next, replacing the earlier DMA prerequisites with the
  posted RX trigger callback-lifetime fix.
- Separate DMA enablement into follow-up work, retaining PIO operation
  for the H616 FIFO configuration.
- Link to v2: https://lore.kernel.org/r/20261023-submit-h616-uart-fifo-v1-v2-0-af0593504635@gmail.com

Changes in v2:
- Keep PORT_16550A and set the FIFO size, transmit load and capabilities
  during setup, following Andy's review.
- Select H616 setup through the matched platform-data pointer and remove
  the type and DMA burst-size platform-data members.
- Use get_rxtrig/set_rxtrig for the 1/64/128/254-byte receive thresholds,
  with port locking and runtime PM around register updates. Keep the
  standard half-full FCR default, selecting 128 bytes on H616.
- Advertise UART_CAP_AFE so CRTSCTS enables hardware automatic flow control.
- Rebase onto next-20261023 and declare the posted sun6i pause/lifetime
  fixes and their prerequisites for DMA enablement.
- Link to v1: https://lore.kernel.org/r/20261023-submit-h616-uart-fifo-v1-v1-0-e4a3bae2eba8@gmail.com

---
James Hilliard (4):
      serial: 8250_dw: select port setup through platform data
      dt-bindings: serial: snps-dw-apb-uart: add Allwinner H616
      serial: 8250_dw: configure the Allwinner H616 UART
      arm64: dts: allwinner: h616: describe the UART integration and FIFO size

 .../bindings/serial/snps-dw-apb-uart.yaml          |  17 +++
 arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi     |  18 ++-
 drivers/tty/serial/8250/8250_dw.c                  | 123 +++++++++++++++++++--
 3 files changed, 142 insertions(+), 16 deletions(-)
---
base-commit: 1184f87e2790e8af9be3116f608d2e86b4792d7d
change-id: 20261022-submit-h616-uart-fifo-v1-c5afcdfe5cb0
prerequisite-message-id: <20261024-submit-serial-8250-rxtrig-lifetime-v1-v1-1-731b78d5003d@gmail.com>
prerequisite-patch-id: 9a9395c715c2bf7bbcae5bdd16a339d7f2af6269

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

