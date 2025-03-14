Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A391FDA93;
	Fri, 14 Mar 2025 12:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741956772; cv=none; b=HonpN1gNT97wx31En4ZmlT5o8JiOzw1W2bH0xrhnJrds/DXZ0NpswIGYoq8raHgF65B3K77K1z6pPXmHTTM5lQ6fwmeSWEwaJrDsMZhfMUOfLRNEABBS8tf3bFYUHH8rUIWqoGNNOiprQ7atZXgmGE1RHnqNLF8sZBm6qFl24Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741956772; c=relaxed/simple;
	bh=8o2ZsEuz7mofHNQ3IpNxL6A775SvKdqB9rQAd4FCmmA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TPbL+1CFOQG6iTbstMHIdi57ok0SGObfqXmGpvuAlfUYryduNqKfPKUC5RHLMI3w0HdoaMzF5XR+/W9zdCxYIMwQoCNte00k6LGHZbG93PFmLNKvofydzcA1ZfGUJ9t5ChWjMVbxzmk/GcgYFCh1RmwhlX4YmpihMUEdhOTcVas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IqwmKe+t; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqwmKe+t"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-46c8474d8f6so18470741cf.3;
        Fri, 14 Mar 2025 05:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741956769; x=1742561569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q/a++v+EomvtKari9qYnWpbekWe6kqG74B/eesbXm3M=;
        b=IqwmKe+tpGT1bgwG59ZHMC9LoLDJrDwNhtiQMHvXfGXCyCR4bpu5o7Ph6vHtPJJsfv
         /ssIZqeqID6XluweswKRCh6PVAe3RZCmIiMN1GsR7oa+vEJhRjrWRwEFrj/Ow8n+sGYB
         ej3RRRsr4DeYPWLfPXtKptEN1Yrv1CWxz8SZFufiuawoB3rY6Z+YN/QvNs8xf9ooUxTQ
         R3BGOB+L4bGLQ3NlloXOJGdHYyVPO5Kfnjfgg51JuVWoo3b0aglOSkYwVFpcPyWiTrD0
         wC69HOjse3S5peE4uSvCj0mQd9ys1Aj8ktJafhZcOrPhNXRRZcKmUXJuEL80u5jHZPPN
         E31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741956769; x=1742561569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q/a++v+EomvtKari9qYnWpbekWe6kqG74B/eesbXm3M=;
        b=Hy+pKwe6I+gC7aJsXvNg8pN7FWbwT66W6Z7sPFdCJrJaKTGqIP2Nb+asiiEsAHDoT3
         gyAOpBAswqGrxjUVGPXGSw8rkSci3oJ5AH4m54ZtyNkjZA+SlllURk4/k3tXt78d/fFl
         zOIPqoi4onMcEBDjLKVVmMlaw5khUmHh5bsreh5wVbDGqHpnL5eduDAL9co7uNvXw0Ls
         u+howJx4/i9tA7y474iUlT0v8zjL1+KGSoOI4xsZVDOqx6JRPqpP1KiGqyJq8aCj/gri
         9TMWbKUDyhjjB+ZutwGXY6o0C0wQtzven9DTv28FD5moWNaNWeBZff6JMZV6o/31YVCi
         /zxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWY9NdZx5kteK/1bela1lkKjX0MqvIgo9HzxoIYi+HDFM4lrGY3Yp5c9cfK5PV9sEUBH3vmHAxzOvXt8tQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV7TsfnenKsC7cs4ETAHGW/hUBPSbIBxb7fivaqWrsbhfzl3wh
	FSyH/oyBpUkyL2WrbNbp9NVUReOSiROjaG3iuYByVdQxMVbAkO51EgBl17ed
X-Gm-Gg: ASbGnctg/Kz377soAkuzlVKCzEcNOxtZEyBg+fjOYiIAOB6bGDUtcI+yYVgh1lWlId8
	Jia/Ciekdmh+A6QKDIDo2IZHJZbV13fQJtqwNw0uw+ayn8MCt5+zrp8luYApuUWCv2Zf6hKLCoc
	bY+FS6F7yZXrSc/mWKbMb7sqCBzW8ET7D9p0eGqun+tSNNdAcQiP34zFdVMeHE42hebEA7oEJZD
	aIEiGjdET4I0uSaB7Qyhch7QhmU6xSCslT4H5TKXLwE5yFMWWazpJFO+egKLf4uef+lhgnYtp5V
	loqdYy07aQIvBdF7XGhNAAdjT7CeBRWdi47Q/r9Gtjli5Mom6spohKo9aYpmpV+OCLpmn2XaxNx
	rYSoP1aQ=
X-Google-Smtp-Source: AGHT+IEsscizpQqgRn1jGNzCOT7wJplYN2WYzlkj0tBEwDt+kMPJ15jvnFHZYkEEWOhjIao3Nysifw==
X-Received: by 2002:a05:622a:c9:b0:476:7a9d:d1e2 with SMTP id d75a77b69052e-476c813101bmr36062711cf.3.1741956768968;
        Fri, 14 Mar 2025 05:52:48 -0700 (PDT)
Received: from nerdopolis2.mynetworksettings.com ([2600:4040:5e66:a800:1b2c:8d81:f410:30c9])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476bb82e879sm22346121cf.71.2025.03.14.05.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 05:52:48 -0700 (PDT)
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
Subject: [PATCH v11 0/1] Optionally allow ttynull to be selected as a default console
Date: Fri, 14 Mar 2025 08:52:43 -0400
Message-ID: <20250314125244.3202791-1-adamsimonelli@gmail.com>
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

Adam Simonelli (1):
  printk: Add an option to allow ttynull to be a default console device

 Documentation/admin-guide/serial-console.rst |  4 +++-
 drivers/tty/Kconfig                          | 19 ++++++++++++++++++-
 kernel/printk/printk.c                       |  5 +++++
 3 files changed, 26 insertions(+), 2 deletions(-)

-- 
2.45.2

