Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71A722339;
	Fri, 14 Mar 2025 05:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741930561; cv=none; b=XduagWpUP2z8VDPb6al6g3iRxYFLQjGYY/8DTechzhcIRqVgF+IDNXGQYMUMI8nBjmiGVadl/Zu7UbyVNjQSy3+Olh2xTIwmjdNJqKCe/zdDpiWXZ9X+aXPfn+k5KWK4FerRuR4xHdaYMFTfXx6wrEejRjo7bEMuhigSLB1Wgw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741930561; c=relaxed/simple;
	bh=VKyZ5Fz1u+FMrWz2PAKYx6AtM0rcTyIVLX0B6X5JLeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ttk2aAXBUM+33oM/lqNnwSA8NI+k3+1yCmPeRLG6qKVC9Hjk+n4LFI+94lY+bAlJfa4eB/fY3Vc/fx7u77L6Yfbf1Y3x/P1echB2NB/MzELBE+i4nUM7+FoYG1Cq2Xt1YMv2VwR7iZhpvEaY2Ar5nUGBDAtpM6x/no/CjjwXl8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ctyZ3c2U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ctyZ3c2U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD2FCC4CEE3;
	Fri, 14 Mar 2025 05:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741930561;
	bh=VKyZ5Fz1u+FMrWz2PAKYx6AtM0rcTyIVLX0B6X5JLeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ctyZ3c2UM6mTgK/4jpE6RcMSW1hdiYDAvwghdp6xpmSaP0BHFxchgJpry+AXiUpG+
	 cfnQSVN/lBhPgP1ete0sMfRzyo//nvE3BfwXjAgHOv1mzNnBvxBlAlXVJJ1/9+XFha
	 zpbWfRZKMk4aoDm/nVjBCHlRIkr27vy8OJjOCfhU=
Date: Fri, 14 Mar 2025 06:35:58 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Elodie Decerle <elodie.decerle@nokia.com>
Cc: jacmet@sunsite.dk, jirislaby@kernel.org, jakub.lewalski@nokia.com,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: serial: uartlite: ensure uart driver is registered
Message-ID: <2025031424-clay-ashamed-f0bf@gregkh>
References: <20250313205852.2870-1-elodie.decerle@nokia.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313205852.2870-1-elodie.decerle@nokia.com>

On Thu, Mar 13, 2025 at 09:58:50PM +0100, Elodie Decerle wrote:
> When two instances of uart devices are probing, a concurrency race can
> occur.
> 
> If one thread calls uart_register_driver function, which first
> allocates and assigns memory to 'uart_state' member of uart_driver
> structure, the other instance can bypass uart driver registration and
> call ulite_assign. This calls uart_add_one_port, which expects the uart
> driver to be fully initialized. This leads to a kernel panic due to a
> null pointer dereference:
> 
> [    8.143581] BUG: kernel NULL pointer dereference, address: 00000000000002b8
> [    8.156982] #PF: supervisor write access in kernel mode
> [    8.156984] #PF: error_code(0x0002) - not-present page
> [    8.156986] PGD 0 P4D 0
> ...
> [    8.180668] RIP: 0010:mutex_lock+0x19/0x30
> [    8.188624] Call Trace:
> [    8.188629]  ? __die_body.cold+0x1a/0x1f
> [    8.195260]  ? page_fault_oops+0x15c/0x290
> [    8.209183]  ? __irq_resolve_mapping+0x47/0x80
> [    8.209187]  ? exc_page_fault+0x64/0x140
> [    8.209190]  ? asm_exc_page_fault+0x22/0x30
> [    8.209196]  ? mutex_lock+0x19/0x30
> [    8.223116]  uart_add_one_port+0x60/0x440
> [    8.223122]  ? proc_tty_register_driver+0x43/0x50
> [    8.223126]  ? tty_register_driver+0x1ca/0x1e0
> [    8.246250]  ulite_probe+0x357/0x4b0 [uartlite]
> 
> Adding a mutex lock around the uart_register_driver call in the probe
> function prevents this race condition and ensures that the uart driver
> structure is fully initialized and registered before it is used.
> 
> Signed-off-by: Elodie Decerle <elodie.decerle@nokia.com>
> Reviewed-by: Jakub Lewalski <jakub.lewalski@nokia.com>
> ---
>  drivers/tty/serial/uartlite.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
> index a41e7fc373b7..460eb2032efa 100644
> --- a/drivers/tty/serial/uartlite.c
> +++ b/drivers/tty/serial/uartlite.c
> @@ -23,6 +23,8 @@
>  #include <linux/clk.h>
>  #include <linux/pm_runtime.h>
>  
> +static DEFINE_MUTEX(uart_driver_register_lock);
> +
>  #define ULITE_NAME		"ttyUL"
>  #if CONFIG_SERIAL_UARTLITE_NR_UARTS > 4
>  #define ULITE_MAJOR             0       /* use dynamic node allocation */
> @@ -880,6 +882,8 @@ static int ulite_probe(struct platform_device *pdev)
>  	pm_runtime_set_active(&pdev->dev);
>  	pm_runtime_enable(&pdev->dev);
>  
> +	mutex_lock(&uart_driver_register_lock);
> +
>  	if (!ulite_uart_driver.state) {

So the problem that there is a single "state" for the driver as a whole.
That should be fixed up to be local to each individual device that is
added to the system.  Don't add a lock to paper over this as odds are
this is not the only place that will have problems.

Are you just now having 2 of these devices in your system at the same
time?

thanks,

greg k-h
