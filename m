Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DCC381E9D
	for <linux-serial@vger.kernel.org>; Thu,  3 Sep 2026 04:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788409507; cv=none; b=QV4CaK9hRDxKnC1+USSf/t6V1zFmq6n8KvSp1QNzXTYbzcv2cOxVbdF34mqICufvD+PdTT//Iw2DnCld+HsqmJKZGJBKVzriMyaOWIxs28v08uD18SZU11a5zYPbuEK9UH+npWkOCU9YuB18MDFMANae1jGApSnMDG5JiJBfGXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788409507; c=relaxed/simple;
	bh=Pm2g6WlUGa7uN5+D5OLV6Tnth8Vjj/o0THldBmej17c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rdcqL+U0xyzv26oXDn3xpFU9A/cqrS47F+LC4ayg88u4LcENuOAO1TwH8C/FOaz8yvqv5k2/5YuxIdb0OHdsO1GcGvp5osdOmJzw2K4SwQq2sjCMHoerTRvkPO3DsI78ROUVT3rGsUI3syAY5rTnx2tAm8lau8sLlYvtDGG6u+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETemhVRK; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETemhVRK"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5bfaa014978so1097995e0c.3
        for <linux-serial@vger.kernel.org>; Wed, 02 Sep 2026 21:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788409503; x=1789014303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UwJ9Kyc3h7M9fN4mjn/dwpP9OV7iadH7CHAovsxH2MU=;
        b=ETemhVRKX/V7r5NllUfDLLX7w1KiOfbd5NmKV+VufArPHXjk5gNZgWJnYNZyIPta92
         +LWVfTj7H2Rr3WbISdiL2cRtcs9e5Gel+gQMGl3Dcwb+oElWHr0zs9TOC0mIhyqeWzZd
         8sdSBgH1Xm9ChYzg/j5Dj27akxdC8gMatdCWKQiS2CZW+NTVpO1jop5uOiYBei+yyAUy
         17WGGUZVFFhMah1UUGbYs3v4TBjrIQKrRJSkzPvdjLaOUbeNs2gFHKjFXBu5j440izMt
         7AQ3nxApu3mmuG5Zza9+2OskE0rtvONVdmo46Ove/Eq9JxQ7ofGeQW+8rbWJof63MB2Q
         vSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788409503; x=1789014303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UwJ9Kyc3h7M9fN4mjn/dwpP9OV7iadH7CHAovsxH2MU=;
        b=iTFzGQTvsoiVny9FDCIB7305y4I14JtdeHm2KEyHhx7C+MxgVHdjQzggz5HCbXPFa4
         c93Y0hpPYCZ75GYWmk+f0AGmaUfKWk3kfFU8w5KLs4rEKn1TtYEjh1/ciymm8Kdh3JCa
         ovwFNJgcgoGMsY3hugerKNTFXX/D4k8Mw3GschTJIUawKyI3W5no4LpbrxdB4TqVZ6lk
         XlPz8Ak0uVs8VDFIchXg7SnB9znbYnCBODPSF9W0tkuVWgsm/3M6qHSYmWsxsTJotiWT
         iZ9rptfJ64hRZfFOkZdWenCCpJ0T3Hm66pZusCr5Sb343V034btDpVKUJIBpqzWxaK4a
         PUXg==
X-Forwarded-Encrypted: i=1; AKwUvBy7q/B6hhi+tn/KdP7clqq8XAallyNy7QzXKxvF/3r87ou1xURCqFNm1W0TjjkUBuMu5O/6fUqq1R5uJw0=@vger.kernel.org
X-Gm-Message-State: AFuF++l3c2F76WDXIDGZtcItqcPWnONdRGdAMx6+ms4yYGJdyGt5jcGZ
	/uiLGzt0vMqomOMI6n87z+vxfUS2YdNxWcyY0Xg9b5XTFWB2FLdiitKX
X-Gm-Gg: AYBFou1/PGI8N+6pdKpiGr2KqqA1gYX7E8US+/d7oodMla+mwbneFhkcEi8bL1Iof+b
	gUlojPGwrm4v8l0KylZ+pwXTJ97P4fKc/KDb0epGWtXM/nuOQLw+YdCNGAqh15AlOaVEheRSdKQ
	ZfT3AXZNXHIBnUpDKu3diItfRp7FDwQ7wYl+KYVUz9XcHQ0jsA0RwKsAy697cpFLZ+gx5YLon4V
	TGFE4f98/xfp4Qcpc+f9qiUVwgyyuU369hxmjvIgPEA+ABDd5f+6htXg4is9cWVyXSGQUuVED1O
	j7apIqxtID+7X1pDB1r2rZFJEPlLGPPa8c23vBM2/aj096RUDguVBpAhIpQks76pvo1zFdramjE
	ASa78F+dQKRDItDIT5tG60HhCBxTF1w2I63ix2H88N4kkjKGpBl7aaX4QtsxorBCAUPdihL5ICD
	6o9Z7Pb36Qm4PcGLZC/zubLyXeNF1BgUv4aRjuu0UEg9Kaqh8q0KKZ
X-Received: by 2002:a05:6102:f11:b0:789:3f43:645b with SMTP id ada2fe7eead31-78a1f12285bmr3209154137.2.1788409503017;
        Wed, 02 Sep 2026 21:25:03 -0700 (PDT)
Received: from adriano ([190.215.95.120])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-78a1a4b1143sm3857241137.7.2026.09.02.21.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 21:25:02 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
To: gregkh@linuxfoundation.org
Cc: johan@kernel.org,
	jirislaby@kernel.org,
	linux-usb@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Adriano Cordova <adrianox@gmail.com>,
	syzbot+473d7477c523b41d4046@syzkaller.appspotmail.com
Subject: [PATCH v2 0/2] tty: fix break race
Date: Thu,  3 Sep 2026 00:24:27 -0400
Message-ID: <20260903042429.130320-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A timed break (TCSBRK/TCSBRKP) and the unconditional TIOCSBRK/TIOCCBRK
can race against USB disconnect and call break_ctl() after the device is
gone, dereferencing freed port data in keyspan_break_ctl().

Both patches are needed: the tty core must not issue break_ctl() to a
hung-up tty, and serial_break() must not call the driver after
disconnect. This is the same two-layer protection read and write already
use.

Changes since v1:
  - v1 https://lore.kernel.org/stable/20260903022452.111316-2-adrianox@gmail.com/T/#t
  - Proper check on the tty side, plus check on the USB side.
  - Tested syzbot

Reported-by: syzbot+473d7477c523b41d4046@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=473d7477c523b41d4046
Tested-by: syzbot+473d7477c523b41d4046@syzkaller.appspotmail.com

Adriano Cordova (2):
  USB: serial: fix break_ctl() NULL-pointer dereference
  tty: fix break race

 drivers/tty/tty_io.c            | 19 +++++++++++++++----
 drivers/usb/serial/usb-serial.c |  3 +++
 2 files changed, 18 insertions(+), 4 deletions(-)

-- 
2.51.0
