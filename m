Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393ED63D0
	for <linux-serial@vger.kernel.org>; Thu,  7 Mar 2024 02:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709779697; cv=none; b=EGKY7XUMQj0WPPEonW9PpHVC1MXJCpMz4mHwfM/ojvJN0O0/20I4GQ1Tx1Y7L5pzC2qQR37AhWXYRL1YfcwsFakk5R7LFrL3JtyBPEFG9DNzXAKJvs/X0P8iRLe9Cca31SWJkEQhTUSS4QzbxDFnMP1kA5ylfu62kuy/+iwl9Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709779697; c=relaxed/simple;
	bh=hhQPcz/fQtlI1CdDKR3YuUxD9RPVR+xBl8a8TvjoJj0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dzQKFOnPM4lnoJ+zHlDO3Ury6vbwRbxuFPmB+NSZX0Pb3LaDfH9Hc9HjSnRzUPqTrulSOd6kgrPXBR7BoubS04BINilAe3VNrwkNZeHCtU6Dp1VWGGogKl3wzGpGJ/jr6gsiLNHf9GszZGlQba4HU84L9cQsdDYRaaf1wdTr/fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=fxptnRNJ; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="fxptnRNJ"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-365c9d37995so1005165ab.0
        for <linux-serial@vger.kernel.org>; Wed, 06 Mar 2024 18:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1709779695; x=1710384495; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Z5d/26bHgqiMApGVsGr3aD7SjWMpb6gdnyVYgaIBs8=;
        b=fxptnRNJ/TKEdg4JWbYKq2MRsqi/zofaHHlM/Gd+iX5X+7N1MjvW5NbfgUfABalYSP
         wknfsgXhks8YDmEzml+otWEUEn8Gf64owBHfyXZm8ULdiv7Ibm7GlgYoPw1l/eUN+FWF
         fnmKZQ2WpLDFbp26vgp6muJzBv/RReF4UhwfjHZe5fIXrTfSbNZDxdzc/8Pua727dus8
         q0YoOxGMZHzJb/ta4SmoSIfVccKWC9KI/LjIkf743aljyU7myu3rixL+lA5DKYhJak3z
         weFhDgo634z/+nbu90cmLbWIX4OJRnghQjOe2+ug+VK6A6em0lBerLtzerLNPODL9SeT
         EN5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709779695; x=1710384495;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Z5d/26bHgqiMApGVsGr3aD7SjWMpb6gdnyVYgaIBs8=;
        b=wK2FOb9mLzZqS2dY4elJVbLlV+XzS8LCRF+ZcwFKRm0d88ul89DslxUBI86vlZnxRF
         ocw0WFCqG1ntzuGDbaW1MSzEP7t/d7VcNN8KwGlkHymrLKpZd90TNxAaF1Kqm2z3PFAI
         ax393AQ5EFddyiT/48Bc5aHCUoHyPYNHRWNcnwAp0dr1vIGqZ4EKNrVcB2p2sG5Aon/g
         JCTMArYJiUFGWC+Q786bzzO8Yk3bTYzlsh7sgAyfeIFgjgB/f41j1XuLHxWvfxrRTYfC
         J0Ua3ruHqd5QnexMJxoOMWZxj6+Z08ZtKt8YVZl86ntElpX9jqBxV1x+WmEptYn6FJgt
         GkPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoYbNv6V34mpkOZ5qFy/xTBsKI4BF6kQvs0Q8vdClLLw1AfTJLU4/qA0sJWdonL18qCxeCIrCN4FHyDqd5FuQtPF2henQk83NmGw5y
X-Gm-Message-State: AOJu0Yy9nWpIZ9tb8USSMj3bG1tDUBf65a3kNcAcVzlTTnbyqiAzAabz
	uewuXRDh/9hKotyDBpXuUlOC0oEK8MY4ZsevRDsOUTTwWrhpv2ewzp/D2M5vlhYLqa4GHwwumUG
	t
X-Google-Smtp-Source: AGHT+IEyF0UCk5AncTHMUs17I2OeHhjTtTpuQHRLuE8Gkg6yydzKB2koqNVCqN1HEtdGNtMpZAviXQ==
X-Received: by 2002:a05:6e02:1a6a:b0:364:21b4:f59a with SMTP id w10-20020a056e021a6a00b0036421b4f59amr21762216ilv.14.1709779695359;
        Wed, 06 Mar 2024 18:48:15 -0800 (PST)
Received: from localhost (c-98-32-39-159.hsd1.nm.comcast.net. [98.32.39.159])
        by smtp.gmail.com with ESMTPSA id z13-20020a029f0d000000b00474fc6638eesm1392353jal.76.2024.03.06.18.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 18:48:14 -0800 (PST)
Date: Wed, 6 Mar 2024 18:48:13 -0800 (PST)
From: Paul Walmsley <paul.walmsley@sifive.com>
To: Conor Dooley <conor@kernel.org>
cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
    linux-riscv@lists.infradead.org, 
    Samuel Holland <samuel.holland@sifive.com>, devicetree@vger.kernel.org, 
    linux-serial@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] Inconsistent sifive,fu540-c000-uart binding.
In-Reply-To: <20240304-whomever-gladly-d43da7ad2fe6@spud>
Message-ID: <229b34c1-5419-93ae-0a6f-a21cf4e4a276@sifive.com>
References: <20240304105947.SJcVAdr1@linutronix.de> <20240304-whomever-gladly-d43da7ad2fe6@spud>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 4 Mar 2024, Conor Dooley wrote:

> On Mon, Mar 04, 2024 at 11:59:47AM +0100, Sebastian Andrzej Siewior wrote:
> > | $ git grep fu540-c000-uart
> > | Documentation/devicetree/bindings/serial/sifive-serial.yaml:          - sifive,fu540-c000-uart
> > | Documentation/devicetree/bindings/serial/sifive-serial.yaml:        compatible = "sifive,fu540-c000-uart", "sifive,uart0";
> > | Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.txt:"sifive,fu540-c000-uart".  This way, if SoC-specific
> > | Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.txt:    compatible = "sifive,fu540-c000-uart", "sifive,uart0";
> > | arch/riscv/boot/dts/sifive/fu540-c000.dtsi:                     compatible = "sifive,fu540-c000-uart", "sifive,uart0";
> > | arch/riscv/boot/dts/sifive/fu540-c000.dtsi:                     compatible = "sifive,fu540-c000-uart", "sifive,uart0";
> > | drivers/tty/serial/sifive.c:OF_EARLYCON_DECLARE(sifive, "sifive,fu540-c000-uart0",
> > | drivers/tty/serial/sifive.c:    { .compatible = "sifive,fu540-c000-uart0" },
> > 
> > note that the driver has a trailing 0 in the binding while the yaml
> > description and the DT part does not.
> > The 'sifive,uart' has a trailing 0 where the 0 denotes the version UART
> > IP.
> > 
> > Was this also intended for the fu540-c000-uart binding? Should the 0 be
> > added everywhere or removed from the driver?
> 
> I suspect that the driver is what's incorrect, given there's little
> value in putting the IP version in the SoC-specific compatible as it's
> a fixed implementation. I'd change the driver to match the bindings.

Agreed


- Paul

