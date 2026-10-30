Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793327645;
	b=TTxbJwAoq6ONiahMZ1KpN8B9a9PclcoNzIIvruVQtflCcRhuGbm6sujaqwZNMhADP2qm
	 SbVNVs1Hcu2ercvG3D2H7fROFh4PjJDh9o9L7t21PVDuML1B67rdH9SlQXrTv52s/O9Ns
	 24nVqPNBKuP5z74CQsnenYjoP3Gyji7evjaVtAPSQwvW1i0t6TNUsaeqm9o9rCZ9oXpRa
	 PPk1HCOwOOXPVZBVx5myLrZrbAOx0GTqnCPtc5FuSQywJbzhI6bG+RoZyrVlnOfyG88N3
	 Lk0lhMv9bHzHyt8U5sQslFTEYB5LQvCge3c1L84nLhB5ndlQWMKQzetjZ9k5qgg+M1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793327645;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=+ygKCXCE551eA/tJUkyJ0eX5BoqYd4HLW3FgIhHoRJY=;
	b=ui39IR8tXiadnoEdWx2egzdbBDxXsgMR6nze+CrHM2TOxsqxYwmZk5ioQMWBA5kaZEtw
	 pcNWulH5nAzBvWwoS336qxiL9uq7Q+xSMNUcwyRKIYnxeNV7XWILiQJ/kFxhmenOBpqo9
	 HgcfgSC4afgkQI9Rig5/Arqefze5R8oO/pcIZ2WNjtHuq9i46QEWoDYsyz3bYMIG3wKhI
	 yzhNPeLbrX65GrH8fLliVOqN64JMjRrSUCro2wnukTxVWtJ/8ydp11X1VBc4RAmNJvPEQ
	 S97P8sRZTTJbno0k+qk+H98X7zol1x9sP0NgqSsRqBuHSbquz15/KbDlQv8+Zs66uEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=kV4uLYKl;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A1E606A31D;
	Fri, 30 Oct 2026 02:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3A1E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=kV4uLYKl
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A37DA40E04CF;
	Fri, 30 Oct 2026 02:34:02 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id MZ4pvWbUOmGC; Fri, 30 Oct 2026 02:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1793327639; bh=+ygKCXCE551eA/tJUkyJ0eX5BoqYd4HLW3FgIhHoRJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kV4uLYKlNxL7QEgZ4wnIDNIuaY+72edTTyZHHk2KLcvU8L8VdXi5qoeH56T8XFVpN
	 VBdj3hQxGz0+YFcbeHci8YBew4pBo+xyuuCq6OlSmtyG5R2liEkgRbk5Vd4LzMxRqF
	 1/dWmMfrjvkojmmYOLfCi5d4q1z0uTNn+4UW/K9CxrcKT8esKSllW0DW4OnuYcGYPD
	 HylcrecQd1awMhxB+XKAWfp2O08dfXwr3G6ELCq7bSaDwoDNWFN5ANqn9aEkEf/+xK
	 JMcvI0SWOX90lKelqf29+oqX6+386QLnsaOLemBUlnyCUQcGgTgcJ311GLQ+TzAEGR
	 sAdfzhlW4rOwdI1iWLH7ZJ/kdVc5b3aOUTjRGFD1JnKfqSn7slfZTmPF4WKSa0CEVR
	 sNNb2HwkJG1C3mHafjqAjdrlegLjbE4x1OFXtICdM8x6RgVjuj5nq1DQAB0fJroAuD
	 GBdelCWUQioKfF/g3wMFhvgVaQBmxHBUKL6aqfJi4hXAbZp2TuT8j0mKxjKuw1wHsM
	 ogGP5hRcHn1OwDx7+C8chSH22l29xW7jAD3IU3uSGCXA7rvgay/WutPv0nDUgE6Z3H
	 nF4BEng8SZdQZ/MIdbbElHfXrTJCkPacoJXay/QqydJkstjKS4kIep028PivEQ+pi9
	 k1fnP3AiudNeeK8Pr1ehzMvk=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5852740E02B7;
	Fri, 30 Oct 2026 02:33:42 +0000 (UTC)
Date: Thu, 29 Oct 2026 19:33:38 -0700
From: Borislav Petkov <bp@alien8.de>
To: Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	"biju.das.au" <biju.das.au@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Au Dang <au.dang.jx@renesas.com>
Subject: [PATCH] MAINTAINERS: Fix Intel TDX kernel file patterns
Message-ID: <20261030023338.GGauQCAuYyXGwIhlqX@fat_crate.local>
References: <20261026-g2ul_sci-v3-0-b3097163edd5@bp.renesas.com>
 <20261027055750.GBauA9XlPykc1c1Xhv@fat_crate.local>
 <TY3PR01MB113468FBD8E5EFA65C4B4E5EB86602@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <072dd88c-4ca1-4c8a-98b1-7783bc43c1c5@kernel.org>
 <TY3PR01MB11346BAE55FF22F66E86A6F8B86602@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <afdf1864-4721-4177-bc18-2a5821d97559@kernel.org>
 <20261027205411.GAauEPc4AtLwvrDfFr@fat_crate.local>
 <7b0a2e98-c614-4cdd-8604-3b5b21e8474f@kernel.org>
 <20261028154743.GCauIZH3pZm24jCX9b@fat_crate.local>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261028154743.GCauIZH3pZm24jCX9b@fat_crate.local>

From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Thu, 29 Oct 2026 19:25:27 -0700

A K: is a content regex file pattern which matches any text in a patch
so if a commit message contains "TDx" as in

  the TDxE (Transmit Data Empty) flag

for example, see

  https://lore.kernel.org/r/20261026-g2ul_sci-v3-3-b3097163edd5@bp.renesas.com

get_maintainer.pl erroneously adds the x86 gang to the Cc list for what
obviously is a completely unrelated patch.

The same happens when someone uses it to check

  drivers/power/reset/tdx-ec-poweroff.c

patches.

So switch the x86 TDX patterns to files and directories (N:) type
patterns and group them by path, for less false positives.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20261027055750.GBauA9XlPykc1c1Xhv@fat_crate.local
---
 MAINTAINERS | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7a162e9bcab1..6aaeb7df83c8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -30347,8 +30347,11 @@ L:	linux-coco@lists.linux.dev
 L:	kvm@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/tdx
-N:	tdx
-K:	\b(tdx)
+N:	arch/x86/.*tdx
+N:	Documentation/.*tdx
+N:	drivers/virt/coco/.*tdx
+N:	include/uapi/linux/.*tdx
+N:	tools/testing/selftests/tdx
 
 X86 VDSO
 M:	Andy Lutomirski <luto@kernel.org>
-- 
2.53.0


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
