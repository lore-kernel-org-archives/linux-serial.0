Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084DA27814A;
	Fri, 20 Jun 2025 11:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750418439; cv=none; b=Gh2GjerU6h5T/QTZOZTRJF6QwFWCPmAfNSjrGIF4DCHF8i1xS4xGq51F2htU+NRHPaVxY7qEjKEEF4RW4UoG7zCq74eZwVcJZ6Tb2z/AZLiiB7nXFNQTmHcgadlaj/uH4kj+Svm1u/JEFZRTV4zTx79e/vwTF6VrIg8KPuXVTos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750418439; c=relaxed/simple;
	bh=QZQn5hlcEoc8aWSjPZrTR9kgtMnW7nGO1rmhXIili4A=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QIjCnObyIy2SFXocShfAs+DuB3l4L3RllA3qoxl+2rOX2tGNNqjeGU5ej+kVLYzRmF/VYl3ibORHJVUpM2QKl+XzyG7sGKHlCJYrdcWWRV7Q0OIztVvTMTM33ucOLSAPovQ7695MaYabyGoSoxwFqLFVnGBqzNSc5bIoo65NYoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DHI9kYRr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aqXpD3Yx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DHI9kYRr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aqXpD3Yx"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750418435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QZQn5hlcEoc8aWSjPZrTR9kgtMnW7nGO1rmhXIili4A=;
	b=DHI9kYRrUMkGcx/u4tFkP55K9Ei4oCOvSrrsFKnffiCAJ6UinzhzkpiH5Ih8l43TJ4M2YK
	44uGrVPA8Rs6TAbDb7/o4ThqsZzyQjeXaDx2jYPib6a6zyKrvQtKGXvRyf9/7LNo5GJ6F0
	R6XvMO/dp5ToO+gDkArQdyVOQ+eMZ6GcH90+1MEb3AW6YVpdC+bcZmcbt5hG3Gh3PhQ2Eh
	xKjGIy+g0fL98ZP7gJ6cnjBGqspU2V/zrI8aoTFZ3uOAOBkfXd6dUfkWK5Rk8NbGlXmcYy
	OIP/vT8Azaq7sRqQmlHDxJFZyXPRp0S0cJeS2uZcO12jU3ay76PyC64KXwQGhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750418435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QZQn5hlcEoc8aWSjPZrTR9kgtMnW7nGO1rmhXIili4A=;
	b=aqXpD3YxtJzh4w3dtZQQcMWKsYpGa7iD0P8JeTHMlCyLjKafOJgb+H/EvWGu19vuMklg7j
	vO6Ns/uq8ryvLUAQ==
To: Yunhui Cui <cuiyunhui@bytedance.com>, arnd@arndb.de,
 andriy.shevchenko@linux.intel.com, benjamin.larsson@genexis.eu,
 cuiyunhui@bytedance.com, gregkh@linuxfoundation.org,
 heikki.krogerus@linux.intel.com, ilpo.jarvinen@linux.intel.com,
 jirislaby@kernel.org, jkeeping@inmusicbrands.com,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 markus.mayer@linaro.org, matt.porter@linaro.org, namcao@linutronix.de,
 paulmck@kernel.org, pmladek@suse.com, schnelle@linux.ibm.com,
 sunilvl@ventanamicro.com, tim.kryger@linaro.org
Subject: Re: [PATCH v9 3/4] serial: 8250: avoid potential PSLVERR issue
In-Reply-To: <20250610092135.28738-4-cuiyunhui@bytedance.com>
References: <20250610092135.28738-1-cuiyunhui@bytedance.com>
 <20250610092135.28738-4-cuiyunhui@bytedance.com>
Date: Fri, 20 Jun 2025 13:26:34 +0206
Message-ID: <848qlmk6bh.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-06-10, Yunhui Cui <cuiyunhui@bytedance.com> wrote:
> When the PSLVERR_RESP_EN parameter is set to 1, reading UART_RX while
> the FIFO is enabled and UART_LSR_DR is not set will generate a PSLVERR
> error.
>
> Failure to check the UART_LSR_DR before reading UART_RX, or the non-
> atomic nature of clearing the FIFO and reading UART_RX, poses
> potential risks that could lead to PSLVERR.
>
> PSLVERR is addressed through two methods. One is to introduce
> serial8250_discard_data() to check whether UART_LSR_DR is set before
> reading UART_RX, thus solving the PSLVERR issue when the FIFO is
> enabled. The other is to place FIFO clearing and reading of UART_RX
> under port->lock.
>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>

Reviewed-by: John Ogness <john.ogness@linutronix.de>
