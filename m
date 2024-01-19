Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD584F88D
	for <linux-serial@vger.kernel.org>; Fri, 19 Jan 2024 11:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705664131; cv=none; b=mJJyAeo9E+XYonPdWNTxS3IeLeC3Tsjb31P4zyQjqVOQnD1oTI/7xS8UdbVYEZJSnD2vsOKc/cdYQeZZ+IK8G9WeSU+hYcz/efQk2Z4JTaWgOKpWrQdEXZgfOVQ/j2UPj6Ft8ZCJNLLO8DzEV6SzE4lLR43a1S8lwMCmHZjtT6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705664131; c=relaxed/simple;
	bh=fqqDjN66329pa4niMWl6MkhJrFW850wjJ+KnOw48Ihc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dQRTiT8H3f/cAk0Ml4OFt986C+UOnkl13R/v+IDJrPdvPd6RFGTtzPUOCEMqrkY9cqFfy6fscfsUIcj4hHP0V2Eedzrsksdr47oXAEfEcLKtWGwIskKPVQjZZ5gSS3RbyY5jPSsegT8yWXV4GB+CyHCkIPW/s/aJKwJpMrKEnmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=mbi9StrE; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="mbi9StrE"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-36091f4d8easo2130295ab.2
        for <linux-serial@vger.kernel.org>; Fri, 19 Jan 2024 03:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1705664129; x=1706268929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9bsP20n9g/LbbgzyTFqfc2H9X3ZVkLkHm6HS5kmWZpw=;
        b=mbi9StrENwn6XzzWy1BiKRt2MrZXI0FQNYiBXiqntu4B3GBqLg2ACdEkuni/HKDOh7
         xeHFb3EQ4WlP3gnlHxkvuLUeAnOPm7oBkcm2mR89JAIeBONVVYYMPaOT1s5m/dIVWmIO
         pguQv9lZ8KL+hld87j1xwIhhVTu1H6fBpSwC5CqNVHNT4qPb4gbFbihbHt30CbSeU1/K
         HAhwSrunwR1C6rvad4H0JDq93r6wWQpJ+Bl6Ms0U7xYYR5s2DDyV3FZ54ejnHy26fyuC
         d+eaaLcjyrkCIMaGGyiuHge4Fc6Vx61+LiM2GzvOnasu+Bt2JbhG3G63Z4dP0jSHW/Gf
         1Xkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705664129; x=1706268929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9bsP20n9g/LbbgzyTFqfc2H9X3ZVkLkHm6HS5kmWZpw=;
        b=VFWWKCbTk9fq5QIm2pSFXyTjuxouIz68AePvOELGub0udX3mPiEE1WnRo/BOezp5id
         RahjO8VQ8NmdQXpfcTmcK2K7XjkSBBR6OTb5HVOxmfiWdcct8R4PW26WUnmju+n78PHc
         IiR5HDmgpWTG1JAJsSP7go34Bgv/qab9/qj8pbv5zfHvOlorvO1cQuRPQmAzcW4g+S3U
         n5gnKscJf4zn9Q9BpZd+Ca/S73Qz5UIWLl0H9fQPPpn6hxBI/x/y2rybjwWKU+ZLd3SY
         dLAyMGpoUMFaNh1CMZqEjK+cdAZviuu5FetMsjGmMSAS4ePK6spMxmXMjfU7W8FkdIyn
         Rj4w==
X-Gm-Message-State: AOJu0YzPC46kY4HqFazHoGt+afNfxZhJmWzwj0sJYmy/awh4PTlQIdZI
	VK6udL6aGSP2WnEU9cpAMvonDkffUo3WoYLJyqjs7nemYOJdxCLMrcqDQh9a/AE=
X-Google-Smtp-Source: AGHT+IGm7KnfG4/vcA0JrRBkZfX6RoyXH3aaqdl/Wta7fnqjAcw1zMCsGIqUf/hTovepwm0OqOzh9A==
X-Received: by 2002:a92:7310:0:b0:360:973b:844b with SMTP id o16-20020a927310000000b00360973b844bmr2368211ilc.11.1705664129602;
        Fri, 19 Jan 2024 03:35:29 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id a5-20020a92a305000000b0036062f40c51sm5347302ili.71.2024.01.19.03.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 03:35:29 -0800 (PST)
From: Anup Patel <apatel@ventanamicro.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Conor Dooley <conor@kernel.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	linux-riscv@lists.infradead.org,
	linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v6 5/5] RISC-V: Enable SBI based earlycon support
Date: Fri, 19 Jan 2024 17:04:49 +0530
Message-Id: <20240119113449.492152-6-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240119113449.492152-1-apatel@ventanamicro.com>
References: <20240119113449.492152-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let us enable SBI based earlycon support in defconfig for both RV32
and RV64 so that "earlycon=sbi" can be used again.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 905881282a7c..eaf34e871e30 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -149,6 +149,7 @@ CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_DW=y
 CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_SERIAL_SH_SCI=y
+CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
 CONFIG_VIRTIO_CONSOLE=y
 CONFIG_HW_RANDOM=y
 CONFIG_HW_RANDOM_VIRTIO=y
-- 
2.34.1

