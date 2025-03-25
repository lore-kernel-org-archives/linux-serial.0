Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEEB266B59
	for <linux-serial@vger.kernel.org>; Tue, 25 Mar 2025 20:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742935314; cv=none; b=hexqGp/CODrYNPrLa3TY+kUicHK7VrEd0Di7B1t8LV2wI7/GCzgJgONSFyUbFvCVf8VFXrU5m638U6zjEc7te2qbL/+iDAPxcGLr0mgWaNz+AnpI3YaTLKe2oLuaXHaw3+w4Xzelkk7oB6hHGN7CUS0RckWTFkPO16WiaoevU6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742935314; c=relaxed/simple;
	bh=GCAhGVtueceq1ubCUXU7aIifbCxnCpAKEuI8oUAtt/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fr0cadRGLQrY+s2qm8adJKsLwlt3erWFKpPqvw4HunCbxqeKAc3eg8KDS4i5wtBHGkRu0BDPzIMWunM4XyFK9AHZhc/jgbGcIePt9fVG2YgUkWG+tK0fRDWofLKdcsfq6GycDTVFuO3BkEF1pM3KIZtZ3CsyxF+FZEHA9ZDx/9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EXJb42kg; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EXJb42kg"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e5e1a38c1aso8000056a12.2
        for <linux-serial@vger.kernel.org>; Tue, 25 Mar 2025 13:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1742935311; x=1743540111; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K52xAWNW5IEkY2W6yv56tbrXz/O78EY3OFwe6Kmcp1A=;
        b=EXJb42kg5HAc6tmyKr5oRY94sG4sbt/CcE2UJmPlqnN7iVY0JglgOH9+r6DRxzSSwb
         NiOrl5WwHztozS0ovw28py2Y9tqC+Et/ztdMCM4v+wvon+xs26qMSaYJroYzspue2WKO
         Y9j68gg01vakh3TWaBnStui40sFXXxQo0HSBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742935311; x=1743540111;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K52xAWNW5IEkY2W6yv56tbrXz/O78EY3OFwe6Kmcp1A=;
        b=lq5o+1RqjI5QkCp3o+Fw3hPV6SccU/zs8l22SdQr1zlsggFztMED+Pwa7Tl82sc8G3
         hqoCQbW8ISdS+OVPP2bBfQhvg36iDawmhIMIRlKYdf2M9IHwqe9R+nMN4pl9p522mTxJ
         S5EgYaNuaI+zXRllPGkFjil95Vo4FAQxLKNa0pDJ+njC3kwmPZfrZXq3eage7iSesUNf
         qPtksH4r5DNBmxGO4T0NF2bwyXzZfbdlM6Osg0Hgacb1JAOVzJssf6Wgoh4rhGQjrCUb
         2rRu10W2vHFi2u9+Jf+Vb5yT2CoYojyLbK6ZP5deq2x1n7G273ZB8NFo4XogUkWzG9x3
         KpBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzr8ewHDL25qdmjR/ecj3CLbXwW++W5FChs+i2GJ8US2UALqN6+JEqVR12IqMyLe1nvoTzwtdeTmuf6pk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgYbuJS+LIK2CLUWB6uw3+kGTfTTnp+TXTbx150VB7Tggxi2kA
	RYWBwbyLh4XyillCdc2XNsbO6m3cbz9q/qPOcSvETC85fHaQsBLXrp9cxdBzuvbIyQz5goqxkk2
	ftYg=
X-Gm-Gg: ASbGncvlID6emgcHbezkR1y8z4eaM2HlP+Dxhy9OXi79S/l6pShE2uoxr+Bn0fAbu68
	OYZrQHAjPJQyCL/Upw6/5yCrTPrYdEHhz27ZL02i2f7bV3cHxsYmkd3ZnxElSllHj3AKzrcBMBe
	3w86P7b0SeHZfMLfZQ0OmuvzzfZbrq/epk8UZGW8hvBGsMV0M7GD32g7EjiGOynU+Tpkg0cdTvu
	K+NgkF31WzQmjskPcoHIs2s3wlA+RxQn30QN9joQ7mh0MuTtKSKOEcUbILw+1zEFcer4Fuclxh3
	L8xvjbAY2+0TZO+PM8UrNtP8Lg/RgID4E5T3vI6hDi4CkpefmNJvSatyGSzA5KObJ/8xvC0JaXS
	UhJm//XNAEDRtggKLtNDNqW6jlbAbZQ==
X-Google-Smtp-Source: AGHT+IEBCdA0I2sEcojGEE3X6+0oRLKo+GBI09dQz/T4eoGU7U2stPR8OQvDqKldb8MNETKELvPzWQ==
X-Received: by 2002:a05:6402:4017:b0:5ec:939e:a60e with SMTP id 4fb4d7f45d1cf-5ec939ea7cbmr9488744a12.0.1742935310864;
        Tue, 25 Mar 2025 13:41:50 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebccf87341sm8504603a12.26.2025.03.25.13.41.48
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 13:41:48 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac2963dc379so1025699866b.2
        for <linux-serial@vger.kernel.org>; Tue, 25 Mar 2025 13:41:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW9Uwb1mHdPGC2by2QsDNqU/T4oP8LGNxUZrRrhzEQxNDnEQbeiE2hck8hPKEQqbbUhMUX45hmwTPvFWjo=@vger.kernel.org
X-Received: by 2002:a17:907:95a4:b0:ac3:48e4:f8bc with SMTP id
 a640c23a62f3a-ac3f27fd3b3mr1859596466b.48.1742935307883; Tue, 25 Mar 2025
 13:41:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325121624.523258-1-guoren@kernel.org> <20250325121624.523258-2-guoren@kernel.org>
In-Reply-To: <20250325121624.523258-2-guoren@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 25 Mar 2025 13:41:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiVgTJpSxrQbEi28pUOmuWXrox45vV9kPhe9q5CcRxEbw@mail.gmail.com>
X-Gm-Features: AQ5f1JpwFc7ifwGuAhyrs4E5qPgHx1McCR38KFycRhkLFRMKTveHrmoaWi4zba4
Message-ID: <CAHk-=wiVgTJpSxrQbEi28pUOmuWXrox45vV9kPhe9q5CcRxEbw@mail.gmail.com>
Subject: Re: [RFC PATCH V3 01/43] rv64ilp32_abi: uapi: Reuse lp64 ABI interface
To: guoren@kernel.org
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, anup@brainfault.org, atishp@atishpatra.org, 
	oleg@redhat.com, kees@kernel.org, tglx@linutronix.de, will@kernel.org, 
	mark.rutland@arm.com, brauner@kernel.org, akpm@linux-foundation.org, 
	rostedt@goodmis.org, edumazet@google.com, unicorn_wang@outlook.com, 
	inochiama@outlook.com, gaohan@iscas.ac.cn, shihua@iscas.ac.cn, 
	jiawei@iscas.ac.cn, wuwei2016@iscas.ac.cn, drew@pdp7.com, 
	prabhakar.mahadev-lad.rj@bp.renesas.com, ctsai390@andestech.com, 
	wefu@redhat.com, kuba@kernel.org, pabeni@redhat.com, josef@toxicpanda.com, 
	dsterba@suse.com, mingo@redhat.com, peterz@infradead.org, 
	boqun.feng@gmail.com, xiao.w.wang@intel.com, qingfang.deng@siflower.com.cn, 
	leobras@redhat.com, jszhang@kernel.org, conor.dooley@microchip.com, 
	samuel.holland@sifive.com, yongxuan.wang@sifive.com, 
	luxu.kernel@bytedance.com, david@redhat.com, ruanjinjie@huawei.com, 
	cuiyunhui@bytedance.com, wangkefeng.wang@huawei.com, qiaozhe@iscas.ac.cn, 
	ardb@kernel.org, ast@kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-mm@kvack.org, 
	linux-crypto@vger.kernel.org, bpf@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-atm-general@lists.sourceforge.net, linux-btrfs@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	linux-nfs@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Mar 2025 at 05:17, <guoren@kernel.org> wrote:
>
> The rv64ilp32 abi kernel accommodates the lp64 abi userspace and
> leverages the lp64 abi Linux interface. Hence, unify the
> BITS_PER_LONG = 32 memory layout to match BITS_PER_LONG = 64.

No.

This isn't happening.

You can't do crazy things in the RISC-V code and then expect the rest
of the kernel to just go "ok, we'll do crazy things".

We're not doing crazy __riscv_xlen hackery with random structures
containing 64-bit values that the kernel then only looks at the low 32
bits. That's wrong on *so* many levels.

I'm willing to say "big-endian is dead", but I'm not willing to accept
this kind of crazy hackery.

Not today, not ever.

If you want to run a ilp32 kernel on 64-bit hardware (and support
64-bit ABI just in a 32-bit virtual memory size), I would suggest you

 (a) treat the kernel as natively 32-bit (obviously you can then tell
the compiler to use the rv64 instructions, which I presume you're
already doing - I didn't look)

 (b) look at making the compat stuff do the conversion the "wrong way".

And btw, that (b) implies *not* just ignoring the high bits. If
user-space gives 64-bit pointer, you don't just treat it as a 32-bit
one by dropping the high bits. You add some logic to convert it to an
invalid pointer so that user space gets -EFAULT.

            Linus
