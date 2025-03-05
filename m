Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5817193077;
	Wed,  5 Mar 2025 04:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741149013; cv=none; b=JcIK/C7OXcxezo9omgIcRmkJ66F7sgDH1Q4ERlLoyTZvjfmU/MvovfYul4+KBhcOlZvCEfUrRyAAosli8CdMuRwGNyDBZpbRHu9FGiJRCa7G5EIdvKUTjdFQv1NJX0tnbJ+SCS3tEAwuHvhVnGapnw9xcETe9KWa/eyJY4zgycQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741149013; c=relaxed/simple;
	bh=LzQlPUCluyjvsQLYHdQBKKCWXG4Umrd0tOdavbaY8bI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XmQryqPRdWwk13yrmiKN11grpxzB1NAEmJcZFlmuOfX2bwzRIiJbO9n+7VhoL3Rn26ORzA86zvmLtMPoPdVKBxp0e7Px12vrqOG1Nhd3jg6NkLSuBdh3NfEcTfLzdpPvXrdAJW9AZcENz5GHzY+GfaD7j3FZxlVsKA1vPqVW4+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVxHpHnI; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVxHpHnI"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c08fc20194so1070524585a.2;
        Tue, 04 Mar 2025 20:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741149010; x=1741753810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KNdPg6w68DIUglBPfqnbcwylAmeEX3JKYHIuSHZzjEY=;
        b=lVxHpHnI03RNJBVKhMaUGeaewnLXApCCklQ/6BjhP711n+E1L08kFTWqZGevdJIu6R
         9/yrXetC95Y/JHuFgrWIiZTEhrWNsb0qpyA/EUWyaU5+4nmXc3weFo6bjaO2pFXTFOR/
         8pMIuKbiZzjuMEiW9/7CVqJ3inCp1DlRaeAGtnfs5pkaMXs722Bg80dr2IaHKg8zXP3K
         VjCvKTewT4kyLh5dUIYcT+bzZjqwh6ikOh1JwZyCDZusDAgoncfXY1MD18C38WEH0Ekm
         t9zCOQKAEAB8vXMdFNnI+zSbFKog8HEIaIU9775zy9k3ZC8za9Xd/UuivJRAnaZz2/zW
         lW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741149010; x=1741753810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KNdPg6w68DIUglBPfqnbcwylAmeEX3JKYHIuSHZzjEY=;
        b=qY4EA9oI5eaPLgNFJIBXGRFAmrpewMp/7UTzDwxIcbri9DDajZorOUPfzXN7swvPN1
         3zrx3OtaqjJbtY1tgfctp/Bwd04+D33tQbIdMLud8BwBlbTPF8LRPKt3HrDk/+mLrOd5
         UuO0DzBhMyU/4Wn96M2VKZvK60NjuRJdNA180jOHBfm2rZJshUlO4oCGB+LFTOpTQ/Z3
         H/8/ODIMwUryvOxh6ijq57GLGBRvA1zas8txi+KX2dc6KW9XXjrfxrIqNPXWakQTpoAj
         WemI1nBxfvQWhMeBIiu9teTPkoHfvPV75V44WwMlUjjRZU97xMzWgh2j9U5TdfxSW19H
         3Q+w==
X-Forwarded-Encrypted: i=1; AJvYcCUIdPvrcYu/Q8uOshmEdOgWXYyFJLR1BHw7bfcXuXgFsx5jp2oN2973Bxoag5ue7ySWFtnkL4zUwYkGJNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZmf6DJOrLbJ5+w5xAHUrpGi9d9tlD1PkfjjDUKCsCsQEMQ6xZ
	V0BC0qt5a2ZS/o1+0dRqzYNDN266a6mKlMfy8NCGeVLJRm//PmKL6FhYwIGn
X-Gm-Gg: ASbGncsk4AB7qr3GjnDCJQFkjGp2a0F3meBTu8m+1CyWJDDSyEtGRrCJ1FDT4G/W7qC
	TTqKZgzXBGo1f/u5yXzPwJebj93gjFRKaD/w+pq31Emo4Pam60vU2kKaykQWYW2z8greVXQle3a
	iqk1aqA1HrJDrcQsJ6mextHoVgJPDpUo8Cz3p7Ic85QbOLW3HdTEBwYjy35Vo6rXuxfF6zsYg+w
	INL8GypFWAdoJZy4B30K4/7szFBYFvDh6gQ49uqa6zd8+ufgx+kl18Yxe4OQbRRwUmISBTXv7tr
	sVIO8YnH1ijQ15knbLmhUpyJxQWpSlRAsjmuzlJie9e+jw5AwvNu2fpclabuIyW5rAlTbLXpGbO
	FdVnjiPg=
X-Google-Smtp-Source: AGHT+IFSiyTv/Wk0jiv+ymoG2D6yDnkkIdrCntyX0M3gUofwMKhtRibcI3oj3LFDws0SOHQSgmVEeg==
X-Received: by 2002:a05:620a:1d09:b0:7c3:cd38:9be0 with SMTP id af79cd13be357-7c3d8ea2194mr394811285a.56.1741149010125;
        Tue, 04 Mar 2025 20:30:10 -0800 (PST)
Received: from nerdopolis2.mynetworksettings.com ([2600:4040:5e66:a800:a5b9:4b66:4113:9357])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c36fee8b4dsm834060785a.15.2025.03.04.20.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 20:30:08 -0800 (PST)
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
Subject: [PATCH v7 0/3] Optionally allow ttynull to be selected as a default console
Date: Tue,  4 Mar 2025 23:29:27 -0500
Message-ID: <20250305042930.3453265-1-adamsimonelli@gmail.com>
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

Adam Simonelli (3):
  ttynull: Always initialize console index to -1
  ttynull: Add an option to allow ttynull to be used as a console device
  tty: Change order of ttynull to be linked sooner if enabled as a
    console.

 drivers/tty/Kconfig   | 15 ++++++++++++++-
 drivers/tty/Makefile  | 12 ++++++++++++
 drivers/tty/ttynull.c | 14 ++++++++++++++
 3 files changed, 40 insertions(+), 1 deletion(-)

-- 
2.45.2

