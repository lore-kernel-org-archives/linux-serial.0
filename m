Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C01262FD9;
	Wed, 11 Jun 2025 11:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749640573; cv=none; b=NGJ0/+caxUKeZLAopY16ZNuNIpHfFCGx6B4bcTtOBJQRnSkiCZyYpe1zHEze4bzkDMgo6zgShxfIfy71ju/7EKe7JekT8qzhVwA3wxd97QfQxx8KYELfdN9WWbZDyfkXC0XYdogtjqgr0d9d3m+zUFnEDqr9v4kUKzDILp35d8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749640573; c=relaxed/simple;
	bh=eEuprULSjDVVLT+zB/HbzjMEOf6OXIWRVXtO+cApelo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=V0Q+lGlhCb3gYGYqzH4cT0N8QybgHuHpFVR75s4vzY1HQ5CFoRwEorv5xJcV/72/Bk/9q2JcJyk0AKHBHkadKgqQE0AWK2uGPAHYLUF/Q0wgZESpYe3bkc6DoM60LkFJYWoTwhfZWA35nYFo+7Zm/BRY/o7KCf5MpyfHTQzsQTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I50QKmE9; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I50QKmE9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749640572; x=1781176572;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=eEuprULSjDVVLT+zB/HbzjMEOf6OXIWRVXtO+cApelo=;
  b=I50QKmE9tEkgzxrIhQDj++G8iIzuObs0f9XwDqeInPFr8tfO2sCTdBI4
   mm4RtHXoUYxukj3uCijrrU4/6lOwRoU20zjYf/JOcxho0j3sz19tgSSs3
   D1sG8dWfJOMZrPoL+DiQ1Jvq9HcIrEJnb1Bltc4SzYTz3ABczqbKxy+XO
   12eLwJIu07VT61I4bMaa3a2/Jp7tudB0eqjgVH8/nuimKvMrNZvjJju6F
   c9eQpy4L0hkBLmJHkmshLGOuRUYHJCMaTqvcJGdiT+dYEfOsUAI24oGol
   8GyVX5fJ7JEKHfTCWUe1wt5QrfaXfuDhnZmI87jHpqn7X5P2huYNzg3/g
   g==;
X-CSE-ConnectionGUID: E7ixhMAlSS+L4MRVh7sh7A==
X-CSE-MsgGUID: Hti3FJ7LQ1uKTS3KBvnVKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="51771628"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="51771628"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 04:16:07 -0700
X-CSE-ConnectionGUID: Oio9/DKCSBqXcbPQylrduw==
X-CSE-MsgGUID: 8dq+FMXgTL+6hzXPi2hQyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="147044556"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.183])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 04:16:03 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 11 Jun 2025 14:15:59 +0300 (EEST)
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Madhavan Srinivasan <maddy@linux.ibm.com>, 
    Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
    Christophe Leroy <christophe.leroy@csgroup.eu>, 
    linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 02/33] powerpc/legacy_serial: cache serial port and info
 in add_legacy_port()
In-Reply-To: <20250611100319.186924-3-jirislaby@kernel.org>
Message-ID: <17b17aa3-dfd9-0e8d-b2a1-010637db29d7@linux.intel.com>
References: <20250611100319.186924-1-jirislaby@kernel.org> <20250611100319.186924-3-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1944227453-1749640559=:957"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1944227453-1749640559=:957
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 11 Jun 2025, Jiri Slaby (SUSE) wrote:

> Caching the port and info in local variables makes the code more compact
> and easier to understand.
>=20
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: linuxppc-dev@lists.ozlabs.org

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--
 i.

> ---
>  arch/powerpc/kernel/legacy_serial.c | 52 ++++++++++++++---------------
>  1 file changed, 26 insertions(+), 26 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/le=
gacy_serial.c
> index 1da2f6e7d2a1..d9080189c28c 100644
> --- a/arch/powerpc/kernel/legacy_serial.c
> +++ b/arch/powerpc/kernel/legacy_serial.c
> @@ -77,6 +77,8 @@ static int __init add_legacy_port(struct device_node *n=
p, int want_index,
>  =09=09=09=09  phys_addr_t taddr, unsigned long irq,
>  =09=09=09=09  upf_t flags, int irq_check_parent)
>  {
> +=09struct plat_serial8250_port *legacy_port;
> +=09struct legacy_serial_info *legacy_info;
>  =09const __be32 *clk, *spd, *rs;
>  =09u32 clock =3D BASE_BAUD * 16;
>  =09u32 shift =3D 0;
> @@ -110,16 +112,17 @@ static int __init add_legacy_port(struct device_nod=
e *np, int want_index,
>  =09if (index >=3D legacy_serial_count)
>  =09=09legacy_serial_count =3D index + 1;
> =20
> +=09legacy_port =3D &legacy_serial_ports[index];
> +=09legacy_info =3D &legacy_serial_infos[index];
> +
>  =09/* Check if there is a port who already claimed our slot */
> -=09if (legacy_serial_infos[index].np !=3D NULL) {
> +=09if (legacy_info->np !=3D NULL) {
>  =09=09/* if we still have some room, move it, else override */
>  =09=09if (legacy_serial_count < MAX_LEGACY_SERIAL_PORTS) {
>  =09=09=09printk(KERN_DEBUG "Moved legacy port %d -> %d\n",
>  =09=09=09       index, legacy_serial_count);
> -=09=09=09legacy_serial_ports[legacy_serial_count] =3D
> -=09=09=09=09legacy_serial_ports[index];
> -=09=09=09legacy_serial_infos[legacy_serial_count] =3D
> -=09=09=09=09legacy_serial_infos[index];
> +=09=09=09legacy_serial_ports[legacy_serial_count] =3D *legacy_port;
> +=09=09=09legacy_serial_infos[legacy_serial_count] =3D *legacy_info;
>  =09=09=09legacy_serial_count++;
>  =09=09} else {
>  =09=09=09printk(KERN_DEBUG "Replacing legacy port %d\n", index);
> @@ -127,36 +130,33 @@ static int __init add_legacy_port(struct device_nod=
e *np, int want_index,
>  =09}
> =20
>  =09/* Now fill the entry */
> -=09memset(&legacy_serial_ports[index], 0,
> -=09       sizeof(struct plat_serial8250_port));
> +=09memset(legacy_port, 0, sizeof(*legacy_port));
>  =09if (iotype =3D=3D UPIO_PORT)
> -=09=09legacy_serial_ports[index].iobase =3D base;
> +=09=09legacy_port->iobase =3D base;
>  =09else
> -=09=09legacy_serial_ports[index].mapbase =3D base;
> -
> -=09legacy_serial_ports[index].iotype =3D iotype;
> -=09legacy_serial_ports[index].uartclk =3D clock;
> -=09legacy_serial_ports[index].irq =3D irq;
> -=09legacy_serial_ports[index].flags =3D flags;
> -=09legacy_serial_ports[index].regshift =3D shift;
> -=09legacy_serial_infos[index].taddr =3D taddr;
> -=09legacy_serial_infos[index].np =3D of_node_get(np);
> -=09legacy_serial_infos[index].clock =3D clock;
> -=09legacy_serial_infos[index].speed =3D spd ? be32_to_cpup(spd) : 0;
> -=09legacy_serial_infos[index].irq_check_parent =3D irq_check_parent;
> +=09=09legacy_port->mapbase =3D base;
> +
> +=09legacy_port->iotype =3D iotype;
> +=09legacy_port->uartclk =3D clock;
> +=09legacy_port->irq =3D irq;
> +=09legacy_port->flags =3D flags;
> +=09legacy_port->regshift =3D shift;
> +=09legacy_info->taddr =3D taddr;
> +=09legacy_info->np =3D of_node_get(np);
> +=09legacy_info->clock =3D clock;
> +=09legacy_info->speed =3D spd ? be32_to_cpup(spd) : 0;
> +=09legacy_info->irq_check_parent =3D irq_check_parent;
> =20
>  =09if (iotype =3D=3D UPIO_TSI) {
> -=09=09legacy_serial_ports[index].serial_in =3D tsi_serial_in;
> -=09=09legacy_serial_ports[index].serial_out =3D tsi_serial_out;
> +=09=09legacy_port->serial_in =3D tsi_serial_in;
> +=09=09legacy_port->serial_out =3D tsi_serial_out;
>  =09}
> =20
> -=09printk(KERN_DEBUG "Found legacy serial port %d for %pOF\n",
> -=09       index, np);
> +=09printk(KERN_DEBUG "Found legacy serial port %d for %pOF\n", index, np=
);
>  =09printk(KERN_DEBUG "  %s=3D%llx, taddr=3D%llx, irq=3D%lx, clk=3D%d, sp=
eed=3D%d\n",
>  =09       (iotype =3D=3D UPIO_PORT) ? "port" : "mem",
>  =09       (unsigned long long)base, (unsigned long long)taddr, irq,
> -=09       legacy_serial_ports[index].uartclk,
> -=09       legacy_serial_infos[index].speed);
> +=09       legacy_port->uartclk, legacy_info->speed);
> =20
>  =09return index;
>  }
>=20
--8323328-1944227453-1749640559=:957--
