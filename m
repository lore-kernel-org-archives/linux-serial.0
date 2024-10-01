Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9BB2AE66
	for <linux-serial@vger.kernel.org>; Tue,  1 Oct 2024 15:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727796686; cv=none; b=rRpF1+4ab6PbAJNVB0xgMDguH+oF4+jRe6uPF6ZHzKsB0qWIA8R4p/I6xkYLFtZisTlrqhpTB/bMj0ewjy29hAw3ygnVi63/tL7V6D/ET/VBO+X4gOLytXrLJSoOi/8ccwwScWgtwNXtejDPcixfuTgTtKka6FU8bfUTLD36iic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727796686; c=relaxed/simple;
	bh=JAFit4a9JHw6vw5PCQYOzUgxBXhAzWamEl3MWG7x3q0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=q6eYpzGZZL9BsiKgKv2jXz1z9yYkxKBwCuUEbA1RdhdD1KKo/CvGyeT3MtU8KAF1zxBIVDY1twnGpPdkugkXd3vvcGWgeJiIUZsmSvYE0s3AqiwerJ4EAv38PL/6zQ9xSx0QV4kITey8nQ3sII2hsDPv8cG5hMnhq80X1S55hoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ov++uYHn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ov++uYHn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AAD0C4CEC7;
	Tue,  1 Oct 2024 15:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727796686;
	bh=JAFit4a9JHw6vw5PCQYOzUgxBXhAzWamEl3MWG7x3q0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Ov++uYHnq8+JdrJS8yRD7KBtHHBFr3A2YaSMAQ6Jmt/IPgvbY/mEF8NQwIBksm7Y+
	 PvNMNpUk+dhio1SZoe6YerbflmEwXu4MZxAg1pQ90klfYSdLhat9l7jLaOIh/GkvGp
	 ct5YURqkzM1PH37jM3IQzBNifRzBfJUmF1j3WIFhd+P4jX8mEviFrowc0Y66AGneLD
	 PfjLdz6TeGjt93LpLgQXjYdbJP2qSX/wdkb84Z16SFOHdC4OJ/bnJIXL/RnDW+tOfx
	 lpyRr6BZ01pxRjyLKTVgEnDmEqfxi+M3UqFcQj/mYZwlcAxpfN56UyIV5d7fs+fwLb
	 dsm7xQDKcBXEg==
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2A6061200043;
	Tue,  1 Oct 2024 11:31:25 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Tue, 01 Oct 2024 11:31:25 -0400
X-ME-Sender: <xms:zRX8ZkFmkqmC89auh6N78ET0irhsgx4yaOCJihE0s7eBJ2YLh3zRzA>
    <xme:zRX8ZtULFqWupe-rgM4Kjk7GnlBwvZPZG_ca0cE3AMOiaiiQyFcn8yQVvVD_ts5mI
    Yt8hSLKp329bh6anz8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlh
    drohhrgheqnecuggftrfgrthhtvghrnhepudefjeetteelhfegudekhfetffehtefhtdev
    keehfefgtdehheeghfektdekvdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdduvdekhedujedtvdegqddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvghlrd
    horhhgsegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepjhhirhhishhlrggshieskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohephhgtrgeslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopehstghhnhgvlhhl
    vgeslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopehilhhpohdrjhgrrhhvihhnvg
    hnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepghhrvghgkhhhsehlihhn
    uhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepmhgrtghrohesohhrtggrmh
    drmhgvrdhukhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsvghrihgrlhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:zRX8ZuK_wK69nPcFt17hPNyHkcia4bjqMR7TWi99cfEjeGJyNOrrhw>
    <xmx:zRX8ZmErsrk546EfandA8147KrxanZz29TZRetZksAfHCAxB3W1iRg>
    <xmx:zRX8ZqVihXueKq681xNrPMggdHgW0_wYO4WoM7t9YjXrwk3cRAQ-xQ>
    <xmx:zRX8ZpPabfVrHYKBfalF2nQzGsXxGXS8EGmI5m-xdheAY93AqpjyVw>
    <xmx:zRX8Zh20R56ojEh4rwUmC1HXW_UD-fMrJV2wlxbtt_5llnuR_IgpT-63>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EB7DA2220071; Tue,  1 Oct 2024 11:31:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 01 Oct 2024 15:31:03 +0000
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Niklas Schnelle" <schnelle@linux.ibm.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Jiri Slaby" <jirislaby@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-serial@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>,
 linux-kernel@vger.kernel.org
Message-Id: <a009093c-06f6-4ea7-8e72-6ad84125262a@app.fastmail.com>
In-Reply-To: <ef2912910d006c573324bcf063cb76e843dc8267.camel@linux.ibm.com>
References: <20240405152924.252598-1-schnelle@linux.ibm.com>
 <20240405152924.252598-2-schnelle@linux.ibm.com>
 <alpine.DEB.2.21.2405230244140.1257@angie.orcam.me.uk>
 <ef2912910d006c573324bcf063cb76e843dc8267.camel@linux.ibm.com>
Subject: Re: [PATCH 1/1] tty: serial: handle HAS_IOPORT dependencies
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024, at 11:21, Niklas Schnelle wrote:
> On Thu, 2024-05-23 at 03:11 +0100, Maciej W. Rozycki wrote:
>
> With 2 more HAS_IOPORT patches having gone into v6.12-rc1 I'm looking
> at what's left and we're down to 4 prerequisite patches[0] before being
> able to compile-time disable inb()/outb()/=E2=80=A6. This one being by=
 far the
> largest of these. Looking at your suggestion it seems that to compile
> 8250_pci.c without HAS_IOPORT I'll have to add #ifdef CONFIG_HAS_IOPORT
> around the MOXI section as that uses I/O ports unconditionally. The
> rest seems fine and I guess would theoretically work on a system with
> !HAS_IOPORT. I'll send a v2 with that included.=20

I think that is the correct approach, yes. From what I can tell, the
older version of the 8250 patch added the #ifdef blocks for all other
port types that need port I/O, but the moxa version was added later
than that and just needs the same change.

      Arnd
