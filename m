Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CD02045AC
	for <linux-serial@vger.kernel.org>; Wed,  5 Mar 2025 09:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741166834; cv=none; b=HyRI+jiZWWykiLpOPjez7WCcgh+MHiAhLAiO12CBEr38sGzcmTz+gdq4aXcw3wx19WCAAux4VAWWSi8HYYKp+qoRQNg384HseVy4z+zcwVspX6Htn6TzvHhpdrk+w1Y9Bg9HjIVaz2/ifxul3VnqDYVQayB489YSHbrVGJ3wceU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741166834; c=relaxed/simple;
	bh=3mDFeB3Bpj3IOfRwlQRf3Grj75HR3nrndwXyWmM3Ob4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=owz2NcIo5T9/lQxzN53apIWESTSeyHf87QPFwhb/WarrRRldbqXw+5bS/HbabHNoGTkoykvtIhM/wrtCzpfaT0ok21BM70DRbHAFUhrab0TO/T88o9mUoLFa9IybRoeHRSj/qoM+wQtbhZPEs+A+QAKoJfy4xGfyGzzg6AyRe4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=awQ2WJus; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="awQ2WJus"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43bc4b1603fso19208345e9.0
        for <linux-serial@vger.kernel.org>; Wed, 05 Mar 2025 01:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741166829; x=1741771629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VaMa3tOr/8WS8V6AnlLw/eUNgZqrJVmxSDme9KtSQnA=;
        b=awQ2WJusxW6Ge0kv9C7Zju2JITr5EXSeephgcSpgRUB67uiBC2wUReZa/SrihqlmBV
         zMms2er4oICT6Quz/tBnkW/bMaNIjXMdxymm2mdhR9xfSuxVKM9ONClD/eluuDgTAG9Z
         cSTRS5qBoAatCwOyBW6idxIRVSxCnO+pKzcmP7MQ0TPj3qdmkaBJ8Q/LWpx+Y/szwxxZ
         LJpMWsH3PAH+QZGkJAJa1GPJ2b+1Y75T/DTdOUHiHu9jDRkjLhakyxdJWPiRbV2Wn6jw
         PqJzVJnpSRn6f7FKJcb4MvkK/ygd88eqJXzL8DmZTvV5KzE9q14qcQvpm1uWSxpYfF86
         iw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741166829; x=1741771629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VaMa3tOr/8WS8V6AnlLw/eUNgZqrJVmxSDme9KtSQnA=;
        b=elvFJmMRPaxE8kq8DRtSHgO87NNs9EW/lS3L0fUY1fW6BvbZ5Ngn6/+EhFtlFVeEIe
         82qgyCycojpJlAJiJE4smESELBwhfYPsdfg3PIPWz1yDRyDMlMp+fbFoIt9PdhBA5Nt4
         TVibOqhhvcfYyJw3VZ+Wd01On4YiRhSHDFEIdy1i7jvS+iq9/cLqeS/DXVUsLZZNXYx6
         l5PvPneyu0SeXGISEoBuZq7jcnfOKotIkidi9h0Sk2n3gBwKTdMmDUHTCvQg8p3xhX6x
         ZC2h3urHHlouwQlleMZqgBDJ63ghbHMzKJBSm4l3D/qIf1NKWJh1rG0OffVJbMix6e/Q
         Dhiw==
X-Forwarded-Encrypted: i=1; AJvYcCXAoiNCbQzAHHGox1hF909cL0imPVD+I7LhjcuqKYGIocvC/XhCP8JCF/dY8+dKUVjhzJdi37Yi4txXoK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDu56u84vkxh55ftggrcfT3YB8UrgKjevBnM+74w9sdWJeiO4J
	2oK+Ddp3+UczKhE3wP8Y/p00FwMeYW7I3jlb629+66jmwTcGPySlB1jZ/32l/qo=
X-Gm-Gg: ASbGncuwCWeAaFLAf0//9Xpu5RHN0Rma0cLrmhFeEEA2q/GS0lx/027j/HmjkSfDTiz
	96SkZUkLXFfZwKl8YMmixHef9LJAG/VXBK9B+f1VbZwRWSMBGFE8CxjgiLW9geQARZmVnhLxbm3
	+fHgl2UpdwmHMyQWxx/Nukzgr7R2WOgBXEmpPQR8NwK5oxgpunLgwKQPankKaqq7wTTO7lVAqS9
	nV36ilHnyD20urvlfPhFRWTwpXHCFeHyafKDZzTQMEAV7Oiq/99fof0nIYhNAqND5mrel/xuy0Y
	qvHtpuXBtEFMGxRVYQOP3VnDu/S7d9dZ8WLlRhOeARGpyDXwDw==
X-Google-Smtp-Source: AGHT+IE3mizAOsnSuTtcbkO82OvTIYaM5IjOsyfCaEaBUlwqBcpm21mf2Z2/NNT65xir9k5CCr442Q==
X-Received: by 2002:a05:600c:4750:b0:439:9e8b:228e with SMTP id 5b1f17b1804b1-43bd29c42c8mr13412085e9.20.1741166829098;
        Wed, 05 Mar 2025 01:27:09 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43bd426d069sm11942015e9.3.2025.03.05.01.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 01:27:08 -0800 (PST)
Date: Wed, 5 Mar 2025 12:27:04 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Marco Elver <elver@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Arnd Bergmann <arnd@arndb.de>, Bart Van Assche <bvanassche@acm.org>,
	Bill Wendling <morbo@google.com>, Boqun Feng <boqun.feng@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ingo Molnar <mingo@kernel.org>, Jann Horn <jannh@google.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
	Kentaro Takeda <takedakn@nttdata.co.jp>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, rcu@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 01/34] compiler_types: Move lock checking attributes
 to compiler-capability-analysis.h
Message-ID: <b6af185f-0109-4f98-a2d7-ab8f716e21a5@stanley.mountain>
References: <20250304092417.2873893-1-elver@google.com>
 <20250304092417.2873893-2-elver@google.com>
 <f76a48fe-09da-41e0-be2e-e7f1b939b7e3@stanley.mountain>
 <Z8gVyLIU71Fg1QWK@elver.google.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8gVyLIU71Fg1QWK@elver.google.com>

On Wed, Mar 05, 2025 at 10:13:44AM +0100, Marco Elver wrote:
> On Wed, Mar 05, 2025 at 11:36AM +0300, Dan Carpenter wrote:
> > On Tue, Mar 04, 2025 at 10:21:00AM +0100, Marco Elver wrote:
> > > +#ifndef _LINUX_COMPILER_CAPABILITY_ANALYSIS_H
> > > +#define _LINUX_COMPILER_CAPABILITY_ANALYSIS_H
> > > +
> > > +#ifdef __CHECKER__
> > > +
> > > +/* Sparse context/lock checking support. */
> > > +# define __must_hold(x)		__attribute__((context(x,1,1)))
> > > +# define __acquires(x)		__attribute__((context(x,0,1)))
> > > +# define __cond_acquires(x)	__attribute__((context(x,0,-1)))
> > > +# define __releases(x)		__attribute__((context(x,1,0)))
> > > +# define __acquire(x)		__context__(x,1)
> > > +# define __release(x)		__context__(x,-1)
> > > +# define __cond_lock(x, c)	((c) ? ({ __acquire(x); 1; }) : 0)
> > > +
> > 
> > The other thing you might want to annotate is ww_mutex_destroy().
> 
> We can add an annotation to check the lock is not held:
> 

Sorry, my email was bad.

I haven't actually tried your patch at all.  I have locking check in
Smatch so I'm just basing this on the things that I did...
https://github.com/error27/smatch/blob/master/smatch_locking.c
This isn't a mandatory thing.  Whatever happens we're going to end up
doing dozens of patches all over the kernel later.

I thought you could destroy a mutex regardless or whether it was held
or not.  I was getting false positives which said that we should drop
the lock on error but actually the mutex is destroyed on that path so it
doesn't matter.

regards,
dan carpenter

