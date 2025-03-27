Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6805819D086
	for <linux-serial@vger.kernel.org>; Thu, 27 Mar 2025 16:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743092414; cv=none; b=Cscvr9QFIn2F2WlRUBhc2vtNn/tJQbew1a3IK22PeMJYtU9GtuX2bvRSWE4huUHidbjr0MdOHsk3HtzAFC687PUJQGTCqRK/mEDlSj3e1ihhkrYh1WI70/vs5EXps0XLB36sT4FAscEwtzf2Lb+14aAq2Fweb32vS6VxYl6I76M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743092414; c=relaxed/simple;
	bh=d7ElXG12q67ts9hPo9D4cCi81eQhC4QyN/csAlxbkk8=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=DA99Nw5NNFKroq+bZq/9dQfffZBBhtg/uVfvxkzRW7lf99C2RBwV5guYj38Xu802JHhKeoEA8yuVXntpIxncze++yxtlyBBpoE8b4ud2U7ZbY8Ulfy6Q7KMLhYGfa16gaSUnZBsUGBZ+UsMEoKloH8u4Nwk1o+Mu7JuySpX4Cac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=kOYAPj8Z; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="kOYAPj8Z"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22398e09e39so27896915ad.3
        for <linux-serial@vger.kernel.org>; Thu, 27 Mar 2025 09:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1743092410; x=1743697210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hQcfqS6ONRy4v+VAuw1r1bUFP3B6ufIgzXQvK3yZp0M=;
        b=kOYAPj8ZAlZLOFNhrs9mchTgodx5+USr5guYG8Kx5M0JP8ixbwK1esti7rpswrGb06
         rZ8bzKVq45I+F4VCYLj8Uyzv45ccDb4WFH942uFTDyknzHTy0czdcynotfuRLD2wg5js
         9s1l+cPdq9QnkCuoEXgL6Mm+Oiy+oFZf5Yo4i+Q7RKiBePhd2E17Wv2UbwxAi5DtKxTB
         JsVtgXqlomwNDp5h8fp8aMZdPPnYqZCWtkFo/vCEykJ/kRXGKYKXo+g3PrjhCX/nSS1t
         FI5ZCmh2PQ14BKCflq1wX58jeyx9oUNg0aEAG1kI4tifINMvDnXCesxjzWtQG7O/35PI
         ZZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743092410; x=1743697210;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQcfqS6ONRy4v+VAuw1r1bUFP3B6ufIgzXQvK3yZp0M=;
        b=MmK4yYjvADuIYEZ0FbXoEq/fc1e1qEPFcLWaMIGqpYBDLrrQru+sYL2D2prC4Wnw56
         5a2PbXQ34cwDb5AlbhORXw6nT04/vbuvD22I0edc352xzXwJMK6rkgWaUeEl06OPBw6G
         bMD+0XpGA01jCXktU+po3z0actg3Fy4YQVMTcWDlcVhys7fV3r5AEERJKH2R43eE/hEi
         mRsfZtXTc+dH25hxQat5M15y4frCYLmXWDFtrJCDrUHDJts7nPP1Edoa/5HnfEPB1/62
         M350X1tl8dMvpFl6KKB9BfiOnI4RfYcBg2R+zJLuzbr1WheOv38GwG+Mb2m5zwnmzQcx
         8fkA==
X-Forwarded-Encrypted: i=1; AJvYcCVD7ipaqBT3GL0r1l2L9gsFG8twB6Xu4EFMxeWE33AA+Vk4tBfVq6pkNNkoAAICc/qc5PrRsEVVljoDKWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRIgNAzTioBBM8URxUyVlMnNpDPRPSU+BTB6B2FDSw5GACvHXa
	Scygxyw83ir3PzGNc/HLs7YhWVdH77XPQxjtrIT2xGFYtBArV/A0QXOhFzwgbJ4=
X-Gm-Gg: ASbGncvRU7CLlNcBF0KS77kzuKV+yyTpUKamISmusPKacuaYFAevxiKTHFaI47P7X7L
	hQUi3og3MfuPiKqHrImnxTgkIUI7zEq5KIxPlxrHBfzucaH47qn7RzTsM4/l9DYruECsgE6gBzC
	HGWgEv7DvT/9gC321uvvhtiadVfxbNHOWkyZG0gq7cyoPTND9FzdVMSqJ7WvPjxU6EZwGg81B7s
	GXFuDLMzC+T/aHMX4ogb5OEhx5C85OZng+t9DqellOsCfxQ80UFAoRs4iJK5p2l6p+vWris+8cp
	vspKNUV2RUc4g3yG2OWR+GeXe2UbNKsocm2NqA==
X-Google-Smtp-Source: AGHT+IGhXmi8JOjZOP3Ikj3wo/1uBU9qt49Ql5SLHckRbeVG8HWYg9iWFYIxA94kzN1K7mL9F21TaQ==
X-Received: by 2002:a17:903:22d2:b0:223:4816:3e9e with SMTP id d9443c01a7336-22804857854mr57168615ad.13.1743092410377;
        Thu, 27 Mar 2025 09:20:10 -0700 (PDT)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390618e4b6sm14534202b3a.180.2025.03.27.09.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 09:20:09 -0700 (PDT)
Date: Thu, 27 Mar 2025 09:20:09 -0700 (PDT)
X-Google-Original-Date: Thu, 27 Mar 2025 09:20:00 PDT (-0700)
Subject:     Re: [RFC PATCH V3 00/43] rv64ilp32_abi: Build CONFIG_64BIT kernel-self with ILP32 ABI
In-Reply-To: <svu4xdeo7a7ve3vorvgbkjxzrqmqk5oztgtfpbg556wjw4x7vc@yg4esoipmt7g>
CC: david@redhat.com, peterz@infradead.org, guoren@kernel.org,
  Arnd Bergmann <arnd@arndb.de>, Greg KH <gregkh@linuxfoundation.org>,
  Linus Torvalds <torvalds@linux-foundation.org>, Paul Walmsley <paul.walmsley@sifive.com>, anup@brainfault.org,
  atishp@atishpatra.org, oleg@redhat.com, kees@kernel.org, tglx@linutronix.de,
  Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, brauner@kernel.org,
  akpm@linux-foundation.org, rostedt@goodmis.org, edumazet@google.com, unicorn_wang@outlook.com,
  inochiama@outlook.com, gaohan@iscas.ac.cn, shihua@iscas.ac.cn, jiawei@iscas.ac.cn,
  wuwei2016@iscas.ac.cn, drew@pdp7.com, prabhakar.mahadev-lad.rj@bp.renesas.com, ctsai390@andestech.com,
  wefu@redhat.com, kuba@kernel.org, pabeni@redhat.com, josef@toxicpanda.com, dsterba@suse.com,
  mingo@redhat.com, boqun.feng@gmail.com, xiao.w.wang@intel.com, qingfang.deng@siflower.com.cn,
  leobras@redhat.com, jszhang@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
  samuel.holland@sifive.com, yongxuan.wang@sifive.com, luxu.kernel@bytedance.com, ruanjinjie@huawei.com,
  cuiyunhui@bytedance.com, wangkefeng.wang@huawei.com, qiaozhe@iscas.ac.cn,
  Ard Biesheuvel <ardb@kernel.org>, ast@kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
  kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-mm@kvack.org,
  linux-crypto@vger.kernel.org, bpf@vger.kernel.org, linux-input@vger.kernel.org,
  linux-perf-users@vger.kernel.org, linux-serial@vger.kernel.org, linux-fsdevel@vger.kernel.org,
  linux-arch@vger.kernel.org, maple-tree@lists.infradead.org, linux-trace-kernel@vger.kernel.org,
  netdev@vger.kernel.org, linux-atm-general@lists.sourceforge.net, linux-btrfs@vger.kernel.org,
  netfilter-devel@vger.kernel.org, coreteam@netfilter.org, linux-nfs@vger.kernel.org, linux-sctp@vger.kernel.org,
  linux-usb@vger.kernel.org, linux-media@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Liam.Howlett@oracle.com
Message-ID: <mhng-e8248074-b79c-42f6-986f-9993851b6be2@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Tue, 25 Mar 2025 12:23:39 PDT (-0700), Liam.Howlett@oracle.com wrote:
> * David Hildenbrand <david@redhat.com> [250325 14:52]:
>> On 25.03.25 13:26, Peter Zijlstra wrote:
>> > On Tue, Mar 25, 2025 at 08:15:41AM -0400, guoren@kernel.org wrote:
>> > > From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
>> > >
>> > > Since 2001, the CONFIG_64BIT kernel has been built with the LP64 ABI,
>> > > but this patchset allows the CONFIG_64BIT kernel to use an ILP32 ABI
>> >
>> > I'm thinking you're going to be finding a metric ton of assumptions
>> > about 'unsigned long' being 64bit when 64BIT=y throughout the kernel.
>> >
>> > I know of a couple of places where 64BIT will result in different math
>> > such that a 32bit 'unsigned long' will trivially overflow.

Ya, I write code that assumes "unsigned long" is the size of a register 
pretty regularly.

>> >
>> > Please, don't do this. This adds a significant maintenance burden on all
>> > of us.
>> >
>>
>> Fully agreed.
>
> I would go further and say I do not want this to go in.

Seems reasonable to me, and I think it's also been the general sentiment 
when this stuff comes up.  This specific implementation seems 
particularly clunky, but I agree that it's going to be painful to do 
this sort of thing.

> The open ended maintenance burden is not worth extending hardware life
> of a board with 16mb of ram (If I understand your 2023 LPC slides
> correctly).

We can already run full 32-bit kernels on 64-bit hardware.  The hardware 
needs to support configurable XLEN, but there's systems out there that 
do already.

It's not like any of the existing RISC-V stuff ships in meaningful 
volumes.  So I think it's fine to just say that vendors who want tiny 
memories should build hardware that plays nice with those constraints, 
and vendors who build hardware that doesn't make any sense get to pick 
up the pieces.

I get RISC-V is where people go to have crazy ideas, but there's got to 
be a line somewhere...

>
> Thank you,
> Liam
