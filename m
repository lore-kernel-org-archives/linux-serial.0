Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794839955;
	b=4mcKqMSiDArOtnMonMh/9VEPs2LulWDV0wzbHLAusrZf76SiTobAR8HZU7cT5J/zHKZc
	 pQM2jxQQK4OZOPJHsniyFZOO+VaV015YoPCQe5q9D0NwgFkP8Ms93Mq9Y/5UWkZlTPp68
	 wstAGZgbogoCeELf5UJER44+cHYNHJUeIrK6sgCdA3GYKMeCZkjrFGqv/fcId/7YkptJR
	 +oibTN3qvcKIX2XQEAsr4e064Wam7oOsVsd7+z9IibfEDBIRZNBGYQDGYcgMJ+neWRwGJ
	 gWiTbpKAII2hBD7rc/2mZKDfsN+Osyf9C9tSR6oYqOaJE3SaofnDvcEYkRRZe6bQA+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794839955;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=i6ILREIqYcFDP5vxsGtNivMUpqP+s5K/w7Ye/l6YwWc=;
	b=WVwVIG5igONl1zg+oWImMvhlmE8JGKyJd3WepGRBc6duWY3yXG6gh/Xq6inbxFHsP/pc
	 VZeiAXV2SO/E9Zke2Yy3ZuRDR3w9sXM+jDU/zWhLPpp/cssb4D2O5o9LvSiWLRDj9//OJ
	 BMciEQ5vgiBc7aAPZvIMcoXKeemvH6TxvRsKP/7YArivqCntRIDF8H1aOnwXymS1Ymgsl
	 RBvcHo5tPOYKoNK0pPYKRUBnUCMNM+z5wLiok1nwwxQNL5M5QTRhfAvD6FamaiHRnU0kE
	 suktIfeTYaqsfM2aFrCsfXEhmJdHaCi01JO+YB+0KiKGx8ebSJ9FDMoC9hALrIcjQ6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M98brw8P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2762606A31C
	for <linux-serial@vger.kernel.org>; Mon, 16 Nov 2026 14:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M98brw8P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E281F000C5;
	Mon, 16 Nov 2026 14:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794839955;
	bh=i6ILREIqYcFDP5vxsGtNivMUpqP+s5K/w7Ye/l6YwWc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M98brw8PPYKluSFLW+efTJh9GmItrd4xCG7pQoOsPKavH0+flygdIAd6o0pTbqwlg
	 JivO+NYVjftHf5vvp7qse2ielFQUV5jRhO9lRB6p3JbA2+aeT4qpWGBmtdpGToxB1q
	 UtU3RoxTS3fK0GAhz7K8xzJhAaXb6kMDgVvPeO5vShiVDqwwHi4awJubKCxHkNc0Dw
	 Sw5gFM0GQSEXiaNedpITuB95iLzvbw8sN3KT4K5UtZilu6icdjZIpD3c5nLxky3RFE
	 l3h5PYjE+jiWeC5VYnEstY2aQbhxjFPQ4qlhJYqSf0lCfq06Da8hQN03WtUX3h77hr
	 TJO+Y1XPqhSgQ==
Message-ID: <sashiko-outbox-217183@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: 8250_aspeed_vuart: Fix potential stale port on
 probe failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guangshuo Li" <liguangshuo@mail.sdu.edu.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261116-c29ba55625-serial-aspeed@mail.sdu.edu.cn>
References: <20261116-c29ba55625-serial-aspeed@mail.sdu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 14:39:15 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] serial: 8250_aspeed_vuart: use-after-free in
  aspeed_vuart_remove() [1]
--

commit 4eac67f7d5031d7988614ed386938a68b8050e5b
Author: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>

serial: 8250_aspeed_vuart: Fix potential stale port on probe failure

This commit disables the VUART, shuts down its unthrottle timer, and
unregisters the 8250 port when LPC configuration fails during probe.

> diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/se=
rial/8250/8250_aspeed_vuart.c
> index c8dc87f6886c1..2cd1c9146ec89 100644
> --- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
> +++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c

[ ... ]

> @@ -543,6 +543,10 @@ static int aspeed_vuart_probe(struct platform_device=
 *pdev)
> =20
>  	return 0;
> =20
> +err_unregister_port:
> +	aspeed_vuart_set_enabled(vuart, false);
> +	timer_shutdown_sync(&vuart->unthrottle_timer);
> +	serial8250_unregister_port(vuart->port);

[Severity: Critical]
This problem wasn't introduced by this patch, but can [1]
aspeed_vuart_remove() cause a use-after-free on vuart when
unthrottle_timer is re-armed during removal?

drivers/tty/serial/8250/8250_aspeed_vuart.c:aspeed_vuart_remove() {
	struct aspeed_vuart *vuart =3D platform_get_drvdata(pdev);

	timer_delete_sync(&vuart->unthrottle_timer);
	aspeed_vuart_set_enabled(vuart, false);
	serial8250_unregister_port(vuart->port);
	sysfs_remove_group(&vuart->dev->kobj, &aspeed_vuart_attr_group);
}

Because aspeed_vuart_remove() calls timer_delete_sync() instead of
timer_shutdown_sync() before serial8250_unregister_port(), a UART
interrupt arriving while the TTY flip buffers are full can re-arm
vuart->unthrottle_timer before the port is unregistered:

CPU0                                  CPU1
aspeed_vuart_remove()
  timer_delete_sync(&vuart->unthrottle_timer)
                                      aspeed_vuart_handle_irq()
                                        if (!space)
                                          mod_timer(&vuart->unthrottle_time=
r, ...)
  serial8250_unregister_port(...)
  // vuart freed by devres on return
                                      aspeed_vuart_unthrottle_exp()
                                        <-- use-after-free

Unregistering the port before stopping the timer, or using
timer_shutdown_sync() as this patch does on the probe error path, would
prevent the timer from being re-armed.

[1] https://sashiko.dev/#/bug/linux-2b3eb48a-af6f-4ebd-a642-413d2498b067

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-c29ba55625=
-serial-aspeed@mail.sdu.edu.cn?part=3D1
