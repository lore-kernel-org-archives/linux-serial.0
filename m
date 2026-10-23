Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792790372;
	b=HrPbb2FKm08ByrkL1piFsK4zdSZqt20Tar6I5wMfYH6D0J0umlhZevdCb433lLMCqqbE
	 MUymn9mWr+31QA8lhxFXdUx6ygHzsiath2wDYbnK0zXl94/MCUOYKSeyr+zz+HeSsyKW0
	 6oRKsi8ozE9XjJcT30S2iTUb42wSismJodN3g2+TU2Ye7Wn0vOB8zxWZ+/zWq859QsEqS
	 6+S54SHk10MRQ9EeWpYDvkghdaHDWzGPyKivMRRbGMZ+GGuSXlFxN/oFvBWG3oZCpEEtb
	 aP3i3ly5t/FaU4qEDfIwbbkjtVuZnqWYtm6s5JAw6kLIeaWYJT8PJaV1hygPHOyMeuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792790372;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=t/OVPwISYIuAdc7Q10pLScYKXWaZFmDPlbXzHuMOEjM=;
	b=1KzWX/x1h0eRaWVpdoZU0dZ7XnWXVnEVRuvLbfyXAqzBqE92lXTkrp+btxhHeZFuqCXD
	 T6M4WiurpEZz/P42FXaYj+a8vwef3QuvcfUcN+pNpGiQ2olP6P+3IBF5SjThZD6euubaL
	 JT6qGTHoo78TrrTEwm6bPVrhuaft+Taji+nU+1GKnCV2uxi3UwoQYFqxXFEMENPxpd8n9
	 nz1KgL9eQknrsknY79aqTHT6Cbgi9kSTrt/rqOa9qCkzyYtS8cJUQDnakYkaZxlbCFiMq
	 vSRpT49aM8AmBIvYMVjyGL2NC4byyURidIzrCkI3k60PX2DQ5Aeta2oKZrdsEmH0ofA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dw13DzYr;
	arc=none smtp.remote-ip=209.85.210.54
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7895606A31B
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 21:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7895606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dw13DzYr
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-8439fe796ebso826760a34.3
        for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 14:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792790371; x=1793395171; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=t/OVPwISYIuAdc7Q10pLScYKXWaZFmDPlbXzHuMOEjM=;
        b=dw13DzYrYenFb1Aw6eabG9lwOCkwfgxYO1noCm1cGs6zt3beK9qZ7/nz+Qhjd+TEpQ
         KWBMP0at5VLP/r3hrcxHrwVIPg+mBzRjeiz2QOG3eQi0jE+Wn+c51yhFHelZq0n5ZQ6q
         9uU+dc1OCWYhpLrkXZi2CbsCl3CK+6VgaufVYJxyUwRD1D9PZ5JSp9QHN9ymgLvYPGZM
         2Adc5LvLyGjeHe2Q9dhS30GGcNaX6TkADym8UNTV4qTWfh6NCy3GBdUtFjJLSTnacZKY
         jeqnBvsjrdfM4HYJpsFsDpgepO/xjtkGRh5XP+viwr+ArtGkeYo68yJrGQCGr5T+hx5I
         i7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792790371; x=1793395171;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=t/OVPwISYIuAdc7Q10pLScYKXWaZFmDPlbXzHuMOEjM=;
        b=ZvO8LjoOx4JTp948o7yv0linX9uOrEbhKVVTHlMTS6qlaRKc85vrz3KqRhlxOiTyqD
         WVuUiDWlxV4pEUeaZ463m3xl4PwVmHl6woWDD2VLbtpnB8AOCGWusyfEEjQldtBdrBRb
         k83stLfH9DuCicYSyh987xQNXMe7hGs360jq1As6UzbY5MsfcxZzYGdg4mrhT8SmPoCv
         06E3FlKyKjteIzlxIaEJQh1iQILHJHFcEOoWx4wIGTCXHqdCnhWsNx+rliM3fkMjBpAI
         fH3xeRNqUHJCiKD33vmOfYXHhvmv6BkHX+21sNlPTxtal4lWFn5WIebPWpBtOH8Hdbg5
         bitw==
X-Forwarded-Encrypted: i=1; AKwUvBy3bE38s657nw+b7g/dwwKdwtdgF89okoD5p1V/3OIvMHZP6wKr/a5KVAwQ5uGDndo9uR4gOBrzzMlBx6A=@vger.kernel.org
X-Gm-Message-State: AFq9FYK7UEZL4PBFiAvZ59YNgNYRHuUPAP5g2aLocQQaqn4Mcxdwl5uE
	xVo/XShXwMo2Q6AmUMMhEqjkwtDxsEzS4nxYp2bqrcodn0KklgXIuIKy
X-Gm-Gg: AYBFou0zNwZ2eKqAExsEnbZ0MQbtjpA6mDS/U30rlXoS1Rl9Bmd1SdeSdE+rlGHG5as
	22/RzuphXil6WEQjbaSN2zStpGgyapeaxHtVKa918QIShxNtV4E5Ij2QxvrXzaBtuB9V5HNoPTH
	k+L8AHTHh3n8NUa4jZUOlDuow7zpc13uoCDzuSYFsAmIFwFPaxEgFo6UD8Ct12a3Y15ejpX7Pgg
	UlD1opb1EeIVenXHEGeThqWRrzmbWKOaoCd78JTHL0qtVWtHy2qBRskX41BTjj4Vm2nMwomyg/g
	mzLVdqdNFiOEBuwrm5Y3X4ie9G//d0nvQ4izCGgJOmLFmT0VaguPmgUd4QLOk7LHszKh+DOrbQi
	+T7f9W1ABca0YsqktaiQvLf8LPBtgJ/eHgMtIea37BCBXHCv6ioB3AEHENzwYZ9RaFhQsbpLyjV
	BDdzJ1e4vcixfDMZlFPMbd3Imq9/7IQWtqfAABHjE09II6FY0RcrFpTrrDQw0RwwmL9Spvw0ZuC
	ygnj+ixgnbjT+7JcDqBgzL16TTqTSeXLvrCWLhJKvQHHELo1cJGyEfKsmBa3dHsgybP2yOBJXoV
	wCHdKE5AkfUHvzAIPrjcOj71Plt8J5sXJRYL2fZpON4sKHANAdUyKFoHaFaYi3XHycugGHzt3Vp
	y2ZkCfF6R7MhWq5I8C5ZrkSAGDiP+p7hRqN/aK5ZgpRBcmthYEl3nsi6b9Jdgs2VmyYhhnRe7MO
	7mzQ==
X-Received: by 2002:a05:6830:44aa:b0:845:3cfe:608 with SMTP id 46e09a7af769-850f7f763b5mr662878a34.0.1792790370828;
        Fri, 23 Oct 2026 14:19:30 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-850f8458d8esm565721a34.1.2026.10.23.14.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 14:19:30 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v2 0/3] serial: 8250_dw: describe the Allwinner H616 UART
 configuration
Date: Fri, 23 Oct 2026 15:19:26 -0600
Message-Id: <20261023-submit-h616-uart-fifo-v1-v2-0-af0593504635@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WSzW4bMQyEXyXYc7egRImUcup7FDlI/Im3aOLWd
 oIWQd69tIMetkCBvRCrb4Yz0ttyttNm5+X+7m052et23o7PMeRPd4scxvOjrZvGvGTIlCDn9fw
 yn7bLeqBE68s4XVbf/Li+plXqcFG3KhOWwH+czLdfN+mvDx9zsN9MLle964nDdr4cT79v3q/pe
 u6vDf7fJj5YrQycw7LN0b48Po3t+2c5Pi0P7x8+J/v5EkkuH+bLHGdb438IRjIYiEKTZBpbaVD
 VY1BqLVFHLgXHSKXdIoyLHKKA+zsl7K0UpsJjgM4JUGc10lAanYxKNh+N9pQTS/KmTbtBKiJUw
 bNjyDSiXBAEJ/PcU63m3LipFxMtHlYsrhjFJKzdyGZtI5nvqa7uNQH3KVUxlsnduPXBgg6lNWn
 JKzPuKRtpdPfJXQujskYJKc3J4eWS0yRUYfxnQyuTmBxqyb2SIoQ5qCZqyhFMoBp2qmNPVcjKZ
 rVL5EfrOZo0FshdZCIbUayOXfdUSgDxINg7QEi7DvbEUT+kuEkoKTP7mLKnUKRJmg08RZ0aN5R
 nZRNW6MM7VitSEo54Mu9/AE2U8xkEAwAA
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

Add an H616 compatible and configure the existing 16550A port type with
the documented FIFO capacity, receive thresholds and automatic flow
control. Preserve the BUSY-safe integer divisor path and keep the UART
gate enabled during termios changes. Attach the existing 8250 DMA path
using single-byte peripheral bursts, with channel acquisition and PIO
fallback handled by the normal startup path.

The patches add the binding, driver configuration and SoC DTS compatible
in that order. Based on next-20261023, which includes the TTY changes and
A733 DMA register-layout updates, with the posted IRQ-safe locking fix [0],
pause-bit fix [1], virt-dma synchronization helper [2], and sun6i channel
lifetime v2 series [3] applied first. The sun6i pause bookkeeping lets an
8250 RX flush account the paused transfer and release its running state,
including when it is flushed before the allocator starts it.

Apply [3] with git am -3 on this base to combine its tx_status() changes
with the intervening NULL-descriptor cleanup.

[0] https://lore.kernel.org/r/20260926171049.841335-1-tien.nguyenminh@embeddedlinux.blog
[1] https://lore.kernel.org/r/20261021-submit-sun6i-dma-pause-bit-v1-v1-1-38d286b69dab@gmail.com
[2] https://lore.kernel.org/r/20261022-submit-mtk-uart-dma-synchronize-v1-v2-1-fdaef0e2edd6@gmail.com
[3] https://lore.kernel.org/r/20261023-submit-sun6i-dma-lifetime-next-v1-v2-0-c9e07cc44bf8@gmail.com

Assisted-by: Codex:gpt-6-astra
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
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
James Hilliard (3):
      dt-bindings: serial: snps-dw-apb-uart: add Allwinner H616
      serial: 8250_dw: configure the Allwinner H616 UART
      arm64: dts: allwinner: h616: identify the UART integration

 .../bindings/serial/snps-dw-apb-uart.yaml          |  1 +
 arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi     | 12 +--
 drivers/tty/serial/8250/8250_dw.c                  | 87 ++++++++++++++++++++--
 3 files changed, 86 insertions(+), 14 deletions(-)
---
base-commit: 20a33c6b6cbe7e4805dfb6cd68816937443aa148
change-id: 20261022-submit-h616-uart-fifo-v1-c5afcdfe5cb0
prerequisite-patch-id: d6398447647aa0dbb005b5e6dc6ba96e642efa86
prerequisite-patch-id: f67c1f8d8d9e014cc650f2f37648662430c3b77b
prerequisite-patch-id: 8522878df4ecd4fb007cfd32611359e6eb58a1ef
prerequisite-patch-id: 9dff51079bc5d3efa29e789a7c3f0488c81f5773
prerequisite-patch-id: ea1a9ffb79d473d7d81611bb7113fc21b63dc73b
prerequisite-patch-id: e4b676f0542956d309df0dd168d7866c05e3965a
prerequisite-patch-id: 502d7ee59c7643e92aa0e7c029ccb37e66bc539d
prerequisite-patch-id: 11000237f90066cfda7f17005010a3041277fabc
prerequisite-patch-id: 3cc8c1b80f1852d96e2b57ec7d09af935e4c413a

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

