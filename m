Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089C134BA33;
	Tue,  7 Oct 2025 14:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759848444; cv=none; b=ph+IIJT+wFxTdjrwer8x2KfDctsKWGVRLD7U+ekIG3b3kWJHtU73M9bGeC9yaC4UE/zBIhUTwX94Y5CQXfZvPlcMaJ1JKKs4cV8GTfUs7R/bT4+VIzO7pZ5FdryzYYtpRx7f1iPofjZkNoAX3cPBF3Mgs4/L0gkEzOQyEl8vNM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759848444; c=relaxed/simple;
	bh=BTshImO9RSXmLBx3sRsRx9Q+sqSjawsY+o2lV+Q6H5A=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=H+4ixFsGLyzAo08ovYgUWUfY+g3mdqJn23am8Ie8tH+P+XVc7SCOTH+TdQQbJFCzfJDhUxClC+VTXVtFkpSbaEMBwRpHldcmj1D9h5A7tN6KJRegZ3awtiv7iLlyXmxSEreCiur4BtJgyuuGXeDTRwCikB36o1oHeeNDh7PK+Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=h9GKzN3c; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="h9GKzN3c"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=938914964c=fe@dev.tdt.de>)
	id 1v68ib-00DM6t-0c; Tue, 07 Oct 2025 16:31:09 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fe@dev.tdt.de>)
	id 1v68ia-007JL0-73; Tue, 07 Oct 2025 16:31:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1759847466;
	bh=oW77RXF3W4SOXWtaWVYPDu4ztShz5Sl9IZGjbt6gGKc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h9GKzN3cPKPVLbtKdJVVUEM14Cdn3NtK/QWJCkhTAijBEaAuCT2QU6Q2P8a0fDWhe
	 CYB3H/l995l6ro1P/ee7XL2psGaL7sqKtgE0dbws7MMymvLKUw3upYEEs/xxKrc1QT
	 HxeeE6+QLGQPv53ezcRER3DtHjaJ96mFypg7APBAkYKSywF6eMVlu6OcV0ekue/rDN
	 OSOspzEOM7UWW9WN7GACGzuwXpLewB5VJqbqkVwHc0pD3WC7y0ILlpWcdhPObwsIqb
	 X9etGKHEJxYvSRtFdhWLYwWb/lYaw25Sp16uKqxxI1D4fh4Oo7mBxodrwDA1FIl2kA
	 Q7DkPwHejjNow==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 85549240042;
	Tue,  7 Oct 2025 16:31:06 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 6B069240036;
	Tue,  7 Oct 2025 16:31:06 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id 0817126B85;
	Tue,  7 Oct 2025 16:31:03 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Tue, 07 Oct 2025 16:31:02 +0200
From: Florian Eckert <fe@dev.tdt.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, kumaravel.thiagarajan@microchip.com,
	andriy.shevchenko@linux.intel.com, pnewman@connecttech.com,
	angelogioacchino.delregno@collabora.com, peterz@infradead.org,
	yujiaoliang@vivo.com, arnd@kernel.org, cang1@live.co.uk,
	macro@orcam.me.uk, schnelle@linux.ibm.com,
	Eckert.Florian@googlemail.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v2] serial: 8250_pcilib: Replace deprecated PCI functions
In-Reply-To: <2025100248-chunk-diaper-91e2@gregkh>
References: <20250930072743.791580-1-fe@dev.tdt.de>
 <f6fe95e5-0dd3-4ce0-b741-06cacf283e4c@kernel.org>
 <e19fa21955115f4621b47b170c3a2193@dev.tdt.de>
 <2025100248-chunk-diaper-91e2@gregkh>
Message-ID: <31850b0e4c7a0c60ade42ae8ee9b32f5@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
Content-Transfer-Encoding: quoted-printable
X-purgate-type: clean
X-purgate-ID: 151534::1759847468-9C930735-E0152090/0/0
X-purgate: clean



On 2025-10-02 07:25, Greg KH wrote:
> On Wed, Oct 01, 2025 at 04:45:44PM +0200, Florian Eckert wrote:
>>=20
>>=20
>> On 2025-09-30 09:34, Jiri Slaby wrote:
>> > On 30. 09. 25, 9:27, Florian Eckert wrote:
>> > > When the '8250_exar' module is loaded into the kernel, a kernel tr=
ace
>> > > with 'WARN_ON(legacy_iomap_table[bar])' is dumped to the console,
>> > > because the old pci table mapping is still used in '8250_pcilib'.
>> > >
>> > > The old function have been deprecated in commit e354bb84a4c1 ("PCI=
:
>> > > Deprecate pcim_iomap_table(), pcim_iomap_regions_request_all()").
>> > >
>> > > The remapping already takes or must take place in the driver that
>> > > calls
>> > > the function 'serial8250_pci_setup_port()'. The remapping should
>> > > only be
>> > > called once via 'pcim_iomap()'. Therefore the remapping moved to t=
he
>> > > caller of 'serial8250_pci_setup_port()'.
>> > >
>> > > To replace the outdated/legacy iomap_table processing in
>> > > '8250_pcilib' the
>> > > function signature of 'serial8250_pci_setup_port()' has been
>> > > extended with
>> > > an already iomapped address value. So this can be used directly
>> > > without
>> > > io mapping again.
>> > >
>> > > Signed-off-by: Florian Eckert <fe@dev.tdt.de>
>> > > ---
>> > >
>> > > v2:
>> > > * The function 'pcim_iomap()' returns a NULL pointer in the event =
of
>> > > an
>> > >    error, so error handling has been adjusted.
>> >
>> > LGTM now.
>> >
>> > Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
>>=20
>> Thanks for the review tag. Will this be included in linux next?
>> Or do I need to do something? I also think that this should be=20
>> backportet
>> to the latest LTS kernel =E2=80=9C6.12.*=E2=80=9D. This is where I not=
iced the=20
>> problem.
>=20
> The merge window is currently happening, I can't add any changes to my
> tree until after that closes in 1 1/2 weeks.  And if you need/want it
> backported to stable kernels, can you provide a "Fixes:" tag and a cc:
> stable tag as well?

Thanks for the info. I'll wait until the change has been applied to your
master branch. After that I will send a backport patch for LTS 6.12.

Thanks

--
Florian
