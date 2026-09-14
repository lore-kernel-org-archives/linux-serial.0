Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B176496D42
	for <linux-serial@vger.kernel.org>; Mon, 14 Sep 2026 17:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789406001; cv=none; b=VNM6saQc0jI3iclXM5IXIMEtrpiVUK9oqBDBoukL5/LnfKgnbpMUIamo6H2bsqTDgTeKH/qjZyBxIEUsMnEJ2Em2onkkz1B+O3blpes+3qlwFCTpONCiLcAF5Q8hEu1oogBDwHg0pZuTE+4pBLtZ2Xnxvh3A/SxnvCByS5i6DBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789406001; c=relaxed/simple;
	bh=DWfd+OrYYBBAjoeKGlYddJuwoBUWlcnOVSA19p7gCPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VgRYSDAdOhQbH66t6DbCpQEM8k6MoQspkEtsfsQL18qMkalibG9gIr5Evr9WCM7o/cQHZnlMdiKoexKkVDFDW/nQSL/SVCWvjmv4RfDASWscOP0fSjKifHxqAOY8CPW6xR/AuC6zBDndcDckGC7KnjGVj4tLc7CWtYNDAKRHyFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFRnhab0; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFRnhab0"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49e78adf099so16629165e9.2
        for <linux-serial@vger.kernel.org>; Mon, 14 Sep 2026 10:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789405997; x=1790010797; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b+lHxHvQW6ptoO5MEGq5MTyGK+6vHvFuZMkZJq4Ndzc=;
        b=MFRnhab0hntRf3ahIUL7wo8NO040OIvRogUEtdFVo5Nwzda2TxxX+GMt2UJpWJmWSu
         Mzvfa2b+TAPy2v3XccD8smBuVpMu3aA8MnscuWlty7Vif266e0Qt2sHReOST2yhq0zBk
         NKJwrOlBWXjWRm/jl7visdu6zMyfwDnPOW/HYfgxWuY+3zbY+EnptwdRNxqQHQCfedVH
         kNkdmetUgF8RBD4bfBInEvRgFOfrK3s0X8MtuZETdqJbbBj5CIi/NNWtS25xK/JIGLno
         VAg65NrBfqvdDs8n7vIxAsMaJdxkay2oAEaGI5sTu8rOJVDMVnWP/HMz2L+QStne0OGg
         PvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789405997; x=1790010797;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=b+lHxHvQW6ptoO5MEGq5MTyGK+6vHvFuZMkZJq4Ndzc=;
        b=nBgeTdNsPSB2z48lSm1vH6QtYAnToj4Ar0d7QcItl7Tj9lQNaUD/Q5gVI/97flVCwZ
         lG0np9XtYqL7SAa4TcKAqqap5MdjJ+NqS33YJGfONw3Se5DdWFmhE8m1mOwxCu3hTfY/
         pKjIfXPGaspWlbP7bdoP1zRRJlP2/Rf1tDgdxeobe8dtWv0NDrvG05t96K9O0ydZNjIo
         OSEzafkJMJrHeGb5ZklzqT88NvltmL+qKSJ+WZDQ6t9wl48lHBkX1zkKnNWm/9LWeraX
         I6SJ+1Ja+NxhKBYlm6EOjOulWwAgWDdytwuYANV2bnxfoNkAyzXd9lxfdhx/IxxWaUKS
         QdaA==
X-Forwarded-Encrypted: i=1; AKwUvByyOMeQ0RmgGKMPIoZRLjsgSzZ7xlRosqHGmYlBc64WU3nN8/rfPk9qD6GZMmUD82ghMMzlrrBoJcOSMFo=@vger.kernel.org
X-Gm-Message-State: AFuF++kgqMwPQWFC0PbLDdw+naIiBia5QS3avYMrrmyThse5UZDjDV+1
	bNIohwQEtlRPIcr4l8jepS3P4V66VaeJGXhvE0GMxKgE6XZddln4TIsM
X-Gm-Gg: AYBFou1pr2RdoF/9gKXiMhH1gmMER4+Xyo2jzYxC9IgFTVC3XQo35jbMsPnkUTfTpsg
	kWzS8gopAhMt4YTVKOMAQ8PKz0u5Vb9ypvWTG/IOcZK2tDMwEpUWG8s4h/BCO/MphfImcdJrYo1
	a77LcalbHGA077ldG4D3iF4+nDbaeBxooq389SjQMPuZgWtibeoJLtyOYW1H5tZFeQ3fNmjrqTj
	jMvCRIpb2bmdFZ1bJOOCgF7kuojIbn0qtOuGgBQ8NAFuCiMCbX0MmQvQCiH6tCzFGE2vv3b0Kvo
	h5uh8b1bOPIavqWjSy6/6U6IeZeIS0BeJsm0/HFQJ2uXKsbWTLBdJPch2nZG+z1FN1U5SbrQSaf
	M/sCm3U3qQ/LVFcZAwr0BGcc5/SrxDRfKvEHJJZJYKROljxeVpz/qI7Ato4ALmJRebW2cYN6DNi
	lFb8ll78/b2X927HUduiOXUxJoI010xNajZZEX1dZsKSYwZ+NJiGgklYXp70JLaY0irJz39yPYk
	clL1mUYnOrQUlUoZzFhuSNZ
X-Received: by 2002:a05:600c:3585:b0:495:4d88:e630 with SMTP id 5b1f17b1804b1-49e7a64b723mr52892565e9.10.1789405996936;
        Mon, 14 Sep 2026 10:13:16 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7d675a50sm6040645e9.9.2026.09.14.10.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 10:13:16 -0700 (PDT)
Date: Mon, 14 Sep 2026 19:13:15 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Christopher Lusk <clusk@northecho.dev>
Cc: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Oleg Nesterov <oleg@redhat.com>, Jiri Slaby <jirislaby@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	John Johansen <john.johansen@canonical.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] Landlock signal scope and TIOCSIG
Message-ID: <20260914.239dc75285d2@gnoack.org>
References: <20260913221958.839429-1-clusk@northecho.dev>
 <20260914.b8a029f9abb8@gnoack.org>
 <20260914134013.1457130-1-clusk@northecho.dev>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260914134013.1457130-1-clusk@northecho.dev>

Hello!

On Mon, Sep 14, 2026 at 09:40:13AM -0400, Christopher Lusk wrote:
> Your capability framing convinces me.  Controlling who may attach to (or
> open a master for) the PTY is the right layer, and the master FD is best
> thought of as the capability, the same way socketpair() is.
> 
> You are also right that the series is incomplete as a fix: the same three
> signals arrive through the n_tty control-character path (Ctrl-C / Ctrl-\ /
> Ctrl-Z) that my patch does not touch, and PTYs additionally raise SIGWINCH,
> SIGHUP and SIGCONT.  That reinforces your point rather than mine.  Chasing
> individual signal-delivery paths inside the TTY layer is the wrong layer,
> and a per-ioctl hook would only paper over one entry into a mechanism that
> is working as designed.
>
> One question, mostly so I have the line right in my own notes rather than
> to relitigate: how do you see this relative to the SIGIO/fowner path that
> 4b80320ca7ed brought under SCOPE_SIGNAL?  My read of the distinction is
> that in the SIGIO case the sandboxed process unilaterally selects the target
> by arming the owner, whereas here the recipients have voluntarily attached
> to the terminal and the TTY driver delivers job-control signals over that
> attachment.  If that is the intended boundary, it is a clean one, and I am
> happy to treat TTY-driven signals as outside the guarantee.

Yes, that is the difference why SIGIO had to be protected -- in the
SIGIO case, it was the already landlocked process which could itself
select the signal recipients through fcntl(fd, F_SETOWN, ...).

In the terminal case, it is the TTY-client-side processes that select
which processes are attached to the terminal.  With the PTY master FD
alone, it is not possible to signal processes that aren't already
attached to the terminal.


> If it is useful, I would be glad to send a small documentation patch making
> that explicit: a note in the SCOPE_SIGNAL / IPC-scoping section of
> landlock.rst that TTY-driver signal delivery (TIOCSIG and the
> control-character path) is not mediated by SCOPE_SIGNAL, with the practical
> guidance to control PTY attachment instead.  I will drop the task_kill
> approach.

Thank you, I would appreciate that!

Thanks,
–Günther
