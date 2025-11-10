Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD0A306B21;
	Mon, 10 Nov 2025 10:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762771413; cv=none; b=kGsGgfr8VCM75oNECxbWLMc0167WjoRT7kBCaOkwwH1X/KvPkJi5O+5UgAc5/MuhwH2wRJWRfKtkOh3GD/I0gj2jUy/1cGyuCVV6OEqWUQlgRVlAT8w5nBY6a4O8ZColrjV2f8A7eQMLSAi1nBOte/rSlkFEOBIvMvhfDLFDbrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762771413; c=relaxed/simple;
	bh=CWZ+v9Aa714nliB9kR2HOKc62+ldN8K4Qh1U+sPy/rA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bvhaWJAIjY0++M4VBGdXXerKou/3ISY/bt1XBp8Oy1+FsC1LIyl2YucwybUYlP6q9wPnyTvjwyzYpmNC1VOxDRPXOZcaveYkDE9Cf+sy9oQ3zas7+Y05Bf4IL5r9fFlDnqnsHxTnwCUbWa5iXPH6xOIUhtAky3ouxBv0A+sMDQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iWCPWabM; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iWCPWabM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762771411; x=1794307411;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=CWZ+v9Aa714nliB9kR2HOKc62+ldN8K4Qh1U+sPy/rA=;
  b=iWCPWabM8aDRPNA5Y+qjnFGI/Gh/hILnBAFjp6t7qrHNkqfXSuStwi37
   TAcjzjCVowMvFGhjVbaQBMUOWAHEpgs71XsFN/VIOqzcBaPLG/tkxTgM6
   7P4sdZwV+9Mi/jzD3BsLkmb1hcBUL4uxsd60F3D7YdzpZv3PnYcudh23a
   DpW0hYvN+4iEzLFCA4BzPl21G6CKSXLS1OcPlot2PXlDu+pqhSV4U4dpm
   KrYYy2LCbwlaJm/JQ+3D20rgmfVXLN7OQhrTvOACjb5cO+DNktMXxujhA
   ywwrFFOIYrTm7qYpCPMZhIlHjZe0C1efiNo1HfyGE2z4SjVe5jTRp/Laj
   g==;
X-CSE-ConnectionGUID: JlikWe9eTGyubRgLoaO0uw==
X-CSE-MsgGUID: SPmDdfH1RfWy4wacumbntA==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="75112029"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="75112029"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 02:43:31 -0800
X-CSE-ConnectionGUID: np1TOxVHTvqrE1kqp8Evpw==
X-CSE-MsgGUID: ANeosOeWS1uhMRMfkkSaSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="189082230"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.13])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 02:43:27 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 10 Nov 2025 12:43:22 +0200 (EET)
To: Stephen Rothwell <sfr@canb.auug.org.au>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: Jiri Slaby <jirislaby@kernel.org>, Alex Davis <alex47794@gmail.com>, 
    Borislav Petkov <bp@alien8.de>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
    John Ogness <john.ogness@linutronix.de>, 
    linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [Regression] depmod fails on kernel 6.17.1 rc1
In-Reply-To: <20251109173413.10c9aa0a@canb.auug.org.au>
Message-ID: <b1c99727-0d09-3a61-d82e-31e29801f837@linux.intel.com>
References: <CADiockCvM6v+d+UoFZpJSMoLAdpy99_h-hJdzUsdfaWGn3W7-g@mail.gmail.com> <20251106160235.GBaQzGm8W2Gt_VMy-s@fat_crate.local> <aQzJveMYT6O3EHeK@smile.fi.intel.com> <20251106162436.GFaQzLxBW-_50ndwtr@fat_crate.local> <3fe70726-80d6-a84a-4101-446fd8b49209@linux.intel.com>
 <ddfbc4bf-658f-3eda-5b4f-f111ecd932f5@linux.intel.com> <82e2ce7f-bd08-4b53-b232-3dd8cb1a0726@kernel.org> <20251109105203.622ebe9e@pine.rothwell.emu.id.au> <2025110956-swaddling-chapter-5932@gregkh> <20251109173413.10c9aa0a@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-185351875-1762770758=:1060"
Content-ID: <a498616d-2f88-7b39-c3dc-11f10df3890e@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-185351875-1762770758=:1060
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <ecc0b2e1-8407-bbb2-0409-02d056ac81fb@linux.intel.com>

On Sun, 9 Nov 2025, Stephen Rothwell wrote:
> On Sun, 9 Nov 2025 09:49:29 +0900 Greg Kroah-Hartman <gregkh@linuxfoundat=
ion.org> wrote:
> > On Sun, Nov 09, 2025 at 10:52:03AM +1100, Stephen Rothwell wrote:
> > > On Fri, 7 Nov 2025 07:20:26 +0100 Jiri Slaby <jirislaby@kernel.org> w=
rote: =20
> > > >
> > > > On 06. 11. 25, 19:00, Ilpo J=E4rvinen wrote: =20
> > > > > This seems to resolve the build issue for me:
> > > > >=20
> > > > > --
> > > > > From: =3D?UTF-8?q?Ilpo=3D20J=3DC3=3DA4rvinen?=3D <ilpo.jarvinen@l=
inux.intel.com>
> > > > > Subject: [PATCH 1/1] serial: 8250: Fix 8250_rsa symbol loop
> > > > >=20
> > > > > make allmodconfig build fails due to dependency loop:
> > > > >=20
> > > > >    depmod: ERROR: Cycle detected: 8250 -> 8250_base -> 8250
> > > > >    depmod: ERROR: Found 2 modules in dependency cycles!
> > > > >=20
> > > > > Break dependency loop by moving 8250_rsa.o into 8250_base and by
> > > > > passing univ8250_port_base_ops to univ8250_rsa_support() that can=
 make
> > > > > a local copy of it.
> > > > >=20
> > > > > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > > > Reported-by: Alex Davis <alex47794@gmail.com>
> > > > > Fixes: b20d6576cdb3 ("serial: 8250: export RSA functions")
> > > > > Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>   =
=20
> > > >=20
> > > > LGTM, thanks for the fix.
> > > >=20
> > > > Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
> > > >=20
> > > > If the reporters could give it a shot and mark this by Tested-by, i=
t would be great... =20
> > >=20
> > > I have not seen this for quite some time ... I assumed it had been
> > > fixed. =20
> >=20
> > I too thought this was fixed a while ago, what changed to cause this to
> > happen now?  Anyone have a .config to reproduce this, 'allmodconfig' on
> > x86 works for me.
>=20
> Actually, I think the current report is for v6.17.1-rc1, so maybe
> something got missed in a stable backport? My original report was for
> next-20250728 (July 28).  The only response I got was on October 1,
> but I am pretty sure it was fixed well before then.
>=20
> Also, you probably only get the error when you do a "make
> modules_install" after the allmodconfig build (at least that is where I
> got it).

Hi all,

I don't want to waste my time building allmodconfig but this is with=20
allnoconfig + a few key CONFIGs set and without my patch:

$ git log -n1
commit e9a6fb0bcdd7609be6969112f3fbfcce3b1d4a7c (grafted, HEAD -> master,=
=20
tag: v6.18-rc5, origin/master, origin/HEAD)
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun Nov 9 15:10:19 2025 -0800

    Linux 6.18-rc5
$ make allnoconfig
  LEX     scripts/kconfig/lexer.lex.c
  YACC    scripts/kconfig/parser.tab.[ch]
  HOSTCC  scripts/kconfig/lexer.lex.o
  HOSTCC  scripts/kconfig/menu.o
  HOSTCC  scripts/kconfig/parser.tab.o
  HOSTCC  scripts/kconfig/preprocess.o
  HOSTCC  scripts/kconfig/symbol.o
  HOSTCC  scripts/kconfig/util.o
  HOSTLD  scripts/kconfig/conf
#
# configuration written to .config
#
$ echo -e "CONFIG_MODULES=3Dy\nCONFIG_SERIAL_8250=3Dm\nCONFIG_SERIAL_8250_E=
XTENDED=3Dy\nCONFIG_SERIAL_8250_RSA=3Dy" >> .config=20
$ make olddefconfig
=2Econfig:1528:warning: override: reassigning to symbol MODULES
=2Econfig:1529:warning: override: reassigning to symbol SERIAL_8250
=2Econfig:1530:warning: override: reassigning to symbol SERIAL_8250_EXTENDE=
D
#
# configuration written to .config
#
$ make -j4 > /dev/null && sudo make modules_install
  INSTALL /lib/modules/6.18.0-rc5/modules.order
  INSTALL /lib/modules/6.18.0-rc5/modules.builtin
  INSTALL /lib/modules/6.18.0-rc5/modules.builtin.modinfo
  SYMLINK /lib/modules/6.18.0-rc5/build
  INSTALL /lib/modules/6.18.0-rc5/kernel/drivers/tty/serial/8250/8250.ko
  INSTALL /lib/modules/6.18.0-rc5/kernel/drivers/tty/serial/8250/8250_base.=
ko
  INSTALL /lib/modules/6.18.0-rc5/kernel/drivers/tty/serial/serial_base.ko
  DEPMOD  /lib/modules/6.18.0-rc5
depmod: ERROR: Cycle detected: 8250 -> 8250_base -> 8250
depmod: ERROR: Found 2 modules in dependency cycles!
make[2]: *** [scripts/Makefile.modinst:132: depmod] Error 1
make[1]: *** [/home/user/linux/Makefile:1916: modules_install] Error 2
make: *** [Makefile:248: __sub-make] Error 2

=2E..so no, it does not look fixed.

With the patch:

$ git am 0001-serial-8250-Fix-8250_rsa-symbol-loop.patch=20
Applying: serial: 8250: Fix 8250_rsa symbol loop
user@disp1097:~/linux$ make -j4 > /dev/null && sudo make modules_install
  SYMLINK /lib/modules/6.18.0-rc5+/build
  INSTALL /lib/modules/6.18.0-rc5+/modules.order
  INSTALL /lib/modules/6.18.0-rc5+/modules.builtin
  INSTALL /lib/modules/6.18.0-rc5+/modules.builtin.modinfo
  INSTALL /lib/modules/6.18.0-rc5+/kernel/drivers/tty/serial/8250/8250.ko
  INSTALL /lib/modules/6.18.0-rc5+/kernel/drivers/tty/serial/8250/8250_base=
=2Eko
  INSTALL /lib/modules/6.18.0-rc5+/kernel/drivers/tty/serial/serial_base.ko
  DEPMOD  /lib/modules/6.18.0-rc5+
$=20

I'll just make the official submission with the #else block's prototype=20
fixed (thanks to lkp).

--=20
 i.
--8323328-185351875-1762770758=:1060--
