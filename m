Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BB82882AD;
	Wed, 11 Jun 2025 13:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749648336; cv=none; b=OK0KBx5eA5bHPRxMwTiC7dttaSLCuNWWFyWljUZjt9ydIxiS1gZHJqYswLjdzIvxwBukYjIk2vO0jcHGORyiViZcnQs4sd9HMzSgRY3wkhFW/8wwq2+CLdDLU0xRwHpqYMr/L+DF/RPJ1J6ut6GFW8t/hy666hbs7K6M98qIqSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749648336; c=relaxed/simple;
	bh=yBbZ2fCzhlcFLHWk3m6bmc7G5d+p2aBM6IGB0/YERh0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=spnze5Dmg1kdXV3k2t3LXeVPESBFOwMoFt+qJ1+ZSbenTiTKExOykqNdOFzjHpR94lLsP11aR/XyillRr08rt9gPc9HHw6f/vulCnqaRnr7U1QNib/1u8IuMvWPDOV3HQ9Y76pye44IpdKdJ1HAAYF89x+UaxdG26T+VlSwpsbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JuQOTTrr; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JuQOTTrr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749648334; x=1781184334;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yBbZ2fCzhlcFLHWk3m6bmc7G5d+p2aBM6IGB0/YERh0=;
  b=JuQOTTrrsJQoc9rBYIkSqlH9/fA8UsZ5EadQfqU0qL7Kwu8qiGpp+lV0
   kY87Cr5+mysqD9NfoyYQLU6aUKz4ZzW/XmCaut+sR5qm3TVQhSFUXN593
   2o+F28BPnl/HYgxp5RpKwjdrA9g3M2xUuH6BYpqb399HB3Oet2iUv/Zk7
   2bClUBu8Uuqx3kwR3pdBCOqNKmB9W9GkKTEZO+UBX+rYy1CtZD2MQhcYO
   GLDPV3tpRrVAceZPr6e8d2Fry+OXNUC1lGvI5xnkqDQR7L1ugdan6AaWo
   LTitO9IOjjn33ZWozk6eiMcsDhW2AzYAvs+j2SVGuZ9FFih44WOkWwEjK
   g==;
X-CSE-ConnectionGUID: 62biPInjQlij2YQ/omfwPQ==
X-CSE-MsgGUID: yoMixfzdS4i1XiHYUXLhWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="55585324"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="55585324"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 06:25:33 -0700
X-CSE-ConnectionGUID: 9Ag5rfBtQxamc7FiQpsQZg==
X-CSE-MsgGUID: 7jeF4lZDSdiMYmD4Syofcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="147037478"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.183])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 06:25:31 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 11 Jun 2025 16:25:26 +0300 (EEST)
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 32/33] serial: 8250: use hashtable
In-Reply-To: <20250611100319.186924-33-jirislaby@kernel.org>
Message-ID: <708697c8-8e8a-fecb-23a5-939194c3935c@linux.intel.com>
References: <20250611100319.186924-1-jirislaby@kernel.org> <20250611100319.186924-33-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 11 Jun 2025, Jiri Slaby (SUSE) wrote:

> Instead of open-coding the hash table, use the one provided by
> hashtable.h. The semantics is the same, except the code needs not to
> compute the hash bucket on its own.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> ---
>  drivers/tty/serial/8250/8250_core.c | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index 10f25bae9f46..a6ecb8575da4 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -13,6 +13,7 @@
>   */
>  
>  #include <linux/acpi.h>
> +#include <linux/hashtable.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
>  #include <linux/ioport.h>
> @@ -47,8 +48,8 @@ struct irq_info {
>  	struct list_head	*head;
>  };
>  
> -#define NR_IRQ_HASH		32	/* Can be adjusted later */
> -static struct hlist_head irq_lists[NR_IRQ_HASH];
> +#define IRQ_HASH_BITS		5	/* Can be adjusted later */
> +static DEFINE_HASHTABLE(irq_lists, IRQ_HASH_BITS);
>  static DEFINE_MUTEX(hash_mutex);	/* Used to walk the hash */
>  
>  /*
> @@ -75,11 +76,8 @@ static irqreturn_t serial8250_interrupt(int irq, void *dev_id)
>  
>  	l = i->head;
>  	do {
> -		struct uart_8250_port *up;
> -		struct uart_port *port;
> -
> -		up = list_entry(l, struct uart_8250_port, list);
> -		port = &up->port;
> +		struct uart_8250_port *up = list_entry(l, struct uart_8250_port, list);
> +		struct uart_port *port = &up->port;

Isn't this entirely unrelated change/cleanup?

>  
>  		if (port->handle_irq(port)) {
>  			handled = 1;
> @@ -132,14 +130,11 @@ static void serial_do_unlink(struct irq_info *i, struct uart_8250_port *up)
>   */
>  static struct irq_info *serial_get_or_create_irq_info(const struct uart_8250_port *up)
>  {
> -	struct hlist_head *h;
>  	struct irq_info *i;
>  
>  	mutex_lock(&hash_mutex);
>  
> -	h = &irq_lists[up->port.irq % NR_IRQ_HASH];
> -
> -	hlist_for_each_entry(i, h, node)
> +	hash_for_each_possible(irq_lists, i, node, up->port.irq)
>  		if (i->irq == up->port.irq)
>  			goto unlock;
>  
> @@ -150,7 +145,7 @@ static struct irq_info *serial_get_or_create_irq_info(const struct uart_8250_por
>  	}
>  	spin_lock_init(&i->lock);
>  	i->irq = up->port.irq;
> -	hlist_add_head(&i->node, h);
> +	hash_add(irq_lists, &i->node, i->irq);
>  unlock:
>  	mutex_unlock(&hash_mutex);
>  
> @@ -189,13 +184,10 @@ static int serial_link_irq_chain(struct uart_8250_port *up)
>  static void serial_unlink_irq_chain(struct uart_8250_port *up)
>  {
>  	struct irq_info *i;
> -	struct hlist_head *h;
>  
>  	mutex_lock(&hash_mutex);
>  
> -	h = &irq_lists[up->port.irq % NR_IRQ_HASH];
> -
> -	hlist_for_each_entry(i, h, node)
> +	hash_for_each_possible(irq_lists, i, node, up->port.irq)
>  		if (i->irq == up->port.irq)
>  			break;
>  
> 

-- 
 i.

