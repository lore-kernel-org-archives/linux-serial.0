Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AD7289811;
	Tue, 22 Jul 2025 11:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753184853; cv=pass; b=HEuPl7P2h/9qN6tZFuKfSrpwaGP3SScKJ+Cn5QZwcWhN65O6JSHw/LTEkJbATzpz2TRS+WGLO00S/NmGzBnJdDjURi1B5cKtpKHpeDUWmhNoBGzWzGk1Ft2mLXnCWz/SwJvIgtOqWAm5U1cZ0Qchs1f3DuPwHJmuSONUXTDImPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753184853; c=relaxed/simple;
	bh=xpegnxQs3ZbtY7JbpoeqaEx7Okr5XdmawkN2WmtMZnQ=;
	h=MIME-Version:From:To:In-Reply-To:Cc:Subject:Message-ID:Date:
	 Content-Type; b=Y6sovS6F9bXHFKKU/CZGX4vtxJFVi5ZH/NsE2U5l0waPPXxmstylCRx77KnLXf7UhqgGjgOviGnpPfY2LMGa3MDyDD6SnFmblV/Ezb9HfG9G0jxF2eM34mo3itEqLOXw7Al4qeY9bwZMq1njDcUWXojn1RrAMYj4kYNhSkwG3sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=NgCQTdb/; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="NgCQTdb/"
ARC-Seal: i=1; a=rsa-sha256; t=1753184822; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DdBCLaeCsAfj/AcN99FfwGfHj8oCOHBcr24JxgrFvH7b49ZdsHVI7xw74RCbY++5eysOePiGQzNZCU5huPjEw0UBIunOaO42tf8col8GXE/ScGkF3pOFEY8jjTY3g4bKgJa0fYN1NYUnwiqTca7rwa7I8DxXUH4yS5Hg7WRmBtw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753184822; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=iLoaiwS+Ud2yCbXeC9zL0Mtugd211TCM6YPAiCXDkGs=; 
	b=WcNS2HjKW4KJIauGA/uu5xDWgUkHF7q+I84+DA22Stjr9UjuOQVA71A2EhiOo/L39QzJIP9ENcimPH1cLvWLs81irpd6HIBPdUspriV/OIS9Ei96uNC6lxoZ0IPSrkpSKTWANywBJ8j97nTVL4IpUgJD5BjeAc0AUEtsXcpwRbw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753184822;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=MIME-Version:From:From:To:To:In-Reply-To:Cc:Cc:Subject:Subject:Message-ID:Date:Date:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=iLoaiwS+Ud2yCbXeC9zL0Mtugd211TCM6YPAiCXDkGs=;
	b=NgCQTdb/5h4sQYxngtfLCx56kgvIKBKfK43c0olNs8WqxaXrbI1RINvaX/npx/G4
	kTsXKPscdSZUbIexWIJMWZaEwxmmM/1KHXfONk6/RKO0ZsNOM+304c0jH36hUA7Xkgo
	qEBCSyt7r8DMh9gKInrUkIJdRPFzNZB3W28xJVqE=
Received: by mx.zohomail.com with SMTPS id 1753184818692439.0197627599191;
	Tue, 22 Jul 2025 04:46:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Junhui Liu" <junhui.liu@pigmoral.tech>
To: "Krzysztof Kozlowski" <krzk@kernel.org>
In-Reply-To: <20250722-proud-polar-mink-12caa8@kuoka>
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
Subject: Re: [PATCH RFC 09/10] riscv: dts: anlogic: Add Milianke MLKPAI FS01
	 board
Message-ID: <1854904c2bf8d2d8.e7cd4abd4f21761b.29b7782965d4456e@Jude-Air.local>
Date: Tue, 22 Jul 2025 11:46:51 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External



On 22/07/2025 09:31, Krzysztof Kozlowski wrote:
> On Mon, Jul 21, 2025 at 11:46:15PM +0800, Junhui Liu wrote:
>> Add support for the Milianke MLKPAI FS01 board based on the Anlogic
>> DR1V90 SoC. The board features 512MB of onboard memory, with the region
>> after 0x1fe00000 reserved for OpenSBI.
>>=20
>> Currently, the board can boot to a console via UART1, which is connected
>> to the onboard serial chip and routed to the Type-C interface.
>>=20
>> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
>> ---
>>  arch/riscv/boot/dts/Makefile                       |  1 +
>>  arch/riscv/boot/dts/anlogic/Makefile               |  2 ++
>>  arch/riscv/boot/dts/anlogic/dr1v90-mlkpai-fs01.dts | 28 ++++++++++++++++=
++++++
>>  3 files changed, 31 insertions(+)
>=20
> You need maintainers entry for your entire sub-arch. Otherwise why would
> we want unmaintained code?

Thanks for your reminder, I will add the relevant information to the
MAINTAINERS file.

>=20
> Best regards,
> Krzysztof

--=20
Best regards,
Junhui Liu

