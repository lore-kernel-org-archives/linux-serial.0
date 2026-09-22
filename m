Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB823F8709
	for <linux-serial@vger.kernel.org>; Tue, 22 Sep 2026 07:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790061981; cv=none; b=jLdXV/cfruUc08Zv/3DkD5w+yAppLerGh/TjmkBDpj175b8cKZIJK8Xb4X2W+SAzJ9lW/R08Tt0irp3c3dpaFWzS3GIicB4WDQX/u4LROCSrcFR0qvTLMmZmITxN44c/QSxE+CeN3XbooTnPsBzHC0rBgspwdQKa2lUTvxQYY/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790061981; c=relaxed/simple;
	bh=NpaZsBG3v2ONu7MpNQhDjFvyJTphrtdxhYVx1AWKONI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BIwBbnNTbdIA75R63mM6LjX/aBrbQ//LwORJUGFmLR0gotAIHYPMPANbvseQAyoIfQGKBrdyUr4BJiLTTUhdOChQLhg+6aqk/8AoYLvVQMtrmXmcWWi8Y/hswxyBNEBfbmIyZJCPOxX7wndxsIThRRakFodlqIL6wXjJ59xNeGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=J5djkjGh; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="J5djkjGh"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485b1d2874fso1373753f8f.0
        for <linux-serial@vger.kernel.org>; Tue, 22 Sep 2026 00:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790061977; x=1790666777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tV9ZgiYFru+aj6sJhaLwXAzLv5SWqi7Zpbwcao5o810=;
        b=J5djkjGhJpFYM2GSd23sDjDtrOemOb+cAnYke12JKUc613u6GSjBOUbYrRutLPOact
         6laArDOc3JtzpKziY2lSdHPzNJfrBxUFa7H3Qr+8XScDlyxBklT7JE/sQEnZBUDCg+tY
         bswMRsdOmHsT+aQZ372QzZvnGmb9LNEHZU8BjATySaK/zEIgaqWIfzZJ6gnODe43K2+h
         cVGrKTHPz5sWOgR015yfEja7eSKANP8c/Rjm1gdlWcgSIN3I5PLnpuzZSQ6PhIR/QwTX
         FLWVcpQLuWwswleJKM0YU2T+WnwNg1D3MRPPqwB2AOj4cnDjKiJ1KQBfMnzrwYiI8RsS
         mI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790061977; x=1790666777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tV9ZgiYFru+aj6sJhaLwXAzLv5SWqi7Zpbwcao5o810=;
        b=nR5/6exi/oXSUM0uPmFb6dh7r6Yq1lZoteNh/gAVP6WoQlcoeB8ZZc7uJdiUXMoYE5
         6ahX02X8fLcBY/jqq5FB+Za7LIvAHlh3TDo4iO5yPVBfT3uyrNa7Qirog+Ta7BUK7GwV
         r+H09rHCJCVu7uULZtm3ws7h7LkGhZJcbpgFEKAi5h3sdhwpTNX9F74JiScAowmYtWEf
         kkdwGyIch4XrSCpOUM9I9ZzPg2awBrkbg5IUE4PaPt4Qp6sA3YnEeH8ZPkj2GkgiezMb
         jYcZunGpyZl+/IQOZoQMAnA+WRdaac50/qx1fozP842in1GlhtXAZ7nTYWTGyjMeiAJ4
         eNLA==
X-Forwarded-Encrypted: i=1; AKwUvBxn3rqWEacydUdz6WkKIJEqkM8WUXfymJEMgR1rpfz2bpCGa3iekYeipq93pqehoUODJ/1tup8ADuD5KTk=@vger.kernel.org
X-Gm-Message-State: AFuF++kGmmh402nHWZ94tSZdorLJywr7HcJ9r/4D78gpA/ax4tzRLBFY
	81HLO9tIQGQhM2PgwiokN0ot0aVAUwIF1H6yEHnRnINgrmcDS2zd57iJ+8tfDrPonmc=
X-Gm-Gg: AYBFou28EsKBX2JBZTZOHWUUsoVvPstiOOBpvjcfk9gGoGW0qeFzt1RPlit4MFvPTFj
	gsN1BUvqTA09BXiswNEY6gOm+h2XlR5vrM8xEjAnM1AqBBCxV3MlIldYOjNd/yqCFGybPXLsFvJ
	/T+Bw9ynmA4pCsOpm/RzL50CBf/LM3yfT8zBUB4+r2mFOGfpMzslw7/Oz5h0+rfp20tJWCLo6mO
	bGtAm9f1IHmp5Nll4qDt7WgOv7n7ZuCy0v7KIdIyaW53d+4FYF8yCDllYc9GFgqAZ6ZV2DwSYEA
	7oHVjpGok7MthORmqrwu6t8FW2ivWR7lUCWG7bfsMDyBo4jhAzw/YAyHx6Kkl+wRFk9QmPuQSQf
	2y82hYwupIa/rgfqRNUhckC9wORtGuB7yBzhtSlqYSiXkKG/6s29UrUt+9aqSgCn34xtaytK18E
	0Gxk0P1DQU69ePoyiaOeRbgcdaACsSakUSPoXwYwOGLLyyh/Yl7qy7oIR5+Rc/i1PVuCJPFmds
X-Received: by 2002:a05:600c:4592:b0:49e:6836:5386 with SMTP id 5b1f17b1804b1-49fd8517e22mr33087645e9.0.1790061976974;
        Tue, 22 Sep 2026 00:26:16 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fd8ce2646sm59215695e9.14.2026.09.22.00.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 00:26:16 -0700 (PDT)
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
Subject: [PATCH 0/2] braille: nbcon: Allow using a serial driver converted to nbcon API as a Braille console
Date: Tue, 22 Sep 2026 09:25:56 +0200
Message-ID: <20260922072558.98854-1-pmladek@suse.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I have been working on v5 [1] of the patchset cleaning console registration
code and I found that the system did not boot when I selected a Braille
on the command line, for example:

     console=brl,ttyS0,115200 console=tty0

Bisection went down to the commit d3539347022a ("serial: 8250: Switch to
nbcon console, take 2"). I found that the Braille console driver called
braille_co->write() internally where braille_co pointed to the uart
8250 driver.

I added the support for the nbcon console API similar way as we did
for kdb [2].

Note 1: I believe that we have a bug in the kdb patch because we call
        con->write() atomic callback after entering the unsafe mode.
        But we should do so in the default "safe" mode.

Note 2: I am not completely sure about the locking. It might be better
        to use NBCON_PRIO_PANIC in panic().

        Also I thought about using con->write_thread(). But I think
	that we have to use the atomic variant because the Braille
	console can be called from printk() via the VT code, aka
	graphical console.

Note 3: I do not have any device to read the Braille output so I am not
	sure if the output is correct. I just checked the output on
	the serial console and it is a bit suspicious. It looks like
	it prints every message N-times when N is the length of the string.
	And it adds one character in each iteration, for example:

<paste>
E>[                                       E>[                                       E>[  O                                    *>[  OK                                   A>[  OK                                   A>[  OK                                   A>[  OK  ]                                <>[  OK  ]                                <>[  OK  ] R                              N>[  OK  ] Re                             
       >[  OK  ] Rea                            J>[  OK  ] Reac                           	>[  OK  ] Reach                          A>[  OK  ] Reache                         D>[  OK  ] Reached                        @>[  OK  ] Reached                        @>[  OK  ] Reached t           
</paste>

	But I think that this is not caused by the NBCON console API.

[1] https://lore.kernel.org/all/20260604101459.393162-1-pmladek@suse.com/
[2] https://lore.kernel.org/all/20251016-nbcon-kgdboc-v6-0-866aac60a80e@suse.com/

Petr Mladek (2):
  printk: nbcon: Introduce Braille helpers
  braille: nbcon: Use nbcon atomic console callbacks

 .../accessibility/braille/braille_console.c   | 38 +++++++++++-
 drivers/tty/serial/8250/8250_port.c           |  5 +-
 include/linux/console.h                       |  8 +++
 kernel/printk/nbcon.c                         | 59 +++++++++++++++++++
 4 files changed, 107 insertions(+), 3 deletions(-)

-- 
2.55.0

