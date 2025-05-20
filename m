Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688B927A47C;
	Tue, 20 May 2025 17:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747761538; cv=none; b=djG+jQpwI4WcRx9rymI6cno57717MSAXx5vAxK5V7A4KRV0L0xq8nW8wlMgdSndzVarODBhj6q14eq1wnIfU46ezeXuIFxxqW8ej6F1+0vqwaMR4iDnhtswQcC1S7jHgSNCjAjbDjcgLohZL4Pq/tor6/9G5qh0dl1eaYdWeH/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747761538; c=relaxed/simple;
	bh=QaJS5pEqLf6kCCIHmsBZHlAMWoH+MknSy/L2A1pxbK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KYukvT3ze+YtxLoKLPelz2GZNmeRXWGLvUGhhaZF5N2BdCr0oaDc80Wvj44UQ0M/ELscAeH+E6eVbLuPQHIEF7orfKHaJ+TkHMRY3FfyNJNsuxDomjh81d8k6v9FtXEx3/jI8lNtijCkgIb3lp5dzJARY1oveusFRQFOFwIJAsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=YajqAQom; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jHY5WLth; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="YajqAQom";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jHY5WLth"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 9CA2913801F1;
	Tue, 20 May 2025 13:18:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Tue, 20 May 2025 13:18:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1747761535; x=1747847935; bh=FOArTy0zBfiJqpS/cLTbA
	XtFy5ptcEhBAPM7VB5HZZ8=; b=YajqAQom9gZZs3qW3VwHUl7NNEoZQIkJzhbQ4
	+/7ORh2sRi93idXoTN/si1puz89bQ9T3wD0dAr0/bX/TKgnmDoMrUX4UKzJdy46b
	YIslO21ABsJoxkjBs4cNduXSn/SkmXmoBF+AHGwJnP1VrzFv8kKL4Drdv6/DP/bF
	B9kqYnF4KleUhMOpDuxo3qV/0S55pkkw8/ZeIDg1iuxlrmbBSb7qKN9Y7qORljiH
	nyCn15X9xCiwZ+qVMnCLRSmJS2DjA+g6OzCc1Q3oa2YS+o1eWN8EngxOiWv5Uril
	FhgVHxGCWlZr6I9JKEdGyjQBFL1PshCg5nMeoWKmK/hj0Ex5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747761535; x=1747847935; bh=FOArTy0zBfiJqpS/cLTbAXtFy5ptcEhBAPM
	7VB5HZZ8=; b=jHY5WLth6K4ddBVdZVjc9++IITT5MD4jLOJQEitdugAaxtBx/3X
	s1fqL1IC2G4vwlYTo0p6pSL1TLaABP4USTaD4hI/kRgwGDBFM5tUnxhm6Q7SUiLn
	d0Dw0YT3TjaR/3tw4DxoHC7ZwF5XTuygvBdetpHyvlvZv27qEtSXy0dxA5r+xGu5
	gvTopzINfiAwcbo02G/9Z0hUOWrZm8gFsIkOxmt3AQG32tJ/kTN78LdR5Ej1DtZI
	o6k8Fpb0IjiEGJhXlyPTdg4yMidN9S2yM0gmoQ9tZ8LOY3PuuvX2BD57+vVmAJK5
	3r9lcjxdadXxJf80zuanz5OD/q3bOKTXziA==
X-ME-Sender: <xms:f7ksaF6R4OhpVsyIxNTrQTpeNrsoWsu7S9pOzfrAhwxXMOggXm19LA>
    <xme:f7ksaC511rgW7CwqGT5bE8vH97TMqp95kv9GGv1DwH-HDCLYvsSSV6FAjSQ9xCkqP
    PE9VrY6ULAXku2wfzw>
X-ME-Received: <xmr:f7ksaMeQX0KjTVeihsB0aT4BqIjKb6tf94vWOZbVk2YBal2M5iOGa9qs6ZP-OwrmMWcIv7-D-scxvFAk6SpSVncLUpGzjaTcQ5EHJgCqVcFqucKFHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdejleculddtuddrgeefvddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghn
    shhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtne
    cusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfg
    sedtkeertdertddtnecuhfhrohhmpefpihgtohhlrghsucfrihhtrhgvuceonhhitghose
    hflhhugihnihgtrdhnvghtqeenucggtffrrghtthgvrhhnpeduhfdvlefggeeugfejiefg
    tdekjeehkeevveegiedtledviefhveefteffieegkeenucffohhmrghinhepkhgvrhhnvg
    hlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepnhhitghosehflhhugihnihgtrdhnvghtpdhnsggprhgtphhtthhopeehpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehnphhithhrvgessggrhihlihgsrhgvrdgtohhm
    pdhrtghpthhtohepjhhirhhishhlrggshieskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidqshgvrhhirghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:f7ksaOLaGm1wuKte-K4qYtCPB_pa8KGtqs9xqeUtnLugFnEcDGVwpA>
    <xmx:f7ksaJICspUACx0QfLv3p38JIok-SYfxwbHh5yZv6TYhphYgn-sz8A>
    <xmx:f7ksaHzgmCaK0qctQS5aoM_3zJaEvuvmlom48I9pInOKFwTZjGj-bA>
    <xmx:f7ksaFKOtLV0LKpqfR68PoGvXwLLcobdUTxWUoDUYrsORkZJls_NrQ>
    <xmx:f7ksaMYh7Tg9qLTAIgs7kDUKdXXP-ue7rF_j8mIKB-65Xwe9Uh4JZZRP>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 May 2025 13:18:55 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 42A3111B0CED;
	Tue, 20 May 2025 13:18:54 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] vt: bracketed paste and cursor position
Date: Tue, 20 May 2025 13:16:42 -0400
Message-ID: <20250520171851.1219676-1-nico@fluxnic.net>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A different kind of VT console update this time. These patches:

- add bracketed paste support to the VT console

- overcome a /dev/vcsa limitation with cursor position retrieval

In v1 those were submitted together to avoid merge conflicts. Those conflicts
no longer exist but here they are together again for coherence sake.

Changes from v1 (https://lore.kernel.org/all/20250514015554.19978-1-nico@fluxnic.net):

- Changed TIOCL_GETCURSORPOS to VT_GETCONSIZECSRPOS with proper structure.
  Moved to the VT_ space to benefit from unambigous pointer argument and
  vt_compat_ioctl() wrapper. Also motivated by the fact that usage require
  both display size and cursor position so those are joined in one syscall.
- Code simplifications suggested by Jiri.

Changes from v2 (https://lore.kernel.org/all/20250514194710.6709-1-nico@fluxnic.net):

- Define VT_GETCONSIZECSRPOS using _IOR().
- Replace unsigned short with __u16 in struct vt_consizecsrpos.

diffstat:
 drivers/tty/vt/selection.c     | 31 +++++++++++++++++++++++++++----
 drivers/tty/vt/vt.c            | 15 +++++++++++++++
 drivers/tty/vt/vt_ioctl.c      | 16 ++++++++++++++++
 include/linux/console_struct.h |  1 +
 include/uapi/linux/tiocl.h     |  1 +
 include/uapi/linux/vt.h        | 11 +++++++++++
 6 files changed, 71 insertions(+), 4 deletions(-)
