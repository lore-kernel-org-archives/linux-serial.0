Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DC04028E9
	for <linux-serial@vger.kernel.org>; Wed,  8 Jul 2026 08:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783500199; cv=none; b=kdAsgbob8k8+Nj62CJemdUYGUKS3QY9vxySWpN/M8DKxVYlFUl5CFXnEp4AY+vmEXJ5+zZB9wgsiH1OWt2LMe74o77doNXFoFkX+Y4kvqMlJvWSLKl5lfVX2wta+T93raLPV/O6Zvtj3XCqxj6LZnn5Na9LiCMUKmBj5A7Yeumw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783500199; c=relaxed/simple;
	bh=JFYJwNlUeDpI30EK0lLd4/qcoBnLBogsGxkiN8Nw4iI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ic95nbYVVnG8phkabGbfIW7ZypIKOWkJfupulHfy+AuiH5OdtHxutLzj8MrsCVOAVsBYUssmH+J+XiIcET4XCeD5Rk7XX4+GgjdV56ylFIbow5EbImXibOrgQpYXq3jaBzZEtNYvs4TY9PTWEQox3v8vDqmH+kjA4CN4QHIlDSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MuRlzJ4n; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuRlzJ4n"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-384c94c9414so397801a91.3
        for <linux-serial@vger.kernel.org>; Wed, 08 Jul 2026 01:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783500198; x=1784104998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aHSKy3h5lLOjkvRp4gtYQf76cY5cLHkTNVDBkUf0G/I=;
        b=MuRlzJ4nS/wiOfzVWAS8dZxdW6hCFFw/uJaqCcmdsN1h2TupC2RUzjl6UCd0mCxuce
         j4nIuAEOc74F2L5OSR211sVPIBed6q9Xpuj8I6e1rB4dH4Ac5xTbm5mHWhBEzbp16ysc
         dt6iQXWiyujfAmoqobP5D7yBRW/PrSWFocozhK18Nu+Yu3Ry2Quh55HifeGeo8BaxB5N
         y92Uxzxy9fs6XWRt1z9AZMNyxc5LpeftUZQzTm8RR+t00SyvyQCOfK4zfun0KkTru9ur
         gv1u56RXrmkZSANuneTSq1/bJj+fQTRrr7lWkYAuCAj0ZcNMxqEbnERNdm60NIgs++w7
         uexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783500198; x=1784104998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aHSKy3h5lLOjkvRp4gtYQf76cY5cLHkTNVDBkUf0G/I=;
        b=PTISGE0D24dXE0eDcU2Jg6YLGIe0KsMA6VpUITCbqEfEhYyLjF3Y2PoiR1Ge44iqwL
         eZ+g4MPZV1ET3G3LTNOiBgnZLxJivfA98688MCvB9SZYspW7JUOvii8aBufkBgLx5eZM
         nxZHTE5S8RyP8/qj7Nv+GClo9a5niYArDCuCsZPi9jSdwNJ873/hpzd/HF+sl5R9p2Gv
         BqzzUdxDFgp+l9w31xlwhBGpQwPWn6KbXb1+gPoCah2PCxKPQN1WG95xIZRL0Si83kfq
         f1h/WRLGP4adkf/w+3thXvQD8VS5jq0k8cwTo3cRP+jabGh5OdGz7YiNvBESK/m3iC/q
         ZNEA==
X-Forwarded-Encrypted: i=1; AHgh+RrTYy5W8nODt4WiUBamut/WhjN0eIp0fqo5gtQSBKbO/4R02ZVLxS/DB+i2beiTW1R6Nm0UUznzoOuoJLY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1Q/U8H96LItNQYVKYh2bYW+PKYuormGneGa9M8gcQ9glT0ADm
	I4JTltyinR7ENlgE8SOR4dpNiIkenHSXcSwJ1VYLYmXybP7dGY8WRruh
X-Gm-Gg: AfdE7ckizjg8K6ZiLae8zfAFC+llCRl6lhQypNp047DiaePupQnTG/T3z5Zw0kXIVyh
	Udo7rhX+vCluutG1u2ZqTHX3xWwxHKpbu+kJw2v84bTMz4SgYR7rKwVVSnuk2s7/z4yh+qbYavA
	7KPReh6LZ9nv9OtJiuab7MJ+0AJXbFbTp0ofytgmfIxNeo3gbbu/ucaylYb8stk8mGjMONwPRqn
	qL4Pah9bfeicxAqkKEVqkftc7TNAghM/4X4TUA8mtELilqyAXsjLtfBUUfiGrCRmaIWYspCvbmT
	Wh/AeFqs8itjx6NNvKYa8FMgB+9xDt2uLrSiV52fMSXBP9fwSMyjRu5Zn9PJVgMH5Nnc2aFIilZ
	F20Ne5OUE7B3X1dZaq4BSlzfoCkmaL29Mcz5htcPltDj5RgSitbE3mquPkYT5kCpyNLc6kX4PH+
	bM6+FNeTXdD4KhNDODUA==
X-Received: by 2002:a17:90a:e183:b0:381:25ce:bcc2 with SMTP id 98e67ed59e1d1-3893fb6b6ebmr1536848a91.6.1783500197556;
        Wed, 08 Jul 2026 01:43:17 -0700 (PDT)
Received: from ubuntu.. ([61.144.108.37])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-387d13fd7bfsm2478447a91.6.2026.07.08.01.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 01:43:17 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
To: wangzhaolong@fnnas.com
Cc: jirislaby@kernel.org,
	gregkh@linuxfoundation.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yuanql9@chinatelecom.cn
Subject: Re: [PATCH v6] serial: 8250: fix use-after-free in IRQ chain handling
Date: Wed,  8 Jul 2026 16:43:11 +0800
Message-ID: <20260708084311.385934-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <5cf37150673ea4d5c28f94db91cdf68504b50522.f7d28dac.3ec0.4c7f.8bb2.ce59501a4b8d@feishu.cn>
References: <20260707-bug-221579-8250-shared-irq-race-v6-1-f8c499a90bdd@gmail.com> <0ede8499-abe2-41d3-bb0c-095c02c5b699@kernel.org> <5cf37150673ea4d5c28f94db91cdf68504b50522.0e091ec2.1d26.4eb2.8da3.53f8a6520707@feishu.cn> <20260708075732.4139996-1-realwujing@gmail.com>
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
