Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02DD258EFB;
	Wed,  1 Oct 2025 14:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759329958; cv=none; b=QoyZACqbxHa/rBSmXOn0MPYUP5xDdm0pE6qlifi4+VLfOUR7SDxt44F75nvmRd8/pyPtDY2MkIvSXt35S2YXzkoE15PlrXOcvRotz3dIq8u3aiitfaFuZhl0/i2fNMySEcXewE3ApELGS+JPgaGIO/s2iWyToEKylDUwlM1r050=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759329958; c=relaxed/simple;
	bh=FGIIx4c5HQzcuPRSz7qxMUt6TC/KjLYO0XGFzcS/Yh8=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=hltF8UMhH7/6/sSOr/4NeCq2FfVVq5Xr50CCruMqGNkB0lEMPFxgxBpyCjimIwhYzJX3HYSrxd5mSDpouaTqK9XEXPM2Vz6E8xwREUFEQmZDIsA1c+kYgDICErxSgxMtbA392yuvnGn2Ij7foOWww7XrJ8iq2YFP3IOQWtu61vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=XZ5K3UHh; arc=none smtp.client-ip=91.198.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="XZ5K3UHh"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=8383b478a6=fe@dev.tdt.de>)
	id 1v3y5T-0016Hc-Qf; Wed, 01 Oct 2025 16:45:47 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fe@dev.tdt.de>)
	id 1v3y5S-00GF4k-RN; Wed, 01 Oct 2025 16:45:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1759329945;
	bh=U2vekvnUNVAKHRU2vk265JxBDAbZVo+RBzq+PxgeWwg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XZ5K3UHhip6bfZGiDLXBUODRKxB3VS9290iLhKzUzH7nS2WBoTEDNbV0pN4DKFOrf
	 m4AwDjg5B2ClaldZUKdFj4rLuHuUVP33CUHwOQcv3b5Tmi7VvpDD89jCHSM//oqB3T
	 8M/jGkhAv8qzcyH/U1Q4gRSn/sk7/Mhve1mkEzSCs1lLsrM0IkxeKrTbVwWR/5Lc7u
	 lu+82bkmYOtII1qnPz4vHIfCUccBl9amoVJn2EEdrxEamoZazwDi0Znvw5ahcxXZGg
	 OEv5eQ8MyREz9BdnGBI6RVxloo/EVdxGT+H6Xzz9wM2KtSKg8EUWKXeq5YAzCQpIZp
	 WpIKVNjDlenfQ==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 23E9E240042;
	Wed,  1 Oct 2025 16:45:45 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 12D1A240036;
	Wed,  1 Oct 2025 16:45:45 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id ADFF92696D;
	Wed,  1 Oct 2025 16:45:44 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Wed, 01 Oct 2025 16:45:44 +0200
From: Florian Eckert <fe@dev.tdt.de>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: gregkh@linuxfoundation.org, kumaravel.thiagarajan@microchip.com,
	andriy.shevchenko@linux.intel.com, pnewman@connecttech.com,
	angelogioacchino.delregno@collabora.com, peterz@infradead.org,
	yujiaoliang@vivo.com, arnd@kernel.org, cang1@live.co.uk,
	macro@orcam.me.uk, schnelle@linux.ibm.com,
	Eckert.Florian@googlemail.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v2] serial: 8250_pcilib: Replace deprecated PCI functions
In-Reply-To: <f6fe95e5-0dd3-4ce0-b741-06cacf283e4c@kernel.org>
References: <20250930072743.791580-1-fe@dev.tdt.de>
 <f6fe95e5-0dd3-4ce0-b741-06cacf283e4c@kernel.org>
Message-ID: <e19fa21955115f4621b47b170c3a2193@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
Content-Transfer-Encoding: quoted-printable
X-purgate-ID: 151534::1759329947-CA4F1A68-C7DE0F1C/0/0
X-purgate: clean
X-purgate-type: clean



On 2025-09-30 09:34, Jiri Slaby wrote:
> On 30. 09. 25, 9:27, Florian Eckert wrote:
>> When the '8250_exar' module is loaded into the kernel, a kernel trace
>> with 'WARN_ON(legacy_iomap_table[bar])' is dumped to the console,
>> because the old pci table mapping is still used in '8250_pcilib'.
>>=20
>> The old function have been deprecated in commit e354bb84a4c1 ("PCI:
>> Deprecate pcim_iomap_table(), pcim_iomap_regions_request_all()").
>>=20
>> The remapping already takes or must take place in the driver that=20
>> calls
>> the function 'serial8250_pci_setup_port()'. The remapping should only=20
>> be
>> called once via 'pcim_iomap()'. Therefore the remapping moved to the
>> caller of 'serial8250_pci_setup_port()'.
>>=20
>> To replace the outdated/legacy iomap_table processing in '8250_pcilib'=
=20
>> the
>> function signature of 'serial8250_pci_setup_port()' has been extended=20
>> with
>> an already iomapped address value. So this can be used directly=20
>> without
>> io mapping again.
>>=20
>> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
>> ---
>>=20
>> v2:
>> * The function 'pcim_iomap()' returns a NULL pointer in the event of=20
>> an
>>    error, so error handling has been adjusted.
>=20
> LGTM now.
>=20
> Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

Thanks for the review tag. Will this be included in linux next?
Or do I need to do something? I also think that this should be=20
backportet
to the latest LTS kernel =E2=80=9C6.12.*=E2=80=9D. This is where I notice=
d the problem.

--

Florian
