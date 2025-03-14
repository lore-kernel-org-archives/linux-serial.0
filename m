Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AE6C8C7;
	Fri, 14 Mar 2025 00:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741912873; cv=none; b=VK8xVR3+CKw+KFDvtvrABfHcMPqCHdq/n6NLTqHohwjGbAt58C0GYAt6nNAzk4qhfR+0cBtQ+LNAWzi7iqFd4DVvgpovbuORR7uYLWqdUwXyPyRniNxjpWJwLKqkn9wa7EkB7xVuedK51EDptoe4BrJCDKZrNhChtnQVLnnZplo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741912873; c=relaxed/simple;
	bh=luIy9HHbO6y+y3L96p2/08pTnr7KhoNyxP6qCZsLvNk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HYDhKXrcFYoNkhllBrAURBxqAxFOnfMqz1Q0jB9L9U9qR6koPOzqzmeRTwSisIAYE2c26xHJN57gFf1IaCSq7yEGivowFfNkim/ePLQJ6F+o9Xr1nIpEmUqy26GqUOIq5qnNz2kFUPlugLri+xOuW9zwNxV5Z06jwfHnNEcMLxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fp88/lb/; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fp88/lb/"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e8f8657f29so13547986d6.3;
        Thu, 13 Mar 2025 17:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741912870; x=1742517670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v0pQeJfjLS9XaBEb6PXfHDN8A97bye59+DsfsV+7Uys=;
        b=fp88/lb/spWxcBy5T93nV3mkUpR6tDVEXmQ5bGDKuHHAskNO76gnYdOIyk9RcfRKeP
         gCXo2QOSMOmX+Ny2jj5WpgkIoL5YZLf7lyZQTnop1SGFP9uljVDQXSPYwx7i/bbm3M/6
         esUQuBHAmixWwG+RBOQi32NGgayn4UTJnAUX9s5RDK2NH+6wFaCgswAaIHyfO0TnzLvo
         Aid2lwWzBU66OWTiMJ4cWABAr4zykyTCFEv0+kFT/R8zZyYnSz7y70yUUzvyT10R23yp
         j2Ab1daZI3CY5t6Sg4QOMyqEQK3QGjm//7TtkQqq5ae3bvzAEPWIbkzTaiayTu6+z7VP
         56ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741912870; x=1742517670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v0pQeJfjLS9XaBEb6PXfHDN8A97bye59+DsfsV+7Uys=;
        b=ABSgEAPiWDWfAF33rb1Bhx45V/eSPpuBKh8CiV/qnzEO5pQPEkE5AMmhG9MLJqwGv9
         C0pugFO20FXmEkyn3HW6Fr2z5tv591YD3Q+maY1VOe8zNP+r+D9J4iNibLlw+XnHhXiz
         9kJ/tRl6I7/ewO0CPqvnadJ0N3gZVAaJInM6Xgt3uALU49GiGhS5hMYlpFG29Fto3XAu
         VfO5aFHJhZe+Y+pkZgD9EJVMRGyt/RWRyaVNKQN2CsuuxXBFHk0nDKTvcBX7hPLU7IaV
         SYivt+CQ1xIyP0eNSzW/sh8ZYxIZGu8bJjQ3TVltnvGwQQqXo0MAfHYCS0/51ZXL4zW2
         SpqA==
X-Forwarded-Encrypted: i=1; AJvYcCUSX+R/lFOV5F0JDqzQq2M7ufJOq6dHTzkZg9tqSKfg77R+oqc1tugyNYpJY5gxeTnzkbjUdN3BUt7eX6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YznA2pl7XUuFf9dHNO80l23BwEHsaX3dXwxqSg+P8Gjgq7UDmBn
	R765TaLl7aTbiu3RXIKNYRD4g3sIk3lVh5DwASrPHXziQ02OZ427Kw2+jbsW
X-Gm-Gg: ASbGncuJWEO/hDJ72Q6VIygb6k1nEBu0LBNOkQ3LK8BdxTJYJ7Tla6JbTq7M6QbwFli
	aMZdX8+Go86CktznK+a40iAUJuux5b3urFlBpPEXCe6LdbS/rZ3KVcXrKfjX0NyQB2BuG8yzOKT
	x2xVEWK/WKxPq+/RM8KAIPGTHYl4CGYiQVcy0SozlwLxyejq/RxTxGxOlqwdwH/7aGg5D/zKPhN
	Xs/jhi0JOzizm7X0B00Go/6mD1OzJKut9QgX4GvbGkSEmeuOyc+BwgiVKLGe+WNvJn9lkvEuhuT
	HeAz9UlWRYicp2/R2QLbiPn8KBFywC8/SRq3EJvkMGz5exaTDCsEaA0WLIyBLJWIeNqbnOQAsun
	P4/QEJzPvD3eKZLbk+A==
X-Google-Smtp-Source: AGHT+IEvALbNOl3Nj7EHpar+/bMde6G0Zt/Kz9dcgv9DNhU6iuzZ9Wi7bvOLOASL9lmvqWkh/ZaVxg==
X-Received: by 2002:a05:6214:27c9:b0:6e8:9dc9:1c03 with SMTP id 6a1803df08f44-6eaeaa64668mr8616196d6.21.1741912870093;
        Thu, 13 Mar 2025 17:41:10 -0700 (PDT)
Received: from nerdopolis2.mynetworksettings.com ([2600:4040:5e66:a800:1190:f8d0:801f:5e0a])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade34c121sm15807876d6.107.2025.03.13.17.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 17:41:09 -0700 (PDT)
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
Subject: [PATCH v10 0/1] Optionally allow ttynull to be selected as a default console
Date: Thu, 13 Mar 2025 20:41:03 -0400
Message-ID: <20250314004104.3103656-1-adamsimonelli@gmail.com>
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

Adam Simonelli (1):
  printk: Add an option to allow ttynull to be a default console device

 Documentation/admin-guide/serial-console.rst |  4 +++-
 drivers/tty/Kconfig                          | 19 ++++++++++++++++++-
 kernel/printk/printk.c                       |  5 +++++
 3 files changed, 26 insertions(+), 2 deletions(-)

-- 
2.45.2

