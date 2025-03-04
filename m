Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DE81FF61E
	for <linux-serial@vger.kernel.org>; Tue,  4 Mar 2025 11:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741088635; cv=none; b=rJp5O1wQR7EaW9AVGR/XhK97aB4mmqLOEaGSxZuQ1+10rmY68J9l603HAcZ1dlAqZean2OcnqRpOr8U8VHPZwm+gsMVCm3zYR3AX0pNuZuOen/y9i409EHQku42V4VI80u2DG616FtlzscaTVA1eTbK4bzgOZCPm2e1rRUOcRUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741088635; c=relaxed/simple;
	bh=7JMGCeJF/Dp3pl5kzpMvrUbvwzv+GjyKlzt033ZLbrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JyIqcV+lN1RUL2+VPDpHNMkC1FV9PcWMZ33KvFqasbGDfUgM1MBdv7vONZwIoeyLDNmzHTzuhLabGNtk0DpLqjQ9gFIZWPhMo0O+mYM4uNq5ZNCVTVAJgLTy3WNRsEpLxKXldieRjcXChu6Z1ELH9ivQHUDX6ciX2T8KSanohAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vRw1+VEA; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vRw1+VEA"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22382657540so54680735ad.2
        for <linux-serial@vger.kernel.org>; Tue, 04 Mar 2025 03:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741088633; x=1741693433; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QR5Fe2yNdtUQN8MYBySGOzmABqc40NGzK767K+eex7I=;
        b=vRw1+VEAt4PRU3DtY9BxsLnStXiAXNOfV90ci4wjIKGuhoSBuH4MFSbK46UhUXb1Vb
         TMxvBaJYaQ6H7RdAaVca8BaFQloCSWXsk3yjbL1Z+tGkihJszaZ6IvMTBxHI1oULOCi+
         8ODVdWAzTUTrlOJB/f00hKvFqNAZ+lT/lrG5aYjKnx+AJ9zcAIZIWIztaiRXizmG4u7w
         RdA1uO92AMD23sXxsQP4ufauZ60qCFHuRgFwosnGOjs+rPsegvul1OZnuh5nyRHsMIV9
         iwqmqxAqeuMyz4AUWWTz1AJnOPsWvb14n8C6RaMKOpBZg1Trj3bwfYv7q+CnlQVzU2Ju
         m18w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741088633; x=1741693433;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QR5Fe2yNdtUQN8MYBySGOzmABqc40NGzK767K+eex7I=;
        b=G0K9qBNLi46jSbCVKQHs2+JYGUAkvNdAyuU2I5/UtXTP6A4Etpwf3TFj6c14nmfsmi
         2hrxZTE8wjBOqe5IEP5VuGcqBx80URAP7vfquY0JPBtCwLh7h4cdEtmdglF3sqC2waFF
         juTs/QLSZn54+JvkdIYAclzuN4xYt11hq9pr+Xg/peKi9g3Ovzko0a/Nt8uWLtmiHqmv
         4vGWk2XWGNOAcIff8rUqgw/cIkGicplFyk7iQ3TSeBqyeNl+7QgmeRf9u/H2OojO7HK+
         WvpYtZNJk7GJ7ORZnq3inBAQwloyByO9UbtxILpt5G5lJQFSRu+UmI1Cx/msXfKnhjD1
         7doQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4sl6J7MZIPLkM0ZWUwYbWe/RjFSdyy/xhtar7G9eT/Ba6ZMnUUfma9jWGqwln937PEyR/JDmJVaCRyiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpenEXrE1QDh6rIOqqIe0PZrJkN6CRTHiXlZQOOXkhaFqfDVaG
	uWQ3/NKdK0LFxmaZg+RnDk7LlhvxCwgSVB9NYtIn1zlSZO7D/a7ov2uQTwizFlJil1aFqDPNI9p
	Xu2xuIy0Jq7VnIAfExT1ls917moGn9bgMcBqL
X-Gm-Gg: ASbGnctRSi7z6yW7S8q1iYKGKwR6/9ecZFhlWnZtkj4ArcJUDy74c8hSJCXI8T7DOpR
	KOWVJJe6CrZ4F/QMhRo0+mIiukKEIV11fPB2FTjYv76UxskPZcVaeAy0SC147ONuvSM3Shn0bIG
	K7WBOYZvnkgo2Wrjy3TWQ8jW+R8dSgLErTFmc9HSa4lAcxykfseXj78a2Q
X-Google-Smtp-Source: AGHT+IEVXXLrKnpkIy+GQHgCDOyqfRoqXWkok7n4CEJmqUNtrw4OipvJO9eUgzweAGOK6LFHiiUO/kAFxvZ/Vg2r6rk=
X-Received: by 2002:a17:903:17cf:b0:215:89a0:416f with SMTP id
 d9443c01a7336-22368fc97c4mr252442495ad.30.1741088632488; Tue, 04 Mar 2025
 03:43:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304092417.2873893-1-elver@google.com> <20250304112114.GE11590@noisy.programming.kicks-ass.net>
In-Reply-To: <20250304112114.GE11590@noisy.programming.kicks-ass.net>
From: Marco Elver <elver@google.com>
Date: Tue, 4 Mar 2025 12:43:15 +0100
X-Gm-Features: AQ5f1Jq8MTV2B3C5aow9x7Sg78yjoK0kjhHzTC3jNgyCezrqQgZfKxcyrD8i65c
Message-ID: <CANpmjNP6N0d0dnGjDUGLeH4FQ2-G5YAuWrSPp+bvDR==0hYykw@mail.gmail.com>
Subject: Re: [PATCH v2 00/34] Compiler-Based Capability- and Locking-Analysis
To: Peter Zijlstra <peterz@infradead.org>
Cc: "David S. Miller" <davem@davemloft.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Bart Van Assche <bvanassche@acm.org>, Bill Wendling <morbo@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Ingo Molnar <mingo@kernel.org>, 
	Jann Horn <jannh@google.com>, Jiri Slaby <jirislaby@kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Triplett <josh@joshtriplett.org>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <kees@kernel.org>, Kentaro Takeda <takedakn@nttdata.co.jp>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Thomas Gleixner <tglx@linutronix.de>, 
	Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, rcu@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Mar 2025 at 12:21, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Mar 04, 2025 at 10:20:59AM +0100, Marco Elver wrote:
>
> > === Initial Uses ===
> >
> > With this initial series, the following synchronization primitives are
> > supported: `raw_spinlock_t`, `spinlock_t`, `rwlock_t`, `mutex`,
> > `seqlock_t`, `bit_spinlock`, RCU, SRCU (`srcu_struct`), `rw_semaphore`,
> > `local_lock_t`, `ww_mutex`.
>
> Wasn't there a limitation wrt recursion -- specifically RCU is very much
> a recursive lock and TS didn't really fancy that?

Yup, I mentioned that in the rcu patch. Make it more prominent in documentation?

> >   - Rename __var_guarded_by to simply __guarded_by. Initially the idea
> >     was to be explicit about if the variable itself or the pointed-to
> >     data is guarded, but in the long-term, making this shorter might be
> >     better.
> >
> >   - Likewise rename __ref_guarded_by to __pt_guarded_by.
>
> Shorter is better :-)
>
> Anyway; I think I would like to start talking about extensions for these
> asap.
>
> Notably I feel like we should have a means to annotate the rules for
> access/read vs modify/write to a variable.
>
> The obvious case is RCU; where holding RCU is sufficient to read, but
> modification requires a 'real' lock. This is not something that can be
> currently expressed.

It can. It distinguishes between holding shared/read locks and
exclusive/read-write locks.

RCU is is a bit special because we also have rcu_dereference() and
rcu_assign_pointer() and such, but in general if you only hold a
"shared capability" e.g. the RCU read lock only, it won't let you
write to __guarded_by variables. Again, the RCU case is special
because updating RCU-guarded can be done any number of ways, so I had
to make rcu_assign_pointer() a bit more relaxed.

But besides RCU, the distinction between holding a lock exclusively or
shared does what one would expect: holding the lock exclusively lets
you write, and holding it shared only lets you only read a
__guarded_by() member.

> The other is the lock pattern I touched upon the other day, where
> reading is permitted when holding one of two locks, while writing
> requires holding both locks.
>
> Being able to explicitly write that in the __guarded_by() annotations is
> the cleanest way I think.

Simpler forms of this are possible if you stack __guarded_by(): you
must hold both locks exclusively to write, otherwise you can only read
(but must still hold both locks "shared", or "shared"+"exclusive").

The special case regarding "hold lock A -OR- B to read" is problematic
of course - that can be solved by designing lock-wrappers that "fake
acquire" some lock, or we do design some extension. We can go off and
propose something to the Clang maintainers, but I fear that there are
only few cases where we need __guarded_by(A OR B). If you say we need
an extension, then we need a list of requirements that we can go and
design a clear and implementable extension.

In general, yes, the analysis imposes additional constraints, and not
all kernel locking patterns will be expressible (if ever). But a lot
of the "regular" code (drivers!) can be opted in today.

Thanks,
-- Marco
