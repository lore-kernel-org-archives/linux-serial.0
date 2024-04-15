Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B083D823CE
	for <linux-serial@vger.kernel.org>; Mon, 15 Apr 2024 17:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713201361; cv=none; b=NL6ULlL95ACKBTyROOO6G/8k1fZNgm9/JecsZRZaHeZc4koaxTwbj3AcAeOBFlpgz/TKArpd6SyoEVoEI2uT6Qon0m7M915RRBK5qb5mFLTjNum0fRJKPFm9I7tx6xTNJHuqtTcTdsvEDwlOQ5hC/bJxXcglGGz/rCLwmkrthXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713201361; c=relaxed/simple;
	bh=aDIu4GbInUhDpbIixo4hB8yARHAIlJEIl0AxsLbJ/Go=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=vCOrFnYvns6nZPwwz5hYinJ2EuPaylId/9+fscBBlOQHj5HMPt49SCAe28GGDIC+5kNnalLJXdsjSC9FHxGKScsK/K19PwsWcEiDBTY6n/oJSUTbwymNqMTtGfUxpjNzT+3JeCJx3VCgq0PNTZUfSPjlzrq9FHjZtfqzx55r/U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rwPvv-0007U6-DV; Mon, 15 Apr 2024 19:15:55 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rwPvu-00CStv-Jm; Mon, 15 Apr 2024 19:15:54 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rwPvu-001mU5-1i;
	Mon, 15 Apr 2024 19:15:54 +0200
Date: Mon, 15 Apr 2024 19:15:54 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-serial@vger.kernel.org, kernel@pengutronix.de
Subject: NULL pointer dereference when closing a busy UART
Message-ID: <luomji4bv5c54xq442csgd2ifdacjrme7bomnwbviw6pmalpgv@5uusgu3vgybm>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7mmymzdxvbeaibzi"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org


--7mmymzdxvbeaibzi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

on a v6.8 kernel + I can trigger a NULL pointer dereference with the
following python3 script on an stm32mp157 based machine. It uses the
stm32-usart driver:

	import serial

	port =3D serial.Serial("/dev/ttySTM1", rtscts=3DTrue, baudrate=3D115200)

	s =3D "a"*100
	s =3D s.encode()

	for _ in range(100):
	    port.write(s)

	del port

I let it run for some and then press Ctrl-C to interrupt it. This
results in

[  206.946589] stm32-usart 4000f000.serial: Transmission is not complete
[  206.988890] 8<--- cut here ---
[  206.990763] Unable to handle kernel NULL pointer dereference at virtual =
address 00000fa3 when read
[  206.999839] [00000fa3] *pgd=3D00000000
[  207.003587] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
[  207.008838] Modules linked in: sd_mod t10_pi crc64_rocksoft_generic crc6=
4_rocksoft crc64 uas usb_storage cdc_acm dm_mod
[  207.019971] CPU: 0 PID: 29 Comm: kworker/0:2 Not tainted 6.8.0-20240403-=
1 #1 4a8ca24b652422adbfb70675a1cc7d4e71b9bbfe
[  207.030754] Hardware name: STM32 (Device Tree Support)
[  207.036002] Workqueue: pm pm_runtime_work
[  207.039979] PC is at stm32_usart_transmit_chars_pio+0x2c/0xd8
[  207.045856] LR is at 0xc108d0e8
[  207.049094] pc : [<c0665514>]    lr : [<c108d0e8>]    psr: 00070193
[  207.055453] sp : e08c5e40  ip : 00000fa3  fp : 000f4240
[  207.060899] r10: e08c5eec  r9 : 00000003  r8 : 00000000
[  207.066053] r7 : c1991110  r6 : 00000000  r5 : c1991110  r4 : 00000000
[  207.072806] r3 : e0901028  r2 : c1991110  r1 : e0901000  r0 : c10fd4e8
[  207.079366] Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segmen=
t none
[  207.086822] Control: 10c5387d  Table: c6c7806a  DAC: 00000051
[  207.092664] Register r0 information: non-slab/vmalloc memory
[  207.098330] Register r1 information: 0-page vmalloc region starting at 0=
xe0901000 allocated at __devm_ioremap_resource+0x168/0x1e0
[  207.110437] Register r2 information: slab kmalloc-4k start c1991000 poin=
ter offset 272 size 4096
[  207.119336] Register r3 information: 0-page vmalloc region starting at 0=
xe0901000 allocated at __devm_ioremap_resource+0x168/0x1e0
[  207.131336] Register r4 information: NULL pointer
[  207.136087] Register r5 information: slab kmalloc-4k start c1991000 poin=
ter offset 272 size 4096
[  207.145075] Register r6 information: NULL pointer
[  207.149913] Register r7 information: slab kmalloc-4k start c1991000 poin=
ter offset 272 size 4096
[  207.158710] Register r8 information: NULL pointer
[  207.163650] Register r9 information: non-paged memory
[  207.168703] Register r10 information: 2-page vmalloc region starting at =
0xe08c4000 allocated at kernel_clone+0x90/0x32c
[  207.179804] Register r11 information: non-paged memory
[  207.184946] Register r12 information: non-paged memory
[  207.190098] Process kworker/0:2 (pid: 29, stack limit =3D 0xf862f2a7)
[  207.196651] Stack: (0xe08c5e40 to 0xe08c6000)
[  207.201003] 5e40: c10fd4e8 c0667dd4 00000000 c187ce80 00000713 e08c5e70 =
00000009 adc5da34
[  207.209364] 5e60: 00000100 adc5da34 c0f4e4c0 c1c5cb10 c10fd4e8 40070113 =
c1c5ca84 00000000
[  207.217633] 5e80: 00000003 c06652b0 c1c5ca00 c0665230 0000000a c06d1920 =
c1c5ca00 c0665230
[  207.226094] 5ea0: 0000000a 00000000 00000008 00000003 e08c5eec c06d1a9c =
c1c5ca00 c0665230
[  207.234355] 5ec0: 0000000a c06d1b84 00000000 00000000 ffffffff c6add580 =
c187cc00 c0172584
[  207.242716] 5ee0: c187cc00 61c88647 c6a6b300 c6a6b300 e08c5f4c adc5da34 =
0a093fa7 c1c5cac8
[  207.250987] 5f00: c1c5ca84 c1815900 df910b40 0a0fd174 c1815905 00000000 =
c187cc00 c06d26f0
[  207.259446] 5f20: c1a13a00 c1c5cac8 c1815900 c0141d98 df910b40 c1003d40 =
df910b60 c1a13a00
[  207.267707] 5f40: df910b40 c1003d40 df910b60 61c88647 c1a13a2c c187cc00 =
df910b60 c014216c
[  207.275976] 5f60: e0831ed0 00000000 e08c5f7c c18f3680 c187cc00 c0141ef0 =
c1a13a00 c19f7700
[  207.284436] 5f80: e0831ed0 00000000 00000000 c014ae50 c18f3680 c014ad40 =
00000000 00000000
[  207.292794] 5fa0: 00000000 00000000 00000000 c010014c 00000000 00000000 =
00000000 00000000
[  207.301055] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000
[  207.309325] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000 =
00000000 00000000
[  207.317789]  stm32_usart_transmit_chars_pio from stm32_usart_transmit_ch=
ars+0x430/0x56c
[  207.325888]  stm32_usart_transmit_chars from serial_port_runtime_suspend=
+0x80/0xb8
[  207.333685]  serial_port_runtime_suspend from __rpm_callback+0x3c/0x168
[  207.340275]  __rpm_callback from rpm_callback+0x50/0x54
[  207.345736]  rpm_callback from rpm_suspend+0xe4/0x528
[  207.350706]  rpm_suspend from pm_runtime_work+0x9c/0xa8
[  207.356079]  pm_runtime_work from process_one_work+0x140/0x298
[  207.362151]  process_one_work from worker_thread+0x27c/0x4ac
[  207.367827]  worker_thread from kthread+0x110/0x12c
[  207.372797]  kthread from ret_from_fork+0x14/0x28
[  207.377574] Exception stack(0xe08c5fb0 to 0xe08c5ff8)
[  207.382725] 5fa0:                                     00000000 00000000 =
00000000 00000000
[  207.391002] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000
[  207.399463] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[  207.406229] Code: ea00002b e59240f0 e5de300a e0813003 (e7d4100c)
[  207.412292] ---[ end trace 0000000000000000 ]---
[  207.437779] note: kworker/0:2[29] exited with irqs disabled
[  207.444324] note: kworker/0:2[29] exited with preempt_count 1

The problem is that after the UART's shutdown callback completed
serial_port_runtime_suspend() calls .start_tx() and there xmit->buf is
NULL.

It's unclear to me where this should be fixed, but I suspect the problem
isn't in the stm32 driver but serial_core.

Cherry-picking a05ce5f2d840 ("serial: core: Clearing the circular buffer
before NULLifying it") didn't help. The other changes to serial_core and
stm32-usart in next since v6.8 didn't look like they could help.

I didn't try to test if older kernel behave better, yet.

Any ideas? Does this ring a bell?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7mmymzdxvbeaibzi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYdYMkACgkQj4D7WH0S
/k7nfwf/S6VjlSwJARrnzb1LA0f9LzFRhBGhPsiSQw9iH8gnm5Tf8artA9/aeh48
Iy1Vl2EPF/BQIwl8xUc3WOeXpBum7xSdsOjbv7iAHsiwbBq2FUvFP+X9rHsX2Pse
bcNhyhurKGsTdittZZWKFocqolh4jkVUwJS3Qwcj3+LkHlANeQauOnX64g+PgTl0
qhiQcP97+1oRondZn3HS7F8kSYpj98vQD4Tlh10in4H4U1zl7eY8yl6NhOFHAkiU
St8BAsZIZgTyv218ZmioDrYjT/TaF7FbgY2uQW8RKU1DsQ3pSsTk2zBjQEhtvQs1
iOoWFD44cMseBSrmcd2BT37bdAwiuQ==
=aJ5h
-----END PGP SIGNATURE-----

--7mmymzdxvbeaibzi--
