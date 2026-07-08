Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001863DCDA0
	for <linux-serial@vger.kernel.org>; Wed,  8 Jul 2026 06:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492468; cv=none; b=VCZV6dfNBzOj44tsr2JHI5LiD+3CNJcnzksMImKMIhm96KFK771fFvmdGHIldrO4jO1i/uFSinL/KTRLXZs3WtLErOiGBYeE+Y4zJDu1o7pJAdtrVOjG8pSfcH4BZ0lFBhXFVC+gFxIceseqGiZKVlSe3mWXL5ZqlFUAMbJsr/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492468; c=relaxed/simple;
	bh=LT0B1dhU1NRKbZdY/SDRVDGianQnqntWCIrMYKlQik4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TL8MSuQoTTVm9wS05eSxg7SEhHi5OnHD2o5ktO+GKw0hw3E/yrcUVfNYgB5lu7kMrpwWWWkr3DzXPk8SKLKJvvWJWTI8XZlBJYptnzkxXqBCg0A1HazV4GlbQT7bA+AKgCsJXt/0bF6DVzIBWelPVQ9KEpqT2F2ofsFPpeUMe1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gA+XJxuL; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gA+XJxuL"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cace91f112so3566375ad.0
        for <linux-serial@vger.kernel.org>; Tue, 07 Jul 2026 23:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783492466; x=1784097266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qijf+Q/iz6Hk/taKo9zjQrhkXJ3vlM7+8IeyvqN/Bro=;
        b=gA+XJxuLIUkAsBvOPdfMg/W0VTu1vfAsX7PFnVvpWnhEQPAu1Olv2aTx6HwhEX3QUR
         x5CEyzbt7xc+9WlTk/DB3kHBi+M8irUmqsbzkbsETn63Ppi7s9fkjVMAusziPX5i/dkq
         308+A0tFHLgy0E6q1jWwsz4BPbOPumSZmEAgTfnHTHcQVOGvnAIOxlBYqBwk7e/uwVNN
         6q2AlOBz/FWp+qeZZeTcg37/oJYy4jDmseytP0JFI+/IWKbSrqjsF9kiTrap8QtbaUfA
         h3j4yuo6zlO6z2lkxPR10PJEO3lDtAtO2trCq985xwxdKamlqBABTd/kZUGkZmCAWzjt
         rHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783492466; x=1784097266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qijf+Q/iz6Hk/taKo9zjQrhkXJ3vlM7+8IeyvqN/Bro=;
        b=BNHremrUD+d2j1rXYBCvZjQPK5QDkGPH5MMt4XD8+s4FHx8D6pdaD4W5Z41VqWvVY5
         jWM6MmBFCtEKcSNxSZg8oSbmAP6QtTK/z5csQYkp6ZE6/p3TowwSEQbYeA0ybHVBqphw
         7/BPbTxsT0/6hVAad0Ft9OBaVsPh+m9dDIyNruxuCO26Bjek8l6SAeYdwpYKs4rlREfp
         4bNTww2t1J6rOIYcnxuny3HEzKBclGTbCI8IjVGeK5Xpy3LUICVZrFmuLPZGJwXVaBCB
         zQgpss+FbPx8f8WnJtC3KWeIjNPBRz77ub5lllkLkYD4/k8OVZqFm+IEZjkxc2TuRxtf
         SnAQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro696HTmE9CoJxOl+r4QSzP99ilsL0DgtUWGBx7hcuYYb1Qg4oRQ74Eckaf4iCXnsLo01VTcNSEVAUNOuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHddba9Su+iOSQu0W0leFUvMCCnyDh9MKRZhIUWZaVJ/b3RLwM
	aJk/UxZ2pj+UdcBEo1yKX2dqH0ZeYOS3T0rPLqueJSWih0/JbDDbts5n
X-Gm-Gg: AfdE7ckXyotGgLcLKctcVJuRjRlLsk6eUyMFgmAEKpPCVMLlld0dxIH50PBIIZHhVfQ
	gxXKOxo6ECUiOnQJy0H0P5m4w3XI0olcsiMyqeIcqI9H8vh5zOGF2O6bzjwvp7M9Pe3ium8qTqM
	5RweZzuiAA+tEg9XmQhKhljmeZKICTGalpQa/39BAQt1fvgIXSBpCNkoaLVqXLPuH5CIGK4i2n0
	paN3XQILhINf8ltF9iBxb3L1NXbbj0K/x1pHJIyHJfN8lztqfIlq15XYckuCY75jgQCagcatCZK
	auvn6jZd6XLpMTWRCQiJEKUPUJFJwK9ZX/J6Qx8/ELPM2y0FS2XSXGXvXDlFy8tZkdB7asujvZC
	6ry1s9rLrngvGcOr3MGfP6u5+Zh0ZDa0mUT33Vd/pO0j2B8OF7cKjC6Lyo5zoOfNLKxMyVDuUML
	3YEdVJOgk=
X-Received: by 2002:a17:902:cf09:b0:2ca:6d87:e684 with SMTP id d9443c01a7336-2ccea488100mr10566585ad.32.1783492466094;
        Tue, 07 Jul 2026 23:34:26 -0700 (PDT)
Received: from ubuntu.. ([61.144.108.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccdf808379sm10187935ad.48.2026.07.07.23.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 23:34:25 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
To: jirislaby@kernel.org
Cc: gregkh@linuxfoundation.org,
	avorontsov@ru.mvista.com,
	alan@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	wangzhaolong@fnnas.com
Subject: Re: [PATCH v6] serial: 8250: fix use-after-free in IRQ chain handling
Date: Wed,  8 Jul 2026 14:34:19 +0800
Message-ID: <20260708063420.3332316-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0ede8499-abe2-41d3-bb0c-095c02c5b699@kernel.org>
References: <20260707-bug-221579-8250-shared-irq-race-v6-1-f8c499a90bdd@gmail.com> <0ede8499-abe2-41d3-bb0c-095c02c5b699@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qiliang Yuan <realwujing@gmail.com>

On Wed, Jul 08, 2026 at 08:03:55AM +0200, Jiri Slaby wrote:
> Ah, now I see you are fixing the same thing as:
> https://lore.kernel.org/all/20260708031115.3757150-1-wangzhaolong@fnnas.com/
>
> I did not look up who of you was first.
>
> Looks like he reported and apparently tries to fix that too ;). You were
> obviously CCed, talk to them and don't send two patches for the same issue.

Wang reported Bugzilla #221579 and sent an initial patch on May 27.
I sent my v1 the next day (May 28), and have iterated with Wang's review
input across v1..v6 — the timeline shows Wang's v2 (Jul 8) was written
after and based on the direction of our v5/v6 series:

  v1: May 28, Qiliang    [PATCH] serial: 8250: fix use-after-free in IRQ chain handling
  v3: May 29, Wang       confirmed "v3 fixes the Bugzilla reproducer on my setup."
  v5: Jun 24, Qiliang    [PATCH v5] (with manual locking)
  v6: Jul 7,  Qiliang    [PATCH v6] (back to guard style)
  v2: Jul 8,  Wang       [PATCH v2] (same lock-move skeleton as v5/v6)

Wang's v2 has the same lock-move skeleton but is missing three pieces
we've added through review:

  - lockdep_assert_held() and __must_hold() in serial_get_or_create_irq_info()
  - hash_mutex covering the request_irq() error cleanup (use-after-free fix)
  - addressing both the use-after-free and "Unbalanced enable" races

I'll add Co-developed-by: Wang Zhaolong to the next revision.

> hash_mutex is no longer an appropriate name for this lock.

Ack, will rename in v7.

> Unrelated change.
> Unrelated and mainly unneeded change.

Ack, will drop both the blank-line removal and the return 0 change.

Thanks,
Qiliang
