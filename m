Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8505338642C;
	Tue, 13 Oct 2026 05:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791870593; cv=none; b=PoJBTqGH1tnwN7rdY7ylhhv7ABedgFmHY80gUG4FVcE2JfZm1FsjNm/uaIKcQIAoUDnX5hQbU1WHdxJgxt7CMWlhikCKNu1gw/R3i7FpCyBJnQLwlaKXxR93Wli8tRaCrNev+dHGF2sFC2GdwS/BPf0MKW8Xj6qmrON44a2y4R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791870593; c=relaxed/simple;
	bh=wuRY5p+5BrzZUH6eJDHauD3cZJW0aNAJikIfR7tCCd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RrkvXfyME6Q1vzejdYD7CqqovtK1MeM5FZm07NRXSMv7HahhHWrHg5ibNxtyjOPM+BUEvcFNhGxq2HSbstkx1r6PoI+Rw3MZCKpCcNbOSzgRVTSykszKe41qwilM25QLLnYPIkCKgZDJU0J63Flq/WEq5si/fu7XwMgLytoTeVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOM7OoZN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOM7OoZN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A9FE1F000FF;
	Tue, 13 Oct 2026 05:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791870592;
	bh=11l6/oERXgMW/KfZBlSq4z+sWH/hdPWsPSIDxfpMm/I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=kOM7OoZNkeQoeZUBmGA9S1uzERXrskTIHg0Dlh4HAYCrI3BAKKGjCcjiWIl1RCJyC
	 BZiJOvFz0c8t5bh6t6eUnpw/VLARFyplhuj51o5LaxqqWt/oWzTXah++nRmhWS6Cs9
	 Jyc9GHqTJ7d+JBOTWytsy+x+HvT3gNTq4Zyr9fLa3RpCIqYsrwI5BjYuH0ULwuBDiL
	 agitrCz3TUWqpmVJiLzg9wjtqUJnjgA84Hdd8vo6Jkmn5Hfo6S/Vd2vVjIaFcRa4UJ
	 bCEc3W0/65OPvP76z0CcDL4uR/WI0ELdUaxL9yncxwDv+GqCoccRPiDPSdZdAS4LN/
	 Bsw1R7pYzLzgg==
Message-ID: <558332ed-b93e-4f0d-abb0-942ca63b0cd6@kernel.org>
Date: Tue, 13 Oct 2026 07:49:47 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] tty: Add NVIDIA LSTP UART driver
To: Adrian Ambrozewicz <aambrozewicz@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Donald Shannon <donalds@nvidia.com>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-usb@vger.kernel.org, llvm@lists.linux.dev,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Johan Hovold <johan@kernel.org>, Oliver Neukum <oneukum@suse.com>
References: <20261012-lstp-usb-adapter-v1-0-aambrozewicz@nvidia.com>
 <20261012-lstp-usb-adapter-v1-10-aambrozewicz@nvidia.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20261012-lstp-usb-adapter-v1-10-aambrozewicz@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 12. 10. 26, 19:36, Adrian Ambrozewicz wrote:
> --- /dev/null
> +++ b/drivers/tty/lstp_tty.c
> @@ -0,0 +1,829 @@
...
> +/* clang-format off */
> +static speed_t lstp_baud_to_speed(u32 baud)

Maybe implement this in drivers/tty/tty_baudrate.c on the top of 
baud_table + baud_bits?

> +{
> +	static const struct {
> +		u32     baud;
> +		speed_t speed;
> +	} map[] = {
> +		{      50, B50      }, {      75, B75      }, {     110, B110     },
> +		{     134, B134     }, {     150, B150     }, {     200, B200     },
> +		{     300, B300     }, {     600, B600     }, {    1200, B1200    },
> +		{    1800, B1800    }, {    2400, B2400    }, {    4800, B4800    },
> +		{    9600, B9600    }, {   19200, B19200   }, {   38400, B38400   },
> +		{   57600, B57600   }, {  115200, B115200  }, {  230400, B230400  },
> +		{  460800, B460800  }, {  500000, B500000  }, {  576000, B576000  },
> +		{  921600, B921600  }, { 1000000, B1000000 }, { 1152000, B1152000 },
> +		{ 1500000, B1500000 }, { 2000000, B2000000 }, { 2500000, B2500000 },
> +		{ 3000000, B3000000 }, { 3500000, B3500000 }, { 4000000, B4000000 },
> +	};
> +
> +	for (size_t i = 0; i < ARRAY_SIZE(map); i++)
> +		if (map[i].baud == baud)
> +			return map[i].speed;
> +
> +	return B0;
> +}
...
> +static int lstp_uart_start(struct lstp_channel *ch)
> +{
> +	struct lstp_uart_ctx *ctx = ch->priv;
> +
> +	/*
> +	 * Mark registered before publishing: tty_port_register_device() adds
> +	 * the cdev and emits the uevent that sends udev straight to open(),
> +	 * and lstp_tty_install() refuses a minor that is not marked. No node
> +	 * exists at this index yet, so nothing can reach the map early.
> +	 */
> +	scoped_guard(mutex, &lstp_minors_lock)
> +		ctx->registered = true;
> +
> +	struct device *tty_dev =
> +		tty_port_register_device(&ctx->port, lstp_tty_driver, ctx->minor, ch->dev);
> +
> +	if (IS_ERR(tty_dev)) {
> +		dev_err(ch->dev, "%s: ch_%d: Could not register TTY (%pe)\n", __func__, ch->ch_id,
> +			tty_dev);
> +		scoped_guard(mutex, &lstp_minors_lock)
> +			ctx->registered = false;
> +		return PTR_ERR(tty_dev);
> +	}
> +
> +	/* Nothing below may fail: really_probe() skips .remove() when .probe() errors. */
> +	dev_info(ch->dev, "%s: ch_%d: Started as %s\n", __func__, ch->ch_id, ch->display_name);

We usually print nothing in case everything went well.

> +	return 0;
> +}
...
> +static void lstp_uart_stop(struct lstp_channel *ch)
> +{
> +	struct lstp_uart_ctx *ctx = ch->priv;
> +
> +	/*
> +	 * Clear @registered before sampling @port->tty, not after:
> +	 * tty_port_open() publishes the tty before it calls .activate(), so an
> +	 * open can go live between a sample and a later clear and never be
> +	 * hung up here.
> +	 */
> +	scoped_guard(mutex, &lstp_minors_lock)
> +		ctx->registered = false;
> +
> +	struct tty_struct *tty = tty_port_tty_get(&ctx->port);
> +
> +	if (tty) {
> +		/*
> +		 * Synchronous: fds move to hung_up_tty_fops and lstp_port_shutdown()
> +		 * cancels write_work, so no write is submitted after this returns.
> +		 */
> +		tty_vhangup(tty);
> +		tty_kref_put(tty);

tty_port_tty_vhangup()?

> +	}
> +
> +	tty_unregister_device(lstp_tty_driver, ctx->minor);
> +}
thanks,
-- 
js
suse labs
