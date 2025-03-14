Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20941339A4;
	Fri, 14 Mar 2025 16:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741968476; cv=none; b=OmnsC0Ffe71TRrXxp+rNslhPzvV2pDYJ/+FTEUToeZOY5Wy1PdkQrk48Pqf5tTalOvQ/wVjXpdlfcle6QAylJs7bo8r43hEFzUujsw/61OkfysXTPh0+Mk95D7GFF2leMzwa8hbmsUxO4rqPrDUQN+4zvpld9NyVgeigUtYrhkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741968476; c=relaxed/simple;
	bh=v96T8Nazm+8knMQrul4tgYQrE5miovBydrzpOvhsJow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SpUfnot1Xi5St+zBm4H57zPnOh0P7u5lAAQbWB5lav3xSTEHVvZy86jTvnf9nqHgJvpvJX+r33pE3a4E3egbu9hnUZUywzx2i8b+sOgbAqHuNyat4Zd5WFR27IxRIAKdgPGbSmzH3xIp7B08d1wf/MR86C7Pq5h6XBHK4Ru+1j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ni8PKHxW; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ni8PKHxW"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c081915cf3so285839885a.1;
        Fri, 14 Mar 2025 09:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741968473; x=1742573273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k06br1Ng+h7y7/2YXRQgDrx8bj2MpAQekqnXZMotWus=;
        b=ni8PKHxWHfcaMTLA9m/0toFhcAN/N1ATy25KPyolJetFl52RokZ1BEiKs4nuJz5eKa
         84Vp2OYQP+rtc3dbrIVqhP8JFU88dqqlPUif/qbHjazlWyC6Lm+mBm5Q6KeJ8JWNJ/ZD
         OQsjzlcKBFyS62hWflT5/wh0AGjptuo8ZBeWr01TIboNGnv6PAKb7mK3UwcaPE6KgWzG
         kEGvEHEaEduDCKRomfp9K+KhwbhUG0N23sU/sJ0XpcDddJ3IlbwPnQF/izIcVwjcm/B0
         LqIQ4tIqdyoIzL2ztoGSQ4cMoXn2160su6QPAUqKGNcia4ACxKWI4COQB8wRBCbr2jx/
         YNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741968473; x=1742573273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k06br1Ng+h7y7/2YXRQgDrx8bj2MpAQekqnXZMotWus=;
        b=E4rcxshOPjq0Gs+Ew35Ny0qDgyZDr02LZHrT2Q9yAhK6SrMjYNzFIO+nM9f6R6MOoX
         kRPb7SpLuMSjTKWVX0L32DIli/poEkyOEnxkPBR5xTp3QFtfNZVH3uV5IiE0SM15p7MU
         GuKpPWbc0c5ie0B9TYEMAS+mJ5yE9GVMhQ4Z77uG9UTAHRxYRCjBZx4p7Lenj2XQitQE
         hWc7eT/DZuzS2aeaL3Dh64RpZNYzdK0EZyP0to9pNu+8125pyGaqzb6JWF8l+vsTMiZ9
         OpBdgz+giyc9puX5tPmcf/HnIS04o0E491tq7A+R0Aj2Q5LIElmeIlNXS46mLIRSjDkN
         YdSA==
X-Forwarded-Encrypted: i=1; AJvYcCW0goyFDv1f//HVx0VFjRrFiq4h1LGxEPHHnQAKVB8BkbA3ZFz31/iqaOShzsfFspu1rBkTsJORe3MnUlk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKXRSchv38CQqEEvwDxvJxqYjoRJPYDCcXR45Lg1X0JJdhxg+6
	lfhWhD57Xr01ZVv/KbzbLVafOxSM3RPO5PRhPdJuHs3r05mhta40pai9kCIt
X-Gm-Gg: ASbGncv+NVfHonzhsMBE8WTpn/ZXeb/P1OlCwMzQhzFG03VhVbtwb+twctz/13wqa2U
	Yq0Ny9YALBfmtGXkTmQVq4ZIQm13ZG8dlVf4VRZlk6J4EWTzSDrIFliC/QXCNVdHEYc/5zdpTzJ
	xJq4/Mm6SL/YkDOeMn4fEZCKq26GE0SpDY7Lcf/XkFfmuxNfQhSbJwoJNgdUxUhA103lIT0bKio
	QU3ICr+WEPefDdSptgAQIrcbdddBUcQ60Z94SfirlNeymRq8reQNyJJEYqTHV3bst6sRJ7ixdVl
	Qw7vHVUFF7c9rISuH5g3hG3AN6iieRIglwR46OzMCr5h7mPuv+aBz0TOd76nl5XiKwETINs6rc3
	zu74/dK8=
X-Google-Smtp-Source: AGHT+IGcYDUOq7RQs4fkUQfpfpWtH4Qk234mYnO3EijgIPmQEIsNcv6zFuSOTIJSclEZHSVo4KKRbw==
X-Received: by 2002:a05:620a:6009:b0:7c5:544e:2ccf with SMTP id af79cd13be357-7c57c928c86mr423307985a.57.1741968473209;
        Fri, 14 Mar 2025 09:07:53 -0700 (PDT)
Received: from nerdopolis2.mynetworksettings.com ([2600:4040:5e66:a800:d731:b11a:3691:3fd7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573d6fc94sm274048285a.74.2025.03.14.09.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 09:07:52 -0700 (PDT)
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
Subject: [PATCH v12 0/1] Optionally allow ttynull to be selected as a default console
Date: Fri, 14 Mar 2025 12:07:48 -0400
Message-ID: <20250314160749.3286153-1-adamsimonelli@gmail.com>
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

v10
    Fix commit message to mention the option correctly. Don't mention the older
    commit option from older revisions.

v11
    Fix spacing

    Fix spelling error in commit message, remove no longer true statement from
    commit message, and add clarifying line.

v12
    Add tags from Petr Mladek in the commit message

Adam Simonelli (1):
  printk: Add an option to allow ttynull to be a default console device

 Documentation/admin-guide/serial-console.rst |  4 +++-
 drivers/tty/Kconfig                          | 19 ++++++++++++++++++-
 kernel/printk/printk.c                       |  5 +++++
 3 files changed, 26 insertions(+), 2 deletions(-)

-- 
2.45.2

