Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0C1270ED5;
	Wed, 11 Jun 2025 13:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749647358; cv=none; b=uzepgmWNF/2x/PU0VGSJ0jOfnEHSS/xvI8QBJkcXWjVCH2YIkav4EuHtBpN+sloXTCZ+RyYLs2MkBVCczt+FvMIeemsFaZ5Gbnn/yk5E5ac24JfMmdoXNKhpDAvKh4NzmvgAB2Jb77dG7ubPcZD3DEml0fIOS8pPWV0a+02eN/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749647358; c=relaxed/simple;
	bh=4GuMQVvjJS+NeB3GJxegmcVN/9iZnCKz1igcJRBGrsA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EssJkPTW2T7NvaRhd0llXvd9n/AS2P4UGpipiCU0IlwRPKmpveVUFGg1yMLjDPhhBpr1MqfAumZuJTdgvf4NzW+11nwfhM5X/R7SL7BnVlt7+r3JI5IkFqb0RC8n+BZcW7yzfXON/0AtgKpPXUcNS+dn3V6LCyWtsWwn4yklfTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fylOoAU4; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fylOoAU4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749647356; x=1781183356;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=4GuMQVvjJS+NeB3GJxegmcVN/9iZnCKz1igcJRBGrsA=;
  b=fylOoAU40VYt50ltQLfWZ0m5VbZuAZrkJtm/pBd/5SUJQE//X2+q6sHt
   2mRyHjxP0p6YDiLXapzEolKXd33TNgBWHMMWFyH5tOk3j03hS/wNTFB1a
   boSdQ7CTqwA2jrLs+gJK/5KCLFj1S+f8cr7KB25jbRpZI0C4aYEAlmXNL
   EiKZyOzZr26/Pc2QejBExfX5ROutAoIkD4tuaDnl+mVooDH9/aMcLZ7QX
   jZ6IDrSg9Bs7mTC0pAmrwLs2AuZu9gqBTCoagJk7BhSw0jYar0I0M8bQN
   c0r5TT9pK7cRh6twd1+27IBqUw/qfcgOGzFSs8UoLYeAnSJbL/m8S3CSP
   g==;
X-CSE-ConnectionGUID: NZl30J/MQuGKSEZ2IWiD/w==
X-CSE-MsgGUID: zxW1jIg1Qu+lWPZarn740g==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="63136515"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="63136515"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 06:09:14 -0700
X-CSE-ConnectionGUID: bPiJ05nwTp2jgdyNqmSUxw==
X-CSE-MsgGUID: dobCd6EtTnOOFwmJm3PNUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="148103401"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.183])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 06:09:13 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 11 Jun 2025 16:09:08 +0300 (EEST)
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 27/33] serial: 8250: extract
 serial_get_or_create_irq_info()
In-Reply-To: <20250611100319.186924-28-jirislaby@kernel.org>
Message-ID: <5643b834-b9be-a70b-7669-a54be24845ad@linux.intel.com>
References: <20250611100319.186924-1-jirislaby@kernel.org> <20250611100319.186924-28-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1724197455-1749647348=:957"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1724197455-1749647348=:957
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 11 Jun 2025, Jiri Slaby (SUSE) wrote:

> This find-or-create-irq part of the serial_link_irq_chain()'s code is
> logically bounded and self-standing. For easier-to-follow code flow,
> extract the code to a separate function:
> serial_get_or_create_irq_info().
>=20
> This allows for an easier found-an-irq handling -- simple jump to the
> 'unlock' label and return. That results in one less 'if' levels.
>=20
> Note when using guard()s in the upcoming patchset, the label can dropped
> altogether.
>=20
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> ---
>  drivers/tty/serial/8250/8250_core.c | 37 ++++++++++++++++++++---------
>  1 file changed, 26 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/825=
0/8250_core.c
> index 7a6050f1c094..d42ceb6ffdc2 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -129,11 +129,15 @@ static void serial_do_unlink(struct irq_info *i, st=
ruct uart_8250_port *up)
>  =09}
>  }
> =20
> -static int serial_link_irq_chain(struct uart_8250_port *up)
> +/*
> + * Either:
> + * - find the corresponding info in the hashtable and return it, or
> + * - allocate a new one, add it to the hashtable and return it.
> + */
> +static struct irq_info *serial_get_or_create_irq_info(const struct uart_=
8250_port *up)
>  {
>  =09struct hlist_head *h;
>  =09struct irq_info *i;
> -=09int ret;
> =20
>  =09mutex_lock(&hash_mutex);
> =20
> @@ -141,20 +145,31 @@ static int serial_link_irq_chain(struct uart_8250_p=
ort *up)
> =20
>  =09hlist_for_each_entry(i, h, node)
>  =09=09if (i->irq =3D=3D up->port.irq)
> -=09=09=09break;
> +=09=09=09goto unlock;
> =20
> +=09i =3D kzalloc(sizeof(*i), GFP_KERNEL);
>  =09if (i =3D=3D NULL) {
> -=09=09i =3D kzalloc(sizeof(struct irq_info), GFP_KERNEL);
> -=09=09if (i =3D=3D NULL) {
> -=09=09=09mutex_unlock(&hash_mutex);
> -=09=09=09return -ENOMEM;
> -=09=09}
> -=09=09spin_lock_init(&i->lock);
> -=09=09i->irq =3D up->port.irq;
> -=09=09hlist_add_head(&i->node, h);
> +=09=09i =3D ERR_PTR(-ENOMEM);
> +=09=09goto unlock;
>  =09}
> +=09spin_lock_init(&i->lock);
> +=09i->irq =3D up->port.irq;
> +=09hlist_add_head(&i->node, h);
> +unlock:
>  =09mutex_unlock(&hash_mutex);
> =20
> +=09return i;
> +}
> +
> +static int serial_link_irq_chain(struct uart_8250_port *up)
> +{
> +=09struct irq_info *i;
> +=09int ret;
> +
> +=09i =3D serial_get_or_create_irq_info(up);
> +=09if (IS_ERR(i))
> +=09=09return PTR_ERR(i);
> +
>  =09spin_lock_irq(&i->lock);
> =20
>  =09if (i->head) {
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

Unrelated to the patch, I didn't like the use of 'i' as a variable name=20
to store a struct pointer.

--=20
 i.

--8323328-1724197455-1749647348=:957--
