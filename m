Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48717257D
	for <linux-serial@vger.kernel.org>; Fri,  6 Jun 2025 14:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749218505; cv=none; b=Av2MNWk1h3DpGwN18O3IaSkQHMagABajiArPMyV5BSWbn1wfoK2N5Mtp+8n4Po5G2bTEpGqAPclruhRxpFhdIbZqzPY/QkYVjQ6BuDgHC9FB3FZiGiwVyD7t+HQOSku8g5PxmB10mqTvicT06bFV7IU5/AC/6RNMsFG+DxAD6fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749218505; c=relaxed/simple;
	bh=rj0vvaDgO/aLd5WsYbdQjAEEA10poNkIwgWWwzipZg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zy3drzpO75q/E6DZb46A/CmhucEWycd1bPK2bshXJ4bo03DVzWsG/ZXxiPPkXZxUKvkkwn3FXXborOrVNTR6KdOAAzbX9iQ9MVyOqRG0SJ/9xe9R46gdaq5771LLR40+gX5+CoWEpJPijkBfREJUZwkSE9jhcx3TBqchvYz/jAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SFxVmzhJ; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SFxVmzhJ"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5535652f42cso2210264e87.2
        for <linux-serial@vger.kernel.org>; Fri, 06 Jun 2025 07:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749218501; x=1749823301; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4ePCtVwEHPRZGVKonS4M/PMlbdUQqiCFtEzUovEubhs=;
        b=SFxVmzhJ5rvtsQ4RMfli9aoPt8UiBMOrUDanpbcer7CrFw4YIApN6BuFaFEMKkmt4A
         K3iDzikQKLq4TLTK8HkoqS9oc0Uo9M2F5pGkhetvuyKqHEef3C33wc1609mN4oxFE30F
         +cAY+T828NAq6VvvEedeVw6gfFiQVRYNR6ksHTNIRPwjeMUAftNxFEa+mWqmjBAFr3BJ
         pWlLlQ0nRbWZsTNaSX/tZQqMM1zqOv2UTW2r/tInwIC7P+7uQhXIZKrsLuyH+Iv6qUpt
         W17EsHfYO/11RNOu0bEYKI6nqFrUf5I/K0LJDRnXYY7tOvespyMB9bdRXMhkvVx9jnv6
         NpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749218501; x=1749823301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ePCtVwEHPRZGVKonS4M/PMlbdUQqiCFtEzUovEubhs=;
        b=xMudcviqS0TB/nQY1J2craPjEqDe9xVfDpuqaVf1+7nr0j6pzmO1UsM2DBHhrtqU4E
         +JP3QGc+Z7ZBKnXEfay18Buch8coc7IamRPYZ12mq1U9LN3ISg+JybWv6d2eb5hH41fK
         aCSxIr4XoOAGK8+p3WfXeCehwA0sp6ni1hFf97ccExPqhNg97eOP5otQeyHZVvw9I62w
         32PrY+wn3Txu11VpsPdh4ubUPJN6JtQYSLnw/jDWabu0Ns/zNZgqhX3grE/m9z21FdHr
         i4mC/L6bAJkEca/j1illMqwneh3fPK3TFyxSzPxBDx3+pvqbI2n4xXnAam7cUiPM7GOw
         ZenQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlp8LnWVmEBvpYK+oJn+OHfh5rS64dxf4fdKvu9U42sN7b0S7WtDSwQhM1kd3YmCw1YSwiPccfF1IN6QY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP+nV9i/UJh6x6Nn/fvvEuKu0tKFvF2BH/7OwS8OVG5OUcA66z
	KM+TeaKtV0XUvNCl9wshyf/nY0Fpni2D4SKE6j6+3X3tag105TxQhaP88AvyB6aYu24=
X-Gm-Gg: ASbGnctkgM96sxvt0fnOtmxBORql4ubWnkh/8sr1xLncZa+PsmDbyF72SKHWTuF2tik
	J65N6nrY66B+SDNfjIeBUg8Ac3auGjMdRXiXR9ZvRVhiukyV9GaiSwV9TjwktLyKW2m8FvTdUFl
	EI6JpjJ3WbvnIMChQJBNma6vOh8mNcNDyV21iKWTPP8eWFd+PsR6jd3KSX6icWIdchxHljId3fv
	EomFeyDA0KjEi4gq0oXFFq4iVhd4UDUmD1O80Bre9uqOXHf9Hq94grUcGaEh9LWkjyAdXm2VOEE
	8Mi+QUrBJLCXTLjuox2MmUa9TAk0NlNVCgdK46pzKCm0+FdQsOS3Sg==
X-Google-Smtp-Source: AGHT+IHwM29hXAlfVn1/kynbfpVzyXzOWId8Hf038RYt/WmxD1MOmRXvKQf7F3Df+vqxxDdGzL3yVQ==
X-Received: by 2002:a05:6512:39c4:b0:553:65bc:4243 with SMTP id 2adb3069b0e04-55366be6eddmr1129183e87.16.1749218499894;
        Fri, 06 Jun 2025 07:01:39 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236034065edsm12491225ad.185.2025.06.06.07.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 07:01:39 -0700 (PDT)
Date: Fri, 6 Jun 2025 16:01:25 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: "Toshiyuki Sato (Fujitsu)" <fj6611ie@fujitsu.com>,
	'Michael Kelley' <mhklinux@outlook.com>,
	'Ryo Takakura' <ryotkkr98@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: Problem with nbcon console and amba-pl011 serial port
Message-ID: <aEL0tZgSEhsR9qbf@pathway.suse.cz>
References: <OS7PR01MB13775FE1A20762D1EA4A38D0ED76DA@OS7PR01MB13775.jpnprd01.prod.outlook.com>
 <84y0u95e0j.fsf@jogness.linutronix.de>
 <84plfl5bf1.fsf@jogness.linutronix.de>
 <TY4PR01MB13777674C22721FCD8ACF4FCCD76CA@TY4PR01MB13777.jpnprd01.prod.outlook.com>
 <aEApOPTqbVOR35F_@pathway.suse.cz>
 <84o6v3ohdh.fsf@jogness.linutronix.de>
 <aEBNLMYVUOGzusuR@pathway.suse.cz>
 <TY4PR01MB13777CC92C858572B9C19394FD76FA@TY4PR01MB13777.jpnprd01.prod.outlook.com>
 <aEGeARVcCwqcoHb8@pathway.suse.cz>
 <84frgdcgug.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84frgdcgug.fsf@jogness.linutronix.de>

On Fri 2025-06-06 12:25:35, John Ogness wrote:
> On 2025-06-05, Petr Mladek <pmladek@suse.com> wrote:
> > The question is if it is worth it. Is the clean up really important?
> 
> I must admit that I am not happy about encouraging the proposed solution
> so far

I am not super happy either. But let me play the devil advocate
for a bit longer ;-)

> (i.e. expecting driver authors to create special unsafe code in
> the panic situation).

The "usafe code" sounds too strong to me. The console driver is
supposed to "do nothing" and just leave when nbcon_reacquire() fails.


> It leads down the "hope and pray" path that nbcon
> was designed to fix.

My understanding is that we "hope and pray" to show the messages
on the console. And it should work because the ownership was
lost only in a safe state.

If the ownership was lost in the unsafe state then it might
be even bigger gamble to do anything in parallel.

Of course, another panic priority is to provide a crash dump
or reboot. But it hopefully should not depend on a console
driver clean up.

> What if during non-panic-CPU shutdown, we allow reacquires to succeed
> only for _direct_ acquires? The below diff shows how this could be
> implemented. Since it only supports direct acquires, it does not violate
> any state rules. And also, since it only involves the reacquire, there
> is no ugly battling for console printing between the panic and non-panic
> CPUs.

Interesting idea. I thought a lot about it, see below.


> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index 5b462029d03c1..d58ebdc8170b3 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> diff --git a/kernel/panic.c b/kernel/panic.c
> index b0b9a8bf4560d..8f572630c9f7e 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -304,6 +310,8 @@ static void panic_other_cpus_shutdown(bool crash_kexec)
>  		smp_send_stop();
>  	else
>  		crash_smp_send_stop();
> +
> +	nbcon_panic_allow_reacquire_set(false);
>  }

I have two concerns here:

1. I wonder whether this is reliable enough. It seems that
   smp_send_stop() waits at least 1 sec until the CPUs
   get stopped. But is this enough on virtualized systems?

2. It might increase a risk when CPUs are stopped using NMI.
   The change would allow a non-panic CPU to reacquire the ownership
   and enter _unsafe_ section right before being stopped by NMI.


The 1st problem might be avoided by allowing the reacquire all
the time unless an "unsafe" takeover happened.

The 2nd problem is worse. But allowing the reacquire all the time
might actually help as well.

Note that the information about the "unsafe_takeover" is stored
in struct console so that we even won't need a new global
variable.


>  /**
> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index d60596777d278..d960cb8a05558 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -235,7 +235,8 @@ static void nbcon_seq_try_update(struct nbcon_context *ctxt, u64 new_seq)
>   *			the handover acquire method.
>   */
>  static int nbcon_context_try_acquire_direct(struct nbcon_context *ctxt,
> -					    struct nbcon_state *cur)
> +					    struct nbcon_state *cur,
> +					    bool ignore_other_cpu_in_panic)
>  {
>  	unsigned int cpu = smp_processor_id();
>  	struct console *con = ctxt->console;
> @@ -249,7 +250,7 @@ static int nbcon_context_try_acquire_direct(struct nbcon_context *ctxt,
>  		 * nbcon_waiter_matches(). In particular, the assumption that
>  		 * lower priorities are ignored during panic.
>  		 */
> -		if (other_cpu_in_panic())
> +		if (other_cpu_in_panic() && !ignore_other_cpu_in_panic)

If you agree with allowing the reacquire all the time then I would
rename the parameter to @is_reacquire and do something like:

	if (other_cpu_in_panic() &&
	   (!is_reacquire || cur->unsafe_takeover))

>  			return -EPERM;
>  
>  		if (ctxt->prio <= cur->prio || ctxt->prio <= cur->req_prio)
> @@ -913,7 +920,7 @@ void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt)
>  {
>  	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
>  
> -	while (!nbcon_context_try_acquire(ctxt))
> +	while (!nbcon_context_try_acquire(ctxt, READ_ONCE(nbcon_panic_allow_reacquire)))

And here it would be:

	while (!nbcon_context_try_acquire(ctxt, true))

>  		cpu_relax();
>  
>  	nbcon_write_context_set_buf(wctxt, NULL, 0);


Summary:

I open to give this alternative approach a chance when we allow the
reacquire all the time. It might work well. And it won't require
any special "panic" handling in all console drivers.

Best Regards,
Petr
