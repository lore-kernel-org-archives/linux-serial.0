Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42CE519912
	for <linux-serial@vger.kernel.org>; Thu,  1 Oct 2026 14:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790863655; cv=none; b=JjL05qHM6kUNENh0I74VrNVzUTmxSqlXp+pecn4uE+f5vxpxi5MSGH4Fn5uVNHChgMtmaV0J5u0inFQtIQ7jGAJGZvXkXjLzkWIXTCCaGF4AlZTTRCWPYcL1t+hdEMIRVNGwesWyzEvxr+pjQlCGT4SRWKmt3Z8Sp+eU6Gfwxw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790863655; c=relaxed/simple;
	bh=TuVpEwAlwlnPZRUBPH2tPbpeRZXgxrKHau0lKsr8EPM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lAlVg2SfFuW41fYGbQQCQRphtFWLoQjKNqIao64dGuTrCQztguj9SHGGQvZ+ZPO92Day/k0+lYiH9QBcZVxHix3u+yvLgNUKGSKu7ctLaC/iYDNgtbEpEACUkXcxjGJ5uVwmJDK00XX//EEEqckCIJAfjw7GO7AMLu22JChqook=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GY1LDGZq; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GY1LDGZq"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffe281cb1so34434985e9.1
        for <linux-serial@vger.kernel.org>; Thu, 01 Oct 2026 07:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790863652; x=1791468452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KaLK6xVc80DoR2HBVg5Dlww4zduxs5a3g6ln9kbuC6Y=;
        b=GY1LDGZqBnxW32dvTykCI63qeWUEH6MpBK9vtGWGOSMNnS40JSGCXCiEnHYo2ABPsB
         6jwaE19Bxu6TkOXmW7pobM6/8pn8U6PzQZjmdEw4jUMsT4VvWsMEARun5D78s4+ya70/
         viba+pt2LCO34+gw9NjjI4aj1BO3O6321BcUWfOQpCD0JM/6g3IL1D1YXL7I+u0GDldq
         q7+ffwaU/k/kbt2d+5NAfUOY6IvUG+Qep8O+BknqeNaDSrfHGlVgUsyOs7yHi6PFthxP
         pwUlyN6pLvF+xiuMz9C2358cqZAl+Kn6Pzg/cpQZjFA9qI52CxhR3MDIGghKjoh0rN+R
         XwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790863652; x=1791468452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KaLK6xVc80DoR2HBVg5Dlww4zduxs5a3g6ln9kbuC6Y=;
        b=Sbt6VIRdqxwcJTX/WDQ8ChF5cGR6mxPB9Uka1ha5qRkR0JrLu6P7ne6gcKsSF34HDI
         KC69j/hsXrQIh21QrdGnIm6k9pNdWqMRQ9Wf8+OTBWUREZ46zhB/M4TqnTWg8Csp2inv
         ikgbYTURex2EVq/wT7mpuWCtfowVyoxZyC6WCvw2pLlCEyOTD1PFUc5Rz8y44wrKQ5eK
         2ST6T0liiLcvyBhG+lmJjOQioW2ZhykbnLP7+pLVL6sUkEjwOcHVokHpHXYKmdA9eZlJ
         CEbklUUNpytMQw2uIaIAavyCrajN2VXQOMoLOhzbUUcmYV0FMQGPHCfB3pUTk+eVMWxo
         Ij0Q==
X-Forwarded-Encrypted: i=1; AKwUvByPWI1SqNK7EGHA8iO8n6+fbnNOUI3yPpf3NgmqCjOlmaWO06X58oHiuWfHL6en/t5z03pAvC+KdYpmmjU=@vger.kernel.org
X-Gm-Message-State: AFuF++lNPxo1Fs4g6Hxh8C2P3eCX4ID4Ay/dOL0S6IKL3Rdf1Bkd5ZaG
	N6xPWa6bgq44ALvKwhF09AonHADvakmBfovQB0twtSsxoy2mUuErIdXiTNrkkjvANrc=
X-Gm-Gg: AYBFou1kcC0gtfh5Auq2hSK4Rulb32WDN3Wb1a/qOs0YFTcd+Km+O1KvYAGy4WFKTrd
	sDa8ppy08gLsOeN1k3HVAWpff8MggZ38jA7Efs1Yl2R6mz+5yVakuaJzVh9vwM78QRImlX9ZH/h
	eWNbgz92+rhNBXDQM+S9C43ccAwMqbXqhTpYirCbbXhlCKmf/PbA08FHrKoPx/btItI2NW0+s0X
	em+9OHNRT6JYSKQn9ha5ND7D432hGbL57zcKTrebCGkR6hUFYQzhGw+GGl4RB406ZfwgeuzXc17
	3CjNG97ATQcltynvCXMWwdoj9AsSMD6x6AWKw3nRKt92tp4wOsR57MYrlu1GSLWyETX8g542DAo
	Db7bdUrHyNhN9poVbgHvQVAVnlHr6QUfIA1TKCOQjD3X6HL3hZFkfMah8lJjTpYugjtb+Gcuxow
	5Q2T29gfSb7Cs3suimBG7rskIpfXcNOqc6D8smxxtwXRA4CDs7PhSrmGraek40DM4wevnP2Hwc
X-Received: by 2002:a05:600c:4fcb:b0:4a0:3b9:f16b with SMTP id 5b1f17b1804b1-4a01ab4f2d9mr90543535e9.0.1790863651874;
        Thu, 01 Oct 2026 07:07:31 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a023798b54sm39456895e9.13.2026.10.01.07.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 07:07:31 -0700 (PDT)
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
Subject: [PATCH v4 0/1] braille: nbcon: Fix Braille console for NBCON API
Date: Thu,  1 Oct 2026 16:07:26 +0200
Message-ID: <20261001140727.124398-1-pmladek@suse.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

this is v4 patch which tries to fix Braille console driver to work
with serial console drivers ported to NBCON API.

I did a quick turnaround because it would be nice to get it into 7.3.
Many people attend Plumbers conference the following week...

Changes against v3:

  + Removed unnecessary "locked" variable. [John]

  + Allow to use console driver even without write_atomic,
    except for panic mode [John]

  + Added parenthesis around (con->flags & CON_BRL) [John]

  + Exported nbcon_write_context_is_braille() [Sashiko]

  + Fixed many typos and wording [John]


Changes against v2:

  + Use con->device_lock() for non-panic case. Try even an unsafe
    acquire in panic(). This simulates the legacy locking using
    NBCON API.

  + Return when the nbcon context can't be acquired in panic().
    The NBCON API is not ready to ignore the lock. Well, it
    should never happen in practice because the unsafe acquire...

  + Avoid the newline prepend logic in all serial consoles
    ported to NBCON API which have it. Add two APIs for
    checking whether either "con" or "wctxt" is in Braille
    mode.

  + Update commit message and comments in the code.


Changes against v1:

  + Merged into one patch. It is hard to explain nbcon_braille*()
    API without the user.

  + Reworked the locking, see the commit message for more details.

  + Fixed the check of CON_NBCON_ATOMIC_UNSAFE [Sashiko]

IMPORTANT: The solution is not safe in PREEMPT_RT. But it is better
	then nothing. We could either solve it in v3. Or we could
	fix it later.

[v1] https://lore.kernel.org/r/20260922072558.98854-1-pmladek@suse.com
[v2] https://lore.kernel.org/r/20260925141729.173943-2-pmladek@suse.com
[v3] https://lore.kernel.org/r/20261001093946.112999-1-pmladek@suse.com

Petr Mladek (1):
  braille: nbcon: Allow to use a serial console with NBCON API as
    Braille console

 .../accessibility/braille/braille_console.c   | 60 +++++++++++++-
 drivers/tty/serial/8250/8250_port.c           |  5 +-
 drivers/tty/serial/amba-pl011.c               |  2 +-
 drivers/tty/serial/imx.c                      |  2 +-
 drivers/tty/serial/sifive.c                   |  2 +-
 include/linux/console.h                       | 15 ++++
 kernel/printk/nbcon.c                         | 79 +++++++++++++++++++
 7 files changed, 159 insertions(+), 6 deletions(-)

-- 
2.55.0

