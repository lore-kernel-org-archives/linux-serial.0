Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6FD192D8B;
	Mon, 13 Jan 2025 17:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736789379; cv=none; b=g1NRYB9UReUdWeB3pRu+QZJDL0KLXTs6GTdypb/D+o8m8aT8yltGLQsXF9OLTtDQj7JhqIDcji049ZppBTbJgWrusxYHbx5c7e0A7Fe6fFTPJ0cUORP58WSH+cxS4jMVKfSlGs9K35jU7Y7MqP7qZgzamzQLoQIs8tCtN6/toac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736789379; c=relaxed/simple;
	bh=gfbWqS9eBgahEwwU95NhMouSvcEpgoD78gUaqZrcmtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JcuA6qLNUc5oao8P+TTleOH8hVYfO1VLoNYj6+jI393YYw1ETqv8mIqPvXGk/+96FulQ1zEQjJhzwfHwMQpaDJo5rxuty6QEsCWIAI3I1pr3PNyfkgARponz8aVmyr9NsMe7AswyTt4xUZSkYwZqn4zMBIQ2H0yKuQGFBNcasLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3YBpXKM; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3YBpXKM"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b6e9db19c8so368355385a.3;
        Mon, 13 Jan 2025 09:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736789377; x=1737394177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCUKgNP2cYqx5tx5V8Do2NZE9mKwTTRFZ3PfmIrUrPI=;
        b=J3YBpXKMAA0nJnqsLI9wHBGs4oYvtpqhhmNhZ5QdIQwQrHRR5ZDLDQujYsUzYrTEeN
         SqcCej6e4zFbkHBpkGtNsecSxSLMWV3pJiTNckEwf8jqdRQRgJn7pyw29JxBhNWUcYBd
         7/76PEI74ykkqgywj6dqnPQW2VNdsDUYIqo1JGYBXYkgDIZ9mAWwGJPwhpEFDCKc6Q9L
         RRemM5qDeO7o6hgzwkFA8TvE/BFIu2r9qyEZ0WAmyOz427/yV/+5sKjOAGJknO26BMtY
         sighb9HkBnnXJJUhX6QVlXRKUSHCPQjQN/oUjLOGKsV+g8ZOjBV/rDbic5WKIEMELP0K
         T6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736789377; x=1737394177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MCUKgNP2cYqx5tx5V8Do2NZE9mKwTTRFZ3PfmIrUrPI=;
        b=dEwJ22TXR05/K0S04VzCO3vv5YvUjbsE0OJKDfkQjjKOBtLc3O7uDeQzWxOFMdrB+e
         N8GPMVNt9JGY9ZEkilmvXJNKUyqKxB99O55oSUa85BRGD8LyqG/xgCUKg9M40iuA8Wqc
         X53OfPlb9mjJuBdaGg+j81V0BPp5i4Ls55RIdrOBvKdjjUuv2enSSSuiFWykYYpS/0cR
         x9Yi3CoQfThrHGrq3BWj9dwVM3rLL519Zqaqml3cJW/ofqFixQQoH+b7PX56IbqOGcpi
         kco+o3ZOsnQscF4wJaFMb1SHpvZqtHvj29WWpffGb6v40fSe1MPczw5y5gRLCa6CKRoj
         n3kw==
X-Forwarded-Encrypted: i=1; AJvYcCWNWLYJnxjylo+vI0QHrw1iV+GcznYcm2ZW68AYNBt8KwUj3qu2JZ5kk/n4RkWteUwKmD0wsKc56rr2/v3M@vger.kernel.org, AJvYcCWcW/tYtDkgRO98PVXtyZ0k31SijCUxta23sHQBDZT9haEcBtAjHGWCJG2aVjMJULb05dbpYtDw0w0ZH8UF3M0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiXPxIpxnl14S+kA/QL6eWg8iUnElqLN0n/Z3YlvdUuPKyZzWq
	saPX7ywz5n2p/RkCMyW8i05JKDvXQZOooWUI5XWd47d2R2vIna2g
X-Gm-Gg: ASbGncvNJIRuv3WMTbc3897z7jdPNsOde4U/hHNyuSM+lDsamJjAe/RFywP5aN9V6oT
	uNL+XjUqLBhbrrufOoSrTkxTUagz3IQ+1QHWSMxuyast6Zh7LfFS2oK+VifI8hdfli+WjAz0CYu
	XiRrFsflEgtwUIP0hrw9xGmkzFioiPTWffcqL/wcMzgZy0JbR6CFxeKSarOZQIeNgiikAI6cNtb
	RxiuZkr727Su0dLYLYQLPq0JXm+aqrsGCr09mvGnQqVdwlB
X-Google-Smtp-Source: AGHT+IFlIgvI+38lGGLOUK9PF4IwCUyMu09/g5fHqpH3bm+ebp/TyEN854UQJXD3Lg7mLFlw1aBIaQ==
X-Received: by 2002:a05:6214:2f8e:b0:6d8:9c92:654a with SMTP id 6a1803df08f44-6df9b1b9147mr399842686d6.10.1736789377249;
        Mon, 13 Jan 2025 09:29:37 -0800 (PST)
Received: from localhost ([2a03:2880:20ff:1::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dfade73391sm43339836d6.88.2025.01.13.09.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 09:29:36 -0800 (PST)
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
Subject: [PATCH v3 0/3] Add a new command in kgdb for vmcoreinfo 
Date: Mon, 13 Jan 2025 09:29:32 -0800
Message-ID: <20250113172936.1434532-1-tjarlama@gmail.com>
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

v3:
- Added relevant links for the new query
- Updated `tmp+=1` to `tmp++`
- Added few examples and additional documentation for encoding function
Amal Raj T (3):
  kgdb: Add kgdb_mem2ebin function for converting memory to binary
    format
  serial: Move LF -> CRLF replacement from serial console to kdb
  kgdb: Add command linux.vmcoreinfo to kgdb

 drivers/tty/serial/serial_core.c |   2 -
 include/linux/kgdb.h             |   1 +
 kernel/debug/gdbstub.c           | 131 ++++++++++++++++++++-----------
 kernel/debug/kdb/kdb_io.c        |   2 +
 lib/Kconfig.kgdb                 |   1 +
 5 files changed, 91 insertions(+), 46 deletions(-)

-- 
2.43.5

