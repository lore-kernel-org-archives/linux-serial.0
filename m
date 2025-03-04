Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D39C141987;
	Tue,  4 Mar 2025 03:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741060498; cv=none; b=eWXmayv2yxMK+BfnvdeFBzOsRy1u9T+U6MUIka1WXbS/Mr88vI8j3+TNxnitPMmCbxxj0lNYpEnnYFgojGCTB8F0SCjd/xoX0bGBCuwjS37LUPl56i+j/UjRngHVCZcsb5BWBVgTGmOB5YCKIQqm87DImzlxUTRVakyibtVmEUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741060498; c=relaxed/simple;
	bh=qc8hg5FVp5/hApF+SpKM8LFfb9pXcXaTEgaWsibCqs4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j5pGhc76B34vwSv0ZF1kBs7kn7GNYRaTtRNIgRk1siAbhChJknUIxCyXhnwbiO6IOjYq2bzixeZFKLzjNGXbI+mDOfQIG1itct+cLTAa9OW1HoUcDclXzJbNADNiJkmf/tqzMaGnlgVnj8WuN3AXi+Jcw8BqnF8nG3+jMKZnx6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldNP5Wy4; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldNP5Wy4"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-47210ab1283so78160381cf.1;
        Mon, 03 Mar 2025 19:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741060495; x=1741665295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/d9zCbu/LYhy5rp6SGakOf1cMhZl+zNjAJhVyQeX4VY=;
        b=ldNP5Wy48XJEidTkfACTmq1Gj/zCBtRAi4W2Dei5kSM84C+ETnoEd2W31UhjYADBGT
         jlUQ69X5LfVJnXFLXrQQzHsfEM+FrH7NNK4CqXhQCW0t0MrKQeHUkQl4PRRVhJy8o+Ig
         ABGczdVfKRCOc5me+ejEdBUdT7K4Metu8tbttzLcLeCSR6HragXTK8wXMAmxl0OVVayn
         fmu0f/3Qw05V7CjuwJw9lLECQCb42mkl2ZXPitZWjfwc3Zyt/YKtbh5sCbIPuso0R6ih
         uIt0dxuXO9t/Ck7tfUhGlkpqb7zGatlaOwHP1IyYzPImj/cSYfKpVzEQzmdcc11fi1aO
         pONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741060495; x=1741665295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/d9zCbu/LYhy5rp6SGakOf1cMhZl+zNjAJhVyQeX4VY=;
        b=rX+GVCsdly1C7Sy/ULLAAzR5l/rCdhswHaXiWKbOyC3DXOekf4RtRJBAagN62eMeyA
         178LLTXY/izPH+/17PA6m3A2+yG0hBX0r1zLhW29043A7KG6ckj2O62lHa92WWgIDkmz
         8Zyf2l6hOh8x0VTwrklew1XyXrNx1o48P0NNP5lSWeZeSE+gOxHU4MM0H7TKiWRNVwpF
         I0OoAN4HBf5JwGoRokpVsh/7WUBhu4HKEz9Zrur83dDDsiioolPKF7XKmN+UsQektjrc
         j6p5NcxrbQUCoJLGgI+VFk+HVgHj1OgOY16Hw2b/m1IGqpxqLFXR7jIUqhNVlAUcxaW0
         lDQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmZa2pTuoCUJPLcSkxSenyd6HF3vrPXtNzNndAj5SozH5pnAwCiRhIfAMF7tNTXrrZwUMxJPWPxB6Ux+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGk8ba1BcxHOuYiG9iKHUEeBIyS3fXGEzGr4JBUux3Mo1zFuYD
	IhEzgmIrW8/XaRLuYmAxANrOWOlBGJ8XT2zdxWiJHhXCLyV+ug5A5Lk+Ggdc
X-Gm-Gg: ASbGncsOrhUY00H4pOsbhHEIzgJY12f0WX5P5etyRVvm2OfXxIii+NKvAW4A/HcvYzn
	zyk3/J9Hj0JYiH6MQm/CyPKbZEo3Qb+XrvGALggELLbTkdcgzNKwua9qHVUb/WCpo4yHSdZBD02
	IhefP8JQ2ZYwUZEEyxAGggdIqvJWdNImYAo1WSaopCMJGlLbiawVzfI9IDjDIjzuRfoZnrzSb85
	8L9Q1Cbt3MAXs/EDWgU1eARMpxhv+IIjZU23PnTLOyAqWdF2oYsTyNqKVjocQIokWQB+gW+dxmt
	pUSrENdVjLUnYBSphN5gO4mNX+FCPb0hsQEaCg3TGTLk1RUn0SAtI882nGiizSjcJsezho5QJ16
	J/TkUAK4=
X-Google-Smtp-Source: AGHT+IFMmnHFglN249NZAz52n1oJHNWGnWYied/qPAwrKZwsU8hr4B4Ll4F9yn7Nbyh6ZtYhTKAIkQ==
X-Received: by 2002:ac8:5dc9:0:b0:472:17b5:dc43 with SMTP id d75a77b69052e-474bc0e14cbmr206862361cf.37.1741060494957;
        Mon, 03 Mar 2025 19:54:54 -0800 (PST)
Received: from nerdopolis2.mynetworksettings.com ([2600:4040:5e66:a800:745f:1ed4:1113:4077])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474691a1f2csm67567041cf.13.2025.03.03.19.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 19:54:53 -0800 (PST)
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
Subject: [PATCH v6 0/3] Optionally allow ttynull to be selected as a default console
Date: Mon,  3 Mar 2025 22:54:44 -0500
Message-ID: <20250304035447.3138221-1-adamsimonelli@gmail.com>
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

Adam Simonelli (3):
  ttynull: Always initialize console index to -1
  ttynull: Add an option to allow ttynull to be used as a console device
  tty: Change order of ttynull to be linked sooner if enabled as a
    console.

 drivers/tty/Kconfig   | 15 ++++++++++++++-
 drivers/tty/Makefile  | 11 +++++++++++
 drivers/tty/ttynull.c | 12 ++++++++++++
 3 files changed, 37 insertions(+), 1 deletion(-)

-- 
2.45.2

