Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8A63A71AF;
	Wed, 13 May 2026 12:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778673715; cv=none; b=GKOfdKxdRPo0yXh8pJcMNUbwp2tmerLz+6zcH5uPhNq05VnXFE4QNM+5oe01VTvLfqc70cSSPI60uQBhF1i6DG4s6AIE2L4ViseH07Cl2TIAicBaN4PAwwIpSTo9KFMttYl0/M7E+RKap+AFdnfF2Oj3lU56+D1eJfqiQSqspAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778673715; c=relaxed/simple;
	bh=/MfRmL/idSnT2zhVAfK+Q3D8VTuRy+kKpxHTDzhD4oE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qkOYqf4F+glsda5QddfInaw7l86CYhEdbbn8E6fASMcO1KqVisder8yIFexeZfj/u1jZI8+DIsX9S4hNCQ/pX3OZEELbIobkeFZEnkU0TZSHkO1EfIsx6eJIM4clAf/qn0/e1l/yrO2R5wKFB2ZAZ1fBpO2ZD9jfhH0dKzLw2ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U/seUxwY; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U/seUxwY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778673714; x=1810209714;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/MfRmL/idSnT2zhVAfK+Q3D8VTuRy+kKpxHTDzhD4oE=;
  b=U/seUxwYj8Fzvt5M3gD444KaQBtkLDblWqjdLnObxV8nWnY7XeaGX5x+
   44WhekFJ26zJ5dUFZTse9xK7vBLeBI/gusZ5hg73S4uO8FKzQEUuYDuM+
   nkR20FpjU61xZUBanYPdCD2xLbyWazu3BzH/l7JCGodPxdJB3ub9jWn7w
   MQKbldx/BSScrFcN7csvk3XTOVtlh7cfd9h+x0zosXyQiBp6EZEI0HC2E
   BVlJ8Jj4olKI+77ztEbabxdQtuby2G6jzCG9gLNEyFwysrlCtRE+lasAc
   xe3HuyLuc5z+X6UbzGM6zym5cGjQgdhdHkzvcectiB6J24OUJTYDyR4Nv
   Q==;
X-CSE-ConnectionGUID: 0ps45iX0RqCoxUEYki9Trw==
X-CSE-MsgGUID: ytWYr7T4Sb+M7Pyu0egZ8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="90699681"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="90699681"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 05:01:51 -0700
X-CSE-ConnectionGUID: +7V4xHpQRjecU3C3TiJ+aA==
X-CSE-MsgGUID: BQtPeKDjT1eG90NgT9TXIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="233797750"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.110])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 05:01:48 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 13 May 2026 15:01:44 +0300 (EEST)
To: Jacques Nilo <jnilo@free.fr>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 1/3] serial: core: introduce
 guard(uart_port_lock_sysrq_irqsave)
In-Reply-To: <b65b5237542c1c1c694a20e9d8fd0e18434a82b9.1778592805.git.jnilo@free.fr>
Message-ID: <3439217b-90b5-5d21-e777-d238b3ffc1a0@linux.intel.com>
References: <5efe9e03-4d86-43a0-9ec2-e610ff31095d@free.fr> <cover.1778592805.git.jnilo@free.fr> <b65b5237542c1c1c694a20e9d8fd0e18434a82b9.1778592805.git.jnilo@free.fr>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 12 May 2026, Jacques Nilo wrote:

> uart_handle_break() and uart_prepare_sysrq_char() (in
> include/linux/serial_core.h) capture a SysRq character into
> port->sysrq_ch while the port lock is held and rely on the unlock
> helper -- uart_unlock_and_check_sysrq_irqrestore() -- to dispatch the
> captured character to handle_sysrq() on scope exit.
> 
> The existing guard(uart_port_lock_irqsave) cannot be used by IRQ
> handlers that process RX, because its destructor calls plain
> uart_port_unlock_irqrestore() and silently drops port->sysrq_ch.
> 
> Add a dedicated guard variant whose destructor is the sysrq-aware

guard(...) (put the full form here already).

> unlock helper. Callers that may capture SysRq characters opt in by
> using guard(uart_port_lock_sysrq_irqsave); the existing

opt in by using -> must use

> uart_port_lock_irqsave guard keeps its current plain-unlock semantics

guard(uart_port_lock_irqsave)

> for the many callers that do not process RX.
> 
> The lock side is identical to uart_port_lock_irqsave -- only the
> unlock-time behaviour differs.

Move this to the previous paragraph after the first sentence.

> Naming mirrors
> uart_unlock_and_check_sysrq_irqrestore() (sysrq before irqsave/irqrestore).

I'd remove the sentence about the name, it's kind of obvious.

> The new macro is placed after the CONFIG_MAGIC_SYSRQ_SERIAL block so
> both definitions of uart_unlock_and_check_sysrq_irqrestore() (sysrq
> enabled and disabled) are visible at expansion time. When
> CONFIG_MAGIC_SYSRQ_SERIAL=n the destructor degenerates to plain
> uart_port_unlock_irqrestore(), so there is no overhead.
> 
> No functional change on its own; users are converted in the following
> patches.
> 

You should add Cc: stable here too as this is prerequisite for the other 
two patches (but no Fixes tag).

> Signed-off-by: Jacques Nilo <jnilo@free.fr>
> ---
>  include/linux/serial_core.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index 4f7bbdd90..4fa079dc9 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -1286,6 +1286,19 @@ static inline void uart_unlock_and_check_sysrq_irqrestore(struct uart_port *port
>  }
>  #endif	/* CONFIG_MAGIC_SYSRQ_SERIAL */
>  
> +/*
> + * Variant of guard(uart_port_lock_irqsave) for IRQ handlers that may capture
> + * a SysRq character via uart_prepare_sysrq_char(). The destructor uses the
> + * sysrq-aware unlock helper so that a captured port->sysrq_ch is dispatched
> + * to handle_sysrq() on scope exit. The plain guard variant silently drops
> + * sysrq_ch and must not be used by callers that process RX.
> + */
> +DEFINE_LOCK_GUARD_1(uart_port_lock_sysrq_irqsave, struct uart_port,

I suppose the "check" in the name is kind of important detail so maybe it 
shouldn't be dropped from the guard name.

> +                    uart_port_lock_irqsave(_T->lock, &_T->flags),
> +                    uart_unlock_and_check_sysrq_irqrestore(_T->lock,
> +                                                           _T->flags),

This fits to one line.

> +                    unsigned long flags);
> +
>  /*
>   * We do the SysRQ and SAK checking like this...
>   */
> 

-- 
 i.

