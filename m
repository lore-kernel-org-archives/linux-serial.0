Received: from ocn-dfr-mts-118c1.ocn.ad.jp (ocn-dfr-mts-118c1.ocn.ad.jp [153.128.190.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1414D23BD05;
	Tue,  4 Aug 2026 23:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=153.128.190.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785885953; cv=none; b=XATz8ucWQcomZwAb5usvfVWY2jrbt9bbOQovHcZWYfUq8cx8VGZowJlvPPP/c4kQJ5dLeRF14MXr2VzZTGywNwqEFH6aXrnmieJgE1IMkvdbY30cSQ5lnCCigeT0DghEmqIAxKHPocFbxGX7WAdsdt/obk9ID0X+AUdOTlogSd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785885953; c=relaxed/simple;
	bh=VALEo/ahxTMDTNo/Z/H27S+F4UD6TMiR7VSBV4+z1S8=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Vv4nld4YNixKge2txHRL0znPMUuh/4BQnBU/iya1r4/xZS/09DEkngbMHdFf30g2dpv8nDxolSUn5zKtsJ5GOGlsMTx2IFXUkbD+6+jwtwmd/cojhjuvrIeP1G8qFLhSYv1GE6y3LgkAZJMFtVjoIcnb/SEEY7QbgpAWg+dgC3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mba.ocn.ne.jp; spf=pass smtp.mailfrom=mba.ocn.ne.jp; dkim=pass (2048-bit key) header.d=mba.ocn.ne.jp header.i=@mba.ocn.ne.jp header.b=J74u29gT; arc=none smtp.client-ip=153.128.190.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mba.ocn.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mba.ocn.ne.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mba.ocn.ne.jp header.i=@mba.ocn.ne.jp header.b="J74u29gT"
Received: from ocn-ckd-mts-113c35.ocn.ad.jp (ocn-ckd-mts-113c35.ocn.ad.jp [180.37.194.228])
	by ocn-dfr-mts-118c1.ocn.ad.jp (Postfix) with ESMTP id 6907094;
	Wed,  5 Aug 2026 08:18:04 +0900 (JST)
Received: from ocn-spm-mts-105c1.ocn.ad.jp (ocn-spm-mts-105c1.ocn.ad.jp [153.128.190.234])
	by ocn-ckd-mts-113c35.ocn.ad.jp (Postfix) with ESMTP id 7BD9B3C0024B7;
	Wed,  5 Aug 2026 08:17:56 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mba.ocn.ne.jp;
	s=20240118; t=1785885476;
	bh=VALEo/ahxTMDTNo/Z/H27S+F4UD6TMiR7VSBV4+z1S8=;
	h=Date:To:Cc:Subject:From:In-Reply-To:References:From;
	b=J74u29gTIE78a5Lf0MU8wOiuoGNhP0D1TIH/JJReIQbSW4/bN7HY5DtqNSgYGM385
	 4+nhhT6hrPprQlaw4+pqZFZr+xvo8jsIAhsdnEsh62oTsvCTOgkcf5iYpbdxIYDLgV
	 BfHg7KIBSfn1F6x4wU/YjPbatAwEDYP9I+iIzZj8Kn405waVzNH+JFprIY8UZV0o/g
	 Fs6lwBW2KhmaGNLNZbhzKAG4S5JnKVoL/H1HejTA0mvo5m5ts6jGvkI0Kx5daxLwcw
	 YtAszhiwHe/fQfIlGmjKx+FhurrRalVqmCoupCT+UpMcQnr9Xwfkaa3vV3q8PffhtH
	 xaaDnrFr//5Hw==
Received: from ocn-vc-mts-109c1.ocn.ad.jp ([153.149.236.232])
 by ocn-spm-mts-105c1 with ngmta
 id a5f4a8cb-18c8bd60f799d5ab; Wed, 05 Aug 2026 08:17:56 +0900
Received: from ocn-sdpx-mts-108c1.ocn.ad.jp ([153.128.117.196])
 by ocn-vc-mts-109c1 with ngmta
 id 8b177f4f-18c8bd60e81bb38a; Wed, 05 Aug 2026 08:17:56 +0900
Received: from localhost (p1601136-ipoe.ipoe.ocn.ne.jp [114.172.254.135])
	by ocn-sdpx-mts-108c1.ocn.ad.jp (Postfix) with ESMTPA;
	Wed,  5 Aug 2026 08:17:56 +0900 (JST)
Date: Wed, 05 Aug 2026 08:17:53 +0900 (JST)
Message-Id: <20260805.081753.200260969789487834.anemo@mba.ocn.ne.jp>
To: u.kleine-koenig@baylibre.com
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
 hvilleneuve@dimonoff.com, john.ogness@linutronix.de,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Geert
 Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 3/8] serial: txx9: Drop usage of uart_match_port()
From: anemo <anemo@mba.ocn.ne.jp>
In-Reply-To: <35779acb88c9507af9ac68bc026070bbc20b33a6.1785832297.git.u.kleine-koenig@baylibre.com>
References: <cover.1785832297.git.u.kleine-koenig@baylibre.com>
	<35779acb88c9507af9ac68bc026070bbc20b33a6.1785832297.git.u.kleine-koenig@baylibre.com>
X-Mailer: Mew version 6.8 on Emacs 30.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue,  4 Aug 2026 10:57:55 +0200, Uwe Kleine-K=F6nig (The Capable Hub=
) <u.kleine-koenig@baylibre.com> wrote:
> In the txx9 driver .iotype is always UPIO_PORT. So uart_match_port() =
is
> equivalent to comparing .iobase. Remove the call to uart_match_port()=

> which then only has a single caller that is handled in the next commi=
t.

As I noted (and tested by Geert, thanks!) in reply for previous patch,
.iotype can be UPIO_MEM.

But now (with v2 1/8 patch applied) serial_txx9_register_port() is call=
ed
only from pciserial_txx9_init_one(), so .iotype is always UPIO_PORT in
this function.

Also, in pciserial_txx9_remove_one() path .iobase is cleared, so this
(uart->iobase =3D=3D port->iobase) condition never asserts (i.e. findin=
g
matching portis unneeded now).
But dropping this can be done in furthor cleanup.

So I'm OK with your patch as is for now.

On Tue,  4 Aug 2026 10:57:55 +0200, Uwe Kleine-K=F6nig (The Capable Hub=
) <u.kleine-koenig@baylibre.com> wrote:
> In the txx9 driver .iotype is always UPIO_PORT. So uart_match_port() =
is
> equivalent to comparing .iobase. Remove the call to uart_match_port()=

> which then only has a single caller that is handled in the next commi=
t.
> =

> Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@=
baylibre.com>
> ---
>  drivers/tty/serial/serial_txx9.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/drivers/tty/serial/serial_txx9.c b/drivers/tty/serial/se=
rial_txx9.c
> index bda7f7527b8d..8febc0549f76 100644
> --- a/drivers/tty/serial/serial_txx9.c
> +++ b/drivers/tty/serial/serial_txx9.c
> @@ -911,7 +911,7 @@ static int serial_txx9_register_port(struct uart_=
port *port)
>  	mutex_lock(&serial_txx9_mutex);
>  	for (i =3D 0; i < UART_NR; i++) {
>  		uart =3D &serial_txx9_ports[i];
> -		if (uart_match_port(uart, port)) {
> +		if (uart->iobase =3D=3D port->iobase) {
>  			uart_remove_one_port(&serial_txx9_reg, uart);
>  			break;
>  		}
> -- =

> 2.55.0.11.g153666a7d9bb
