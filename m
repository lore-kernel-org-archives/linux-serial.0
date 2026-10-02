Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D291A681C
	for <linux-serial@vger.kernel.org>; Fri,  2 Oct 2026 16:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790957746; cv=none; b=EeFKyONgonYDHH8+pkZOuNT8EF8c5ul5DfAHhmtU35Yz2kPKByv8kqQCt2BQPQN7j87PLN21JbyL6rL8LV9YbTuBW129zCxmK9rEm0hJXy+g0hsJZHwN7Gw4Hi99cH41iKmVT1EucQ9yf4dynXJgKG/BzDEGmiMEY4lpB7afqAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790957746; c=relaxed/simple;
	bh=FmrZsCQCkfPKkxLhyxsxGqqblu2KJkJgk/mbNbXoYKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cy51X+263TD5vGTZlV4WviLLuinJ6NmTaM3Lv73872gExxsw8CxJXE9SCmLvPqjF4MAM7cJ0R2EEQWvldpd1ex/cZv0Ja3QNzH0no5vVSUZyJOFMuzhunqvUh2MU/KO+MsrAPJDHxgDuEodWUTrT+pC/qf/Acu6uxeZQyfqGZWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BK6zvlOO; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BK6zvlOO"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2e227422e3so8462466b.3
        for <linux-serial@vger.kernel.org>; Fri, 02 Oct 2026 09:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790957743; x=1791562543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=o4niJFCL1Tg94S7QXfdYdCSyAdIrBTgV96rmAV/L4ak=;
        b=BK6zvlOOIHHPYSUmG5dtBBpjWV29MW+dCV3vMstfvQVWPSyeA5JTJ7/yQU6JDepizy
         x7JHPDvuXoxqVr+wgiv4RYjWQ+9bU6838sUHQ56ZffC3leslBVXbzLiwbiiuYzGOxR2K
         2taTy0wxdZOqf/MYgDhIa5S4dnAoPHb2w7Jy6rwEl8SSMUzhTRmiVonVFrDmvIOu7pWa
         CRUhsLEAlQ2F/r360zfafWqcHXi/VSJI13+LINd7ahRoOufT7poXKASTk1oz1YY0uu4N
         ePobZBr6XEhX0nDqO++YcV5yFS+NoR8rMcBEJzrVnKgged5TPl52d+ycQ4x0a3B2DEoo
         uyww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790957743; x=1791562543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o4niJFCL1Tg94S7QXfdYdCSyAdIrBTgV96rmAV/L4ak=;
        b=X8TMQW4hSW57FjytgGsqB902EvTLw7EMxBMpHNuvVljKMS0q4NC+1QuEL0WpC840H/
         uUoiL+EP1pij+qrd0SiEF/lC8dh/3gzstqvWEYNL9ioTUlOFrFKrQnGYVtQnPPFHjpfX
         zLDuaaXQSJkGI3/yHqIdbxUEt11eGQnFHTvo8rZzpP8KX3vjInhkvjqIOE0VenUpp4/F
         RjMoKTUziQkPZvyMB8+4Z0zKMgjPHFEG7BBWU/oU2crpNdD/0upZEfT++paVNVtTunw6
         hS5U83OFpC2k1b2C7AMFR3jBr+6bNwf27XZZvlBLsmgztq4ijnLMDn6+dutO+X5hXTET
         ONSQ==
X-Forwarded-Encrypted: i=1; AKwUvBwqqVB1q6V7YCEL5yGyp4UQsr0TvEkYLrbhq+OlPvdwBlz1pNHe2vPxoV7DN1fXKS/5lVTnsnPBr5Tfl8c=@vger.kernel.org
X-Gm-Message-State: AFuF++nfYn27NL0ijpZthmV3QFyFBVgqwKXCrmVcycUwIHUKoeY8J6Au
	m3wc8v7+NEyQyRxh7WiElxlZwr+2LTKtF6yqxSSJSSU8JgXjyuz4chcb
X-Gm-Gg: AYBFou3PpN2MG+fWS2SdjP+INDPwNUgpCK6cYvQxvVG+Vo/IGZ6YptWTl/3IiH8Bp2r
	qQmjo4Mxm/oU0T4blha+jJdHPw7sJwJ7LG6rnc9ODcggTKZTa67+vZNdiwkzt0KPtNKId6rNVt8
	BucGHSny7D2c+VWlSOpkgtBhHfJZgEJ0g9DqwtHWajP+ogkby7gA7JJCG5pRLX5+yGHaZfezVY3
	pP7GvMvKFTN3Eo3Cu85BpFRHHsmxd8nFxJyVAwEAGkaVRXIkFhQJj4ubUBUn8SWqgZE07ABBCAJ
	SUEIc9T3wL7KtftHm7zogML2zZzsq/arrVg6bGwrhxoVE+0V8JLCBqc822t078onY4geV0EDsXy
	bv4NVuU63rWzsxg6RCHP6D4PKIoDg0CbamSZoq/lONfr5BxewEmA2hNVEcH/5Zog/KkbXBy1jOG
	wmoYoF8iP/8hfju+/BX08i4BVOX9KUSumT6uy2D5GMWRuQ4N42lRwTV54eF9U0buXGhgsRx/JKs
	BYG08Y8ket0nG54rjPSGB5nP0njPP8oGWkvkYgJ2wdJNMcZrGg=
X-Received: by 2002:a17:906:6a02:b0:c2a:fcf5:c6bb with SMTP id a640c23a62f3a-c2e4af6ee00mr264468966b.23.1790957742743;
        Fri, 02 Oct 2026 09:15:42 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e4cf5f4e4sm106437166b.42.2026.10.02.09.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 09:15:40 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: sparclinux@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: linux-kernel@vger.kernel.org,
	Magnus Lindholm <linmag7@gmail.com>,
	netdev@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH 0/7] sparc64: add Fujitsu M3000 support
Date: Fri,  2 Oct 2026 18:14:22 +0200
Message-ID: <20261002161515.932316-1-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several years ago I salvaged an M3000 SPARC Enterprise box being
decommissioned at work. The box has been sitting ever since, it did
not run Linux. It did not seem impossible to get Linux running but
my earlier attempts failed. I recently found some documentation;
"SPARC JPS2: Common Specification" and the "Fujitsu SPARC64 II
Extensions", which gave me some of the missingpieces.
Getting this up and running required extensive testing, some
kernel instrumentation, debug printouts and many reboot iterations.
For thisi, Codex proved very helpful. Along the way, I stumbled upon
some generic sparc and driver bugs that this series addresses as well.

This series adds support for the Fujitsu SPARC Enterprise M3000, with
SPARC64 VII+, Oberon PCIe, BCM5718 networking and a firmware hvc console.
It applies to Linux v7.3-rc1, base cee9395acd8043be0644b25c34bfa86623f2b935.

Patches 1-3 fix existing sparc64 defects in generic clear_page, secondary
queued-spinlock acquisition and sun4u kernel huge-PUD mappings. Each has
a Fixes tag. Patches 4-7 add the CPU/MMU/SMP path, PCIe bridge, narrowly
matched tg3 firmware-state correction and console. They form one series
so the complete port can be built without collecting prerequisites.

VII context-write and demap synchronization follows the cited JPS2 and
SPARC64 VII manual sections. Existing Cheetah routines are unchanged:
similar assembly does not establish the same hardware requirement there.

The final tree includes the demap-all instruction synchronization in the
CPU/MMU patch. All seven cumulative prefixes build. The exact final image
boots Gentoo/OpenRC and SSH with eight threads; kernel taint is zero.

HugeTLB/THP, CPU offlining, Oberon MSI and complete RAS recovery remain
unsupported. Firmware console calls cannot be bounded if firmware stalls.

SPARC64 VII/VII+ support is currently opt-in through Kconfig while the new
CPU/MMU/SMP paths receive broader testing. The option also excludes HugeTLB
and THP configurations, which this implementation does not yet support.
The longer-term aim is to rely on runtime CPU detection once unsupported
huge-page configurations can be handled safely.

Magnus Lindholm (7):
  sparc64: return from the generic clear_page implementation
  sparc64: honor queued spinlock layout in secondary startup
  sparc64: avoid huge kernel PUD mappings on sun4u
  sparc64: add SPARC64 VII CPU, MMU and SMP support
  sparc64: add M3000 Oberon PCIe support
  tg3: normalize inherited M3000 register byte order
  hvc: add an M3000 firmware console backend

 MAINTAINERS                         |   6 +
 arch/sparc/Kconfig                  |  19 +++
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
 arch/sparc/kernel/irq_64.c          |  50 ++++--
 arch/sparc/kernel/pci_fire.c        |  31 +++-
 arch/sparc/kernel/pci_impl.h        |   1 +
 arch/sparc/kernel/prom_64.c         |   6 +
 arch/sparc/kernel/prom_irqtrans.c   |   7 +
 arch/sparc/kernel/ptrace_64.c       |   7 +
 arch/sparc/kernel/setup_64.c        |  55 +++++++
 arch/sparc/kernel/smp_64.c          |  82 +++++++++-
 arch/sparc/kernel/trampoline_64.S   |  53 ++++++-
 arch/sparc/kernel/traps_64.c        |  27 ++++
 arch/sparc/lib/GENpage.S            |   3 +
 arch/sparc/mm/init_64.c             | 110 ++++++++++++-
 arch/sparc/mm/tsb.c                 |  19 ++-
 arch/sparc/mm/ultra.S               | 236 ++++++++++++++++++++++++++++
 drivers/net/ethernet/broadcom/tg3.c |  91 ++++++++++-
 drivers/tty/hvc/Kconfig             |  10 ++
 drivers/tty/hvc/Makefile            |   2 +
 drivers/tty/hvc/hvc_m3000.c         | 167 ++++++++++++++++++++
 32 files changed, 1088 insertions(+), 35 deletions(-)
 create mode 100644 drivers/tty/hvc/hvc_m3000.c


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.43.0

