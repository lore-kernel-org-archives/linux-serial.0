Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F69925BEEB;
	Wed, 11 Jun 2025 11:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749641447; cv=none; b=TVEbN3x4vaaCbnAnNfaTAF8sp/a91iPA6mUfnZdcBF1VCb1VbJt53Ao9giFwptlkcuoqJwFCSws/73QAGMC8xSB57bYWbPUswKKFJqXs4SuWQIYjpXrPF+4p8YBAvVagmVLumEG/mS5dpdxudOc56DVXcnAhLpsairpkSe5L+eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749641447; c=relaxed/simple;
	bh=KQrqtEH0etXWoUXGzvlnizb+C+/gmbJQ4VquC2KTQEo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QoPc5bbYLm9F+9T4UhFrLThRt73GhS7zzYWQ1qF0cDefg7EEEUsMMlfYFBY6p4g0CdrBaiU0a2jd7DTFeIL5yCHBT3HsgtBgbWU3w4NZSjRaQ3DhMep7bOHmKaT/CQbtC7iAUAPPiGmYEyxnQRmKCkc9eGCGNzy33Q56tqzXAW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OEvdk6yF; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OEvdk6yF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749641446; x=1781177446;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=KQrqtEH0etXWoUXGzvlnizb+C+/gmbJQ4VquC2KTQEo=;
  b=OEvdk6yFG27PX42dY2k3Nnypa+qwrp0uEhOxtR2gZqcNOli5x37KFIAe
   X8FSLsHGo9MPVL5BmbAWtZ4Mln1LSoPTjrElvqJLFb2ad3Mrygcq9pR+M
   XXp/KB9G87uUjBNoTpWh8yi76fl0wq/+ujI6mhr389cBw7qU6VOoNvOj+
   nIhejYjC5QbDrDBhdlbdOVI6rZSZWx7ym+GUKVflojp2mVMVcFmBa50YW
   L3QfaP4aWHwkBqRzy0puugyAIldqUZOOHpj55loeq9wCJB3GP5w9Z+6fz
   Sq/BNrUkfhxgzFaDQszCevudznVb2WzKMWc0B/urAdRDTRy8447wJ53NB
   g==;
X-CSE-ConnectionGUID: STY4W1ZzTXq/7nYtr4Ei2w==
X-CSE-MsgGUID: jhvT7LDxR9SgECW2lOm88Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="51642790"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="51642790"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 04:30:44 -0700
X-CSE-ConnectionGUID: 8lmJBuFMSJmfzMHixfqJmQ==
X-CSE-MsgGUID: 3w/GH2mxTZGSz/Q5cXhc7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="152161957"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.183])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 04:30:42 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 11 Jun 2025 14:30:37 +0300 (EEST)
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, 
    linux-kernel@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 07/33] tty: vt: use _IO() to define ioctl numbers
In-Reply-To: <20250611100319.186924-8-jirislaby@kernel.org>
Message-ID: <0c69d88b-d6a8-b6e7-9482-5ac21fc88192@linux.intel.com>
References: <20250611100319.186924-1-jirislaby@kernel.org> <20250611100319.186924-8-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1458262110-1749641437=:957"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1458262110-1749641437=:957
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 11 Jun 2025, Jiri Slaby (SUSE) wrote:

> _IO*() is the proper way of defining ioctl numbers. All these vt numbers
> were synthetically built up the same way the _IO() macro does.
>=20
> So instead of implicit hex numbers, use _IO() properly.
>=20
> To not change the pre-existing numbers, use only _IO() (and not _IOR()
> or _IOW()). The latter would change the numbers indeed.
>=20
> Objdump of vt_ioctl.o reveals no difference with this patch.
>=20
> Again, VT_GETCONSIZECSRPOS already uses _IOR(), so everything is paved
> for this patch.
>=20
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Nicolas Pitre <nico@fluxnic.net>

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

> ---
>  include/uapi/linux/vt.h | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
>=20
> diff --git a/include/uapi/linux/vt.h b/include/uapi/linux/vt.h
> index 714483d68c69..b60fcdfb2746 100644
> --- a/include/uapi/linux/vt.h
> +++ b/include/uapi/linux/vt.h
> @@ -14,9 +14,9 @@
>  =09=09/* Note: the ioctl VT_GETSTATE does not work for
>  =09=09   consoles 16 and higher (since it returns a short) */
> =20
> -/* 0x56 is 'V', to avoid collision with termios and kd */
> +/* 'V' to avoid collision with termios and kd */
> =20
> -#define VT_OPENQRY=090x5600=09/* find available vt */
> +#define VT_OPENQRY=09=09_IO('V', 0x00)=09/* find available vt */
> =20
>  struct vt_mode {
>  =09__u8 mode;=09=09/* vt mode */
> @@ -25,8 +25,8 @@ struct vt_mode {
>  =09__s16 acqsig;=09=09/* signal to raise on acquisition */
>  =09__s16 frsig;=09=09/* unused (set to 0) */
>  };
> -#define VT_GETMODE=090x5601=09/* get mode of active vt */
> -#define VT_SETMODE=090x5602=09/* set mode of active vt */
> +#define VT_GETMODE=09=09_IO('V', 0x01)=09/* get mode of active vt */
> +#define VT_SETMODE=09=09_IO('V', 0x02)=09/* set mode of active vt */
>  #define=09=09VT_AUTO=09=090x00=09/* auto vt switching */
>  #define=09=09VT_PROCESS=090x01=09/* process controls switching */
>  #define=09=09VT_ACKACQ=090x02=09/* acknowledge switch */
> @@ -36,21 +36,21 @@ struct vt_stat {
>  =09__u16 v_signal;=09/* signal to send */
>  =09__u16 v_state;=09=09/* vt bitmask */
>  };
> -#define VT_GETSTATE=090x5603=09/* get global vt state info */
> -#define VT_SENDSIG=090x5604=09/* signal to send to bitmask of vts */
> +#define VT_GETSTATE=09=09_IO('V', 0x03)=09/* get global vt state info */
> +#define VT_SENDSIG=09=09_IO('V', 0x04)=09/* signal to send to bitmask of=
 vts */
> =20
> -#define VT_RELDISP=090x5605=09/* release display */
> +#define VT_RELDISP=09=09_IO('V', 0x05)=09/* release display */
> =20
> -#define VT_ACTIVATE=090x5606=09/* make vt active */
> -#define VT_WAITACTIVE=090x5607=09/* wait for vt active */
> -#define VT_DISALLOCATE=090x5608  /* free memory associated to vt */
> +#define VT_ACTIVATE=09=09_IO('V', 0x06)=09/* make vt active */
> +#define VT_WAITACTIVE=09=09_IO('V', 0x07)=09/* wait for vt active */
> +#define VT_DISALLOCATE=09=09_IO('V', 0x08)  /* free memory associated to=
 vt */
> =20
>  struct vt_sizes {
>  =09__u16 v_rows;=09=09/* number of rows */
>  =09__u16 v_cols;=09=09/* number of columns */
>  =09__u16 v_scrollsize;=09/* number of lines of scrollback */
>  };
> -#define VT_RESIZE=090x5609=09/* set kernel's idea of screensize */
> +#define VT_RESIZE=09=09_IO('V', 0x09)=09/* set kernel's idea of screensi=
ze */
> =20
>  struct vt_consize {
>  =09__u16 v_rows;=09/* number of rows */
> @@ -60,10 +60,10 @@ struct vt_consize {
>  =09__u16 v_vcol;=09/* number of pixel columns on screen */
>  =09__u16 v_ccol;=09/* number of pixel columns per character */
>  };
> -#define VT_RESIZEX      0x560A  /* set kernel's idea of screensize + mor=
e */
> -#define VT_LOCKSWITCH   0x560B  /* disallow vt switching */
> -#define VT_UNLOCKSWITCH 0x560C  /* allow vt switching */
> -#define VT_GETHIFONTMASK 0x560D  /* return hi font mask */
> +#define VT_RESIZEX=09=09_IO('V', 0x0A)  /* set kernel's idea of screensi=
ze + more */
> +#define VT_LOCKSWITCH=09=09_IO('V', 0x0B)  /* disallow vt switching */
> +#define VT_UNLOCKSWITCH=09=09_IO('V', 0x0C)  /* allow vt switching */
> +#define VT_GETHIFONTMASK=09_IO('V', 0x0D)  /* return hi font mask */
> =20
>  struct vt_event {
>  =09__u32 event;
> @@ -77,14 +77,14 @@ struct vt_event {
>  =09__u32 pad[4];=09=09/* Padding for expansion */
>  };
> =20
> -#define VT_WAITEVENT=090x560E=09/* Wait for an event */
> +#define VT_WAITEVENT=09=09_IO('V', 0x0E)=09/* Wait for an event */
> =20
>  struct vt_setactivate {
>  =09__u32 console;
>  =09struct vt_mode mode;
>  };
> =20
> -#define VT_SETACTIVATE=090x560F=09/* Activate and set the mode of a cons=
ole */
> +#define VT_SETACTIVATE=09=09_IO('V', 0x0F)=09/* Activate and set the mod=
e of a console */
> =20
>  /* get console size and cursor position */
>  struct vt_consizecsrpos {
>=20
--8323328-1458262110-1749641437=:957--
