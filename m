Received: from ocn-dfr-mts-113c2.ocn.ad.jp (ocn-dfr-mts-113c2.ocn.ad.jp [153.128.190.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946DD3F58E8;
	Sat, 15 Aug 2026 07:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=153.128.190.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786779871; cv=none; b=htxHuqQntcXvy0RZ5YE9bSuD/fuDURzkzXKQk3e4IkW/M/qLwXLp+eyAP5HBqkGVlqnCfLIbywsFMhOnbGQZJqt2lnzcC/Edo9uBFqC/wraxclexRx7fvA1Y472fFwivGwTzi9jkQkDEeNGwoKzscEH1ui09gvNNfe6VXQU6npA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786779871; c=relaxed/simple;
	bh=MbCY+tED5EWgOKaWY+wFJVszaGqUYlwmB9GiuNU07GE=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RmvuY8uoX9rxXLPJfy4Aoy5/H98OpHKnpOeReDOR0CnqaJzsyMf8+hXY7HfgnbCtc0VXnSNlHnYzne08yQ5QRKbyN2kdmtlnnl5TG84MV4QT+xfE/OkV2z6/q3j76Vbt0O0m0W8+9Bh3cwtlzMEBzMxtC+OXt/DGNfWCxlu+iPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mba.ocn.ne.jp; spf=pass smtp.mailfrom=mba.ocn.ne.jp; dkim=pass (2048-bit key) header.d=mba.ocn.ne.jp header.i=@mba.ocn.ne.jp header.b=WXN3OHLR; arc=none smtp.client-ip=153.128.190.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mba.ocn.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mba.ocn.ne.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mba.ocn.ne.jp header.i=@mba.ocn.ne.jp header.b="WXN3OHLR"
Received: from ocn-ckd-mts-118c32.ocn.ad.jp (ocn-ckd-mts-118c32.ocn.ad.jp [122.28.129.97])
	by ocn-dfr-mts-113c2.ocn.ad.jp (Postfix) with ESMTP id 7997E1C000258;
	Sat, 15 Aug 2026 16:36:34 +0900 (JST)
Received: from ocn-spm-mts-102c1.ocn.ad.jp (ocn-spm-mts-102c1.ocn.ad.jp [153.128.190.228])
	by ocn-ckd-mts-118c32.ocn.ad.jp (Postfix) with ESMTP id 0FE3F68007103;
	Sat, 15 Aug 2026 16:36:27 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mba.ocn.ne.jp;
	s=20240118; t=1786779387;
	bh=MbCY+tED5EWgOKaWY+wFJVszaGqUYlwmB9GiuNU07GE=;
	h=Date:To:Cc:Subject:From:In-Reply-To:References:From;
	b=WXN3OHLRwGogBKwIwkSAc3uRjfOfqFSVzX39nABGwZIKWMMsylNHZhcx52I3n72c2
	 5LRnZSuPgr6+2u/gIiHgPp9c9uRROa8Rn/Dt9g8xlmBpTaV07haGSkeMkAnKwurRGS
	 /xOpR3t+HJpniZ8j1mJYWTR6E7aGKWF2kO8MoY3zPS5Jw2l3ETWPjUZqpfZFon+tl9
	 AWgFKnsJi6xM1rOGP4ry3JywJfXhD18FgHvtNCxDNMz0m9GLB2koGTkWU7fautSR8A
	 wAN2SUrvdDvAVuiNIMtvXE+O7DRbB98zez/Z6m4tn3pinBjjKqW9hDdekJ1l4RyK2q
	 uj26ZeCDEtuaA==
Received: from ocn-vc-mts-110c1.ocn.ad.jp ([153.149.236.162])
 by ocn-spm-mts-102c1 with ngmta
 id beed6ee8-18cbea62bd6dbdd8; Sat, 15 Aug 2026 16:36:27 +0900
Received: from ocn-sdpx-mts-113c1.ocn.ad.jp ([153.128.117.211])
 by ocn-vc-mts-110c1 with ngmta
 id 58488311-18cbea62aff71174; Sat, 15 Aug 2026 16:36:26 +0900
Received: from localhost (p1601136-ipoe.ipoe.ocn.ne.jp [114.172.254.135])
	by ocn-sdpx-mts-113c1.ocn.ad.jp (Postfix) with ESMTPA;
	Sat, 15 Aug 2026 16:36:26 +0900 (JST)
Date: Sat, 15 Aug 2026 16:36:23 +0900 (JST)
Message-Id: <20260815.163623.821342571660046378.anemo@mba.ocn.ne.jp>
To: u.kleine-koenig@baylibre.com
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
 andriy.shevchenko@linux.intel.com, john.ogness@linutronix.de,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 geert@linux-m68k.org
Subject: Re: [PATCH v3 2/7] serial: txx9: Drop usage of uart_match_port()
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <b9287ba4b13b32a11765c0532db5d34843227373.1786697789.git.u.kleine-koenig@baylibre.com>
References: <cover.1786697789.git.u.kleine-koenig@baylibre.com>
	<b9287ba4b13b32a11765c0532db5d34843227373.1786697789.git.u.kleine-koenig@baylibre.com>
X-Mailer: Mew version 6.8 on Emacs 30.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Aug 2026 11:19:28 +0200, Uwe Kleine-K=F6nig (The Capable Hub=
) <u.kleine-koenig@baylibre.com> wrote:
> -		if (uart_match_port(uart, port)) {
> +		/*
> +		 * serial_txx9_register_port() is only called from
> +		 * pciserial_txx9_init_one(). So .iotype is UPIO_PORT and
> +		 * comparing .iobase serves to distinguish ports.
> +		 */
> +		if (uart->iobase =3D=3D port->iobase) {

Thank you for adding this comment.

Reviewed-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

---
Atsushi Nemoto
