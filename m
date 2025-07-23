Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F3B5D8F0;
	Wed, 23 Jul 2025 02:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753238283; cv=pass; b=Vq/+66hEeKhv00HX1aUDvUHcdHvy120KKhgyXatSiV1CCjadYlQYEjwop0JukRqYk4zXAbaa4oegbfUiK44CWA5UltqwPyaUyX0gtYPp9RyPFz/TDJvEchOy5gE25A24P2Zs+LSe0NuCtMG38ZAWec1BVi7gJFVCnpifhhLWEVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753238283; c=relaxed/simple;
	bh=XCoc9+wLkq3sUU/NFjhuG75tzrVltF1sgbtPeA06ffs=;
	h=MIME-Version:From:To:In-Reply-To:Cc:Subject:Message-ID:Date:
	 Content-Type; b=NwWoCvtKtKUP57hb6Sv4I+3mAIw8VE1yeg5X4ljnQC/EmVFHSFowBnk1yXFN8AYkhIcGER2yoL28Uqy+U/FL8+v5d2yyJygafNkc2MwVDjhgw2vVSW5kHG51uZ8VT0XMvjBB93VRoHRqfNzrTv+DD8ojg0d6FkquXV96dhxYJZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=LJSC674v; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="LJSC674v"
ARC-Seal: i=1; a=rsa-sha256; t=1753238256; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nXNlbIJ2gBelqjEBEVD2ZZqHhYpHfqLNhyRL02/HrWePPrbBVzn9UFlpWLLQQqMgFkVOHgI7EPs11uxDJT2hAD3HxsnglyiqNvXHhO2Rh1o7CKVO9e2P7f9kJ1aPsC003SbwyrEkydGjlmMb2sEMdR1SO8Aw2Ums9FF/CqIAILk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753238256; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jHHlBhF2vPEqFOO6kTk6KJpYRHF8+DAv7zaVRV3Y9Vc=; 
	b=iYfXamsvsiKsG75/ndrpRp1zxp5gBp37UyESssCCFbcHYBxAjRGCXTX3cWLDK5FMl7iYfEkAFwVZK+Gj5fuwxDKK5QTNuuNCMtui3MilTN6mzPrwa+B8CnTNZPVvv/xCFFTIiBlE0+DDcDIlzSaUif03wrRLmEkOIqh9XXl4ITM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753238256;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=MIME-Version:From:From:To:To:In-Reply-To:Cc:Cc:Subject:Subject:Message-ID:Date:Date:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=jHHlBhF2vPEqFOO6kTk6KJpYRHF8+DAv7zaVRV3Y9Vc=;
	b=LJSC674veqzVU7kyyZ0gi5lDSLjcElD+OaUS/4BfyPH46K1FfJodeapXXZVhFXCB
	/r+z4lqTFUSDMeeukCcmEEap8Jat18rKa/sj9mu4ads9dqs4MAiMFDBWQISGKzfATUh
	KpX2Qb0Aeeg5RvkQkDXIBaNMggYP33lbFLTSYZpc=
Received: by mx.zohomail.com with SMTPS id 175323825315690.31617852682825;
	Tue, 22 Jul 2025 19:37:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Junhui Liu" <junhui.liu@pigmoral.tech>
To: "Conor Dooley" <conor@kernel.org>
In-Reply-To: <20250722-proposal-gothic-e0c3725e0874@spud>
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
	<linux-riscv@lists.infradead.org>, <linux-serial@vger.kernel.org>
Subject: Re: [PATCH RFC 08/10] riscv: dts: Add initial Anlogic DR1V90 SoC device
	 tree
Message-ID: <1854c0e4c92fe7d0.4d402317a33bdba0.106dbab4984c351f@Jude-Air.local>
Date: Wed, 23 Jul 2025 02:37:23 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External



On 22/07/2025 16:21, Conor Dooley wrote:
> On Mon, Jul 21, 2025 at 11:46:14PM +0800, Junhui Liu wrote:
>> +	cpus {
>> +		#address-cells =3D <1>;
>> +		#size-cells =3D <0>;
>> +		timebase-frequency =3D <800000000>;
>> +
>> +		cpu@0 {
>> +			compatible =3D "nuclei,ux900", "riscv";
>> +			device_type =3D "cpu";
>> +			reg =3D <0>;
>> +			riscv,isa =3D "rv64imafdc";
>> +			riscv,isa-base =3D "rv64i";
>> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zba", "zbb", =
"zbc",
>> +					       "zbkc", "zbs", "zicntr", "zicsr", "zifencei",
>> +					       "zihintpause", "zihpm";
>=20
> Why do riscv,isa and riscv,isa-extensions differ?
> If riscv,isa is not even accurate, why not just remove it entirely?

You're right, they should be the same. I will remove "riscv,isa" and
keep only "riscv,isa-base" and "riscv,isa-extensions".
Thanks for pointing it out, I will fix this in the next version.

>=20
>> +			i-cache-block-size =3D <64>;
>> +			i-cache-size =3D <32768>;
>> +			i-cache-sets =3D <256>;
>> +			d-cache-block-size =3D <64>;
>> +			d-cache-size =3D <32768>;
>> +			d-cache-sets =3D <256>;
>> +			mmu-type =3D "riscv,sv39";
>> +
>> +			cpu0_intc: interrupt-controller {
>> +				compatible =3D "riscv,cpu-intc";
>> +				interrupt-controller;
>> +				#interrupt-cells =3D <1>;
>> +			};
>> +		};
>> +	};

--=20
Best regards,
Junhui Liu

