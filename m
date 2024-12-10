Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768771C75F3
	for <linux-serial@vger.kernel.org>; Tue, 10 Dec 2024 09:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733821292; cv=none; b=WfKXNXuFTdy2nXjglISW7jICGRtFHTm8v1DY60WyODxy/NzqUtm7HO4jTkmaBmIonCUgsbq/mR5F2ysoM/08FCPmb2LDEu5SyaS8CGoRFlnzlD5rcq0AFtgvuEzokOOa8sqSKU5grM1jYmxaIzcIdIBglJBB+SgnGoSWyRUtkrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733821292; c=relaxed/simple;
	bh=gBFwtX62HZzRaai0K+v2rk3fcFBb5+CMCQxsV9IEtl8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V1539/hVIjQClYZbLDPzDgG6WABf+alAEvrFVfhG8TPBsNufShH536v2d+rs8rClf++CBbLzyf4UQ3t6HN0yLXeRy50CoZUDPmpDAj0RyU+BHZIdPQACoNU/vj3cNZd0hpjzIoeaVVNPDcyP35pr8P1QjjDeAmjLFQW7ORaT5sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1tKw73-00051L-G9; Tue, 10 Dec 2024 10:01:01 +0100
Message-ID: <b092fdec6fda26c56b4f2cc5927bbaa4a6d786f9.camel@pengutronix.de>
Subject: Re: [PATCH v2] serial: imx: Use uart_port_lock_irq() instead of
 uart_port_lock()
From: Lucas Stach <l.stach@pengutronix.de>
To: Xiaolei Wang <xiaolei.wang@windriver.com>, gregkh@linuxfoundation.org, 
 jirislaby@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, 
 kernel@pengutronix.de, festevam@gmail.com, esben@geanix.com, marex@denx.de,
  ilpo.jarvinen@linux.intel.com, linux@rasmusvillemoes.dk, 
 stefan.eichenberger@toradex.com, l.sanfilippo@kunbus.com, 
 cniedermaier@dh-electronics.com, rickaran@axis.com
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Date: Tue, 10 Dec 2024 10:00:57 +0100
In-Reply-To: <20241210034223.1493522-1-xiaolei.wang@windriver.com>
References: <20241210034223.1493522-1-xiaolei.wang@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org

Am Dienstag, dem 10.12.2024 um 11:42 +0800 schrieb Xiaolei Wang:
> When executing 'ehco mem > /sys/power/state', the following
> deadlock occurs. Since there is output during the serial
> port entering the suspend process, the suspend will be
> interrupted, resulting in the nesting of locks. Therefore,
> use uart_port_lock_irq() instead of uart_port_unlock().
>=20
> WARNING: inconsistent lock state
> 6.12.0-rc2-00002-g3c199ed5bd64-dirty #23 Not tainted
> --------------------------------
> inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
> sh/494 [HC0[0]:SC0[0]:HE1:SE1] takes:
> c4db5850 (&port_lock_key){?.-.}-{3:3}, at: imx_uart_enable_wakeup+0x14/0x=
254
> {IN-HARDIRQ-W} state was registered at:
>   lock_acquire+0x104/0x348
>   _raw_spin_lock+0x48/0x84
>   imx_uart_int+0x14/0x4dc
>   __handle_irq_event_percpu+0xac/0x2fc
>   handle_irq_event_percpu+0xc/0x40
>   handle_irq_event+0x38/0x8c
>   handle_fasteoi_irq+0xb4/0x1b8
>   handle_irq_desc+0x1c/0x2c
>   gic_handle_irq+0x6c/0xa0
>   generic_handle_arch_irq+0x2c/0x64
>   call_with_stack+0x18/0x20
>   __irq_svc+0x9c/0xbc
>   _raw_spin_unlock_irqrestore+0x2c/0x48
>   uart_write+0xd8/0x3a0
>   do_output_char+0x1a8/0x1e4
>   n_tty_write+0x224/0x440
>   file_tty_write.constprop.0+0x124/0x250
>   do_iter_readv_writev+0x100/0x1e0
>   vfs_writev+0xc4/0x448
>   do_writev+0x68/0xf8
>   ret_fast_syscall+0x0/0x1c
> irq event stamp: 31593
> hardirqs last  enabled at (31593): [<c1150e48>] _raw_spin_unlock_irqresto=
re+0x44/0x48
> hardirqs last disabled at (31592): [<c07f32f0>] clk_enable_lock+0x60/0x12=
0
> softirqs last  enabled at (30334): [<c012d1d4>] handle_softirqs+0x2cc/0x4=
78
> softirqs last disabled at (30325): [<c012d510>] __irq_exit_rcu+0x120/0x15=
c
>=20
> other info that might help us debug this:
>  Possible unsafe locking scenario:
>=20
>        CPU0
>        ----
>   lock(&port_lock_key);
>   <Interrupt>
>     lock(&port_lock_key);
>=20
> Fixes: 3c199ed5bd64 ("serial: imx: Grab port lock in imx_uart_enable_wake=
up()")
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>=20
> v1:
>   https://patchwork.kernel.org/project/linux-arm-kernel/patch/20241209124=
732.693834-1-xiaolei.wang@windriver.com/
> v2:
>   use uart_port_lock_irq() instead of uart_port_lock_irqsave()
>=20
>  drivers/tty/serial/imx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 17f70e4bee43..9c59ec128bb4 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -2692,7 +2692,7 @@ static void imx_uart_enable_wakeup(struct imx_port =
*sport, bool on)
>  {
>  	u32 ucr3;
> =20
> -	uart_port_lock(&sport->port);
> +	uart_port_lock_irq(&sport->port);
> =20
>  	ucr3 =3D imx_uart_readl(sport, UCR3);
>  	if (on) {
> @@ -2714,7 +2714,7 @@ static void imx_uart_enable_wakeup(struct imx_port =
*sport, bool on)
>  		imx_uart_writel(sport, ucr1, UCR1);
>  	}
> =20
> -	uart_port_unlock(&sport->port);
> +	uart_port_unlock_irq(&sport->port);
>  }
> =20
>  static int imx_uart_suspend_noirq(struct device *dev)

