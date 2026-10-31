Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793415700;
	b=wG9RMDjU2OB91OvC5A2ZYEOfXLSGsuaJoZt3HZNWnsxXlHyRsaHZboiqZkksD+IS1mOg
	 cCRbi+wbfA2g5Av7eWStFl1MgaFJ1/pSfhPrS92xpBv95KhSO9NaElTdXuJwKrYGr1LIp
	 S5oYb5NRZV6tMdf8+yVegzpnWLnvxTsstJIqQXqwWQd4RwZNkafKH9s08g+5oqtoPexD8
	 Y2vA9libQM4A2IY95zO8j1apLpe5GL4cER8CiP6WcqVJRusKm4wwzzOXJrVu9Fnz3S5g9
	 uHQKIRe02vGt97T1LzY6BiN52BmSlWLA5lrPM5znEIvLV+thXrcJ83+BgZg9P8fOwkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793415700;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=0pyAsH8gwqtQqNNm/v8qLvT0oMadqvUmRdeyHoWxCkk=;
	b=rue+L+nwHac/TZfcWJ8T44f1/mOvR6pT4x+6vg0o/o1KlRzOdLs0xhcbRO5akz2tp9GX
	 nqVOZKSX5XC3dNJ0TuLsyH4yQWa66p6oVjsSMuEnIzP1t47VlP2c66DvbcD7PC9uNwSdr
	 mHDqzE1/muhHDHey+xeuFMrSrPqO0u1MO5M0c7HIujCXxdYcFX5YAaetA7jiOyWrSRIRA
	 GAaV6oXiRpEaDgySKntq098H3VVbyC8bcAB97UG1/vHjMRHKKHk8Z+d+fdVMD1Agi2znC
	 JUojHNEtKc+MtBgitlMGT70F12Qo6UWO1Oulihe0/db65zwa6eOnV2dEQRdvXpIjWdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=ARo0k0t6;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B91606A31D;
	Sat, 31 Oct 2026 03:01:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9B91606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=ARo0k0t6
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6E73A40E03BE;
	Sat, 31 Oct 2026 03:01:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id VAOU-mxyKRtE; Sat, 31 Oct 2026 03:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1793415692; bh=0pyAsH8gwqtQqNNm/v8qLvT0oMadqvUmRdeyHoWxCkk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ARo0k0t63aHztXyih1D0V4Z2TxlBKaR+J5do/x/gYMHI8FJ9q9fi8OmK1HMDBS7jg
	 TeYJFKvUD4lGZ3wHHrzeu94rpgtEiCB3a+HyHpF5EaqActVQ2hrRbVuXCurwtkKRjR
	 PBivNrv1Z4N8nSptEDL++HJXRpxkogeZotdKAVPMC5pfyCvhe+iFMvmX7t+27oUG7M
	 dQR5+pOvBZC7CR1z58DT2TlRnYeeJiDwA8oRi9wsYbg0YENxgYHuJZw9w+hMdV2rig
	 wuF6RY6B5M+HZoyjae8efvTAsDdR2qMWua5jr/666ru7IsE1BB9YKZCnsYpdFwsMp0
	 BhJCtzZn4DiDOaSE8K5203liu4WT6zds/kMVbaiB0cwD7ROSoNpi60TLjCaKy2bxuM
	 /qzLPMGDf/O1AbeF9nACfcA7MRPW5tqfvuCQWgx879iw3+hboObXn7vRkon9W8pqI6
	 LnAm2xrppa/b2+MeDRGpPxyfPN12rFH26zOTMM7DOAQmJoK7REkR3HvbewTeQkeweZ
	 6sIertfd5jYuFhIKFm48spvMpmd31YqFaKDqJlvksul4Suy8lhai7Cjp6aT8iKrojz
	 Z3OJWfM0hKcOT3PuQosu/3F73ThYEcyEXcC1x5I66IFIGBHX8mqv53CNPsZlESL7z/
	 lw/SrvWoh2iAxU2PgcnswTxs=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 21C9F40E016C;
	Sat, 31 Oct 2026 03:01:15 +0000 (UTC)
Date: Fri, 30 Oct 2026 20:01:12 -0700
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
Subject: [PATCH -v2] MAINTAINERS: Fix Intel TDX kernel file patterns
Message-ID: <20261031030112.GHauVZ-OI2KjdkjrcY@fat_crate.local>
References: <20261026-g2ul_sci-v3-0-b3097163edd5@bp.renesas.com>
 <20261027055750.GBauA9XlPykc1c1Xhv@fat_crate.local>
 <TY3PR01MB113468FBD8E5EFA65C4B4E5EB86602@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <072dd88c-4ca1-4c8a-98b1-7783bc43c1c5@kernel.org>
 <TY3PR01MB11346BAE55FF22F66E86A6F8B86602@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <afdf1864-4721-4177-bc18-2a5821d97559@kernel.org>
 <20261027205411.GAauEPc4AtLwvrDfFr@fat_crate.local>
 <7b0a2e98-c614-4cdd-8604-3b5b21e8474f@kernel.org>
 <20261028154743.GCauIZH3pZm24jCX9b@fat_crate.local>
 <20261030023338.GGauQCAuYyXGwIhlqX@fat_crate.local>
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
In-Reply-To: <20261030023338.GGauQCAuYyXGwIhlqX@fat_crate.local>

From: "Borislav Petkov (AMD)" <bp@alien8.de>

A K: is a content regex file pattern which matches any text in a patch
so if a commit message contains "tdx" as in

  has_tdxe_auto_clear

for example, see

  https://lore.kernel.org/r/20261026-g2ul_sci-v3-3-b3097163edd5@bp.renesas.com

get_maintainer.pl erroneously adds the x86 gang to the Cc list for what
obviously is a completely unrelated patch.

The same happens when someone uses it to check

  drivers/power/reset/tdx-ec-poweroff.c

patches.

So switch the x86 TDX patterns to files and directories (F:) wildcard
type patterns and group them by path, for less false positives.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20261027055750.GBauA9XlPykc1c1Xhv@fat_crate.local
---
 MAINTAINERS | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7a162e9bcab1..015cf66afb96 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -30347,8 +30347,11 @@ L:	linux-coco@lists.linux.dev
 L:	kvm@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/tdx
-N:	tdx
-K:	\b(tdx)
+F:	arch/x86/**/*tdx*
+F:	Documentation/**/*tdx*
+F:	drivers/virt/coco/tdx*/
+F:	include/uapi/linux/tdx
+F:	tools/testing/selftests/tdx/
 
 X86 VDSO
 M:	Andy Lutomirski <luto@kernel.org>
-- 
2.53.0


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
