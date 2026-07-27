Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703C33BBFAD
	for <linux-serial@vger.kernel.org>; Mon, 27 Jul 2026 07:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785138037; cv=none; b=kZRr+QD56OZuqj260d+APknNLhgnamZETJHw6qVOxy5eGrZzfwKxcgQsmbTuYOUtpvdyY9e4MwiRSq1MAFR+OxYcfYr7pLHN809esduxdc1EsMqXCEm+YaG3w3/c5/l2AmsiK8dvDy6JL4+Aid4wUZ7iaSm4y7pD1aktmMOhBzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785138037; c=relaxed/simple;
	bh=OygoRfGon7dYJNR2US0LH9/35f6aArMEQMwU3t4zO6Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Fd2RUn/M5Fm+eu4Rs4GusAHqrYo2ImWjXiUJRiyOAvO9jNRzKXwxz047UKNywYrlLKt/TSTfOZJU777KGTCzsxuEJuQKLHKjB44ASFqYGoEbbhen5fnTGf7MlZaaGxHDw5SL++9B4hqkVYleQ9M57gXASr9NaMYu7mqF3OC3Dss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=FIFDABkU; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="FIFDABkU"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-4784b41f3aeso691345f8f.1
        for <linux-serial@vger.kernel.org>; Mon, 27 Jul 2026 00:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785138034; x=1785742834; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3ymwueSqv0BpYNpyWUdRv4xMRNQnOisJ/XLIc8X3z5E=;
        b=FIFDABkUcJTTZ8mZRUcz1VrLSa6yCwefhcA1t5zl/G//6FiLyd4eKUL5Yn08/FudU6
         B+1nFwux/+q7VMXhQ3HnenNOY0/tsgnihjedxh8JBt3I7XzsPMQ6ZxXc277Yu64/3/zC
         UxI6axm4XbJRmpMgfxl37jRlhuOJcNidC5gpIa+KlaMKZB6aEEi7n1mKKzKAIklpZaDb
         UZQJd1kL9kt4fgDh11SS7XGBH0Zb4tcamX9lZm8pVyEDGoRyjZjgb4GNLpOL7KH9UYfo
         HM5KRAyjShnfUdbgX9VavSWpdwngm1uMqoVB9wDSqx8+KCk5jIaWUyYm6gC3VeRpXBZU
         DAeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785138034; x=1785742834;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3ymwueSqv0BpYNpyWUdRv4xMRNQnOisJ/XLIc8X3z5E=;
        b=O25AP+pakVCVi4xUOHtdiC0VQfWNjZjm31tifJgpd7hHth4ndubCn0Nc9suRJYr+5t
         FaShH1h8Q5ijdetbikqqMtwKObh9217iRfFnjgJL2VK2I6BRR+Rqrz5dcMkLc31d5xZp
         8+v7Nu8RkTVBByCVtr9sNxaGnoQAmEILQIBw3XWgONCQkaeGDmOH1oh6VTuoUTkzmnJm
         uBIki5Fa/gEl0cq8iwn3oQC8d/bgROSxG6XGxocPiERwMssvN+YjwSYozuNGOeALdaAW
         J+w4FaQTwpun7MVCahS4A2duUroVWSA+cHEUgJ0H4XEYiT7CXJibccU7YDbEpfDjDq29
         Eksw==
X-Forwarded-Encrypted: i=1; AHgh+RoWhxB5dNW/dfH0NUbuwfL1vBfKd8mebMcYKj5k0pFv4D198zwhj3c7F/kJ0oLBfYA5B+y1P4F+bbhmx98=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4102oJ/OdtQBmcNF96/1YicqPtTTd5oeZHfzJIPKwbshEDxxA
	uA7DlC5h0D1iu0npX+QJdKymtDYYMQ7LbwgrBcQayC/SZPUz2NzGcWmO8BaxATX8ziFCWWscqKz
	I6c8NNJx4lNZ3
X-Gm-Gg: AR+sD12xN76B3Nkylai1SCvdLKT+oZQjyJzMjbHohfvMvtDSo2/esM53v8M7a6Ll1r6
	K+MacB7qbgpjXV0QJrSCsYBOvys/yFy9fIejkzTDAGXcJTmYoMxICjcyk65X8yL+uAWGX3P9fa8
	q97wZAd7HWZPdI5th547tMY4nINaDo+v73Ui4gEhD3thyNEmy9+yy+JFkoFSSeenp3UOHwRQl5D
	pp9O9swSZhrBtrmanmABANvG/MgUbTU6tfk185/AfImx8XFxpp85wZtNfQgZKfS8MAn5/HN3hiC
	2hFdO8LsvRK1ajfaweuCGRGOroy/zabvOL9zpEzsIAY8BDSAl4uEHFt+Ex2FZgDXcAmvTPw5ZxX
	fmRP4/NfN+Aovfsqbbf77FByoI2s5vBJ96if5ES3mBqNNvB2xN64GnXndcsvipckiznWiI+VXFa
	N3HpFDO1yMqEwD+2zddndj8vXFcmeSfsfBBxyoUV4biAgbGtCX3eAkqu5vewG/CkcgrhEQSUXo+
	5Q9YH8p3mytlA8=
X-Received: by 2002:a05:6000:310e:b0:47f:9425:1a2a with SMTP id ffacd0b85a97d-47f9fe97d8bmr9625606f8f.30.1785138033659;
        Mon, 27 Jul 2026 00:40:33 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it (host-87-0-90-136.retail.telecomitalia.it. [87.0.90.136])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb5127sm43677682f8f.10.2026.07.27.00.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 00:40:33 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Subject: [PATCH v2 0/2] Stabilize serial line numbers on MediaTek boards
Date: Mon, 27 Jul 2026 09:38:07 +0200
Message-Id: <20260727-ccaione-genio-serial-aliases-v2-0-0f2ae41a8e89@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NQQ6CMBBFr0Jm7ZhSAoIr72FYtHUKY5CSFomEc
 HdbvICze8mb9zcI5JkCXLMNPC0c2I0R5CkD06uxI+RHZJBCVuIiajRGRYWwo5Edpm81oBpYBQp
 IpZVG1rq0toKYmDxZ/hz5e/vj8NZPMnNqJqPnMDu/HvtLnrw/p5YcBWor4zXUFHVx02odWHs6G
 /eCdt/3L/oS1v3dAAAA
X-Change-ID: 20260708-ccaione-genio-serial-aliases-e5f2c28b5ff6
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-serial@vger.kernel.org, dlechner@baylibre.com, jstephan@baylibre.com, 
 Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.15.2

On MediaTek boards typically only serial0 is aliased, so the remaining
enabled UARTs get first-free ttyS line numbers from the 8250 core at
probe time. Line numbers are handed out in probe order, and probe order
is not deterministic once a UART defers on its clocks, so the console
UART can lose ttyS0 to another port.

This was observed on the Genio 700 EVK running the Ubuntu 26.04 generic
kernel: uart0 (the debug console) deferred waiting for its clocks while
uart1 probed first and claimed ttyS0. With console=ttyS0 on the kernel
command line the console then pointed at the wrong UART, and the boot
looked like it had hung on the serial console. The failure is
intermittent and depends purely on probe timing.

Pin the line numbers explicitly instead:

- Patch 1 aliases every enabled UART on the affected Mediatek boards, so
  DT expresses the intended serial<N> -> ttyS<N> mapping.

- Patch 2 makes the 8250_mtk driver read that alias with
  of_alias_get_id() and seed uart.port.line before registering the
  port, so the 8250 core reserves the requested ttyS slot instead of
  falling back to first-free.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
Changes in v2:
- Added some missing MTK boards
- Link to v1: https://patch.msgid.link/20260708-ccaione-genio-serial-aliases-v1-0-bf22229e9383@baylibre.com

---
Carlo Caione (2):
      arm64: dts: mediatek: alias all enabled serial ports
      serial: 8250_mtk: honor DT serial aliases

 arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts    | 1 +
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts              | 1 +
 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts  | 2 ++
 arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts              | 2 ++
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi            | 1 +
 arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts | 4 ++++
 arch/arm64/boot/dts/mediatek/mt8195-demo.dts              | 1 +
 arch/arm64/boot/dts/mediatek/mt8365-evk.dts               | 2 ++
 arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi     | 2 ++
 arch/arm64/boot/dts/mediatek/mt8390-grinn-genio-sbc.dtsi  | 2 ++
 arch/arm64/boot/dts/mediatek/mt8390-tungsten-smarc.dtsi   | 2 ++
 arch/arm64/boot/dts/mediatek/mt8395-genio-common.dtsi     | 1 +
 drivers/tty/serial/8250/8250_mtk.c                        | 7 ++++++-
 13 files changed, 27 insertions(+), 1 deletion(-)
---
base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
change-id: 20260708-ccaione-genio-serial-aliases-e5f2c28b5ff6

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>

