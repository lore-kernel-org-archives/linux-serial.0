Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C5813D8A4;
	Thu,  3 Jul 2025 14:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751552020; cv=none; b=LHStHKc6MdngsciY5We1Kpa+ZroUm6HFiIFMwdVLmrnElXnUCmtJtf3KVIoBH9xbAXeNsWA1E8JVJGucSy9GukQ5Z8fsb+whUjqRHn1IY043HhmzoVL9EbERLrOi53yC4nlJloObJNcR7ummndFrzqQu+N4LSXrozwhscuUsV30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751552020; c=relaxed/simple;
	bh=Q2ylaOeBTtuJNcCw5v7aJ6VeP3eyBOiwu7/dJRAIPOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1Z8+7/7JavXgG49gkRTgKj3mt4TEAY1r4UqHRNZufRsaWTtDvG+XVMpfsqqKp+GsMhnpVY/QOnLcJj+hyDNup+b4HQQozydhnDWyfCzRF1PGcdMhjI6ZT4T6VilETueobLAkwKvt50k0zk0mUS/4RvZ+casgODtNbeSHhTgaD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-60bf5a08729so11271804a12.0;
        Thu, 03 Jul 2025 07:13:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751552013; x=1752156813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z18oj+x92MNc/0S9Y8xHuEcemOWJBgJqXoJ/JKjM/Uo=;
        b=dSTREdfd95NhutSreX3l0j4AHIiS6+Qi5FXVdQ9znXMWnSKBEYSfVfVdkvyRc9P1jv
         M3tWBaUjp6oGV2flH+a+xbYuLaxa5aTRAwnWPkMKPICHH+C9BWZ4BW/ezizDnZzgtiOV
         1oUiGvW2HPomg8Lgp6NXFJY/Xjbjmo4ruMYUcVQRGtTonVZPvMfSY0zrSltJ40gaBPDV
         Gz4W9oDaRD1Ch9NlmKT+x9lulW8+JxRWjPrIblxLGOpbNMZk9nAZO+HdyIdIy8+d6ehO
         mKsXo5KEt440hsfPs9w0SsMm2feoVKGTAC90B1XrD8cMJY5D2+OVrQNSUsVwKBMeKmKd
         1tMg==
X-Forwarded-Encrypted: i=1; AJvYcCUVsyXxwVIuTPA0DhJnD6mhnc27WVHanghTyd8DwalQOhE+OubwQT+x6vD9FLVTCc6qcRIqwS1P+CmG/ag=@vger.kernel.org, AJvYcCXrlnj0BbOCuhBdnvzeV8O3B8KY2LkvEXAY646VvdNSngxQpxA7Hiq3q4Do9VcG8wKuMDo2Y/qS7AeYZfaZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwIt4yVGnPZyKFJgmtukLW7FUY5Sk0xgVh3RFRpy48UuP2R47Gn
	cS0zWGIwuer2bWC3EkzJaNjL+f1i1q3eKCUaU0JB/Cr8xbRaybLAWElz
X-Gm-Gg: ASbGnctFzdxJ0k321QcM8Lbujmyu8ltqO06xzRZLuB+Gutcy/UGfsjRXqTEcrc4Wrb0
	in94N1CN6GBGIiiEDr7tKO7rCsS8oJyf+rABq4C8PmJgWduPYbj40LVMlNlF4oDkL9Xz1OdwdmU
	MiMc15oBZzqlc9AzCdORzS5hrQED6wTQIRoG/WoSuP5YBfVJNc9HIAl0Jjb6JwVq6SEyNLVbrMk
	qnTaNATQ4zxwyngZ1dQ/yUomJq3piNSgd8zVsUrQm9Rdo3yF2NCHBIN1K40M/5OuKJi9F4Hdd3v
	sVcLZtjz3W0M3LPz3YJUbQur5A1YbBCPrvpeHFYqcqhAjTXHsBxhCuR1hBZ3ICmnh3jiRO8JV3Q
	=
X-Google-Smtp-Source: AGHT+IG2W4RiEIKOP1cdVrQs5oIBrb+dGkYJvqPdZKRCaRwD1JVKgzL5Mw0lQq3snaidPWHlUSFbZA==
X-Received: by 2002:a17:907:3e8b:b0:ade:32fa:739e with SMTP id a640c23a62f3a-ae3c2a904e4mr715630966b.2.1751552012723;
        Thu, 03 Jul 2025 07:13:32 -0700 (PDT)
Received: from gmail.com ([2620:10d:c092:500::4:6e61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c01201sm1301680866b.97.2025.07.03.07.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 07:13:32 -0700 (PDT)
Date: Thu, 3 Jul 2025 15:13:26 +0100
From: Breno Leitao <leitao@debian.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: cov@codeaurora.org, rmk+kernel@armlinux.org.uk, catalin.marinas@arm.com,
	linux-serial@vger.kernel.org, rmikey@meta.com,
	linux-arm-kernel@lists.infradead.org, usamaarif642@gmail.com,
	leo.yan@arm.com, linux-kernel@vger.kernel.org, paulmck@kernel.org
Subject: Re: arm64: csdlock at early boot due to slow serial (?)
Message-ID: <aGaQBghdAl8VGWmV@gmail.com>
References: <aGVn/SnOvwWewkOW@gmail.com>
 <aGZbYmV26kUKJwu_@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <aGZbYmV26kUKJwu_@J2N7QTR9R3>

On Thu, Jul 03, 2025 at 11:28:50AM +0100, Mark Rutland wrote:
> On Wed, Jul 02, 2025 at 10:10:21AM -0700, Breno Leitao wrote:
> > I'm observing two unusual behaviors during the boot process on my SBSA
> > ARM machine, with upstream kernel (6.16-rc4):
> 
> Can you say which SoC in particular that is? Knowing that would help to
> identify whether there's some known erratum, clocking issue, etc.

This is custom made rack mounted machine based on Grace CPU. Here are
some info about the hardware:

	# lscpu:
		Vendor ID:                   ARM
		  Model name:                Neoverse-V2
		    Model:                   0
		    Thread(s) per core:      1
		    Core(s) per socket:      72
		    Socket(s):               1
		    Stepping:                r0p0

	# /proc/cpuinfo
		processor	: 71
		BogoMIPS	: 2000.00
		Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics fphp asimdhp cpuid asimdrdm jscvt fcma lrcpc dcpop sha3 sm3 sm4 asimddp sha512 sve asimdfhm dit uscat ilrcpc flagm sb paca pacg dcpodp sve2 sveaes svepmull svebitperm svesha3 svesm4 flagm2 frint svei8mm svebf16 i8mm bf16 dgh bti
		CPU implementer	: 0x41
		CPU architecture: 8
		CPU variant	: 0x0
		CPU part	: 0xd4f
		CPU revision	: 0

	# lshw
	    description: Rack Mount Chassis
	    product: <Internal name>
	    vendor: Quanta
	    version: <Internal name>
	    width: 64 bits
	    capabilities: smbios-3.6.0 dmi-3.6.0 smp sve_default_vector_length tagged_addr_disabled
	    configuration: boot=normal chassis=rackmount family=Default string sku=Default string uuid=...

How do I find the SoC exactly?

> Likewise that might imply more folk to add to Cc.
> 
> [...]
> 
> > At timestamp 9.69 seconds, the serial console is still flushing messages from
> > 0.92 seconds, indicating that the initial 9-second gap is spent looping in
> > cpu_relax()-about 20,000 times per message, which is clearly suboptimal.
> > 
> > Further debugging revealed the following sequence with the pl011 registers:
> > 
> > 	1) uart_console_write()
> > 	2) REG_FR has BUSY | RXFE | TXFF for a while (~1k cpu_relax())
> > 	3) RXFE and TXFF are cleaned, and BUSY stay on for another 17k-19k cpu_relax()
> > 
> > Michael has reported a hardware issue where the BUSY bit could get
> > stuck (see commit d8a4995bcea1: "tty: pl011: Work around QDF2400 E44 stuck BUSY
> > bit"), which is very similar. TXFE goes down, but BUSY is(?) still stuck for long.
> 
> Looking at the commit message, that was an issue with the a "custom
> (non-PrimeCell) implementation of the SBSA UART" present on QDF400. I
> assume that was soemthing that Qualcomm Datacenter Technologies designed
> themselves.
> 
> It's possible that your SoC has a similar issue with whatever IP block
> is being used as the UART, but the issue in that commit certainly
> doesn't apply to most PL011 / SBSA-UART implementations.

That makes total sense. Decoding SPCR I see the following:

	# iasl -d spcr.dat
	Intel ACPI Component Architecture
	ASL+ Optimizing Compiler/Disassembler version 20210604
	Copyright (c) 2000 - 2021 Intel Corporation

	File appears to be binary: found 56 non-ASCII characters, disassembling
	Binary file appears to be a valid ACPI table, disassembling
	Input file spcr.dat, Length 0x50 (80) bytes
	ACPI: SPCR 0x0000000000000000 000050 (v02 NVIDIA A M I    00000001 ARMH 00010000)
	Acpi Data Table [SPCR] decoded
	Formatted output:  spcr.dsl - 2624 bytes

Thanks,
--breno
