Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F0C441F
	for <linux-serial@vger.kernel.org>; Thu,  7 Mar 2024 01:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709775563; cv=none; b=H0WO4Hke9hruA8PkP8AgEBMqA3PY3snzb7RTMxwHWZXlTIY/KcBfEYOCCL57ANxepHKh9AIfZujE/o1/GxTnRjjYN1x8OiEPApYOe8leMj4ZGOETi3FrQexEns1rSs9JNilwlUuKLdx42T7BCo6wri5/BmjTVvpzfVzDXlXd1l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709775563; c=relaxed/simple;
	bh=/9XN3gCJStF5EnHJQEMdSSrphA7dC9unblAqW9pLZUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rdcrkJIucp1zMITbWla7v2/ISn8kDn2+IynaIwE01Pp+zEOYFLVhDQ5ynLY2jYACPAja7iROBDboAV4fmjhPV8i8ngKjln2mhyGE+16MY3KiA9om1jZGgsDQY26+EQuMfU9olf2CzggG1mXoAMrpkXkgSB0lAG9x0lydndXZdqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=EyynXuwb; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="EyynXuwb"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-78822adc835so23748585a.3
        for <linux-serial@vger.kernel.org>; Wed, 06 Mar 2024 17:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1709775561; x=1710380361; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k0SbDUA41eUP+9zdTARSNuV/ete68uPUC1r8MIz84hU=;
        b=EyynXuwbRxoVHRGC/sAzfrN7yxb0aXkz20l0viJoPz7KgtryVpy+/FL6qDt0HnDMi7
         lNOabLx3DhaJOo4Al0GlPPTvJTy6eV/fcLJt+emqkjrgzf3PzgHZtQtONVNiSGOkeJUP
         dQQNJ7CutitcKz0N9WdJPleeTlZDHfWuAkt6U3Jc13nC3Gy9fGFMjLRUur+V5osAaOb/
         pbKNFw/P2sLhzCfR3lN+ZbSJ8rB0KgIVqGNWwPysoNHWjULbAUnNNIwTHoTHhharOpgy
         ezTlvc4qB7H1+2BgRRB0mHAU2R9Wp1OR5Mw9wvUmF6tl149wNVIkQsFlivPjqBahIoWw
         x9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709775561; x=1710380361;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k0SbDUA41eUP+9zdTARSNuV/ete68uPUC1r8MIz84hU=;
        b=BulM0b6eS88I5VzD4GWPMpjlYUzx+k+1fkdQclceGSrk7ESgsuVbgw3D6fTY+tWSP9
         n1V8LvCobj6pirEfJ8g5dkntcw+rxCeKJk5fpUKF9FrKeYGgTLnxTtxjJGPRBttqw8qK
         NV7NNo+IU8F0LT8LeoQWlSMOdVznphYl9h1/PpDYRtiGQuDP8sX0qx0wXwGsOswQKb6D
         jHzT+R4LBc4iI7U9BK37fjClGP11MfnyQDQbN9cLeVb2gRhFYgdEJwnCIwiagS8efN7k
         9kKz0rfi8e8B6EaOPCzjPy+ieqcmMymrwl0yC7fxx3J9i6WFyXI0kNIgwoUd5tAs3Pra
         EeSQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0/DbkjBqcxjoZPGa+Nhq7eFBIttnJA/+zPcHObOJe3yrJd8DuR7fQvniftR+aJx5XcpdVyQT6uEQ1ahgn1QNNnEHK+WPxjKg4jkwq
X-Gm-Message-State: AOJu0YzMlST7kqNKzvu4IIpj4SrdKZSMazZkZiXkA/PmOz9nnZQLQE8J
	m1wvpUUZ6EpFIE/CRtj8XerK+VP5yLUbdzGtwBiJ9ywH0RQqZ2DxBfhpKhqC3Mk=
X-Google-Smtp-Source: AGHT+IFf4x9Pki+DLL/Ppvd38GvUMxQXysG3pCfvxlDIle3QnJYGBL2zBqSfeuh5GWFIcMGvQW1/Qw==
X-Received: by 2002:a05:620a:244a:b0:788:2cc6:1232 with SMTP id h10-20020a05620a244a00b007882cc61232mr7778482qkn.16.1709775561159;
        Wed, 06 Mar 2024 17:39:21 -0800 (PST)
Received: from [100.64.0.1] ([170.85.8.176])
        by smtp.gmail.com with ESMTPSA id a21-20020a05620a02f500b0078833092600sm2649809qko.30.2024.03.06.17.39.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 17:39:20 -0800 (PST)
Message-ID: <ddf63d8b-7818-4c25-a83a-255ea45ea027@sifive.com>
Date: Wed, 6 Mar 2024 19:39:19 -0600
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/18] serial: sifive: Use uart_prepare_sysrq_char() to
 handle sysrq.
Content-Language: en-US
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, linux-riscv@lists.infradead.org
References: <20240301215246.891055-1-bigeasy@linutronix.de>
 <20240301215246.891055-13-bigeasy@linutronix.de>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20240301215246.891055-13-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-03-01 3:45 PM, Sebastian Andrzej Siewior wrote:
> The port lock is a spinlock_t which is becomes a sleeping lock on PREEMPT_RT.
> The driver splits the locking function into two parts: local_irq_save() and
> uart_port_lock() and this breaks PREEMPT_RT.
> 
> Handle sysrq requests sysrq once the port lock is dropped.
> Remove the special case in the console write routine an always use the
> complete locking function.
> 
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: linux-riscv@lists.infradead.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/tty/serial/sifive.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)

Acked-by: Samuel Holland <samuel.holland@sifive.com>
Tested-by: Samuel Holland <samuel.holland@sifive.com>

