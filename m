Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC45E1B6CE5;
	Wed, 11 Dec 2024 15:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931599; cv=none; b=S46Q4xzKS8ZkRdovKp2S4izMDtHzMlZIdlfEAdVAwhvJCJlL10sOOJRrfSoyyKxtgkpGT5KdTMeFfR5ErDPiQ9GVe0XswtyChFGq8HMXoxfwJboTi2VWMBxQBbs9dakwVN9/QQ1Mk8uKJXGhU9xQnWdJZtoAiHxXTM9t4YW4jHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931599; c=relaxed/simple;
	bh=QXpUUZx6z6CIcAqLPryPnHBBBPD8T62bHg2uwoNTXHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DDL/Q29lAEX/ZyAOh0XYugs+WKILHK020ECoHubvNinYhCvfaKOq3O+Py0KXYcW1hBtZqhVotua4jC+QNsgyeer4XB+Q6f+VsdX/QCWbXNEmaP0LOh3+eUqkmFf/rYg2HW+QEHTpfWGc59OB2yPqNbGHZDtCQERazs8PXmRMBSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DsmT6OH/; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsmT6OH/"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b6f0afda3fso29923885a.2;
        Wed, 11 Dec 2024 07:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733931597; x=1734536397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48GbB3M2j37soBiPKpPC0VMJn48wRwefUHb3hKn0lzM=;
        b=DsmT6OH/L/kE1w5M09z6uqtxIgPhQB70R9WcT0yd92qQjYIremoJHWxkOVKYphNI29
         EnLONZcIZPyyG/JqclKjWAq/Ab8klQiFUMJsQdfjy26M4l58eLc/rNC4NfNqCJEN6Hq0
         KfpuW3OTYJQSPX/1B8FFruEmDibZO9HU3KHoa12wLJUQhYfXa0b5UFZFv+XgEbwbjyLm
         cUa4jVU0JOK3Zhw9CvIS6ORIoDUBNreIQlia0ZmX7R3sxrfA/kjc0TP2owerR+wWn7Ky
         +cCTKstoO+6BSlwaH3sw0rnkU6NOH149hvzKuJ8UNs1HYkfg/WFQGzojJY5T4mRP88cg
         lGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733931597; x=1734536397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=48GbB3M2j37soBiPKpPC0VMJn48wRwefUHb3hKn0lzM=;
        b=qgP6YspNDuYwxbgkrgrdC+VytcrQWKrZewl5sf5hrqililvD5DshxZoKdIp+//cUsM
         a935c9OJ25QedyATB9eo82wO+pMiaU6G/2WCyXpcORnvFx9KlHyOwBt5LJFpsgNjX6rX
         J7RKJUHW0708vt47Z5EYr58HFOuTvKJ7MouQEAiiLyW8DdboNC1uVBg+DKQJ/+5rZRMl
         LbkWn5xhtJWF9du4MmfOdU/pDpziAYYMjPGtgYyoPvglX8IfcRryEw4dI+pbicx+YSGM
         LlyEFIaQzQPDsJPj+rYRDx0c4O8QIpuT/Sda0w4SQosJ3NNBMZgL2BgyVyrPrKyuYvCv
         Kzyg==
X-Forwarded-Encrypted: i=1; AJvYcCWQO+FfA6wjwDyPp53+cxdrGD3KXVX1fqj0driMCC6vxa5kNqws3qEulGT/Qn57/aYZXqCI90035uBivfz6@vger.kernel.org, AJvYcCXzbC6jcznIKdx2lU0rmiCBMUGMNex1NT3Qmkc3i1LXHIXCUElpIEoNTTUjkFwPaTiSFK9kY6G4WPYTK0F1EX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqOOjJ0AJ95sWM6Nzjf3F0I9txmXoQzg2SAd+4j1JFXXV2FL9o
	tuFsKNFo2es9iRGlNwEQTRxVqY0EPaI1xnd89rLZxWriat6uSAVs
X-Gm-Gg: ASbGncvqp+z4h8EptMsIZnI4hGIla48YKZiMK4+fCopE54U+vs71at62hOd175eGyNQ
	m+Ka03mihmmsLeDbAm3e0G0SthH/KdELanzqJ+kVrEeL/Q6NIxldj4fhR5TrbdiJ/zSJ2E7rBMZ
	oMeVOuRTuiM7s3b1u70Ux8o1yhJCJxxiUQGw51JUSiB19Bylw14SgOmNOBv40D0VLn/zSdavr+y
	LaSUetPKQrr3jS/U7c5u4TDF40sOo7pqImgzWDcRbzkZQ==
X-Google-Smtp-Source: AGHT+IEy50fmuC7NHJOcNL/rF6R5gTJA3Lm8KINHkGcfbYhlgLJmyEBM313EjFNbhlws9AQ8dn3zpQ==
X-Received: by 2002:a05:620a:3181:b0:7b6:eaa9:d6a4 with SMTP id af79cd13be357-7b6f1bfbb79mr23852585a.26.1733931596644;
        Wed, 11 Dec 2024 07:39:56 -0800 (PST)
Received: from localhost ([2a03:2880:20ff:2::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d90e0c40f1sm35974076d6.89.2024.12.11.07.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 07:39:56 -0800 (PST)
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
Subject: [PATCH v2 0/3] Add a new command in kgdb for vmcoreinfo
Date: Wed, 11 Dec 2024 07:39:52 -0800
Message-ID: <20241211153955.33518-1-tjarlama@gmail.com>
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

v2:
Added back LF neplacement logic in `uart_console_write`

Amal Raj T (3):
  kgdb: Add kgdb_mem2ebin function for converting memory to binary
    format
  serial: Move LF -> CRLF replacement from serial console to kdb
  kgdb: Add command linux.vmcoreinfo to kgdb

 drivers/tty/serial/serial_core.c |  2 --
 include/linux/kgdb.h             |  1 +
 kernel/debug/gdbstub.c           | 41 +++++++++++++++++++++++++++++++-
 kernel/debug/kdb/kdb_io.c        |  2 ++
 lib/Kconfig.kgdb                 |  1 +
 5 files changed, 44 insertions(+), 3 deletions(-)

-- 
2.43.5

