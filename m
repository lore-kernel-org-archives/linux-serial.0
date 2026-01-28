Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AD0313E03
	for <linux-serial@vger.kernel.org>; Wed, 28 Jan 2026 16:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769617912; cv=none; b=p7A24iadVuBsdQl2tHJyslij4n4Q25rJuLUJlOiSv27RhTzBkDjeQ2nB6mOf+N4dx/ixvWhZBxSK70K1o0MVK7axH8C7HJP/xJHPJaMl+8PO0VuwCtdxhMlhW2me8ouqLLzpoTr4bkMoOiXjaaFyNk87qiueKW0YU3X7IwWwPMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769617912; c=relaxed/simple;
	bh=Obt19+lMo6d+1YPnRvuc01loQTbRK+u2PQ9eQu2mRVY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vETbfsYsfUV6wxX37HQ5G2iuKQbcIIXFfvWIEMHxhKiN5/ouqP3AvpLJ8QtBLNS1SRo6oWBP7Nqxh0L+ol1QbPrKiwZHjQwAMvJAWMZ7J4dgoW7I4u5L0bJ8gfQngh9/af2DzIrUsWtDiIyoQiip+mH+FsCIrIcLQHRiFNFnE5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngMRCdFa; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngMRCdFa"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a8a7269547so5200395ad.0
        for <linux-serial@vger.kernel.org>; Wed, 28 Jan 2026 08:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769617910; x=1770222710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Obt19+lMo6d+1YPnRvuc01loQTbRK+u2PQ9eQu2mRVY=;
        b=ngMRCdFa3Nlyvq4HVcYeWnUWYLm4V4Erx7lVyM9zYCSk3Yu9YdmrAJyEcAnN9RF5te
         yBEwwJ+dio/pPok6mE7aI/Bo4IZ3bNIdCD5cZTwejjgYMy6QnDwkZcx1iCx85PlVTJju
         S94MX3bj30bTYNUectT7eCykfiNeGAWv7CrBX2pZXDfRRQX4+CRGWEtBgdgI9p/iGPUd
         Tmpyr/KEjQu9WBkpA/7WC9ctVhZT1FIZQNU8Lcy/0no1GKYeN1eoroXG5UX0UmhYzQPP
         CBnf+G8PyNwADWFoIayJ60agk9pfFz06DAMdDB3JH7aGqoWDwest+GcfQgyL1urLqr1q
         BdsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769617910; x=1770222710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Obt19+lMo6d+1YPnRvuc01loQTbRK+u2PQ9eQu2mRVY=;
        b=R43uSCd8zLUuGFLHaPbWmZnBq8oSHQUok8w1Tt9FF7M07UShDXpt8P9bdP4G14PzkT
         VHqxsbUQhs2KOuU6lnJmE+3wPYps3L2G8qZ/J5YXxOisg2cMhiLy1EKgOe3C2i+VXtns
         DnBBKy0ItCUNtm7MGrP6/WLWHreVJmdF4P9qOwaH70wzIN5Q5sLd9sn/AhGSAWjwVtOh
         2Rv61a2YNr38PvvyWxnaQy1Jc5+B8bK6gv9IesIMyoo/DE1piR2H6o2KYgFQ15501SXZ
         WXs0CzHdYb+Ldxf3XWspn3A38zgxgUoWSZnywVgqCT5c1EnCIOUQrs3ue3OHueflsdsm
         7wHA==
X-Forwarded-Encrypted: i=1; AJvYcCVMzQVSw1AGcqbqiZVLLlu2yotTjPh3tIqhUu/Lz3o07YQjet0hDesICLSdMfVbOs3jYVLTbyzZU+QX0vs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX4cGU0fcbMZ+QNtEniQTGI6IFD5+RnqUvTxlJZ620HcnNAEdk
	CtiwDrWMRxs49bNtoIg6XM5WLmMGRt0uqeqDpEJCeM7T6EeihEoIc2va
X-Gm-Gg: AZuq6aLTF7RU6gi8WPX0WEcaZnSUTmkTv1dqZP39fe4Y7sKk9fCKuUGNpxvuUW8jKNp
	oUz/MvOExD9D5DLivy8GSvm24HrFC5ixKPFGUFbW1Jh4TNFSDNxmVXMzxJ8lkAdE+DgleVIrIXD
	UkrNN2YX2ML2USMWzG8voSfD6cFUd5rzkV2L0A1JDEUMraXfB/Mn7sIDVhqsLf9ZDhmy1q3mVqZ
	6HHsygY7qmTgDl2CsYX6fnVkr0QPhtkKUJ5cZPyZVkTJD3Nqoc/xvZcCgKUFjM1J7+lMrgw2jpo
	DaPbKl6TNKmFJ9UBy3EuN4tNOIxI0Qgx1DTBcvXjsNqpeXhaBf2wnudjI1MwVouFrWq51Tnmd0x
	Q4MdW1uQzdkaZD+UtQrLyGKan2gfFrdfLx4usXt+2FyEiPahQwz2vYZkXCiio+5sOHZImCEpoRq
	9MYxHpGCWNRMkOouevEyoTEy8hp+uyd4rpaZcOBQ==
X-Received: by 2002:a17:90b:1f8b:b0:349:9d63:8511 with SMTP id 98e67ed59e1d1-353fed9b7d9mr4780189a91.25.1769617910257;
        Wed, 28 Jan 2026 08:31:50 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3540f5f12casm400019a91.0.2026.01.28.08.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 08:31:49 -0800 (PST)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+bbe4d8bcf8e458140bb8@syzkaller.appspotmail.com
Cc: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [serial?] general protection fault in fn_enter
Date: Thu, 29 Jan 2026 01:31:47 +0900
Message-Id: <20260128163147.54831-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <697959d5.050a0220.c9109.002b.GAE@google.com>
References: <697959d5.050a0220.c9109.002b.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz fix Revert "tty: tty_port: add workqueue to flip TTY buffer"
