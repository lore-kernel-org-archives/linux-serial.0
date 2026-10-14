Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F7739734A
	for <linux-serial@vger.kernel.org>; Wed, 14 Oct 2026 06:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791960562; cv=none; b=knTvDZaL23ZaUHrzF+j9oLg4TlDxWt1gKxJnNJzbFKWmA0YR45ixjK9XdNkpfX0X23p2SMvpQbjiJF0vp4rDE9rPATFY0ILoOKglOA6BEqbtH793Yv4hJ9bvtPHNAJypB3hE2vMZs3QNnFXxlrm4KYwGPGeTWV3vzfQv6ceBRXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791960562; c=relaxed/simple;
	bh=HAgxiRjDfKMiC3yoh3eRMoLipYB0tfR+Jru2MWHJsbQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=HIqLytJJ9M/Vbw7u7XYGFPkIipeI4FNy09Ef2OUMUs60PPW6NKu/wWTeKAHDTF1CLfxLlXuJqYhs3uA6M9XlHEn9woZOjS39alLkarGCMCWA7+7b6QOqp+gs2iGdChlzNWFdfMAK5D4ukzYcFPHZYii7HPeo20fvuU9WhlyLxV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYWng9wv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYWng9wv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 545CB1F000FF;
	Wed, 14 Oct 2026 06:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791960561;
	bh=tYcyZkGcDB+z2LDNKpYgLwLoQVekfrg/3nxoFaiRk10=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PYWng9wvWnMXFyL6T+GloRX7s/pKsGatLLlx0fiai6Hdxx2pEA/lNhuB5JF22nhx6
	 DojzbggVtRH4khUugnfz6QXib5jZihB4UaCLdMFgJwrqQ1g5MagFn9AvPm1Ttv6dke
	 Zc5JWuo8R8+e57FaONUchklMF1ZqkxpUOcco5gpz+77S9en1VyynijwYfmnTz2J6c3
	 fye0fAlROBrIdg1Wl/GJBC2ihIJ28D3/IFT84kTUyO5sP2HZ6N4HAWpDbJPBnxmVv+
	 quwJz3MIqHlet32Sw4kxvM4xlAt0rt1V2EI1flOubE6QzG53Tv2/3KKbU6IQyKK5EZ
	 FNgUyQGpR0XjA==
Message-ID: <sashiko-outbox-170892@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/6] serial: 8250: drop err label from
 serial8250_register_8250_port()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SmlyaSBTbGFieSAoU1VTRSk=?= <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <baf799ad88f9ef43093ae96731f48a5e88d726dd.1791873876.git.jirislaby@kernel.org>
References: <cover.1791873876.git.jirislaby@kernel.org>
 <baf799ad88f9ef43093ae96731f48a5e88d726dd.1791873876.git.jirislaby@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 06:49:20 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] tty: serial: 8250: missing cancel_delayed_work_sync() for overrun_=
backoff
- [High] tty: serial: 8250: workqueue list corruption via INIT_DELAYED_WORK=
()
--

commit c4166af59c093eb0e0aed408aac8356ad1cf88f2
Author: Jiri Slaby (SUSE) <jirislaby@kernel.org>

serial: 8250: drop err label from serial8250_register_8250_port()

This commit refactors serial8250_register_8250_port() to eliminate
goto-based error handling while holding a guard() lock. The port
configuration logic is moved into a new helper,
__serial8250_register_8250_port(), which returns an int and uses plain
returns on failures. The caller then handles resetting uart->port.dev in a
single place.

> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/825=
0/8250_core.c
> index 11424fef7c08b..7ff307ce6aa88 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -743,46 +743,12 @@ static void serial_8250_overrun_backoff_work(struct=
 work_struct *work)
>  	serial_out(up, UART_IER, up->ier);
>  }

[Severity: High]
Can this background work access hardware registers after the port is
unregistered?

When a port is removed (such as during hot-unplug or driver unbind), it
appears there is no matching cancel_delayed_work_sync() for the
overrun_backoff work.=20

If the device memory is unmapped and the delayed work executes, will this
serial_out() trigger a synchronous external abort or use-after-free?

[ ... ]

> @@ -927,9 +891,51 @@ int serial8250_register_8250_port(const struct uart_=
8250_port *up)
>  	}
> =20
>  	return ret;
> +}

[Severity: High]
Does this new helper unconditionally re-initialize the delayed work without
checking if it is already pending?

If a device is unbound and then rebound while the overrun_backoff work is
still pending, __serial8250_register_8250_port() is called again. Towards t=
he
end of the helper, the work is initialized:

	if (up->overrun_backoff_time_ms > 0) {
		...
		INIT_DELAYED_WORK(&uart->overrun_backoff,
				serial_8250_overrun_backoff_work);
	}

Re-initializing an active delayed work item with INIT_DELAYED_WORK() calls
INIT_LIST_HEAD() on its list nodes.

Can this corrupt the timer or workqueue linked lists if the work is still
active from a previous registration?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791873876.gi=
t.jirislaby@kernel.org?part=3D1
