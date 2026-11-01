Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793511371;
	b=niVseSD9KvDNlNk5eogrtxQml2IJes+w8JNyb47OQ4lEZVg0ZojdoR1CbhA9tamTEdzE
	 ppwfIqQqLZBajLHhZyhxFYBkW1O1vaJFKhmJpGqScd39bfn5G2vZSkTNKycOxwKHooru1
	 dzTMUJupe9yzyJvvFXjNNRReuD97XGadIliq434eTNyqhqBLAc/H3Zv25oDEOz3pF4QFb
	 TjPdBFXIl0NtWXP8so4k4gSYeFzP6BNxdKnk6I8mxmfy+wCdjx5LbScL4F4Z1U6bryAh9
	 CPnTsxIN8sF/TV1e+jNOKdDZt1kawcy6mqqm09558NI7UVhAWxSuB0p9AUhT4JUkHgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793511371;
	h=DMARC-Filter:Received:Received:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:X-HE-Tag:
	 X-HE-Meta;
	bh=+pWCWfDAqIjrylvpr4u1LEX57uVzt1KlThKiOI2rJYI=;
	b=Hnv0Yep5JZAwl/8T29YCOPipOX9wkEFAke1EKpw+RyIjpCnRCGpTczu7V27KCaS9ipGA
	 juFsG2ur8jYiuxf+JUBU99WV5j0WiitjQVN0Ibmmw4pH0UtyBn5cNOckCQgb561Ds4Gte
	 Ylnvp4CE9OdXDtj2JrWzwr1XGfPIWDBUmVqur7Ziqj9wgyiInZ9PXMgRYCHYTeLJBQU/I
	 304qEfIirnBE6uC/1x977O1vEcWqJg7euMhFqLSoQZ/3hBIzQO3+vM4fwczO2BpA/4VtP
	 TloIh3l267CnnYMH1RURvmVFDSuDWdKlZGvlFMMe6Vvt9asVw5EvTHxoRQaphjKyzqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=perches.com;
	spf=pass smtp.mailfrom=perches.com;
	arc=none smtp.remote-ip=216.40.44.17
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8AF606A324;
	Sun,  1 Nov 2026 05:36:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED8AF606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf13.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 4D09AA8003;
	Sun,  1 Nov 2026 05:36:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf13.hostedemail.com (Postfix) with ESMTPA id B736420011;
	Sun,  1 Nov 2026 05:35:58 +0000 (UTC)
Message-ID: <b700f0fb96b9454287850f7aa54d876b709cadb0.camel@perches.com>
Subject: Re: [PATCH -v2] MAINTAINERS: Fix Intel TDX kernel file patterns
From: Joe Perches <joe@perches.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe	
 <rick.p.edgecombe@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
 Krzysztof Kozlowski	 <krzk@kernel.org>, Biju Das
 <biju.das.jz@bp.renesas.com>, "biju.das.au"	 <biju.das.au@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>,
 "linux-kernel@vger.kernel.org"	 <linux-kernel@vger.kernel.org>,
 "linux-serial@vger.kernel.org"	 <linux-serial@vger.kernel.org>,
 "linux-renesas-soc@vger.kernel.org"	 <linux-renesas-soc@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,  "linux-coco@lists.linux.dev"	
 <linux-coco@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
 Au Dang <au.dang.jx@renesas.com>
Date: Sat, 31 Oct 2026 22:35:57 -0700
In-Reply-To: <20261101014710.GEauaaHoYk5TzRpGBQ@fat_crate.local>
References: <20261027205411.GAauEPc4AtLwvrDfFr@fat_crate.local>
	 <7b0a2e98-c614-4cdd-8604-3b5b21e8474f@kernel.org>
	 <20261028154743.GCauIZH3pZm24jCX9b@fat_crate.local>
	 <20261030023338.GGauQCAuYyXGwIhlqX@fat_crate.local>
	 <20261031030112.GHauVZ-OI2KjdkjrcY@fat_crate.local>
	 <35ba539820e1782bde038df98d3b49295eb7cd3a.camel@perches.com>
	 <20261031202741.GAauZPPfNDpQLSmIZD@fat_crate.local>
	 <94f0ab99b5c9072ce7c026672f704b2987db427f.camel@perches.com>
	 <20261031235958.GDauaA_pScrsk2xYUF@fat_crate.local>
	 <5ad69a1167fddc7caf1eb73e439765116db1ce17.camel@perches.com>
	 <20261101014710.GEauaaHoYk5TzRpGBQ@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: B736420011
X-Stat-Signature: e73htcat4cfmq1bd9tqjwg4q4cxft3m6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19Rajxre7ooLNqKMlwzOUy+DZakmZXRay8=
X-HE-Tag: 1793511358-759391
X-HE-Meta: U2FsdGVkX18TMu8OWhRhoWPs8GNuf4n7s1uAz0w71THVvFlmi64sJ0RcrA4aAqt0aEKE/NzR+i5GBBGiQ3ltlZtdbgl+BRAyk8I2bJfgcLzJZ7vKZIpVOJRFiQ5Qekug2lhT6kcWltzi5UKl5wV8OevmPAacL1Aq0kXFzjQSPmVwXtyeUtWvWkWZo4yZ7+Ffum9/ABA+MVn+J1j7emWejLe5XbC5LYKlM9IAaozuh9wwg78uQVdvWyn2JHvOhiwzo22eN/qVO2UH9N1uRS7ZSUANOIzq9abnLdH/dOIr9wqB96kr3M2li7j6dPY8/P8R

On Sat, 2026-10-31 at 18:47 -0700, Borislav Petkov wrote:
> On Sat, Oct 31, 2026 at 05:38:46PM -0700, Joe Perches wrote:
> > On Sat, 2026-10-31 at 16:59 -0700, Borislav Petkov wrote:
> > > On Sat, Oct 31, 2026 at 03:52:50PM -0700, Joe Perches wrote:
> > > > Please add a wildcard * at the end
> > >=20
> > > I will, once the rationale is clear and documented so that people kno=
w what to
> > > do in the future.
> >=20
> > MAINTAINERS currently has:
> >=20
> > 	F: *Files* and directories wildcard patterns.
> > 	   A trailing slash includes all files and subdirectory files.
> > 	   F:	drivers/net/	all files in and below drivers/net
> > 	   F:	drivers/net/*	all files in drivers/net, but not below
> > 	   F:	*/net/*		all files in "any top level directory"/net
> > 	   F:	fs/**/*foo*.c	all *foo*.c files in any subdirectory of fs
>=20
> 	   F:  drivers/net/foo  everything under drivers/net/ which starts
> 	   with "foo"
>=20

No.  The intent is to match typical file matching patterns.

For instance:

This does not match anything

$ git ls-files -- 'Kcon'
$

but this does

$ git ls-files -- 'Kconfig'
Kconfig
$

and so does this

$ git ls-files -- 'Kconf*'
Kconfig
$
