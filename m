Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4732D4028E8
	for <linux-serial@vger.kernel.org>; Wed,  8 Jul 2026 08:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783500444; cv=none; b=K3ChAtMkjEjpWq8TAAAtLEcRau+Isqmw6XaiNIXu9/jiUvEe0iN1NWCjfNMSG+qyEkzovL3B3kHUr786bFtucbE3ZqvIf29d4LvV0fKoSbA6dJhjHbizUtYnCG5gmuLTT9zK3tLqUO9hzCR8ALyFoLEUpLnJ/kIbbLqoEvuKZOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783500444; c=relaxed/simple;
	bh=JFYJwNlUeDpI30EK0lLd4/qcoBnLBogsGxkiN8Nw4iI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LdaLGOHci7OtVXh7EhoyDpCUwMDHLMW/Y75GEtc9K4gsnlUD+2GhErfiUQpmDE/GrdWufhTdkOAVUdz7/0wSArRDnEP2TC1JgMSXIULP3yxeOInvvfwmXV3ml0BnUZw0dphSio+Ha47J6o0IEsI4YSs1AePbujt004BNF5XDUJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aw4rhBij; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aw4rhBij"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-37e0a189b0bso355217a91.1
        for <linux-serial@vger.kernel.org>; Wed, 08 Jul 2026 01:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783500443; x=1784105243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aHSKy3h5lLOjkvRp4gtYQf76cY5cLHkTNVDBkUf0G/I=;
        b=Aw4rhBij/TBaumgS2Ho0Si0TKIgfih2TfmbZru33h23K26zV34r5EKscwgniktER0Y
         pyag8ZRFprIq9N6cCXhQMh4a0jn9LaI2niEJmxbVkqg1HTxmHtLrWP2UEQNp+EtpW8/j
         s6ol9Ffbi/kI8clwHWvHVpH5QUYVY2GjUVKY60qfxaQ6/uJm9HQS1B7UgQ5i6u9O9eYT
         gMcvG1FyGZgRoe7233cZLnLo3eOz6uxWxkDsooe0qMo5gmVeZIoHSMPCCLXIDSU5fw0w
         B5LICC9iJfjc4aD0JJgsFPtXtVwIN9fdFuVHkfNz43pLQpyvU7pjwNiC5PzklYn+5XXT
         jpqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783500443; x=1784105243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aHSKy3h5lLOjkvRp4gtYQf76cY5cLHkTNVDBkUf0G/I=;
        b=fgV7sYgZN6Z3w8a9HI69VtQY7ieZEkw5UIwyjmWCj3wJpLDA08wzR1+78iK3QlWMFu
         DXGt7C396sWmOllcNvKypfe06Z7Ul4zLvmTKkPvzeM2yNDQqQOiGTgKyAFmN0SNdWrnn
         wTMFKK15IdNawYmomXDi+4eom+xy4qc3XwOIUV6fHz3tVu5zY0xta3fq+8FLwMPoZZz4
         YcA9bbk2n049+Q1nrzF1Z0pg5ewlglLHAFjXZYLrbc+Kreh35WOhodYMl1jy+iBXS1Xl
         VYq/LQMOmXZeKCs5sHgZwsytNgtws+1XdGC3Y7w8hfAmNvzqHEJqRQEPXJ4Vp2UHddm4
         ymnw==
X-Forwarded-Encrypted: i=1; AHgh+RotAUs4ZeZ33WFym5bbULgUBeWgwTfxSpDW5MlWf1EG1682XdHY8Na61s6vEf2qoAR6RYpBSR9QxYh1TsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcbNoikisBItt5itLUmHa2v4vYI01evQLR9cvlrx8dDaZb1VZk
	p47mHq4ycKHiJlto3aKHEWdLiLryGnekb7PWujO8Ca4HQXVP07VSkCYU
X-Gm-Gg: AfdE7clzNHEuV5GunCddFLT770GEDL08dcU1VyTAZpPlOYWsjGpyZzwkDV1oAfDfKh2
	NQj6dQfGu0f4ZBEWqhqIWq09584N+O0Wg9fwGeHLUANgWe5WumaHOrxSy+3zDR2NHUbadqU40UJ
	jOXGKeW73Kfku2DR56N0lc9FExGq3tyOMeIqDax0AwdTTCpSZJ0FIz/K49PSB1qy/RQ/ymQ6Abl
	ajE1xz4Us9UOwYH27ATF+Hzz6TtHmUZ0lB49GAs5xWE9RMo0vrSbQpNsMP+f/h6K4VhOQi5aP06
	19t6SQVbWZFHMvMZBIksv7OreJa3UBTG7V4xxDcnI7naCG9/cCk2YnugGJ7YhucTADWKehUP8A9
	HAUJ+1G0T7XdMMBog2bpQ80Fxia9EO7pwFUq73MIcuY5GsxBS/BwuDf7SbALVDu0goxSDn83lNr
	B2qhIFFXw=
X-Received: by 2002:a17:90b:2752:b0:37e:10d1:c05b with SMTP id 98e67ed59e1d1-389417e4858mr1550105a91.22.1783500442624;
        Wed, 08 Jul 2026 01:47:22 -0700 (PDT)
Received: from ubuntu.. ([61.144.108.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d5bdf5sm24281325ad.73.2026.07.08.01.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 01:47:22 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
To: wangzhaolong@fnnas.com
Cc: jirislaby@kernel.org,
	gregkh@linuxfoundation.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yuanql9@chinatelecom.cn
Subject: Re: [PATCH v6] serial: 8250: fix use-after-free in IRQ chain handling
Date: Wed,  8 Jul 2026 16:47:17 +0800
Message-ID: <20260708084717.421487-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708072306.3921604-1-wangzhaolong@fnnas.com>
References: <20260527092052.2086342-1-wangzhaolong@fnnas.com> <20260708031115.3757150-1-wangzhaolong@fnnas.com> <20260708072306.3921604-1-wangzhaolong@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This accusation is not acceptable.

It's not an accusation.  It's a timeline.

Your v1 predates ours by one day — not in dispute.  But your v1 didn't
work.  You confirmed this yourself on May 29 when you wrote "v3 fixes
the Bugzilla reproducer on my setup" — on *our* v3 thread, not yours.
If your v1 already fixed the problem, you wouldn't have needed to test
our v3 and report back.

> That same locking change also closes the irq_info UAF window

Your v1 commit message never mentions use-after-free.  It discusses only
"Unbalanced enable for IRQ."  Our v1 was the first to identify and
document both races.  Claiming retroactively that your v1 "also" fixed
UAF is revisionist.

> For v3, the irq_chain_mutex rename was made in response to Jiri's review
> comment

Jiri made that comment on *our* v6, not yours.  He reviewed our code.
You took a review comment from our thread and applied it to your patch
as if it were your own insight.

> The __must_hold() and lockdep_assert_held() additions ... are not the
> functional fix.

They were added in our v5, reviewed by Greg on our v4.  You copied them
into your v3 and listed them as "Changes in v3" with zero attribution.

Now look at the timeline:

  Jul 7 22:06  Our v6 — posted to the list
  Jul 8 11:11  Your v2 — next morning, same lock-move skeleton
  Jul 8 15:23  Your v3 — hours later, copies irq_chain_mutex rename,
               __must_hold(), lockdep_assert_held() from our v5/v7

If we hadn't replied to Jiri and sent v6, would your v2 exist the next
morning?  If we hadn't renamed hash_mutex in v7, would your v3 appear
hours later with the same rename?  The answer is obvious.

> I do not agree to a Co-developed-by tag for my patch

We added Co-developed-by for you on our v7.  The only reason we did so
is that you confirmed the fix worked on your setup — nothing more.  You
reported the bug, you tested the fix, we credited you.  That's what
open source contributors do.

You, on the other hand, copied our lockdep annotations, our static
analysis annotations, our mutex rename — all reviewed by Jiri and Greg
on *our* patches — and passed them off as your own changelog entries.
And now you're saying you won't extend the same basic courtesy in return.
Copying is fine under GPLv2.  Presenting it as your own work is not.

You reported the bug.  We fixed it.  You copied our improvements.  Add
the tags.

Jing
