Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2A930100;
	Tue, 22 Jul 2025 11:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753183693; cv=pass; b=sRSst3wN240U5lh7fzqlaqg4/dT5MBdxvrb/V29Oby1CAFmSKHheHUfGFlHpW/fFM4Rt8cgxpkJQgmqqT+6MSCNYiVW4M4MJnwWnLKzgtfizkg022mAPdoM+s8V37tftmu0c8oReHpxTlAk5sbq5fW3ZlEYKXvoaA6LcSZs74lQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753183693; c=relaxed/simple;
	bh=ikD0rMcKmRVjoAxqulFqg/X3a6tVlFz2ZfIGnWg5/Bk=;
	h=MIME-Version:From:To:In-Reply-To:Cc:Subject:Message-ID:Date:
	 Content-Type; b=gRcPJ2LqJ+9gAY/kYQDSwGhMkpM9cPLmyE96dRUeSa7l0WVz0GJOSEidkomQgzf8Hiebnxbg/Qt0fQl7Vyac+ynOKO7iKMK2DC0/ZXzz/HIcewfZypKWpzjvWxoFVF6zzVMerb5/akQCIM0lLhiVvMgZlavCnwGWbj8zQn4e+2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=KuAvm1U7; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="KuAvm1U7"
ARC-Seal: i=1; a=rsa-sha256; t=1753183646; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=L8uXSYQxwzi6GnqOKA5+M/zFPG4YsKprlvaiueZ6tyTNaDL5JdRi7F4krtqMduJ4Ag69Rg7U4KPh8r5llGt06szaffvPBwsjPG0Le/CnRbR41qo1u8JBxhK3xiCfh25Qe6QdZrzckGLUiHvZWTJDa2Lh7TQZOFLxLKr6lu3WOQs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753183646; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=oSWzK9+1+wJc6wh6CDIQZWQCvimKKJe8O5m5BgUOpHM=; 
	b=jrZKYr4L4LdOFAuzndQZW5Qz+Lz1wmRU490h2L4eC6Dm7C9X8bR490PUz42rHs55ViumCFNLmb3iufzWwCweDrl45bjqjmsw4JatKBu9sJKx0MY8pNkHVBJRTExu6uVWhYFPEH83ifRRTLuzU0+RPMY/hB1j8jI6sOUcSLnwtLA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753183646;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=MIME-Version:From:From:To:To:In-Reply-To:Cc:Cc:Subject:Subject:Message-ID:Date:Date:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=oSWzK9+1+wJc6wh6CDIQZWQCvimKKJe8O5m5BgUOpHM=;
	b=KuAvm1U7/rkniCfUxMjB0BR6KZ2ypIXEi2EuO2iqtr7dyL10XVPnZaVwSM6o14Sj
	38SyFAnkKq7IVnSYBHIVmUJx0CNsrmkcDmyn4geRQiBGTO5bg4Vz8byXslcL198w104
	zbn14B6zSUpYB83NsJcFigm/jWU7OkcYb3JkyYwg=
Received: by mx.zohomail.com with SMTPS id 1753183643006882.6847732993253;
	Tue, 22 Jul 2025 04:27:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Junhui Liu" <junhui.liu@pigmoral.tech>
To: "Krzysztof Kozlowski" <krzk@kernel.org>
In-Reply-To: <20250722-berserk-octopus-of-destiny-f4475e@kuoka>
Cc: "Rob Herring" <robh@kernel.org>, 
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, 
	"Conor Dooley" <conor+dt@kernel.org>, 
	"Paul Walmsley" <paul.walmsley@sifive.com>, 
	"Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>, 
	"Alexandre Ghiti" <alex@ghiti.fr>, 
	"Daniel Lezcano" <daniel.lezcano@linaro.org>, 
	"Thomas Gleixner" <tglx@linutronix.de>, 
	"Samuel Holland" <samuel.holland@sifive.com>, 
	"Anup Patel" <anup@brainfault.org>, 
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, 
	"Jiri Slaby" <jirislaby@kernel.org>, <devicetree@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, "Palmer Dabbelt" <palmer@sifive.com>, 
	"Conor Dooley" <conor@kernel.org>, <linux-riscv@lists.infradead.org>, 
	<linux-serial@vger.kernel.org>
Subject: Re: [PATCH RFC 07/10] riscv: Add Anlogic SoC famly Kconfig support
Message-ID: <18548f39bd190d28.fca9acf422f7bf67.f37c65074e24e08a@Jude-Air.local>
Date: Tue, 22 Jul 2025 11:27:13 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External



On 22/07/2025 09:29, Krzysztof Kozlowski wrote:
> On Mon, Jul 21, 2025 at 11:46:13PM +0800, Junhui Liu wrote:
>> The first SoC in the Anlogic series is DR1V90, which contains a RISC-V
>> core from Nuclei.
>>=20
>> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
>> ---
>>  arch/riscv/Kconfig.socs | 5 +++++
>>  1 file changed, 5 insertions(+)
>>=20
>> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
>> index a9c3d2f6debca1469f4a912b3414711eb709baab..de163cdddcda1c08e7c9e9871=
6eaf043d4c4555a 100644
>> --- a/arch/riscv/Kconfig.socs
>> +++ b/arch/riscv/Kconfig.socs
>> @@ -1,5 +1,10 @@
>>  menu "SoC selection"
>> =20
>> +config ARCH_ANLOGIC
>> +	bool "Anlogic SoCs"
>> +	help
>> +		This enables support for Anlogic SoC platform hardware.
>=20
> Wrong indentation. See everything else in this file or just read coding
> style.

Thanks for pointing this out. I overlooked it and will fix it in the
next version.

>=20
> Best regards,
> Krzysztof

--=20
Best regards,
Junhui Liu

