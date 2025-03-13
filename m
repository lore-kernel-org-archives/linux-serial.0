Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F941F4717;
	Thu, 13 Mar 2025 21:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741899839; cv=none; b=bZag3J0RSj9nwmLRUy1m/NNkem3pxW0BISAJdnVjo+5qFWFcatewZe6Wo6epij7A90Bc81FfSaTsJl9JHmR9vlmsnW5hWHO6Pa47kSEnXtGt5lLp6E97aQw54a/IVdO2m0V+nP84msO69Hd71A2aAmdqEP2MvMpLJxpEnezsCMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741899839; c=relaxed/simple;
	bh=At0jJxy8GE0BGJdO4YufDmadX/ZXkkXRWG1zgn/ffJI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bi4RqeQUvQE6qKmqigRLl6MYE8tAqQkgv6nknt6G2E0Fo9EpCcBwFw00GaqspEa97noxeDqDjk3wj+qmiSwJf3SUDdBR7DKaT4eNVTs0Sfbohq95/P9psaLMXl8Fp05nePqFIluQmwe1k5tdEQ3lCQGwyEDH4cefe1Iy4xAMJuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNxrL32/; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNxrL32/"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-476b89782c3so17058031cf.1;
        Thu, 13 Mar 2025 14:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741899835; x=1742504635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3F9JfhhpLd0DiMMN5ZTXTTxN5dp3duXWr88AR4TSCTI=;
        b=PNxrL32/2Ad+jJPiIqAnMCfpnrHSHRbg9AZs00uxgvPfdUvMIeJHRTSwaR6YigbPCw
         vWxYLqlnxas52SsgG50Y0RsRqmdfWFS834Q95O0kyXGe9RRIp2Oc6pvqzWO+slE5PCfe
         O7p9xudQRVdJsstLXpLv4xmzZ9O25TD1krZ5A/mhLG2RvjTMzmlHr5Tz2fSR2D9+rC8j
         Sg8w0DTrGS+gf2bedv2naTYemyEr1SP4LmkDHwG4VajvoT9gA9ByjocpxKwjk5/bqyhT
         LxgMklP2W6zVugcJOwpoJSk4QVroDFVkTYNT00uOU0V4V1xwzvvtYcmT6m6MeMDwXBVO
         dZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741899835; x=1742504635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3F9JfhhpLd0DiMMN5ZTXTTxN5dp3duXWr88AR4TSCTI=;
        b=AJ4NDW76NT6f+wn2vmD8UvBJeJxKpgFrWHD91h7HeNpGMh7OccKnKbd2aCYbO3Bq4K
         GPl0DQGSD6XYUS6g52BzbGkGIhH1VaesRDKDf6rA/3jwsUcjj0U7mmWbWdD57aFyWlyC
         YowojQ4dKWPyT2kT8KXweMK4vbfZseQ7U0TBMuVhW/IHamGGRyKuFvxe02+06iFcx0B7
         ZEQJNBeClb80CCcAsCdGyhb2Bp9nA/S/xU/wiaK2JJ4bI92honriGm8b5UZZiHjBE32F
         BhdTO6/ZAIGwYCIjmRjqwwakgJ7Ofu9yQe92eb4mC+F+WHDoGXYZ3KiiYKCbqvVVrI1L
         CQlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDVhVp04F3k1Rdqi8DTqsXgwwKQyPvh8L6ctREhc1mPjZ9vlkox+PFQBl0CQ8m+rIeRirKfzNQO1UxBNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYrxoSDm5Y0kvwW+L2eR/mImHoXzHFImZSKjcTj3pcsgjTZX/W
	t+yG76LUCekGSf9A/HygGEEX0T2OQPOzx8XxAjyzP/lBRk5A1Sg0UiFHYoXE
X-Gm-Gg: ASbGncuGcxEUTagBic/tGjqYqXx5X2l/PYDuj3u6w4CSVjHKTzJavo5PsM2DjEVRdYu
	m19pAENzZWgTiJM1XobqgrFLbEdAGjElP5Fo8TByQf8evg3Mdwa6W9KzeESzbPUlE4ArbHz+rYk
	MQ7PQMxuPqp2sAnE6AwnVpDQ8IHRTRY7mw0DZhYzXKOo0LkEZboked2CZZs15MQmHRLh3racIog
	YMXJT5aNREuYo6Zck6fuRGeglq/XmzfOquM5WpdygE6xGGKYtTIAJ2tzQ9eqyo9XX5aQVTcKMa6
	LpH/SugKfMRmEQBYX3tqmeISFCk1jdKeVHhSoq9CZTI0nKaR6Hoj3LRqbjN9XplsWQUSc2WfEcN
	2Ze/0WUUoWi9aQVQ1uA==
X-Google-Smtp-Source: AGHT+IHbBE3KuCwZqo9MW0GUgiFHzWms8CY/ImiDM0hMcuxQrJEy1obM4IL7fWSg/ywYH4gRIkuM6Q==
X-Received: by 2002:a05:622a:58d:b0:472:139c:3b50 with SMTP id d75a77b69052e-476c8149bb8mr1592661cf.13.1741899835198;
        Thu, 13 Mar 2025 14:03:55 -0700 (PDT)
Received: from nerdopolis2.mynetworksettings.com ([2600:4040:5e66:a800:1190:f8d0:801f:5e0a])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476bb63f3a4sm13223601cf.30.2025.03.13.14.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 14:03:54 -0700 (PDT)
From: adamsimonelli@gmail.com
To: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Petr Mladek <pmladek@suse.com>
Cc: Adam Simonelli <adamsimonelli@gmail.com>
Subject: [PATCH v9 0/1] Optionally allow ttynull to be selected as a default console
Date: Thu, 13 Mar 2025 17:03:46 -0400
Message-ID: <20250313210347.2987535-1-adamsimonelli@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adam Simonelli <adamsimonelli@gmail.com>

When switching to a CONFIG_VT=n world, at least on x86 systems,
/dev/console becomes /dev/ttyS0. This can cause some undesired effects.
/dev/console's behavior is now tied to the physical /dev/ttyS0, which when
disconnected can cause isatty() to fail when /dev/ttyS0 is disconnected,
and users who upgrade to a theoretical vt-less kernel from their
distribution who have a device such as a science instrument connected to
their /dev/ttyS0 port will suddenly see it receive kernel log messages.

When the new CONFIG_NULL_TTY_DEFAULT_CONSOLE option is turned on, this will
allow the ttynull device to be leveraged as the default console. Distributions
that had CONFIG_VT turned on before will be able to leverage this option
to where /dev/console is still backed by a pseudo device, avoiding these
issues, without needing to enable the entire VT subsystem.

v2:
    rebase

v3:
    Clarify commit messages.

    Guard the all the register_console()s in ttynull to prevent it from being
    registered twice.

    Only change the link order if CONFIG_NULL_TTY_CONSOLE is enabled, otherwise
    use the existing order for ttynull if only CONFIG_NULL_TTY is enabled.

    Document why the link order changes in the drivers/tty/Makefile file.

    Replace #ifdefs

v4:
    Remember to actually include the changes to v3 in the cover letter.

v5:
    Correct code formatting in Makefile comment.

v6:
    Change to CONFIG_NULL_TTY_DEFAULT_CONSOLE

    Set the index to -1, and don't set the flags

    Use add_preferred_console() instead of register_console() in ttynull's
    console_initcall when CONFIG_NULL_TTY_DEFAULT_CONSOLE is enabled

v7
    Add a commit message to the first commit, and the Suggested-by

    Correct Kconfig tabs/spaces formatting

    Invert the console_set_on_cmdline check

v8
    Update Documentation.

    Remove the "CONFIG_" in the help text when mentioning other configuration
    options.

    Update commit message

v9
    Spell pseudo correctly in the cover letter.

    Use more clear, and suggested help text for NULL_TTY_DEFAULT_CONSOLE.

    Do not set ttynull's index to -1 anymore.

    Do not rely on link order, call add_preferred_console() in console_init().

    Merge the Documentation/admin-guide/serial-console.rst change into one commit.

Adam Simonelli (1):
  printk: Add an option to allow ttynull to be a default console device

 Documentation/admin-guide/serial-console.rst |  4 +++-
 drivers/tty/Kconfig                          | 19 ++++++++++++++++++-
 kernel/printk/printk.c                       |  5 +++++
 3 files changed, 26 insertions(+), 2 deletions(-)

-- 
2.45.2

