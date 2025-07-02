Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058BE1A2622;
	Wed,  2 Jul 2025 17:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751476228; cv=none; b=MY5UoxWEsIjyFYfIRBrigRfS7DAa6nInjBeQdGyY1HaqSIQj7DPWB8ZxLU8tPX3O4X/jHLphypVCKYl1MGoqjrOo/f7mKNocEIzE+0LTfCDREzW0TWx3L0F93PikoR7lAJHII5MM1gdjMeFTVXUdMf+0e500wRXXQo2fgXpZY6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751476228; c=relaxed/simple;
	bh=YeWJQeemG7u/ZingmAESBMvieSjH5GEUCp5yLIhOv1g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nniJos13CAR70auAMEbbdAKpFYs6aLj2GES6S5LF6keNrHV5Vqn+oedO5g2g3tbkLoU/DiLCdXIUmhKiYW0gfzxlBM4zuBpDpvnJryUwaSjDliH/FsOSfQlZvui9+w8MH0QNpmvsQpLIZUEXe6ejrM2hjDMKE4wuWKdKlX9T4yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-604bff84741so13070414a12.2;
        Wed, 02 Jul 2025 10:10:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751476225; x=1752081025;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L63cfSvnDXH9DB4EgrgFoF//uYH+DmeGPIriamKHA+0=;
        b=PDH5I7S4U/HhtKt6FGdOP8ONOnm4bQXxEqY/q+BV17HCTTF/Pa1dfEcZIuHh8Etdwx
         +h1ruz341h20TTdDdjh7qpYOI1Fxrk6RSTpJIhKThAqcDEMrUXTYZtAHpbcGvWB1SyHg
         4HUtA9ITyW2hyPcNB5Ue3DvnjWkPMUjMW3ypT774Bm9l57G+8R5REQP2XKhj09MqOifl
         fS336z1dXVtRmj9c1gNQRCczs/U72lvgUoRE4bOtZz0jgJq16zkqdmK3+8gPI2EixwyS
         YyvTOm3bsXwz+XHEZ0LScGIkgIS2y1hepMqJ14zxrgR2UpW/NJ1pzL35HCpg/QwO2TgF
         rLbw==
X-Forwarded-Encrypted: i=1; AJvYcCUJX1sRh7Wcgi9iiXHQOCcNo/dYUygwMV8s2lQrliLqRl9J1fROrucSrKYtQhpescx/6/CfSQfvkq1osge4@vger.kernel.org, AJvYcCVP9cST68OvJQYX/2hSm5vLLZrDGSibnOjU2+avOK/Tt7v1vsipF3+XQforftiZkfQOCOQA3ztbkBgjHnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YylgyLOPQvMkp328M6XTsowRzc+DwLXhcHNY7hFlVrb4cxsh4iu
	ZeXnhaHGGd6medENhwkXlcymdZLJV3vy4tP0iO6LNpq9pHRY/JtdvDqID3/gYQ==
X-Gm-Gg: ASbGncvMFtnsAtJZvD8tvQwIEZIcc16GiiCObcFd3SaetSybI4vuzt0XOWzxhmgQYJi
	OAYkHClh6fIMPHzsJLUE7Ks0D5DrXx93NBKgihacI7ZRalPUealKnuAEfPuHQugrZdmS3fb7PAy
	2+h3EtGdhN5q0E2E/gODh8lXashQ9+lHBv5+NXUZqfxSHywI9U1qsqEXlw2U/yMDKjXDrleaySD
	RS8W2o0OYcSYxyLl7sjZnDrw2UErLuYNCkPP67ApFe776SO8UeB5Cw6n8sB8yqvgq4nqz6EXA1i
	/d/UbhKAlb7M/h/sU/gsazM7SkaeCLP66FTjzEJQqcvZTbRLMWs4Di2Gba1BnaQ=
X-Google-Smtp-Source: AGHT+IGnC3lQFbafqaLA6sanJmrlJcYjRCas5njjZkxtyABSR4KndYWH+LDFo8yq2ojKT8y+ZX4gmw==
X-Received: by 2002:a17:907:e895:b0:ad8:9257:5727 with SMTP id a640c23a62f3a-ae3c2dca4efmr400653366b.51.1751476225007;
        Wed, 02 Jul 2025 10:10:25 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35365a75fsm1112854566b.67.2025.07.02.10.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 10:10:24 -0700 (PDT)
Date: Wed, 2 Jul 2025 10:10:21 -0700
From: Breno Leitao <leitao@debian.org>
To: cov@codeaurora.org, rmk+kernel@armlinux.org.uk, mark.rutland@arm.com,
	catalin.marinas@arm.com, linux-serial@vger.kernel.org
Cc: rmikey@meta.com, linux-arm-kernel@lists.infradead.org,
	usamaarif642@gmail.com, leo.yan@arm.com,
	linux-kernel@vger.kernel.org, paulmck@kernel.org
Subject: arm64: csdlock at early boot due to slow serial (?)
Message-ID: <aGVn/SnOvwWewkOW@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello,

I'm observing two unusual behaviors during the boot process on my SBSA
ARM machine, with upstream kernel (6.16-rc4):

1) A 9-second pause during early boot:

	[    0.000000] ACPI: SPCR: console: pl011,mmio32,0xc280000,115200
	[    0.420120] Serial: AMBA PL011 UART driver
	[    0.875263] printk: console [ttyAMA0] enabled
	[    9.848263] ACPI: PCI Root Bridge [PCI2] (domain 0002 [bus 00-ff])

2) Occasional CSD lock during early boot:

Intermittently, I encounter a CSD lock. Diagnosing this was challenging, but
after enabling PSEUDO NMI, I was able to capture the stack trace:

	printk: console [ttyAMA0] enabled
	smp: csd: Detected non-responsive CSD lock (#1) on CPU#0, waiting 5001000000 ns for CPU#02 do_nothing (kernel/smp.c:1058)
	smp:     csd: CSD lock (#1) unresponsive.
	Sending NMI from CPU 0 to CPUs 2:
	....
	pl011_console_write_atomic (./arch/arm64/include/asm/vdso/processor.h:12 drivers/tty/serial/amba-pl011.c:2540) (P)
	nbcon_emit_next_record (kernel/printk/nbcon.c:1030)
	__nbcon_atomic_flush_pending_con (kernel/printk/nbcon.c:1498)
	__nbcon_atomic_flush_pending (kernel/printk/nbcon.c:1541 kernel/printk/nbcon.c:1593)
	nbcon_atomic_flush_pending (kernel/printk/nbcon.c:1610)
	vprintk_emit (kernel/printk/printk.c:2429)

On reviewing the amba-pl011.c code, I noticed that each message being flushed
causes the following loop to iterate roughly 20,000 times:

          while ((pl011_read(uap, REG_FR) ^ uap->vendor->inv_fr) & uap->vendor->fr_busy)
                  cpu_relax();

Tracing this, I found that flushing early boot messages is taking a significant
amount of time. For example, trace_printk() output from that function shows:

       swapper/0-1       [000] dN...     9.695941: pl011_console_write_atomic: "[    0.928995] printk: console [ttyAMA0] enabled"
											|
       											-> This is trace_printk of wctxt->outbuf

At timestamp 9.69 seconds, the serial console is still flushing messages from
0.92 seconds, indicating that the initial 9-second gap is spent looping in
cpu_relax()—about 20,000 times per message, which is clearly suboptimal.

Further debugging revealed the following sequence with the pl011 registers:

	1) uart_console_write()
	2) REG_FR has BUSY | RXFE | TXFF for a while (~1k cpu_relax())
	3) RXFE and TXFF are cleaned, and BUSY stay on for another 17k-19k cpu_relax()

Michael has reported a hardware issue where the BUSY bit could get
stuck (see commit d8a4995bcea1: "tty: pl011: Work around QDF2400 E44 stuck BUSY
bit"), which is very similar. TXFE goes down, but BUSY is(?) still stuck for long.

If I am having the same hardware issue, I suppose I need to change that logic
to exist the cpu_relax() loop by checking when Transmit FIFO Empty (TXFE) is 0
instead of BUSY.

Anyway, any one familar with this weird behaviour?

Thanks
--breno

