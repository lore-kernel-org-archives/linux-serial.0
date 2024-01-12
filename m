Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1911BA5E
	for <linux-serial@vger.kernel.org>; Fri, 12 Jan 2024 18:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="mmkNwBh+"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3bd6581bc66so265748b6e.1
        for <linux-serial@vger.kernel.org>; Fri, 12 Jan 2024 10:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1705084238; x=1705689038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1y9RFKMR0FSPqYNNO9hPu+QHh0esMWSorBv6pzr/qFM=;
        b=mmkNwBh+NozHzf6PRcy5xxx6nQGPfr8Q1FX10zy+uqAaCRPCs3P+Pps/t1dXRJWR0l
         9Rj5PAtYF6zkd/EfD8Qu+T4Vi0L+MDT2s1ne61216E68YVrSa+6GqpvT2CaGlqmFNpT+
         NSiccl9fV9WFUFV4GReFODlGYJWlaE0fEi4xP2rob5+YQjFl3en/ZWVfcBTnwEqKgIjf
         hLF/9kKk+SJmr+MEdyc5FG7EGnFtIWOqtGaEUadtFoWVwbGQDK/EorePa6ZhPmgryf3h
         Jq+rImIK7hm1ceawLy3XYXu4HhqMogrFUFCstJaNd2Ku7JlEVImemIkaWtNQ7xpnTXYB
         OZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705084238; x=1705689038;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1y9RFKMR0FSPqYNNO9hPu+QHh0esMWSorBv6pzr/qFM=;
        b=nSVBlx7h+5S/pX7kcHbbO4dUq7Ft6LloSYeyrY53bnhvxkbLbR5YtcIViK0gM8aQeD
         P0rJ9D9B9CgQAfRGiFYB+gtpwxkTJaANb843jZJXSXWS3oNArkGfZGk0KApp4ktxFQb1
         1f1PWiqK7/rxDYGEvgM/NtogcSU+hxakGlIYucKHEXpNEFWGGm+rcFw/r05207JSAMLC
         tnJwzZm/C/e6b0kxIPug6d3hrnrBGrgX6KZElBxYJ4mNANF8WuLZ14y23PbyYqfOoz6R
         Fa4j2AT0UewyhlsvPCbNLUMb/D63P0YtZaBq3a7Swu9WCe+l1l6awxVptyxZm0LCnQuC
         TUpg==
X-Gm-Message-State: AOJu0YztUH7AaHOB/lU+9RS8/vWMZxwDrMpmWQCHPY/0ZaHAGSrMuJIN
	szitCD2CDnlDlUSJXYyTgB1Mgzg/MTBPBA==
X-Google-Smtp-Source: AGHT+IF1BUZm9MFACP928AtwGap6NZre7MHtBSqet5vC3dqPxL0czPLn7Q0DKWE2Rm3d/VpIQYiTIg==
X-Received: by 2002:a05:6808:3a14:b0:3bd:5f84:b599 with SMTP id gr20-20020a0568083a1400b003bd5f84b599mr2083047oib.109.1705084238187;
        Fri, 12 Jan 2024 10:30:38 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id n17-20020a0568080a1100b003bc144dc4f5sm669050oij.1.2024.01.12.10.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 10:30:37 -0800 (PST)
Date: Fri, 12 Jan 2024 10:30:37 -0800 (PST)
X-Google-Original-Date: Fri, 12 Jan 2024 10:30:23 PST (-0800)
Subject:     Re: [PATCH v5 0/5] RISC-V SBI debug console extension support
In-Reply-To: <170498463783.20080.10723421328706946354.git-patchwork-notify@kernel.org>
CC: linux-riscv@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>,
  jirislaby@kernel.org, Conor Dooley <conor@kernel.org>, ajones@ventanamicro.com,
  linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: apatel@ventanamicro.com, Greg KH <gregkh@linuxfoundation.org>, nathan@kernel.org
Message-ID: <mhng-2a34d0e2-170f-47a5-a688-ab454a70f06b@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Thu, 11 Jan 2024 06:50:37 PST (-0800), patchwork-bot+linux-riscv@kernel.org wrote:
> Hello:
>
> This series was applied to riscv/linux.git (for-next)
> by Palmer Dabbelt <palmer@rivosinc.com>:
>
> On Fri, 24 Nov 2023 12:39:00 +0530 you wrote:
>> The SBI v2.0 specification is now frozen. The SBI v2.0 specification defines
>> SBI debug console (DBCN) extension which replaces the legacy SBI v0.1
>> functions sbi_console_putchar() and sbi_console_getchar().
>> (Refer v2.0-rc5 at https://github.com/riscv-non-isa/riscv-sbi-doc/releases)
>>
>> This series adds support for SBI debug console (DBCN) extension in
>> Linux RISC-V.
>>
>> [...]
>
> Here is the summary with links:
>   - [v5,1/5] RISC-V: Add stubs for sbi_console_putchar/getchar()
>     https://git.kernel.org/riscv/c/f503b167b660
>   - [v5,2/5] RISC-V: Add SBI debug console helper routines
>     https://git.kernel.org/riscv/c/f43fabf444ca
>   - [v5,3/5] tty/serial: Add RISC-V SBI debug console based earlycon
>     https://git.kernel.org/riscv/c/c77bf3607a0f
>   - [v5,4/5] tty: Add SBI debug console support to HVC SBI driver
>     https://git.kernel.org/riscv/c/88ead68e764c
>   - [v5,5/5] RISC-V: Enable SBI based earlycon support
>     https://git.kernel.org/riscv/c/50942ad6ddb5
>
> You are awesome, thank you!

Nathan points out that this has some semantic conflicts with a patch in 
Greg's TTY tree: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/commit/?id=f32fcbedbe9290565e4eac3fd7c4c451d5478787

So I think the best bet is to wait on Greg's patch to land in Linus' 
tree, and then base a v6 of this patch set on that merged patch.  I'm 
going to drop this one from for-next.
