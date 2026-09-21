Received: from mail-pz2-f24.google.com (mail-pz2-f24.google.com [74.125.228.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7244D6C2E
	for <linux-serial@vger.kernel.org>; Mon, 21 Sep 2026 16:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790008124; cv=none; b=p0ISGTFuE/UO1RkKmdQ/HS95+2WrjG/4VGntIMLBsxDKQlIRTsa94fflp+76dyCr6B5NwCyWePNMW+jJHg5rB0DK5f4teAvLezbmOl34GvdLX3shaaNHa1249MwDBrsfUFO5xl4Zi1LP8ZxSOyKWXg/b7fgzu1bPNHWzsKQ2+14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790008124; c=relaxed/simple;
	bh=Ei/lMDbqtinZc2yiBLQAMSXEoLG4Je+V+bGkXlP0VYg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RDRkcMcLAnvfIxBgu9LrX3HT7BrjXA6N9l+hPW9M9sm5zYsLYtH/sxP8KhwiJa+Gz13Lh7xalQfqLQiBsMFB1Oxf4Fr4bk0086SYQ9VTUnYWtLX1xFaJbCRZAsl6QabI5vGf3jYVroC76EghfBaa+CG6RZOuqRFUF/Jxp6AcgEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/06/YAZ; arc=none smtp.client-ip=74.125.228.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/06/YAZ"
Received: by mail-pz2-f24.google.com with SMTP id 41be03b00d2f7-cc745abb731so695377a12.2
        for <linux-serial@vger.kernel.org>; Mon, 21 Sep 2026 09:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790008122; x=1790612922; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t4G340J0PDbk3TvCsLvJzIITRUJ1wAT/vSIriLlX324=;
        b=H/06/YAZBLtuYf3AuZ60eF9ft44hb2CoZRlmIc8r8FaXSY34kQtWjMCZ5dZhh1U3wo
         K6vHkWAFFPTr+fdB9/3lXE5dk3Tiq5vbjSvnmdzKYh3fARIyI9weAWi1+a+K2qw6/G3Z
         ycbXdLEAOeF0wSG7SVt/tJR/gVlB9Fl0O/emtb223N9PWHRH+4IPaAld16QF9u1yvcb5
         l38RpG63Jmv8kCqJtzSLoIeyjYgzguOU4rX9EXLbbrhxnCbsY1/SoULPrI0A5kjr4PmM
         vJila0W45XK+56Ofo9n/ipsg6oo2i92M6ch3kEnsk1SkO7k6yUnPRsMAECGxU9ruKTMo
         dz+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790008122; x=1790612922;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t4G340J0PDbk3TvCsLvJzIITRUJ1wAT/vSIriLlX324=;
        b=Ki2f63du5ZPEeR8AID+tOkdDbfT/8b7vAxhxfEmlWRU5T4uKuY5HpMxINHn2rBA3DV
         KJOuam5MfFDLG5ILlTtTFl0EO+Y6kDuh30oGRWKUeY+9JlQueJlDJ8rbb5l8hIS9sYrd
         OMTBaHEarxqFSRwHXM3nHr+ZlQI4LCKxBrBVDAba/1UgwzpRZi3vtRKuvzdFFj5ZxFs2
         dIVmWwbCvM1wFtp/THyod8MytL1EPjlNlTK9RT9hOujsEjgyIMAn/HF/OEtCQE/LqSLA
         dY7dWRynsGAYbWVNQgptCZyAgiT6FxpKNCjqNUGCw4B4bAMaY04f0EyNc5SEX6kk2f2U
         +f+Q==
X-Forwarded-Encrypted: i=1; AKwUvBztlPPL7yY+qcBwP/M3f3Xzzta8ULESGBQGaC8Hid+11oWPfKtI/XdYOuYo9bP8TCPdkFdu5/IQyqyh1uo=@vger.kernel.org
X-Gm-Message-State: AFuF++leIvZVRPkQ4kPgXb0i24UEo2dn+me4RFpyF9uuvuc2pEVjylLu
	uSh0RvgJsgM2/ftPJzNhEZ3slc/rkBF/t3ywqk/omj+bNdAa8Y27Y/ygJ9fLGlho
X-Gm-Gg: AYBFou1hM/Cy70ukuyXKxscaONMjhIQlhd+K9/C4qTMoh0ulspS+jAHnJ41stpX6P/q
	6B1hfr2UoMr+67j3T9Xvb0Q9S+gciEp2O8FVQSBe5gePGttJM3MmL9FLRDD+a1vW7fOQxCcMhxk
	oa0uN8KFUtx1o22glSvGlFxaGXglp9hJAVh4VzP0qpH/QZ322KJRKjld52dQv3VmFTc9dGKzDzn
	F0AIzUPjaIV59hhKNZ59cJdSpMZ2zw0BUhJSXMD4xgsw7t2CeFkH8uLQlgywYbYIUN1fXobVIAv
	wVNXCW2hrnctKDU60lvEtlEmH8HFK300TgHhaDgaoF8vtKa0gDPJwRGlZpKG58Dr9XT4dottT/G
	siIeE7genSCS1ToDFJCmrcbUDjIOavAvjj+u5ccuc1mh5GSFKvuRx9aNxk2aBoCyg4aLklxWPXI
	AlgY3mKt+iipKj9YIpZv08VcmYKD8LVUEGSgME1kJRyAgl3VfbGCEo7LfBakGrqzK5YsF8ICwuj
	LdI8/WRMrtFpFszzeVkPGhV
X-Received: by 2002:a05:6a20:4310:b0:3dd:85a8:cac9 with SMTP id adf61e73a8af0-3dd8c47c24cmr15340142637.32.1790008122351;
        Mon, 21 Sep 2026 09:28:42 -0700 (PDT)
Received: from SANGHOON. ([1.220.132.212])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc72aee0fbasm3746033a12.25.2026.09.21.09.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 09:28:41 -0700 (PDT)
From: Sang-Hoon Choi <csh0052@gmail.com>
To: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    Jiri Slaby <jirislaby@kernel.org>,
    linux-remoteproc@vger.kernel.org, linux-serial@vger.kernel.org,
    linux-kernel@vger.kernel.org, Changyul Lee <lcy8047@gmail.com>
Subject: [RFC] tty: rpmsg: possible lookup-to-reference lifetime race
Date: Tue, 22 Sep 2026 01:28:34 +0900
Message-ID: <179000811428.1227592.8003229121862460039.idr-bug-84@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

I would like to report a possible lifetime gap between looking up a port
in tty_idr and acquiring its reference in rpmsg_tty_install().

The source reviewed is mainline commit
5dd1818b15d98d4a20806cd00b1b40320b06004f.

The install path calls idr_find() without idr_lock, stores the result in
tty->driver_data, and calls tty_port_get(&cport->port). The port destructor
removes the IDR entry under idr_lock, drops the mutex, and frees cport.

If the last reference is dropped during that lookup-to-get interval, the
following order appears possible:

    rpmsg_tty_install()              rpmsg_tty_destruct_port()
    -------------------              -------------------------
    cport = idr_find(...)
                                     take idr_lock
                                     idr_remove(...)
                                     drop idr_lock
                                     kfree(cport)
    tty_port_get(&cport->port)

tty_port_get() uses kref_get_unless_zero(), but this cannot protect memory
that has already been freed. The install path also does not check for a
missing ID or a failed reference acquisition before tty_port_install().

TTY installation is serialized by tty_mutex, but the RPMsg remove path
does not explicitly take that mutex around its final tty_port_put().
The destructor can consequently run from RPMsg removal, not just from
TTY cleanup. I have not established all cross-subsystem ordering rules.

A draft takes idr_lock across idr_find() and tty_port_get(), and returns
-ENODEV if no live reference is obtained. This uses the mutex already
taken by the destructor before removing the entry. Its scope is this
lookup/destruction gap; it does not establish safety of every probe or
remove interaction.

The draft was compile-checked as rpmsg_tty.o with W=1 in an x86
allmodconfig build at the commit above and passed checkpatch. There is
no runtime reproducer with an RPMsg endpoint or sanitizer trace. Device
permissions and the ability to remove the endpoint also remain relevant
to any security assessment.

Does another TTY or RPMsg lifetime rule prevent this particular overlap?

Reported-by: Changyul Lee <lcy8047@gmail.com>
Assisted-by: LLM

Thanks,
Sang-Hoon Choi
