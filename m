Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D86D2D8377
	for <linux-serial@vger.kernel.org>; Wed, 14 Jan 2026 08:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768380267; cv=none; b=CVVq8TPPy1811ieaEa5RaDSMdvAL4KTMhA3TDEjFEb+kWB9svVyGQKl7GjypGZNM9KRO+3UpjBXx5rWGrFDsHlFDFKfmGOHVz9MW2eI0AKRgEoEKxljSA96Yt4Mf8x51X6AJ3MuYL8Y6GJDmRKZiDSfopb32ajwd32KlNW1QjPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768380267; c=relaxed/simple;
	bh=ysd4WYTvCh9+HsQ1AtbOfW5FzL4/iKQHwd6lm5bPF7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMKl21FZ2PlsvMC51eq5MIUxVMwqseTwS2IkzSc0uHty13CVtvuprx5vf+OXCIgMwiWXWGDteW9IgqYjdQ0c67/66vZdxk760n5jxt+mr5IunsSVK8x2VZZWtj5ofjPbb3KcmKiAzRbXCnHSzdPSoXOH41/Y7erjk10C/hFrbpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UJDpRkoJ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UJDpRkoJ"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42fbc305914so5911927f8f.0
        for <linux-serial@vger.kernel.org>; Wed, 14 Jan 2026 00:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768380255; x=1768985055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Nn9M/VPDoeuifL+P7no8o5FApQZk7zNKYvSR+p2CRU=;
        b=UJDpRkoJ07RgspaR1NhfCpR626ZyVYHDm/91x63cM8gsy5+B8MAqHavRm979cqv826
         adfCBmE4P0x6kfOJf6QVKQ+F73K8lwHrXn3rzPWHcqFa3N4E1nvvheWr+fvWlsfjnG3d
         q5I4aa3r8n+1bnVHkuJKjH4VnxEE0Ax/OlO+0AlsTNmjx9JmMpIQmGfXyFrUV7bjE4AG
         b+aIpJVdS5yOciq4wFCdKoOH2ygYDkIIMtINtTrq5bEwn2hZxdIsOnH1Mevl7p3aXRkT
         mmHrpfvAEIKMqwJsI6Dxxcv5mSGvyKeQIfwtfaMbksOr61rqb70D/17uospsX2LrpTOB
         fjgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768380255; x=1768985055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Nn9M/VPDoeuifL+P7no8o5FApQZk7zNKYvSR+p2CRU=;
        b=FnxztjXEYrCNlNTDF2L/klegyYClLYYF4k7khg4Sb7CuEHK+9GA6g2yCafn5aGnDcb
         thsW0M6V1sXGjpYoSff9X4/aCU6T0Bznw0NsRpPJ36ultBPTbnGGuLJKoAfhUfaqc8Fn
         eRA63CxayxP+2v9rZUfw9uD9h07dBWUvLvQGEUbfWaGG7XH3xgPrg+gHMc0r+ccg9Tuu
         kIjzMxx3k25YInHxUfEOtiYjuf1QJNacQSzhnZprPxkotVuqjXxKV9s5xL7CgJ1T2Sc8
         frBO8jPbjYrIJVAm5cAoYgmDEuXCmNUuhfgQ7hR24hCQ2jEu+ZKvwbr3+z3dR2/sGdYg
         a1XQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiVUiIx/F7uyPb35tCvqtxRFUkg+o28d4ukX2cND3o01oy9JDfUJElr7BirCC1+DejEkFppolpjxRtnw0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrfb9VnF6MrUhBJYjpUnYvFEsH89VEz63mcfRmuF1uLw5BQfkE
	J5bSQvLLAZ8fDf5A2Nff/YLwPxaRe+AV+MpZaDajJzkx9AuRul24jYZn4frB7st5rmk=
X-Gm-Gg: AY/fxX4ug827iDGGD5NnYaa86HHNWcLTGnavm5TQkuei0+9EdB7ewneioL96gt6ZZHc
	KS5v5d4+fcuSBI3SLFoppP62q4IcX/ojD7TAlLo10C1umZOtUs0SusfxyWlHO1nn6BbJ484H7zI
	p6z+ZxxfI9S1FcnWUb4UGpczDiHUC2e1E/RfxpeOLg04Tue+9CQlgNf/aAMZXb/LukYslMgeDZJ
	ynviF2kP79lEqreBULJGZ79FkpZcr3ubx9z23zBIxPegNyspSyJn8Aa6+BeKnSxxSX0TX3Cr5Hu
	ZdlUGQ3gAnYULrRNT8UGEYcG4gxax3YfxEkNHWrKqi97tijNRr9zwmCRD4/cC3udagG9nB26r35
	g6Y/c1HHu0S4TYqyU2SIep1zMljTaYGi1ZfXX727Wa5haJ+Cj/CGsPrfTrNYAUP6HDiZ+SVwXap
	6w64fhLzwxdeJ5Fg==
X-Received: by 2002:a05:6000:61e:b0:431:a38:c2f7 with SMTP id ffacd0b85a97d-4342c574bedmr1500621f8f.59.1768380254886;
        Wed, 14 Jan 2026 00:44:14 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee5e3sm48685590f8f.35.2026.01.14.00.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 00:44:14 -0800 (PST)
Date: Wed, 14 Jan 2026 09:44:11 +0100
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jiri Slaby <jirislaby@kernel.org>, Breno Leitao <leitao@debian.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andreas Larsson <andreas@gaisler.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
	netdev@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	sparclinux@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/19] printk: Drop flags argument from console_is_usable
Message-ID: <aWdXW6ohfQ7_z2B_@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-3-21a291bcf197@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-3-21a291bcf197@suse.com>

On Sat 2025-12-27 09:16:10, Marcos Paulo de Souza wrote:
> The flags argument was also used to check if CON_NBCON was set, but their
> usage was fixed in the last commit. All current users are reading the
> variable just to call console_is_usable.
> 
> By calling console_srcu_read_flags inside console_is_usable makes the
> code cleaner and removes one argument from the function.
> 
> Along with it, create a variant called __console_is_usable that can be
> used under console_list_lock(), like unregister_console_locked.
> 
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -656,13 +656,8 @@ extern bool nbcon_kdb_try_acquire(struct console *con,
>  				  struct nbcon_write_context *wctxt);
>  extern void nbcon_kdb_release(struct nbcon_write_context *wctxt);
>  
> -/*
> - * Check if the given console is currently capable and allowed to print
> - * records. Note that this function does not consider the current context,
> - * which can also play a role in deciding if @con can be used to print
> - * records.
> - */
> -static inline bool console_is_usable(struct console *con, short flags,
> +/* Variant of console_is_usable() when the console_list_lock is held. */

Nit: The comment is a bit misleading because this function is called
     also from console_is_usable() under console_srcu_read_lock().

     I would say something like:

/*
 * The caller must ensure that @con can't disappear either by taking
 * console_list_lock() or console_srcu_read_lock(). See also
 * console_is_usable().
 */
> +static inline bool __console_is_usable(struct console *con, short flags,
>  				     enum nbcon_write_cb nwc)
>  {
>  	if (!(flags & CON_ENABLED))
> @@ -707,6 +702,18 @@ static inline bool console_is_usable(struct console *con, short flags,
>  	return true;
>  }
>  
> +/*
> + * Check if the given console is currently capable and allowed to print
> + * records. Note that this function does not consider the current context,
> + * which can also play a role in deciding if @con can be used to print
> + * records.

And I would add here something like:

 *
 * Context: Must be called under console_srcu_read_lock().

> + */
> +static inline bool console_is_usable(struct console *con,
> +				     enum nbcon_write_cb nwc)
> +{
> +	return __console_is_usable(con, console_srcu_read_flags(con), nwc);
> +}
> +
>  #else
>  static inline void nbcon_cpu_emergency_enter(void) { }
>  static inline void nbcon_cpu_emergency_exit(void) { }

Otherwise, it looks good. It is a nice clean up.

Best Regards,
Petr
