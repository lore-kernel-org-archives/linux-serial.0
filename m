Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BD43C8732;
	Fri, 31 Jul 2026 08:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785486253; cv=none; b=Wzh8TEChpKCjMRTS736SRg+MoStOA/vi3bos2AA0+JvLgF+PSd9zMug8W5Kw1yQeJSl5y/rFRYpUZnM3XP9Tuf1jYTBB/qanMZxRENyD27U+VgUWRDi4LB9T33uP0w8mgV3Z2jMv9x0TLgOjvJVkSrFpdhDKM5nrIchhkebi2SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785486253; c=relaxed/simple;
	bh=uaT3RI9nmflxJ/7kpxRGyP5PQy9sTyvrAmRO6ZGaK/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bZyKTjcpXHCAA0yzINCqb2nrud0Znbtby2+Lc5ZEWkhvASSZEKeVpCNHGZrMCNPhzewHFPuG+cZKYeMm+U6hs/c+xLNcgI1LlyCOsGyHXt9nh7qbB+ndlhneNagGRxb1SMcYsa1Gqb6xbK2MiGW1xcpLVqyml221r/DIpg9TTYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIXMKy60; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIXMKy60"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 034D81F00A3A;
	Fri, 31 Jul 2026 08:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785486245;
	bh=1ESc4CQiJNiqVcMcL70lkVes9YgcpmoNar7aC6kk5vg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=PIXMKy60rzCTasYVYIKP3FpEHK+Q/W1RWY5Ua0w3WheXGCZLCWL0Pc64a6eMvEIT/
	 XCB6/UUJMuvR/gXfaxa5dZ/g/UxHBUOQxpuj9vaFxV7h6TYCtQOZf4l7pPmrlgIfW6
	 FcSCxsD3vrYgyN5YXXMXyisLuih6jM4OsdlxatHvpv69zu8svYbcEn2MZfHETPaKc4
	 x83oltuAvkc5hl8mD3bnBcGJROskEyxcUHYtvn+2HBOgXntJO8Xvk98nIc48/EYs36
	 5ShcE7GtHH3s225VhW+QY3ddzReVmg9399XIRjG3si1Z6AJC1LE/xK2ub4jrFewDgN
	 qpLJ4C4jsP4bw==
Message-ID: <d6d96f15-03f5-4213-9d7c-145b5a8c3f79@kernel.org>
Date: Fri, 31 Jul 2026 10:24:02 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] serdev: use tty_port_tty_get() in ttyport_write_buf()
 to prevent UAF
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Markus Probst <markus.probst@posteo.de>, linux-serial@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
 Joshua Rogers <linux@joshua.hu>, stable <stable@kernel.org>
References: <20260731-aisle-tty-serdev-v1-0-2401a3189327@linuxfoundation.org>
 <20260731-aisle-tty-serdev-v1-2-2401a3189327@linuxfoundation.org>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20260731-aisle-tty-serdev-v1-2-2401a3189327@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31. 07. 26, 10:06, Greg Kroah-Hartman wrote:
> From: Joshua Rogers <linux@joshua.hu>
> 
> ttyport_write_buf() snapshots serport->tty as a raw pointer without
> taking a reference, while ttyport_close() can concurrently release the
> tty via tty_release_struct(), leading to a use-after-free. Use
> tty_port_tty_get() to obtain a reference-counted tty pointer, matching
> the pattern already used by ttyport_write_wakeup().
> 
> Assisted-by: AISLE:Snapshot
> Cc: stable <stable@kernel.org>
> Signed-off-by: Joshua Rogers <linux@joshua.hu>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>   drivers/tty/serdev/serdev-ttyport.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
> index 48ce5b3f8308..4d37c8130dd7 100644
> --- a/drivers/tty/serdev/serdev-ttyport.c
> +++ b/drivers/tty/serdev/serdev-ttyport.c
> @@ -85,13 +85,21 @@ static const struct tty_port_client_operations client_ops = {
>   static ssize_t ttyport_write_buf(struct serdev_controller *ctrl, const u8 *data, size_t len)
>   {
>   	struct serport *serport = serdev_controller_get_drvdata(ctrl);
> -	struct tty_struct *tty = serport->tty;
> +	struct tty_struct *tty;
> +	ssize_t ret;
>   
>   	if (!test_bit(SERPORT_ACTIVE, &serport->flags))
>   		return 0;
>   
> +	tty = tty_port_tty_get(serport->port);
> +	if (!tty)
> +		return 0;
> +
>   	set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
> -	return tty->ops->write(serport->tty, data, len);
> +	ret = tty->ops->write(tty, data, len);
> +	tty_kref_put(tty);

Here,

   scope_guard(tty_port_tty, serport->port) {
     struct tty_struct *tty = scoped_tty();

     set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
     return tty->ops->write(serport->tty, data, len);
   }

   return 0;

appears to be cleaner.

thanks,
-- 
js
suse labs
