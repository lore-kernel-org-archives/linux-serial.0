Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA3438E8D9;
	Wed,  3 Jun 2026 06:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780469824; cv=none; b=R1GWkCKhAIki79cq7gJG+2Dtf2aRxsp7I2b8tUjbM6ZAM5NVkzykzds4YgQw6hZFfFb/OPC5XZGNbUd7hkZCJrrcMP/QMSI9bpQkPy6khGqe1KrKGJDKnBFsMkUKrdYIdUod363Z5BAwmrNYKL9s6SOSIOY3vu6bboDXj25jXoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780469824; c=relaxed/simple;
	bh=InlKBdW6y2nYfFlv+fbHgsuviW36QJoiIp+24c7L2FY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K2TvZatbW0XHlFS8icVC1dQcSSoAlFlwD5DZRQpTNAXj44bYrW4V37G5sMPJH8ePWet4MGG/jupGjr+DdJtOAc4l3Ox70L+MHuShk8tBe7RtIbWNqKQ0DluFRFwsjxhv6gTiv+BDWaJlQFV+w8dVK3yhzwmQgHnJQosEnLkp9rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rIK5MRSv; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rIK5MRSv"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780469821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O8Xg5kMwDiZhGeMRVTNH+BvulIB1WnOcW2ZagQP3CFk=;
	b=rIK5MRSvJMhGbgcFg2/hFu41L7GB22rFuJJ8sCSLP3JF4ved/EdhekTHLWXRd4Ck6vfqTC
	ZjCwOFCQMJTsu/s0X9ECE1/Ab7xYJX60Y21Jg2eFovLw7EmeVhPaiZBITF1li2NKwtCqrn
	/Yhu30lzy6dZ5G5HHc7NZJvD5XTJjw0=
From: Fushuai Wang <fushuai.wang@linux.dev>
To: fushuai.wang@linux.dev
Cc: alan@linux.intel.com,
	andy.shevchenko@gmail.com,
	gregkh@linuxfoundation.org,
	ilpo.jarvinen@linux.intel.com,
	jackzxcui1989@163.com,
	jirislaby@kernel.org,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	osama.abdelkader@gmail.com,
	sean@mess.org,
	wangfushuai@baidu.com
Subject: Re: [PATCH v3] serial: 8250: Clear CON_PRINTBUFFER on port re-registration
Date: Wed,  3 Jun 2026 14:56:42 +0800
Message-Id: <20260603065642.7575-1-fushuai.wang@linux.dev>
In-Reply-To: <20260522101042.21976-1-fushuai.wang@linux.dev>
References: <20260522101042.21976-1-fushuai.wang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index a428e88938eb..5419f1d22d47 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -716,8 +716,12 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
>  	if (uart->port.type == PORT_8250_CIR)
>  		return -ENODEV;
>  
> -	if (uart->port.dev)
> +	if (uart->port.dev) {
> +		if (uart_console(&uart->port))
> +			uart->port.cons->flags &= ~CON_PRINTBUFFER;
> +
>  		uart_remove_one_port(&serial8250_reg, &uart->port);
> +	}
>  
>  	uart->port.ctrl_id	= up->port.ctrl_id;
>  	uart->port.port_id	= up->port.port_id;

ping.

-- 
Regards,
WANG
