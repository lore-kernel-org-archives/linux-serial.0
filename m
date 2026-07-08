Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D24A3EDAD8
	for <linux-serial@vger.kernel.org>; Wed,  8 Jul 2026 07:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783497474; cv=none; b=sviniIImKVMDdRPj6aKc7Xh9m7/jcrM7mkKe4kU3sgwucSkhnZGPEJlGwI5HhO+z0rrrxtZi55YjNPSwHUIGi9Chfw+X0nxeI5i4RsK/EDB94R4nY6N93z+trHe5bJI3e0X+qgHSdV242fwJ8DRrCgxFESxZep+nkAPNXfgMPNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783497474; c=relaxed/simple;
	bh=qUQCAJuwW4Rjzzdp0x98+Xlms0UiaZirbGW/HA7a1CU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bVyflWH9wxTHVUfyX+4pjdmFLr1gl8KD7jVQ1n3Xb74Lg7Nxs5/sR79s69AAQaAnr8E3vI3TiBdF3TwWe0ZePjV8ahvf5VPoAzjEJrxzbVcMyLzEDGuBO5yzbpuIqQuqDqJF5Fl0PCONMsQu1YMwWMr3LhW8WK5eWbaV0cq1JpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZO00sLv; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZO00sLv"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c9b1edf2bdso5661395ad.1
        for <linux-serial@vger.kernel.org>; Wed, 08 Jul 2026 00:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783497463; x=1784102263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=486WW1JHMRQKBuqFsIZ1uCG0N19quNrCaa6r6U7OHUM=;
        b=YZO00sLvwz5VjsBPs2frGZXtYzSwQrHIE+3jtgWDS+KDDpFID18iXXvJUOwvqUm6Hl
         GAAYp45VuUj6E5hH63xFNq195WStjrKDzFLFIe5kmPcrpGgv/KWg6ovXxLwrWHrKADrr
         38F+vdI5HlbpFhODb1iT2i8d42LEI9b2mIVhuSbJUqAMmM7Ts3l/dF1e4bHkfo9Yc1np
         ssD2M5dq5rjYajynXT082z2KP4cWsJFePrfQUHp1pGpgoWm0RMPYEv/W6G43y0n8d/sL
         Boz5MJIyVNzsvxxG0niM/j5wtNp9lMvOu0/dcRsDbkP2tKSBQFdjzwcogSUItQJ4qe7d
         uEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783497463; x=1784102263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=486WW1JHMRQKBuqFsIZ1uCG0N19quNrCaa6r6U7OHUM=;
        b=fQMFFtdZcqfKFIasEAXKtntdai0nr4mttco4QdHKNIecgtDL8Q6s7ihK7u91xWjCaa
         oHkIqQxYJUGd23h4Q+Y+8ab08ytvvfvE5hDhJj9AWjVMkxLcAJEonadzEsxQsip9jKk8
         /O4a8YHbJmIRRC1+0f5b/J3yEDM9DA6ERu+P5sZquwo0u6Gl+LBC8d4ogyGZ+OSY8nIf
         d1uPSLLqWWbc0gLSA9y1+OErON3lOFX6NGU3+84dZUCs/kY4Tc1yqNj6uMkX5zwn5IOG
         nq2578AAAe5Mat7ORRWjwsZg5RO8rO3n37hOfPscLD8T+kbIosd4Mq0OnQRzdO7aIiSV
         azqA==
X-Forwarded-Encrypted: i=1; AHgh+Rq5Ka6Dga8mtenYiqOAb1SqoNJJvxzSjaDsYtgiZ5i6F3PpYcUWLFwTC2y7xrY+5hnunS1wzxOOmeXgF3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBkB/7IeBCdi8Yrk+sMdIHol5W/Vtx014SqXy7XUeScmrYQ26d
	zw9hX+4tEk0/ovYGWdAI6zFhk/LMDkhOFZaQJInjxGi/HCWLsYxKNliS
X-Gm-Gg: AfdE7clIk6Zmx80TYMWggQojB9l2WWLfkInhOpElo+FAE0J1RnwM5aede2ohZJlC3h9
	L+PgafPTz1HKOiay2OCKrZn/edw2wDNcLFV5XJx/3lpUgfP20BF26D8SBPBWjGGQIC6jKWfVdi8
	mEdhRPptikCfoBdtByjx5gKhgpuvDQ+AqtcQ+q6yoxwrRvzTKTmCGuwr61ZGu+aL+GLQbDM5lOE
	SWUpEIeBFKEZVjTZ7csZ3NP+mqYca0t2PNMMMoeCiITkMyeuM3ps3OGJLl2bmJOOyJFO2fi/lot
	T+3kKdwfc5jGBL1ux9vkYSDsMdbXEuWKzO6y7s355N0p2UAjuJbHwNfN97IttEoDy/52loSd4sF
	mxFSMC6bdKYoWvzO0dGp+E1r8bzCsMQxt0DAMHLSxI5Jwx12DiVqz6m6XlZ0qgb+RAIcnnGMIRp
	6s4uMjV2d7+ZSDQuIu+A==
X-Received: by 2002:a17:902:dacf:b0:2ca:d91e:bfb4 with SMTP id d9443c01a7336-2ccea4295c7mr13888285ad.24.1783497462906;
        Wed, 08 Jul 2026 00:57:42 -0700 (PDT)
Received: from ubuntu.. ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d5bd2fsm23631875ad.78.2026.07.08.00.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 00:57:42 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
To: wangzhaolong@fnnas.com
Cc: jirislaby@kernel.org,
	gregkh@linuxfoundation.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yuanql9@chinatelecom.cn
Subject: Re: [PATCH v6] serial: 8250: fix use-after-free in IRQ chain handling
Date: Wed,  8 Jul 2026 15:57:31 +0800
Message-ID: <20260708075732.4139996-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <5cf37150673ea4d5c28f94db91cdf68504b50522.0e091ec2.1d26.4eb2.8da3.53f8a6520707@feishu.cn>
References: <20260707-bug-221579-8250-shared-irq-race-v6-1-f8c499a90bdd@gmail.com> <0ede8499-abe2-41d3-bb0c-095c02c5b699@kernel.org> <5cf37150673ea4d5c28f94db91cdf68504b50522.0e091ec2.1d26.4eb2.8da3.53f8a6520707@feishu.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Jul 08, 2026 at 03:33:36PM +0800, Wang Zhaolong wrote:
> I do not want to make this a patch ownership discussion.

Let's be clear about the facts, then.

You reported the bug.  Our team fixed it — the next day.  May 28, our
v1.  You confirmed on May 29 that our v3 fixes your reproducer.

Since then, you've posted three versions — v1, v2, v3 — that
incrementally copy the work we developed and refined through seven
iterations.  Your v2 copied our lock-move skeleton.  Your v3 copied the
irq_chain_mutex rename, __must_hold(), and lockdep_assert_held() — all
written by us, all reviewed by Jiri on our patches.

You list these as your own "Changes in v3" with zero attribution.

This is not a "patch ownership discussion."  You copied our code.  The
kernel is GPLv2 — that means you can use the code, but you must
preserve the copyright notices.  Co-developed-by is the mechanism for
that.

You reported the bug — we fixed it first.  We credited you.  Now add
the tags.

Jing
