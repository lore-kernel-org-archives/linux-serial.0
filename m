Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A62737F310
	for <linux-serial@vger.kernel.org>; Fri, 28 Aug 2026 17:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787939891; cv=none; b=rxsvCzpAkUjZ8NRY6mC7J0J6wq9NvVOVLLce/KjtElspSC1Xl5Ao8uVX48/4cGM1vv+0uorNQXuZbW7TKbXP6fDl5Oq7Wzww2fgeiHhw3FBxkjLHvLjXH045vOY3EL20Y/Hv7dgzPtOFKD6xvCR5qKvG94f7zQp7x7w6GN8yd28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787939891; c=relaxed/simple;
	bh=5PkATv96a5OCOrWRq/A2ruYkuOv3h7T9J5eTDGopBgY=;
	h=From:To:Cc:Subject:Date:Message-ID; b=tZA+7dYxMMCL5MhYfVhM9kRTRAh9dprWU/4LGTBIz9ykDxMrpljoyWDEefzXGUn41ioJIcsgLEsxbKhqo1L1joJorvqrWCzQp0HJVOiT2F17AFs56mMRUBodI1taEIKk+lgv9ByqaZJKuKVs201yXWi5KTFQhhs6XOuAjFHGebE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=eG3uKZyG; arc=none smtp.client-ip=209.85.210.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="eG3uKZyG"
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-84864086bfeso1164574b3a.1
        for <linux-serial@vger.kernel.org>; Fri, 28 Aug 2026 10:58:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787939889; x=1788544689;
        h=content-transfer-encoding:message-id:date:subject:cc:to:from
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l0MYRmzZFgruXC9r5HawEJJIBHGX1MwpvzJV/6xzk4w=;
        b=HoczlcU0xh+2mC62ptqVD6+jG3tTkbUM3UDss/Jy1FwlJO9n34iEYAI+QVf9aTCdoi
         98tyS6dpVoahbDcQ+mfJdhG+uDPC5QjudB8LAlfxTDaMGUDbV+JEpzRl4KKmz8hOQlGx
         gFC91UUO7hDH/BwMJJvRgKbE3E0MdIymTQXcb5tUf81fwA5J3Kvn4Ouo3u0ofAlyMzcX
         hZKlj+gQBFU6/DosEoB/xwUtoR8P/MQ52Gcm5UFwC4H86WUa596suZVXt03LGqHHvmER
         OebrHcvhVJCEr7GkCmyxybnVw+wZmijHq3pOB6eJ3cxDlreIOkSoVMbNyoTrpzv7WdP7
         uqXQ==
X-Forwarded-Encrypted: i=1; AHgh+RorEb8sdG6A/j5xBSnkrfVYs0Y+QH8WSDlGFagapoBC9e0DduyKWd5pbRWwjmaYxHVZa3aqth7CnTgj5Bk=@vger.kernel.org
X-Gm-Message-State: AFuF++muZAmE8GJfclTNecF5i2cCAJ1zcsdJbc3+OBxTsY5GqzFvoEjh
	Q+PTakmd+twvHIdWYDd8Tdmz4NDAk3pHh38VjZdjqCWvjmh91318i9ACKHkaOi8GaVQuhUo/Iou
	UeHjSQazKyUHE727F/bK09TGXC+Yl0hF8gQ==
X-Gm-Gg: AR+sD12mK/WZtRFM3JaOCN4qAo/4x1uVI4NNyBoYSsPq0zMQRK0YJGRCv6dr81mAaZC
	w5oK5Nl8wHM4ntJAqCGd1aALfL9lC0/G9rxWt5gvSKua9/KH98F3ugmOxX3GTwsDdidtk7cykQx
	6Kpd8VdTPejA9WNsZHuZaOLp9LeLtSvsCf7HdXcqz5uWeX0Uo4Q209HR8zBuIxqw34c3W5hml1j
	/Ia6ahUXdnPRV3jzL9K+qZdvnDUZsOKugdPM/9imWFYQ1i6vvV+ZB4Rushm+mFZbw69mlsFsCQa
	M29L/YG2W99sQjpO4IkAaa+iXcBB8jelRxuTvJ24unEmDurA/jlt9F9hIDQsFyRJjmHXJJLw8Dr
	Z9+qTNlocSaXcvXLCFQwTeolHMTS6A/uvddfLoKIHsrzevMr26m1vijGEDjB5
X-Received: by 2002:a05:6a00:2e24:b0:851:8baf:5b26 with SMTP id d2e1a72fcca58-8562a7dc401mr13785540b3a.14.1787939887387;
        Fri, 28 Aug 2026 10:58:07 -0700 (PDT)
Received: from smtp.aristanetworks.com (ec2-54-84-120-176.compute-1.amazonaws.com. [54.84.120.176])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-8569f3a0fddsm819717b3a.2.2026.08.28.10.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 10:58:07 -0700 (PDT)
X-Relaying-Domain: arista.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
	s=Arista-A; t=1787939886;
	bh=l0MYRmzZFgruXC9r5HawEJJIBHGX1MwpvzJV/6xzk4w=;
	h=From:To:Cc:Subject:Date:From;
	b=eG3uKZyGSmNj9bVPNEHDYUwq/K0u4ADVlFzeN4WPO1k9I/lLghRacGWe1L/Etr8pz
	 nBkn2qno+nx4WvXkQCR5mbEV4beP9Af9PXvhm6AnIELIZCMnWnrFbtO/kRkzmaBE06
	 Afv1SnDjTRR010IvekfwbEOjZTKCOi937V/sVYK4lZ1OVNsmDsy22nWM2Y7uUizLcX
	 VaTpNxzBwxUqNwySjrnmCKsEHIBDuWUJj1P01AKmHw7QCtB2AcfGEN94y3iM8ct64J
	 RYOKOvLKvnJejeZL124FpDpwysBXP5D4u0xIn3FSfE/wjv0YF542g/xbRQhC6A/m+v
	 y6zrgzwzaVc5Q==
Received: from vm-whiteberg-ubuntu.aristanetworks.com (dhcp-244-90-77.sjc.aristanetworks.com [10.244.90.77])
	by smtp.aristanetworks.com (Postfix) with ESMTPS id 5A5A9C0CE5;
	Fri, 28 Aug 2026 17:58:05 +0000 (UTC)
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
From: Tate Whiteberg <whiteberg@arista.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Tate Whiteberg <whiteberg@arista.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v2 0/2] serial: 8250_mid: fix race condition between output flush and termios update
Date: Fri, 28 Aug 2026 17:57:26 +0000
Message-ID: <20260828175733.1650267-1-whiteberg@arista.com>
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Fix a race condition in which setting termios while still transmitting
can corrupt transmission.

Changes in v2:
  Split original patch into two: a prerequisite to to expose
  wait_for_xmitr() and a successor to fix the bug. 

Tate Whiteberg (2):
  serial: 8250: export and rename wait_for_xmitr()
  serial: 8250_mid: wait for LSR tx empty before setting termios

 drivers/tty/serial/8250/8250.h      |  1 +
 drivers/tty/serial/8250/8250_mid.c  |  7 +++++++
 drivers/tty/serial/8250/8250_port.c | 13 +++++++------
 3 files changed, 15 insertions(+), 6 deletions(-)

-- 
2.43.0

