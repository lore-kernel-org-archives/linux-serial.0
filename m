Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDF01C6FE1
	for <linux-serial@vger.kernel.org>; Wed,  5 Mar 2025 08:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741163777; cv=none; b=lrDEUy+LoA8MjAEaVm1aJ7SRY7zuz5WqxRCTPYMgW5FvdI46ZnWe72s9aiKWGWQnmSsoDY7p4eI6b0N0jykCnY4CpBcNgLLppemzO6ToWYeKz689IB0AOUwaOiBUbGXvSVsbiRO2IEX/MkGzjTBhSpcxOtsHsNH/ebwd5yOnrmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741163777; c=relaxed/simple;
	bh=tclfnaQ+78uJUqE4m2J8GwrNwDst3SKOWGjXQTac2LE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6ITxUPma2Wo6XpGatgrQawAJulbaCyRjMzqLUF6D+dIgLDpHqW5VubWf0BFd0KZNUjQVHN2XhhRGw/TepMoF7PVtePVdGLNgqnDt91taLAVQ0pm7afQ8lWXZY95w3OJBwSW/pTJP+keUmHH1nhy1yUS2CydAjohHjfG6a1HeT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mRucgZbg; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mRucgZbg"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-390eb7c1024so3767524f8f.0
        for <linux-serial@vger.kernel.org>; Wed, 05 Mar 2025 00:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741163774; x=1741768574; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfQXwUL3Ydz7mR+cjRUeO/xqWRGS7uJqxxJMkaNfgT0=;
        b=mRucgZbgodwpnJ/LEwx6AquTZQHVsPy5Wt7PkYj3/3iuVXlzlfYtpsV5C2wYRBmbjw
         3EoNk2BCWG1GAhSntBmEettOHYWTw2qcwjQFFgUL1MBd4YosDoTysLdpXDjaGw4dS5/N
         Afz6ZJnF3JarVvhJSD/cRh7RFuYL7ulENxsauISFdD0pBKnaBVNiVDZ1LdAb5/NKn++B
         5iWGnQFlmfBbr4Dr/jZayWeKdN15hWB7yQvny/iE3hdmhtMSsRKqZKIQU6aD7hHmimWU
         5BgNaV21Aa7Kck9JS9G6E/zL3yh/A8g5Gr1dvG6j87h9dCZniNs542brkWusvVD9JHQo
         W0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741163774; x=1741768574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfQXwUL3Ydz7mR+cjRUeO/xqWRGS7uJqxxJMkaNfgT0=;
        b=DJmvZxSAKHTtSWbrsmf/Wc48P/uKAAdCUU96rUpCHRMLMsgKBb0KqfDC+qf17yQzuW
         Z6ViTngXqe0lf88ayFCno+DBTPGQAFimhoOfenbNIWHJxSTG8bklqexq1FPyIz33Q+bI
         N6HTu1fj2YyeYqOewv7qHO9lsGeTpOuDKsnR9jq3g3DDuMG77P+Y8tH43kofWfWTIzLm
         o4Czzswn3s398kfpL9TQbmKfTGfZ4KNScR+sJ6Zt+WnmecghW6ZTedpV3LQT8nxTxqM+
         jl2V14URtEexab/gpg7Fe6vsWBBKvjZ5bPIHTO4QczfhDEVBmeQNXspTwzMDhX7kICoi
         A+qA==
X-Forwarded-Encrypted: i=1; AJvYcCVFzEVn/2nFblKQttuAr2cwxiLIInqsWKVd5/JvWSHL839IuHS1q1svccqt+APM0F70OzKQIrUuZID+5Jk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJmgnGg/ubvyJTd6A6iU/HMD/EQRZfL3vLgq4zaRfFo87oX0SZ
	eee1Y5Tl6A0UHlYjiY978WBsVmSkEDaMNEPaUwXN1ZOQNqJmXhejJc6cY2i4gss=
X-Gm-Gg: ASbGncsi463pO+FB3eZjwO9UwnDvJdH21livNYCfiSxFFe343MFwp4c8ayM8d6wL3k/
	wbZrKtnbE6HGu+LPlNi0taOrEjQF95LTiVcATftDTr6ixkmweDbHpJ3lSfTjQ6w/pPYsUg/sUbx
	AK+phxMj4NLXE/i//uzrpu9OfloNtEZeIa4TDlZECYdi9XYRIpzB+2tkQ4YeSk/g9Xlz6RM7RsX
	5iFG4bjMvmK0o/Q/sM+AFFPs1RNrvnny7BMi5t2cnzISRulxFnkp0d9m10Nf27SsPgiSZZbplYk
	PAk/+OLxsb9JzyLMBAGGikejEw5sP49J9b4c6aDLo+xSsrn4qg==
X-Google-Smtp-Source: AGHT+IG1TdRy5Kvu8p1cmT5U4TYJbrUoCcVGa1tX1dkQIqW9WiR2lgUQPgvjP/3zB9IzHIHCvQwYww==
X-Received: by 2002:a05:6000:184c:b0:391:23de:b1b4 with SMTP id ffacd0b85a97d-39123deb51dmr497486f8f.45.1741163774150;
        Wed, 05 Mar 2025 00:36:14 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-390e479608fsm20564933f8f.14.2025.03.05.00.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 00:36:13 -0800 (PST)
Date: Wed, 5 Mar 2025 11:36:10 +0300
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
Message-ID: <f76a48fe-09da-41e0-be2e-e7f1b939b7e3@stanley.mountain>
References: <20250304092417.2873893-1-elver@google.com>
 <20250304092417.2873893-2-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304092417.2873893-2-elver@google.com>

On Tue, Mar 04, 2025 at 10:21:00AM +0100, Marco Elver wrote:
> +#ifndef _LINUX_COMPILER_CAPABILITY_ANALYSIS_H
> +#define _LINUX_COMPILER_CAPABILITY_ANALYSIS_H
> +
> +#ifdef __CHECKER__
> +
> +/* Sparse context/lock checking support. */
> +# define __must_hold(x)		__attribute__((context(x,1,1)))
> +# define __acquires(x)		__attribute__((context(x,0,1)))
> +# define __cond_acquires(x)	__attribute__((context(x,0,-1)))
> +# define __releases(x)		__attribute__((context(x,1,0)))
> +# define __acquire(x)		__context__(x,1)
> +# define __release(x)		__context__(x,-1)
> +# define __cond_lock(x, c)	((c) ? ({ __acquire(x); 1; }) : 0)
> +

The other thing you might want to annotate is ww_mutex_destroy().

I'm happy about the new __guarded_by annotation.

regards,
dan carpenter

