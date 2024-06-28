Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C7E43AC0;
	Fri, 28 Jun 2024 08:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719564283; cv=none; b=ZsFjhWSA42zVCqfX6OX8tV3x3IDz3O7DCFamLTj7pXUrS1p7krCq0JRsmB8ywXcnodrOJ/sb/tQ8SlPfo3FptMgQNh/jFn9k7b9Pvp0utKFHAPLLFODilglf+goDuuJwRyoR5bQA+XULZ9PmJglmmvoVyjNKK25D2QDLgFj+4M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719564283; c=relaxed/simple;
	bh=rjY3yb4wtSMvrFArcSzxrYzmsyqAuKcfTtVos4HkRYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=En2E3pClvmrTPf0oJgm5paEC0C+i07nWTQiVpc6UFnahUPAkq8UA2isamvUviactPl1VqwM6zPGKNr24SsCRPoeeQBhNMropvSKiilask5aBCCxpp2/Q16HK1YZTXLasQqagaERgnvS6/0VmzpM042Kz/wVe7Qlt6UCVbEGdNyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Date: Fri, 28 Jun 2024 08:44:34 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Conor Dooley <conor@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@sifive.com>, linux-riscv@lists.infradead.org,
	linux-serial@vger.kernel.org, Inochi Amaoto <inochiama@outlook.com>,
	Meng Zhang <zhangmeng.kevin@spacemit.com>,
	Yangyu Chen <cyy@cyyself.name>
Subject: Re: [PATCH v2 03/10] dt-bindings: riscv: add SpacemiT K1 bindings
Message-ID: <20240628084434.GA1752165@ofsar>
References: <20240627-k1-01-basic-dt-v2-0-cc06c7555f07@gentoo.org>
 <20240627-k1-01-basic-dt-v2-3-cc06c7555f07@gentoo.org>
 <eb05af3d-85b8-4068-961e-20f2f7d7d0c2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb05af3d-85b8-4068-961e-20f2f7d7d0c2@kernel.org>

On 09:34 Fri 28 Jun     , Krzysztof Kozlowski wrote:
> On 27/06/2024 17:31, Yixun Lan wrote:
> > From: Yangyu Chen <cyy@cyyself.name>
> > 
> > Add DT binding documentation for the SpacemiT K1 Soc[1] and the Banana
> > Pi BPi-F3 board[2] which used it.
> > 
> > [1] https://www.spacemit.com/en/spacemit-key-stone-2/
> > [2] https://docs.banana-pi.org/en/BPI-F3/BananaPi_BPI-F3
> 
> You got a bug reported by tool and you send the same version again,
> producing the same bug.
> 
> In case it is not clear:
> 
> *You cannot ignore* bug reports, comments, reviewer requests or any
> other reply to your patchset. Each one must be addressed one way or another.
> 
sorry, it's my fault, I rushed to send out this series.
and yes, I should really go back and check all the thread..

I will fix all the issues in next version (tags, dt error..)

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55
