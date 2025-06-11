Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF406FB9;
	Wed, 11 Jun 2025 11:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749640962; cv=none; b=SVBQdLb/lViyBw7x/RV9TEH51B5bcI/h1cmMgJCNgChabKINK4W01qslv3yLLXxVF0GMnSWw38g71VC3Hcmy4D5lauNAeSzOUidA8JXgSx0xwHKI4Ufh8mp8jAQhakaRLRaBZlq/boZu1o0Of+dTAqBUn4gMiSXRJRrUQ8NPWl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749640962; c=relaxed/simple;
	bh=Qe6Nr2dHM83kzSqpO6AU8+NASoIrgEuIaTGJZzzqwls=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mWvONG3nKTum/ksqaOCuH6MPtPm2Ho1SBHwZY3SS8J5qCTUxw/8FFzg77NPF8DZ5JYiMSaKb8k79Z2SvQoGsii2u0Re0YzMZJ7DlJEMgZ1Y34RZkdGxgIxs0M2drcbpEeBw25x7Oe39xVI6BB3MBM+/an/gyp7OekVps+W2Z7zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fVrV3M04; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fVrV3M04"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749640961; x=1781176961;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Qe6Nr2dHM83kzSqpO6AU8+NASoIrgEuIaTGJZzzqwls=;
  b=fVrV3M04dmAUeT99dk53/9CzMU8EjJVf7b1Jx8xSDyE13PXYob0lx91X
   P8V3RrOa0qyJ2qrpWkTdgUgYJx/mIAdYAOhzZh55MndD59thZQB+Pka16
   ysj6QD+5RYyEME6on532/smqpYbcrkjllrfnG99GJ2KipbT0yD8XA0Ady
   5oz31UGkofuO9n22n+2QIyOnUm+h+zf6F9NC/zqRkOIpaJnSBuJWzuO02
   H1l390mrnqwmR45eNQ06Zz7aYbDDuPUtU53vGoohurfND/w0DSH1MYG6I
   crbjpXHTDmKRbi1Y62iwLhGptEy2uQfyp4CuNF67uCLaINBIIlBmsf8kC
   w==;
X-CSE-ConnectionGUID: wsUSBSJTS6qKrLXP5AqQng==
X-CSE-MsgGUID: qiu9jxTRQrOfP65X3R2nug==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="62058877"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="62058877"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 04:22:40 -0700
X-CSE-ConnectionGUID: Ojyg/RhjTriSvTpn1TMQ5w==
X-CSE-MsgGUID: 52oD8a70SvawWK4mDJNmAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="147017158"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.183])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 04:22:38 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 11 Jun 2025 14:22:34 +0300 (EEST)
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Geert Uytterhoeven <geert@linux-m68k.org>, 
    Joshua Thompson <funaho@jurai.org>, linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH 04/33] m68k: remove unneeded tty includes
In-Reply-To: <20250611100319.186924-5-jirislaby@kernel.org>
Message-ID: <2e994f05-8aa9-82c0-e8e3-927730dccadf@linux.intel.com>
References: <20250611100319.186924-1-jirislaby@kernel.org> <20250611100319.186924-5-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-843499514-1749640954=:957"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-843499514-1749640954=:957
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 11 Jun 2025, Jiri Slaby (SUSE) wrote:

> All these includes must have been cut & pasted. The code does not use
> any tty or vt functionality at all.
>=20
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Joshua Thompson <funaho@jurai.org>
> Cc: linux-m68k@lists.linux-m68k.org

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--
 i.

> ---
>  arch/m68k/amiga/config.c  | 2 --
>  arch/m68k/apollo/config.c | 2 --
>  arch/m68k/atari/config.c  | 1 -
>  arch/m68k/mac/config.c    | 2 --
>  arch/m68k/q40/config.c    | 2 --
>  5 files changed, 9 deletions(-)
>=20
> diff --git a/arch/m68k/amiga/config.c b/arch/m68k/amiga/config.c
> index 0147130dc34e..242d18e750b0 100644
> --- a/arch/m68k/amiga/config.c
> +++ b/arch/m68k/amiga/config.c
> @@ -16,12 +16,10 @@
>  #include <linux/kernel.h>
>  #include <linux/mm.h>
>  #include <linux/seq_file.h>
> -#include <linux/tty.h>
>  #include <linux/clocksource.h>
>  #include <linux/console.h>
>  #include <linux/rtc.h>
>  #include <linux/init.h>
> -#include <linux/vt_kern.h>
>  #include <linux/delay.h>
>  #include <linux/interrupt.h>
>  #include <linux/zorro.h>
> diff --git a/arch/m68k/apollo/config.c b/arch/m68k/apollo/config.c
> index e161ecd76035..e324c5f671de 100644
> --- a/arch/m68k/apollo/config.c
> +++ b/arch/m68k/apollo/config.c
> @@ -3,9 +3,7 @@
>  #include <linux/types.h>
>  #include <linux/kernel.h>
>  #include <linux/mm.h>
> -#include <linux/tty.h>
>  #include <linux/rtc.h>
> -#include <linux/vt_kern.h>
>  #include <linux/interrupt.h>
> =20
>  #include <asm/setup.h>
> diff --git a/arch/m68k/atari/config.c b/arch/m68k/atari/config.c
> index b48a0606a000..ee2d061efb2a 100644
> --- a/arch/m68k/atari/config.c
> +++ b/arch/m68k/atari/config.c
> @@ -33,7 +33,6 @@
>  #include <linux/ioport.h>
>  #include <linux/platform_device.h>
>  #include <linux/usb/isp116x.h>
> -#include <linux/vt_kern.h>
>  #include <linux/module.h>
> =20
>  #include <asm/bootinfo.h>
> diff --git a/arch/m68k/mac/config.c b/arch/m68k/mac/config.c
> index d26c7f4f8c36..c0033f885ed4 100644
> --- a/arch/m68k/mac/config.c
> +++ b/arch/m68k/mac/config.c
> @@ -15,7 +15,6 @@
>  #include <linux/reboot.h>
>  #include <linux/types.h>
>  #include <linux/mm.h>
> -#include <linux/tty.h>
>  #include <linux/console.h>
>  #include <linux/interrupt.h>
>  /* keyb */
> @@ -23,7 +22,6 @@
>  #include <linux/delay.h>
>  /* keyb */
>  #include <linux/init.h>
> -#include <linux/vt_kern.h>
>  #include <linux/platform_device.h>
>  #include <linux/ata_platform.h>
>  #include <linux/adb.h>
> diff --git a/arch/m68k/q40/config.c b/arch/m68k/q40/config.c
> index de7870ad2a30..5a4258697622 100644
> --- a/arch/m68k/q40/config.c
> +++ b/arch/m68k/q40/config.c
> @@ -13,14 +13,12 @@
>  #include <linux/types.h>
>  #include <linux/kernel.h>
>  #include <linux/mm.h>
> -#include <linux/tty.h>
>  #include <linux/console.h>
>  #include <linux/linkage.h>
>  #include <linux/init.h>
>  #include <linux/major.h>
>  #include <linux/serial_reg.h>
>  #include <linux/rtc.h>
> -#include <linux/vt_kern.h>
>  #include <linux/bcd.h>
>  #include <linux/platform_device.h>
> =20
>=20
--8323328-843499514-1749640954=:957--
