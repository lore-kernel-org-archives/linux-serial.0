Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794981913;
	b=Jf9EFPpUxvj/odugUZ3E3jKezgGd+NL44yvHn65E2eeLnr4fhmz3amRV2tKhRhUUnk3J
	 eP67rZ2cAWiMU0x5U9S+foP8LrqjUAps7r45LJv48qh0zcyA06zHpydn9ObO1+qYHwyiE
	 QX905D2OCXE/798VIEhVuTmZEcGNjw1CGX/UOC/s0c3DMBcF75Xffvn1kTwpXwUW861Vn
	 1tTGuybBuzc5aN4Iio+WNftfyghCAeYNx8+R4dPk3wMWfxzyGPUaZj7JHH2mfnsptWOYO
	 teuz2nig+eQXRydEW5bpwSdDWdmLyxLURYenjF7JQ/DEFvCFnkt9YZo3DRpeYugWqjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794981913;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=k58+4VXumWGm9ydGG3fAL2iecNdWFj/ZkuOieURvByk=;
	b=FGphQ462h1yYYZjFFgcTw4qKutjHa/Ska9HbNLUaapl8Bhub9gTTcxRgC8mx8jsn4Ss6
	 GuWRVUAhyKYDaESNuBJ63jQeb+SQtSvO4wLeD6p2Y7mNFtph4dGWT3jxIPMtGGvSQ7RgC
	 Xzgt4j+qn//G1l05WjRhV3Xq4wkver35fU3pmK/D3qfOdtSfFmg6owo1CU81DQUyUpZii
	 AKgPvwpDuk/2fOGl/+z16919YSvTdASJvhWZOxlBDu6dQLbhNjAAOHUIiiVa+0/P0AQfc
	 55VAIndKOZB2MlStKAmqG34UGO2H4cfv6/zUtRU7PF+ZbnBtYlEH60z89oA3E3SLHQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h2oEGXOw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5FD606A32A;
	Wed, 18 Nov 2026 06:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h2oEGXOw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA161F000C5;
	Wed, 18 Nov 2026 06:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794981913;
	bh=k58+4VXumWGm9ydGG3fAL2iecNdWFj/ZkuOieURvByk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=h2oEGXOwQgCgElRbTyIldi8uLq96Kx+N96A5oJpT3BKf/gub7hZW+mICf2Vti9B2o
	 Vnyecs3EHbpHYwXoLNVQooB1Yzgu3ViR7ZIClzS41FcJ5z7pEHPq6jtKr8HjzyezTI
	 JItzc2qVG0reshFe8j+maCLTrqHpgaOcfCTdhegEJWAFEnAieaFplztc6r9ZI3Tef9
	 4Ihn2v/6SugaziIaIV33JEh+AtB4mm2eaMisA1BDs1jlbkT5hQnCO37TL29V6VEThn
	 g0J4ZHic40MRuFZBmNBCRPCsgTTkMkPHDMcU0u8ZGuq1jsNPkDzdKNGu/bqD16Q3PG
	 42O3oKWphWotw==
Message-ID: <86eea37d-632d-4c8a-b548-63907c7adee2@kernel.org>
Date: Wed, 18 Nov 2026 07:05:09 +0100
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
Subject: Re: [PATCH] tty: vt: protect tty lifetime in keyboard path
To: Haoli Zhang <26031212468@stu.xidian.edu.cn>, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 syzbot+2932e8970a6398db95c3@syzkaller.appspotmail.com,
 25031212117@stu.xidian.edu.cn, byu@xidian.edu.cn
References: <20261117091207.3950936-1-26031212468@stu.xidian.edu.cn>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20261117091207.3950936-1-26031212468@stu.xidian.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17. 11. 26, 10:12, Haoli Zhang wrote:
> The KASAN report reaches stop_tty() through fn_hold(). That handler
> reads vc->port.tty and uses it without holding a tty reference. It runs
> under kbd_event_lock, while con_shutdown() clears the port association
> under console_lock; these locks do not protect the tty lifetime.
> 
> Use the tty_port_tty guard in fn_hold() and keep the reference until
> start_tty() or stop_tty() returns. Keep kbd_keycode()'s existing tty
> reference interval unchanged.
> 
> Use tty_port_tty_set() when installing and clearing the association so
> that updates use the same port lock as guarded reads and the port holds a
> tty reference while the association is active. A keyboard operation
> that already obtained a reference can then finish safely after shutdown
> clears the association.
> 
> Reported-by: syzbot+2932e8970a6398db95c3@syzkaller.appspotmail.com
> Closes: https://syzbot.org/bug?extid=2932e8970a6398db95c3
> Co-developed-by: Jinning Zhang <25031212117@stu.xidian.edu.cn>
> Signed-off-by: Jinning Zhang <25031212117@stu.xidian.edu.cn>
> Co-developed-by: Bin Yu <byu@xidian.edu.cn>
> Signed-off-by: Bin Yu <byu@xidian.edu.cn>
> Signed-off-by: Haoli Zhang <26031212468@stu.xidian.edu.cn>
> 
> ---
>   drivers/tty/vt/keyboard.c | 34 ++++++++++++++++++++--------------
>   drivers/tty/vt/vt.c       |  4 ++--
>   2 files changed, 22 insertions(+), 16 deletions(-)
> 
> --- a/drivers/tty/vt/keyboard.c
> +++ b/drivers/tty/vt/keyboard.c
> @@ -509,20 +509,26 @@
>   
>   static void fn_hold(struct vc_data *vc)
>   {
> -	struct tty_struct *tty = vc->port.tty;
> -
> -	if (rep || !tty)
> -		return;
> -
> -	/*
> -	 * Note: SCROLLOCK will be set (cleared) by stop_tty (start_tty);
> -	 * these routines are also activated by ^S/^Q.
> -	 * (And SCROLLOCK can also be set by the ioctl KDSKBLED.)
> -	 */
> -	if (tty->flow.stopped)
> -		start_tty(tty);
> -	else
> -		stop_tty(tty);
> +	struct tty_struct *tty;
> +
> +	if (rep)
> +		return;
> +
> +	scoped_guard(tty_port_tty, &vc->port) {
> +		tty = scoped_tty();
> +		if (!tty)
> +			return;

I am not sure whether you are a bot, but this is obviously wrong.

-- 
js
suse labs
