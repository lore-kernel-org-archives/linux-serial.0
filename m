Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794406628;
	b=2KyjS2naZsbGBWDxcBmWFHHdWS3Fbx7xB33bg6VyX0lKXyarDe8JaqgEnwDCbIyoSzMu
	 dTFaRwEcB1bK/1mVkgQzokAEeHMGY5GZJfUCyj9D2wPztfjkMMxymZfMGrWRzuvrk+fBF
	 dFfEX/UL8iIXPvpcCgdeZNIAA3PN1GmdvRuizKG3FqwOYELKiB1jE0tTTcGcckMplQMyz
	 GyR9TdZFLT6DtAxAjVKSmKgXULzQuK+z7a/bTvAzB6WHZNWiRD6y3GeULpMZ2z/IGwsvu
	 xyg1e0GFcjmVM8tPLhJgMM77m7CXv53qh8FSI3QcWy2vquFebk8caRhxLKeF+RKs9Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794406628;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=rhhgs3SOKWlfwatuwxS7aRDVfjVPDbWLqI/UBAGOHnE=;
	b=ybNvyNn8xq8T4wJN/N41uFuN0od0v6fTqQwoEIib7r/e7k5UrkJPFvOBwKjAgmpglEUH
	 l2+Aw2YpLEugJ7z7noxAxPqbiMMfZhKWNl0LnRkPg0ML1GL3JnxwsyaME4qPEckz7KlJA
	 n5udZF/No27KAQOeckIlfRNDwnmt6+p41TiDTprMfKS422Aw3ITNhRrCDqkfNUKCbSC8i
	 +Lx2hJfLyDSQyRdZwHiYt658NXHF0uA1KjzvdkKF/xEONZpOHz3nGsv8+lrdMgbaJu2G+
	 0z/MQ7rRRWxGvKZK0Mt+Cx2ncRiWUz7PIK49DC3/J9z13G4yi34v4GFnXuVIdeNk2pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Aks+70oq;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C3C606A324;
	Wed, 11 Nov 2026 14:17:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9C3C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Aks+70oq
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF00A1576;
	Wed, 11 Nov 2026 06:17:03 -0800 (PST)
Received: from [10.0.154.42] (e121487-lin.cambridge.arm.com [10.0.154.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EAFBC3F632;
	Wed, 11 Nov 2026 06:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794406626; bh=tT/KoO/QdKIgG6YIe8GqMisCkeUut2m9Zpo7qT+ZkAY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Aks+70oqj5nGSTTUzaQusoPGxfXAt6zjVCn/VlBAfLLe48wlQToWbbbfQuR4KhtdH
	 CGRglsv9NvJxgj3OY6wKcTU3iG2fBrGtt8wITDWsRplJ9MAAjdDKlUGZlvAtrw7yWF
	 PtbUTAiE6T1XMBpmVx7spKUO0VqR5EPUkYM/c184=
Message-ID: <89544da0-7c18-4fe5-8005-131760a2b8b5@arm.com>
Date: Wed, 11 Nov 2026 14:17:02 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: mps2-uart: Remove the ports_idr entry when probe
 fails
To: Changyul Lee <lcy8047@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, arnd@kernel.org
Cc: Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla
 <sudeep.holla@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20261106010611.1708587-1-lcy8047@gmail.com>
Content-Language: en-GB
From: Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <20261106010611.1708587-1-lcy8047@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/26 01:06, Changyul Lee wrote:
> mps2_of_get_port() adds mps_port to ports_idr, but mps2_serial_probe()
> does not remove the entry when mps2_init_port() or uart_add_one_port()
> fails. mps_port is allocated with devm_kzalloc(), so devres frees it
> when probe fails, while ports_idr still points to it. When another port
> later registers the console, mps2_uart_console_setup() looks up the
> console index in ports_idr and uses the freed mps_port:
> 
>   BUG: KASAN: slab-use-after-free in uart_set_options+0x650/0x7a4
>   Read of size 8 at addr ffff0000018c41a0 by task swapper/0/1
>   Call trace:
>    uart_set_options
>    mps2_uart_console_setup
>    try_enable_preferred_console
>    register_console
>    serial_core_register_port
>    serial_ctrl_register_port
>    uart_add_one_port
>    mps2_serial_probe
>   ...
>   Freed by task 1:
>    kfree
>    dr_node_free
>    devres_release_all
>    device_unbind_cleanup
>    really_probe
> 
> The stale entry also keeps the ID in use. A re-probe of the port (e.g.
> after -EPROBE_DEFER) then gets a different ID than its alias.
> 
> Remove the entry on both error paths.
> 
> Fixes: 9f25e07b882b ("serial: mps2-uart: move to dynamic port allocation")
> Signed-off-by: Changyul Lee <lcy8047@gmail.com>
> ---
> 
> Notes:
>     Found with a static analysis tool we are developing.
>     
>     Reproduced in QEMU (arm64 virt, CONFIG_COMPILE_TEST, KASAN) with two
>     arm,mps2-uart nodes added to the device tree: serial0 without a
>     "clocks" property, so devm_clk_get() fails after the ID is allocated,
>     and serial1 with a fixed clock, booted with console=ttyMPS0. Without
>     this patch KASAN reports the use-after-free above. With it, there is no
>     KASAN report and the boot goes on until it looks for a root filesystem
>     (the test has none).
>     Not tested on MPS2 hardware.

Before getting into the review, I'd like to clarify a few things:

- This driver is only used on a NOMMU platform, where any code
  can write to any memory location, so the security impact of
  this issue is likely minimal

- The only platform that uses this driver is deprecated and
  scheduled for removal [1], with the driver to be removed
  afterwards

@Arnd, could you please advise on how to proceed? Should we
review the patch, leave things as they are, or take a different
approach?

[1] https://lore.kernel.org/linux-arm-kernel/20260908152808.3928630-12-arnd@kernel.org/

> 
>  drivers/tty/serial/mps2-uart.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/mps2-uart.c b/drivers/tty/serial/mps2-uart.c
> index 2a4c09f3a834..c39aa534b822 100644
> --- a/drivers/tty/serial/mps2-uart.c
> +++ b/drivers/tty/serial/mps2-uart.c
> @@ -590,15 +590,19 @@ static int mps2_serial_probe(struct platform_device *pdev)
>  
>  	ret = mps2_init_port(pdev, mps_port);
>  	if (ret)
> -		return ret;
> +		goto err_remove_id;
>  
>  	ret = uart_add_one_port(&mps2_uart_driver, &mps_port->port);
>  	if (ret)
> -		return ret;
> +		goto err_remove_id;
>  
>  	platform_set_drvdata(pdev, mps_port);
>  
>  	return 0;
> +
> +err_remove_id:
> +	idr_remove(&ports_idr, mps_port->port.line);
> +	return ret;
>  }
>  
>  #ifdef CONFIG_OF
> 
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> -- 2.43.0
> 

