Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7115C3D75D7
	for <linux-serial@vger.kernel.org>; Mon, 14 Sep 2026 13:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789393232; cv=none; b=GiN4gcqAbps5yU9PBFsDRmS0MeQpZ/AtCoh3UQPjiL6ceILk3H1T73gHiWRMLW6/R9lDVPKr8fCpKOY4DcTBnTd7XXfNFLzalOvB4HTZg5bm+GUiovoH338hVnL8qrCjB2iT9GQ0nhHIorHovDhfslzsBBHoc1dy00YKvq4Y52Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789393232; c=relaxed/simple;
	bh=mZU/fO8OtaGbBarERog6EImn3Wb4EilvuM8GJIgoyXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JzlWRnmDZ9JCr0fxxgWFSsWOrwzWinE6jiF6ym5d+qzdeBPjEIgGJKqfnPt9gA+/SjWkKsdSVX5OEuc10L4UKKfZSNLeGHBby796RMmK40IUiiHQ7u11v5EcWU2b2vDR4rjrIqww8EhuF8Lo/JXn7DUt5YzgBOAWVKJ9s5NV2uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev; spf=none smtp.mailfrom=northecho.dev; dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b=OAzVnwwN; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=northecho.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b="OAzVnwwN"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85901984389so697667b3.1
        for <linux-serial@vger.kernel.org>; Mon, 14 Sep 2026 06:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=northecho-dev.20251104.gappssmtp.com; s=20251104; t=1789393230; x=1789998030; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VFyoG+nKOe7E1GIHo4TRUP3a6TAurMs7mwR7N6d6faA=;
        b=OAzVnwwN5SvVCD2pbSZ24aOXC6SwzT1sW24uM2/7fR39W1d04it5n1SGO9QLp120YV
         99s4v9RNtbybxOBwoKDt5FzJ5z+Xk9GzW31cvaqz/UA11pV5YurKDhnxu3KG21WvMdDt
         ttIKKW9y0YVeezFGVaqF7vKZxWKfK8eMgjLDCp9CrfH5SAOWTWbzM9HEF28N7MFGCF2z
         b2OQZcth5kBEZExrHl7GfE705PFdGmqHujWY1UR9utP4S3X4HDU4m4T3kyKdBmSypJAB
         ViJlPBHAeIFnyLg8eqjhoOcTwglLdhcr0IOTx263DmTgXgaXYwuPP6FEYaTzTP9pFofm
         SOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789393230; x=1789998030;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VFyoG+nKOe7E1GIHo4TRUP3a6TAurMs7mwR7N6d6faA=;
        b=R7sbSLN82YTdhL4qp+LEA1C3Jxa29fU3+XUJPZy+JE2fVtVGoNFizoICQNxiZdUxBn
         p+H86dMjAVOOo+Kw6iptfu5MAwlzf4ASJGyhtSp1OH+1h1RlxSCxNX4wjcdQsgE9hz7e
         heGk6V7G20DwFdxR2z78i7Zc8yx1yGlGZedA3X6mUNBgmgFJ/41TgZ9vxjt7YgrXbS3y
         XoL4xfOiQ5zdIyCIFno+fJtgf6BvSCIgb1vcN8PnFVq2n4o9tAWOdgEyNEcZB13589+y
         ARx2XXIn9gJ3bxUH018wUSmkZ36qQTf7QG9OlacQkqpAu+Ptfd4HbWhjJcGL2IKInadN
         Iw7w==
X-Forwarded-Encrypted: i=1; AKwUvBzbhGn1VOhzfgsQSkvKgsMZlZ1ImfetgwPUYRby+9Gd+k7MAYqQReDUey/Y2tFKe/fIiDunURu55glCspI=@vger.kernel.org
X-Gm-Message-State: AFuF++kO0tB90WkuV8nx2gZ6Wt4QaHDMGVNPizP8RilDo+pe5Gv/wu1M
	tgtjOqT4cFLhPQUFBNOoxOyNkA5ki2lS/rC8vrcjOUR7cmeviukjgTjN2+ZdPyZh/xqX
X-Gm-Gg: AYBFou3wPcJ5NxjhyooS0z9aGhGMBj1l86JxfrMd+PH6oc3IO0gcGMZCT+YBME+Hbxi
	PSBkC+PIdyA88OeD2QkEx0uj4mkApzwuyzJpDejf83+6z3ZM7QeQacQNDHfXfz6D1gaZ5lvFkL6
	4Qy0e4hGUZhilSV4nvAogmOE+DXAa31CC0JS9H6SgYkNdZxm5hRTd7V8QaIRNTn4a/K5L20585o
	cvPS6M3ffeDPu87Nz4j8WAXzksiBMz7IZqnuIDslxUPVmzHTvPDD7Y5RVbQlgPWm/v1mQcKjkWd
	VURAzuoMugIhrStq0HE06mkJlFkbrkPuE1sUEEj8leThtcXIQsrTPgIwXBlbvqgFJH6iD5Sq49Z
	g0Tq5zlxgf7aF3j5Bhaf6k53v2x4w/391MdjHJ1BcjEC3M4xAQ+2lIz+VBy1mgNEvzbVW7x+uio
	0Ckc9lFQnX3KUP+e0kZtEPzVPpGUgPgrxiJ9MCZI4cSGcedL1ApfnHKFKiRA5QDYVSnOWSYZVS4
	oG3bJRAGMg6rw3l3Y33zBhGhzOtslUlB8ok0XA=
X-Received: by 2002:a05:690c:6c87:b0:861:a34b:7de6 with SMTP id 00721157ae682-88d1992ba59mr9985527b3.0.1789393228701;
        Mon, 14 Sep 2026 06:40:28 -0700 (PDT)
Received: from kelso (99-10-92-174.lightspeed.rlghnc.sbcglobal.net. [99.10.92.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-88488a4c120sm36807737b3.38.2026.09.14.06.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 06:40:28 -0700 (PDT)
From: Christopher Lusk <clusk@northecho.dev>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	John Johansen <john.johansen@canonical.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] Landlock signal scope and TIOCSIG
Date: Mon, 14 Sep 2026 09:40:13 -0400
Message-ID: <20260914134013.1457130-1-clusk@northecho.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914.b8a029f9abb8@gnoack.org>
References: <20260913221958.839429-1-clusk@northecho.dev> <20260914.b8a029f9abb8@gnoack.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello Günther,

Thanks for digging into this so carefully, and for the clear write-up.

Your capability framing convinces me.  Controlling who may attach to (or
open a master for) the PTY is the right layer, and the master FD is best
thought of as the capability, the same way socketpair() is.

You are also right that the series is incomplete as a fix: the same three
signals arrive through the n_tty control-character path (Ctrl-C / Ctrl-\ /
Ctrl-Z) that my patch does not touch, and PTYs additionally raise SIGWINCH,
SIGHUP and SIGCONT.  That reinforces your point rather than mine.  Chasing
individual signal-delivery paths inside the TTY layer is the wrong layer,
and a per-ioctl hook would only paper over one entry into a mechanism that
is working as designed.

One question, mostly so I have the line right in my own notes rather than
to relitigate: how do you see this relative to the SIGIO/fowner path that
4b80320ca7ed brought under SCOPE_SIGNAL?  My read of the distinction is
that in the SIGIO case the sandboxed process unilaterally selects the target
by arming the owner, whereas here the recipients have voluntarily attached
to the terminal and the TTY driver delivers job-control signals over that
attachment.  If that is the intended boundary, it is a clean one, and I am
happy to treat TTY-driven signals as outside the guarantee.

If it is useful, I would be glad to send a small documentation patch making
that explicit: a note in the SCOPE_SIGNAL / IPC-scoping section of
landlock.rst that TTY-driver signal delivery (TIOCSIG and the
control-character path) is not mediated by SCOPE_SIGNAL, with the practical
guidance to control PTY attachment instead.  I will drop the task_kill
approach.

Thanks again for the thorough look.

Christopher
