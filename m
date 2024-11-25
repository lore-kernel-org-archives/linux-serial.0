Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E3618C039
	for <linux-serial@vger.kernel.org>; Mon, 25 Nov 2024 10:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732531555; cv=none; b=aFdhoWbflkerQzTy2TP6MphFzzvWRYdyTBE3KOr6LZ1mwE2BZCQN8Qi6BdESDsRelNJIRTp70rreXTarYr/gOgy5rtfPHTCrKm7CleDtWoX6lP9woJSf2qzWgtRqFPh+81s/vk0bT58/+ENBu7GSV5kAs0TmeUoyMuUz/OppPyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732531555; c=relaxed/simple;
	bh=H8jHzL6ei/EwpDcgwLpkQaZt1HF6WA/zA21C1UeDIrw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=L0T3kgvmvEzu5Nq1svoP+6PN0iWtAMnWE8Xbl8VbfzMuNjGEUqHNnRtN0cHBlAET4M2jU5GDpr0xbxUEGep5l5ZHYUA+PsduijjQ5KHc9DZmFurVQUm4wiN23t9ytfMCv3ee3nujEbahElgZVXZXIW9wopxThMlE5ySOrZjlZGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhI5mueL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhI5mueL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C348C4CED7;
	Mon, 25 Nov 2024 10:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732531554;
	bh=H8jHzL6ei/EwpDcgwLpkQaZt1HF6WA/zA21C1UeDIrw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=XhI5mueLphW6ef0yguyAWCJqNEzy+DHC719shUyyleLxq2eLOVurIMK8+VRJg1yze
	 9gRDQRS7zEavLBH0t0QK+6euiYuFZZnpRf3oJldPI/gchwPvJbqGq/nazEdN9u+g1b
	 0Y8jHCOtF48NiTqceAMoN4vmM3QIPBg4vFJ6SwId56S6L6N2I5rWh19hBZwF/ceyzU
	 YgO1QNw6WKCjy97Szv0HLZr/FdBECp/MjW2aI+83yk66YEZ0dfpKTO+Mv8xcQfrWtb
	 vOmX+w7I3C6LsVBjQxppV91Kr6D6LTwtfsWiRRkT3+G18wghD0jPpphhE0uGa5wUxx
	 HJKoorEmviNkQ==
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5BF4D1200076;
	Mon, 25 Nov 2024 05:45:53 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Mon, 25 Nov 2024 05:45:53 -0500
X-ME-Sender: <xms:YVVEZ7CHpFNXYSOcsG7fX98L3WYaI8R8JyAKPAPD-py5VjxRprw2yA>
    <xme:YVVEZxgCLG0fDcetyNw7MYWY_9HGJmFPILzyNaZNWnMVvNopPLq8gdXfYiy6ogBH9
    -3qwtZu-sZYCF9XlMo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeehgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugeskhgvrhhnvghlrd
    horhhgqeenucggtffrrghtthgvrhhnpeejjeffteetfeetkeeijedugeeuvdfgfeefiedt
    udeikeeggeefkefhudfhlefhveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihht
    hidquddvkeehudejtddvgedqvdekjedttddvieegqdgrrhhnugeppehkvghrnhgvlhdroh
    hrghesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehjihhrihhslhgrsgihsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtohhm
    pdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpd
    hrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqshgvrhhirghlsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:YVVEZ2nMHrtwzfhxHwDvebsx1Oro10v7We4QGWyIhduwTFaNNGJT0Q>
    <xmx:YVVEZ9zKchtTDvsdYuhQXVCLCQjQAQG7z4bsFwPZRF3_3FZZpUruzg>
    <xmx:YVVEZwTMNdkpUNRY_CFlGSXMUujImEWzvbvRvDO9JEyyw-7z7CbOsA>
    <xmx:YVVEZwYSyt274-1HwJfj0jAPd-TI3hZOzDetQDz65ioBbM_0EmQcvQ>
    <xmx:YVVEZxSiYD_EjdL2-SQeTKyTCXeVT5Tqd-OU_DmJkiQxR27o5f_iQ6Au>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 338B02220071; Mon, 25 Nov 2024 05:45:53 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 25 Nov 2024 11:45:32 +0100
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: "Jiri Slaby" <jirislaby@kernel.org>
Message-Id: <ce88e017-9c2a-4963-a64c-9893e12cf6ea@app.fastmail.com>
In-Reply-To: <20241125103305.1614986-1-andriy.shevchenko@linux.intel.com>
References: <20241125103305.1614986-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] serial: 8250_port: Assign UPIO_UNKNOWN instead of its
 direct value
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Nov 25, 2024, at 11:33, Andy Shevchenko wrote:
> serial8250_init_port() assings 0xFF for the unset or unknown port
> IO type, use predefined constant for that instead.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

I already thought about sending the same thing, but was going
to wait until we have found a solution to the
!CONFIG_HAS_IOPORT warning.

      Arnd
