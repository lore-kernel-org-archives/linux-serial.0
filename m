Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8BF3AAF52;
	Fri, 31 Jul 2026 09:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785490777; cv=none; b=sP+JS36+wlwx5u6h1yvD0ANcaTvnMfjpmFrcCZATNXCf4gUZkEiEMsbtqmmjwaNhqhHlMKqrmqGDlgaeA+ZTIGwvu3OSqj2228Mo3kLZ5qOBFaKRFeoItXpU78vRdEDZKdoJ1fDDDnChPhcL8zdIqs//ZCudRsPEs8GrlJlwLVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785490777; c=relaxed/simple;
	bh=zG6swiB/AMk0TGLjz2J7YcWMcFeSZMr+eM+NGLkx4t0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mAB9GxTa55tNcz2VBPaGs62CRKvfQMoAN00Wox4kJJ1pTE0vvk6T4K0zuGwZ7eobCK4zo+V4C7f6vL0j4uFMH646xiy7UA1LVm0JbIoURV77lVYGocPyJCBAyz0BIS6Pzsvhj0lVtwmDk4fGDHowDTWGZTaUVFEmVpmr3UK+ldw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XaNCiFXt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XaNCiFXt"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id CCAFB1F00A3A;
	Fri, 31 Jul 2026 09:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785490775;
	bh=vu8zzqXJAgd/ggo2pVA5oFd3CA10umr0vwdR2u0YsTk=;
	h=From:To:Cc:Subject:Date;
	b=XaNCiFXtF7inCpVpxi+3u+hhpm0MiMqk7wwurW9BMdgzKXrtlXBWtHoFpP/+OP2VA
	 CFBGdLpyfxsgB8XvvuHKdQkA3Y8lH/CJIMdxhVIETBMOUSHhnhCH9Ok+BIZm3eweOt
	 VcblC9kcJGT3iW/BijVpcXcypGriKdVITPcZgiUKPhBs99twMW9rS4ll7sGEPK7s1o
	 s7KyY2TBeE5BEqxiAG+Ui8JGrn+TZqIML2k3dPuZH1wWBRyTSXddd31CAFPNQMrURW
	 6yQzpvMtGJJuMiy1un1X3OUzsC5n0vmL7MdHQtbc43VPqkSZ832NpQ2MLFbMtw7lY+
	 IRNxtnp2qCmjA==
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: John Ogness <john.ogness@linutronix.de>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	Alan Cox <alan@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Stepan Ionichev <sozdayvek@gmail.com>,
	Fushuai Wang <wangfushuai@baidu.com>,
	Osama Abdelkader <osama.abdelkader@gmail.com>,
	linux-doc@vger.kernel.org,
	=?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Abinash Singh <abinashsinghlalotra@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Gerhard Engleder <eg@keba.com>,
	Lukas Wunner <lukas@wunner.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Rong Zhang <rongrong@oss.cipunited.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Haowei Zheng <zhenghaowei@loongson.cn>,
	Rahul Bukte <rahul.bukte@sony.com>,
	Russell King <rmk@dyn-67.arm.linux.org.uk>
Subject: [PATCH v1 0/6] serial: Some yak shaving
Date: Fri, 31 Jul 2026 11:39:03 +0200
Message-ID: <cover.1785489518.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2501; i=ukleinek@kernel.org; h=from:subject:message-id; bh=zG6swiB/AMk0TGLjz2J7YcWMcFeSZMr+eM+NGLkx4t0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqbG0430SmozmDnsmI0NKnw4zAAtOWHMd+fZhg/ x1GjPpLNdqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCamxtOAAKCRCPgPtYfRL+ Tg+OB/96o7kGKIe7n09XmsuC+oTgqoJxDaBlADO/6AxrdN26RQDsW7V2Fm5FwFrRCC/ZTGWqokd j46UnehxgkOxGlgOHUyd3dqwDho9/KjpJgj2mFofun/gjf6GiYxNnf4VXE1iyrIw6xtcWzqtJEh 8Au5crx2ps47SOIGJ/VMmphPGZB7qPGoC0aV6iXFV09nhu0M+pIWwJtvYxiuVOPg7ysFYsjVGPy Rz3WYrYEkdsyYH1kqT4+LKbVaEwFqv070yzAmNqMKTc61Mc2lxBko3+ftBhYARLINDzzXt/cjGK jQ9hDDclcvktXJoLmx2eLGklDb/K2f4N8qznsfDGyHdZxoF9
X-Developer-Key: i=ukleinek@kernel.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

after the discussion with Hugo about hub6_match_port()[1] I looked into
implementing my suggestion. Hugo had a doubt there:

> I am not sure to fully understand what you suggest. Copying the same
> function code to two drivers seems like a waisted opportunity for code
> reuse?

I don't think this is a wasted opportunity, as uart_match_port() only
becomes a single comparison for the txx9 driver. Also having 8250
specific parts in serial_core is a layer violation.

I was unable to unsee some of the stuff I discovered, so there are a few
more patches in this series now ...

The first txx9 patch is a preparation for the second to establish the
assertion ".iotype is always UPIO_PORT". It's also a fix that is correct
on its own (assuming I understood the driver model misuse in this driver
correctly).

After that uart_match_port() is only used by the 8250 driver code and
thus can be moved to there in the third patch, simplifying the
dependencies a bit which enables fixing the breakage I found in the
fourth patch.

The two remaining patches are cleanups I found while working on that
driver.

Note this is only compile tested as I don't have a machine with any of
the three affected serial hardwares.

Best regards
Uwe

[1] https://lore.kernel.org/linux-serial/amn8Hb2dbv_Sah_Y@monoceros/

Uwe Kleine-König (6):
  serial: txx9: Drop noop probe function and dangerous remove callback
  serial: txx9: Drop usage of uart_match_port()
  serial: 8250: Make uart_match_port() a 8250 specific function
  serial: 8250: Fix corner case for port matching
  serial: 8250: hub6: Add cleanup code
  serial: 8250: pnp: Annotate init and exit functions for conditional
    discarding

 Documentation/driver-api/serial/driver.rst |  2 +-
 drivers/tty/serial/8250/8250.h             | 10 +++-
 drivers/tty/serial/8250/8250_core.c        | 27 +++++++++-
 drivers/tty/serial/8250/8250_hub6.c        | 11 ++---
 drivers/tty/serial/8250/8250_platform.c    |  9 +++-
 drivers/tty/serial/8250/8250_pnp.c         |  4 +-
 drivers/tty/serial/8250/Kconfig            |  4 +-
 drivers/tty/serial/8250/Makefile           |  2 +-
 drivers/tty/serial/serial_core.c           | 27 ----------
 drivers/tty/serial/serial_txx9.c           | 57 ++--------------------
 include/linux/serial_core.h                |  2 -
 11 files changed, 58 insertions(+), 97 deletions(-)


base-commit: 95d6a9ccef99117115e41e9adb271243bd5e985b
-- 
2.55.0.11.g153666a7d9bb

