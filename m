Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9264A7CA2
	for <linux-serial@vger.kernel.org>; Fri, 25 Sep 2026 14:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790345862; cv=none; b=KgMms5+HbjAvTgGRK2Ln7uZ6Z1xkwnVumUJO4j5Mkl9iMF2ogVbkdZ/l/dc5oV2eVmRku4Yl64zTExRDhcBG7Yev5tA0n6Ul4QOwS35hhLDoC3c8MYjpSRaKirJslKbWZm0gu3pBE3gPgb/RyE850Ml/4tBEnhzxZObgfKea+f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790345862; c=relaxed/simple;
	bh=y32gu9h1ReM6OPh3o/V745lcyXdiNoslJ/9QC/Rc3/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ff/8W0sm7YwJ5L+EAlDX/USxo/thLW6lmZhkno6XtZDyeDU/4m/ZoxEbLCPJActsTiuvrD7daR/saIQ7dvmHVA9Db+eunym179ANGDRmDyCdjZzFXSGfgy+3kHHvqzUdctNCkEW3V/1hI5j+hZibuuSW2a+r24YtQRAQs9SDEKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bHlBGFfp; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bHlBGFfp"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f635552aso717378f8f.2
        for <linux-serial@vger.kernel.org>; Fri, 25 Sep 2026 07:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790345858; x=1790950658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=R7KJXYx8/32YzNnwER2CenWGIjFU5wrhADjR8xA4akM=;
        b=bHlBGFfpRuJfmHlhKGCheohZxecxwwCpHHMv3OF4408hNjAigdf6tcRrnHIPIpYmTN
         L7EixXEE4uz3aSYRa4W3N76rdSbxbkK/TMqG7ffUYmsaih0IwbL9GEFP7WouetDtzKBA
         3hGDpwVQuZILGcW2VUo32JEWoyK0b3+e4P+VpbrG8Kk2KiLvVjfgVlO50QfUH6VaS/Ge
         FGyKta6EISDE2MuXcxnEWRIDH501+Oxh0jcr8cpNLyCzg+t8PHvTdfTWNnLJlIEalVx8
         Z4m1Sf3b3S50iqrzsxwtIIIk93YLjsVzmIduPNcaN3VC9cnFMFom6S+n5Ygitspm5fx/
         B5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790345858; x=1790950658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R7KJXYx8/32YzNnwER2CenWGIjFU5wrhADjR8xA4akM=;
        b=tzQZSHqiYC74QfpjpPLVLYAYdr0BmceC93wjMo63Mt4+lFqrJzYSIf1zaYaCJO6++Y
         w7eShGSN5ccPua9iyZnkY997dUTTwWn3TR55zVzXvkepVhgCaCXK6kGqO9Y9OqxX+mAV
         8RkKULATii8uap1OvBjZ0/qoM2CCO82QtmactWswRj39j/D/L2TlbzG+bBs21hZ1CwQz
         3i/8Hly7zve4M8RFccwsVMIKRODsFTjXHDCyI15xpwOSlBDGAQBXfBvYlDuZaoAf9bA/
         qCfYmo0hZGaaE9IOqNih3qjm4Vn5SpXt7hc1tbqHzp0Q4vwSbfyAhiyZo7GJW+88t6ar
         oBkA==
X-Forwarded-Encrypted: i=1; AKwUvBxd4CsRuU/Ku/IMZXv5W+Tfn803xWj5UhyJKORGugOG8311OokjA+PWmmwXnnqXpRXnY241fmFEF0OS4FI=@vger.kernel.org
X-Gm-Message-State: AFuF++mdOx47jYpNUxa/U/xnub3ZLgslm2XvjikFBIEFVaZ7YsbnOpTL
	XSGzF5nEGDJUVizUVJlpSGUTYGuQi4IOlRQ8b6fxABcerc2lceREOgAjTQFIub0WzkI=
X-Gm-Gg: AYBFou2FB6ujSAzG6tAlIft/rDAHNGTrovWawRUlmiuwSLs40wPPqiF8NXKg6Awe4G4
	UTMupcaet0MtVOJHuPl2ausAk+3HYaMXzhLXVBa/ODZTZi6v/f8By9DK9B6Ku4/c2gBBMLwVIJO
	m8qxBFv0HEy/K74KyfqlQmeZa6gW0XtqPCsVA+sZqa5oB7tveErc8Akxg1ncBP3uEL1GKJb+07K
	nWaGbUwWkQfTP9HOWHqQQWEk2dYoUTRIXDfAhby2pP1a4rywQNB0g0LNDomYDpNPHthKTzHDAXc
	gX7nqTfMv+CT65jSwqq8YSXu8k0svkYmidCHSiY5W2B5gvJEBYtWHCAnQQGie0ZDRbIf8O44kIv
	NnfEES/pLI8vWYe85NS+Lp+WPfoC3qdfBYuck5qRpOqSppK0SdoJpaljn2b3zSHPo4KqD7Q9/yA
	hSp/8V12U9hP6FGMZAyP0aymY46jVV0we7Rn0gVpo3n6ksP1kKXxp+BJinw/XKXN7TALIffrtE
X-Received: by 2002:a05:6000:4707:b0:488:6bcb:ec92 with SMTP id ffacd0b85a97d-48872a71ba2mr9339555f8f.17.1790345858166;
        Fri, 25 Sep 2026 07:17:38 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a640df9sm7336595f8f.24.2026.09.25.07.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 07:17:37 -0700 (PDT)
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Fushuai Wang <wangfushuai@baidu.com>,
	Kees Cook <kees@kernel.org>,
	Stepan Ionichev <sozdayvek@gmail.com>,
	linux-serial@vger.kernel.org,
	Manuel Lauss <manuel.lauss@gmail.com>,
	linux-kernel@vger.kernel.org,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 0/1]   braille: nbcon: Fix Braille console for NBCON API
Date: Fri, 25 Sep 2026 16:17:28 +0200
Message-ID: <20260925141729.173943-1-pmladek@suse.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

this is v2 patch which tries to fix Braille console driver to work
with uart 8250 serial console driver after is has been converted into
NBCON API.

Changes against v1:

  + Merged into one patch. It is hard to explain nbcon_braille*()
    API without the user.

  + Reworked the locking, see the commit message for more details.

  + Fixed the check of CON_NBCON_ATOMIC_UNSAFE [Sashiko]

IMPORTANT: The solution is not safe in PREEMPT_RT. But it is better
	then nothing. We could either solve it in v3. Or we could
	fix it later.

[v1] https://lore.kernel.org/r/20260922072558.98854-1-pmladek@suse.com

Petr Mladek (1):
  braille: nbcon: Allow to use a serial console with NBCON API as
    Braille console

 .../accessibility/braille/braille_console.c   | 43 ++++++++++++-
 drivers/tty/serial/8250/8250_port.c           |  5 +-
 include/linux/console.h                       |  8 +++
 kernel/printk/nbcon.c                         | 64 +++++++++++++++++++
 4 files changed, 117 insertions(+), 3 deletions(-)

-- 
2.55.0

