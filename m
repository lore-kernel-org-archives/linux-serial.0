Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD3C19BA6;
	Mon, 20 Jan 2025 16:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737390214; cv=none; b=FVNwVHYXD/iPBdFt4fRogwfNUkXOQ0ugQV22WEGcNuoxu8h88JqxaRRq2Q/Hi8X1pUWKG/XqJ9+IM7ywqzBZKV440fGO4jT1sLoS7ScSfr7dakpkK9yCCxlgCvrTty23VnL0Uhtl/lNC1p+ZKYyIizw6MgvsktHFHvibqA2tAv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737390214; c=relaxed/simple;
	bh=iSVSmHIxVlMIcQ2IOpxcwP9Lm6cbjJggq7zkBcuDX2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rr4veU0MT780bbczGpEBE/JKcim7JUopEJjM3utBa04iKoAYC4lJrN2gE08fO0LKTSXHVvTRXUmqyd9xnEJE1R5rZ28NDEZoFmceoXnBN86INj1p2E0r0oN8n/Q+cfqsJc1ssJmGbOhU5LR4SFNTtZTOxNzxOHp7MQSp24qVOpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BovqAkcj; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BovqAkcj"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4361b0ec57aso48083935e9.0;
        Mon, 20 Jan 2025 08:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737390210; x=1737995010; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hBDzS6VwvH8X7O7B3FLCvAQ6xo0j0Nw4vahiTQPox4s=;
        b=BovqAkcjTrYk+ElfxwEX9jcbgrLGxOVxJTOYmeCI+VZ7luw5bxc5W6zwtK2Knus0VE
         kY5ybzxJxN5aWQES3rwwNYnm4qSYLdUwJFftbFtIImDNjRvJL3zGI/zQFqYY1p+lAlAG
         q29LzHdMSuOl3tN1SolGs1wlcZ1A68ga5L3I3ujo9vkXilSsJYIpVW911/2CVorbEh/T
         igXsStTxM6SesIeOq6QiRxz9mKHHw4MY9efL0gcRlqoOChyqdMGlo9WhaDaKi051xyB1
         o93CqA0SRjxfwbL1OdtisM93L8Tq/McrAIh/HcyOCsqW8W3Ask5At8lhHmudqfv7/Vcb
         1LeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737390210; x=1737995010;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBDzS6VwvH8X7O7B3FLCvAQ6xo0j0Nw4vahiTQPox4s=;
        b=uv7Dz3lkmmOcG+p/n4HAEhbjlob3rbEuxJqJdxDj3DB1r7oQwxOixbnplWvpwMcSBr
         UIM2BmIdh/831KtMNbFCEHIr2emaqvmVl36jK4tTw4z6ZH0HGD9ld+LPazBWGfFKNqYu
         2hQ1MYcXDPx8HAKayRx/TzSp1XmSiBWiEZFOacVyKOuDZDVeDIP6rw3AAgOpJvkNDpO1
         Gj653OoNoTsoENcetqP3Rv+ARnVvJRDyogD2p9PdCbjvfCQJZcsnjrJzaTAnh7ASmjcZ
         xkL/4T+9oelz2w8ruvyLjZ6CwXGK+nex5SsRzNS9i7GxM+4H09iuQIjj45Hri8ni0z95
         B8fQ==
X-Forwarded-Encrypted: i=1; AJvYcCUX6D7vk+He88Zam7Xh1CQwa8ZivuezSoLKXhc2uCjnPkjbHFV0NPXj9+dyATFIoOS/hNL/YKmQWXgvaEaT@vger.kernel.org, AJvYcCVZh3aRMWKK8U1nEhCW8dU8w4jiWUyi6QxDdvaIBbnsr7UZxGjJA62J/09BpSaiaNFtg8hMPgEkHv5+3d4=@vger.kernel.org, AJvYcCXtsKBXxgEh+b1KNU9b5K7/GB7dptftW96FnFI/QjsGuq5O3ON0HcwMpw+SvljfKGMzOlpPQT7v+Mkv4Zc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+feW6Klh+yJ9Ks5QfwctZayifZ0yCAEZ4rzLBqTScdgNFwoOL
	g1ysZctju7SOffo7nmNV6nDd+oZlEW1uDrCFOfosfRspZsqYZHybxYFnRw==
X-Gm-Gg: ASbGnctYDVzme6ISMpyhtP+iwqLaH9y9Da99GAbOIqTyiSEGyq3ky8Vys7y0iwMkFV6
	dN2ZqHTY4/jgfqKlZHJ4qEMyJty51RlPz/TMKYCser63jtvem6Ae/H8axc23/ygXU413pWzgRCb
	BT54ABm7ZbDBhUpTQh3Rgw56onTrGjrZ77xG0j8rqiLCgukxwSSuJ7QOJYPdAfAOJzcgpSh6ZZI
	iIzosRweSlUnA510D1Q80LQHwvs22UmljfSqJR8WCvtldVaAefP7gFtGvNhYO1bDmSMQ5ZyfEvy
	dtcPz0K1yvxRigamzsmfIrGexBN2WQXdrPWyL3nmt9+CKpm0qypAaPYx
X-Google-Smtp-Source: AGHT+IH0vj1NEPrL2fULF2OeUFJ7VBn9vEp7/XOFCer+UqR97w+GrSLfInrta6Rs0GqeEsgewNM1TA==
X-Received: by 2002:a05:600c:3544:b0:434:a781:f5e2 with SMTP id 5b1f17b1804b1-438913cabedmr117993265e9.8.1737390210251;
        Mon, 20 Jan 2025 08:23:30 -0800 (PST)
Received: from orome (p200300e41f281900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:1900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c74c475csm207620425e9.20.2025.01.20.08.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 08:23:28 -0800 (PST)
Date: Mon, 20 Jan 2025 17:23:26 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: John Ogness <john.ogness@linutronix.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, 
	Niklas Schnelle <schnelle@linux.ibm.com>, Serge Semin <fancer.lancer@gmail.com>, 
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH tty-next v5 5/6] serial: 8250: Switch to nbcon console
Message-ID: <sx4nrwuzs3vafnbrkgag4dkapll3itvece4k3ylvobvid2vlpk@oncxz3eq33zk>
References: <20250107212702.169493-1-john.ogness@linutronix.de>
 <20250107212702.169493-6-john.ogness@linutronix.de>
 <80b020fc-c18a-4da4-b222-16da1cab2f4c@nvidia.com>
 <84ldvcyq41.fsf@jogness.linutronix.de>
 <96b02b20-a51e-480f-a0ce-3a1457650ca9@nvidia.com>
 <84y0zbyrf0.fsf@jogness.linutronix.de>
 <bee7de35-e767-4c69-94ad-d09c92a3577a@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bdxbf5etrjypj6iv"
Content-Disposition: inline
In-Reply-To: <bee7de35-e767-4c69-94ad-d09c92a3577a@nvidia.com>


--bdxbf5etrjypj6iv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH tty-next v5 5/6] serial: 8250: Switch to nbcon console
MIME-Version: 1.0

On Thu, Jan 16, 2025 at 10:41:08AM +0000, Jon Hunter wrote:
>=20
> On 16/01/2025 10:38, John Ogness wrote:
> > On 2025-01-16, Jon Hunter <jonathanh@nvidia.com> wrote:
> > > > Do you at least know if it is failing to suspend or failing to resu=
me
> > > > (based on power consumption)?
> > >=20
> > >=20
> > > Unfortunately, I don't. These are farm boards and so nothing local I =
can
> > > get my hands on. For some reason all the serial console logs are not
> > > available and so I am going to talk to the farm team about fixing that
> > > because we should at least have serial logs.
> >=20
> > Can you confirm that the board is actually booting? The suspend code for
> > 8250_tegra.c is quite simple. I am wondering if the farm tests are
> > failing somewhere else, such as the atomic printing during early boot.
>=20
>=20
> Yes they are all booting fine. I have an independent boot test and that is
> passing. It is just the suspend test that is failing.

I was able to capture logs, but unfortunately they don't provide much
insight either. On the first try it doesn't suspend and goes back to
userspace after a second or so:

--- >8 ---
-sh-5.1# rtcwake --device /dev/rtc1 --mode mem --seconds 5
rtcwake: assuming RTC uses UTC ...
rtcwake: wakeup from "mem" using /dev/rtc1 at Thu Jan  1 00:01:00 1970
[   36.332486] PM: suspend entry (deep)
[   36.332832] Filesystems sync: 0.000 seconds
[   36.369331] +1.8V_RUN_CAM: disabling
[   36.373884] +2.8V_RUN_CAM: disabling
[   36.375571] +1.2V_RUN_CAM_FRONT: disabling
[   36.380359] +1.05V_RUN_CAM_REAR: disabling
[   36.387399] +3.3V_RUN_TOUCH: disabling
[   36.390808] +2.8V_RUN_CAM_AF: disabling
[   36.393621] +1.8V_RUN_VPP_FUSE: disabling
[   36.408218] Freezing user space processes
[   36.413660] Freezing user space processes completed (elapsed 0.005 secon=
ds)
[   36.413680] OOM killer disabled.
[   36.413693] Freezing remaining freezable tasks
[   36.415033] Freezing remaining freezable tasks completed (elapsed 0.001 =
seconds)
[   36.428474] drm drm: [drm:drm_client_dev_suspend] fbdev: ret=3D0
[   36.428527] drm drm: [drm:drm_atomic_state_init] Allocated atomic state =
2e5cd010
[   36.428547] drm drm: [drm:drm_atomic_get_crtc_state] Added [CRTC:47:crtc=
-0] 6a6be0ef state to 2e5cd010
[   36.428561] drm drm: [drm:drm_atomic_get_crtc_state] Added [CRTC:63:crtc=
-1] 00d818c2 state to 2e5cd010
[   36.428574] drm drm: [drm:drm_atomic_get_plane_state] Added [PLANE:32:pl=
ane-0] 4e145b7d state to 2e5cd010
[   36.428587] drm drm: [drm:drm_atomic_get_plane_state] Added [PLANE:36:pl=
ane-1] dbf67d12 state to 2e5cd010
[   36.428597] drm drm: [drm:drm_atomic_get_plane_state] Added [PLANE:40:pl=
ane-2] 763d8809 state to 2e5cd010
[   36.428608] drm drm: [drm:drm_atomic_get_plane_state] Added [PLANE:44:pl=
ane-3] b6eabcf1 state to 2e5cd010
[   36.428617] drm drm: [drm:drm_atomic_get_plane_state] Added [PLANE:48:pl=
ane-4] 7863878c state to 2e5cd010
[   36.428628] drm drm: [drm:drm_atomic_get_plane_state] Added [PLANE:52:pl=
ane-5] 54b8029c state to 2e5cd010
[   36.428638] drm drm: [drm:drm_atomic_get_plane_state] Added [PLANE:56:pl=
ane-6] 364063af state to 2e5cd010
[   36.428648] drm drm: [drm:drm_atomic_get_plane_state] Added [PLANE:60:pl=
ane-7] e1c11dfb state to 2e5cd010
[   36.428662] drm drm: [drm:drm_atomic_get_connector_state] Added [CONNECT=
OR:65:HDMI-A-1] 5cb32770 state to 2e5cd010
[   36.428674] drm drm: [drm:drm_atomic_state_init] Allocated atomic state =
832943c7
[   36.428682] drm drm: [drm:drm_atomic_get_crtc_state] Added [CRTC:47:crtc=
-0] f09cf73d state to 832943c7
[   36.428691] drm drm: [drm:drm_atomic_add_affected_planes] Adding all cur=
rent planes for [CRTC:47:crtc-0] to 832943c7
[   36.428700] drm drm: [drm:drm_atomic_add_affected_connectors] Adding all=
 current connectors for [CRTC:47:crtc-0] to 832943c7
[   36.428711] drm drm: [drm:drm_atomic_get_crtc_state] Added [CRTC:63:crtc=
-1] 2700922c state to 832943c7
[   36.428720] drm drm: [drm:drm_atomic_add_affected_planes] Adding all cur=
rent planes for [CRTC:63:crtc-1] to 832943c7
[   36.428727] drm drm: [drm:drm_atomic_add_affected_connectors] Adding all=
 current connectors for [CRTC:63:crtc-1] to 832943c7
[   36.428737] drm drm: [drm:drm_atomic_check_only] checking 832943c7
[   36.428759] drm drm: [drm:drm_atomic_commit] committing 832943c7
[   36.428881] drm drm: [drm:drm_atomic_state_default_clear] Clearing atomi=
c state 832943c7
[   36.428897] drm drm: [drm:__drm_atomic_state_free] Freeing atomic state =
832943c7
[   36.429085] r8169 0000:01:00.0 eth0: Link is Down
[   36.713236] Disabling non-boot CPUs ...
-sh-5.1#
--- >8 ---

A second attempt soft-hangs:

--- >8 ---
-sh-5.1# rtcwake --device /dev/rtc1 --mode mem --seconds 5
rtcwake: assuming RTC uses UTC ...
rtcwake: wakeup from "mem" using /dev/rtc1 at Thu Jan  1 00:01:10 1970
--- >8 ---

Where "soft-hang" means it doesn't do anything after this and I can't
SIGINT out of it or anything. However, the serial seems to still be
responsive.

Thierry

--bdxbf5etrjypj6iv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmeOeHoACgkQ3SOs138+
s6EnRQ//dzgeuFUjt/OajK4lqEf/jBgpmoOGQz3nlfNjhdgOdZO+q6XyVPgr8oDJ
ewcxSSIHJWA5ZL1biqLEmBSNM0AYtJQWhO9PpsEKqOIru1iO8EtcWvTEt+lTl6mN
XnssnNZsTEy3bbsfk0/u7W4FXMsFP+KRyfwWhkljSv57AP6H6wUpd5IZlkDgbBLJ
TD52f1S/WTjI7CM/0GOnxnEYf8VegR39w1Vz0+Ah0ZljCICtYUvRcAnESXcm1/Mm
Z3J9PLcxMnBjfTsnfWpMRYdhM5TyWhRgcsYQDG0U0Z2dLb7OgONWQ5OsWU/QJxfV
/cLfPIimUHXUO4rDqwpwgCLtvKU06zR3op2StZzMYpaZ7hUW1pZyEJ8TmnosroIh
FJzS00mp7YWHiaEgf+zhM8NzwmOKb2VKSWqovDPiYnoJ/O0zrt0ud+wF5Vs9beoH
gcQw2IdtFRAO9kOAXD8eCqfC6lQzuUIynyfZlLEDCj0nrty977mi2e4CPKQTRnrN
S7vmof7ewEbTxhyftMulMo8Q0wt51+gW0VAX3hogIyy/m1cTlFtQWb9RhGUodzza
MbWIjTr064rodpYnxc8Wd8EFI4CIAu0Ym9zRu/RCvDOD/7ZqxJgBt7Wj3QYf8+4d
YYUZHInKJ/UT1ckg9Wd0OFzgEI6YXdzE5XcwG96+9dpto1pzQJQ=
=GucT
-----END PGP SIGNATURE-----

--bdxbf5etrjypj6iv--
