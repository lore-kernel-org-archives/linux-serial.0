Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A747C1D799D
	for <linux-serial@vger.kernel.org>; Tue,  9 Sep 2025 20:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757448875; cv=none; b=iWYqrJCo7NAKXx4SF2yhaUlOY9pmOc7tTOZ6wlzhz21u+SpiGnRbNHu7okQWF62k4vXVH/2mPcRD1GbfzctqypKy7LODrXZQ6nX/+gx0j4EZ6kpxPTWpTgMF6ox9CdLLgRNOk9xdM2cL9bmjCScF4ph5ghkJnvr2wQeIe6a1FOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757448875; c=relaxed/simple;
	bh=pC+qgCrf5oAgUVn4e1xqaTlgujkerEsWE670XtZjcrY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=qoer3l5JLvA0+7Vx6aOExwrFv+Qd8DO3uSN5bhKYdXsVuOmAVDkeZKOj80JIR2yf+PFnzZKoSJBf5t/RFVQAAhos9WNIL2vM2ANLjDKg5/a9aycKBVPLrorLwlN/C4/0n1fVUWHQfbkwx4rfWQLPLoSPjnT4fed5E5xFHFlamnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=gCJEhYd1; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="gCJEhYd1"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-411498d92deso10740295ab.1
        for <linux-serial@vger.kernel.org>; Tue, 09 Sep 2025 13:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1757448873; x=1758053673; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pC+qgCrf5oAgUVn4e1xqaTlgujkerEsWE670XtZjcrY=;
        b=gCJEhYd1TPbUZOAx6m8o2N/w7CkdbT9S0hiO1VBarNwQUq2LVpcPVcybdn9MfeJ24m
         PHoesMV8eyxk6wPvpq7SnKYZ2NhrHvvibHKTvndMl+SmqdUCfwda1UmlH5jLpH3WQaMS
         6csgnjd8OQ+elxHTJ0/NafIOx6Wr0EIbGjDXH+QPCoCTNFNKLJ++M/tcSVttKC7fw1wi
         3ox4NPFd1xI7pNsfm8G1cd7EzhKfp5guGZJ1CTmLbwbbvrMjY3/wgVW0zFRUgXeKC8zL
         vFyS2mS0OTGLVHu0oib0JS7PVnea+hVLrwbbuBbXEBCZClOVb3MpYvRSnjKWjV+mtvZg
         WcDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757448873; x=1758053673;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pC+qgCrf5oAgUVn4e1xqaTlgujkerEsWE670XtZjcrY=;
        b=R8vJ/k0sMcIXSY8U9rnouQ8roOoNtrHFqDat663NBCdBlz1PagXderPLfdeLB6e47y
         rzhNcfcbdmTiKTVvVu09FHLOK9y82wX2W2H9jDW35xx23pcPYOw0YmAIznJRSzhp04em
         E29KibuBFzbuojjLf8lqZ2FlamHbVZSipwvRg+KnbarK4UHjfaMg64I/aeCN1RG2/RwA
         dFQ8e02CWbR99ypw4cJTt/1clQwKipRk8oS5sCQSGRC5U/OoK9FQgvg/DD0OKLjCTWs/
         mnSM4Zftl6hWVWWnjEoIN1DFd/K9y364k45ay+WxiZBYGzzMhYzvTGH69YEOUI+Z8XLA
         F0fQ==
X-Gm-Message-State: AOJu0YxNTvWPXpjttaBgJYQ3ZdkwJmAQe+D9Vrsmt2WjZ/KWfMx75KWa
	tududacZgFpoj5yrTk2oEpo7h4Alv/J+kRQmPhREwwemfwqrBy5LlJWK/lOtrkwa35oxUn66B7y
	3Ir9TeFFxu+QxHfhzj/aKlg+i02WOiwnD/G/Lw/VTAg==
X-Gm-Gg: ASbGncvTPuB0PRSpRncYNhJR7bRmODsGZqi5sW6BvzmeQWbgAXLX9u04Q+uTTa4H+RU
	dW2ysGd7vsW1dS1kNO1t9QizRXFNui6nIC6+OJ92Voo7/wSw3oc4eNZT8u/I4YcydvMYS0bVWC9
	RxssFm/QeUJUNTF2cfoUHMve/Oyudg/aK9ziE0a7vpAP5KtcPY/8/IFs9XQsIjkDVQ92UmAJQ0D
	IcF3Kt8x1Octk7arGh/sxcgDGisXlusuwGVDhSP
X-Google-Smtp-Source: AGHT+IGHIAGmGX8vz05/lHBhytEr4x1XYWfkWmN/DCTUzC9y/eFYWItfXPB20Mf+dZFPdethrOW25+C6zWtIO0sh/1A=
X-Received: by 2002:a05:6e02:250c:b0:416:c09f:d572 with SMTP id
 e9e14a558f8ab-416c09fddd7mr4303345ab.13.1757448872525; Tue, 09 Sep 2025
 13:14:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Andrew Murray <amurray@thegoodpenguin.co.uk>
Date: Tue, 9 Sep 2025 21:14:21 +0100
X-Gm-Features: Ac12FXzGBMdzlurF2d39aH1H_wq3Uv_KIwQQYmFRcKQ-TLNb2E0PlXq74olWjjU
Message-ID: <CALqELGwr=XWA2iD-7wa1jOigx3pfEnTnaGWUMQX_A5MWe3DN_g@mail.gmail.com>
Subject: Lock contention with console kthreads
To: John Ogness <john.ogness@linutronix.de>, senozhatsky@chromium.org, pmladek@suse.com, 
	rostedt@goodmis.org
Cc: linux-serial@vger.kernel.org, Andrew Murray <amurray@thegoodpenguin.co.uk>, 
	Michael Cobb <mcobb@thegoodpenguin.co.uk>
Content-Type: text/plain; charset="UTF-8"

Hello,

Since commit 5f53ca3ff83b ("printk: Implement legacy printer kthread
for PREEMPT_RT"), and only when PREEMPT_RT is enabled, legacy consoles
use a kthread to write out to the device. This is beneficial for boot
time when using a slow console such as a serial port. However, this
gain can be short-lived as console_on_rootfs in init/main.c appears to
act as a synchronisation point.

legacy_kthread_func holds console_lock when flushing, and is held for
a long period of time during boot. Towards the end of boot,
console_on_rootfs is called which calls filp_open("/devconsole"). This
does a tty_lookup_driver which uses the console_device function to
obtain the tty_driver. console_device attempts to acquire
console_lock. At this point in time, with a (very) slow UART, progress
through kernel_init_freeable is halted waiting for the lock,
eliminating the gains of offloading to a kthread. If this could be
avoided, then boot time would be improved.

I also see something similar with an nbcon console (with
b63e6f60eab45b16a1bf734fef9035a4c4187cd5 on 8250), with
console_on_rootfs being held up by the writeout, as far as I can tell
this is due to lock contention in many places, for example with long
delays acquiring uart_port_lock_irq.

These issues can easily be reproduced by adding 'initcall_debug=1
loglevel=10' on a 8250 console at 9600 bps.

I know the legacy printer and nbcon work relate to PREEMPT_RT rather
than boot time, and so I thought I'd point out my observations as it
seems we're pretty close to getting boot time benefits from this work
as well.

Assuming my observations are correct, are these known issues, is there
any interest in accepting patches to address them? Or pointers for a
direction forward?

Andrew Murray
