Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5561E0DC0;
	Mon, 20 Jan 2025 16:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737390873; cv=none; b=SJMT+sOHDPxvbWivCCnp0iv4ZECPSphf2xmCe4/ijyTwm2nr9Ndg1RDeaGasuSlWROD+aUUq4+Wf8nRnqO9RF0SACKPKD+akuuWP09oByIuLzksW2v29fKRUrMD5HkoIq7chleUjQIRkKWdFECLntJYjuzEB8fmvME64ySgEurw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737390873; c=relaxed/simple;
	bh=NaOfdC4w2dusBKWhswHOIYMj7fgn4WHJ3PXero1V1d8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CB394nVBnuwbx9iQGlc1twH0J14qgKBI6/Hsmn3JJuEyWHQ2KLHXU9RhxxGrVVvUd6YyZ51AduURw5CYY0OS8t5jSzLV2MJs9E9w7b8lH8FcMH6bcbVL1a56Xd7d87+5PzSwA8g1oLPotvmNoEFR/eG/3NBZKbB9cI5Dn1Lohw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPJ/UFrP; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPJ/UFrP"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4361b0ec57aso48196145e9.0;
        Mon, 20 Jan 2025 08:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737390869; x=1737995669; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hlgzafycjr+D1IG8dXztsrTCccNsvQrvLPOu7qKber4=;
        b=CPJ/UFrPB2VUtc64e8WBKB99FWpQm0y9JRXi9FZ1a8rq4dG9V7uOyT/dAaSPyrpyXz
         bKu7ZdGaofBrGkHLQ2auSNFzC6QWOl8j+37BdelUN6O+4UTByjlG1B1WS0bAz7n/ZsQa
         y/K2qFYccWd0XCfl2SmPobEfoQ4oM9M/ikCkTB6EfmFxEzGop6t7XBJ1nW2sTGyK5Kj5
         AAqh8z2findBhB3g941GHno3BR+VNCjjaT63Ze3NsDzYtzHYlQj/woXiV3drgWLXx16q
         sMT6hJ5pMXx9qznipEG9Y74orLCoxF5uHZa/g9UmvEj/dghjEBHW0rTJdAKdsoOBtr/O
         f8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737390869; x=1737995669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlgzafycjr+D1IG8dXztsrTCccNsvQrvLPOu7qKber4=;
        b=lrKOndamFDz0PHCH7FOIkGEnNe0TgRkegPRO5SoNUypMq1h3dLYOtb/bHgnUxqHrVf
         qsxcJWIdBk+JxtSEDy/rxM/H9NvLvDyot7olSbAm98xcqZR97nOu0xTfL/IdwFtYdpha
         7p5bE4/z32Onx18bqxhKt/YEAf3tGdDwkkzAe/y1gpcY47R+quDo6yFgjlWD3M9zopmD
         xQcKGEIcizv1P7fWqCoYJxi7gnnU2OzC0fgXpU5E+CIUuMtOj5N24OQsPTclwY4uOfjZ
         tzd/pf8k6psAXlpVg9bCDTI+K2MksrkgZBzvu4lu6RZx4LwkKZyv64ZG4PaOCHdblHlA
         4rbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIg73cBn1A+0MhV8Hk70uiI7DGZ9yVdl1Na8p/1xc+yYcaZamGp6uQ9t8t8Se26MO9iagRuVQ4b7YVSKQ=@vger.kernel.org, AJvYcCVhL3DXqgSugiioUvnLNpw6jb2Om/uT7XQ3rbeN6t9uNA8LMWbFTDyFKZtb7TMaV7VZyZu1v3jmBw2zY2g=@vger.kernel.org, AJvYcCXefuahoHZt0DT0d+4H8BKAtXA+Ukjk2AVzIyO+YvUZd5omSboex2++PdHgXEG5BJF1+ic7JLGhlK/ea/H2@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn4En1G9yUUxGVJS1KBNFn5wOtjpFOaIjwjKBMuZX8Ec2B6cg1
	PjKaKChvqXMN67Uvk097HCRpKDDdplZ5XnyTojQT/Rsi1QsPGGjJ
X-Gm-Gg: ASbGncunY5lk3Y/kabTXsnpiqibAy62YpfFqkyxCRZlcJGm+d2Hq4+Pl/ChSPq9nepi
	eMU+3Fb90X2K1taIzV+k8lte3v0XME0RCeXhdNqPMgBC8Yu1OM99oIpoN234Mlc58YjprK1eqZl
	5f3nRXIWGsnnVdJHXi3fhbRRXIT2l1rENeSFZT4jFT33af7G7Fz4pM6R3rEQLPB1fT+lJ4IezBh
	YH6VhetGyqGeFcksRPz6Aqb0EnZgAoQfE27VFS2p6U77NoyUsU5J+IwnYZxsCmNU/sqz3wWJvbc
	9JYmNZhXBklEz74cRWFrgmu62GpDTELLncuK1Vogeao8T/atqzMjwVt7
X-Google-Smtp-Source: AGHT+IG9Y0Ek2Z67J+xIcMtfGU2PhyTql319o+NS9uUNbPE0E1G0g3V9P6Xe1lCTGzkwF4S/E1Rh3w==
X-Received: by 2002:a5d:52c7:0:b0:386:37f5:99e7 with SMTP id ffacd0b85a97d-38bf5674784mr10655959f8f.33.1737390869315;
        Mon, 20 Jan 2025 08:34:29 -0800 (PST)
Received: from orome (p200300e41f281900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:1900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3215066sm11122929f8f.11.2025.01.20.08.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 08:34:28 -0800 (PST)
Date: Mon, 20 Jan 2025 17:34:26 +0100
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
Message-ID: <lrpcbufgu7jnvepqkd3sz2qap2th45ndzv4c4vxh7v4zyhep6k@t635s7vbhkgz>
References: <20250107212702.169493-1-john.ogness@linutronix.de>
 <20250107212702.169493-6-john.ogness@linutronix.de>
 <80b020fc-c18a-4da4-b222-16da1cab2f4c@nvidia.com>
 <84ldvcyq41.fsf@jogness.linutronix.de>
 <96b02b20-a51e-480f-a0ce-3a1457650ca9@nvidia.com>
 <84y0zbyrf0.fsf@jogness.linutronix.de>
 <bee7de35-e767-4c69-94ad-d09c92a3577a@nvidia.com>
 <sx4nrwuzs3vafnbrkgag4dkapll3itvece4k3ylvobvid2vlpk@oncxz3eq33zk>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="w7gy37l5ix2lyorf"
Content-Disposition: inline
In-Reply-To: <sx4nrwuzs3vafnbrkgag4dkapll3itvece4k3ylvobvid2vlpk@oncxz3eq33zk>


--w7gy37l5ix2lyorf
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH tty-next v5 5/6] serial: 8250: Switch to nbcon console
MIME-Version: 1.0

On Mon, Jan 20, 2025 at 05:23:26PM +0100, Thierry Reding wrote:
> On Thu, Jan 16, 2025 at 10:41:08AM +0000, Jon Hunter wrote:
> >=20
> > On 16/01/2025 10:38, John Ogness wrote:
> > > On 2025-01-16, Jon Hunter <jonathanh@nvidia.com> wrote:
> > > > > Do you at least know if it is failing to suspend or failing to re=
sume
> > > > > (based on power consumption)?
> > > >=20
> > > >=20
> > > > Unfortunately, I don't. These are farm boards and so nothing local =
I can
> > > > get my hands on. For some reason all the serial console logs are not
> > > > available and so I am going to talk to the farm team about fixing t=
hat
> > > > because we should at least have serial logs.
> > >=20
> > > Can you confirm that the board is actually booting? The suspend code =
for
> > > 8250_tegra.c is quite simple. I am wondering if the farm tests are
> > > failing somewhere else, such as the atomic printing during early boot.
> >=20
> >=20
> > Yes they are all booting fine. I have an independent boot test and that=
 is
> > passing. It is just the suspend test that is failing.
>=20
> I was able to capture logs, but unfortunately they don't provide much
> insight either. On the first try it doesn't suspend and goes back to
> userspace after a second or so:
>=20
> --- >8 ---
> -sh-5.1# rtcwake --device /dev/rtc1 --mode mem --seconds 5
> rtcwake: assuming RTC uses UTC ...
> rtcwake: wakeup from "mem" using /dev/rtc1 at Thu Jan  1 00:01:00 1970
> [   36.332486] PM: suspend entry (deep)
> [   36.332832] Filesystems sync: 0.000 seconds
> [   36.369331] +1.8V_RUN_CAM: disabling
> [   36.373884] +2.8V_RUN_CAM: disabling
> [   36.375571] +1.2V_RUN_CAM_FRONT: disabling
> [   36.380359] +1.05V_RUN_CAM_REAR: disabling
> [   36.387399] +3.3V_RUN_TOUCH: disabling
> [   36.390808] +2.8V_RUN_CAM_AF: disabling
> [   36.393621] +1.8V_RUN_VPP_FUSE: disabling
> [   36.408218] Freezing user space processes
> [   36.413660] Freezing user space processes completed (elapsed 0.005 sec=
onds)
> [   36.413680] OOM killer disabled.
> [   36.413693] Freezing remaining freezable tasks
> [   36.415033] Freezing remaining freezable tasks completed (elapsed 0.00=
1 seconds)
> [   36.428474] drm drm: [drm:drm_client_dev_suspend] fbdev: ret=3D0
> [   36.428527] drm drm: [drm:drm_atomic_state_init] Allocated atomic stat=
e 2e5cd010
> [   36.428547] drm drm: [drm:drm_atomic_get_crtc_state] Added [CRTC:47:cr=
tc-0] 6a6be0ef state to 2e5cd010
> [   36.428561] drm drm: [drm:drm_atomic_get_crtc_state] Added [CRTC:63:cr=
tc-1] 00d818c2 state to 2e5cd010
> [   36.428574] drm drm: [drm:drm_atomic_get_plane_state] Added [PLANE:32:=
plane-0] 4e145b7d state to 2e5cd010
> [   36.428587] drm drm: [drm:drm_atomic_get_plane_state] Added [PLANE:36:=
plane-1] dbf67d12 state to 2e5cd010
> [   36.428597] drm drm: [drm:drm_atomic_get_plane_state] Added [PLANE:40:=
plane-2] 763d8809 state to 2e5cd010
> [   36.428608] drm drm: [drm:drm_atomic_get_plane_state] Added [PLANE:44:=
plane-3] b6eabcf1 state to 2e5cd010
> [   36.428617] drm drm: [drm:drm_atomic_get_plane_state] Added [PLANE:48:=
plane-4] 7863878c state to 2e5cd010
> [   36.428628] drm drm: [drm:drm_atomic_get_plane_state] Added [PLANE:52:=
plane-5] 54b8029c state to 2e5cd010
> [   36.428638] drm drm: [drm:drm_atomic_get_plane_state] Added [PLANE:56:=
plane-6] 364063af state to 2e5cd010
> [   36.428648] drm drm: [drm:drm_atomic_get_plane_state] Added [PLANE:60:=
plane-7] e1c11dfb state to 2e5cd010
> [   36.428662] drm drm: [drm:drm_atomic_get_connector_state] Added [CONNE=
CTOR:65:HDMI-A-1] 5cb32770 state to 2e5cd010
> [   36.428674] drm drm: [drm:drm_atomic_state_init] Allocated atomic stat=
e 832943c7
> [   36.428682] drm drm: [drm:drm_atomic_get_crtc_state] Added [CRTC:47:cr=
tc-0] f09cf73d state to 832943c7
> [   36.428691] drm drm: [drm:drm_atomic_add_affected_planes] Adding all c=
urrent planes for [CRTC:47:crtc-0] to 832943c7
> [   36.428700] drm drm: [drm:drm_atomic_add_affected_connectors] Adding a=
ll current connectors for [CRTC:47:crtc-0] to 832943c7
> [   36.428711] drm drm: [drm:drm_atomic_get_crtc_state] Added [CRTC:63:cr=
tc-1] 2700922c state to 832943c7
> [   36.428720] drm drm: [drm:drm_atomic_add_affected_planes] Adding all c=
urrent planes for [CRTC:63:crtc-1] to 832943c7
> [   36.428727] drm drm: [drm:drm_atomic_add_affected_connectors] Adding a=
ll current connectors for [CRTC:63:crtc-1] to 832943c7
> [   36.428737] drm drm: [drm:drm_atomic_check_only] checking 832943c7
> [   36.428759] drm drm: [drm:drm_atomic_commit] committing 832943c7
> [   36.428881] drm drm: [drm:drm_atomic_state_default_clear] Clearing ato=
mic state 832943c7
> [   36.428897] drm drm: [drm:__drm_atomic_state_free] Freeing atomic stat=
e 832943c7
> [   36.429085] r8169 0000:01:00.0 eth0: Link is Down
> [   36.713236] Disabling non-boot CPUs ...
> -sh-5.1#
> --- >8 ---
>=20
> A second attempt soft-hangs:
>=20
> --- >8 ---
> -sh-5.1# rtcwake --device /dev/rtc1 --mode mem --seconds 5
> rtcwake: assuming RTC uses UTC ...
> rtcwake: wakeup from "mem" using /dev/rtc1 at Thu Jan  1 00:01:10 1970
> --- >8 ---
>=20
> Where "soft-hang" means it doesn't do anything after this and I can't
> SIGINT out of it or anything. However, the serial seems to still be
> responsive.

To clarify, this was on top of next-20250120 and reverting the patches
that Jon mentioned suspend/resume is fixed for me as well.

I do have a local device that I can test on, so if there's any patches
you want me to try, or any options to enable to get more information,
please let me know.

Thanks,
Thierry

--w7gy37l5ix2lyorf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmeOexIACgkQ3SOs138+
s6FsMRAAuKWWsfRVrZ4KfwdQevPuem8lnl06hHKC5IZHuPuCqMVhv3t6qP3T6vHI
AG/TPVMs5vyhtEapLdI/Ne3rBh6Med8/+GoZAkLa8HGs7Zz7mrGO2gjGAwBTjEKP
bVvXA+je9RfUCr5dL2zW/2cGvdbSu74hBGE64oyuGk+U3WXHsU8LGrxmkm69wPSi
MfI0T6YT0CuLnHuQDr3rL9ceq6zU8wwwF/6dmFbHoIWp1A12um6HbaiRK/tt7bGx
enOJEY2eNWOewpG91NIPNjr70jr7tXhh+HW1/BooZSkphIsSHsJT5b+5vyqIgxFn
kQtS5+tptVMUk719SoLayiALcm3TiGNgkpcrYH6fbGFUB3C97n/evzGjXn1TcmXK
e0XDbxG5naDnFvkR4zSIJQpIalZnzTE3JvAo0Qa0+3Z8MzJkf0rrzAV5yBW9bR5O
/ZAFepJmZTPlHe51/gxwFuxKU7jgWIYYhrNtvwPV7QlV3PYLAF1JHYRIwovH2c2L
ISypb1PerCIwakek+sELZuBHfEYbm9i2my90B4wvjwjAXZlxZ0DZLHnCwh7uyAjQ
guWDB5dEGw0rmzwbtzi2ul4dyN1zqXJsSbhWTTcZssFbT/nq/Wtanho90Yds5set
AbwWyANMaaAjidQuTltZWoSpCJvgk/MqqPe1Ygc/jDMHy60dkAs=
=bSL4
-----END PGP SIGNATURE-----

--w7gy37l5ix2lyorf--
