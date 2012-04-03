From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial: 8250: Add cpufreq support
Date: Tue, 3 Apr 2012 10:55:30 +0100
Message-ID: <20120403105530.7fa3bce7@pyramind.ukuu.org.uk>
References: <1333433022-5455-1-git-send-email-akshay.s@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:45046 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849Ab2DCJxT (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 3 Apr 2012 05:53:19 -0400
In-Reply-To: <1333433022-5455-1-git-send-email-akshay.s@ti.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Shankarmurthy, Akshay" <akshay.s@ti.com>
Cc: linux-serial@vger.kernel.org, alan@linux.intel.com, gregkh@linuxfoundation.org, paul.gortmaker@windriver.com, jamie@jamieiles.com, swarren@nvidia.com, dianders@chromium.org, davinci-linux-open-source@linux.davincidsp.com, linux-kernel@vger.kernel.org, Chaithrika U S <chaithrika@ti.com>

> This patch was submitted 2 years ago but didn't make it to the mainline. Now i am reposting it.

Can you fix it instead of just reposting it ?


> +#ifdef CONFIG_CPU_FREQ
> +static int serial8250_cpufreq_transition(struct notifier_block *nb,
> +					     unsigned long val, void *data)
> +{
> +	struct uart_8250_port *p;
> +	struct uart_port *uport;

What is your locking model ?


> +static inline void serial8250_cpufreq_deregister(struct uart_8250_port *p)

unregister

> +		ret = serial8250_cpufreq_register(uart);
> +		if (ret < 0)
> +			printk(KERN_ERR "Failed to add cpufreq notifier\n");

Why do this for devices that don't care.

Alan
