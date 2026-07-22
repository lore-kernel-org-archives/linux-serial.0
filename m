Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazolkn19012052.outbound.protection.outlook.com [52.103.2.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F088D471D03;
	Wed, 22 Jul 2026 16:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784738733; cv=fail; b=KJ7FpgwNpQCHZrY1Hz0epdvuDkUfdn8egxJ6omHxqPwEYzQoyeVt4vc1bSHMriOXc3EmobaOSVo1L5aDPbDDKVinUgtQiRIyeVnd1OnbxSwoW+ihDmFTe9UHge6YZ5C7dGssMbg88W1sIL+oMLtIEHYjobzhIb0hcJzFFOYKLqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784738733; c=relaxed/simple;
	bh=4A6W+hRucMR0C+kOX483RKF6MUJA2ITDFoY6m5eMydI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MXfHCJZNXoCSkXYehx6ad0KlwrIn4qgBABMzM65inyzttErX5KDElTJGI/QfRg7AhUdrHn/JK4Sz7jdNSDgL87XSELtfVxrNzi/E1QjeeXlCiVv2bm0/7R0AIfKUGKpO0Z4NjXE+XSg5AtHUoYLJd+2TeS28YUg8ecdMiyRObiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ZLxcx49K; arc=fail smtp.client-ip=52.103.2.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ZLxcx49K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VsdgNF/wBWbrhczBDKdKxbbEkjvs8kLVNN2d5k9gMfDrIkeEz1GgHbC+ftIBmm2tYdbvhGUII2xNhXmWlMJfEnMNLesSW0ga46goBbc/yN/dj8g1ZHoS/LEnWs/XYqPB9z22pMyq/3y1ldnTuUZQAu53aUP6ZBDwH7QxdJ9XV2ueD4rz8TnWrO+ecNsuRF6bgfj4DXIs5fNXALcakienDx+2qkrgCxRr3FDib3bLtNT8llZ5V7BgGjxAFFedlup2L864EHNNO6+SqyBqqySjzWi6gj/DPJT23rEuSelWrLQlNWppm7MMPL0XBgaEGam6p7lFVMSGbL9I/RrENY5wwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/h9HMuyzo8uWLSYR240B8Zy9njnC2IPvc6u09XN6TGI=;
 b=pK+ocvrLEroVTgAQNkvTIKUvgzlMQdyboYSdaQ6ILBf0eRNG4mfTu262gQME8E269DYNLh+GJLTVQG0YdAOXZFa8AVhiACcsoOR3MSWM+Kq9V/F6flbLVIp8y//pukAhRCBtnbE4M7HZI7QDlkornGXXawqyX2zCwO96BkoM7kmRUx5kpupnmWJD+2VK+2V5rIUsnxOSAS7ZcULs7zZRRNwchKv45WxRMb63iGpubw/lYGMSCDk06nnupLPA6i9Zk60tqiOmE/5qVLgEz6I/S4PUbUrIspD6DO9BrFBcanvVcbf1nQU63pxv1RqNIPLyJoGhcNdW570rw1T1fGC9NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/h9HMuyzo8uWLSYR240B8Zy9njnC2IPvc6u09XN6TGI=;
 b=ZLxcx49KzJQdFCD9IYFBblz5HD61c8emfe+K44TA3QYBBba1BCU76+RTUlrjwQBUqDl9anr6CMyVrNH0NoBAk/IsX4NF1qlTj8H7PJdXCVzZZHGOj8Ga4ByyiptvSd+o2BZH7GbA8PkaRiSmzPDPMVDB2OjMnkC3irAWg0vatNQPqisggWS2rL42hXtz9h0xrNDefCXe8ZJdvhyzWQ2S1U6quV3AIx5XjIYVSKXoRcOOs/R7BiXZZuWu7YEXAMapkWV5edrRxWmH7q/kfIekpTEUMdQ/4y91QBVb8dl0JtMvUAFBhzbTWbaOGA4Qhv5Fu8scfsysIB0UsW0yu42zaw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB7741.namprd02.prod.outlook.com (2603:10b6:a03:32c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 16:45:20 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 16:45:20 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Eric Curtin <ericcurtin17@gmail.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, Dexuan Cui <decui@microsoft.com>
CC: "jirislaby@kernel.org" <jirislaby@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: RE: [PATCH v4] serial: amba-pl011: don't wait for BUSY after every
 earlycon character
Thread-Topic: [PATCH v4] serial: amba-pl011: don't wait for BUSY after every
 earlycon character
Thread-Index: AQH6BqAo4C0ab3I2DXnQNJgNs97H/gJ1VuvMtiwmmKA=
Date: Wed, 22 Jul 2026 16:45:20 +0000
Message-ID:
 <SN6PR02MB4157A6147A1DBD19960B7ACFD4C12@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <2026071036-unworn-bunny-fec5@gregkh>
 <20260720122646.16994-1-ericcurtin17@gmail.com>
In-Reply-To: <20260720122646.16994-1-ericcurtin17@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB7741:EE_
x-ms-office365-filtering-correlation-id: 167b4ece-966a-496e-2c68-08dee8109e31
x-ms-exchange-slblob-mailprops:
 AZnQBsB9XmrTkIzDOCxR6E7nJ4I/6XZ792CjEX+LiO8O/aWGEz74Hm/jWyrbYquPXE/5ZYKIqZkih75mr3X7g4rdG4ZJmCrrZ/izs2TVR1F55A+8q2nSll635jJQCsyfETpg44Dru6P53T8nPalRZiz9a3gvn8z69+1c+Y3o87cF+25nZtilomkoRCjaLn1j/bqjZimNjlObmOYcNp/CJjaqxXKFkjQdIzcfbNaNjY/fdfcOiEHqYebE1fF+QxO4Qnq7xXMF2la6jul6Wo1Hgbm2jSMrP4E3FeIhZ1bftCJRmSv2ImDtiY/N9gx1BVilQ16G+8Hri3fxWYcqW00iC//GaKGeMt6eS2TAN+GxjRU5xt1NKBnd562gdjGDGPZh3olNxry4ZSs4jVdpFhwtEWPfSOK7AlqpLQyz1hBsGjHELmsHLAXo7P5j3C/FYLXqv6WIYlrRRai463YeQ0KpkojllMU7WqS4sOgV7tM6baF2kk+oJYLVuLA4pt4Wp2KyyHWwl6IZEhcDPzn7xxJEczf80vYBCghjHFP5NC2l+rb2Mx2spx27wG9wJ5ZZYuIY2erdc1+taJG3s4InBLmFM8/SWeW9/zqv9Qxs59BAlT51ZyCqlRLevLzSLeEuiN/kRWtPWW4fIdGmJlwzxcIALSdtH5Psfmg9kUGdnX8f5fbjRyyUCgkSrl0jZhtfbO+gUdHB/lWD479zFzGKoTjMsScWcoHTXYAh0XK8oFtHRzUA/FQsPzibomjxjPHCTU+NmpP013Gh5g4=
x-microsoft-antispam:
 BCL:0;ARA:14566002|25010399006|12121999013|4140399003|37011999003|13031999006|24021099003|15080799012|13091999003|31061999003|8060799015|8062599012|19110799012|55001999006|440099028|3412199025|102099032|52005399003|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ES9nxfzNFk7LRfTgC/ntlnR9CmbUUVBY1pgn88etNiRrtP7I01+vzviFYfu2?=
 =?us-ascii?Q?JdZWga6vDN1xtIzozlEkfYsVY30/ejpuQSAg2qnup6tgq2EyVWPBzv1zF4MK?=
 =?us-ascii?Q?jyPVsj5JczyRp8PAvSGZC+NrPXxlPMltIV4FmCbxNCg1LKH8lS4oQ1vvRajZ?=
 =?us-ascii?Q?erziprlxgzVK+zik2dy7L1urpJlxyuUPr9SeBaVXuINIhCfSgktYfqDyds91?=
 =?us-ascii?Q?hJ2wcAGcDk2LbWqiKko0rZVO2ipqtGxUTQrKhJu4MTWxxaGjf+wPrQyfbyY+?=
 =?us-ascii?Q?RwOU6qByXvpDz8ewpNdY3+uVEGRhyVoo4FrnKPAPvFn9399l/9IpuEKIY6lM?=
 =?us-ascii?Q?bqD6q/udMAQ6cyQv2TSe/Ke9QtkKZn9R7BKBJQP2nqD49jMby95BagQq69M9?=
 =?us-ascii?Q?9co0Jf6wO76d/q88Gqz/LNhZXTgUsc7SVH+y+9crPnKwhNYy9bh6exfoTWt3?=
 =?us-ascii?Q?o6DBPGJWXZvGqY3FrE51RX5T/BPPDl6EOuGBjq93eYAlcvaPdweqhKbO7fHz?=
 =?us-ascii?Q?nq9j6mdqyjJDK2Lh/nbXgWktEB+NT9EshW+Y5rEqDFa+zMbynEJKjYXT6tci?=
 =?us-ascii?Q?emrXtd+ynX1NE7Jp/ofLVdNnH7ezGYiIk/SADjRcVYkCgKYneEGC1nZAPMHp?=
 =?us-ascii?Q?yQmQu/CE7vW985kKox+SlZVNHakTo9nf9zgfhXA0yIKzlS2Fw5HED8NEO7yA?=
 =?us-ascii?Q?or9JqSNSV/qyJ7hKu82neoL00An9+ki3FzaDAAtVmwg0oOGSbMlySGxtDkiK?=
 =?us-ascii?Q?5Y099vP6Q3S2NNkl+s6HSGWwGWwP2LQDxBZwZf/BWY3aITSQCpzOxZf8wQWk?=
 =?us-ascii?Q?HteMC6adgg8odWZUE+6vCzAoc17UxM5aX31x0VEc+QcOX/rmeLzqG4bAltOy?=
 =?us-ascii?Q?9dYusim8wxm9FGNpx8ftXQ2ezGrwMfHz8CfSt8bGHWbJSPbrwhJupVHWcrK1?=
 =?us-ascii?Q?ek7NIt8ECeaRJXrdvjTBZ5zk29rsHkjcfABec2Sye2UWi8H9+Zx16Z4Te/rx?=
 =?us-ascii?Q?qRyLoUXI/eEbz8fyG8USTj+dkp+sngBLtdUNhYgMgj65SDSgcHTuN6/OJfd0?=
 =?us-ascii?Q?X8zM/LEbDYGXecLRcjqQwYTBIewyqYSN8fAkMTYtp+eazC5ccUA=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9JlttX9vGtEaniX2K+bb1d+ZTl02C2Lf9b0N8jw5oEDVj2aXBVnSOtzip7I9?=
 =?us-ascii?Q?uDe65M1M4i4y6CI0ARbNWSdcggZCr6d+hMXkikc5AYlWnE/M47mQYLLE+Fer?=
 =?us-ascii?Q?fFL9GTFyrBLwlZp5gcT7t8DkPJVOz9XNRQ7YEHoApbemNRh+rYKHRfCJFflC?=
 =?us-ascii?Q?nk8KaroCdZFAX5o/Whdah0DfJRQcGAu5+BM6JNXrx3NhHk0Supq+XFFG5vXL?=
 =?us-ascii?Q?0KHAyK8000VxXX7onzx9GYaEt+RlGBF3G6Ht31G13L/JgVnnTIWVLGAg+dYe?=
 =?us-ascii?Q?5BraWtVzJPMTlRFUgr5AJG7h58LzKU9QenB+mcAcp4HRLn7hZ4MTwpnigj53?=
 =?us-ascii?Q?m3uFxRrD7AjKelF3qGIQiz9k1P+mzEoYMrS2eEVRCFwEJPq/4wdKMFUytndY?=
 =?us-ascii?Q?ni/Ge3K6nuq0PxsHAW+u1ZOoK1duIF7kgs54WuMk3eEN0b9VHG7JkYJlid0c?=
 =?us-ascii?Q?StlvF+QKnVqgWPiTzsyVL6oR8eCADmy8jZUZL+Qz6pn4AZpNn3JoRHDBnoDK?=
 =?us-ascii?Q?XgqwbvilfORkXzr9UJpxH6xUOX7BbMSDNyqoLydyBLioFWTu3eqLKKehxlHi?=
 =?us-ascii?Q?gjTvSOhFvHkj8tYSD3tGC/H2BqBsBIiVTzZ63rNEpRhKP3Y17JK4qAtN536o?=
 =?us-ascii?Q?DmhhdhVTeTvZy7Xn25qr5zuRu2Gp+jl9o04F0wRrSWlk/alN9q1l8O1l/yyq?=
 =?us-ascii?Q?XtSzMMhtlKe6CJOPbypQW/4O9P40e66/mYlPVrfGWXLuLCy7koV9Yi063/Cl?=
 =?us-ascii?Q?hVpsiELueBEfIwHgwxr9/lYyERLRDE/Sdeg9/ZTBGHspDhSJBM689e6l43no?=
 =?us-ascii?Q?oLX9LLG2KtKdtVcs1CM6YyZvpvd2XB66dHx50f6LeUMiJ7ddivKb0wCXSpbO?=
 =?us-ascii?Q?4/LM8CN3YbNUzPi8seOcxZjorXQhq1Wa1qAtfvMduanBxjga1gnY8SyDDl9R?=
 =?us-ascii?Q?/FWIRWQsc2dc1pZcPLTiOCcl02b2GxfaNE03IUGcmg/kefQ2GIaDSK6lI8V4?=
 =?us-ascii?Q?oYoH1j8ueypdR7FzISSxblKWjCFSHJbwS2zKQ0BZfwQHGBZLlnXUKIjTOG05?=
 =?us-ascii?Q?grxrcJZswIkwSANqtks3pRgjGIdoMj0OOp9AbT4DRZPMPqnU4bzh0EceKhSL?=
 =?us-ascii?Q?7E0qQUU+InKfcwztygR8ZvfQjQK0byeDFUl4VPvwA5b9bjieZERftYAnWZGX?=
 =?us-ascii?Q?yP6Rtsn2mMfKxuJJ2jiKnUP9QILzVB1EP3ZvgIimR5bP6IPQXER37WNWl11y?=
 =?us-ascii?Q?kR09O8qS/XeJgwju/3psAEgqqxITb2X8P61DMzaelmce8wI69Gd7cRJ/PTOT?=
 =?us-ascii?Q?ePAjxumeucTKC5rHjsJ5iC071WDwdjpGt3N9enLDUQO9T9nYm5+QTtaCW0Dy?=
 =?us-ascii?Q?MXU1bbQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 167b4ece-966a-496e-2c68-08dee8109e31
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2026 16:45:20.4221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7741

From: Eric Curtin <ericcurtin17@gmail.com> Sent: Monday, July 20, 2026 5:27=
 AM
>=20
> pl011_putc(), used exclusively by the pl011 earlycon (pl011_early_write()
> -> uart_console_write()), waits for UART01x_FR_TXFF to clear before
> writing a character (correct: don't overrun the TX FIFO) and then *also*
> busy-waited for UART01x_FR_BUSY to clear before returning, i.e. it waited
> for the character to be fully shifted out on the wire before the next
> character in the string could even be considered.
>=20
> Waiting for BUSY per character defeats the TX FIFO: instead of letting
> the UART buffer several queued bytes and transmit them back to back,
> every single character printed through earlycon was forced to wait for
> that character's own complete transmission (a full UART bit-time at the
> configured baud rate) before the driver would even look at writing the
> next one. This is wasted time on real hardware, and it is much worse
> under virtualization: each read of UARTFR and each write to UARTDR is
> an MMIO access that traps to the hypervisor, so every extra poll is a
> full VM-exit/entry round trip.
>=20
> git blame on this function is unhelpful (this tree's history stops at a
> shallow-clone boundary), but the equivalent history is available from
> the upstream patch that added the QDF2400 erratum 44 workaround:
>=20
> commit d8a4995bcea1 ("tty: pl011: Work around QDF2400 E44 stuck BUSY bit"=
):
>=20
> That patch added a *separate* qdf2400_e44_putc() for hardware where
> BUSY can get stuck at 1, rather than touching pl011_putc() itself, and
> it left pl011_putc()'s per-character BUSY wait in place. So there is
> precedent for "waiting on BUSY is fragile on some hardware", but no
> indication that pl011_putc()'s per-character wait was ever intentional
> for standard hardware as opposed to simply mirroring the already-present
> final-drain wait used elsewhere in this same file.
>=20
> Both pl011_console_putchar() and pl011_put_poll_char() (the regular,
> always-built console write path and the kgdb/kdb polling path) only
> wait for TXFF before writing, never for BUSY. The regular console path
> still gets a full-drain guarantee, but correctly obtains it only *once*,
> after the whole buffer has been written: pl011_console_write_atomic()
> and pl011_console_write_thread() each call uart_console_write() with
> pl011_console_putchar (no per-character BUSY wait), then separately
> wait for BUSY exactly once, after the loop, before restoring the CR
> register.
>=20
> pl011_early_write() had no equivalent single final wait, so simply
> deleting the wait from pl011_putc() would drop the "the UART has
> actually finished transmitting by the time this function returns"
> guarantee that earlycon currently provides, e.g. right before a panic
> message is followed immediately by a reboot/poweroff. Instead, move the
> same "wait for BUSY" out of the per-character pl011_putc() and place it
> once in pl011_early_write(), after uart_console_write() completes,
> mirroring the pattern already used by pl011_console_write_atomic()/
> _thread(). This keeps the flush guarantee while turning an O(n) wait
> (once per character) into an O(1) wait (once per earlycon write call).
>=20
> This is easy to see, and to prove, in a fast-booting VMM. Using a small
> KVM-based VMM that boots Linux guests directly on arm64 (no firmware),
> booting an otherwise-identical 7.2.0-rc1 kernel (single vCPU, 512MB
> guest, direct PL011 MMIO with no interrupt-driven UART - i.e. earlycon
> is the only console active) up to the (expected, rootfs-less)
> "Unable to mount root fs" panic, with 20 boot samples per kernel per
> configuration:
>=20
>   cmdline: console=3DttyAMA0 earlycon=3Dpl011,0x09000000 ignore_loglevel
>            initcall_debug printk.time=3D1     (~99KB printed over earlyco=
n)
>     before: min 466.3ms  avg 471.4ms  max 480.3ms  (n=3D20)
>     after:  min 429.4ms  avg 435.3ms  max 449.0ms  (n=3D20)
>     -> ~36ms / ~7.7% faster, non-overlapping distributions
>=20
>   cmdline: <the VMM's actual default, quiet, earlycon=3Dpl011,0x09000000>
>     before: min  74.3ms  avg  76.5ms  max  82.2ms  (n=3D20)
>     after:  min  53.8ms  avg  56.8ms  max  74.9ms  (n=3D20)
>     -> ~20ms / ~25.8% faster
>=20
> The second measurement uses the VMM's real default boot configuration
> (not a synthetic debug cmdline), so this is representative of ordinary
> boots, not just verbose-logging ones. Console content was diffed
> (timestamps and per-initcall "returned 0 after N usecs" numbers
> excluded) between before/after runs and is identical line-for-line:
> this change does not drop, reorder, or corrupt any output.
>=20

I tested this patch in two VMs running on Hyper-V in the Azure public
cloud. Hyper-V provides an emulated PL011 to ARM64 guests, but the
emulation has some quirks. I wanted to verify that the quirks didn't
cause any issues. All my basic smoke testing passed, which is great.

From a performance standpoint, the older Dp_v5 series VM saved
an average of 196 milliseconds in boot time up to the point that the
regular PL011 driver took over. The newer Dp_v6 series VM, which
has a faster physical processor, saved an average of 158 ms. Both
values are an average of 4 runs of an unmodified linux-next20260721
kernel vs. the same kernel with your patch. That's a nice win!

Tested-by: Michael Kelley <mhklinux@outlook.com>
