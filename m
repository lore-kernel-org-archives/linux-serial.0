Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C482384CE5
	for <linux-serial@vger.kernel.org>; Mon, 12 Oct 2026 18:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830928; cv=none; b=JqDH4ZOy7lej71kUv3u7fTt17r9R7GH5AY2ux5GRr12AVDG5c4aoUrgBQzxBVc9JlRUq4Ga2wMUKbWwgM7j3o8jXoCTmBMqz2MWzRQ7Ofzl4bfIFvPHH4iTpCvMWdKzrBOHqrTgCD5Ob+4tvsvJd2rSQcfPw+Ux2th2bpbKkDlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830928; c=relaxed/simple;
	bh=RXZU9pGmybZEzzVgTyCUUBPb33NmSEa3c7lCgL2izTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fxjRg4hv+GVmy+g0uV0aEgYd4zwRbV9+x1OLmQyDCXazSCxiCyrHBeqlisPnYupCK6IATlDhumqqOtgv51ZYO57yoZkqXxZp9Shlaaq6G/5iDkwDNU4i7rXT3Dy6ODYlaSBJU52Git9nIHU66/EkqSnn4SU6n7r9yQpy+5sCnbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gO/NrSOU; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gO/NrSOU"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c2e5e090746so195307166b.0
        for <linux-serial@vger.kernel.org>; Mon, 12 Oct 2026 11:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791830923; x=1792435723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SuQqbuz4y3M9yuu6TKfF/F/BBLi6OQx/9CpoEI3dfHI=;
        b=gO/NrSOU0URkG6AyNG38PYCCGTK+8Mlb8OoaKMmsstV+5DA/CPeP0DDAIbBufqT62A
         FneMlPeiidxhbIn48Srn5pT9Ga4DpqB1f1zYO0WqWneK3MaRnCpXKMH9Jj+ThIdh9gg3
         I7wiq2OZmPE8Vy61RY8VxZAy6WjfHmf2yycfHgRQbGOvTVKsbHwUAe3ZMQygIAWi9Cjh
         KPFCN1WjSuU6/bJEzOAayoaEagIIdDozNOo98df/uF9qZtnHUydOYqtXylvS9KfR+NA2
         4kGQbfgRKAs/D7EpQqIBuEre0Pwn8nA6FvgaL+8GKUM3AREzKwBLSTEpFjxCl7Npmcj1
         7aOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791830923; x=1792435723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SuQqbuz4y3M9yuu6TKfF/F/BBLi6OQx/9CpoEI3dfHI=;
        b=FkeloP/Lgao5HK73BY2n7bkLWN9D9UisTTJ9aD68gGsE245tNwWPWWBVlDdMXzP8qk
         W+KFKDpCMPK9DgTun3DXTeTPvreCs7XRugHF4PtqN7bM7xGLiEbppq+QnfbGTiMzm/r1
         NPVbt/xRVB93KlnwGwQCB0sBxl1VUV7r+OuuI0wt6qevumJXZZf8fRUnYejALhzB3l/q
         jzzUS2LeMt8Y3e8AYkoUCRIglcV5IbORBqavTlmsA439upFUq82B9opT5l8pPeZx6PpV
         4ZfeAOYxUlcoFIf1FPkZ85TLBpIXCM8cFdJi3Jc2dxPWrWEZOw2DmEWOM6IOucwS6awe
         5FKQ==
X-Forwarded-Encrypted: i=1; AKwUvBy5W9XOcExb8qU4xq5tk50b+O2/tIcWGwZjwejk9p6Bsa2ZyxM1c7UVzAmnY4f2NxhIZuP9Lo6ay0i3h38=@vger.kernel.org
X-Gm-Message-State: AFq9FYKJTbJtpDt0mQatjGde9vmkNUTotSL/IsxkAPrKhiSVrqbZLOX3
	Syt6nwbxts7O+21mRujqHiYMUh0x1+GVAPITBs6tU3f9LNtLj8OgZr+W
X-Gm-Gg: AYBFou2ynM4LHI5PfadRlJtP6ApLIPk5AXuNeO1Dar44sqzkn/sFkgtx6Tkn+EqdqqE
	9ft0nG/+DGZsW2FF/AjPrdUSeZu3vsa0aVZcJtR2Mm9R44T5mD7jtonJHtH8IcCG669cNdm1kj3
	NYuQUTjLxQza3A4GtGm+MacrHYyNGsl83tApl5kl7Oij4BJ2Pqa6m0ZFR6EStS8uyCOKjw2/32P
	bzqoSyXDZtdMZAzGQZAr+Bkvks6rU5nRR6hgwUSNJYGjAG3VK7I4p9jLnEsBKJg040hOkrUE0Ke
	8JTBAtanlgPE/VSm0P+yzgWUmTXIUxuQ4nfQzOS9RHhjmyiZyEsJNn2PwqevY/4Gb13sx9k5ujl
	Se8dNYrfqcE8fCPgrKKaydPaGpdnJLGCO83yFOMoe2/PHUmQdlzx3SzwQcIVXQBwNjh65KYgw32
	cHQ3GFww/l4m3REknHslcg86j9lE2IJQONcdHseRVVvYaSUkMr75uLudtthEONnGCQbsjhMRKWu
	8RZiMoScQGJnBxf4LVWm2m4wFJM2ILACa60phY5
X-Received: by 2002:a17:907:c003:b0:c34:cf13:a92b with SMTP id a640c23a62f3a-c34cf13b42bmr339345466b.3.1791830923181;
        Mon, 12 Oct 2026 11:48:43 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9aa5aa7sm488517666b.55.2026.10.12.11.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 11:48:42 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com,
	sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	krzk@kernel.org,
	oleg@redhat.com,
	linmag7@gmail.com
Subject: [PATCH v3 0/8] sparc64: add Fujitsu M3000 support
Date: Mon, 12 Oct 2026 20:48:01 +0200
Message-ID: <20261012184826.986050-1-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several years ago I salvaged an M3000 SPARC Enterprise box being
decommissioned at work. The box has been sitting ever since, as it did
not run Linux. It did not seem impossible to get Linux running, but
my earlier attempts failed. I recently found some documentation:
"SPARC JPS2: Common Specification" and the "Fujitsu SPARC64 VII
Extensions", which gave me some of the missing pieces.
Getting this up and running required extensive testing, some
kernel instrumentation, debug printouts and many reboot iterations.
For this, Codex proved very helpful. Along the way, I stumbled upon
some generic sparc and driver bugs that this series addresses as well.

This series adds CPU, MMU, SMP, Oberon PCIe and firmware console support
for the Fujitsu SPARC Enterprise M3000. It is based on v7.3-rc1.

Patches 1-5 are generic sparc64 fixes: the clear_page return, secondary
startup spinlock layout, sun4u kernel PUD mappings, IRQ allocation
failure handling and Fire firmware register-property validation.
Patches 6-8 add the M3000 support. The generic fixes are kept in this
series so that the architecture changes can be applied and tested
together.

The on-board BCM5718 also needs the separate netdev patch:

[PATCH net-next v3] tg3: normalize inherited BCM5718 register byte order
Link: https://lore.kernel.org/sparclinux/20261011194228.981141-1-linmag7@gmail.com/

That patch applies independently and is not included in this series.
It was included in the M3000 test kernel described below.

Changes since v2
---------------
- Add separate generic fixes for unchecked IRQ allocation failure and
  missing or short Fire reg properties, following the Sashiko review.
  IRQ setup now stops before publishing an invalid descriptor; register
  properties are validated before their entries are accessed.
- Mark fill_in_one_cpu() as __init to match its initialization-only
  caller and vii_cpu_topology(), fixing the section mismatch reported
  by the kernel test robot.
- Address Jiri Slaby's HVC review: reorder the console state to reduce
  padding, use guard()/scoped_guard() for locking, test the input
  pointer directly, and name the firmware argument counts and error
  return values. Keep the polling spinlock released during synchronous
  timer deletion, with the mutex held to serialize close and reopen.
- Retain the raw buffer lock for atomic console calls and the existing
  firmware polling policy. Zero still means zero bytes transferred;
  firmware argument-array positions remain the fixed interface layout.
- Remove the leftover experimental Oberon boot message.
- Fold the CPU and HVC corrections into their respective support
  patches. The two new generic fixes bring the SPARC series to eight
  patches; the tg3 fix remains separate.

Testing
-------
The candidate source tree, including the separate tg3 patch, was built
with W=1 using GCC 13.3 and Clang 23.1.3. Neither build reports the
CPU topology section mismatch or warnings in the changed HVC code.
Other warnings remain in existing code. This does not reproduce the
robot's exact Clang 24 development compiler and defconfig combination.

The GCC kernel booted from disk into OpenRC and SSH on an M3000 with
all eight CPUs and 16 GiB of RAM. Bounded fork/COW, CPU migration,
file write/read verification and network transfer checks passed.
HVC checks covered output, paced input after idle, concurrent open and
close, and hangup/reopen. The kernel remained untainted, with no new
WARNING, BUG or Oops reports during these checks.

The final export plus tg3 differs from that boot-tested source tree only
by removal of the experimental Oberon boot message. It applies cleanly
to v7.3-rc1 and has been rebuilt with GCC and W=1; the final export has
not been rebooted. The Clang image was not booted. This revision has not
been retested on the Ultra45 or in UP mode, and these bounded tests do
not establish long-term stability or exercise hardware failure paths.

Current limitations
-------------------
SPARC64 VII support remains a Kconfig option because this path currently
excludes HugeTLB and THP. Removing that restriction requires further
large-page MMU work and testing. CPU offlining is not supported.

Oberon uses legacy interrupts; MSI and native bridge error recovery are
not implemented. CPU error handling is limited to the supported
restrainable ECC path; other unhandled error traps remain fatal.

The HVC backend relies on firmware calls. A firmware call that does not
return remains unbounded, and fast pasted input can exceed the firmware
FIFO. The console tests above do not establish panic-path reliability.

Magnus Lindholm (8):
  sparc64: return from the generic clear_page implementation
  sparc64: honor queued spinlock layout in secondary startup
  sparc64: avoid huge kernel PUD mappings on sun4u
  sparc64: stop IRQ setup when descriptor allocation fails
  sparc64: validate Fire register properties before initialization
  sparc64: add SPARC64 VII CPU, MMU and SMP support
  sparc64: add M3000 Oberon PCIe support
  hvc: add an M3000 firmware console backend

 MAINTAINERS                         |   6 +
 arch/sparc/Kconfig                  |  20 +++
 arch/sparc/include/asm/head_64.h    |  15 ++
 arch/sparc/include/asm/iommu_64.h   |   1 +
 arch/sparc/include/asm/irq_64.h     |   1 +
 arch/sparc/include/asm/setup.h      |   5 +
 arch/sparc/include/asm/smp_64.h     |   4 +
 arch/sparc/include/asm/spitfire.h   |   1 +
 arch/sparc/include/asm/trap_block.h |   6 +
 arch/sparc/kernel/cpu.c             |   3 +
 arch/sparc/kernel/entry.h           |   2 +
 arch/sparc/kernel/head_64.S         |  18 +++
 arch/sparc/kernel/helpers.S         |  41 +++++
 arch/sparc/kernel/iommu.c           |  44 ++++++
 arch/sparc/kernel/irq_64.c          |  54 +++++--
 arch/sparc/kernel/pci_fire.c        |  37 ++++-
 arch/sparc/kernel/pci_impl.h        |   1 +
 arch/sparc/kernel/prom_64.c         |  29 +++-
 arch/sparc/kernel/prom_irqtrans.c   |  15 +-
 arch/sparc/kernel/ptrace_64.c       |   7 +
 arch/sparc/kernel/setup_64.c        |  55 +++++++
 arch/sparc/kernel/smp_64.c          |  89 ++++++++++-
 arch/sparc/kernel/trampoline_64.S   |  53 ++++++-
 arch/sparc/kernel/traps_64.c        |  27 ++++
 arch/sparc/lib/GENpage.S            |   3 +
 arch/sparc/mm/init_64.c             | 110 ++++++++++++-
 arch/sparc/mm/tsb.c                 |  19 ++-
 arch/sparc/mm/ultra.S               | 236 ++++++++++++++++++++++++++++
 drivers/tty/hvc/Kconfig             |  10 ++
 drivers/tty/hvc/Makefile            |   1 +
 drivers/tty/hvc/hvc_m3000.c         | 202 ++++++++++++++++++++++++
 31 files changed, 1077 insertions(+), 38 deletions(-)
 create mode 100644 drivers/tty/hvc/hvc_m3000.c


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
