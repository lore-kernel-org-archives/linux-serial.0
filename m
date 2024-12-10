Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A296723DEB6;
	Tue, 10 Dec 2024 13:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733837693; cv=none; b=jz5Ma0TLSzLbPPPq3sK9ku8CcPYdHqs+n6Ffu1HacywxTJdsu7YgdeH5AynxJc/Uz2q3fV8eTXc1ftE4MehNkNEiAn2OFVXDyyy5bDWzfFlhWhy2OaR50BAkojIDkEgDxOFw93dGJa0W3aTOm69mPW+DxQEDe1/2cX9nHNjDzp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733837693; c=relaxed/simple;
	bh=0S9jFH6L+gnHSK49ufKw8bSZpaWfMQjCqQKTZ3/L1Sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vou6UDiPHGT1Tnd1Vv5m5Z9qnDN6WR7SpnT1BCZqH87/ITcXaiPmdo7b0ZWACRtlscy2aI7T8xLtMtuxb0JttpFvYGsvZPR0Dyy2yb4p4yS+WUGAduqNrOG2PFwbP4BtloYbrlMrga7upKI43tLgy5Smj3YNYsVqlCFQ1JOY3rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+q4LjUN; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+q4LjUN"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b6e7f04c98so14311385a.2;
        Tue, 10 Dec 2024 05:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733837690; x=1734442490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4tm3kBZ09JwrPbjgXLy3qFEqmN9/4ag151iXQrlURUU=;
        b=W+q4LjUNDXPO/+n6nPfDpCxX8t3hBtnC923GVq9otYQtO9FllNb+EaydtAs8Y8u+3V
         Q9d8vvb40tS28RIptiflh1zNw46HwiNtE1OwDiocp20yjZws7Yp5GfZ9+C2jLupE3809
         Y6VNvyKHv2R+JKg99n9a9sjt4POZsmLq9COOzH3qAOKFK+yrxmxO5vstqCktCtSeAF3a
         4nBgz4D0eISU635yFwlkg66JKbijYuxUwIj980fo0k7sXzdBU8o+1sD2tV0y/TQL7AIH
         db6uf92x3J9iUP80jNTH519YZMV8lb+tQCpMUwe30/85LTR8/SyGReMbg7lFe4A6zcBK
         /+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733837690; x=1734442490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4tm3kBZ09JwrPbjgXLy3qFEqmN9/4ag151iXQrlURUU=;
        b=a7VkL/FZBp/W7eS1/ywqt9cb7oa0U4jh5NwqxePZPg73TuI3Yk3VlMee+tjPod/EL3
         jKSOptOJHHnhB3uS6A0mFtuGuCeESAnM2MCBj9Y/m0Sg7GFUJxpWpajV3RlBOiQJM9A9
         2s3cbMgPYKewrOqnwsGHbF0ap/iHWcOTjixRinLGWx2petH8DaSwKULZvLwBCloWg3Vi
         D0JJ4nAWYWw8njy7+MdYciwkCLgBSQWdVFoeX7VmVhgXsTJU4k0pYHTx8MC+4a+kBAF1
         htlArK1vWmJ/doN+UHErWqiKR5ukdyv2/cAhLwL6/XyD6wO12SqgJK8DEUpezAekrgFm
         lLbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOLOxoHK/PJzQPRVyXv0gflrL5s4zhcnRDWKaD82jrrHcoEgnZ3WoNTyB03QAJqkLZQaZ9uCfs5hjypHXLPj8=@vger.kernel.org, AJvYcCXsUT/U3HLnpoV2JWnGtqPvyfpUr5AzaadDGgyVSJ4kEN7eVT/O1TIaO5sAOv7IzsCbbr6DuPYvdxjrPdXI@vger.kernel.org
X-Gm-Message-State: AOJu0YwypN4Rk8Ad70eKsIl+icMM08Ctc9jEY9PzudXDktYN8bNODVO7
	G4sj6W5s0moXD4EBum6Ok8CyqUCzlhUgGE9LC886WmqKnvMjRdrK
X-Gm-Gg: ASbGncvFYAthZ6+RVxSJuWmfwSkUt5+zw0OgnwyrkMBbkJJafeaTXbcdbgBQYWPALgV
	MNpTnBZZZKwuRNqqMXoKJF8TXKkJMyAfUaJgUT1bPDb22FiGD6GzHg8Odt2oMQaweSo637IJVlG
	I2VfeXwiBkLxHGpPgZlRUqetufyMM7olUCARVRQur0QiMMfVVhH470+k7yakCVK5+8B9+dMKLDG
	iq7DEzhUIuq99TvsbRBAhdz215hck45qGM5I/POjdS7zA==
X-Google-Smtp-Source: AGHT+IEb78W/6xK9hjh+i1udDJ1MfbMqGecnW4cmrIebp5vNa9F6R1xagx2MRlF79GFTqHP8AZsz/A==
X-Received: by 2002:a05:620a:19a6:b0:7b1:4579:80ea with SMTP id af79cd13be357-7b6bcb65738mr2835857885a.60.1733837690179;
        Tue, 10 Dec 2024 05:34:50 -0800 (PST)
Received: from localhost ([2a03:2880:20ff:9::])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467664c915dsm20717201cf.4.2024.12.10.05.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 05:34:49 -0800 (PST)
From: Amal Raj T <tjarlama@gmail.com>
To: danielt@kernel.org,
	dianders@chromium.org,
	jason.wessel@windriver.com,
	stephen.s.brennan@oracle.com
Cc: tjarlama@gmail.com,
	amalrajt@meta.com,
	osandov@osandov.com,
	linux-debuggers@vger.kernel.org,
	linux-serial@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net
Subject: [PATCH 0/3] Add a new command in kgdb for vmcoreinfo
Date: Tue, 10 Dec 2024 05:34:45 -0800
Message-ID: <20241210133448.3684593-1-tjarlama@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <gmail>
References: <gmail>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amal Raj T <amalrajt@meta.com>

This patch set introduces a new custom query packet,
`qlinux.vmcoreinfo`, to kgdb. This packet retrieves kernel's
vmcoreinfo text, which contains crucial debugging information
such as the KASLR offset, kernel release, `phys_base` etc.

This implementation includes a new binary-encoder (`mem2ebin`)
instead of the existing hex-encoder (`mem2hex`) to reduce the
amount of data sent over the wire.

These changes also move the LF -> CRLF replacement logic from
serial drivers to KDB, since KDB is the only user of this
logic, and the existing replacement results in incorrect
checksums generated by KGDB.

Link:
- https://github.com/osandov/drgn/wiki/GDB-Remote-Protocol-proposal:-linux.vmcoreinfo-query-packet

Amal Raj T (3):
  kgdb: Add kgdb_mem2ebin function for converting memory to binary
    format
  serial: Move LF -> CRLF replacement from serial console to kdb
  kgdb: Add command linux.vmcoreinfo to kgdb

 drivers/tty/serial/serial_core.c |  4 ----
 include/linux/kgdb.h             |  1 +
 kernel/debug/gdbstub.c           | 41 +++++++++++++++++++++++++++++++-
 kernel/debug/kdb/kdb_io.c        |  2 ++
 lib/Kconfig.kgdb                 |  1 +
 5 files changed, 44 insertions(+), 5 deletions(-)

-- 
2.43.5

