Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3FA288528;
	Fri, 11 Jul 2025 10:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752230715; cv=none; b=kkDp15SQP8uXbko2fMzn4n6JNNcK3sE15bUgdswatkcm4lGJSFSD5u2mvj2QfF32dWUzbjnRA5M53Oz9RvX1/5gzptO88MMzsZdz8ePlRL5lsKnwIDysV//g2TpK2nHtYqEKIzwxFvNXinG8hnhHhsFvdfTn6K/ksxQqHtr2qS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752230715; c=relaxed/simple;
	bh=0l28Px7R8xaO1KryvrB3s+snvnmMB+xnv79zUdB2cvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=md084rMx0/iupbZyJq7zGlbqUEAUPSHn76u4IErJPZEj6WmbxSs9FanQHm3mLtAeNfju+a3M81ND4/If4PdR81V/9/BxpBqJfr2/aJDJZ47fuaoy5MBwlRr8YG6Uh+Ucu/o+5sKsVFqP3HiA4feg9tdlxdxHF8kWfcrQx0HKY9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-60c01b983b6so3749916a12.0;
        Fri, 11 Jul 2025 03:45:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752230707; x=1752835507;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wqe2V2FQ3vs0VDZ5V0wJHCGKzcLhMMVXArsFnuE7xuI=;
        b=syYESan5j+UYcXmPezs1VUNSKrN59dToIGkmEGjG4Xtl1XUz9xgrCfu56qCZhDOLxw
         t5Ki4zjEfchF3ZR4mg2LK0VKYd8uPgChQrr4mcJTlC0bxZ/FkATI1pTXU5ZHHtGuMETB
         6DIYf9MQN/lxTK7P+nwJfsgRErtK+hSfTQV2qTpPh5pbx042n+SqwcmQqYQTgd83LZHW
         5sdATV3jDRbsAJ/Q1PEPziE7izd8zU5GQgtVBKtROLeeq4erwu6n+zEkEodcF68jVkm6
         5hJQEswhjmfew7bcKFB6KRAfLLQtJ5p06ntyh3jNPM6qMXgPTGkDN8LgTQh3bdRwq2Xe
         FITA==
X-Forwarded-Encrypted: i=1; AJvYcCVMfoJVKawZIEwuG6HoOYQ8HashBxPF+O0Lz9pEajyMNuzEuokKj90wHOYGy91odO7M+agDK17lEwSUc+1a@vger.kernel.org, AJvYcCVsogKEeUpmxf5pxh2OEnUTiIj43CVoKZVQF2Hc2wuopBW1MuIn9cKdE0CEmWZeWDT+U2yNWatnUXYFRmw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7tZd8xq6U3ReOhloNqCh1Vrl7laePJUApLs49PHMeBbF1UyHv
	yArXNbdxke2lI7BT0M8HdbSNzuKSwPptO9zj0WppvJXdI37y8fI8a42K
X-Gm-Gg: ASbGncuTb1WVNHFAPcEfjFyQ02uGODgbrTa4CJAK3Mqr6GAv26w9RZNYjxB5MuEtaOv
	zZmynVzOMNErLAbVH6QgGWOEfdbm9g68wJ+Lq0rWagc43K8F+hyEZYTOlvXUBx2I3rc1P25xNgi
	ZN5Exmp0Jbpq6zgfyXRF7RHBq8QK18RfbouN0F/duOkzqRZ6hGDBcy+7u6+1EDpLrr1pWnBdJ1A
	gBYnvlFgDi2cg9+V9sOdQsRws8Unxo9oFzPv3teBB1bJmL0+XX4bT75M6DehPE7Bzm+E4iZRSx/
	WpYcc/VazsjwjRIpX9W6VIb3vF4VuGj9jJZPM6XPpBxdHnqkfW3YQSXgROV1MwQTqz3TgV8JSy0
	IRW7Ct6T07Kp7
X-Google-Smtp-Source: AGHT+IG95TjqDu1gHCuIdkjxrSl2DNZ5fJVRFAP9SkKuRN/XnM3t9hcjqg0dzi74FNM6iE0HoZM94w==
X-Received: by 2002:a05:6402:4407:b0:600:129:444e with SMTP id 4fb4d7f45d1cf-611e624f8aamr2478843a12.4.1752230706500;
        Fri, 11 Jul 2025 03:45:06 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c9528b05sm2028651a12.30.2025.07.11.03.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 03:45:05 -0700 (PDT)
Date: Fri, 11 Jul 2025 03:45:03 -0700
From: Breno Leitao <leitao@debian.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, ankita@nvidia.com, 
	bwicaksono@nvidia.com, rmk+kernel@armlinux.org.uk, catalin.marinas@arm.com, 
	linux-serial@vger.kernel.org, rmikey@meta.com, linux-arm-kernel@lists.infradead.org, 
	usamaarif642@gmail.com, linux-kernel@vger.kernel.org, paulmck@kernel.org
Subject: Re: arm64: csdlock at early boot due to slow serial (?)
Message-ID: <cno3lsprrz36gqu27omvwrw27d2ubqtshac3cahfgkhcm2rla7@bpnulcmsyx2u>
References: <aGVn/SnOvwWewkOW@gmail.com>
 <aGZbYmV26kUKJwu_@J2N7QTR9R3>
 <aGaQBghdAl8VGWmV@gmail.com>
 <aGawTd8N2i8MDCmL@J2N7QTR9R3>
 <aG0kYjl/sphGqd4r@gmail.com>
 <juiog3337iozva23zpf4apdydegj4z7jibqykfvcgnkabemw4w@z5g5hhwrqr2w>
 <20250710133557.GA1093654@e132581.arm.com>
 <jlhgtwkeezoca34wbqipvsgr4muxov5wmgrswleo2k7zqitzfr@4ngriyb2udra>
 <20250711095023.GB1093654@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250711095023.GB1093654@e132581.arm.com>

On Fri, Jul 11, 2025 at 10:50:23AM +0100, Leo Yan wrote:
> > I've reverted commit 2eb2608618ce ("serial: amba-pl011: Implement nbcon
> > console"), and I don't see the CSD locks anymoer. The serial speed is
> > the same and continue to be slow, but, the CSD lock is not there. Here
> > is the time spent on the serial flush when reverting the commit above
> > 
> > 	[    0.309561] printk: legacy console [ttyAMA0] enabled
> > 	[    8.657938] ACPI: PCI Root Bridge [PCI2] (domain 0002 [bus 00-ff])
> 
> From this result, we can know both the atomic path and the thread path
> take a long time polling.

I am wondering if this slowdown is by design, or, if there is a bug
somewhere.

> Since both paths configure the UART clock, I'm curious about the
> behaviour if the UART clock is untouched. The relevant code is shown
> below.

Is this the clock frequency that is connected to pl011 coming from AMBA?

> I may seem a bit stubborn in suspecting a clock issue :) But if you
> have confirmed that a standard pl011 UART IP is being used.

How do I double check this is a pl011 UART IP or if this is being
emulated by firmware/ACPI.

> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index 71482d639a6d..b04773ba2602 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
>
I've tested it, but, it seems it didnt' help much. here is the full log

[    0.000000] Booting Linux on physical CPU 0x0000020000 [0x410fd4f0]
[    0.000000] Linux version 6.16.0-rc5-00056-gd7753fd13f9e () (gcc (GCC) 11.5.0 20240719 (Red Hat 11.5.0-5), GNU ld version 2.35.2-63.el9) #86 SMP Fri Jul 11 03:25:52 PDT 2025
[    0.000000] random: crng init done
[    0.000000] efi: EFI v2.9 by American Megatrends
[    0.000000] efi: RTPROP=0x4053fee418 ACPI 2.0=0x4044bcb018 SMBIOS 3.0=0x4053fe4018 TPMFinalLog=0x4042b50000 MEMATTR=0x404d4f3018 ESRT=0x404f943018 TPMEventLog=0x4042857018 RNG=0x4044bca818 MEMRESERVE=0x4042854e98 
[    0.000000] esrt: Reserving ESRT space from 0x000000404f943018 to 0x000000404f943078.
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x0000004044BCB018 000024 (v02 NVIDIA)
[    0.000000] ACPI: XSDT 0x0000004044BCB098 00012C (v01 NVIDIA A M I    00000001 AMI  00000001)
[    0.000000] ACPI: FACP 0x0000004044BCAE18 000114 (v06 NVIDIA A M I    00000001 ARMH 00010000)
[    0.000000] ACPI: DSDT 0x0000004044BC4018 001EC9 (v02 NVIDIA TH500    00000001 INTL 20220331)
[    0.000000] ACPI: FIDT 0x0000004044BCBF18 00009C (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: SSDT 0x0000004044BCBB18 00015E (v02 ALASKA PRMOPREG 00001000 INTL 20220331)
[    0.000000] ACPI: SPMI 0x0000004044BCBD98 000041 (v05 ALASKA A M I    00000000 AMI. 00000000)
[    0.000000] ACPI: FPDT 0x0000004044BCBE18 000034 (v01 ALASKA T241c1   00000001 AMI  00000001)
[    0.000000] ACPI: PRMT 0x0000004044BCA018 00008E (v00 ALASKA A M I    00000001 AMI  00000001)
[    0.000000] ACPI: SDEI 0x0000004044BCAF98 000024 (v01 NVIDIA A M I    00000001 NVDA 00000001)
[    0.000000] ACPI: HEST 0x0000004044BC8018 001054 (v01 NVIDIA A M I    00000001 NVDA 00000001)
[    0.000000] ACPI: BERT 0x0000004044BCBE98 000030 (v01 NVIDIA A M I    00000001 NVDA 00000001)
[    0.000000] ACPI: EINJ 0x0000004044BCAB98 000170 (v01 NVIDIA A M I    00000001 NVDA 00000001)
[    0.000000] ACPI: ERST 0x0000004044BCA118 000290 (v01 NVIDIA A M I    00000001 NVDA 00000001)
[    0.000000] ACPI: GTDT 0x0000004044BCA518 000084 (v03 NVIDIA A M I    00000001 ARMH 00010000)
[    0.000000] ACPI: APIC 0x0000004044BC6018 001778 (v06 NVIDIA A M I    00000001 ARMH 00010000)
[    0.000000] ACPI: PPTT 0x0000004044BC1018 0020F8 (v03 NVIDIA A M I    00000001 ARMH 00010000)
[    0.000000] ACPI: SSDT 0x0000004042AF9018 006CA7 (v02 NVIDIA A M I    00000001 ARMH 00010000)
[    0.000000] ACPI: SPCR 0x0000004044BCAA18 000050 (v02 NVIDIA A M I    00000001 ARMH 00010000)
[    0.000000] ACPI: SSDT 0x0000004044BCAA98 0000CC (v02 NVIDIA A M I    00000001 INTL 20220331)
[    0.000000] ACPI: SSDT 0x0000004044BCA618 0000C0 (v02 NVIDIA TH500    00000001 INTL 20220331)
[    0.000000] ACPI: SSDT 0x0000004042AF7018 00190C (v02 NVIDIA BPMP_S0  00000001 INTL 20220331)
[    0.000000] ACPI: MCFG 0x0000004044BCA718 00007C (v01 NVIDIA A M I    00000001 ARMH 00010000)
[    0.000000] ACPI: SSDT 0x0000004044BC0018 0003AE (v02 NVIDIA A M I    00000001 ARMH 00010000)
[    0.000000] ACPI: SSDT 0x0000004044BC0418 0003AE (v02 NVIDIA A M I    00000001 ARMH 00010000)
[    0.000000] ACPI: SSDT 0x0000004044BC0818 0003AF (v02 NVIDIA A M I    00000001 ARMH 00010000)
[    0.000000] ACPI: SSDT 0x0000004042AF6018 0003AF (v02 NVIDIA A M I    00000001 ARMH 00010000)
[    0.000000] ACPI: SSDT 0x0000004042AF6418 0003AF (v02 NVIDIA A M I    00000001 ARMH 00010000)
[    0.000000] ACPI: IORT 0x0000004042AF5018 00072B (v06 NVIDIA A M I    00000001 ARMH 00010000)
[    0.000000] ACPI: APMT 0x0000004042AF5E98 00013C (v00 ALASKA A M I    00000001 AMI  00000001)
[    0.000000] ACPI: MPAM 0x0000004042AF6E98 000084 (v01 NVIDIA A M I    00000001 ARMH 00010000)
[    0.000000] ACPI: SLIT 0x0000004042AF6F98 00002D (v01 ALASKA A M I    00000001 AMI  00000001)
[    0.000000] ACPI: SRAT 0x0000004042AF6818 000574 (v03 NVIDIA A M I    00000001 ARMH 00010000)
[    0.000000] ACPI: HMAT 0x0000004044BC0E98 0000A6 (v02 ALASKA A M I    00000001 AMI  00000001)
[    0.000000] ACPI: WSMT 0x0000004044BC0F98 000028 (v01 ALASKA A M I    00000001 AMI  00000001)
[    0.000000] ACPI: TPM2 0x0000004044BCA998 00004C (v04 ALASKA A M I    00000001 AMI  00000000)
[    0.000000] ACPI: SPCR: console: pl011,mmio32,0xc280000,115200
[    0.000000] ACPI: Use ACPI SPCR as default console: Yes
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x80000000-0x407fffffff]
[    0.000000] NUMA: Initialized distance table, cnt=1
[    0.000000] NODE_DATA(0) allocated [mem 0x40597daac0-0x40597dffff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000080000000-0x00000000ffffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000405fffffff]
[    0.000000]   Device   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000080000000-0x00000000fffcffff]
[    0.000000]   node   0: [mem 0x00000000fffd0000-0x00000000ffffffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000161ab7ffff]
[    0.000000]   node   0: [mem 0x000000161ab90000-0x0000004042afffff]
[    0.000000]   node   0: [mem 0x0000004042b00000-0x0000004044bbffff]
[    0.000000]   node   0: [mem 0x0000004044bc0000-0x00000040520affff]
[    0.000000]   node   0: [mem 0x00000040520b0000-0x000000405303ffff]
[    0.000000]   node   0: [mem 0x0000004053040000-0x000000405376ffff]
[    0.000000]   node   0: [mem 0x0000004053770000-0x0000004053feffff]
[    0.000000]   node   0: [mem 0x0000004053ff0000-0x00000040567fffff]
[    0.000000]   node   0: [mem 0x0000004057000000-0x00000040571fffff]
[    0.000000]   node   0: [mem 0x0000004057600000-0x00000040576fffff]
[    0.000000]   node   0: [mem 0x0000004059700000-0x00000040597dffff]
[    0.000000]   node   0: [mem 0x000000405c000000-0x000000405fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000080000000-0x000000405fffffff]
[    0.000000] On node 0, zone Normal: 1 pages in unavailable ranges
[    0.000000] On node 0, zone Normal: 128 pages in unavailable ranges
[    0.000000] On node 0, zone Normal: 64 pages in unavailable ranges
[    0.000000] On node 0, zone Normal: 512 pages in unavailable ranges
[    0.000000] On node 0, zone Normal: 642 pages in unavailable ranges
[    0.000000] crashkernel reserved: 0x00000000e7e00000 - 0x00000000ffe00000 (384 MB)
[    0.000000] psci: probing for conduit method from ACPI.
[    0.000000] psci: PSCIv1.1 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.
[    0.000000] psci: SMC Calling Convention v1.2
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x20000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x40000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x50000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x60000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x70000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x80000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x90000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0xa0000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0xb0000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0xe0000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x100000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x110000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x120000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x130000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x140000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x150000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x160000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x170000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x180000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x190000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x1a0000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x1c0000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x1d0000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x1e0000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x1f0000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x200000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x210000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x220000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x230000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x240000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x250000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x260000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x270000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x280000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x290000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x2a0000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x2b0000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x2c0000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x2d0000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x2e0000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x2f0000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x300000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x310000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x320000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x330000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x340000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x350000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x360000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x370000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x380000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x3a0000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x3b0000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x3c0000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x3d0000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x3e0000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x3f0000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x400000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x410000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x420000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x430000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x440000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x460000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x480000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x490000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x4a0000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x4b0000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x4c0000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x4d0000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x4e0000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x4f0000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x500000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x510000 -> Node 0
[    0.000000] percpu: Embedded 4 pages/cpu s175784 r8192 d78168 u262144
[    0.000000] pcpu-alloc: s175784 r8192 d78168 u262144 alloc=4*65536
[    0.000000] pcpu-alloc: [0] 00 [0] 01 [0] 02 [0] 03 [0] 04 [0] 05 [0] 06 [0] 07 
[    0.000000] pcpu-alloc: [0] 08 [0] 09 [0] 10 [0] 11 [0] 12 [0] 13 [0] 14 [0] 15 
[    0.000000] pcpu-alloc: [0] 16 [0] 17 [0] 18 [0] 19 [0] 20 [0] 21 [0] 22 [0] 23 
[    0.000000] pcpu-alloc: [0] 24 [0] 25 [0] 26 [0] 27 [0] 28 [0] 29 [0] 30 [0] 31 
[    0.000000] pcpu-alloc: [0] 32 [0] 33 [0] 34 [0] 35 [0] 36 [0] 37 [0] 38 [0] 39 
[    0.000000] pcpu-alloc: [0] 40 [0] 41 [0] 42 [0] 43 [0] 44 [0] 45 [0] 46 [0] 47 
[    0.000000] pcpu-alloc: [0] 48 [0] 49 [0] 50 [0] 51 [0] 52 [0] 53 [0] 54 [0] 55 
[    0.000000] pcpu-alloc: [0] 56 [0] 57 [0] 58 [0] 59 [0] 60 [0] 61 [0] 62 [0] 63 
[    0.000000] pcpu-alloc: [0] 64 [0] 65 [0] 66 [0] 67 [0] 68 [0] 69 [0] 70 [0] 71 
[    0.000000] Detected PIPT I-cache on CPU0
[    0.000000] CPU features: detected: Address authentication (architected QARMA5 algorithm)
[    0.000000] CPU features: detected: GIC system register CPU interface
[    0.000000] CPU features: detected: IRQ priority masking
[    0.000000] CPU features: detected: Virtualization Host Extensions
[    0.000000] CPU features: detected: Spectre-v4
[    0.000000] CPU features: detected: Spectre-BHB
[    0.000000] CPU features: detected: SSBS not fully self-synchronizing
[    0.000000] alternatives: applying boot alternatives
[    0.000000] Kernel command line: BOOT_IMAGE=(hd0,gpt2)/vmlinuz-6.16.0-rc5-00055-g0c759ecd169d root=UUID=f89a029a-5900-4918-ae30-e8657630c770 ro ipv6.autoconf=0 crashkernel=384M pcie_aspm=nomsi selinux=0 biosdevname=0 net.ifnames=0 msr.allow_writes=on swiotlb=4096 rd.auto=1 systemd.gpt_auto=0 netconsole=+6666@2401:db00:209c:171e:face:0000:0172:0000/eth0,1514@2401:db00:eef0:a59::/76:d4:dd:68:c3:59 iommu.passthrough=1 pcie_ports=native irqchip.gicv3_pseudo_nmi=1
[    0.000000] Unknown kernel command line parameters "BOOT_IMAGE=(hd0,gpt2)/vmlinuz-6.16.0-rc5-00055-g0c759ecd169d biosdevname=0", will be passed to user space.
[    0.000000] printk: log buffer data + meta data: 2097152 + 7340032 = 9437184 bytes
[    0.000000] Dentry cache hash table entries: 16777216 (order: 11, 134217728 bytes, linear)
[    0.000000] Inode-cache hash table entries: 8388608 (order: 10, 67108864 bytes, linear)
[    0.000000] software IO TLB: area num 128.
[    0.000000] software IO TLB: SWIOTLB bounce buffer size roundup to 32MB
[    0.000000] software IO TLB: mapped [mem 0x00000000e5e00000-0x00000000e7e00000] (32MB)
[    0.000000] Fallback order for Node 0: 0 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 4184765
[    0.000000] Policy zone: Normal
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=72, Nodes=1
[    0.000000] ftrace: allocating 60398 entries in 15 pages
[    0.000000] ftrace: allocated 15 pages with 4 groups
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu: 	RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=72.
[    0.000000] 	Rude variant of Tasks RCU enabled.
[    0.000000] 	Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=72
[    0.000000] RCU Tasks Rude: Setting shift to 7 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=72.
[    0.000000] RCU Tasks Trace: Setting shift to 7 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=72.
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] GIC: enabling workaround for GICv3: ARM64 erratum 2941627
[    0.000000] GICv3: 960 SPIs implemented
[    0.000000] GICv3: 320 Extended SPIs implemented
[    0.000000] Root IRQ handler: gic_handle_irq
[    0.000000] GICv3: GICv3 features: 16 PPIs, DirectLPI
[    0.000000] GICv3: GICv4 features: DirectLPI RVPEID Valid+Dirty 
[    0.000000] GICv3: GICD_CTRL.DS=0, SCR_EL3.FIQ=1
[    0.000000] GICv3: CPU0: found redistributor 20000 region 0:0x0000000022100000
[    0.000000] GICv3: Pseudo-NMIs enabled using relaxed ICC_PMR_EL1 synchronisation
[    0.000000] SRAT: PXM 0 -> ITS 0 -> Node 0
[    0.000000] ITS [mem 0x22040000-0x2205ffff]
[    0.000000] ITS@0x0000000022040000: Single VMOVP capable
[    0.000000] ITS@0x0000000022040000: Using GICv4.1 mode 00000000 00000001
[    0.000000] ITS@0x0000000022040000: allocated 8192 Devices @120a10000 (indirect, esz 8, psz 64K, shr 1)
[    0.000000] ITS@0x0000000022040000: allocated 32768 Interrupt Collections @120a20000 (flat, esz 2, psz 64K, shr 1)
[    0.000000] ITS@0x0000000022040000: allocated 16384 Virtual CPUs @120a40000 (flat, esz 8, psz 64K, shr 1)
[    0.000000] GICv3: Using preallocated redistributor tables
[    0.000000] GICv3: using LPI property table @0x0000000100900000
[    0.000000] ITS: Using DirectLPI for VPE invalidation
[    0.000000] ITS: Enabling GICv4 support
[    0.000000] GICv3: CPU0: using reserved LPI pending table @0x0000000100920000
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.000000] arch_timer: cp15 timer(s) running at 1000.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0x1fffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.000001] sched_clock: 61 bits at 1000MHz, resolution 1ns, wraps every 4398046511103ns
[    0.000271] kfence: initialized - using 33554432 bytes for 255 objects at 0x(____ptrval____)-0x(____ptrval____)
[    0.000379] Console: colour dummy device 80x25
[    0.000424] ACPI: Core revision 20250404
[    0.000571] Calibrating delay loop (skipped), value calculated using timer frequency.. 2000.00 BogoMIPS (lpj=1000000)
[    0.000576] pid_max: default: 73728 minimum: 576
[    0.000617] LSM: initializing lsm=capability,bpf,ima
[    0.000896] LSM support for eBPF active
[    0.000934] stackdepot: allocating hash table of 1048576 entries via kvcalloc
[    0.001806] Mount-cache hash table entries: 262144 (order: 5, 2097152 bytes, linear)
[    0.001850] Mountpoint-cache hash table entries: 262144 (order: 5, 2097152 bytes, linear)
[    0.002665] rcu: Hierarchical SRCU implementation.
[    0.002667] rcu: 	Max phase no-delay instances is 400.
[    0.002710] Timer migration: 3 hierarchy levels; 8 children per group; 3 crossnode level
[    0.002890] Remapping and enabling EFI services.
[    0.003411] smp: Bringing up secondary CPUs ...
[    0.006323] Detected PIPT I-cache on CPU1
[    0.006339] GICv3: CPU1: found redistributor 40000 region 0:0x0000000022180000
[    0.006344] GICv3: CPU1: using reserved LPI pending table @0x0000000100930000
[    0.006360] CPU1: Booted secondary processor 0x0000040000 [0x410fd4f0]
[    0.007966] Detected PIPT I-cache on CPU2
[    0.007979] GICv3: CPU2: found redistributor 50000 region 0:0x00000000221c0000
[    0.007984] GICv3: CPU2: using reserved LPI pending table @0x0000000100940000
[    0.008000] CPU2: Booted secondary processor 0x0000050000 [0x410fd4f0]
[    0.009650] Detected PIPT I-cache on CPU3
[    0.009663] GICv3: CPU3: found redistributor 60000 region 0:0x0000000022200000
[    0.009668] GICv3: CPU3: using reserved LPI pending table @0x0000000100950000
[    0.009684] CPU3: Booted secondary processor 0x0000060000 [0x410fd4f0]
[    0.011338] Detected PIPT I-cache on CPU4
[    0.011350] GICv3: CPU4: found redistributor 70000 region 0:0x0000000022240000
[    0.011355] GICv3: CPU4: using reserved LPI pending table @0x0000000100960000
[    0.011371] CPU4: Booted secondary processor 0x0000070000 [0x410fd4f0]
[    0.013067] Detected PIPT I-cache on CPU5
[    0.013080] GICv3: CPU5: found redistributor 80000 region 0:0x0000000022280000
[    0.013085] GICv3: CPU5: using reserved LPI pending table @0x0000000100970000
[    0.013101] CPU5: Booted secondary processor 0x0000080000 [0x410fd4f0]
[    0.014795] Detected PIPT I-cache on CPU6
[    0.014808] GICv3: CPU6: found redistributor 90000 region 0:0x00000000222c0000
[    0.014814] GICv3: CPU6: using reserved LPI pending table @0x0000000100980000
[    0.014829] CPU6: Booted secondary processor 0x0000090000 [0x410fd4f0]
[    0.016559] Detected PIPT I-cache on CPU7
[    0.016573] GICv3: CPU7: found redistributor a0000 region 0:0x0000000022300000
[    0.016579] GICv3: CPU7: using reserved LPI pending table @0x0000000100990000
[    0.016594] CPU7: Booted secondary processor 0x00000a0000 [0x410fd4f0]
[    0.018324] Detected PIPT I-cache on CPU8
[    0.018339] GICv3: CPU8: found redistributor b0000 region 0:0x0000000022340000
[    0.018344] GICv3: CPU8: using reserved LPI pending table @0x00000001009a0000
[    0.018360] CPU8: Booted secondary processor 0x00000b0000 [0x410fd4f0]
[    0.019923] Detected PIPT I-cache on CPU9
[    0.019937] GICv3: CPU9: found redistributor e0000 region 0:0x0000000022400000
[    0.019943] GICv3: CPU9: using reserved LPI pending table @0x00000001009b0000
[    0.019958] CPU9: Booted secondary processor 0x00000e0000 [0x410fd4f0]
[    0.021545] Detected PIPT I-cache on CPU10
[    0.021560] GICv3: CPU10: found redistributor 100000 region 0:0x0000000022480000
[    0.021566] GICv3: CPU10: using reserved LPI pending table @0x00000001009c0000
[    0.021581] CPU10: Booted secondary processor 0x0000100000 [0x410fd4f0]
[    0.023148] Detected PIPT I-cache on CPU11
[    0.023164] GICv3: CPU11: found redistributor 110000 region 0:0x00000000224c0000
[    0.023170] GICv3: CPU11: using reserved LPI pending table @0x00000001009d0000
[    0.023185] CPU11: Booted secondary processor 0x0000110000 [0x410fd4f0]
[    0.024714] Detected PIPT I-cache on CPU12
[    0.024731] GICv3: CPU12: found redistributor 120000 region 0:0x0000000022500000
[    0.024736] GICv3: CPU12: using reserved LPI pending table @0x00000001009e0000
[    0.024751] CPU12: Booted secondary processor 0x0000120000 [0x410fd4f0]
[    0.026276] Detected PIPT I-cache on CPU13
[    0.026293] GICv3: CPU13: found redistributor 130000 region 0:0x0000000022540000
[    0.026298] GICv3: CPU13: using reserved LPI pending table @0x00000001009f0000
[    0.026314] CPU13: Booted secondary processor 0x0000130000 [0x410fd4f0]
[    0.027910] Detected PIPT I-cache on CPU14
[    0.027928] GICv3: CPU14: found redistributor 140000 region 0:0x0000000022580000
[    0.027934] GICv3: CPU14: using reserved LPI pending table @0x0000000100a00000
[    0.027949] CPU14: Booted secondary processor 0x0000140000 [0x410fd4f0]
[    0.029552] Detected PIPT I-cache on CPU15
[    0.029569] GICv3: CPU15: found redistributor 150000 region 0:0x00000000225c0000
[    0.029575] GICv3: CPU15: using reserved LPI pending table @0x0000000100a10000
[    0.029591] CPU15: Booted secondary processor 0x0000150000 [0x410fd4f0]
[    0.031223] Detected PIPT I-cache on CPU16
[    0.031241] GICv3: CPU16: found redistributor 160000 region 0:0x0000000022600000
[    0.031247] GICv3: CPU16: using reserved LPI pending table @0x0000000100a20000
[    0.031262] CPU16: Booted secondary processor 0x0000160000 [0x410fd4f0]
[    0.032899] Detected PIPT I-cache on CPU17
[    0.032917] GICv3: CPU17: found redistributor 170000 region 0:0x0000000022640000
[    0.032923] GICv3: CPU17: using reserved LPI pending table @0x0000000100a30000
[    0.032938] CPU17: Booted secondary processor 0x0000170000 [0x410fd4f0]
[    0.034624] Detected PIPT I-cache on CPU18
[    0.034644] GICv3: CPU18: found redistributor 180000 region 0:0x0000000022680000
[    0.034650] GICv3: CPU18: using reserved LPI pending table @0x0000000100a40000
[    0.034666] CPU18: Booted secondary processor 0x0000180000 [0x410fd4f0]
[    0.036339] Detected PIPT I-cache on CPU19
[    0.036358] GICv3: CPU19: found redistributor 190000 region 0:0x00000000226c0000
[    0.036364] GICv3: CPU19: using reserved LPI pending table @0x0000000100a50000
[    0.036380] CPU19: Booted secondary processor 0x0000190000 [0x410fd4f0]
[    0.038094] Detected PIPT I-cache on CPU20
[    0.038117] GICv3: CPU20: found redistributor 1a0000 region 0:0x0000000022700000
[    0.038123] GICv3: CPU20: using reserved LPI pending table @0x0000000100a60000
[    0.038139] CPU20: Booted secondary processor 0x00001a0000 [0x410fd4f0]
[    0.039711] Detected PIPT I-cache on CPU21
[    0.039732] GICv3: CPU21: found redistributor 1c0000 region 0:0x0000000022780000
[    0.039738] GICv3: CPU21: using reserved LPI pending table @0x0000000100a70000
[    0.039754] CPU21: Booted secondary processor 0x00001c0000 [0x410fd4f0]
[    0.041326] Detected PIPT I-cache on CPU22
[    0.041347] GICv3: CPU22: found redistributor 1d0000 region 0:0x00000000227c0000
[    0.041353] GICv3: CPU22: using reserved LPI pending table @0x0000000100a80000
[    0.041369] CPU22: Booted secondary processor 0x00001d0000 [0x410fd4f0]
[    0.042948] Detected PIPT I-cache on CPU23
[    0.042968] GICv3: CPU23: found redistributor 1e0000 region 0:0x0000000022800000
[    0.042974] GICv3: CPU23: using reserved LPI pending table @0x0000000100a90000
[    0.042989] CPU23: Booted secondary processor 0x00001e0000 [0x410fd4f0]
[    0.044560] Detected PIPT I-cache on CPU24
[    0.044582] GICv3: CPU24: found redistributor 1f0000 region 0:0x0000000022840000
[    0.044588] GICv3: CPU24: using reserved LPI pending table @0x0000000100aa0000
[    0.044603] CPU24: Booted secondary processor 0x00001f0000 [0x410fd4f0]
[    0.046141] Detected PIPT I-cache on CPU25
[    0.046164] GICv3: CPU25: found redistributor 200000 region 0:0x0000000022880000
[    0.046170] GICv3: CPU25: using reserved LPI pending table @0x0000000100ab0000
[    0.046185] CPU25: Booted secondary processor 0x0000200000 [0x410fd4f0]
[    0.047727] Detected PIPT I-cache on CPU26
[    0.047750] GICv3: CPU26: found redistributor 210000 region 0:0x00000000228c0000
[    0.047756] GICv3: CPU26: using reserved LPI pending table @0x0000000100ac0000
[    0.047771] CPU26: Booted secondary processor 0x0000210000 [0x410fd4f0]
[    0.049373] Detected PIPT I-cache on CPU27
[    0.049397] GICv3: CPU27: found redistributor 220000 region 0:0x0000000022900000
[    0.049403] GICv3: CPU27: using reserved LPI pending table @0x0000000100ad0000
[    0.049419] CPU27: Booted secondary processor 0x0000220000 [0x410fd4f0]
[    0.051022] Detected PIPT I-cache on CPU28
[    0.051046] GICv3: CPU28: found redistributor 230000 region 0:0x0000000022940000
[    0.051051] GICv3: CPU28: using reserved LPI pending table @0x0000000100ae0000
[    0.051067] CPU28: Booted secondary processor 0x0000230000 [0x410fd4f0]
[    0.052708] Detected PIPT I-cache on CPU29
[    0.052733] GICv3: CPU29: found redistributor 240000 region 0:0x0000000022980000
[    0.052739] GICv3: CPU29: using reserved LPI pending table @0x0000000100af0000
[    0.052755] CPU29: Booted secondary processor 0x0000240000 [0x410fd4f0]
[    0.054410] Detected PIPT I-cache on CPU30
[    0.054435] GICv3: CPU30: found redistributor 250000 region 0:0x00000000229c0000
[    0.054441] GICv3: CPU30: using reserved LPI pending table @0x0000000100b00000
[    0.054456] CPU30: Booted secondary processor 0x0000250000 [0x410fd4f0]
[    0.056142] Detected PIPT I-cache on CPU31
[    0.056168] GICv3: CPU31: found redistributor 260000 region 0:0x0000000022a00000
[    0.056174] GICv3: CPU31: using reserved LPI pending table @0x0000000100b10000
[    0.056190] CPU31: Booted secondary processor 0x0000260000 [0x410fd4f0]
[    0.057875] Detected PIPT I-cache on CPU32
[    0.057901] GICv3: CPU32: found redistributor 270000 region 0:0x0000000022a40000
[    0.057907] GICv3: CPU32: using reserved LPI pending table @0x0000000100b20000
[    0.057922] CPU32: Booted secondary processor 0x0000270000 [0x410fd4f0]
[    0.059643] Detected PIPT I-cache on CPU33
[    0.059670] GICv3: CPU33: found redistributor 280000 region 0:0x0000000022a80000
[    0.059676] GICv3: CPU33: using reserved LPI pending table @0x0000000100b30000
[    0.059692] CPU33: Booted secondary processor 0x0000280000 [0x410fd4f0]
[    0.061415] Detected PIPT I-cache on CPU34
[    0.061441] GICv3: CPU34: found redistributor 290000 region 0:0x0000000022ac0000
[    0.061447] GICv3: CPU34: using reserved LPI pending table @0x0000000100b40000
[    0.061463] CPU34: Booted secondary processor 0x0000290000 [0x410fd4f0]
[    0.063142] Detected PIPT I-cache on CPU35
[    0.063169] GICv3: CPU35: found redistributor 2a0000 region 0:0x0000000022b00000
[    0.063175] GICv3: CPU35: using reserved LPI pending table @0x0000000100b50000
[    0.063191] CPU35: Booted secondary processor 0x00002a0000 [0x410fd4f0]
[    0.064866] Detected PIPT I-cache on CPU36
[    0.064893] GICv3: CPU36: found redistributor 2b0000 region 0:0x0000000022b40000
[    0.064900] GICv3: CPU36: using reserved LPI pending table @0x0000000100b60000
[    0.064916] CPU36: Booted secondary processor 0x00002b0000 [0x410fd4f0]
[    0.066593] Detected PIPT I-cache on CPU37
[    0.066619] GICv3: CPU37: found redistributor 2c0000 region 0:0x0000000022b80000
[    0.066625] GICv3: CPU37: using reserved LPI pending table @0x0000000100b70000
[    0.066641] CPU37: Booted secondary processor 0x00002c0000 [0x410fd4f0]
[    0.068323] Detected PIPT I-cache on CPU38
[    0.068351] GICv3: CPU38: found redistributor 2d0000 region 0:0x0000000022bc0000
[    0.068356] GICv3: CPU38: using reserved LPI pending table @0x0000000100b80000
[    0.068372] CPU38: Booted secondary processor 0x00002d0000 [0x410fd4f0]
[    0.070013] Detected PIPT I-cache on CPU39
[    0.070041] GICv3: CPU39: found redistributor 2e0000 region 0:0x0000000022c00000
[    0.070047] GICv3: CPU39: using reserved LPI pending table @0x0000000100b90000
[    0.070062] CPU39: Booted secondary processor 0x00002e0000 [0x410fd4f0]
[    0.071709] Detected PIPT I-cache on CPU40
[    0.071737] GICv3: CPU40: found redistributor 2f0000 region 0:0x0000000022c40000
[    0.071743] GICv3: CPU40: using reserved LPI pending table @0x0000000100ba0000
[    0.071758] CPU40: Booted secondary processor 0x00002f0000 [0x410fd4f0]
[    0.073468] Detected PIPT I-cache on CPU41
[    0.073498] GICv3: CPU41: found redistributor 300000 region 0:0x0000000022c80000
[    0.073504] GICv3: CPU41: using reserved LPI pending table @0x0000000100bb0000
[    0.073519] CPU41: Booted secondary processor 0x0000300000 [0x410fd4f0]
[    0.075231] Detected PIPT I-cache on CPU42
[    0.075260] GICv3: CPU42: found redistributor 310000 region 0:0x0000000022cc0000
[    0.075266] GICv3: CPU42: using reserved LPI pending table @0x0000000100bc0000
[    0.075281] CPU42: Booted secondary processor 0x0000310000 [0x410fd4f0]
[    0.077026] Detected PIPT I-cache on CPU43
[    0.077057] GICv3: CPU43: found redistributor 320000 region 0:0x0000000022d00000
[    0.077064] GICv3: CPU43: using reserved LPI pending table @0x0000000100bd0000
[    0.077079] CPU43: Booted secondary processor 0x0000320000 [0x410fd4f0]
[    0.078848] Detected PIPT I-cache on CPU44
[    0.078878] GICv3: CPU44: found redistributor 330000 region 0:0x0000000022d40000
[    0.078884] GICv3: CPU44: using reserved LPI pending table @0x0000000100be0000
[    0.078899] CPU44: Booted secondary processor 0x0000330000 [0x410fd4f0]
[    0.080701] Detected PIPT I-cache on CPU45
[    0.080732] GICv3: CPU45: found redistributor 340000 region 0:0x0000000022d80000
[    0.080739] GICv3: CPU45: using reserved LPI pending table @0x0000000100bf0000
[    0.080754] CPU45: Booted secondary processor 0x0000340000 [0x410fd4f0]
[    0.082538] Detected PIPT I-cache on CPU46
[    0.082571] GICv3: CPU46: found redistributor 350000 region 0:0x0000000022dc0000
[    0.082577] GICv3: CPU46: using reserved LPI pending table @0x0000000100c00000
[    0.082593] CPU46: Booted secondary processor 0x0000350000 [0x410fd4f0]
[    0.084424] Detected PIPT I-cache on CPU47
[    0.084457] GICv3: CPU47: found redistributor 360000 region 0:0x0000000022e00000
[    0.084464] GICv3: CPU47: using reserved LPI pending table @0x0000000100c10000
[    0.084480] CPU47: Booted secondary processor 0x0000360000 [0x410fd4f0]
[    0.086320] Detected PIPT I-cache on CPU48
[    0.086356] GICv3: CPU48: found redistributor 370000 region 0:0x0000000022e40000
[    0.086363] GICv3: CPU48: using reserved LPI pending table @0x0000000100c20000
[    0.086378] CPU48: Booted secondary processor 0x0000370000 [0x410fd4f0]
[    0.088111] Detected PIPT I-cache on CPU49
[    0.088144] GICv3: CPU49: found redistributor 380000 region 0:0x0000000022e80000
[    0.088150] GICv3: CPU49: using reserved LPI pending table @0x0000000100c30000
[    0.088166] CPU49: Booted secondary processor 0x0000380000 [0x410fd4f0]
[    0.089909] Detected PIPT I-cache on CPU50
[    0.089943] GICv3: CPU50: found redistributor 3a0000 region 0:0x0000000022f00000
[    0.089949] GICv3: CPU50: using reserved LPI pending table @0x0000000100c40000
[    0.089965] CPU50: Booted secondary processor 0x00003a0000 [0x410fd4f0]
[    0.091700] Detected PIPT I-cache on CPU51
[    0.091734] GICv3: CPU51: found redistributor 3b0000 region 0:0x0000000022f40000
[    0.091741] GICv3: CPU51: using reserved LPI pending table @0x0000000100c50000
[    0.091756] CPU51: Booted secondary processor 0x00003b0000 [0x410fd4f0]
[    0.093453] Detected PIPT I-cache on CPU52
[    0.093487] GICv3: CPU52: found redistributor 3c0000 region 0:0x0000000022f80000
[    0.093493] GICv3: CPU52: using reserved LPI pending table @0x0000000100c60000
[    0.093509] CPU52: Booted secondary processor 0x00003c0000 [0x410fd4f0]
[    0.095209] Detected PIPT I-cache on CPU53
[    0.095245] GICv3: CPU53: found redistributor 3d0000 region 0:0x0000000022fc0000
[    0.095252] GICv3: CPU53: using reserved LPI pending table @0x0000000100c70000
[    0.095267] CPU53: Booted secondary processor 0x00003d0000 [0x410fd4f0]
[    0.097036] Detected PIPT I-cache on CPU54
[    0.097071] GICv3: CPU54: found redistributor 3e0000 region 0:0x0000000023000000
[    0.097077] GICv3: CPU54: using reserved LPI pending table @0x0000000100c80000
[    0.097093] CPU54: Booted secondary processor 0x00003e0000 [0x410fd4f0]
[    0.098860] Detected PIPT I-cache on CPU55
[    0.098896] GICv3: CPU55: found redistributor 3f0000 region 0:0x0000000023040000
[    0.098902] GICv3: CPU55: using reserved LPI pending table @0x0000000100c90000
[    0.098918] CPU55: Booted secondary processor 0x00003f0000 [0x410fd4f0]
[    0.100722] Detected PIPT I-cache on CPU56
[    0.100757] GICv3: CPU56: found redistributor 400000 region 0:0x0000000023080000
[    0.100764] GICv3: CPU56: using reserved LPI pending table @0x0000000100ca0000
[    0.100780] CPU56: Booted secondary processor 0x0000400000 [0x410fd4f0]
[    0.102581] Detected PIPT I-cache on CPU57
[    0.102619] GICv3: CPU57: found redistributor 410000 region 0:0x00000000230c0000
[    0.102626] GICv3: CPU57: using reserved LPI pending table @0x0000000100cb0000
[    0.102642] CPU57: Booted secondary processor 0x0000410000 [0x410fd4f0]
[    0.104491] Detected PIPT I-cache on CPU58
[    0.104528] GICv3: CPU58: found redistributor 420000 region 0:0x0000000023100000
[    0.104535] GICv3: CPU58: using reserved LPI pending table @0x0000000100cc0000
[    0.104551] CPU58: Booted secondary processor 0x0000420000 [0x410fd4f0]
[    0.106452] Detected PIPT I-cache on CPU59
[    0.106492] GICv3: CPU59: found redistributor 430000 region 0:0x0000000023140000
[    0.106499] GICv3: CPU59: using reserved LPI pending table @0x0000000100cd0000
[    0.106515] CPU59: Booted secondary processor 0x0000430000 [0x410fd4f0]
[    0.108460] Detected PIPT I-cache on CPU60
[    0.108499] GICv3: CPU60: found redistributor 440000 region 0:0x0000000023180000
[    0.108506] GICv3: CPU60: using reserved LPI pending table @0x0000000100ce0000
[    0.108522] CPU60: Booted secondary processor 0x0000440000 [0x410fd4f0]
[    0.110309] Detected PIPT I-cache on CPU61
[    0.110352] GICv3: CPU61: found redistributor 460000 region 0:0x0000000023200000
[    0.110359] GICv3: CPU61: using reserved LPI pending table @0x0000000100cf0000
[    0.110375] CPU61: Booted secondary processor 0x0000460000 [0x410fd4f0]
[    0.112170] Detected PIPT I-cache on CPU62
[    0.112211] GICv3: CPU62: found redistributor 480000 region 0:0x0000000023280000
[    0.112218] GICv3: CPU62: using reserved LPI pending table @0x0000000100d00000
[    0.112233] CPU62: Booted secondary processor 0x0000480000 [0x410fd4f0]
[    0.114020] Detected PIPT I-cache on CPU63
[    0.114063] GICv3: CPU63: found redistributor 490000 region 0:0x00000000232c0000
[    0.114069] GICv3: CPU63: using reserved LPI pending table @0x0000000100d10000
[    0.114085] CPU63: Booted secondary processor 0x0000490000 [0x410fd4f0]
[    0.115853] Detected PIPT I-cache on CPU64
[    0.115895] GICv3: CPU64: found redistributor 4a0000 region 0:0x0000000023300000
[    0.115901] GICv3: CPU64: using reserved LPI pending table @0x0000000100d20000
[    0.115917] CPU64: Booted secondary processor 0x00004a0000 [0x410fd4f0]
[    0.117678] Detected PIPT I-cache on CPU65
[    0.117721] GICv3: CPU65: found redistributor 4b0000 region 0:0x0000000023340000
[    0.117728] GICv3: CPU65: using reserved LPI pending table @0x0000000100d30000
[    0.117744] CPU65: Booted secondary processor 0x00004b0000 [0x410fd4f0]
[    0.119570] Detected PIPT I-cache on CPU66
[    0.119613] GICv3: CPU66: found redistributor 4c0000 region 0:0x0000000023380000
[    0.119620] GICv3: CPU66: using reserved LPI pending table @0x0000000100d40000
[    0.119636] CPU66: Booted secondary processor 0x00004c0000 [0x410fd4f0]
[    0.121452] Detected PIPT I-cache on CPU67
[    0.121494] GICv3: CPU67: found redistributor 4d0000 region 0:0x00000000233c0000
[    0.121501] GICv3: CPU67: using reserved LPI pending table @0x0000000100d50000
[    0.121517] CPU67: Booted secondary processor 0x00004d0000 [0x410fd4f0]
[    0.123378] Detected PIPT I-cache on CPU68
[    0.123424] GICv3: CPU68: found redistributor 4e0000 region 0:0x0000000023400000
[    0.123431] GICv3: CPU68: using reserved LPI pending table @0x0000000100d60000
[    0.123447] CPU68: Booted secondary processor 0x00004e0000 [0x410fd4f0]
[    0.125306] Detected PIPT I-cache on CPU69
[    0.125351] GICv3: CPU69: found redistributor 4f0000 region 0:0x0000000023440000
[    0.125358] GICv3: CPU69: using reserved LPI pending table @0x0000000100d70000
[    0.125374] CPU69: Booted secondary processor 0x00004f0000 [0x410fd4f0]
[    0.127276] Detected PIPT I-cache on CPU70
[    0.127322] GICv3: CPU70: found redistributor 500000 region 0:0x0000000023480000
[    0.127329] GICv3: CPU70: using reserved LPI pending table @0x0000000100d80000
[    0.127345] CPU70: Booted secondary processor 0x0000500000 [0x410fd4f0]
[    0.129250] Detected PIPT I-cache on CPU71
[    0.129296] GICv3: CPU71: found redistributor 510000 region 0:0x00000000234c0000
[    0.129303] GICv3: CPU71: using reserved LPI pending table @0x0000000100d90000
[    0.129320] CPU71: Booted secondary processor 0x0000510000 [0x410fd4f0]
[    0.129411] smp: Brought up 1 node, 72 CPUs
[    0.129415] SMP: Total of 72 processors activated.
[    0.129416] CPU: All CPU(s) started at EL2
[    0.129419] CPU features: detected: Branch Target Identification
[    0.129422] CPU features: detected: ARMv8.4 Translation Table Level
[    0.129423] CPU features: detected: Instruction cache invalidation not required for I/D coherence
[    0.129425] CPU features: detected: Data cache clean to the PoU not required for I/D coherence
[    0.129428] CPU features: detected: Common not Private translations
[    0.129429] CPU features: detected: CRC32 instructions
[    0.129431] CPU features: detected: Data cache clean to Point of Deep Persistence
[    0.129433] CPU features: detected: Data cache clean to Point of Persistence
[    0.129434] CPU features: detected: Data independent timing control (DIT)
[    0.129436] CPU features: detected: E0PD
[    0.129437] CPU features: detected: Enhanced Privileged Access Never
[    0.129439] CPU features: detected: Enhanced Virtualization Traps
[    0.129441] CPU features: detected: Generic authentication (architected QARMA5 algorithm)
[    0.129443] CPU features: detected: RCpc load-acquire (LDAPR)
[    0.129445] CPU features: detected: LSE atomic instructions
[    0.129446] CPU features: detected: Privileged Access Never
[    0.129448] CPU features: detected: PMUv3
[    0.129449] CPU features: detected: RAS Extension Support
[    0.129451] CPU features: detected: Speculation barrier (SB)
[    0.129452] CPU features: detected: Stage-2 Force Write-Back
[    0.129454] CPU features: detected: TLB range maintenance instructions
[    0.129456] CPU features: detected: Memory Partitioning And Monitoring
[    0.129457] CPU features: detected: Memory Partitioning And Monitoring Virtualisation
[    0.129459] CPU features: detected: Speculative Store Bypassing Safe (SSBS)
[    0.129461] CPU features: detected: Scalable Vector Extension
[    0.129779] alternatives: applying system-wide alternatives
[    0.132380] CPU features: detected: Activity Monitors Unit (AMU) on CPU0-71
[    0.132384] CPU features: detected: Hardware dirty bit management on CPU0-71
[    0.132387] SVE: maximum available vector length 16 bytes per vector
[    0.132389] SVE: default vector length 16 bytes per vector
[    0.133122] Memory: 266487360K/267824960K available (21056K kernel code, 11778K rwdata, 16704K rodata, 11264K init, 3238K bss, 1123456K reserved, 0K cma-reserved)
[    0.133326] devtmpfs: initialized
[    0.136841] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.136862] posixtimers hash table entries: 65536 (order: 5, 2097152 bytes, linear)
[    0.137410] futex hash table entries: 32768 (2097152 bytes on 1 NUMA nodes, total 2048 KiB, linear).
[    0.137482] 1031 pages in range for non-PLT usage
[    0.137483] 31751 pages in range for PLT usage
[    0.137589] pinctrl core: initialized pinctrl subsystem
[    0.137750] SMBIOS 3.6.0 present.
[    0.137754] DMI:....
[    0.137765] DMI: Memory slots populated: 1/1
[    0.138894] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.139813] DMA: preallocated 32768 KiB GFP_KERNEL pool for atomic allocations
[    0.140086] DMA: preallocated 32768 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.140360] DMA: preallocated 32768 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.140375] audit: initializing netlink subsys (disabled)
[    0.140438] audit: type=2000 audit(0.138:1): state=initialized audit_enabled=0 res=1
[    0.140503] thermal_sys: Registered thermal governor 'step_wise'
[    0.140505] thermal_sys: Registered thermal governor 'user_space'
[    0.140540] cpuidle: using governor menu
[    0.140575] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.141172] ASID allocator initialised with 65536 entries
[    0.141217] Serial: AMBA PL011 UART driver
[    0.141547] HugeTLB: allocation took 0ms with hugepage_allocation_threads=18
[    0.141549] HugeTLB: allocation took 0ms with hugepage_allocation_threads=18
[    0.141553] HugeTLB: registered 16.0 GiB page size, pre-allocated 0 pages
[    0.141554] HugeTLB: 0 KiB vmemmap can be freed for a 16.0 GiB page
[    0.141556] HugeTLB: registered 512 MiB page size, pre-allocated 0 pages
[    0.141557] HugeTLB: 0 KiB vmemmap can be freed for a 512 MiB page
[    0.141559] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.141560] HugeTLB: 0 KiB vmemmap can be freed for a 2.00 MiB page
[    0.158413] raid6: neonx8   gen() 27187 MB/s
[    0.175451] raid6: neonx4   gen() 25335 MB/s
[    0.192493] raid6: neonx2   gen() 22617 MB/s
[    0.209520] raid6: neonx1   gen() 20437 MB/s
[    0.226578] raid6: int64x8  gen()  9539 MB/s
[    0.243622] raid6: int64x4  gen() 10312 MB/s
[    0.260625] raid6: int64x2  gen()  9492 MB/s
[    0.277692] raid6: int64x1  gen()  7851 MB/s
[    0.277694] raid6: using algorithm neonx8 gen() 27187 MB/s
[    0.294696] raid6: .... xor() 20355 MB/s, rmw enabled
[    0.294698] raid6: using neon recovery algorithm
[    0.294792] PRM: found 1 modules
[    0.294840] ACPI: Added _OSI(Module Device)
[    0.294842] ACPI: Added _OSI(Processor Device)
[    0.294844] ACPI: Added _OSI(Processor Aggregator Device)
[    0.296335] ACPI: 11 ACPI AML tables successfully acquired and loaded
[    0.297520] ACPI: Interpreter enabled
[    0.297522] ACPI: Using GIC for interrupt routing
[    0.297532] ACPI: MCFG table detected, 5 entries
[    0.297802] HEST: Table parsing has been initialized.
[    0.297818] sdei: SDEIv1.0 (0x0) detected in firmware.
[    0.299871] GHES: APEI firmware first mode is enabled by APEI bit and WHEA _OSC.
[    0.299959] ACPI: IORT: SMMU-v3[11000000] Mapped to Proximity domain 0
[    0.299979] ACPI: IORT: SMMU-v3[12000000] Mapped to Proximity domain 0
[    0.299996] ACPI: IORT: SMMU-v3[15000000] Mapped to Proximity domain 0
[    0.300013] ACPI: IORT: SMMU-v3[16000000] Mapped to Proximity domain 0
[    0.300031] ACPI: IORT: SMMU-v3[5000000] Mapped to Proximity domain 0
[    0.305809] ACPI: CPU0 has been hot-added
[    0.305840] ACPI: CPU1 has been hot-added
[    0.305866] ACPI: CPU2 has been hot-added
[    0.305892] ACPI: CPU3 has been hot-added
[    0.305919] ACPI: CPU4 has been hot-added
[    0.305944] ACPI: CPU5 has been hot-added
[    0.305970] ACPI: CPU6 has been hot-added
[    0.305996] ACPI: CPU7 has been hot-added
[    0.306021] ACPI: CPU8 has been hot-added
[    0.306047] ACPI: CPU9 has been hot-added
[    0.306072] ACPI: CPU10 has been hot-added
[    0.306098] ACPI: CPU11 has been hot-added
[    0.306130] ACPI: CPU12 has been hot-added
[    0.306155] ACPI: CPU13 has been hot-added
[    0.306181] ACPI: CPU14 has been hot-added
[    0.306206] ACPI: CPU15 has been hot-added
[    0.306231] ACPI: CPU16 has been hot-added
[    0.306256] ACPI: CPU17 has been hot-added
[    0.306282] ACPI: CPU18 has been hot-added
[    0.306307] ACPI: CPU19 has been hot-added
[    0.306332] ACPI: CPU20 has been hot-added
[    0.306357] ACPI: CPU21 has been hot-added
[    0.306382] ACPI: CPU22 has been hot-added
[    0.306407] ACPI: CPU23 has been hot-added
[    0.306433] ACPI: CPU24 has been hot-added
[    0.306458] ACPI: CPU25 has been hot-added
[    0.306490] ACPI: CPU26 has been hot-added
[    0.306515] ACPI: CPU27 has been hot-added
[    0.306540] ACPI: CPU28 has been hot-added
[    0.306566] ACPI: CPU29 has been hot-added
[    0.306616] ACPI: CPU30 has been hot-added
[    0.306645] ACPI: CPU31 has been hot-added
[    0.306675] ACPI: CPU32 has been hot-added
[    0.306700] ACPI: CPU33 has been hot-added
[    0.306725] ACPI: CPU34 has been hot-added
[    0.306751] ACPI: CPU35 has been hot-added
[    0.306778] ACPI: CPU36 has been hot-added
[    0.306803] ACPI: CPU37 has been hot-added
[    0.306829] ACPI: CPU38 has been hot-added
[    0.306855] ACPI: CPU39 has been hot-added
[    0.306882] ACPI: CPU40 has been hot-added
[    0.306913] ACPI: CPU41 has been hot-added
[    0.306938] ACPI: CPU42 has been hot-added
[    0.306964] ACPI: CPU43 has been hot-added
[    0.306989] ACPI: CPU44 has been hot-added
[    0.307014] ACPI: CPU45 has been hot-added
[    0.307039] ACPI: CPU46 has been hot-added
[    0.307065] ACPI: CPU47 has been hot-added
[    0.307091] ACPI: CPU48 has been hot-added
[    0.307116] ACPI: CPU49 has been hot-added
[    0.307141] ACPI: CPU50 has been hot-added
[    0.307167] ACPI: CPU51 has been hot-added
[    0.307192] ACPI: CPU52 has been hot-added
[    0.307217] ACPI: CPU53 has been hot-added
[    0.307243] ACPI: CPU54 has been hot-added
[    0.307277] ACPI: CPU55 has been hot-added
[    0.307303] ACPI: CPU56 has been hot-added
[    0.307328] ACPI: CPU57 has been hot-added
[    0.307354] ACPI: CPU58 has been hot-added
[    0.307379] ACPI: CPU59 has been hot-added
[    0.307405] ACPI: CPU60 has been hot-added
[    0.307430] ACPI: CPU61 has been hot-added
[    0.307455] ACPI: CPU62 has been hot-added
[    0.307481] ACPI: CPU63 has been hot-added
[    0.307507] ACPI: CPU64 has been hot-added
[    0.307532] ACPI: CPU65 has been hot-added
[    0.307558] ACPI: CPU66 has been hot-added
[    0.307596] ACPI: CPU67 has been hot-added
[    0.307637] ACPI: CPU68 has been hot-added
[    0.307671] ACPI: CPU69 has been hot-added
[    0.307703] ACPI: CPU70 has been hot-added
[    0.307729] ACPI: CPU71 has been hot-added
[    0.307809] ARMH0011:00: ttyAMA0 at MMIO 0xc280000 (irq = 66, base_baud = 0) is a SBSA
[    0.307816] printk: console [ttyAMA0] enabled
[    5.414515] smp: csd: Detected non-responsive CSD lock (#1) on CPU#0, waiting 5001000000 ns for CPU#01 do_nothing+0x0/0x10(0x0).
[    5.414532] smp: 	csd: CSD lock (#1) unresponsive.
[    5.414535] Sending NMI from CPU 0 to CPUs 1:
[    5.414541] NMI backtrace for cpu 1
[    5.414545] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.16.0-rc5-00056-gd7753fd13f9e #86 NONE 
[    5.414548] Hardware name: Quanta JAVA ISLAND PVT 29F0EMAZ049/Java Island, BIOS F0EJ3A13 06/04/2025
[    5.414550] pstate: 61400009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[    5.414552] pc : pl011_console_write_atomic+0x94/0x170
[    5.414559] lr : pl011_console_write_atomic+0x84/0x170
[    5.414562] sp : ffff80008492f1a0
[    5.414564] pmr: 000000c0
[    5.414565] x29: ffff80008492f1a0 x28: 0000000000000000 x27: 00000000000000e0
[    5.414572] x26: 0000000000000190 x25: 0000000000000000 x24: 0000000000000000
[    5.414578] x23: 0000000000000001 x22: 0000000000000000 x21: ffff800080c38ea8
[    5.414584] x20: ffff80008492f288 x19: ffff0000b2060080 x18: 00000000ffffffff
[    5.414590] x17: 6362323230303030 x16: 3030303078303a30 x15: 206e6f6967657220
[    5.414595] x14: 3030303064322072 x13: 3030303063623232 x12: 3030303030303030
[    5.414601] x11: 78303a30206e6f69 x10: 6765722030303030 x9 : ffff800080c390e4
[    5.414607] x8 : 6964657220646e75 x7 : 205d313533383630 x6 : 302e30202020205b
[    5.414612] x5 : ffff0000ad10200f x4 : 0000000000000000 x3 : 0000000000000008
[    5.414618] x2 : ffff8000816336c0 x1 : 0000000000000018 x0 : 0000000000000018
[    5.414624] Call trace:
[    5.414626]  pl011_console_write_atomic+0x94/0x170 (P)
[    5.414630]  nbcon_emit_next_record+0x234/0x388
[    5.414634]  __nbcon_atomic_flush_pending_con+0x88/0x108
[    5.414637]  __nbcon_atomic_flush_pending+0x108/0x198
[    5.414640]  nbcon_atomic_flush_pending+0x24/0x38
[    5.414643]  vprintk_emit+0x200/0x348
[    5.414645]  vprintk_default+0x3c/0x50
[    5.414647]  vprintk+0x2c/0x40
[    5.414650]  _printk+0x50/0x60
[    5.414652]  register_console+0x424/0x560
[    5.414654]  serial_core_register_port+0x878/0x898
[    5.414659]  serial_ctrl_register_port+0x14/0x28
[    5.414661]  uart_add_one_port+0x14/0x28
[    5.414664]  pl011_register_port+0x74/0x130
[    5.414667]  sbsa_uart_probe+0x164/0x1b8
[    5.414670]  platform_probe+0x8c/0x100
[    5.414674]  really_probe+0xc4/0x398
[    5.414676]  __driver_probe_device+0x80/0x1a8
[    5.414679]  driver_probe_device+0x44/0x120
[    5.414681]  __device_attach_driver+0xb8/0x158
[    5.414683]  bus_for_each_drv+0x74/0xc0
[    5.414685]  __device_attach+0xac/0x1e0
[    5.414687]  device_initial_probe+0x18/0x28
[    5.414690]  bus_probe_device+0xa8/0xb8
[    5.414692]  device_add+0x648/0x830
[    5.414697]  platform_device_add+0x114/0x280
[    5.414700]  platform_device_register_full+0x148/0x1b8
[    5.414702]  acpi_create_platform_device+0x264/0x388
[    5.414706]  acpi_bus_attach+0x2c8/0x2e8
[    5.414709]  acpi_dev_for_one_check+0x38/0x48
[    5.414711]  device_for_each_child+0x54/0xa0
[    5.414714]  acpi_dev_for_each_child+0x30/0x40
[    5.414716]  acpi_bus_attach+0x6c/0x2e8
[    5.414718]  acpi_dev_for_one_check+0x38/0x48
[    5.414720]  device_for_each_child+0x54/0xa0
[    5.414723]  acpi_dev_for_each_child+0x30/0x40
[    5.414725]  acpi_bus_attach+0x6c/0x2e8
[    5.414727]  acpi_bus_scan+0x5c/0x1b0
[    5.414730]  acpi_scan_init+0xa0/0x288
[    5.414737]  acpi_init+0x1e8/0x4b8
[    5.414740]  do_one_initcall+0x3c/0x2a0
[    5.414743]  kernel_init_freeable+0x22c/0x460
[    5.414746]  kernel_init+0x28/0x1f0
[    5.414750]  ret_from_fork+0x10/0x20
[    5.415540] smp: csd: Re-sending CSD lock (#1) IPI from CPU#00 to CPU#01
[    5.415544] CPU: 0 UID: 0 PID: 14 Comm: kworker/u288:1 Not tainted 6.16.0-rc5-00056-gd7753fd13f9e #86 NONE 
[    5.415548] Hardware name: Quanta JAVA ISLAND PVT 29F0EMAZ049/Java Island, BIOS F0EJ3A13 06/04/2025
[    5.415550] Workqueue: events_unbound toggle_allocation_gate
[    5.415557] Call trace:
[    5.415560]  show_stack+0x1c/0x30 (C)
[    5.415564]  dump_stack_lvl+0x80/0xe8
[    5.415570]  dump_stack+0x14/0x20
[    5.415574]  csd_lock_wait_toolong+0x484/0x5e0
[    5.415577]  smp_call_function_many_cond+0x5e0/0x7f8
[    5.415581]  kick_all_cpus_sync+0x48/0x68
[    5.415585]  arch_jump_label_transform_apply+0x14/0x28
[    5.415590]  __jump_label_update+0x14c/0x230
[    5.415595]  jump_label_update+0x164/0x1b0
[    5.415598]  static_key_enable_cpuslocked+0xf8/0x138
[    5.415602]  static_key_enable+0x24/0x40
[    5.415605]  toggle_allocation_gate+0x5c/0x110
[    5.415608]  process_one_work+0x1e8/0x450
[    5.415614]  worker_thread+0x250/0x3c8
[    5.415616]  kthread+0x264/0x2e0
[    5.415620]  ret_from_fork+0x10/0x20
[    8.826703] smp: csd: CSD lock (#1) got unstuck on CPU#00, CPU#01 released the lock.
[    8.827333] ACPI: PCI Root Bridge [PCI2] (domain 0002 [bus 00-ff])
[    8.827341] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
[    8.827387] acpi PNP0A08:00: _OSC: platform does not support [PME AER DPC]
[    8.827437] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PCIeCapability LTR]
[    8.827850] acpi PNP0A08:00: ECAM area [mem 0x610010000000-0x61001fffffff] reserved by PNP0C02:01
[    8.827880] acpi PNP0A08:00: ECAM at [mem 0x610010000000-0x61001fffffff] for [bus 00-ff]
[    8.827893] ACPI: Remapped I/O 0x0000610020000000 to [io  0x0000-0xffff window]
[    8.827933] PCI host bridge to bus 0002:00
[    8.827938] pci_bus 0002:00: root bus resource [mem 0x610040000000-0x6100bfffffff window] (bus address [0x40000000-0xbfffffff])
[    8.827942] pci_bus 0002:00: root bus resource [mem 0x6100c0000000-0x617fffffffff window]
[    8.827944] pci_bus 0002:00: root bus resource [io  0x0000-0xffff window]
[    8.827947] pci_bus 0002:00: root bus resource [bus 00-ff]
[    8.827965] pci 0002:00:00.0: [10de:22b2] type 01 class 0x060400 PCIe Root Port
[    8.827980] pci 0002:00:00.0: PCI bridge to [bus 01]
[    8.827984] pci 0002:00:00.0:   bridge window [io  0x1000-0x1fff]
[    8.827987] pci 0002:00:00.0:   bridge window [mem 0x610040000000-0x6100402fffff]
[    8.827994] pci 0002:00:00.0:   bridge window [mem 0x6100c0000000-0x6100c17fffff 64bit pref]
[    8.828044] pci 0002:00:00.0: PME# supported from D0 D3hot
[    8.828287] pci 0002:01:00.0: [14e4:1750] type 00 class 0x020000 PCIe Endpoint
[    8.828321] pci 0002:01:00.0: BAR 0 [mem 0x6100c1000000-0x6100c100ffff 64bit pref]
[    8.828326] pci 0002:01:00.0: BAR 2 [mem 0x6100c0000000-0x6100c0ffffff 64bit pref]
[    8.828329] pci 0002:01:00.0: BAR 4 [mem 0x6100c1010000-0x6100c1017fff 64bit pref]
[    8.828333] pci 0002:01:00.0: ROM [mem 0x610040000000-0x61004007ffff pref]
[    8.828427] pci 0002:01:00.0: PME# supported from D0 D3hot D3cold
[    8.828613] pci_bus 0002:00: on NUMA node 0
[    8.828618] pci 0002:00:00.0: bridge window [io  0x1000-0x0fff] to [bus 01] add_size 1000
[    8.828621] pci 0002:00:00.0: bridge window [mem 0x00100000-0x000fffff] to [bus 01] add_size 300000 add_align 100000
[    8.828627] pci 0002:00:00.0: bridge window [mem 0x6100c0000000-0x6100c17fffff 64bit pref]: assigned
[    8.828630] pci 0002:00:00.0: bridge window [mem 0x610040000000-0x6100402fffff]: assigned
[    8.828632] pci 0002:00:00.0: bridge window [io  0x1000-0x1fff]: assigned
[    8.828636] pci 0002:01:00.0: BAR 2 [mem 0x6100c0000000-0x6100c0ffffff 64bit pref]: assigned
[    8.828644] pci 0002:01:00.0: ROM [mem 0x610040000000-0x61004007ffff pref]: assigned
[    8.828646] pci 0002:01:00.0: BAR 0 [mem 0x6100c1000000-0x6100c100ffff 64bit pref]: assigned
[    8.828654] pci 0002:01:00.0: BAR 4 [mem 0x6100c1010000-0x6100c1017fff 64bit pref]: assigned
[    8.828662] pci 0002:00:00.0: PCI bridge to [bus 01]
[    8.828666] pci 0002:00:00.0:   bridge window [io  0x1000-0x1fff]
[    8.828670] pci 0002:00:00.0:   bridge window [mem 0x610040000000-0x6100402fffff]
[    8.828673] pci 0002:00:00.0:   bridge window [mem 0x6100c0000000-0x6100c17fffff 64bit pref]
[    8.828677] pci_bus 0002:00: resource 4 [mem 0x610040000000-0x6100bfffffff window]
[    8.828680] pci_bus 0002:00: resource 5 [mem 0x6100c0000000-0x617fffffffff window]
[    8.828682] pci_bus 0002:00: resource 6 [io  0x0000-0xffff window]
[    8.828685] pci_bus 0002:01: resource 0 [io  0x1000-0x1fff]
[    8.828688] pci_bus 0002:01: resource 1 [mem 0x610040000000-0x6100402fffff]
[    8.828691] pci_bus 0002:01: resource 2 [mem 0x6100c0000000-0x6100c17fffff 64bit pref]
[    8.828792] ACPI: PCI Root Bridge [PCI3] (domain 0003 [bus 00-ff])
[    8.828797] acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
[    8.828831] acpi PNP0A08:01: _OSC: platform does not support [PME AER DPC]
[    8.828884] acpi PNP0A08:01: _OSC: OS now controls [PCIeHotplug PCIeCapability LTR]
[    8.829285] acpi PNP0A08:01: ECAM area [mem 0x618010000000-0x61801fffffff] reserved by PNP0C02:02
[    8.829300] acpi PNP0A08:01: ECAM at [mem 0x618010000000-0x61801fffffff] for [bus 00-ff]
[    8.829307] ACPI: Remapped I/O 0x0000618020000000 to [io  0x10000-0x1ffff window]
[    8.829337] PCI host bridge to bus 0003:00
[    8.829342] pci_bus 0003:00: root bus resource [mem 0x618040000000-0x6180bfffffff window] (bus address [0x40000000-0xbfffffff])
[    8.829346] pci_bus 0003:00: root bus resource [mem 0x6180c0000000-0x61ffffffffff window]
[    8.829349] pci_bus 0003:00: root bus resource [io  0x10000-0x1ffff window] (bus address [0x0000-0xffff])
[    8.829351] pci_bus 0003:00: root bus resource [bus 00-ff]
[    8.829370] pci 0003:00:00.0: [10de:22b8] type 01 class 0x060400 PCIe Root Port
[    8.829392] pci 0003:00:00.0: PCI bridge to [bus 01]
[    8.829398] pci 0003:00:00.0:   bridge window [io  0x10000-0x10fff]
[    8.829402] pci 0003:00:00.0:   bridge window [mem 0x618040000000-0x6180401fffff]
[    8.829411] pci 0003:00:00.0:   bridge window [mem 0x6180c0000000-0x6180c01fffff 64bit pref]
[    8.829494] pci 0003:00:00.0: PME# supported from D0 D3hot
[    8.829779] pci_bus 0003:00: on NUMA node 0
[    8.829781] pci 0003:00:00.0: bridge window [io  0x1000-0x0fff] to [bus 01] add_size 1000
[    8.829784] pci 0003:00:00.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 01] add_size 200000 add_align 100000
[    8.829787] pci 0003:00:00.0: bridge window [mem 0x00100000-0x000fffff] to [bus 01] add_size 200000 add_align 100000
[    8.829790] pci 0003:00:00.0: bridge window [mem 0x618040000000-0x6180401fffff]: assigned
[    8.829793] pci 0003:00:00.0: bridge window [mem 0x6180c0000000-0x6180c01fffff 64bit pref]: assigned
[    8.829795] pci 0003:00:00.0: bridge window [io  0x10000-0x10fff]: assigned
[    8.829798] pci 0003:00:00.0: PCI bridge to [bus 01]
[    8.829802] pci 0003:00:00.0:   bridge window [io  0x10000-0x10fff]
[    8.829807] pci 0003:00:00.0:   bridge window [mem 0x618040000000-0x6180401fffff]
[    8.829811] pci 0003:00:00.0:   bridge window [mem 0x6180c0000000-0x6180c01fffff 64bit pref]
[    8.829817] pci_bus 0003:00: resource 4 [mem 0x618040000000-0x6180bfffffff window]
[    8.829819] pci_bus 0003:00: resource 5 [mem 0x6180c0000000-0x61ffffffffff window]
[    8.829822] pci_bus 0003:00: resource 6 [io  0x10000-0x1ffff window]
[    8.829824] pci_bus 0003:01: resource 0 [io  0x10000-0x10fff]
[    8.829827] pci_bus 0003:01: resource 1 [mem 0x618040000000-0x6180401fffff]
[    8.829831] pci_bus 0003:01: resource 2 [mem 0x6180c0000000-0x6180c01fffff 64bit pref]
[    8.829883] ACPI: PCI Root Bridge [PCI6] (domain 0006 [bus 00-ff])
[    8.829888] acpi PNP0A08:02: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
[    8.829916] acpi PNP0A08:02: _OSC: platform does not support [PME AER DPC]
[    8.829961] acpi PNP0A08:02: _OSC: OS now controls [PCIeHotplug PCIeCapability LTR]
[    8.830358] acpi PNP0A08:02: ECAM area [mem 0x630010000000-0x63001fffffff] reserved by PNP0C02:03
[    8.830370] acpi PNP0A08:02: ECAM at [mem 0x630010000000-0x63001fffffff] for [bus 00-ff]
[    8.830378] ACPI: Remapped I/O 0x0000630020000000 to [io  0x20000-0x2ffff window]
[    8.830406] PCI host bridge to bus 0006:00
[    8.830410] pci_bus 0006:00: root bus resource [mem 0x630040000000-0x6300bfffffff window] (bus address [0x40000000-0xbfffffff])
[    8.830413] pci_bus 0006:00: root bus resource [mem 0x6300c0000000-0x63ffffffffff window]
[    8.830416] pci_bus 0006:00: root bus resource [io  0x20000-0x2ffff window] (bus address [0x0000-0xffff])
[    8.830418] pci_bus 0006:00: root bus resource [bus 00-ff]
[    8.830432] pci 0006:00:00.0: [10de:22b2] type 01 class 0x060400 PCIe Root Port
[    8.830444] pci 0006:00:00.0: PCI bridge to [bus 01]
[    8.830448] pci 0006:00:00.0:   bridge window [io  0x20000-0x20fff]
[    8.830451] pci 0006:00:00.0:   bridge window [mem 0x630040000000-0x6300402fffff]
[    8.830457] pci 0006:00:00.0:   bridge window [mem 0x6300c0000000-0x6300c01fffff 64bit pref]
[    8.830503] pci 0006:00:00.0: PME# supported from D0 D3hot
[    8.830723] pci 0006:01:00.0: [1344:51c3] type 00 class 0x010802 PCIe Endpoint
[    8.830764] pci 0006:01:00.0: BAR 0 [mem 0x630040000000-0x63004003ffff 64bit]
[    8.830772] pci 0006:01:00.0: ROM [mem 0x630040000000-0x63004003ffff pref]
[    8.830846] pci 0006:01:00.0: PME# supported from D0 D1 D3hot
[    8.830923] pci 0006:01:00.0: 31.504 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x4 link at 0006:00:00.0 (capable of 63.012 Gb/s with 16.0 GT/s PCIe x4 link)
[    8.830983] pci_bus 0006:00: on NUMA node 0
[    8.830986] pci 0006:00:00.0: bridge window [io  0x1000-0x0fff] to [bus 01] add_size 1000
[    8.830989] pci 0006:00:00.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 01] add_size 200000 add_align 100000
[    8.830992] pci 0006:00:00.0: bridge window [mem 0x00100000-0x001fffff] to [bus 01] add_size 200000 add_align 100000
[    8.830996] pci 0006:00:00.0: bridge window [mem 0x630040000000-0x6300402fffff]: assigned
[    8.830998] pci 0006:00:00.0: bridge window [mem 0x6300c0000000-0x6300c01fffff 64bit pref]: assigned
[    8.831001] pci 0006:00:00.0: bridge window [io  0x20000-0x20fff]: assigned
[    8.831005] pci 0006:01:00.0: BAR 0 [mem 0x630040000000-0x63004003ffff 64bit]: assigned
[    8.831015] pci 0006:01:00.0: ROM [mem 0x630040040000-0x63004007ffff pref]: assigned
[    8.831018] pci 0006:00:00.0: PCI bridge to [bus 01]
[    8.831020] pci 0006:00:00.0:   bridge window [io  0x20000-0x20fff]
[    8.831024] pci 0006:00:00.0:   bridge window [mem 0x630040000000-0x6300402fffff]
[    8.831029] pci 0006:00:00.0:   bridge window [mem 0x6300c0000000-0x6300c01fffff 64bit pref]
[    8.831033] pci_bus 0006:00: resource 4 [mem 0x630040000000-0x6300bfffffff window]
[    8.831036] pci_bus 0006:00: resource 5 [mem 0x6300c0000000-0x63ffffffffff window]
[    8.831039] pci_bus 0006:00: resource 6 [io  0x20000-0x2ffff window]
[    8.831041] pci_bus 0006:01: resource 0 [io  0x20000-0x20fff]
[    8.831044] pci_bus 0006:01: resource 1 [mem 0x630040000000-0x6300402fffff]
[    8.831047] pci_bus 0006:01: resource 2 [mem 0x6300c0000000-0x6300c01fffff 64bit pref]
[    8.831138] ACPI: PCI Root Bridge [PCI7] (domain 0007 [bus 00-ff])
[    8.831141] acpi PNP0A08:03: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
[    8.831169] acpi PNP0A08:03: _OSC: platform does not support [PME AER DPC]
[    8.831215] acpi PNP0A08:03: _OSC: OS now controls [PCIeHotplug PCIeCapability LTR]
[    8.831617] acpi PNP0A08:03: ECAM area [mem 0x640010000000-0x64001fffffff] reserved by PNP0C02:04
[    8.831629] acpi PNP0A08:03: ECAM at [mem 0x640010000000-0x64001fffffff] for [bus 00-ff]
[    8.831636] ACPI: Remapped I/O 0x0000640020000000 to [io  0x30000-0x3ffff window]
[    8.831672] PCI host bridge to bus 0007:00
[    8.831676] pci_bus 0007:00: root bus resource [mem 0x640040000000-0x6400bfffffff window] (bus address [0x40000000-0xbfffffff])
[    8.831679] pci_bus 0007:00: root bus resource [mem 0x6400c0000000-0x64ffffffffff window]
[    8.831681] pci_bus 0007:00: root bus resource [io  0x30000-0x3ffff window] (bus address [0x0000-0xffff])
[    8.831684] pci_bus 0007:00: root bus resource [bus 00-ff]
[    8.831702] pci 0007:00:00.0: [10de:22b8] type 01 class 0x060400 PCIe Root Port
[    8.831722] pci 0007:00:00.0: PCI bridge to [bus 01]
[    8.831730] pci 0007:00:00.0:   bridge window [io  0x30000-0x30fff]
[    8.831734] pci 0007:00:00.0:   bridge window [mem 0x640040000000-0x6400401fffff]
[    8.831742] pci 0007:00:00.0:   bridge window [mem 0x6400c0000000-0x6400c01fffff 64bit pref]
[    8.831823] pci 0007:00:00.0: PME# supported from D0 D3hot
[    8.832100] pci_bus 0007:00: on NUMA node 0
[    8.832102] pci 0007:00:00.0: bridge window [io  0x1000-0x0fff] to [bus 01] add_size 1000
[    8.832105] pci 0007:00:00.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 01] add_size 200000 add_align 100000
[    8.832108] pci 0007:00:00.0: bridge window [mem 0x00100000-0x000fffff] to [bus 01] add_size 200000 add_align 100000
[    8.832112] pci 0007:00:00.0: bridge window [mem 0x640040000000-0x6400401fffff]: assigned
[    8.832115] pci 0007:00:00.0: bridge window [mem 0x6400c0000000-0x6400c01fffff 64bit pref]: assigned
[    8.832118] pci 0007:00:00.0: bridge window [io  0x30000-0x30fff]: assigned
[    8.832121] pci 0007:00:00.0: PCI bridge to [bus 01]
[    8.832124] pci 0007:00:00.0:   bridge window [io  0x30000-0x30fff]
[    8.832128] pci 0007:00:00.0:   bridge window [mem 0x640040000000-0x6400401fffff]
[    8.832132] pci 0007:00:00.0:   bridge window [mem 0x6400c0000000-0x6400c01fffff 64bit pref]
[    8.832138] pci_bus 0007:00: resource 4 [mem 0x640040000000-0x6400bfffffff window]
[    8.832141] pci_bus 0007:00: resource 5 [mem 0x6400c0000000-0x64ffffffffff window]
[    8.832145] pci_bus 0007:00: resource 6 [io  0x30000-0x3ffff window]
[    8.832147] pci_bus 0007:01: resource 0 [io  0x30000-0x30fff]
[    8.832150] pci_bus 0007:01: resource 1 [mem 0x640040000000-0x6400401fffff]
[    8.832153] pci_bus 0007:01: resource 2 [mem 0x6400c0000000-0x6400c01fffff 64bit pref]
[    8.832209] ACPI: PCI Root Bridge [PCI8] (domain 0008 [bus 00-ff])
[    8.832212] acpi PNP0A08:04: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
[    8.832238] acpi PNP0A08:04: _OSC: platform does not support [PME AER DPC]
[    8.832283] acpi PNP0A08:04: _OSC: OS now controls [PCIeHotplug PCIeCapability LTR]
[    8.832700] acpi PNP0A08:04: ECAM area [mem 0x650010000000-0x65001fffffff] reserved by PNP0C02:05
[    8.832712] acpi PNP0A08:04: ECAM at [mem 0x650010000000-0x65001fffffff] for [bus 00-ff]
[    8.832720] ACPI: Remapped I/O 0x0000650020000000 to [io  0x40000-0x4ffff window]
[    8.832753] PCI host bridge to bus 0008:00
[    8.832758] pci_bus 0008:00: root bus resource [mem 0x650040000000-0x6500bfffffff window] (bus address [0x40000000-0xbfffffff])
[    8.832760] pci_bus 0008:00: root bus resource [mem 0x6500c0000000-0x65ffffffffff window]
[    8.832763] pci_bus 0008:00: root bus resource [io  0x40000-0x4ffff window] (bus address [0x0000-0xffff])
[    8.832765] pci_bus 0008:00: root bus resource [bus 00-ff]
[    8.832785] pci 0008:00:00.0: [10de:22b9] type 01 class 0x060400 PCIe Root Port
[    8.832806] pci 0008:00:00.0: PCI bridge to [bus 01]
[    8.832813] pci 0008:00:00.0:   bridge window [io  0x40000-0x40fff]
[    8.832817] pci 0008:00:00.0:   bridge window [mem 0x650040000000-0x6500401fffff]
[    8.832826] pci 0008:00:00.0:   bridge window [mem 0x6500c0000000-0x6500c01fffff 64bit pref]
[    8.832908] pci 0008:00:00.0: PME# supported from D0 D3hot
[    8.833180] pci_bus 0008:00: on NUMA node 0
[    8.833184] pci 0008:00:00.0: bridge window [io  0x1000-0x0fff] to [bus 01] add_size 1000
[    8.833186] pci 0008:00:00.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 01] add_size 200000 add_align 100000
[    8.833189] pci 0008:00:00.0: bridge window [mem 0x00100000-0x000fffff] to [bus 01] add_size 200000 add_align 100000
[    8.833192] pci 0008:00:00.0: bridge window [mem 0x650040000000-0x6500401fffff]: assigned
[    8.833195] pci 0008:00:00.0: bridge window [mem 0x6500c0000000-0x6500c01fffff 64bit pref]: assigned
[    8.833197] pci 0008:00:00.0: bridge window [io  0x40000-0x40fff]: assigned
[    8.833200] pci 0008:00:00.0: PCI bridge to [bus 01]
[    8.833203] pci 0008:00:00.0:   bridge window [io  0x40000-0x40fff]
[    8.833208] pci 0008:00:00.0:   bridge window [mem 0x650040000000-0x6500401fffff]
[    8.833211] pci 0008:00:00.0:   bridge window [mem 0x6500c0000000-0x6500c01fffff 64bit pref]
[    8.833217] pci_bus 0008:00: resource 4 [mem 0x650040000000-0x6500bfffffff window]
[    8.833219] pci_bus 0008:00: resource 5 [mem 0x6500c0000000-0x65ffffffffff window]
[    8.833222] pci_bus 0008:00: resource 6 [io  0x40000-0x4ffff window]
[    8.833225] pci_bus 0008:01: resource 0 [io  0x40000-0x40fff]
[    8.833227] pci_bus 0008:01: resource 1 [mem 0x650040000000-0x6500401fffff]
[    8.833230] pci_bus 0008:01: resource 2 [mem 0x6500c0000000-0x6500c01fffff 64bit pref]
[    8.833567] iommu: Default domain type: Passthrough (set via kernel command line)
[    9.748361] SCSI subsystem initialized
[    9.748370] libata version 3.00 loaded.
[    9.748391] ACPI: bus type USB registered
[    9.748404] usbcore: registered new interface driver usbfs
[    9.748411] usbcore: registered new interface driver hub
[    9.748424] usbcore: registered new device driver usb
[    9.748464] pps_core: LinuxPPS API ver. 1 registered
[    9.748466] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    9.748469] PTP clock support registered
[    9.748564] EDAC MC: Ver: 3.0.0
[    9.748648] scmi_core: SCMI protocol bus registered
[    9.748682] efivars: Registered efivars operations
[    9.763956] clocksource: Switched to clocksource arch_sys_counter
[    9.764077] Warning: could not register annotated branches stats
[    9.764372] VFS: Disk quotas dquot_6.6.0
[    9.764381] VFS: Dquot-cache hash table entries: 8192 (order 0, 65536 bytes)
[    9.794973] pnp: PnP ACPI init
[    9.795170] system 00:00: [mem 0x610010000000-0x61001fffffff window] could not be reserved
[    9.795195] system 00:01: [mem 0x618010000000-0x61801fffffff window] could not be reserved
[    9.795215] system 00:02: [mem 0x630010000000-0x63001fffffff window] could not be reserved
[    9.795235] system 00:03: [mem 0x640010000000-0x64001fffffff window] could not be reserved
[    9.795254] system 00:04: [mem 0x650010000000-0x65001fffffff window] could not be reserved
[    9.795259] pnp: PnP ACPI: found 5 devices
[    9.796910] NET: Registered PF_INET protocol family
[    9.796965] IP idents hash table entries: 262144 (order: 5, 2097152 bytes, linear)
[    9.806138] tcp_listen_portaddr_hash hash table entries: 65536 (order: 5, 2097152 bytes, linear)
[    9.806432] Table-perturb hash table entries: 65536 (order: 2, 262144 bytes, linear)
[    9.806439] TCP established hash table entries: 524288 (order: 6, 4194304 bytes, linear)
[    9.807409] TCP bind hash table entries: 65536 (order: 6, 4194304 bytes, linear)
[    9.807967] TCP: Hash tables configured (established 524288 bind 65536)
[    9.808186] MPTCP token hash table entries: 65536 (order: 5, 3145728 bytes, linear)
[    9.808526] UDP hash table entries: 65536 (order: 7, 10485760 bytes, linear)
[    9.810122] UDP-Lite hash table entries: 65536 (order: 7, 10485760 bytes, linear)
[    9.811792] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    9.811801] NET: Registered PF_XDP protocol family
[    9.811830] PCI: CLS 64 bytes, default 64
[    9.811902] Trying to unpack rootfs image as initramfs...
[    9.827215] kvm [1]: nv: 566 coarse grained trap handlers
[    9.827286] kvm [1]: IPA Size Limit: 48 bits
[    9.842650] kvm [1]: GICv4 support disabled
[    9.842652] kvm [1]: GICv3: no GICV resource entry
[    9.842654] kvm [1]: disabling GICv2 emulation
[    9.856294] kvm [1]: GIC system register CPU interface enabled
[    9.856311] kvm [1]: vgic interrupt IRQ9
[    9.882011] kvm [1]: VHE mode initialized successfully
[    9.906518] Initialise system trusted keyrings
[    9.906571] workingset: timestamp_bits=40 max_order=22 bucket_order=0
[    9.906797] fuse: init (API version 7.44)
[    9.906864] SGI XFS with ACLs, security attributes, realtime, quota, no debug enabled
[    9.907175] cryptd: max_cpu_qlen set to 1000
[    9.915059] NET: Registered PF_ALG protocol family
[    9.915066] xor: measuring software checksum speed
[    9.915156]    8regs           : 37215 MB/sec
[    9.915246]    32regs          : 37242 MB/sec
[    9.915324]    arm64_neon      : 42791 MB/sec
[    9.915326] xor: using function: arm64_neon (42791 MB/sec)
[    9.915330] Key type asymmetric registered
[    9.915332] Asymmetric key parser 'x509' registered
[    9.915353] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 243)
[    9.915404] io scheduler mq-deadline registered
[    9.915407] io scheduler kyber registered
[    9.919590] Memory allocation profiling is not supported!
[    9.941873] thermal LNXTHERM:00: registered as thermal_zone0
[    9.941877] ACPI: thermal: Thermal Zone [TZ00] (51 C)
[    9.942232] thermal LNXTHERM:01: registered as thermal_zone1
[    9.942235] ACPI: thermal: Thermal Zone [TZ01] (51 C)
[    9.942560] thermal LNXTHERM:02: registered as thermal_zone2
[    9.942562] ACPI: thermal: Thermal Zone [TZ02] (52 C)
[    9.942888] thermal LNXTHERM:03: registered as thermal_zone3
[    9.942890] ACPI: thermal: Thermal Zone [TZ03] (52 C)
[    9.943212] thermal LNXTHERM:04: registered as thermal_zone4
[    9.943214] ACPI: thermal: Thermal Zone [TZ04] (50 C)
[    9.943536] thermal LNXTHERM:05: registered as thermal_zone5
[    9.943538] ACPI: thermal: Thermal Zone [TZ05] (51 C)
[    9.943859] thermal LNXTHERM:06: registered as thermal_zone6
[    9.943860] ACPI: thermal: Thermal Zone [TZ06] (51 C)
[    9.944186] thermal LNXTHERM:07: registered as thermal_zone7
[    9.944188] ACPI: thermal: Thermal Zone [TZ07] (47 C)
[    9.944508] thermal LNXTHERM:08: registered as thermal_zone8
[    9.944510] ACPI: thermal: Thermal Zone [TZ08] (41 C)
[    9.944854] thermal LNXTHERM:09: registered as thermal_zone9
[    9.944856] ACPI: thermal: Thermal Zone [TZ09] (52 C)
[    9.945179] thermal LNXTHERM:0a: registered as thermal_zone10
[    9.945181] ACPI: thermal: Thermal Zone [TZ0A] (40 C)
[    9.945502] thermal LNXTHERM:0b: registered as thermal_zone11
[    9.945503] ACPI: thermal: Thermal Zone [TZ0B] (43 C)
[    9.945569] thermal LNXTHERM:0c: registered as thermal_zone12
[    9.945571] ACPI: thermal: Thermal Zone [TZL0] (48 C)
[    9.945593] ERST: Error Record Serialization Table (ERST) support is initialized.
[    9.947628] pstore: Using crash dump compression: deflate
[    9.947631] pstore: Registered erst as persistent store backend
[    9.947676] EINJ: Error INJection is initialized.
[    9.947716] ACPI GTDT: found 1 SBSA generic Watchdog(s).
[    9.947885] Tegra Revision: A02 SKU: 38 CPU Process: 0 SoC Process: 0
[    9.948040] Serial: 8250/16550 driver, 16 ports, IRQ sharing enabled
[    9.948836] arm-smmu-v3 arm-smmu-v3.5.auto: option mask 0x0
[    9.948847] arm-smmu-v3 arm-smmu-v3.5.auto: ias 48-bit, oas 48-bit (features 0x001e1fbf)
[    9.949000] arm-smmu-v3 arm-smmu-v3.5.auto: allocated 524288 entries for cmdq
[    9.949293] arm-smmu-v3 arm-smmu-v3.5.auto: allocated 524288 entries for evtq
[    9.949457] arm-smmu-v3 arm-smmu-v3.5.auto: allocated 524288 entries for priq
[    9.949508] arm-smmu-v3 arm-smmu-v3.5.auto: msi_domain absent - falling back to wired irqs
[    9.949569] arm-smmu-v3 arm-smmu-v3.5.auto: no priq irq - PRI will be broken
[    9.949633] platform NVDA2006:00: Adding to iommu group 0
[    9.949649] platform NVDA2003:00: Adding to iommu group 1
[    9.949664] platform NVDA1513:00: Adding to iommu group 2
[    9.949731] arm-smmu-v3 arm-smmu-v3.6.auto: option mask 0x0
[    9.949739] arm-smmu-v3 arm-smmu-v3.6.auto: ias 48-bit, oas 48-bit (features 0x001e1fbf)
[    9.949889] arm-smmu-v3 arm-smmu-v3.6.auto: allocated 524288 entries for cmdq
[    9.950181] arm-smmu-v3 arm-smmu-v3.6.auto: allocated 524288 entries for evtq
[    9.950343] arm-smmu-v3 arm-smmu-v3.6.auto: allocated 524288 entries for priq
[    9.950390] arm-smmu-v3 arm-smmu-v3.6.auto: msi_domain absent - falling back to wired irqs
[    9.950442] arm-smmu-v3 arm-smmu-v3.6.auto: no priq irq - PRI will be broken
[    9.950528] pci 0002:00:00.0: Adding to iommu group 3
[    9.950544] pci 0002:01:00.0: Adding to iommu group 4
[    9.950558] pci 0003:00:00.0: Adding to iommu group 5
[    9.950582] arm-smmu-v3 arm-smmu-v3.7.auto: option mask 0x0
[    9.950591] arm-smmu-v3 arm-smmu-v3.7.auto: ias 48-bit, oas 48-bit (features 0x001e1fbf)
[    9.950737] arm-smmu-v3 arm-smmu-v3.7.auto: allocated 524288 entries for cmdq
[    9.951034] arm-smmu-v3 arm-smmu-v3.7.auto: allocated 524288 entries for evtq
[    9.951196] arm-smmu-v3 arm-smmu-v3.7.auto: allocated 524288 entries for priq
[    9.951243] arm-smmu-v3 arm-smmu-v3.7.auto: msi_domain absent - falling back to wired irqs
[    9.951292] arm-smmu-v3 arm-smmu-v3.7.auto: no priq irq - PRI will be broken
[    9.951374] pci 0006:00:00.0: Adding to iommu group 6
[    9.951390] pci 0006:01:00.0: Adding to iommu group 7
[    9.951405] pci 0007:00:00.0: Adding to iommu group 8
[    9.951426] arm-smmu-v3 arm-smmu-v3.8.auto: option mask 0x0
[    9.951434] arm-smmu-v3 arm-smmu-v3.8.auto: ias 48-bit, oas 48-bit (features 0x001e1fbf)
[    9.951580] arm-smmu-v3 arm-smmu-v3.8.auto: allocated 524288 entries for cmdq
[    9.951872] arm-smmu-v3 arm-smmu-v3.8.auto: allocated 524288 entries for evtq
[    9.952038] arm-smmu-v3 arm-smmu-v3.8.auto: allocated 524288 entries for priq
[    9.952085] arm-smmu-v3 arm-smmu-v3.8.auto: msi_domain absent - falling back to wired irqs
[    9.952134] arm-smmu-v3 arm-smmu-v3.8.auto: no priq irq - PRI will be broken
[    9.952206] arm-smmu-v3 arm-smmu-v3.9.auto: option mask 0x0
[    9.952213] arm-smmu-v3 arm-smmu-v3.9.auto: ias 48-bit, oas 48-bit (features 0x001e1fbf)
[    9.952360] arm-smmu-v3 arm-smmu-v3.9.auto: allocated 524288 entries for cmdq
[    9.952652] arm-smmu-v3 arm-smmu-v3.9.auto: allocated 524288 entries for evtq
[    9.952816] arm-smmu-v3 arm-smmu-v3.9.auto: allocated 524288 entries for priq
[    9.952863] arm-smmu-v3 arm-smmu-v3.9.auto: msi_domain absent - falling back to wired irqs
[    9.952917] arm-smmu-v3 arm-smmu-v3.9.auto: no priq irq - PRI will be broken
[    9.953006] pci 0008:00:00.0: Adding to iommu group 9
[    9.963864] wireguard: WireGuard 1.0.0 loaded. See www.wireguard.com for information.
[    9.963866] wireguard: Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
[    9.963878] nvme nvme0: pci function 0006:01:00.0
[    9.992700] bnxt_en 0002:01:00.0 eth0: Broadcom BCM57508 NetXtreme-E 10Gb/25Gb/50Gb/100Gb/200Gb Ethernet found at mem 6100c1000000, node addr d4:04:e6:3f:8a:96
[    9.992710] bnxt_en 0002:01:00.0: 63.012 Gb/s available PCIe bandwidth (16.0 GT/s PCIe x4 link)
[    9.992796] igb: Intel(R) Gigabit Ethernet Network Driver
[    9.992799] igb: Copyright (c) 2007-2014 Intel Corporation.
[    9.992808] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver
[    9.992810] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
[    9.993065] usbcore: registered new interface driver ark3116
[    9.993070] usbserial: USB Serial support registered for ark3116
[    9.993076] usbcore: registered new interface driver pl2303
[    9.993082] usbserial: USB Serial support registered for pl2303
[    9.993977] rtc-efi rtc-efi.0: registered as rtc0
[    9.994381] rtc-efi rtc-efi.0: setting system clock to 2025-07-11T10:28:00 UTC (1752229680)
[    9.994408] i2c_dev: i2c /dev entries driver
[    9.995186] sbsa-gwdt sbsa-gwdt.0: Initialized with 10s timeout @ 1000000000 Hz, action=0.
[    9.995246] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will not be recorded in the IMA log.
[    9.995311] device-mapper: ioctl: 4.50.0-ioctl (2025-04-28) initialised: dm-devel@lists.linux.dev
[    9.995919] SMCCC: SOC_ID: ID = jep106:036b:0241 Revision = 0x00000002
[    9.995984] usbcore: registered new interface driver usbhid
[    9.995986] usbhid: USB HID core driver
[    9.997279] nvme nvme0: 72/0/0 default/read/poll queues
[   10.008186] hw perfevents: enabled with armv8_pmuv3_0 PMU driver, 7 (0,8000003f) counters available, using NMIs
[   10.008303] Initializing XFRM netlink socket
[   10.008323] NET: Registered PF_INET6 protocol family
[   10.008874] Segment Routing with IPv6
[   10.008882] In-situ OAM (IOAM) with IPv6
[   10.008910] NET: Registered PF_PACKET protocol family
[   10.008970] Key type dns_resolver registered
[   10.009017] NET: Registered PF_VSOCK protocol family
[   10.011353]  nvme0n1: p1 p2 p3
[   10.012387] registered taskstats version 1
[   10.012774] Loading compiled-in X.509 certificates
[   10.016700] Freeing initrd memory: 25280K
[   10.019092] Loaded X.509 cert 'Build time autogenerated kernel key: 1a46e001355c3b4d6acb43ef64aa5cb4f9aa6815'
[   10.021612] Demotion targets for Node 0: null
[   10.021618] debug_vm_pgtable: [debug_vm_pgtable         ]: Validating architecture page table helpers
[   10.022019] Btrfs loaded, zoned=no, fsverity=yes
[   10.022062] ima: No TPM chip found, activating TPM-bypass!
[   10.022066] ima: Allocated hash algorithm: sha256
[   10.022077] ima: No architecture policies found
[   10.022332] pcieport 0002:00:00.0: PME: Signaling with IRQ 165
[   10.022404] pcieport 0002:00:00.0: AER: enabled with IRQ 165
[   10.022428] pcieport 0002:00:00.0: pciehp: Slot #2 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl+ IbPresDis- LLActRep+
[   10.022530] pcieport 0002:00:00.0: DPC: enabled with IRQ 165
[   10.022532] pcieport 0002:00:00.0: DPC: error containment capabilities: Int Msg #0, RPExt- PoisonedTLP+ SwTrigger+ RP PIO Log 0, DL_ActiveErr+
[   10.022682] pcieport 0003:00:00.0: PME: Signaling with IRQ 166
[   10.022740] pcieport 0003:00:00.0: AER: enabled with IRQ 166
[   10.022758] pcieport 0003:00:00.0: pciehp: Slot #3 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl+ IbPresDis- LLActRep+
[   10.022853] pcieport 0003:00:00.0: DPC: enabled with IRQ 166
[   10.022855] pcieport 0003:00:00.0: DPC: error containment capabilities: Int Msg #0, RPExt- PoisonedTLP+ SwTrigger+ RP PIO Log 0, DL_ActiveErr+
[   10.023028] pcieport 0006:00:00.0: PME: Signaling with IRQ 167
[   10.023082] pcieport 0006:00:00.0: AER: enabled with IRQ 167
[   10.023099] pcieport 0006:00:00.0: pciehp: Slot #6 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl+ IbPresDis- LLActRep+
[   10.023194] pcieport 0006:00:00.0: DPC: enabled with IRQ 167
[   10.023196] pcieport 0006:00:00.0: DPC: error containment capabilities: Int Msg #0, RPExt- PoisonedTLP+ SwTrigger+ RP PIO Log 0, DL_ActiveErr+
[   10.023337] pcieport 0007:00:00.0: PME: Signaling with IRQ 168
[   10.023395] pcieport 0007:00:00.0: AER: enabled with IRQ 168
[   10.023413] pcieport 0007:00:00.0: pciehp: Slot #7 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl+ IbPresDis- LLActRep+
[   10.023507] pcieport 0007:00:00.0: DPC: enabled with IRQ 168
[   10.023509] pcieport 0007:00:00.0: DPC: error containment capabilities: Int Msg #0, RPExt- PoisonedTLP+ SwTrigger+ RP PIO Log 0, DL_ActiveErr+
[   10.023678] pcieport 0008:00:00.0: PME: Signaling with IRQ 169
[   10.023739] pcieport 0008:00:00.0: AER: enabled with IRQ 169
[   10.023758] pcieport 0008:00:00.0: pciehp: Slot #8 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl+ IbPresDis- LLActRep+
[   10.023852] pcieport 0008:00:00.0: DPC: enabled with IRQ 169
[   10.023854] pcieport 0008:00:00.0: DPC: error containment capabilities: Int Msg #0, RPExt- PoisonedTLP+ SwTrigger+ RP PIO Log 0, DL_ActiveErr+
[   10.023969] netpoll: netconsole: local port 6666
[   10.023972] netpoll: netconsole: local IPv6 address 2401:db00:209c:171e:face:0:172:0
[   10.023975] netpoll: netconsole: interface name 'eth0'
[   10.023976] netpoll: netconsole: local ethernet address 'ff:ff:ff:ff:ff:ff'
[   10.023978] netpoll: netconsole: remote port 1514
[   10.023980] netpoll: netconsole: remote IPv6 address 2401:db00:eef0:a59::
[   10.023982] netpoll: netconsole: remote ethernet address 76:d4:dd:68:c3:59
[   10.023986] netpoll: netconsole: device eth0 not up yet, forcing it
[   10.038132] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[   10.059252] bnxt_en 0002:01:00.0 eth0: NIC Link is Up, 50000 Mbps (PAM4 56Gbps) full duplex, Flow control: ON - receive
[   10.059257] bnxt_en 0002:01:00.0 eth0: FEC autoneg off encoding: Clause 91 RS544_1XN
[   10.124060] printk: legacy console [netcon_ext0] enabled
[   10.127011] printk: legacy console [netcon0] enabled
[   10.127018] netconsole: network logging started
[   10.134790] clk: Disabling unused clocks
[   10.134804] PM: genpd: Disabling unused power domains
[   10.197303] Freeing unused kernel memory: 11264K
[   10.208685] Run /init as init process
[   10.208694]   with arguments:
[   10.208698]     /init
[   10.208703]   with environment:
[   10.208708]     HOME=/
[   10.208712]     TERM=linux
[   10.208717]     BOOT_IMAGE=(hd0,gpt2)/vmlinuz-6.16.0-rc5-00055-g0c759ecd169d
[   10.208721]     biosdevname=0
[   10.269385] autofs4: module verification failed: signature and/or required key missing - tainting kernel
[   10.356195] systemd[1]: Inserted module 'autofs4'
[   10.451466] systemd[1]: Successfully made /usr/ read-only.
[   10.567346] systemd[1]: systemd 257.6-1.2.hs+fb.el9 running in system mode (+PAM +AUDIT +SELINUX -APPARMOR +IMA +IPE +SMACK +SECCOMP -GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN -IPTC +KMOD +LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT -QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +BTF +XKBCOMMON +UTMP +SYSVINIT +LIBARCHIVE)
[   10.567368] systemd[1]: Detected architecture arm64.
[   10.567440] systemd[1]: Running in initrd.
[   10.674975] systemd[1]: Hostname set to <foo>.
[   10.874501] systemd[1]: Queued start job for default target initrd.target.
[   11.236688] systemd[1]: Created slice hostcritical.slice - Slice /hostcritical.
[   11.420057] systemd[1]: Started systemd-ask-password-console.path - Dispatch Password Requests to Console Directory Watch.
[   11.576918] systemd[1]: Expecting device dev-disk-by\x2duuid-f89a029a\x2d5900\x2d4918\x2dae30\x2de8657630c770.device - /dev/disk/by-uuid/f89a029a-5900-4918-ae30-e8657630c770...
[   11.734953] systemd[1]: Reached target initrd-usr-fs.target - Initrd /usr File System.
[   11.851386] systemd[1]: Reached target paths.target - Path Units.
[   12.027700] systemd[1]: Reached target slices.target - Slice Units.
[   12.189924] systemd[1]: Reached target swap.target - Swaps.
[   12.311069] systemd[1]: Reached target timers.target - Timer Units.
[   12.482468] systemd[1]: Listening on systemd-journald-dev-log.socket - Journal Socket (/dev/log).
[   12.656973] systemd[1]: Listening on systemd-journald.socket - Journal Sockets.
[   12.803593] systemd[1]: Listening on systemd-udevd-control.socket - udev Control Socket.
[   12.949672] systemd[1]: Listening on systemd-udevd-kernel.socket - udev Kernel Socket.
[   13.080970] systemd[1]: Reached target sockets.target - Socket Units.
[   13.252981] systemd[1]: Starting kmod-static-nodes.service - Create List of Static Device Nodes...
[   13.513924] systemd[1]: Starting systemd-journald.service - Journal Service...
[   13.646755] systemd[1]: Starting systemd-modules-load.service - Load Kernel Modules...
[   13.737157] systemd[1]: Starting systemd-vconsole-setup.service - Virtual Console Setup...
[   13.811226] loop: module loaded
[   13.878644] systemd[1]: Finished kmod-static-nodes.service - Create List of Static Device Nodes.
[   13.896157] power_meter ACPI000D:01: Found ACPI power meter.
[   13.896238] power_meter ACPI000D:02: Found ACPI power meter.
[   13.896282] power_meter ACPI000D:03: Found ACPI power meter.
[   14.032223] systemd[1]: Started systemd-journald.service - Journal Service.
[   15.874967] tegra-qspi NVDA1513:00: cannot use DMA: -19
[   15.875001] tegra-qspi NVDA1513:00: falling back to PIO
[   15.875160] tegra-qspi NVDA1513:00: device reset failed
[   15.883114] tpm_tis_spi spi-PRP0001:01: 2.0 TPM (device-id 0x1B, rev-id 22)
[   16.215299] BTRFS: device label / devid 1 transid 245397 /dev/nvme0n1p3 (259:3) scanned by mount (908)
[   16.215933] BTRFS info (device nvme0n1p3): first mount of filesystem f89a029a-5900-4918-ae30-e8657630c770
[   16.215949] BTRFS info (device nvme0n1p3): using crc32c (crc32c-arm64) checksum algorithm
[   16.215962] BTRFS info (device nvme0n1p3): forcing free space tree for sector size 4096 with page size 65536
[   16.215970] BTRFS info (device nvme0n1p3): using free-space-tree
[   17.186909] systemd[1]: systemd 257.6-1.2.hs+fb.el9 running in system mode (+PAM +AUDIT +SELINUX -APPARMOR +IMA +IPE +SMACK +SECCOMP -GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN -IPTC +KMOD +LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT -QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +BTF +XKBCOMMON +UTMP +SYSVINIT +LIBARCHIVE)
[   17.186923] systemd[1]: Detected architecture arm64.
[   17.279527] systemd[1]: bpf-restrict-fs: LSM BPF program attached
[   17.294875] systemd-sysv-generator[962]: SysV service '/etc/rc.d/init.d/webserver' lacks a native systemd unit file, automatically generating a unit file for compatibility.
[   17.294909] systemd-sysv-generator[962]: Please update package to include a native systemd unit file.
[   17.294919] systemd-sysv-generator[962]: ⚠️ This compatibility logic is deprecated, expect removal soon. ⚠️
[   17.466546] systemd[1]: /usr/lib/systemd/system/smtpdlite.service:11: Special user nobody configured, this is not safe!
[   17.552288] systemd[1]: /etc/systemd/system/selinux_status.service:13: Special user nobody configured, this is not safe!
[   17.635466] systemd[1]: initrd-switch-root.service: Deactivated successfully.
[   17.635643] systemd[1]: Stopped initrd-switch-root.service - Switch Root.
[   17.651936] systemd[1]: systemd-journald.service: Scheduled restart job, restart counter is at 1.
[   17.652538] systemd[1]: Created slice overcommit.slice - Overcommit Slice.
[   17.669633] systemd[1]: Created slice system-fb_scm_daemon.slice - Slice /system/fb_scm_daemon.
[   17.690696] systemd[1]: Created slice system-fbwatchman.slice - Slice /system/fbwatchman.
[   17.710570] systemd[1]: Created slice system-getty.slice - Slice /system/getty.
[   17.727572] systemd[1]: Created slice system-mcrouter.slice - Slice /system/mcrouter.
[   17.746558] systemd[1]: Created slice system-serial\x2dgetty.slice - Slice /system/serial-getty.
[   17.766471] systemd[1]: Created slice system-sshd\x2dkeygen.slice - Slice /system/sshd-keygen.
[   17.786234] systemd[1]: Created slice user.slice - User and Session Slice.
[   17.803337] systemd[1]: Created slice workload.slice - Workload Slice.
[   17.819250] systemd[1]: Created slice workload-tw.slice - Slice /workload/tw.
[   17.836257] systemd[1]: Created slice workload-wdb.slice - WDBs that are needed for workload.
[   17.855992] systemd[1]: Started systemd-ask-password-console.path - Dispatch Password Requests to Console Directory Watch.
[   17.875952] systemd[1]: Started systemd-ask-password-wall.path - Forward Password Requests to Wall Directory Watch.
[   17.896233] systemd[1]: Set up automount proc-sys-fs-binfmt_misc.automount - Arbitrary Executable File Formats File System Automount Point.
[   17.915925] systemd[1]: Expecting device dev-disk-by\x2dlabel-\x5cx2fboot.device - /dev/disk/by-label/\x2fboot...
[   17.934907] systemd[1]: Expecting device dev-disk-by\x2dlabel-\x5cx2fefi.device - /dev/disk/by-label/\x2fefi...
[   17.951932] systemd[1]: Expecting device dev-ttyAMA0.device - /dev/ttyAMA0...
[   17.965920] systemd[1]: Reached target cryptsetup.target - Local Encrypted Volumes.
[   17.982918] systemd[1]: Reached target hardware_is_ready.target - Hardware is ready.
[   17.999910] systemd[1]: Stopped target initrd-switch-root.target - Switch Root.
[   18.016907] systemd[1]: Stopped target initrd-fs.target - Initrd File Systems.
[   18.033911] systemd[1]: Stopped target initrd-root-fs.target - Initrd Root File System.
[   18.052012] systemd[1]: Reached target integritysetup.target - Local Integrity Protected Volumes.
[   18.071925] systemd[1]: Reached target remote-cryptsetup.target - Remote Encrypted Volumes.
[   18.091906] systemd[1]: Reached target remote-fs.target - Remote File Systems.
[   18.108906] systemd[1]: Reached target slices.target - Slice Units.
[   18.122924] systemd[1]: Reached target time-set.target - System Time Set.
[   18.138041] systemd[1]: Reached target time-sync.target - System Time Synchronized.
[   18.155023] systemd[1]: Reached target veritysetup.target - Local Verity Protected Volumes.
[   18.175004] systemd[1]: Listening on syslog.socket - Syslog Socket.
[   18.189680] systemd[1]: Listening on systemd-coredump.socket - Process Core Dump Socket.
[   18.209379] systemd[1]: Listening on systemd-creds.socket - Credential Encryption/Decryption.
[   18.228970] systemd[1]: Listening on systemd-initctl.socket - initctl Compatibility Named Pipe.
[   18.249059] systemd[1]: Listening on systemd-journald-audit.socket - Journal Audit Socket.
[   18.268968] systemd[1]: Listening on systemd-mountfsd.socket - DDI File System Mounter Socket.
[   18.288959] systemd[1]: Listening on systemd-nsresourced.socket - Namespace Resource Manager Socket.
[   18.308930] systemd[1]: systemd-pcrextend.socket - TPM PCR Measurements was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[   18.308946] systemd[1]: systemd-pcrlock.socket - Make TPM PCR Policy was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[   18.309008] systemd[1]: Listening on systemd-udevd-control.socket - udev Control Socket.
[   18.326946] systemd[1]: Listening on systemd-udevd-kernel.socket - udev Kernel Socket.
[   18.345958] systemd[1]: Listening on systemd-userdbd.socket - User Database Manager Socket.
[   18.383941] systemd[1]: Mounting dev-hugepages.mount - Huge Pages File System...
[   18.400619] systemd[1]: Mounting dev-mqueue.mount - POSIX Message Queue File System...
[   18.417739] systemd[1]: Mounting sys-kernel-debug.mount - /sys/kernel/debug...
[   18.432767] systemd[1]: Mounting sys-kernel-tracing.mount - Kernel Trace File System...
[   18.451688] systemd[1]: Starting kmod-static-nodes.service - Create List of Static Device Nodes...
[   18.470018] systemd[1]: Starting modprobe@configfs.service - Load Kernel Module configfs...
[   18.487830] systemd[1]: Starting modprobe@dm_mod.service - Load Kernel Module dm_mod...
[   18.505834] systemd[1]: Starting modprobe@drm.service - Load Kernel Module drm...
[   18.522822] systemd[1]: Starting modprobe@efi_pstore.service - Load Kernel Module efi_pstore...
[   18.534604] ACPI: bus type drm_connector registered
[   18.541113] systemd[1]: Starting modprobe@fuse.service - Load Kernel Module fuse...
[   18.557005] systemd[1]: Starting modprobe@loop.service - Load Kernel Module loop...
[   18.573112] systemd[1]: Starting nis-domainname.service - Read and set NIS domainname from /etc/sysconfig/network...
[   18.592038] systemd[1]: systemd-fsck-root.service: Deactivated successfully.
[   18.592108] systemd[1]: Stopped systemd-fsck-root.service - File System Check on Root Device.
[   18.611995] systemd[1]: systemd-hibernate-clear.service - Clear Stale Hibernate Storage Info was skipped because of an unmet condition check (ConditionPathExists=/sys/firmware/efi/efivars/HibernateLocation-8cf2644b-4b0b-428f-9387-6d876050dc67).
[   18.613800] systemd[1]: Starting systemd-journald.service - Journal Service...
[   18.629179] systemd[1]: Starting systemd-modules-load.service - Load Kernel Modules...
[   18.658513] systemd[1]: Starting systemd-network-generator.service - Generate network units from Kernel command line...
[   18.676924] systemd[1]: systemd-pcrmachine.service - TPM PCR Machine ID Measurement was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[   18.678020] systemd[1]: Starting systemd-remount-fs.service - Remount Root and Kernel File Systems...
[   18.696945] systemd[1]: Starting systemd-udev-load-credentials.service - Load udev Rules from Credentials...
[   18.700907] BTRFS info (device nvme0n1p3 state M): turning on sync discard
[   18.700922] BTRFS info (device nvme0n1p3 state M): force zstd compression, level 3
[   18.716020] systemd[1]: Starting systemd-udev-trigger.service - Coldplug All udev Devices...
[   18.736797] systemd[1]: Started systemd-journald.service - Journal Service.
[   18.753982] audit: type=1130 audit(1752229689.259:2): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   18.845934] audit: type=1130 audit(1752229689.351:3): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=kmod-static-nodes comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   18.865932] audit: type=1130 audit(1752229689.371:4): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=modprobe@configfs comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   18.865944] audit: type=1131 audit(1752229689.371:5): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=modprobe@configfs comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   18.884973] audit: type=1130 audit(1752229689.390:6): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=modprobe@dm_mod comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   18.884984] audit: type=1131 audit(1752229689.390:7): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=modprobe@dm_mod comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   18.901924] audit: type=1130 audit(1752229689.407:8): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=modprobe@drm comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   18.901937] audit: type=1131 audit(1752229689.407:9): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=modprobe@drm comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   18.921922] audit: type=1130 audit(1752229689.427:10): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=modprobe@efi_pstore comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   18.921933] audit: type=1131 audit(1752229689.427:11): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=modprobe@efi_pstore comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   22.359101]  cs_system_cfg: CoreSight Configuration manager initialised
[   22.361196] IPMI message handler: version 39.2
[   22.370489] ipmi device interface
[   22.378404] arm_spe_pmu arm,spe-v1: probed SPEv1.1 for CPUs 0-71 [max_record_sz 64, align 64, features 0x17]
[   22.396643] ipmi_si: IPMI System Interface driver
[   22.402817] ipmi_si: Unable to find any System Interface(s)
[   22.407821] coresight stm0: STM32 initialized
[   22.408791] ipmi_ssif: IPMI SSIF Interface driver
[   22.414153] ipmi_ssif i2c-IPI0001:00: ipmi_ssif: Trying ACPI-specified SSIF interface at i2c address 0x10, adapter NVDA0301:00, slave address 0x20
[   22.418526] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.10.auto: option mask 0x0
[   22.419230] CSCFG registered ete0
[   22.419243] coresight ete0: CPU0: ete v1.0 initialized
[   22.420055] CSCFG registered ete1
[   22.420067] coresight ete1: CPU1: ete v1.0 initialized
[   22.420646] CSCFG registered ete2
[   22.420659] coresight ete2: CPU2: ete v1.0 initialized
[   22.421448] CSCFG registered ete3
[   22.421460] coresight ete3: CPU3: ete v1.0 initialized
[   22.422215] CSCFG registered ete4
[   22.422227] coresight ete4: CPU4: ete v1.0 initialized
[   22.422807] CSCFG registered ete5
[   22.422817] coresight ete5: CPU5: ete v1.0 initialized
[   22.424044] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.10.auto: Registered PMU @ 0x0000000011002000 using 4 counters with Global(Counter0) filter settings
[   22.424123] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.11.auto: option mask 0x0
[   22.424226] CSCFG registered ete6
[   22.424238] coresight ete6: CPU6: ete v1.0 initialized
[   22.425168] CSCFG registered ete7
[   22.425177] coresight ete7: CPU7: ete v1.0 initialized
[   22.425819] CSCFG registered ete8
[   22.425830] coresight ete8: CPU8: ete v1.0 initialized
[   22.426521] CSCFG registered ete9
[   22.426531] coresight ete9: CPU9: ete v1.0 initialized
[   22.427116] CSCFG registered ete10
[   22.427126] coresight ete10: CPU10: ete v1.0 initialized
[   22.427503] CSCFG registered ete11
[   22.427512] coresight ete11: CPU11: ete v1.0 initialized
[   22.428001] CSCFG registered ete12
[   22.428010] coresight ete12: CPU12: ete v1.0 initialized
[   22.428544] CSCFG registered ete13
[   22.428552] coresight ete13: CPU13: ete v1.0 initialized
[   22.429124] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.11.auto: Registered PMU @ 0x0000000011042000 using 4 counters with Global(Counter0) filter settings
[   22.429214] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.12.auto: option mask 0x0
[   22.429277] CSCFG registered ete14
[   22.429288] coresight ete14: CPU14: ete v1.0 initialized
[   22.429721] CSCFG registered ete15
[   22.429731] coresight ete15: CPU15: ete v1.0 initialized
[   22.430180] CSCFG registered ete16
[   22.430188] coresight ete16: CPU16: ete v1.0 initialized
[   22.430606] CSCFG registered ete17
[   22.430616] coresight ete17: CPU17: ete v1.0 initialized
[   22.431057] CSCFG registered ete18
[   22.431066] coresight ete18: CPU18: ete v1.0 initialized
[   22.431236] EXT4-fs (nvme0n1p2): Supports (experimental) DIO atomic writes awu_min: 4096, awu_max: 4096
[   22.431745] CSCFG registered ete19
[   22.431758] coresight ete19: CPU19: ete v1.0 initialized
[   22.432408] EXT4-fs (nvme0n1p2): mounted filesystem 696239a1-b79d-4739-9d9e-32405c28345f r/w with ordered data mode. Quota mode: none.
[   22.432693] CSCFG registered ete20
[   22.432702] coresight ete20: CPU20: ete v1.0 initialized
[   22.433280] CSCFG registered ete21
[   22.433288] coresight ete21: CPU21: ete v1.0 initialized
[   22.433745] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.12.auto: Registered PMU @ 0x0000000011062000 using 4 counters with Global(Counter0) filter settings
[   22.433775] CSCFG registered ete22
[   22.433788] coresight ete22: CPU22: ete v1.0 initialized
[   22.433821] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.13.auto: option mask 0x0
[   22.434285] CSCFG registered ete23
[   22.434295] coresight ete23: CPU23: ete v1.0 initialized
[   22.434735] CSCFG registered ete24
[   22.434745] coresight ete24: CPU24: ete v1.0 initialized
[   22.435176] CSCFG registered ete25
[   22.435185] coresight ete25: CPU25: ete v1.0 initialized
[   22.435643] CSCFG registered ete26
[   22.435654] coresight ete26: CPU26: ete v1.0 initialized
[   22.435656] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.13.auto: Registered PMU @ 0x0000000011082000 using 4 counters with Global(Counter0) filter settings
[   22.435724] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.14.auto: option mask 0x0
[   22.436138] CSCFG registered ete27
[   22.436147] coresight ete27: CPU27: ete v1.0 initialized
[   22.436514] CSCFG registered ete28
[   22.436524] coresight ete28: CPU28: ete v1.0 initialized
[   22.436831] CSCFG registered ete29
[   22.436840] coresight ete29: CPU29: ete v1.0 initialized
[   22.437226] CSCFG registered ete30
[   22.437234] coresight ete30: CPU30: ete v1.0 initialized
[   22.437628] CSCFG registered ete31
[   22.437636] coresight ete31: CPU31: ete v1.0 initialized
[   22.437795] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.14.auto: Registered PMU @ 0x00000000110a2000 using 4 counters with Global(Counter0) filter settings
[   22.437911] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.15.auto: option mask 0x0
[   22.438127] CSCFG registered ete32
[   22.438136] coresight ete32: CPU32: ete v1.0 initialized
[   22.438574] CSCFG registered ete33
[   22.438585] coresight ete33: CPU33: ete v1.0 initialized
[   22.438957] CSCFG registered ete34
[   22.438965] coresight ete34: CPU34: ete v1.0 initialized
[   22.439369] CSCFG registered ete35
[   22.439378] coresight ete35: CPU35: ete v1.0 initialized
[   22.439758] CSCFG registered ete36
[   22.439768] coresight ete36: CPU36: ete v1.0 initialized
[   22.440173] CSCFG registered ete37
[   22.440181] coresight ete37: CPU37: ete v1.0 initialized
[   22.440572] CSCFG registered ete38
[   22.440580] coresight ete38: CPU38: ete v1.0 initialized
[   22.440926] CSCFG registered ete39
[   22.440935] coresight ete39: CPU39: ete v1.0 initialized
[   22.441315] CSCFG registered ete40
[   22.441324] coresight ete40: CPU40: ete v1.0 initialized
[   22.441740] CSCFG registered ete41
[   22.441751] coresight ete41: CPU41: ete v1.0 initialized
[   22.442065] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.15.auto: Registered PMU @ 0x0000000012002000 using 4 counters with Global(Counter0) filter settings
[   22.442135] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.16.auto: option mask 0x0
[   22.442213] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.16.auto: Registered PMU @ 0x0000000012042000 using 4 counters with Global(Counter0) filter settings
[   22.442261] CSCFG registered ete42
[   22.442271] coresight ete42: CPU42: ete v1.0 initialized
[   22.442274] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.17.auto: option mask 0x0
[   22.442363] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.17.auto: Registered PMU @ 0x0000000012062000 using 4 counters with Global(Counter0) filter settings
[   22.442424] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.18.auto: option mask 0x0
[   22.442540] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.18.auto: Registered PMU @ 0x0000000012082000 using 4 counters with Global(Counter0) filter settings
[   22.442611] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.19.auto: option mask 0x0
[   22.442694] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.19.auto: Registered PMU @ 0x00000000120a2000 using 4 counters with Global(Counter0) filter settings
[   22.442744] CSCFG registered ete43
[   22.442752] coresight ete43: CPU43: ete v1.0 initialized
[   22.442788] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.20.auto: option mask 0x0
[   22.442965] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.20.auto: Registered PMU @ 0x0000000015002000 using 4 counters with Global(Counter0) filter settings
[   22.443024] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.21.auto: option mask 0x0
[   22.443124] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.21.auto: Registered PMU @ 0x0000000015042000 using 4 counters with Global(Counter0) filter settings
[   22.443195] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.22.auto: option mask 0x0
[   22.443274] CSCFG registered ete44
[   22.443284] coresight ete44: CPU44: ete v1.0 initialized
[   22.443285] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.22.auto: Registered PMU @ 0x0000000015062000 using 4 counters with Global(Counter0) filter settings
[   22.443351] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.23.auto: option mask 0x0
[   22.443511] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.23.auto: Registered PMU @ 0x0000000015082000 using 4 counters with Global(Counter0) filter settings
[   22.443578] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.24.auto: option mask 0x0
[   22.443675] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.24.auto: Registered PMU @ 0x00000000150a2000 using 4 counters with Global(Counter0) filter settings
[   22.443771] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.25.auto: option mask 0x0
[   22.443787] CSCFG registered ete45
[   22.443796] coresight ete45: CPU45: ete v1.0 initialized
[   22.443895] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.25.auto: Registered PMU @ 0x0000000016002000 using 4 counters with Global(Counter0) filter settings
[   22.443961] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.26.auto: option mask 0x0
[   22.444063] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.26.auto: Registered PMU @ 0x0000000016042000 using 4 counters with Global(Counter0) filter settings
[   22.444123] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.27.auto: option mask 0x0
[   22.444200] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.27.auto: Registered PMU @ 0x0000000016062000 using 4 counters with Global(Counter0) filter settings
[   22.444243] CSCFG registered ete46
[   22.444251] coresight ete46: CPU46: ete v1.0 initialized
[   22.444289] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.28.auto: option mask 0x0
[   22.444410] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.28.auto: Registered PMU @ 0x0000000005002000 using 4 counters with Global(Counter0) filter settings
[   22.444484] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.29.auto: option mask 0x0
[   22.444573] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.29.auto: Registered PMU @ 0x0000000005042000 using 4 counters with Global(Counter0) filter settings
[   22.444639] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.30.auto: option mask 0x0
[   22.444701] CSCFG registered ete47
[   22.444711] coresight ete47: CPU47: ete v1.0 initialized
[   22.444725] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.30.auto: Registered PMU @ 0x0000000005062000 using 4 counters with Global(Counter0) filter settings
[   22.445148] CSCFG registered ete48
[   22.445159] coresight ete48: CPU48: ete v1.0 initialized
[   22.445541] CSCFG registered ete49
[   22.445550] coresight ete49: CPU49: ete v1.0 initialized
[   22.445967] CSCFG registered ete50
[   22.445976] coresight ete50: CPU50: ete v1.0 initialized
[   22.446409] CSCFG registered ete51
[   22.446418] coresight ete51: CPU51: ete v1.0 initialized
[   22.448916] CSCFG registered ete52
[   22.448931] coresight ete52: CPU52: ete v1.0 initialized
[   22.450965] CSCFG registered ete53
[   22.450976] coresight ete53: CPU53: ete v1.0 initialized
[   22.452034] CSCFG registered ete54
[   22.452045] coresight ete54: CPU54: ete v1.0 initialized
[   22.452761] CSCFG registered ete55
[   22.452772] coresight ete55: CPU55: ete v1.0 initialized
[   22.453691] CSCFG registered ete56
[   22.453702] coresight ete56: CPU56: ete v1.0 initialized
[   22.454506] CSCFG registered ete57
[   22.454516] coresight ete57: CPU57: ete v1.0 initialized
[   22.455405] CSCFG registered ete58
[   22.455416] coresight ete58: CPU58: ete v1.0 initialized
[   22.456280] CSCFG registered ete59
[   22.456290] coresight ete59: CPU59: ete v1.0 initialized
[   22.457233] CSCFG registered ete60
[   22.457244] coresight ete60: CPU60: ete v1.0 initialized
[   22.458031] CSCFG registered ete61
[   22.458041] coresight ete61: CPU61: ete v1.0 initialized
[   22.458942] CSCFG registered ete62
[   22.458954] coresight ete62: CPU62: ete v1.0 initialized
[   22.459835] CSCFG registered ete63
[   22.459846] coresight ete63: CPU63: ete v1.0 initialized
[   22.460844] CSCFG registered ete64
[   22.460856] coresight ete64: CPU64: ete v1.0 initialized
[   22.461771] CSCFG registered ete65
[   22.461783] coresight ete65: CPU65: ete v1.0 initialized
[   22.462686] CSCFG registered ete66
[   22.462699] coresight ete66: CPU66: ete v1.0 initialized
[   22.463604] CSCFG registered ete67
[   22.463614] coresight ete67: CPU67: ete v1.0 initialized
[   22.464533] CSCFG registered ete68
[   22.464543] coresight ete68: CPU68: ete v1.0 initialized
[   22.465401] CSCFG registered ete69
[   22.465412] coresight ete69: CPU69: ete v1.0 initialized
[   22.466278] CSCFG registered ete70
[   22.466290] coresight ete70: CPU70: ete v1.0 initialized
[   22.467074] CSCFG registered ete71
[   22.467084] coresight ete71: CPU71: ete v1.0 initialized
[   22.567370] FAT-fs (nvme0n1p1): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
[   22.678550] Adding 134191936k swap on /swapvol/swapfile.  Priority:10 extents:73 across:531378752k SS
[   22.738729] ipmi_ssif i2c-IPI0001:00: IPMI message handler: Found new BMC (man_id: 0x00a015, prod_id: 0x3146, dev_id: 0x20)
[   23.760978] kauditd_printk_skb: 72 callbacks suppressed
[   23.761003] audit: type=1305 audit(1752229694.266:58): op=set audit_enabled=1 old=1 auid=4294967295 ses=4294967295 res=1
