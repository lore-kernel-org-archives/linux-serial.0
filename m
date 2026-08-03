Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5EF371CF4;
	Mon,  3 Aug 2026 17:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785778051; cv=none; b=Uq4Jh8IKVzwUeFkQ1XRXohgKpd2FyEqmJehWsB9KU0AUJGzY9y2SEvUztyA+/Lcr2h5OtVaqACf9tlLHa8p4Bev9IJtJY53Ulib5izZHtWfurRCJ5tpyXMTbr58KrF9OHWWFqUknwGNZOF7EW9lGTDTgPG6TfN6R4iI5GxIuBMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785778051; c=relaxed/simple;
	bh=bf8eVeMY1Y2aungtS4aq8DzYgti/ZTDBg7jHIfXxK2I=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=thmIcr24AFY6t+FmLGyXBHVu2atqIn2WQbCShFkISWCyqo3MjRui6iiJAbLm9rGBmUD4QN8LcObvGx6cttlXatu1soo/qxa4T4aFgMEZtbFE/WGoA2pgSo5udJvcykRUQm0QU9vcnHh5yVGq6n0Rgyz6oelKAC7Lc6Fr8cksvMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f45/nsZN; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f45/nsZN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785778050; x=1817314050;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=bf8eVeMY1Y2aungtS4aq8DzYgti/ZTDBg7jHIfXxK2I=;
  b=f45/nsZNBUEpyuCGCksL11p+v1QPZzYfsyb2374GZS+xpRJEY6TYu9+F
   /0yflxqRpsp+ZWLrBgWrDvQ3w+N/Uh8Wb4BRvZG3fluVWb6dzeorJ8oDZ
   J8u4AHX9Y/1OM+wi7oyxNPtxeb1QXKxH05Nue7mL4EhpGfVSGpDT1Aj2n
   4zNHjxIZN0qL8EO/dl5p6jVrnZCcQhzpCqMwLJ7ghdWJENFfRpVr6hx4I
   pk1lri3NwYWR/h+nAsrAAIWBVsthyq2on7S91YbsycYrQkHwA8u3EZVn5
   q8BAOYs1/cJ3iLG7++f1eO2sFeT+tAGgwp4EPc7AWlvuISGGvxEjYK9Pg
   Q==;
X-CSE-ConnectionGUID: iLEmRKG6TYuCVdw8KrEY4g==
X-CSE-MsgGUID: wFCYUE0YSVCZWHE5nUWCPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="97691836"
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="97691836"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 10:27:29 -0700
X-CSE-ConnectionGUID: Vk00Um84Sdi7D13noxfYdA==
X-CSE-MsgGUID: tLMJB50LR4uzrWPbyy0YMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="258611480"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 10:27:26 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 3 Aug 2026 20:27:22 +0300 (EEST)
To: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <ukleinek@kernel.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
    John Ogness <john.ogness@linutronix.de>, linux-kernel@vger.kernel.org, 
    linux-serial@vger.kernel.org
Subject: Re: [PATCH v1 2/6] serial: txx9: Drop usage of uart_match_port()
In-Reply-To: <c785f3269794934d126909719e94d5ad6c35f7dc.1785489518.git.ukleinek@kernel.org>
Message-ID: <01a84877-9cc7-8136-d5a8-e368a36cda93@linux.intel.com>
References: <cover.1785489518.git.ukleinek@kernel.org> <c785f3269794934d126909719e94d5ad6c35f7dc.1785489518.git.ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1996484965-1785778042=:1172"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1996484965-1785778042=:1172
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 31 Jul 2026, Uwe Kleine-K=C3=B6nig wrote:

> In this driver .iotype is always UPIO_PORT. So uart_match_port() is
> equivalent to comparing .iobase. Remove the call to uart_match_port()
> which then only has a single caller that is handled in the next commit.

Not directly related to the change. The txx9 driver seems to have some=20
iotype switch/cases as well so some !UPIO_PORT deadcode too.

--=20
 i.

> Signed-off-by: Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org>
> ---
>  drivers/tty/serial/serial_txx9.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/tty/serial/serial_txx9.c b/drivers/tty/serial/serial=
_txx9.c
> index 5ed20129b44b..2368081c3742 100644
> --- a/drivers/tty/serial/serial_txx9.c
> +++ b/drivers/tty/serial/serial_txx9.c
> @@ -965,7 +965,7 @@ static int serial_txx9_register_port(struct uart_port=
 *port)
>  =09mutex_lock(&serial_txx9_mutex);
>  =09for (i =3D 0; i < UART_NR; i++) {
>  =09=09uart =3D &serial_txx9_ports[i];
> -=09=09if (uart_match_port(uart, port)) {
> +=09=09if (uart->iobase =3D=3D port->iobase)
>  =09=09=09uart_remove_one_port(&serial_txx9_reg, uart);
>  =09=09=09break;
>  =09=09}
>=20

--8323328-1996484965-1785778042=:1172--
