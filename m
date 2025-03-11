Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0A6191;
	Tue, 11 Mar 2025 03:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741663904; cv=none; b=Uf5+qK4BLHpbPOuqAZ/PsYYqz5bKyN5hg5d7lhe/gzalaT2jHENv83abl32gk1qVX3vc9fVrbXQT+8hy4PEk9erd/Mn08dQ6IbwwEEUhPkv66eWTNTDyCY6HICpfWLWxZKcKZ8EXvELVy3B++IHQMvi7UmMrJwDv3o48xjA97rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741663904; c=relaxed/simple;
	bh=9HmfOd1FyJaO19Mcn0B/422ZGBzz52as/dTIHWOK3w0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iUqaf5qaZQyePCLuerF5E7s9Ow8DQhAdOvwky2G7DUCjVPHHvK/jMfy9SzTv3jWwW5fb+69IRDH3zCmA7vj6lgHdJd50bAAQmm1bRGZpL04ZfwklgSkswkqyJVXtL0TWsg23gz1iSf5fWS9bVQLZIWNIEGvTEI9vmIFHB4XE2fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clFk3RCo; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clFk3RCo"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c560c55bc1so31452585a.1;
        Mon, 10 Mar 2025 20:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741663900; x=1742268700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SlQZvj1ghWnYS6At7Y8U9KhExQGuUdgo5sBVSUfxZb0=;
        b=clFk3RCo/+IyXMs/EYZ95R3Dd9CFH/HT77NFPu4V6NtbGYClPPdGls1sbKtDdG6atl
         vbrEYc6rGYm6C0shIlO1qy9F1+KSWIbdU6ObuUG2MufsOT0xbMZUTixChgj9NP+OmnEq
         CZHnziqRTXU8eYIvdqPCf3gMBHSRsKsVticrn7oQQ16IQDBGyJX4uAiHoCxLMmlryB+W
         C1eAZG4Lo49WKw9Upsq5zgbmstk0sixfUZBZj8q3qg/6HbziSeniTsTgAf7pMWc0RuR8
         Eb0RMwxUiKiH6lE7WqUWVCk8FmqYj3uJpbkCWShythRGDbDNmwdR3ftRLhaen6a8ezZy
         Gtdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741663900; x=1742268700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SlQZvj1ghWnYS6At7Y8U9KhExQGuUdgo5sBVSUfxZb0=;
        b=GN2vnOILSBWNtmBPz+KRQqat04vgfqehtnVvIyiGlW8964mqGG1U8Xu2WzGK0EdD3P
         jZdnmO4YlyPUaOMZdW8m32S+gZN1hAzB4ILEmeFeZc95D/OONDv9nkGki/4IxQ4lqSRH
         PfjEljLIFQe0s59tRTP1TiYrL6ha+2IvZOfIsZCWDyeAdY3ih9Xyval2z3d40lal0SQq
         FuHk2iBYBAI+h9a9lb5c/A6Erhah8Jyq2BDqWIKpTs2Ng4FGDaIo0oX7pyko9VnUIRiU
         TbRwBlfy7XJzIXkLqFSHpAc/ntXiqY56p9ksckGKGQC/PlzbuzRGjcu09v64sRZdgxDF
         CtiA==
X-Forwarded-Encrypted: i=1; AJvYcCU5GHRfVavAVNfNjcDFgn500a4E0Cf7EvxLdv0mQFGzHsqQS4Zt0A/amxWV/DmxLMmwYQaKHmIYoaKQjDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR6ViPNdxyzlR8MGw2d162ZzJc52/5XmGn/XbtSueo3UhmcidQ
	9xsOraAWXsGxyYf9TFKOXsJrG15KeTAdCrsKl68/guWKebmbnA6v4X+dwPj3
X-Gm-Gg: ASbGncveJM9IjgL/8FFnFiLSAIIgjxpBcT946Yqkds5VDI0pk0pmqdPiRpvuk+lXpju
	wU1YTUzL/0fLRc44thJXCI8CDh7a32ghc8DyEJCb96dvk1JCFVAJmdVD7pGukIGP2l4lKPUJPTQ
	JexqI3EbKW5RFKnPdtJ03N5WVw76gz85iEvSMHW0VEYOGp+e/QbOgZ4jPZP80ViYcbAsrKEP9mn
	JKPs8JfaO0qZNbRmDN08CWHymW2rPz4HZUZnaFXBy+5Og/83fCvNq3urezZaYeluROO9a7GxjGn
	+TxPXJdyWtfczrd2LRgCl6WCHhsyod03TZ2yjgyEF6znYifMiDt1fLiuJAlVxAyhmRH48IJGpKb
	JMNsSVlo=
X-Google-Smtp-Source: AGHT+IFb3fuc6KbiLPYdmEfN4504pg3NxfsLmi5pNEXHuk9I3GzfezHAuUQdcrP8HN/HMsO7xMdu4Q==
X-Received: by 2002:a05:620a:2782:b0:7c5:4738:8a0e with SMTP id af79cd13be357-7c55e910d4fmr378040785a.44.1741663900523;
        Mon, 10 Mar 2025 20:31:40 -0700 (PDT)
Received: from nerdopolis2.mynetworksettings.com ([2600:4040:5e66:a800:aa39:bd07:6207:ac0d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c54c204e36sm342772385a.40.2025.03.10.20.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 20:31:39 -0700 (PDT)
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
Subject: [PATCH v8 0/4] Optionally allow ttynull to be selected as a default console
Date: Mon, 10 Mar 2025 23:31:29 -0400
Message-ID: <20250311033133.1859963-1-adamsimonelli@gmail.com>
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
to where /dev/console is still backed by a psuedo device, avoiding these
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

Adam Simonelli (4):
  ttynull: Always initialize console index to -1
  ttynull: Add an option to allow ttynull to be used as a console device
  tty: Change order of ttynull to be linked sooner if enabled as a
    console.
  Documentation/serial-console: Document
    CONFIG_NULL_TTY_DEFAULT_CONSOLE.

 Documentation/admin-guide/serial-console.rst |  4 +++-
 drivers/tty/Kconfig                          | 15 ++++++++++++++-
 drivers/tty/Makefile                         | 12 ++++++++++++
 drivers/tty/ttynull.c                        | 14 ++++++++++++++
 4 files changed, 43 insertions(+), 2 deletions(-)

-- 
2.45.2

