Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C2B38757B
	for <linux-serial@vger.kernel.org>; Tue, 22 Sep 2026 15:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790090272; cv=none; b=hGaKqoEkvtQoIsmV2utxcsofpLkzNfO4CdLdOmODgYDcyEHJ4heY4q0WbA/f3HflZB8l7veglZZ6KChMg+VWkQaiPPQHX33E637BER//yxrI5yn5s9XRRrrda6m+x4/1W3SEichwHRpNXSQLhqTSar28FANLOq9Bq+ElMyR/C88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790090272; c=relaxed/simple;
	bh=CGwfGX7tsRpqOKKJ0miq2JDg5a0dolCInmXOCA+qY6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yn6iHq8e2hqG+U7U/peYwkM6UhMAaGX4cifZCE4CjEKDDJDr1UoMdbAK2G+JKl3qRjytJ/pf+FDlmOoWAKjdEN+AHnuunCoTV4L4NLI5fmQTqyPH34Imb3e12vNugEVbv278HQ7jXTf0NL7jh45KM/DPqKN7lWXYy3fdPuNSaKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qgh7EGsP; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qgh7EGsP"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-8633a38df87so2806797b3a.2
        for <linux-serial@vger.kernel.org>; Tue, 22 Sep 2026 08:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790090269; x=1790695069; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IHB9IxVUxavOjDPhu5rxEe8qPGJRa/948zvhQlxvPGI=;
        b=Qgh7EGsPfWl55YdLntFwdw033arm4nQ/stwnQJmQ1/IJ5v2WtiK/YoZAKc394DCLiF
         xwaAkhAkHgFHm2lPRSe/itOl8TXYrbOUQueGfcyvKIFNfOg6cqNN0wTH2qJJLU1a+7/7
         jq1W7npN463MH5j+P9Z6PTWC9iSqbPcMps/EPxwj1MGHMGAoIfoYF0jqY0GsnyKPHk8C
         lwI0XFztT4VPDOfIjWs6eVLkkSsZlsOwzZd09rNvuSZZr2jhSWSfw3OGMP6C15sasIXE
         tTmp0Nk8BDfCHzMXNmoflLqx5jKEO/A/PlNWhRZwaScWzXzHbzCM0M8jlm1y1xK6+fG7
         xRNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790090269; x=1790695069;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IHB9IxVUxavOjDPhu5rxEe8qPGJRa/948zvhQlxvPGI=;
        b=ikdSUl0tvhj+qVgWhiOIBdl+7C/TMoAGazOFOKVeuPE5XgTQR9ytFxBLHwFYJSHF4D
         HZ/9QnVJP5M+EKTs+o7MMoZANRSwLbJpSWLQX3w5TIzp9cMeLZpqIpibgeiTFOahtmze
         iw3kt8wZCGGwwgnYTWbyrLPN9be7KwQ9/XdotDd4r0VqnLfWfIAXQg4ya3qLYoRuYudY
         H47AXeslsOcJDbCmpPQDBlvJoms6B2jOJhPk2wfO9s0SaZ1aOBVjtT/+b3IWSIjb3uf9
         UoIfcMrVEH84KxCiCimYyQMWKaHp8r/aDm+mERc9Emq3KE5Q2cunmDI/G5NB0HZTQnQg
         HzUw==
X-Forwarded-Encrypted: i=1; AKwUvBzj+0e7VbTS8K6CMmil2HZ2jT/6wWhgCGGwYQLy/C8rRr36bybMTG2v4XYuXnDLM6e1JvqChWoqXGbkROk=@vger.kernel.org
X-Gm-Message-State: AFuF++lSCzsuAYXDklDmnpuuBcQUuhGn5qp5OQEdd8xXg7zGpTa647KU
	QK3gos9fsGfAcVaGkwbxi6PotTY7KWPcA5g8CqT9GwPX/KsY8FvRhRHw
X-Gm-Gg: AYBFou0kCakSNOe1hzovdX7oCFWpyFG6GT+TzUDw5eVI+MPmkzVoN4/O0q9EIJZyUk2
	hy2xdl14d5JASKVAaNrG8JK0oZtm0iNwtqEXjjfgLNIks3Set1GuvSFYxyRG9ZJEBkiwbdWunz0
	DLi5ZzzhN8Bu1wGJ3ialVoPijIlGn3cfEI7Sfanv9+m5N4/pCuFLDbSGBmVziVg8XmXXWmGKxfR
	O8ExnxinEHatT1HlXCZirjsFLSS8D76RTTZ64ZYg3cOjFyHlsuF3D8h/z2YgvNOvV+dJAGaJ9qX
	Pegy0g+ffCM8/PJThdVC8agmUnVvruj0vvG3fzwBxgpu+DJBvcdNu+L0VL+CCGncvtw1JOQH1dG
	VaOlUwZ4xlZlHqN0QA0ZOvaYOMtjONRd3ZaC715y7q2C89ZzRtmL3PP1wbZRptPLMTNrYiyXbqR
	UuC+n+UDII+Vwf22wPE66cbwMEoFOA/tLIoXkHHmAocPZdLxzImPi5VFCqJmlViKw1ABZ4CtpRT
	wme0c4jl3A1uVq1OKfZzmrgWoavySXJJoCI9pmsc2/yEw==
X-Received: by 2002:a05:6a00:1496:b0:878:37e1:aa76 with SMTP id d2e1a72fcca58-87c855f6437mr1731047b3a.56.1790090268489;
        Tue, 22 Sep 2026 08:17:48 -0700 (PDT)
Received: from SANGHOON.tail18dcf4.ts.net ([1.220.132.212])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87c332aca11sm1074819b3a.54.2026.09.22.08.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 08:17:47 -0700 (PDT)
From: Sang-Hoon Choi <csh0052@gmail.com>
To: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc: Sang-Hoon Choi <csh0052@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-remoteproc@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Changyul Lee <lcy8047@gmail.com>
Subject: [PATCH] tty: rpmsg: close port lookup-to-get race
Date: Wed, 23 Sep 2026 00:17:41 +0900
Message-ID: <20260923001647.1337001-1-csh0052@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026092154-anger-sensually-aae8@gregkh>
References: <179000811428.1227592.8003229121862460039.idr-bug-84@gmail.com> <2026092154-anger-sensually-aae8@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit

rpmsg_tty_install() obtains cport from tty_idr before taking a port
reference. rpmsg_tty_destruct_port() removes the entry under idr_lock
and frees cport. If channel removal drops the last reference between
idr_find() and tty_port_get(), the install path dereferences freed
memory.

The first-open path and channel removal can run concurrently. tty_mutex
serializes TTY initialization, but rpmsg_tty_remove() does not take that
mutex. tty_unregister_device() prevents later opens through cdev_del(),
but cdev_del() does not wait for an open which has already entered the
driver. Before rpmsg_tty_install() finishes, the port is not attached to
the new TTY, so tty_port_tty_hangup() does not close this interval.

RPMsg channel removal may be initiated asynchronously by the remote
processor or transport. In the test, the local process only needs
permission to open the TTY node; channel removal is initiated
independently.

I reproduced this with a UML kernel built with KASAN and a synthetic
RPMsg device using the real rpmsg_tty probe and remove paths. Test-only
synchronization forces removal after idr_find() and before
tty_port_get(). The opening process drops to UID 1000 and GID 1000 first.
The unpatched kernel reports:

  BUG: KASAN: slab-use-after-free in rpmsg_tty_install
  Read of size 4 ... by task init/23
  CPU: 0 UID: 1000 PID: 23

The allocation stack ends in rpmsg_tty_probe(). The free stack is
rpmsg_tty_remove() -> tty_port_put() -> rpmsg_tty_destruct_port(), and
the invalid read is in rpmsg_tty_install().

Take idr_lock across idr_find() and tty_port_get(). If the entry is gone
or its reference count has reached zero, fail the installation with
-ENODEV. With the same forced overlap, the UID 1000 open returns ENODEV
and KASAN stays quiet.

The test uses a synthetic transport and deliberately widens the race
window. It demonstrates the lifetime bug and an unprivileged opener, but
does not show that an unprivileged user can deliberately cause channel
removal on every RPMsg platform. I am therefore reporting this as a
normal lifetime bug.

Fixes: 7c0408d80579 ("tty: add rpmsg driver")
Reported-by: Changyul Lee <lcy8047@gmail.com>
Link: https://lore.kernel.org/all/179000811428.1227592.8003229121862460039.idr-bug-84@gmail.com/
Assisted-by: LLM
Signed-off-by: Sang-Hoon Choi <csh0052@gmail.com>
---
Greg, thanks for the feedback. I went back and reproduced the race under
KASAN before preparing this patch. I can also provide the test-only
instrumentation and the complete KASAN log if useful.

 drivers/tty/rpmsg_tty.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/rpmsg_tty.c b/drivers/tty/rpmsg_tty.c
index c5fd6d9b3..b2765bae2 100644
--- a/drivers/tty/rpmsg_tty.c
+++ b/drivers/tty/rpmsg_tty.c
@@ -49,12 +49,19 @@ static int rpmsg_tty_cb(struct rpmsg_device *rpdev, void *data, int len, void *p
 
 static int rpmsg_tty_install(struct tty_driver *driver, struct tty_struct *tty)
 {
-	struct rpmsg_tty_port *cport = idr_find(&tty_idr, tty->index);
-	struct tty_port *port;
+	struct rpmsg_tty_port *cport;
+	struct tty_port *port = NULL;
 
-	tty->driver_data = cport;
+	mutex_lock(&idr_lock);
+	cport = idr_find(&tty_idr, tty->index);
+	if (cport)
+		port = tty_port_get(&cport->port);
+	mutex_unlock(&idr_lock);
+
+	if (!port)
+		return -ENODEV;
 
-	port = tty_port_get(&cport->port);
+	tty->driver_data = cport;
 	return tty_port_install(port, driver, tty);
 }
 
-- 
2.43.0
