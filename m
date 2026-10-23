Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792740835;
	b=QIKm1wGJWkiYCsvQWLg9V9eWxsvSohqjIxqXtVK0TMnE83rLhJbEpk+jHh3iI18iUH0w
	 RbUg2uop9DvTDmnQ+FPuwmciwy7H9dNA6lSU+4tq0Zo2jYQ+lJpoFaswBCdFs39bTR82b
	 KmnLWzNnOJwZKS3rTqH3ihQyHSCDmwb1DKqvJOpRpvNoHlnZCwETJI/wzrVKoW35I16Sf
	 qFOHKQkJMdA37T0h9VN8o1ZloXTFmr2hzypPUo3SpO9GtiwRpjQZV3BcvNvHGDffwE8NO
	 eD+v70+h6oKGnJY/UlJQpdGvDg4ES6b8im9Qt9WbnooDEGlTG/la0l/BCFN1L89jzSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792740835;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=45to1KyNca3iZWz1ynFCrLebqSO0Gkuz8FnFEnoX6Vo=;
	b=d9anry96XvYkNmKaxZ6aRILQW+7iTAkeu7X4kjz44To/MmFuBJAbrtc7RMkKI6ZN0VOO
	 Iup0ZsQjNsAOidLanKkZeg1pZsGoyrHIAc3o4Wk19JVM9dkQ+iueR8O+EPaLyyhYSBGK0
	 51hU0yt0mApSZVR7A+QiPy/2pWbpUiAER5Bo9UAQHtaeZJZT1FevHguNP+0hjKH5QmBmS
	 Qlha1+wMp0V6FGctNU/ZU59EWmXoLjP1KlXpePhUtj/oXABgms7mltGRPoMMwPdIPTrNV
	 wPO9n6cKsWAgO58C93R6Hswz9WZ8umNyA1BmSDNHg3NJVkBiMxc3Z5DXREjW7gueQCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dyqpZWIE;
	arc=none smtp.remote-ip=209.85.167.170
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B7E606A31B
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 07:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7B7E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dyqpZWIE
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4e4a4d77e5bso1013182b6e.0
        for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 00:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792740833; x=1793345633; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=45to1KyNca3iZWz1ynFCrLebqSO0Gkuz8FnFEnoX6Vo=;
        b=dyqpZWIELTK+QcpV07HE242SRzF85f2oO51gb8podc5WECcr/7BZ178up+12bEBo4Y
         xohK4fPpdON5O+wqd8wi3UoNQ5dalpgpxjHbZZin5mUTOLZbgzg0jovJpN4ICukRhfJu
         mwskBgX6s6uZTFoT7QGOsYdxyK2pQp/AdtwYI/2b9rUUeXwPtRj3BfuJDWr9QugYSIDu
         pUdAxUxcbU+8wwg4vipnVLJOFUrryX4M2HQ/RsyexRiUwMejsd1DwPDukEJjPsiRx2gx
         t1a9o5HJsBnyiplh7sWeC/L+ZKzah8Li84wQ+q3ewBNIWOv4F518JA5WUMciYLFVocre
         2Ahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792740833; x=1793345633;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=45to1KyNca3iZWz1ynFCrLebqSO0Gkuz8FnFEnoX6Vo=;
        b=Hh/LFC6cMnk03x09wiEKRKJ6cV3hi0wU4vTv9pMDUVmk/x9wr0GBOMTpBynVt2fn8H
         qQkEiEK0XzQVdcmbJFJJKp3i3kNpYvX4HfFELYvFShs5VvupVs470/sUfhwVtnYiAg2J
         x2jyCO1MKcCC6Nvl2JGyt/C1ggJnlw74KFXpz5HGc9g4GNy5uT+qckxWXiGXsRvVPiAO
         rQrHyGjY+BS+lqBT+cquGXh5pLEuCeU95T97ZGj3rQyjUPnS3rwhfEtyZwScl1DHimwu
         GK89Q+543Q1RXxwuISwVVZkB7QpkrwYyDWrfRGIKaFAaBKEe7+MPvijim8pyqqoFTn+S
         4xVg==
X-Forwarded-Encrypted: i=1; AKwUvByBvr7PM2q9NPk8VGuc/xkl3T0MHve0ugb2wkS7T2Qx4gILgbSGI8OquflF6fUlxodyOttyWWlH+Ou70Rs=@vger.kernel.org
X-Gm-Message-State: AFq9FYL9FSTRQ82jIA5G9GSGNqosVA8edCvCmem3U5qxVOCoKOOp3nff
	KLsFTLVbfIk8y00jxpNokZyVBuzPPfdvlgbKfM5H1ui3iN/eggCNyLeW
X-Gm-Gg: AYBFou0egIcuy3TPD1BJboFt00f/+ce531ZA38YnmvCnDT+8pyhThoHL2CbmhXyPqHd
	+aagKIRmjFe5FyHI2HqrsTtYEc9Hm7Zsvw0IIAE4u8Df9oPDOIyQz8fkiNuThK90g5OmehwAiq7
	nmz9Dl8DkRxcD2ioGWrBZCT7d4H2gVQtt6CnBGFIHosyjZt+Ger0l104a9NMYD3yBQmU/r1Sbzz
	Bbr24tmx/09teJiQnmclKO6DMP+O6AqbZ8YSvBqwmdZq3XGacQlJviH0+LAPUgMqn4y5zVlWU9H
	+fRoUd/Ewtwc9sHDLO3ksQo/iE/P6vIVjO0YlnoNcNEO3MeU3L/7ZdkRi6bE5I0B2nCriWLpL0w
	2gl+ecTqTctE1t3hyQqcKKHTuomGyoHgoPSUu9rwvUIrN/Tf6IhA96eI5wrIun0Q4Caz9BKXiz8
	cb7eB9dz6ABo70RA8BNTZrZEODMnQdXTjal/03ryUv9o9SPdTuQ4HulF/YUxjODSkThul05gfa/
	VSDcOZIZcO1o6cQ/8j/rz9nkogGw8tQ1i9UHfWEmK+JWjO7MP4tMUdoEtew/RGflFrvjinARMxN
	d1oFNp3fxSrmPQAg273CFasq79AC76jfhPIAbaeFZ1dRL2EenJbyqOaImK8xOh6k/ijyR36yEoR
	1k5l5tetpnLtrL5mGF0+W9xbrer0Bn9L4Z4s0Aqn3JEFJG3r96BFYUm63kFLB2DgvHuKb8POea+
	AjSEc=
X-Received: by 2002:a05:6808:c1b6:b0:4f5:1b84:8cd3 with SMTP id 5614622812f47-557eb4799f4mr2769761b6e.24.1792740833602;
        Fri, 23 Oct 2026 00:33:53 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55be9880a99sm909562b6e.14.2026.10.23.00.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 00:33:51 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH 0/3] serial: 8250_dw: describe the Allwinner H616 UART
 configuration
Date: Fri, 23 Oct 2026 01:33:48 -0600
Message-Id: <20261023-submit-h616-uart-fifo-v1-v1-0-e4a3bae2eba8@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqEMAxA0atI1gbagl14FXFRY6IZGJW2iiDe3
 TqzfIv/L0gclRO01QWRD026LgW2roDmsEyMOhaDM85b4xymffhqxtlbj3uIGUVlxcMiNUFoFG5
 oMFDyLbLo+Vt3/d+l/TDl9wf3/QBuxM/gfAAAAA==
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

Add an H616 compatible and select a fixed port configuration with the
documented FIFO capacity and receive trigger levels. Preserve the
BUSY-safe integer divisor path and keep the UART gate enabled during
termios changes. Attach the existing 8250 DMA path using single-byte
peripheral bursts, with channel acquisition and PIO fallback handled
by the normal startup path.

The patches add the binding, driver configuration and SoC DTS compatible
in that order. Based on tty-next at 1184f87e2790.

Assisted-by: Codex:gpt-6-astra
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
James Hilliard (3):
      dt-bindings: serial: snps-dw-apb-uart: add Allwinner H616
      serial: 8250_dw: configure the Allwinner H616 UART
      arm64: dts: allwinner: h616: identify the UART integration

 .../bindings/serial/snps-dw-apb-uart.yaml          |  1 +
 arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi     | 12 +++---
 drivers/tty/serial/8250/8250.h                     |  1 +
 drivers/tty/serial/8250/8250_dw.c                  | 45 ++++++++++++++++++----
 drivers/tty/serial/8250/8250_port.c                |  8 ++++
 5 files changed, 54 insertions(+), 13 deletions(-)
---
base-commit: 1184f87e2790e8af9be3116f608d2e86b4792d7d
change-id: 20261022-submit-h616-uart-fifo-v1-c5afcdfe5cb0

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

