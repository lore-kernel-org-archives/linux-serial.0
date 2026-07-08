Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DAC3EBF07
	for <linux-serial@vger.kernel.org>; Wed,  8 Jul 2026 07:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783496397; cv=none; b=K//rWaCaMOju6JHUYHQnNYgcPL/wyjM7kD07Mdf4CQMH5YSnEnrVdXNjQWQxYRDXAgRHwWhhDXngq/DodjNFnd4oUJPPIt3xjXC/LZe4U+roVCT7T7mbvleDkDpeRbwkFkMl9sAoYH1yhSaFrUUvFormUP3GDS4/IvX1hR9FHig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783496397; c=relaxed/simple;
	bh=Eq3OobiBuPPEljSZV1qR/ybfYbxFRevHYoljGwbs/oQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WuqBV6yIN81KjPXB1ywI6j6EuHl5BYMIgQ0LFpEYPcUjznbwh+00sYWTikw5XHcdD5EqysYRfRZoX11GsBkX8rd3IZnTjpJ1oMH1vy/FlJy6XCJS4j4zp8n44UaxeUj2PN+Mr0Gv8gPffDZ4TFlaETnSk7xWV//57m07U/e8B2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XX7WgMkM; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XX7WgMkM"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cca24023edso5804455ad.1
        for <linux-serial@vger.kernel.org>; Wed, 08 Jul 2026 00:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783496385; x=1784101185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+pxaPIGiPBZm50eJSfbW6UPjpiFIRlWoavGQXcAOzg=;
        b=XX7WgMkMjXJpxVOkgqwW4t3lmNAnnosNcNw0iUW1FmOIu065Quoe6KAGlXGK9gAxkx
         dbFbU/eC/3hKz6Sq9w1VD8rMIGsAE8Odezioci9UprMpUSiolqD0taME1xqcSfpznlTx
         F8ssyR3OXNEKA/QkLd/+/2llzUeGQBTNU9ZY/4Xzh5u2jyF3KFl+U2M7xchGB4gAKVJT
         WnME3IfwmhX2ZDHw9IdkCzWiBIpEYGYIwgooDWYurWjNLnqir6DVfogymj0WHA/ElvGS
         OGBj0MgKsIhxR+eLyfE7mTPWBMiWnRed+PGdJHRcknTTzlCZxr+gLZ+1PVjj+o23lGp3
         NIeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783496385; x=1784101185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I+pxaPIGiPBZm50eJSfbW6UPjpiFIRlWoavGQXcAOzg=;
        b=CMTPVVK2ioXcWlRuQZzWsQ9sPDOoA8nMMEJkGKsA6hNGFCGW9qJTppCJty+NnA+FNK
         LCdEFgolmQJxv0WJSR0o0703ioyGUOqsQ6kdxLE/f0wTzd0xVTP4DVUeIgizUBZyG1JW
         xNJgP6tVGZGbZC9YBxC6icIqGSKj5/fyjU4jYYpnKjZ5fkDsLCimIdcxaAvXll1UKJez
         kKi5oy60b6ZLY/RJ6gKDMcWN9FnYIoZWRnPfHOeuf6sITnIW5RQ+ES50edEStzc2DEdL
         sZbWIboUpUZbaZ0TQG/4VX4I+LoJMR+IvR9dvTScf/2ZGTHk+3u7/xHqSvxGnEmQB00e
         b5sw==
X-Forwarded-Encrypted: i=1; AHgh+RoeCtlBylT52azgpuMK/u8PZEImZNhC9mJZjV2pfG7otYVmY8TKAkSDV24MBXFkQR04MPD97Rm1qVPyAck=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHmWxT9NNQ436Mu+N1z0CBIPE/mbE0Xq3iCDhvLQUv5rWSeVB9
	rZ0tXcB3XSJO2KtAuVbmtZpM5PFmI9jMUQZkm4n9L7G8uwSPmJxvnosHL8WCIvJxkSE=
X-Gm-Gg: AfdE7clkiVqpp6Exx3VyM8x9C7CYqWf6lY9+p8DnAlRKYYlad9KyyJ5KNgSSAzl7IE8
	+bE7XeXFL7tPsBBt4VWgwb79JNtAHFwXO04OXPz2WnxDRAcS31+gybaBeTSFu293OTExSAAh9pQ
	b1vg92EbLz52PyaO66AarHVi5QlKoEhp5rZrqcDaOhztGLFyo8DWwdmcMMWNlnQltKCxupNDnjO
	/uLWjL+zzNzfQlANSCzgjHR8ROpjsk/pgpokZARfn1MSWPcoOfzHgwQgpqZ/nIj2+8BTs+5xv+B
	3Jz5CfjGsyX13r08lYrFi1v3brnnGAP/s+QCLEEJc4RSMHqoHElAIvLiL5k+W+4LKkrYspJ3bKL
	k/b6eB2IwMvifIoq/9Ws/lNzA/OaRszAQhBvHlAUIaxzGc6ifsN4NaiuOnMGQ5igbcO+li/EtAt
	0cTsUS1ojibOJ6DuDJVg==
X-Received: by 2002:a05:6a21:4582:b0:3bd:3800:7538 with SMTP id adf61e73a8af0-3c0bcf49ca1mr1613758637.33.1783496384550;
        Wed, 08 Jul 2026 00:39:44 -0700 (PDT)
Received: from ubuntu.. ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b3b25204sm1997705a12.28.2026.07.08.00.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 00:39:44 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
To: jirislaby@kernel.org
Cc: gregkh@linuxfoundation.org,
	avorontsov@ru.mvista.com,
	alan@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	wangzhaolong@fnnas.com,
	yuanql9@chinatelecom.cn
Subject: Re: [PATCH v6] serial: 8250: fix use-after-free in IRQ chain handling
Date: Wed,  8 Jul 2026 15:39:38 +0800
Message-ID: <20260708073938.3975921-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0ede8499-abe2-41d3-bb0c-095c02c5b699@kernel.org>
References: <20260707-bug-221579-8250-shared-irq-race-v6-1-f8c499a90bdd@gmail.com> <0ede8499-abe2-41d3-bb0c-095c02c5b699@kernel.org> <20260708071138.3698581-1-realwujing@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Jul 08, 2026 at 08:03:55AM +0200, Jiri Slaby wrote:
> Ah, now I see you are fixing the same thing as:
> https://lore.kernel.org/all/20260708031115.3757150-1-wangzhaolong@fnnas.com/
> I did not look up who of you was first.
> Looks like he reported and apparently tries to fix that too ;). You were
> obviously CCed, talk to them and don't send two patches for the same issue.

I sent a v7 [1] addressing the three review items you raised, and added
Co-developed-by: Wang Zhaolong and Qiliang Yuan.

Wang has just posted a v3 [2] which copies the very same changes from
our series — irq_chain_mutex rename, __must_hold(), lockdep_assert_held()
— without any acknowledgment.  No Co-developed-by, no mention of our
series in the changelog.  It presents these as his own improvements.

The full timeline, for the record:

  May 27  Wang v1 — only the THRE test race, no use-after-free fix
  May 28  Our v1 — both races, full fix
  May 29  Wang on our v3 thread: "v3 fixes the Bugzilla reproducer"
  Jun 24  Our v5 — added __must_hold() and lockdep_assert_held()
  Jul  7  Our v6 — back to guard style
  Jul  8  Our v7 — renamed hash_mutex to irq_chain_mutex (per Jiri)
  Jul  8  Wang v3 — copies the rename, __must_hold(), lockdep_assert_held()
                  from our v5/v7, claims as own work

Wang's v2 (Jul 8) was posted after our v5 and v6 and uses the same
lock-move skeleton.  His v3 (Jul 8) was posted after our v7 and copies
the irq_chain_mutex rename and __must_hold()/lockdep_assert_held() that
we added in v5 and v7 — yet his changelog gives no credit.

I've been happy to add him as co-developer on our v7.  I would expect
the same basic courtesy in return, but apparently that's too much to
ask.

[1] https://lore.kernel.org/r/20260708-bug-221579-8250-shared-irq-race-v7-1-xxx@gmail.com
[2] https://lore.kernel.org/all/20260708072306.3921604-1-wangzhaolong@fnnas.com/

Thanks,
Jing
