Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9978C3E3151
	for <linux-serial@vger.kernel.org>; Fri,  2 Oct 2026 08:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790931057; cv=none; b=c3I5Xy+2W2T67tpM9nVuUQh7WpqTXeLIs2TVj+a+TCAAErjI63dgtAfzQbXtvNraRYOPEdq68DS7KQZnzAMvk9PdgMtoj2UFpoCj7cmAqlTxG2hbpK02/bUixtLjuoZJXid2MFyp1CBUbpEejHe0ENaEGxWBQxZdRBvYffBa0GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790931057; c=relaxed/simple;
	bh=wXoGcISl/oRmRKOslUtroVSQBceFYYnhGvTBcOJf+bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dn3nHyKOrmk52cZS57T4+Re3iz8tOc44Hkdm7Zqs//f/SNWJr7F4BxlqnrfgO4HYnE+l3FtY73zfmVY1NF9g+VMeok1MrAZ3BTAnwqLdzO0pQBHyYcrI9CisftkGYEfhatgsGjkl2o9LPdGQaiiRoBmF+s8LCC3C+M3Hj+RkMo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GQT38/Lp; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GQT38/Lp"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e69b9e16aso76231135e9.1
        for <linux-serial@vger.kernel.org>; Fri, 02 Oct 2026 01:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790931053; x=1791535853; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KwGPT/StOmJlxWR4s0ZZvZS4zacF6jCq3vcOkQeznls=;
        b=GQT38/LpIQo3eAZD3JOUQkNsquiIejB4hi8nUr0uHKakR9NgQPwBTtevPYgVcSUUTV
         F7ZBRsbMDa/VJdn2fq3dbQ+ycGUVjXI5f9yGY94yN6eaCzrlQe1TSDQxy02psjoLVe3+
         DE41TRT6v2ftelSVC8imjusKr39nSlq0rNwQO101GMhpIoVY7FckTG1E8fLb2inHRRQa
         TgnJd1E0w80tk8JxKHi/gzYmVZBr5rFkG9KttSDTvpOfKWGOOQCoTHy3qhA4J7BtrPwM
         zQPPWEtTg0tPSrh96cHMtdbITwxyEw0Qb01YaH3d+qMlSZmje3bn0O/IViUhIF7fkqqM
         TgMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790931053; x=1791535853;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KwGPT/StOmJlxWR4s0ZZvZS4zacF6jCq3vcOkQeznls=;
        b=WA0Mg5EpVQ8PFVyrG/ETxK1mUZAvV/koG7Rsol2FR76ngj+1TQ3H2Ib1YaCwRFqzQd
         f/AQR3JWD2B3JWy1Y9IoBaWbx7LrLfLOV1VVIplr6s8NhEiAJPOYXgfLRHcH+mC7ryvu
         AO2nL4WyPqbWgib/UpMzCMRB6x88XRhxQX99vSnESEXf82pOCZTHPK8mSqtdl8ks4kPT
         0Uup6VVp4RLxuiWfzaD8QdvUbuEjwa6I+PdAekO54Ljci9rhngLZZ3MdsxCmAmLi1Qbj
         HkoYGqEt5h8dZBIh/f+kBNvrN0EXrEoHW2I6+y8ucW0Jqh39SrAAK4ZqO3BQAJ9gZt7G
         pw9A==
X-Forwarded-Encrypted: i=1; AKwUvBw91DzLhCsScXgRjoNbOc8FdcG9u+hgOEVWWqPqXj9QIn3tSMbMtyJUmPWSclQZDolZwyqpdGyoe1wXSrI=@vger.kernel.org
X-Gm-Message-State: AFuF++m+SrqYmS7IfkTAGfw63Y2GmNdEvc3euNTYPO52QoFkD9G0hZLy
	z7TikEWrzbYtiHEJ//ZgQZB/DjyS37BPkkUoB4T9cfTJSU8mS66Byw/D1vdrPhlBtjU=
X-Gm-Gg: AYBFou3iyLrHppzkt+25wJ5MkxHDWg8wZnKABT+TubTdCTG5DjR69GKj7cH0oSQ9faf
	YUc+dAWzjPDsSvWai6h6u2tz2C4b4huA1enVX6JRfS+padD40TNNarhuQeVKPouookakCKQNAWg
	w9wvzOBv3knvs3zocIpKwUah7YOi6otzNJvHBsIFt7a+xA3dEVZVoYK+ri0fK1lrWoWdix8ireL
	SkqYlVnV6cKAuykaKKCozBKfEetUM6KLsAFo5N8AjjKi/ez22KV1grE9c8sdoDelJsb/hN4mUJe
	nnhVsd8k00FNT3Maw6VJ+MP7ByAyZ096WgJrMHmKUPD1bsvOfaJXycT2JgKYX4EoEgY5uMDHIrY
	W0CiDKiedMYGy1lf23nLPqWVaMNYTbHyIhtsyjdPeozXkNxkRHdFqQH0MiP+Y+PgUo+cYcCx+cm
	ZyoSbgfgCDJwKoJA5uWxqiWR3ODMQS/CIJ/qz/kj4VlH6P3vh0vrboj0tgCabsmg3olADOnFx6
X-Received: by 2002:a05:600c:608c:b0:4a0:20fa:603f with SMTP id 5b1f17b1804b1-4a02758e4e1mr35166675e9.17.1790931052807;
        Fri, 02 Oct 2026 01:50:52 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a03ff56136sm21502925e9.3.2026.10.02.01.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 01:50:52 -0700 (PDT)
Date: Fri, 2 Oct 2026 10:50:49 +0200
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
Subject: Re: [PATCH v4 1/1] braille: nbcon: Allow to use a serial console
 with NBCON API as Braille console
Message-ID: <ar9wacP7FGkiKFXp@pathway.suse.cz>
References: <20261001140727.124398-1-pmladek@suse.com>
 <20261001140727.124398-2-pmladek@suse.com>
 <87h5j58mj2.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h5j58mj2.fsf@jogness.linutronix.de>

On Thu 2026-10-01 17:38:01, John Ogness wrote:
> On 2026-10-01, Petr Mladek <pmladek@suse.com> wrote:
> > The Braille console is not registered in console_list. Instead, it is
> > integrated with the virtual terminal (VT) and shows what is displayed
> > on the terminal. It writes the data using con->write*() callback
> > of the associated serial console driver.
> >
> > braille_write() is called from the VT code under console_lock().
> > The associated serial console driver can be converted to the NBCON API
> > though. The situation is similar to flushing nbcon consoles in the legacy
> > loop when some boot consoles are still registered, see
> > nbcon_legacy_emit_next_record().
> >
> > But there is a big difference though. braille_write() is not directly
> > called from the code paths flushing registered consoles. The VT code
> > expects that braille_write() succeeds. It does not replay the message
> > when it can't acquire the ownership. As a result, braille_write():
> >
> >   + must try harder to get the ownership.
> >
> >   + has to be synchronized only against non-printk serial console
> >     which depend nbcon_device_try_acquire() using NBCON_PRIO_NORMAL.
> >
> > Let's look at it from another side and try to simulate the original
> > locking using the NBCON API:
> >
> >   1. Take con->device_lock(), aka the port->lock in the legacy serial
> >      console driver.
> >
> >   2. Acquire nbcon context to provide some synchronization for a panic()
> >      context. Use NBCON_PRIO_NORMAL because it contends only with
> >      nbcon_device_try_acquire() users. Do it in a busy loop. It should
> >      always succeed when con->device_lock() succeeded because all other
> >      users do the same. The only exception is when the context get acquired
> >      by a CPU handling panic.
> >
> >   3. In panic, disable interrupts and try to acquire the nbcon context.
> >      Use NBCON_PRIO_PANIC. And try even an unsafe takeover because
> >      otherwise the Braille console won't see the text shown during panic().
> >      It is similar to the oops_in_progress/trylock handling in the legacy
> >      serial console driver.
> >
> > Finally, avoid the newline prepending logic in the existing serial console
> > drivers when they are used as a Braille console. As explained above,
> > the Braille console shows the last modified line on the terminal (VT).
> > braille_write() is called when single characters are added. Most
> > messages are not ended by newline. Anyway, the VT code does not have
> > logic to reply partially printed messages.
> >
> > Fixes: 13189fa73afa ("printk: nbcon: Rely on kthreads for normal operation")
> > Signed-off-by: Petr Mladek <pmladek@suse.com>
> 
> Minor comments follow, but no need to send a v5 for them. You could fix
> them up on your own.
> 
> Reviewed-by: John Ogness <john.ogness@linutronix.de>

Thanks a lot for the review.

I have updated the patch as you suggested and committed it into
printk/linux.git, branch for-7.3-hotfix, see
https://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git/commit/?id=c83e3d2912432107148cc5e288ddd153a84c0f43

It should be good enough for 7.3. And I wanted to get it into
linux-next ASAP.

There is still an open problem with the dependency on CONFIG_PRINTK
to fix the Sashiko complains. We might add it as a separate patch.
But we might also try to fix it properly by enabling nbcon.c code
even when CONFIG_PRINTK is disabled, ...

Best Regards,
Petr
