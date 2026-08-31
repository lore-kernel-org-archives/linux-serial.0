Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FCA39B952
	for <linux-serial@vger.kernel.org>; Mon, 31 Aug 2026 16:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788195574; cv=none; b=uOZ4/u/oZy6y4yzsOIpg1ab0329R1ThQUqNfEWfxIeXcY78C0ksjdjGEPMaUugLe0ETMhfO4qeuAZ7/zwi74fuJh4IFKH6jkjuGJxyfc5nUed3ZDksPN9cxv4YRWgCFz2FdokKK2NFdHAuyakCexj1JNiR0Y4KCX+b/IVhqH+DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788195574; c=relaxed/simple;
	bh=Ewfrv3pb6vTQrXV7ZsHXBFCFYAu5G9ghsNuNVD+zo7U=;
	h=From:To:Cc:Subject:Date:Message-ID; b=R0+surJL+K/LMsScfy6Aa7cw01vO2mMy1Fs4MxIQ/9TlGGtThguEYLx7u0L2NpihJb0e1XaZ1FrEorkh2TTyWo35FY3X/iN4NNSwif36pmRQn9kJdgrS8G2QxEjebclssuUJgu99bp53zBLD1Ihl9RrN2F65KNnV4mwgdGapeoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=FEx3W2w2; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="FEx3W2w2"
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-38511175ad3so3824495a91.2
        for <linux-serial@vger.kernel.org>; Mon, 31 Aug 2026 09:59:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788195570; x=1788800370;
        h=content-transfer-encoding:message-id:date:subject:cc:to:from
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oNWxtw/AIgfdPSPKFR3OrUMfFoHwBve6dL6/68wNzoA=;
        b=AJ5BFD0hedZgUAnmRGmSV7Tu+jgEtQ7kbyq5pTSWWNtzh2QL2kf2eNfrt9MCvaYfuH
         zjA8/KaowFzirMmk0u4x28ebivigVCuUElrKTR1Kh6c8oUWWE7eyQ97kAkBOIgkMyOxh
         Jx7qkWd6eqs8vX7FJdy6b5jSTnmivG2QHTFJXT5DQ2AkAqEgF8jOc4bC/6Rb9Mt0ZAsF
         /FaFRronR4ienU7ekTH8SlUFHVzqhrFpm+FNAjkr/UhzzCFLWxTLe5zFw95J/MOPkEUX
         n42tAL6lySMuKgJfTDZOD0p4L71lvXE2uylWou3JKOmwtL2hYZRWUCy62pnc3zxBKeXN
         1Kfw==
X-Forwarded-Encrypted: i=1; AKwUvBz8kGyO0l1TXozOsj8kkhe8L6EFUzAWT0NkjBE/svK9uHuoUhlct3gty7wxccdq5vIL/zeWAbhZhWrgsBk=@vger.kernel.org
X-Gm-Message-State: AFuF++mgX0iTXZY7pq4pc3kLCpYzQLTxLE+IgNXUlbVMgbGXtGLQ7JhY
	gZZsyfUBcHFvSHkRpdiqfeZAYJuo+pNI8iWtvP533OX/TOGTbVV5RhCIam9AwQ2A15mnP88B7jo
	GfqELACdTiyXsgK7tfEIEI9qHyFCF7MaPlA==
X-Gm-Gg: AYBFou01hLiiJHryirK6ovBh5+gONgIUky+MuAYdxL08UPYGhLuHWufEnOZJJvNsewf
	ELKrN8KLf0r1uDysJAykoFqcaP70+SrS5pJ+aHjSl9AnQFJ0S6Hs8CY34XXfrF4Iyhn029hin+o
	99Hw7zgw3BtPGa9PJCXn91qGHSLUhCMDpIbPa6cjK1WGUtP8F1Zuu0tvqGcxLJ/7p6PBkfbhr5O
	LGsqZqKD8kvVq+HWPwvDMMTC4q+Vm1B0Lb4gd4S4HPS/mY9+eC298SyeiHbnKVZw7nawtI7EQfP
	f3aMLxer/cGCB441c89CueiAJ8qU8qK7lPXupwVxVo9gjJ6mTiWjcm4iUsjHZME7+9SZaXaUc0H
	Zdb5TC4hMwbXUG/P6D0Tv5++CFx+BpT1KwM9yYTMvL0jsFAQubgi7MDr4U64CfK9mJvW6
X-Received: by 2002:a17:90a:16cf:b0:399:ea1:5a82 with SMTP id 98e67ed59e1d1-3990ea18f12mr10238a91.3.1788195570171;
        Mon, 31 Aug 2026 09:59:30 -0700 (PDT)
Received: from smtp.aristanetworks.com (ec2-52-52-135-65.us-west-1.compute.amazonaws.com. [52.52.135.65])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3990bccf100sm69057a91.2.2026.08.31.09.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 09:59:30 -0700 (PDT)
X-Relaying-Domain: arista.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
	s=Arista-A; t=1788195568;
	bh=oNWxtw/AIgfdPSPKFR3OrUMfFoHwBve6dL6/68wNzoA=;
	h=From:To:Cc:Subject:Date:From;
	b=FEx3W2w2zhDSBt89Fswat61dd1ijBWVH8f7uMo31Q3E9hOooUYW8RYqlGsXaQ5K0k
	 iHJ0ed/09Uhj0AdzejMNbkCsKZNETs7CtO0S4QqRN1rE7be/J113Jn+gZgoHmkUEh7
	 Kh7eXJy0N5z/zZ3vlUeMPD0rpwDfEQ+9xYVC2Vd9Fxgalxvl7XePBxXNPcGfVOUFNJ
	 HeMyPO4CcG6YFbnYCxXxEQ0Emr6gVRZYKGsi9jAjkgkLFAv8hBM3lez9OwUujvUTHo
	 MgPviJQZtrQ38mh6zsXR8+XpsY+XD1Bd6Z6w3UBzyUp1P7Ursmuq7ukZxFt+OWOjzG
	 91Bl211BP2bdg==
Received: from vm-whiteberg-ubuntu.aristanetworks.com (dhcp-244-90-77.sjc.aristanetworks.com [10.244.90.77])
	by smtp.aristanetworks.com (Postfix) with ESMTPS id 8DA97C2E81;
	Mon, 31 Aug 2026 16:59:28 +0000 (UTC)
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
From: Tate Whiteberg <whiteberg@arista.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Tate Whiteberg <whiteberg@arista.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v3 0/2] serial: 8250_mid: fix race condition between output flush and termios update
Date: Mon, 31 Aug 2026 16:59:06 +0000
Message-ID: <20260831165911.2029839-1-whiteberg@arista.com>
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Fix a race condition in which setting termios while still transmitting
can corrupt transmission.

Changes in v3:
  1. Patch 2: use scoped_guard(), as suggested by jirislaby@kernel.org
  2. Patch 2: Update Fixes tag, formatting changes as suggested by
     andriy.shevchenko@intel.com

Changes in v2:
  Split original patch into two: a prerequisite to to expose
  wait_for_xmitr() and a successor to fix the bug. 

Tate Whiteberg (2):
  serial: 8250: export and rename wait_for_xmitr()
  serial: 8250_mid: wait for LSR tx empty before setting termios

 drivers/tty/serial/8250/8250.h      |  1 +
 drivers/tty/serial/8250/8250_mid.c  | 15 +++++++++++----
 drivers/tty/serial/8250/8250_port.c | 13 +++++++------
 3 files changed, 19 insertions(+), 10 deletions(-)

-- 
2.43.0

