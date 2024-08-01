Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7A516C695
	for <linux-serial@vger.kernel.org>; Thu,  1 Aug 2024 15:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722527844; cv=none; b=HrMLuUuluJxazgL77yyVtudKqU+GGfU9LLWXJnSc0o7RyQhvfeh9lJ1tsOENDSCa+17Ko/c46wHgml60yt5qZZ3y2j+t7CbM578itBDoyQ5I6ezvho0YJI6dgQugDca51jqQNhf5yK3nYqMg/PouLK1JcTe+bj8nXLPIWSfDBjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722527844; c=relaxed/simple;
	bh=slA1qcJMPPEJn4qszj+pVRy2XbF7w9EBv9WMIhCYejg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uy0zCHZaky5Gjaj78hsd6DgdFuh4ai3ygZIQ0oS9EyJuX/7Pd2AThhY067qbjxW9WAxVN+5xmfjoMSfLJuI6tVsK692GWeHlsrj89UjPaamUbC9mvtuHz+mLMiRDpett3T9cUR5xAwMmtVuhU2FwiCrKMxjcUeWohdUj7TJY0lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=sUXYs1kO; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="sUXYs1kO"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-493e8ef36b4so1915338137.2
        for <linux-serial@vger.kernel.org>; Thu, 01 Aug 2024 08:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722527840; x=1723132640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wk2MARZcNfHzvjANqiOLi2ZAwp6PwZTQh8uG8eriV6o=;
        b=sUXYs1kOauJEq53OMvJitNOgKd+qzk2HThaQg+Agl3fobeKlQ9Ko5I5wlFeBpB0avn
         wx37VqoKwT1STzYADQ+pG0HvxjC3CHulSnkX1zE0BckegrtI1QJX7ehrMPiPOnwaZUUU
         3TWDYYJSBItJiMamBn37LR9NPEqVvA4WVVAxdxR7JGTBLHTCodGS6Ii/Tc/pKW1DiDw7
         4P4eWgioebx6501EDyuPOdx03O+x8lN5zKhtP67DKRH21t5ea1uhzry5OgDqigumObBo
         RAGx+g7S4SJzsgN9MuajF4Yxdy5g7ZcFhLlQLvCFNlrVSBJkrgMh8gaswknsnlcwIrpe
         bluA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722527840; x=1723132640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wk2MARZcNfHzvjANqiOLi2ZAwp6PwZTQh8uG8eriV6o=;
        b=qrDjJ2PIi2TKBJW0GlBA82gAAVubWyD8mDm7vm3UhZJfzTR+OBaj/mpHRyDZPgrAjU
         2oWo3kUW/G4hn+xuGPv77oHCbHj3465MClm90Qv25srndamaH5ZHH6QQmTMgjU0gsDeu
         uof5/mU2Tfo+OY5D6r70wZtocZWWlYtS1Xvuq4uWU33oDvX0bl/zplt8USh5p69CszZL
         u/gZ6AUIIyQ8yvg5eoRgmFwGz8u/hjd+RlTC5svbpgnv8VUWpYbNnv9yqeswwbNlxGTU
         aJFrp4aJU1IcU8cQki1Zfv4FRVPpmW27GKNx2K+o8WgQBc5KDnCoZxdZs4xW6ZJUd50C
         3h8w==
X-Forwarded-Encrypted: i=1; AJvYcCXYMyoLDaO7R9+9FcchVr4b7eZ6krPevB9B9YnfNUhPaWsVJKEU99oDZRFMii6G3RGb+U5Phj6nDdxQENpENwNYvTL+PgHzPo9dKtrS
X-Gm-Message-State: AOJu0YyRaMKUChIVLivTZD4Wv7nTrQhf9UpwloNR0nSaTiFpenHz3n8S
	n2SjH45YLxhaY4hUoqrYJ5LnrexTCBrnUVvdrU73p5K/xkkEn+DDCWk1qEud4gihGK8zJxUR7dD
	7McqNE/5/BYOeQP5DZIL0qQVzUBiUnyRek//pUQ==
X-Google-Smtp-Source: AGHT+IG/a8PBfE3N7dyq8VgSMDxPTo+KNf0Ob43bZ+nA3u0KyI3ARKY7uZMpDrYlRsa4rNvyuiTgROVSz0+En1z78FM=
X-Received: by 2002:a05:6102:3593:b0:493:bf9b:166 with SMTP id
 ada2fe7eead31-4945bdca458mr905753137.3.1722527840387; Thu, 01 Aug 2024
 08:57:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730-k1-01-basic-dt-v5-0-98263aae83be@gentoo.org> <20240730-k1-01-basic-dt-v5-8-98263aae83be@gentoo.org>
In-Reply-To: <20240730-k1-01-basic-dt-v5-8-98263aae83be@gentoo.org>
From: Jesse Taube <jesse@rivosinc.com>
Date: Thu, 1 Aug 2024 11:57:09 -0400
Message-ID: <CALSpo=ZuO9fugMmABUK-n5tyxNVwpWrQnf_nexbNKr0gZP8f9w@mail.gmail.com>
Subject: Re: [PATCH v5 08/10] riscv: dts: add initial SpacemiT K1 SoC device tree
To: Yixun Lan <dlan@gentoo.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Yangyu Chen <cyy@cyyself.name>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Samuel Holland <samuel.holland@sifive.com>, 
	Anup Patel <anup@brainfault.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-serial@vger.kernel.org, Jisheng Zhang <jszhang@kernel.org>, 
	Inochi Amaoto <inochiama@outlook.com>, Icenowy Zheng <uwu@icenowy.me>, 
	Meng Zhang <zhangmeng.kevin@spacemit.com>, Meng Zhang <kevin.z.m@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 8:29=E2=80=AFPM Yixun Lan <dlan@gentoo.org> wrote:
>
> From: Yangyu Chen <cyy@cyyself.name>
>
> Banana Pi BPI-F3 motherboard is powered by SpacemiT K1[1].
>
> Key features:
> - 4 cores per cluster, 2 clusters on chip
> - UART IP is Intel XScale UART
>
> Some key considerations:
> - ISA string is inferred from vendor documentation[2]
> - Cluster topology is inferred from datasheet[1] and L2 in vendor dts[3]
> - No coherent DMA on this board
>     Inferred by taking vendor ethernet and MMC drivers to the mainline
>     kernel. Without dma-noncoherent in soc node, the driver fails.
> - Add cache nodes
>     K1 SoC has 128 sets of 32KiB L1 I/D Cache for each hart, and 512 sets
>     of 512KiB L2 Cache for each cluster.
>
> Currently only support booting into console with only uart, other
> features will be added soon later.
>
> Link: https://docs.banana-pi.org/en/BPI-F3/SpacemiT_K1_datasheet [1]
> Link: https://developer.spacemit.com/#/documentation?token=3DBWbGwbx7liGW=
21kq9lucSA6Vnpb [2]
> Link: https://gitee.com/bianbu-linux/linux-6.1/blob/bl-v1.0.y/arch/riscv/=
boot/dts/spacemit/k1-x.dtsi [3]
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> Signed-off-by: Yixun Lan <dlan@gentoo.org>

Acked-by: Jesse Taube <jesse@rivosinc.com>

>
> ---
> Changes in v5:
>  - fix cache-sets
>  - Link to v4: https://lore.kernel.org/all/20240709-k1-01-basic-dt-v4-8-a=
e5bb5e56aaf@gentoo.org/
>
> Changes in v4:
>  - add i/d-cache, l2-cache info
>  - Link to v3: https://lore.kernel.org/all/20240703-k1-01-basic-dt-v3-8-1=
2f73b47461e@gentoo.org/
> ---
>  arch/riscv/boot/dts/spacemit/k1.dtsi | 459 +++++++++++++++++++++++++++++=
++++++
>  1 file changed, 459 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/s=
pacemit/k1.dtsi
> new file mode 100644
> index 0000000000000..0777bf9e01183
> --- /dev/null
> +++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
> @@ -0,0 +1,459 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
> + */
> +
> +/dts-v1/;
> +/ {
> +       #address-cells =3D <2>;
> +       #size-cells =3D <2>;
> +       model =3D "SpacemiT K1";
> +       compatible =3D "spacemit,k1";
> +
> +       aliases {
> +               serial0 =3D &uart0;
> +               serial1 =3D &uart2;
> +               serial2 =3D &uart3;
> +               serial3 =3D &uart4;
> +               serial4 =3D &uart5;
> +               serial5 =3D &uart6;
> +               serial6 =3D &uart7;
> +               serial7 =3D &uart8;
> +               serial8 =3D &uart9;
> +       };
> +
> +       cpus {
> +               #address-cells =3D <1>;
> +               #size-cells =3D <0>;
> +               timebase-frequency =3D <24000000>;
> +
> +               cpu-map {
> +                       cluster0 {
> +                               core0 {
> +                                       cpu =3D <&cpu_0>;
> +                               };
> +                               core1 {
> +                                       cpu =3D <&cpu_1>;
> +                               };
> +                               core2 {
> +                                       cpu =3D <&cpu_2>;
> +                               };
> +                               core3 {
> +                                       cpu =3D <&cpu_3>;
> +                               };
> +                       };
> +
> +                       cluster1 {
> +                               core0 {
> +                                       cpu =3D <&cpu_4>;
> +                               };
> +                               core1 {
> +                                       cpu =3D <&cpu_5>;
> +                               };
> +                               core2 {
> +                                       cpu =3D <&cpu_6>;
> +                               };
> +                               core3 {
> +                                       cpu =3D <&cpu_7>;
> +                               };
> +                       };
> +               };
> +
> +               cpu_0: cpu@0 {
> +                       compatible =3D "spacemit,x60", "riscv";
> +                       device_type =3D "cpu";
> +                       reg =3D <0>;
> +                       riscv,isa =3D "rv64imafdcv_zicbom_zicbop_zicboz_z=
icntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_=
zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
> +                       riscv,isa-base =3D "rv64i";
> +                       riscv,isa-extensions =3D "i", "m", "a", "f", "d",=
 "c", "v", "zicbom",
> +                                              "zicbop", "zicboz", "zicnt=
r", "zicond", "zicsr",
> +                                              "zifencei", "zihintpause",=
 "zihpm", "zfh", "zba",
> +                                              "zbb", "zbc", "zbs", "zkt"=
, "zvfh", "zvkt",
> +                                              "sscofpmf", "sstc", "svinv=
al", "svnapot", "svpbmt";
> +                       riscv,cbom-block-size =3D <64>;
> +                       riscv,cbop-block-size =3D <64>;
> +                       riscv,cboz-block-size =3D <64>;
> +                       i-cache-block-size =3D <64>;
> +                       i-cache-size =3D <32768>;
> +                       i-cache-sets =3D <128>;
> +                       d-cache-block-size =3D <64>;
> +                       d-cache-size =3D <32768>;
> +                       d-cache-sets =3D <128>;
> +                       next-level-cache =3D <&cluster0_l2_cache>;
> +                       mmu-type =3D "riscv,sv39";
> +
> +                       cpu0_intc: interrupt-controller {
> +                               compatible =3D "riscv,cpu-intc";
> +                               interrupt-controller;
> +                               #interrupt-cells =3D <1>;
> +                       };
> +               };
> +
> +               cpu_1: cpu@1 {
> +                       compatible =3D "spacemit,x60", "riscv";
> +                       device_type =3D "cpu";
> +                       reg =3D <1>;
> +                       riscv,isa =3D "rv64imafdcv_zicbom_zicbop_zicboz_z=
icntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_=
zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
> +                       riscv,isa-base =3D "rv64i";
> +                       riscv,isa-extensions =3D "i", "m", "a", "f", "d",=
 "c", "v", "zicbom",
> +                                              "zicbop", "zicboz", "zicnt=
r", "zicond", "zicsr",
> +                                              "zifencei", "zihintpause",=
 "zihpm", "zfh", "zba",
> +                                              "zbb", "zbc", "zbs", "zkt"=
, "zvfh", "zvkt",
> +                                              "sscofpmf", "sstc", "svinv=
al", "svnapot", "svpbmt";
> +                       riscv,cbom-block-size =3D <64>;
> +                       riscv,cbop-block-size =3D <64>;
> +                       riscv,cboz-block-size =3D <64>;
> +                       i-cache-block-size =3D <64>;
> +                       i-cache-size =3D <32768>;
> +                       i-cache-sets =3D <128>;
> +                       d-cache-block-size =3D <64>;
> +                       d-cache-size =3D <32768>;
> +                       d-cache-sets =3D <128>;
> +                       next-level-cache =3D <&cluster0_l2_cache>;
> +                       mmu-type =3D "riscv,sv39";
> +
> +                       cpu1_intc: interrupt-controller {
> +                               compatible =3D "riscv,cpu-intc";
> +                               interrupt-controller;
> +                               #interrupt-cells =3D <1>;
> +                       };
> +               };
> +
> +               cpu_2: cpu@2 {
> +                       compatible =3D "spacemit,x60", "riscv";
> +                       device_type =3D "cpu";
> +                       reg =3D <2>;
> +                       riscv,isa =3D "rv64imafdcv_zicbom_zicbop_zicboz_z=
icntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_=
zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
> +                       riscv,isa-base =3D "rv64i";
> +                       riscv,isa-extensions =3D "i", "m", "a", "f", "d",=
 "c", "v", "zicbom",
> +                                              "zicbop", "zicboz", "zicnt=
r", "zicond", "zicsr",
> +                                              "zifencei", "zihintpause",=
 "zihpm", "zfh", "zba",
> +                                              "zbb", "zbc", "zbs", "zkt"=
, "zvfh", "zvkt",
> +                                              "sscofpmf", "sstc", "svinv=
al", "svnapot", "svpbmt";
> +                       riscv,cbom-block-size =3D <64>;
> +                       riscv,cbop-block-size =3D <64>;
> +                       riscv,cboz-block-size =3D <64>;
> +                       i-cache-block-size =3D <64>;
> +                       i-cache-size =3D <32768>;
> +                       i-cache-sets =3D <128>;
> +                       d-cache-block-size =3D <64>;
> +                       d-cache-size =3D <32768>;
> +                       d-cache-sets =3D <128>;
> +                       next-level-cache =3D <&cluster0_l2_cache>;
> +                       mmu-type =3D "riscv,sv39";
> +
> +                       cpu2_intc: interrupt-controller {
> +                               compatible =3D "riscv,cpu-intc";
> +                               interrupt-controller;
> +                               #interrupt-cells =3D <1>;
> +                       };
> +               };
> +
> +               cpu_3: cpu@3 {
> +                       compatible =3D "spacemit,x60", "riscv";
> +                       device_type =3D "cpu";
> +                       reg =3D <3>;
> +                       riscv,isa =3D "rv64imafdcv_zicbom_zicbop_zicboz_z=
icntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_=
zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
> +                       riscv,isa-base =3D "rv64i";
> +                       riscv,isa-extensions =3D "i", "m", "a", "f", "d",=
 "c", "v", "zicbom",
> +                                              "zicbop", "zicboz", "zicnt=
r", "zicond", "zicsr",
> +                                              "zifencei", "zihintpause",=
 "zihpm", "zfh", "zba",
> +                                              "zbb", "zbc", "zbs", "zkt"=
, "zvfh", "zvkt",
> +                                              "sscofpmf", "sstc", "svinv=
al", "svnapot", "svpbmt";
> +                       riscv,cbom-block-size =3D <64>;
> +                       riscv,cbop-block-size =3D <64>;
> +                       riscv,cboz-block-size =3D <64>;
> +                       i-cache-block-size =3D <64>;
> +                       i-cache-size =3D <32768>;
> +                       i-cache-sets =3D <128>;
> +                       d-cache-block-size =3D <64>;
> +                       d-cache-size =3D <32768>;
> +                       d-cache-sets =3D <128>;
> +                       next-level-cache =3D <&cluster0_l2_cache>;
> +                       mmu-type =3D "riscv,sv39";
> +
> +                       cpu3_intc: interrupt-controller {
> +                               compatible =3D "riscv,cpu-intc";
> +                               interrupt-controller;
> +                               #interrupt-cells =3D <1>;
> +                       };
> +               };
> +
> +               cpu_4: cpu@4 {
> +                       compatible =3D "spacemit,x60", "riscv";
> +                       device_type =3D "cpu";
> +                       reg =3D <4>;
> +                       riscv,isa =3D "rv64imafdcv_zicbom_zicbop_zicboz_z=
icntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_=
zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
> +                       riscv,isa-base =3D "rv64i";
> +                       riscv,isa-extensions =3D "i", "m", "a", "f", "d",=
 "c", "v", "zicbom",
> +                                              "zicbop", "zicboz", "zicnt=
r", "zicond", "zicsr",
> +                                              "zifencei", "zihintpause",=
 "zihpm", "zfh", "zba",
> +                                              "zbb", "zbc", "zbs", "zkt"=
, "zvfh", "zvkt",
> +                                              "sscofpmf", "sstc", "svinv=
al", "svnapot", "svpbmt";
> +                       riscv,cbom-block-size =3D <64>;
> +                       riscv,cbop-block-size =3D <64>;
> +                       riscv,cboz-block-size =3D <64>;
> +                       i-cache-block-size =3D <64>;
> +                       i-cache-size =3D <32768>;
> +                       i-cache-sets =3D <128>;
> +                       d-cache-block-size =3D <64>;
> +                       d-cache-size =3D <32768>;
> +                       d-cache-sets =3D <128>;
> +                       next-level-cache =3D <&cluster1_l2_cache>;
> +                       mmu-type =3D "riscv,sv39";
> +
> +                       cpu4_intc: interrupt-controller {
> +                               compatible =3D "riscv,cpu-intc";
> +                               interrupt-controller;
> +                               #interrupt-cells =3D <1>;
> +                       };
> +               };
> +
> +               cpu_5: cpu@5 {
> +                       compatible =3D "spacemit,x60", "riscv";
> +                       device_type =3D "cpu";
> +                       reg =3D <5>;
> +                       riscv,isa =3D "rv64imafdcv_zicbom_zicbop_zicboz_z=
icntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_=
zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
> +                       riscv,isa-base =3D "rv64i";
> +                       riscv,isa-extensions =3D "i", "m", "a", "f", "d",=
 "c", "v", "zicbom",
> +                                              "zicbop", "zicboz", "zicnt=
r", "zicond", "zicsr",
> +                                              "zifencei", "zihintpause",=
 "zihpm", "zfh", "zba",
> +                                              "zbb", "zbc", "zbs", "zkt"=
, "zvfh", "zvkt",
> +                                              "sscofpmf", "sstc", "svinv=
al", "svnapot", "svpbmt";
> +                       riscv,cbom-block-size =3D <64>;
> +                       riscv,cbop-block-size =3D <64>;
> +                       riscv,cboz-block-size =3D <64>;
> +                       i-cache-block-size =3D <64>;
> +                       i-cache-size =3D <32768>;
> +                       i-cache-sets =3D <128>;
> +                       d-cache-block-size =3D <64>;
> +                       d-cache-size =3D <32768>;
> +                       d-cache-sets =3D <128>;
> +                       next-level-cache =3D <&cluster1_l2_cache>;
> +                       mmu-type =3D "riscv,sv39";
> +
> +                       cpu5_intc: interrupt-controller {
> +                               compatible =3D "riscv,cpu-intc";
> +                               interrupt-controller;
> +                               #interrupt-cells =3D <1>;
> +                       };
> +               };
> +
> +               cpu_6: cpu@6 {
> +                       compatible =3D "spacemit,x60", "riscv";
> +                       device_type =3D "cpu";
> +                       reg =3D <6>;
> +                       riscv,isa =3D "rv64imafdcv_zicbom_zicbop_zicboz_z=
icntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_=
zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
> +                       riscv,isa-base =3D "rv64i";
> +                       riscv,isa-extensions =3D "i", "m", "a", "f", "d",=
 "c", "v", "zicbom",
> +                                              "zicbop", "zicboz", "zicnt=
r", "zicond", "zicsr",
> +                                              "zifencei", "zihintpause",=
 "zihpm", "zfh", "zba",
> +                                              "zbb", "zbc", "zbs", "zkt"=
, "zvfh", "zvkt",
> +                                              "sscofpmf", "sstc", "svinv=
al", "svnapot", "svpbmt";
> +                       riscv,cbom-block-size =3D <64>;
> +                       riscv,cbop-block-size =3D <64>;
> +                       riscv,cboz-block-size =3D <64>;
> +                       i-cache-block-size =3D <64>;
> +                       i-cache-size =3D <32768>;
> +                       i-cache-sets =3D <128>;
> +                       d-cache-block-size =3D <64>;
> +                       d-cache-size =3D <32768>;
> +                       d-cache-sets =3D <128>;
> +                       next-level-cache =3D <&cluster1_l2_cache>;
> +                       mmu-type =3D "riscv,sv39";
> +
> +                       cpu6_intc: interrupt-controller {
> +                               compatible =3D "riscv,cpu-intc";
> +                               interrupt-controller;
> +                               #interrupt-cells =3D <1>;
> +                       };
> +               };
> +
> +               cpu_7: cpu@7 {
> +                       compatible =3D "spacemit,x60", "riscv";
> +                       device_type =3D "cpu";
> +                       reg =3D <7>;
> +                       riscv,isa =3D "rv64imafdcv_zicbom_zicbop_zicboz_z=
icntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_=
zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
> +                       riscv,isa-base =3D "rv64i";
> +                       riscv,isa-extensions =3D "i", "m", "a", "f", "d",=
 "c", "v", "zicbom",
> +                                              "zicbop", "zicboz", "zicnt=
r", "zicond", "zicsr",
> +                                              "zifencei", "zihintpause",=
 "zihpm", "zfh", "zba",
> +                                              "zbb", "zbc", "zbs", "zkt"=
, "zvfh", "zvkt",
> +                                              "sscofpmf", "sstc", "svinv=
al", "svnapot", "svpbmt";
> +                       riscv,cbom-block-size =3D <64>;
> +                       riscv,cbop-block-size =3D <64>;
> +                       riscv,cboz-block-size =3D <64>;
> +                       i-cache-block-size =3D <64>;
> +                       i-cache-size =3D <32768>;
> +                       i-cache-sets =3D <128>;
> +                       d-cache-block-size =3D <64>;
> +                       d-cache-size =3D <32768>;
> +                       d-cache-sets =3D <128>;
> +                       next-level-cache =3D <&cluster1_l2_cache>;
> +                       mmu-type =3D "riscv,sv39";
> +
> +                       cpu7_intc: interrupt-controller {
> +                               compatible =3D "riscv,cpu-intc";
> +                               interrupt-controller;
> +                               #interrupt-cells =3D <1>;
> +                       };
> +               };
> +
> +               cluster0_l2_cache: l2-cache0 {
> +                       compatible =3D "cache";
> +                       cache-block-size =3D <64>;
> +                       cache-level =3D <2>;
> +                       cache-size =3D <524288>;
> +                       cache-sets =3D <512>;
> +                       cache-unified;
> +               };
> +
> +               cluster1_l2_cache: l2-cache1 {
> +                       compatible =3D "cache";
> +                       cache-block-size =3D <64>;
> +                       cache-level =3D <2>;
> +                       cache-size =3D <524288>;
> +                       cache-sets =3D <512>;
> +                       cache-unified;
> +               };
> +       };
> +
> +       soc {
> +               compatible =3D "simple-bus";
> +               interrupt-parent =3D <&plic>;
> +               #address-cells =3D <2>;
> +               #size-cells =3D <2>;
> +               dma-noncoherent;
> +               ranges;
> +
> +               uart0: serial@d4017000 {
> +                       compatible =3D "spacemit,k1-uart", "intel,xscale-=
uart";
> +                       reg =3D <0x0 0xd4017000 0x0 0x100>;
> +                       interrupts =3D <42>;
> +                       clock-frequency =3D <14857000>;
> +                       reg-shift =3D <2>;
> +                       reg-io-width =3D <4>;
> +                       status =3D "disabled";
> +               };
> +
> +               uart2: serial@d4017100 {
> +                       compatible =3D "spacemit,k1-uart", "intel,xscale-=
uart";
> +                       reg =3D <0x0 0xd4017100 0x0 0x100>;
> +                       interrupts =3D <44>;
> +                       clock-frequency =3D <14857000>;
> +                       reg-shift =3D <2>;
> +                       reg-io-width =3D <4>;
> +                       status =3D "disabled";
> +               };
> +
> +               uart3: serial@d4017200 {
> +                       compatible =3D "spacemit,k1-uart", "intel,xscale-=
uart";
> +                       reg =3D <0x0 0xd4017200 0x0 0x100>;
> +                       interrupts =3D <45>;
> +                       clock-frequency =3D <14857000>;
> +                       reg-shift =3D <2>;
> +                       reg-io-width =3D <4>;
> +                       status =3D "disabled";
> +               };
> +
> +               uart4: serial@d4017300 {
> +                       compatible =3D "spacemit,k1-uart", "intel,xscale-=
uart";
> +                       reg =3D <0x0 0xd4017300 0x0 0x100>;
> +                       interrupts =3D <46>;
> +                       clock-frequency =3D <14857000>;
> +                       reg-shift =3D <2>;
> +                       reg-io-width =3D <4>;
> +                       status =3D "disabled";
> +               };
> +
> +               uart5: serial@d4017400 {
> +                       compatible =3D "spacemit,k1-uart", "intel,xscale-=
uart";
> +                       reg =3D <0x0 0xd4017400 0x0 0x100>;
> +                       interrupts =3D <47>;
> +                       clock-frequency =3D <14857000>;
> +                       reg-shift =3D <2>;
> +                       reg-io-width =3D <4>;
> +                       status =3D "disabled";
> +               };
> +
> +               uart6: serial@d4017500 {
> +                       compatible =3D "spacemit,k1-uart", "intel,xscale-=
uart";
> +                       reg =3D <0x0 0xd4017500 0x0 0x100>;
> +                       interrupts =3D <48>;
> +                       clock-frequency =3D <14857000>;
> +                       reg-shift =3D <2>;
> +                       reg-io-width =3D <4>;
> +                       status =3D "disabled";
> +               };
> +
> +               uart7: serial@d4017600 {
> +                       compatible =3D "spacemit,k1-uart", "intel,xscale-=
uart";
> +                       reg =3D <0x0 0xd4017600 0x0 0x100>;
> +                       interrupts =3D <49>;
> +                       clock-frequency =3D <14857000>;
> +                       reg-shift =3D <2>;
> +                       reg-io-width =3D <4>;
> +                       status =3D "disabled";
> +               };
> +
> +               uart8: serial@d4017700 {
> +                       compatible =3D "spacemit,k1-uart", "intel,xscale-=
uart";
> +                       reg =3D <0x0 0xd4017700 0x0 0x100>;
> +                       interrupts =3D <50>;
> +                       clock-frequency =3D <14857000>;
> +                       reg-shift =3D <2>;
> +                       reg-io-width =3D <4>;
> +                       status =3D "disabled";
> +               };
> +
> +               uart9: serial@d4017800 {
> +                       compatible =3D "spacemit,k1-uart", "intel,xscale-=
uart";
> +                       reg =3D <0x0 0xd4017800 0x0 0x100>;
> +                       interrupts =3D <51>;
> +                       clock-frequency =3D <14857000>;
> +                       reg-shift =3D <2>;
> +                       reg-io-width =3D <4>;
> +                       status =3D "disabled";
> +               };
> +
> +               plic: interrupt-controller@e0000000 {
> +                       compatible =3D "spacemit,k1-plic", "sifive,plic-1=
.0.0";
> +                       reg =3D <0x0 0xe0000000 0x0 0x4000000>;
> +                       interrupts-extended =3D <&cpu0_intc 11>, <&cpu0_i=
ntc 9>,
> +                                             <&cpu1_intc 11>, <&cpu1_int=
c 9>,
> +                                             <&cpu2_intc 11>, <&cpu2_int=
c 9>,
> +                                             <&cpu3_intc 11>, <&cpu3_int=
c 9>,
> +                                             <&cpu4_intc 11>, <&cpu4_int=
c 9>,
> +                                             <&cpu5_intc 11>, <&cpu5_int=
c 9>,
> +                                             <&cpu6_intc 11>, <&cpu6_int=
c 9>,
> +                                             <&cpu7_intc 11>, <&cpu7_int=
c 9>;
> +                       interrupt-controller;
> +                       #address-cells =3D <0>;
> +                       #interrupt-cells =3D <1>;
> +                       riscv,ndev =3D <159>;
> +               };
> +
> +               clint: timer@e4000000 {
> +                       compatible =3D "spacemit,k1-clint", "sifive,clint=
0";
> +                       reg =3D <0x0 0xe4000000 0x0 0x10000>;
> +                       interrupts-extended =3D <&cpu0_intc 3>, <&cpu0_in=
tc 7>,
> +                                             <&cpu1_intc 3>, <&cpu1_intc=
 7>,
> +                                             <&cpu2_intc 3>, <&cpu2_intc=
 7>,
> +                                             <&cpu3_intc 3>, <&cpu3_intc=
 7>,
> +                                             <&cpu4_intc 3>, <&cpu4_intc=
 7>,
> +                                             <&cpu5_intc 3>, <&cpu5_intc=
 7>,
> +                                             <&cpu6_intc 3>, <&cpu6_intc=
 7>,
> +                                             <&cpu7_intc 3>, <&cpu7_intc=
 7>;
> +               };
> +
> +               sec_uart1: serial@f0612000 {
> +                       compatible =3D "spacemit,k1-uart", "intel,xscale-=
uart";
> +                       reg =3D <0x0 0xf0612000 0x0 0x100>;
> +                       interrupts =3D <43>;
> +                       clock-frequency =3D <14857000>;
> +                       reg-shift =3D <2>;
> +                       reg-io-width =3D <4>;
> +                       status =3D "reserved"; /* for TEE usage */
> +               };
> +       };
> +};
>
> --
> 2.45.2
>
