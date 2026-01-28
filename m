Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DA4286D4B
	for <linux-serial@vger.kernel.org>; Wed, 28 Jan 2026 16:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769616209; cv=none; b=KeymGa8aKWslMGQNsbxxU0L1lR9g1mAF7WrwP54V+2VX6N866gV98S46VWsjeXxsylStKfKDZ41gHYvWV6od1hC8hqEY4fjyPPK+S/ZtHSm2fp12QyzT4KAn/beeMSiTgCgNKN3atwDuaPG/JPXb9Bru/Jq1UVc/uzGHFdp22O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769616209; c=relaxed/simple;
	bh=Obt19+lMo6d+1YPnRvuc01loQTbRK+u2PQ9eQu2mRVY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=obQjZDei17xvZ1L3nLI53CMxXhTzzSlrZ2LgoU5h8sqCxT8sOAK+ueQOd1ccyEhq6LfFGeyqNmtkTSWR0k2N0dYLGCH/3XOnWCSNEbfO42bGuuqKKHc/kMZ8mnUscRAlEZ6BWXdFW8lGXnbBrel1CT2AwE8KghmIEZ0n7JYc1aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUf8OCQY; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUf8OCQY"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a07fac8aa1so52153175ad.1
        for <linux-serial@vger.kernel.org>; Wed, 28 Jan 2026 08:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769616207; x=1770221007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Obt19+lMo6d+1YPnRvuc01loQTbRK+u2PQ9eQu2mRVY=;
        b=KUf8OCQYYAe5iPCiKdy2WQaUtd37IIU4zv2KfJ9nB0RaOUGz2SPw0QJGEB6SZEUbpT
         4cCkeZI1lyn5x0tHZh3X+SI/FvSNRuOuXfUuS4uwWwNfo7N5FxffrWY91LhO1tNt2iNJ
         QZEvihyiQeLVE3H9sQtSSHB7kdca1pwa6HI09HP1ika5j9A2uvn/liQbHqwUBrzJ3UmF
         OwWD3ZsLLKtJnAi6+sOuROCXuN4XdPIQnukqMK7kNOGhceVbL0Nb48fwaZobr3TbiwOO
         Opp+Ko64qumKD6R+JCVPhHetUd/y5I+CNmPqJGO5zLr0s3tJw1JPdCe9gKRtSFSvw+tH
         cBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769616207; x=1770221007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Obt19+lMo6d+1YPnRvuc01loQTbRK+u2PQ9eQu2mRVY=;
        b=t0GaiZ6J5hbNSZEmkYFq58y0E25I2chSBnTeKJ3vmVJwmQIRrbw8RSS+5bj3eG2/Yy
         /yrC+m4P5jWIJyqtQWvFloV2IKFs5Wl5YOmL7Rjw2UdayDmGcIo/pirfJOWJVjB1eaeN
         3v5BzEUtFKt5mI7kmZ1LC4sKUShq906iB4CRauqDdicpuVmT79gSBONHe0qh/X+I8n89
         ebgcrspwUu5NpJqjno2C8cXruRBIx4f0es/Z/quQD/rulFkX7GnNmpFa5hWv0kfW9uiF
         kUo+tPGnVH3rJ2233/C4iQQFcdR7HmnBvM+ml4XXYzqPl9lInTOXrrDsr8Vr2xqvy7Ua
         25zw==
X-Forwarded-Encrypted: i=1; AJvYcCX5lwkL3tvsSFSTpxMyL45afTU23qJewovR5zw8HTYZ3Lq6LE97bsOoK+vW70VOPUUEVAhKwIvSqfeDc0M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+l8t5Pa2L1eHEUt58lFMn72sQ9+jPb2HjOhx3AlrIqsNipnZT
	uiiDrxjbaxLadMEp3QBlsJUA51RLxZLpGGT2xRZ6iEwcF3HcJNO6RMcs
X-Gm-Gg: AZuq6aLRYBMRQIBK6KSSzgM22les5IWuJhwC/VTH+SqvH2IwMZwet0stexHjjzwuggR
	v9fyo996FQCKxHRZ5PB52/MjAB09Lk3G9xfdA2qhZ43KtbdJdsAGffjReqnbib3pA5fBQYZBYgE
	M7RoEb9edUeM09RS/DhgtI/08s1UugqfMIHndfZmVAkQ6E+mdN5vuSCIkY1kCHR3xXG6YvPSRTp
	7LeqDj441Q6jhgFFpvIEgdXsAq09+nQe7mGWD3185brcWNl9xY1l+xj415MzCd7vR0oj2oVJE6y
	XFDZu1ufnYjWM3YXt/T/nXnGRkqcCydduSkhTlkQBMPoItVd/WQxWCTX+fpQAMQlmZ+TklHvoHJ
	PweO/C/XJy/1rf+dwJ0zmp/lL1Gy0moq+QtxBDnvyb5BGkRkY3oHQfljeJvsIpXqHDQNHfsEOi+
	aFsa0d7z45LhiYoshIoUDQPdN/6bBmDjAqFoYkOQ==
X-Received: by 2002:a17:90a:c2cb:b0:34c:3cbc:db8e with SMTP id 98e67ed59e1d1-353feda7219mr5000619a91.25.1769616207242;
        Wed, 28 Jan 2026 08:03:27 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3540f17955asm2800168a91.0.2026.01.28.08.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 08:03:26 -0800 (PST)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+3f83d97f1d51ddaabd8a@syzkaller.appspotmail.com
Cc: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [serial?] general protection fault in to_utf8
Date: Thu, 29 Jan 2026 01:03:24 +0900
Message-Id: <20260128160324.54561-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <69795996.050a0220.c9109.0029.GAE@google.com>
References: <69795996.050a0220.c9109.0029.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz fix Revert "tty: tty_port: add workqueue to flip TTY buffer"
