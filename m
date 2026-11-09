Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794236139;
	b=FviIVjnxxhuvBt0aQknsdKZkU2ZCgjaontK8QDqZsz4oKnPWSDCuG2cSCYNTari33O0J
	 Vngs59JziGMpR0DvvFpKdVAlTsG0pkVDsmEKpLThtpoi8fAWmers6wcr8eTNNyrH6RI7H
	 tQ2FbY72hYfTxHCeWGQk0c02CRKTSlbT9zR1xrcpzCAot2M8CVmcuzWsndal74c1heaDH
	 bDVfUjqXaq8MgfahctDQgxYn9yyT9bq+wZ/Ka+GEiRxZ76jdI8EpjHSShqpF4NdcclM9B
	 K/m8rimIX5CsmtottLWEEyUGtu6J+VmGTWd0IfKa81y+1q8DDHmhY6fCU8i9CUBn22A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794236139;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=OPMTYrIv7U1UWYQ/ULbovNNC49g7R/EbhbaHljblfH8=;
	b=AjF1XlLuYwMtjvkbbeaBwJnfUSRS8vDHpOnojBRdrvRo0ZPuWTaYWabFIjTslXQ83VOw
	 Ft+NWWhKwfhFUUTYFfe7a5i72zN097g4vDwLjLW2ZIZLaEJXarSgvP5x8n1c6gyKX+nnE
	 1zTCfcxYkizfHzfLSTSqfJeHy4GhvicuJM2Sn+a50acYu0YA3iz7OiDUAASlJy6DwAtIh
	 vxBU6mTg3GqWA9CBGJIfkAIdCR0QgVpZuFfv9v0iUDXxhIdxd7RUtx+vrzjY0KAFnYVwv
	 rJPOLEMUqn7Qil+ju6b5pO+hO5eT9nqyaSWySXMhrXL5CIDNjrxL3urTrKHQaOcyZAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Fu0lbhZg;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2270C606A31C;
	Mon,  9 Nov 2026 14:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2270C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Fu0lbhZg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794236140; x=1825772140;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=rVCjiIFvC6E3quo9l3R3aM1S43mCGLdSCsEF+O0+dgI=;
  b=Fu0lbhZgErFZSYNw/jumzy+GMcGtVgBCmnERJ5MztOSZHy6dJVqjE1J8
   v5jO/liCvzsUmIkEOD9ffNNOOwVt+9NLKvUi1gcNy6FvDQvFLbr9U8nze
   mdMildCk7k6vEaL6JfVcmjjLNQY+yRbo8eS1Kja0j1M+cvtn59GQlAZO2
   pzw1Fh+hFEmRAgU51FdqF9+ZfOQeP2mnJ510zw5ZqjN7meZgrZ5wKiTKb
   aCYAWYfURHtjULoHIzB0HdEgude8C7pq5XqBLB0Lto3XVvFDz+7INWoOp
   ONjxXDDGZZ9j9P4rLfAo4ClF1yWveaHkmDTzZtqZnY5DicWWJh0ZCjJYH
   w==;
X-CSE-ConnectionGUID: GsMHZaj3RvmiP7MqBPmQgw==
X-CSE-MsgGUID: ejQi+zAoTEOBee5T2FoTPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2838443"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2838443"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 06:55:39 -0800
X-CSE-ConnectionGUID: 3vrj6c/cR9C6/ZvLjx0OWg==
X-CSE-MsgGUID: CYuhuV9PRZqMOFS1UElLLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="8218137"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.139])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 06:55:35 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 9 Nov 2026 16:55:31 +0200 (EET)
To: =?ISO-8859-2?Q?Kry=B9tof_=C8ern=FD?= <cleverline1mc@gmail.com>
cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
    LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
    Miroslav Ondra <ondra@faster.cz>
Subject: Re: [PATCH 1/2] serial: 8250: Add RX trigger levels for U6_16550A
In-Reply-To: <20261109-8250-select-u6-64bit-v1-1-04bc8332fa34@gmail.com>
Message-ID: <469362ef-f0c5-45f2-746a-b4a3c51876a4@linux.intel.com>
References: <20261109-8250-select-u6-64bit-v1-0-04bc8332fa34@gmail.com> <20261109-8250-select-u6-64bit-v1-1-04bc8332fa34@gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-656436369-1794236131=:1181"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-656436369-1794236131=:1181
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 9 Nov 2026, Kry=C5=A1tof =C4=8Cern=C3=BD via B4 Relay wrote:

> From: Kry=C5=A1tof =C4=8Cern=C3=BD <cleverline1mc@gmail.com>
>=20
> PORT_U6_16550A has a 64-byte FIFO but no rxtrig_bytes table, so the
> rx_trig_bytes sysfs attribute is not registered for ports of this type
> and the RX trigger level cannot be read or changed from userspace.
>=20
> Add a table with 1, 16, 32 and 62 bytes, i.e. 1 character, FIFO 1/4
> full, FIFO 1/2 full and FIFO 2 less than full. These are the levels the
> Synopsys DesignWare UART uses for a 64-byte FIFO, and they match the
> existing PORT_ALTR_16550_F64 table.
>=20
> The default FCR value of the type is unchanged, so the trigger level a
> port starts with stays at 1/2 full. The only visible change for ports
> already detected as U6_16550A by autoconfig is the new sysfs attribute.
>=20
> This prepares for 8250_dw selecting PORT_U6_16550A for DesignWare UARTs
> with a 64-byte FIFO.
>=20
> Co-developed-by: Miroslav Ondra <ondra@faster.cz>
> Signed-off-by: Miroslav Ondra <ondra@faster.cz>
> Signed-off-by: Kry=C5=A1tof =C4=8Cern=C3=BD <cleverline1mc@gmail.com>
> ---
>  drivers/tty/serial/8250/8250_port.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/825=
0/8250_port.c
> index 36b2b0a2c05c..a7acede62f40 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -163,6 +163,7 @@ static const struct serial8250_config uart_config[] =
=3D {
>  =09=09.fifo_size=09=3D 64,
>  =09=09.tx_loadsz=09=3D 64,
>  =09=09.fcr=09=09=3D UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
> +=09=09.rxtrig_bytes=09=3D {1, 16, 32, 62},

Reusing U6 entry for DW UARTs seems misleading.

We've better mechanism coming up for defining rxtrig in a one pending=20
series so this constant friction with the uart config types can be put=20
into rest.

Please build on top of that other series and help in testing and reviewing=
=20
it.


--=20
 i.

--8323328-656436369-1794236131=:1181--
