Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FE921832F
	for <linux-serial@vger.kernel.org>; Thu,  7 Nov 2024 22:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731018210; cv=none; b=JVe+NHamF6tfW/LxyCqhv2qeCoBELlYHbNKb9zgb+/Qgn4BRJtd0ro4LiauBZpM+t2gEDZWqnx+TgLSaYCHIvI5PHr8dpC4Nb7Fs8mE084VHAr9dqa7jpIUbtQhg84n04jHkKOPKoyLD29r9Qz07B5QWytQwsc+/HNZETvh4doM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731018210; c=relaxed/simple;
	bh=6Lhr4Ig4vdtORmSzZyxjxLEmvplrUOEwk98lC37NBGw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JtbNiGg19/NCk21tpR4nn07SxuIz8LH69AtTNDai1w8L6WPSKOnZ+cjSWfZ7Qt9NrB8V3xPrnd1tj45LiIQiXnmRnZ39aHa7zNiST7D3gWaWBUndok1OwTm8nKbfcXFWu/SaQWok+M8cz3UA/abYO1iXYWu5u+zILEs6D1HVpqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=XRVaBfIm; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="XRVaBfIm"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7eadb7f77e8so198424a12.1
        for <linux-serial@vger.kernel.org>; Thu, 07 Nov 2024 14:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1731018208; x=1731623008; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Lhr4Ig4vdtORmSzZyxjxLEmvplrUOEwk98lC37NBGw=;
        b=XRVaBfImfgVdzGPybDbjx9Ko3L/TX9COGh1zRfQ1rQ52nO4iUhAsFuQiDPXjm+Kgr8
         fpHm7enz5XFpwKZOR/r/Jm6E6zke9vSqVcy13sDH6T52AabAxBvW1BlbOAJUZcmZveza
         8lfYbHGcwf2juN476C61+7qbieRqBvgy2HZOudLEKnzVoW1lPhB+uPqThgkddocadMZH
         WTzpzI1j/bM6rmE9Bj8eSGsPyaF5z80qaqEmdnWtdX0c3W/V1NmhJwai4RXpM11OAlmO
         +Odp7sSG9u4tTrbB+lNhhB0MkghAioWHVv7d8iU5XyOFuNZlmJqbLEMkfHDX44b1RGKM
         Q8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731018208; x=1731623008;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Lhr4Ig4vdtORmSzZyxjxLEmvplrUOEwk98lC37NBGw=;
        b=Mx7jgc/LGv5uWcdh8yEES0DQkG5Hw/4N+D/iFBiitcTfygMa+gmOnnoGPjMjXo3iT6
         Ed2bdO81bsYLsJ1PpZ4QQhfpyZMUA4Rfeik/MA7iKjpFJV4hPepRJS0jCxVMZwELQu4w
         BpZP68dOYOoCahJOLS3lw/Ae7VxvH0taeNsdtXbbeB3GwxQRb4/XLdzoCCmBJ/GRFe2w
         fbCYxUqse6X4QSnwukFnq54CyRv74A1Ts2hp3uJGnum0bgICjHdfdL/bhqIVA4fAxMGj
         hk0XlXO4cOlLiGOQSFpA/6sWE/uvZ0kE16r3dG1FYNNSR+XQiZXaR47la4tNAw9vo9r5
         65zg==
X-Forwarded-Encrypted: i=1; AJvYcCUUsV1JKImYFYRJ+OL3HEzYHhL53GJxb6dbQ3fJsMI4i3KlLRHhdZS2ETq2/H+kUdgdOupSZwBGmz1l+yg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFKoZY4Pnxt8N2Xp/x+BCu4JeOXa094kPzDUNWJ2x20iuZgPD9
	twRjjFEINpHn06clAAlUJTI0o1Zb/8tfra47ioe8YKDxU2jf/occa6gPs7hAWms=
X-Google-Smtp-Source: AGHT+IEhv0g+JbUWUkr1DA1ltW7FeqCwkGTOzUqI8gzsR8reCMxyXMhw4vFXWCdDSf0fI1Y4fO/smQ==
X-Received: by 2002:a05:6a21:6d8a:b0:1d9:9de1:b2e7 with SMTP id adf61e73a8af0-1dc22ae2a9emr425006637.7.1731018208580;
        Thu, 07 Nov 2024 14:23:28 -0800 (PST)
Received: from telecaster ([2601:602:8980:9170::5633])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a15493sm2206288b3a.139.2024.11.07.14.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 14:23:27 -0800 (PST)
Date: Thu, 7 Nov 2024 14:23:26 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Douglas Anderson <dianders@chromium.org>
Cc: Amal Raj T <amalrajt@meta.com>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
	linux-debuggers@vger.kernel.org
Subject: kgdb replacing newline with CRLF in custom query response
Message-ID: <Zy093jVKPs9gSVx2@telecaster>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi everyone,

Amal is working on adding a custom query packet to kgdb for getting the
kernel's vmcoreinfo. The rationale and details are available here:
https://github.com/osandov/drgn/wiki/GDB-Remote-Protocol-proposal:-linux.vmcoreinfo-query-packet

vmcoreinfo is about 3kB, so we were hoping to avoid hex-encoding the
response and doubling the time it takes to transmit over a slow serial
connection. Instead, we were hoping to use the escaped binary format,
which escapes the characters #$}* and leaves other bytes untouched.

We ran into a problem, though: vmcoreinfo contains newline characters,
which the serial core replaces with CRLF; see commit c7d44a02ac60
("serial_core: Commonalize crlf when working w/ a non open console
port"). This effectively corrupts the data and causes a checksum
mismatch.

We'd love some input on how to work around this, especially from the
kgdb maintainers. Here are a few options, in descending order of my
preference:

1. Disable the LF -> CRLF replacement while sending binary data.
2. Escape the newlines using some other custom scheme.
3. Give up and hex-encode the response.

Any thoughts?

Thanks,
Omar
