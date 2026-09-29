Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AA43D0BE4
	for <linux-serial@vger.kernel.org>; Tue, 29 Sep 2026 12:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790686377; cv=none; b=UnHqa5/7m9oy0jx1m8tH8tYsCRO+E69UkFvj3uLRdtWhK9HU19tqkdH69s/N6w+55TAgDnXvAyaImpFgUEgWEHjoaWnFQCDYh8QUk3pN6+C25RCZpW27m23IjmdWeMJixma4gq+rftAMKeWP9N8DlGclq7VxJbuOdimDsP9lZJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790686377; c=relaxed/simple;
	bh=P/c1snDOFgpdovNskKlCF1xc096CVenS9d1WfWHBJtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MuzLpD+hLStjYPx7Dy6GPr2MRJvL91P5MsIGykivEN7Ft1MPYz/2yihP0+EXQReL6m0sMplYWYLphfUCXd4/me8RE10njWZYwElecrpFTytTQurNqFWoInVN6bY4rYVRKXPZtbVTh1RA/quvGvepuEQQFfytVOaeH7rDsV5TbDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ShcHyj78; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ShcHyj78"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e71cdb22bso30827185e9.2
        for <linux-serial@vger.kernel.org>; Tue, 29 Sep 2026 05:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790686374; x=1791291174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mgpBdFFJVnb1Jele4m29rAnxkAAsd/6RdwPNkfN1m4A=;
        b=ShcHyj78eggNffKiedGoHhzNrwjPeiNjEkOSbD4XNWi+GmZglmeyd+W7Abqh72i38+
         S+0/J4avgduQGPudQXlCwSX2twdmXFNaQnkJteD08CecCNosgd6BXN6RFR7RWD1BrMuo
         W7PjTc/ymqL77Rzma494CZcjqy8Jd+XwnhKemXjjqviWIgiKwA4ovtU/wBC5dtexpQ0e
         CrO0INGrd9vTHD2xTvhvWKPmGLigJ2wBW38t8Pfq+66jvC6M7b4UOXOx7ZJn12xFMGPd
         mKB0NN9q1c5EdvgcDNWOgha6VJ/211ZJqUSB3Q0QgK8iyo+6k4nFOuFhu/HS7mjcBCFt
         r4Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790686374; x=1791291174;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mgpBdFFJVnb1Jele4m29rAnxkAAsd/6RdwPNkfN1m4A=;
        b=U1tNkKzZNfTLhDqe5WrNPLRd5AllbHqmoOftpHPpVsunaIGp9Ix8pnWx/iQhRs04Fp
         y3m5UqLfQMNiUnC8eve1Xx1rgq/+Vfs3HMAslQg4kH11P8+TeyPuzlYfCnlprqgYnFtJ
         pY/f8AwyfJAJhCfE80Z1ViWk5K3+uqG2lpQJwd5/p2ovM5cJKoFsUr6vgI3BZ9833Ggl
         Cagzfz/8wx0Y7ZrS+z/AJItMO93fgwcsiwf8vXEhiioEJWnkQ+9/vcjsRL56UmS0sXF5
         N50JvfTNrXq1dMxuIMa71Y+C/538yUw3Nav7lAwY9Ku6QfQBKW/ADtnHng69RgbHf9DH
         VtLA==
X-Forwarded-Encrypted: i=1; AKwUvBwWvOQRAxz0mknQia9t+guDdTw+HVsjp4R7epBCL7CNeoVN0XR7C0CDyAzmJ+aw8udZ3cNCvEV1r+Y+5VI=@vger.kernel.org
X-Gm-Message-State: AFuF++kpktNuo2+lzKTHFvbh2Qrz/8zzfR8sfFG9yqqjtdoga2mhSmiy
	/yVN2aguao44eZ0V15RqNn7tfiP8lRnb01+9Yrj5imo2RvUW7KJB3xmMK+R71pwPUHw=
X-Gm-Gg: AYBFou0gLHQSKGQ21soxh/VY28RaP87ZkSgm+fKC8nZzgG1QyfPeJweqAD4VP/4zuql
	nb+2j6XVbNnzGrCa0UZnpQaEI2zyfg9gZ67YYKCwvs6SKefxLNQqHW201H5rHur1C+mRNB2D3HM
	g+HpYE6JtDDK+2j804Xl/FYtJ60THwZS3a6RxKPwB1nh7EBttUymOrOrVSM2PolntxQ78TNjUzJ
	ZFBe8fdGUCHFHlcMDLx70tDvtWtFNi/mHoXuHBL+ToUJSzT2M1hSV5qVYvRpSAXqaNDrhhTEV73
	pLqALBNvzXqIqpmpv/IoIwwMZGx+93NwiF1+LLQDRxoZ8Q8yn+llkCtjoFasm4Pb0AbFFV69Fco
	DT2EySdc8Soz5QnUIEJjRzIQxYo0jg5LAKR4/jZWKgFWldKFdKg9RUtvgo9tSycLJ50f0iyxYiw
	hLtorgdSplo9832uOHp3wuB/Pycr4XheQ7PdAtwfKMrURG1jfylufjEkhFnvZZm8Hf6uyzI617C
	bSoU6Vg4tINTIU=
X-Received: by 2002:a05:600c:a09:b0:49f:bcce:13f5 with SMTP id 5b1f17b1804b1-4a0099c361cmr63999585e9.24.1790686373920;
        Tue, 29 Sep 2026 05:52:53 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00d0f66cfsm88772945e9.14.2026.09.29.05.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 05:52:53 -0700 (PDT)
Date: Tue, 29 Sep 2026 14:52:51 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Fushuai Wang <wangfushuai@baidu.com>, Kees Cook <kees@kernel.org>,
	Stepan Ionichev <sozdayvek@gmail.com>, linux-serial@vger.kernel.org,
	Manuel Lauss <manuel.lauss@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] braille: nbcon: Allow using a serial driver
 converted to nbcon API as a Braille console
Message-ID: <aru0o0G-YpgGa7pp@pathway.suse.cz>
References: <20260922072558.98854-1-pmladek@suse.com>
 <87ik3tiim7.fsf@jogness.linutronix.de>
 <araAvkIB5XatHPNk@pathway.suse.cz>
 <87a4p5iejg.fsf@jogness.linutronix.de>
 <araJ-EBntyqOGPkT@pathway.suse.cz>
 <877bk9id6f.fsf@jogness.linutronix.de>
 <araWJhKdVZnfCQcg@pathway.suse.cz>
 <87ld8pp2wq.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ld8pp2wq.fsf@jogness.linutronix.de>

On Fri 2026-09-25 21:11:41, John Ogness wrote:
> On 2026-09-25, Petr Mladek <pmladek@suse.com> wrote:
> > I used on the command line:
> >
> > 	console=brl,ttyS0,115200 console=tty0
> >
> > The serial console driver is not in console_list. But it shows
> > all printk() messages because tty0 is in console_list and
> > the messages are shown there.
> 
> Got it. So from the perspective of printk() we have a legacy
> console. The legacy console is (mis)using the write callback of a
> console driver to write to the underlying device. And since the driver
> for the underlying device is NBCON, these contexts do not match. But
> actually it is more complicated than that, because the console driver
> callback is being used for all vt updates, not just those from printk().

Yes. This looks like a good description of the situation.

> Since the 8250 driver (and so far all NBCON UART drivers) use the port
> lock for the ->device_lock() callback, it would be enough to do:
> 
> 	con->device_lock();
> 	con->write_thread();
> 	con->device_unlock();

I'll play with this and use it in v3 when the code looks reasonable.
I'll try to get the nbcon context as well. It will be for !PREEMPT_RT anyway.

> if it is NBCON. That would at least provide proper locking (port lock)
> for the underlying device during runtime. The only downside is that
> panic could deadlock if the panic occurred while a CPU is holding the
> port lock.

Yup, we would need some special handling in panic and rely just on
the nbcon context.

Best Regards,
Petr
