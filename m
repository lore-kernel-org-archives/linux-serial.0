Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB862D9EFB;
	Tue, 30 Dec 2025 02:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767060788; cv=none; b=uCddO2aysQTfOpnF9z0paoAioMj/pQwAYqMlIL/Ium9ylvlrUMLoiFdPJsqyuuPqYqaX+A/5erhkFc7mMLxYdcsJtGVCdKO96ruz4a30lu7eeVr9DiSZr3n2CV+P4Gb+uBRSwiIw0zsKtRvkXUgQwEdsizSvT2fVEL+KRbFYfUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767060788; c=relaxed/simple;
	bh=ujZ1P5lBfgwx4tIvimvvLGd3ecXpSBouVkmJT85mccE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ICAmFzChP8Gex6OMll/L/+zZ6Thl3JbB0ZX1FnzGT6U6SLBUZzT+eXoak0x4zGdj5AsRibEmmJCq4cnhqilygC3/SMovvxxUUdgNSQfavE5EIAC7Pi9gc7glcMY24ZWsOxQYdSPBOL+sU++FNJyMmjzEmRadPZQkSZ5ex5kHue4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tO5bdLtO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tO5bdLtO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8767CC4CEF7;
	Tue, 30 Dec 2025 02:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767060787;
	bh=ujZ1P5lBfgwx4tIvimvvLGd3ecXpSBouVkmJT85mccE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tO5bdLtO41d5F00M9eL2DiNwnBmycH8RX0eeY8cU9C018ar4bwq3t03A7MoZfZzUz
	 9FBHnO+00LiF1B+K7zKr/Oz9AOJk4J1orJWhkDCBCs4ikFjOPDWMYyVFseD4Hq0/1y
	 uH8a7PQsFR5ibtYPiQVz1zhYq27LxP8C7x5tjaJKQo80xY5c0owDKGqFxcxzAXhRRp
	 HMlUD/RzwJMZssgwuBo4y4+DyYLMrFAFcbEGVA7ZtL+BNZP5s2Sn1qVi5WwE+XiNJy
	 Jysl5qkbNDmh3ZSmjYd6t4gElEQTv9kPzZe/NkqZlAc1SN02Alkec98FX8b2vbQOgo
	 zcoI/C3d6MY9w==
Date: Mon, 29 Dec 2025 20:13:06 -0600
From: Rob Herring <robh@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: Guodong Xu <guodong@riscstar.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yixun Lan <dlan@gentoo.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
	Yangyu Chen <cyy@cyyself.name>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Conor Dooley <conor@kernel.org>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>,
	Andrew Jones <ajones@ventanamicro.com>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	spacemit@lists.linux.dev, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 11/13] dt-bindings: riscv: Add Supm extension
 description
Message-ID: <20251230021306.GA3094273-robh@kernel.org>
References: <20251222-k3-basic-dt-v2-0-3af3f3cd0f8a@riscstar.com>
 <20251222-k3-basic-dt-v2-11-3af3f3cd0f8a@riscstar.com>
 <fc719e92-10bc-455f-b402-c93bdbf878cf@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc719e92-10bc-455f-b402-c93bdbf878cf@riscstar.com>

On Fri, Dec 26, 2025 at 03:28:47PM -0600, Alex Elder wrote:
> On 12/22/25 7:04 AM, Guodong Xu wrote:
> > Add description for the Supm extension. Supm indicates support for pointer
> > masking in user mode. Supm is mandatory for RVA23S64.
> > 
> > The Supm extension is ratified in commit d70011dde6c2 ("Update to ratified
> > state") of riscv-j-extension.
> > 
> > Supm depends on either Smnpm or Ssnpm, so add a schema check to enforce
> > this dependency.
> 
> I have the same general question on this, about whether it's really
> necessary for the DT binding to enforce these requirements.  The
> RISC-V specifications are what truly defines their meaning, so I
> don't really see why the DT framework should need to enforce them.
> (That said, I'm sure there are other cases where DT enforces things
> it shouldn't have to.)

Does the specification have some way to check it? What happens if a DT 
is wrong? Are you going to require a DT update to make things right? Or 
the kernel has to work-around the error? Neither is great. So having 
this as a schema makes sense to prevent either scenario.

> 
> And now, having looked at these added binding definitions (in patches
> 07 through 11 in this series), I wonder what exactly is required for
> them to be accepted.  For the most part these seem to just be defining
> how the extensions specified for RISC-V are to be expressed in
> DT files.  It seems to be a fairly straightforward copy from the
> ratified specification(s) to the YAML format.
> 
> Who need to sign off on it?  Conor?  Paul?  DT maintainers?

I generally leave this extension mess to Conor.

Rob
