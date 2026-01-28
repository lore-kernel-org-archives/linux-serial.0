Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432113093A8
	for <linux-serial@vger.kernel.org>; Wed, 28 Jan 2026 16:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769617652; cv=none; b=Y7niXnx59m9GZiDGoQbtMkPHL6tVyuDmGwlxmJ0Oh7AlhoqGnoldLy0j6CNkPIG69dfAuVPSINkAFZnxJQoJ4y1IKkvIwsHWXDdtxs9OWUVMjpbrIE25fu4hC5Wkme/gh767pnG6o2tQszC/bZ7zUIAOfHDeJ0qAdJgt6mPqz+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769617652; c=relaxed/simple;
	bh=Obt19+lMo6d+1YPnRvuc01loQTbRK+u2PQ9eQu2mRVY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VMbO8jnmevnAPVC5M84aB9pXlcC36201yUajdpvBU32rLuOfu/9d/XzsGkmXVtRMGUqvFrG2VydLoI6UjbWCNl5D2qrdMSo2bPUENkdoBrZU4f7osQFaxEDaIJFwxwzSvXlxwQ1qtJB/S+1fXLLmrcF0p2sjtQHm36LMHoB8EDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WsFTRP0O; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsFTRP0O"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a7786d7895so48233345ad.1
        for <linux-serial@vger.kernel.org>; Wed, 28 Jan 2026 08:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769617650; x=1770222450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Obt19+lMo6d+1YPnRvuc01loQTbRK+u2PQ9eQu2mRVY=;
        b=WsFTRP0Op0HpAG36TgtxidIMhXjZthftQ/u2a5couLrbqR4YeEZwvujO5rhuU1UX5U
         EGNNtHlUHrgrulUZVLeNGxFNNVq20oGedC3i0LKGSLzfagnkLHaWuSxtHejKPsd4N+9H
         lz+z6jfWuB7UKoAvd56mrwHO4sgpTPscFl0ZP1qsVTOXPYivoG8lEfVC4BPsETI6gedD
         0BK0y9K5mYbcrCaIOopM08Wuy/6PKCYqnsFxjGFay1MCliwVELD8vO0cNbaPc1PuBgba
         uB/4c8vAH/gTipXjj0NAPeu1x1pSS1e/lYAor1w1I9FYYy5kgtZH3gxd/ISPQ4hyz6Iv
         Z6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769617650; x=1770222450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Obt19+lMo6d+1YPnRvuc01loQTbRK+u2PQ9eQu2mRVY=;
        b=XwBqpNtj3XhYEDaq93rjamavRxH1osYHwyhQZhlscNxgCMiooADRFVS78R/5WK3nhb
         MVPxMZzrp0Iys0Plw9i+JYLj+60HkmCtoNzkzVximd6mWbCz1FC1idvc7eQye7yiglra
         gfFDd/denrKeaxReXA2ZM80ZHR0qCbc5mdYyLMaf/CAsYDS3/Fb3GDdAdHoriDBNQzZj
         bdfGqcFjVgagVQrJACzrL9D2sY+gPFwdWhnRfESxfJO/kAH/UkF0Ak59iePHBW3vtaox
         dWhPNRSl+Vy8GtOUQ5FajudLTT5SM/6OSXJb15YaUvTriwdrKIlnWVSNUwfCt5y9GyRj
         6uAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsYCO3CdfIMo0caK/9kwIYBJEfiz7i2K9mFI87YCw0BQuTVv1HKas0RtZ5SsFEcpP2omkR/MW/nr0Beog=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4kU2izpptlHvJ/UKbnTe9mzXAdxH3jxyFdSetI9OE1DbHLqKd
	RP+WdXB46kLUwZacYJqOydrCKbCQ9U3OdKRQyktwNSw0WIUa3tXaLFh1
X-Gm-Gg: AZuq6aLDAHAsbyAljxgP+HjqwOYX2VgDBvRiCjWM/kXjWCH7Db6va17kYKaodnpaP3f
	hkH2Z8Wd0oZDaHarF17qxS4/E2FFRYrm8xmmz2+J4TavwSX2dj2tQBeLDh9M3tIemkXjJewRcRc
	4jKQBdjdwco9eia0qA4BlioUzCz2IbFVhEWBTkdW/A78AksBj3rdwL1MFvyLAy58TnLCUdut8Mk
	qPw1kP0/5cSjMF2emaLOryv8oS6iPFBrnnuioyFhkHLflsghKMd8Ij84+C3WOhj8jC681IlIaN0
	Xu6bhAbAb4Y13BZHed7RuI9sqTqv5jsCsvjvPxx0JB41PA4jb5io7l4lVJYEljq1THd9W0orXyB
	OJU7jdzTaH4uKAhnRSXmtIFEA5r+5dC1ig291bFy0rKqoyATMorkYnvSXczKWezJ9OGAiTp44It
	W4nMThYSGljvhqXrpOCpeegbI9l6dIdwkMh2H5gA==
X-Received: by 2002:a17:903:22c3:b0:2a7:8bf3:4656 with SMTP id d9443c01a7336-2a870d55723mr51845725ad.8.1769617650274;
        Wed, 28 Jan 2026 08:27:30 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b5d8eabsm27575225ad.68.2026.01.28.08.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 08:27:29 -0800 (PST)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+4b914439b1ce3f6b1baf@syzkaller.appspotmail.com
Cc: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [serial?] general protection fault in k_pad
Date: Thu, 29 Jan 2026 01:27:27 +0900
Message-Id: <20260128162727.54747-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <69795996.050a0220.c9109.002a.GAE@google.com>
References: <69795996.050a0220.c9109.002a.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz fix Revert "tty: tty_port: add workqueue to flip TTY buffer"
