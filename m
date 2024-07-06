Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730433B295;
	Sat,  6 Jul 2024 08:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720253160; cv=none; b=BTcsAegn2LQrTyUQjQETaHxvQ6lMKvkD9eS9uK4H4QaKpP2YzBijfHAGyGWjbmovgioveSpaFo7jRxPmohF2bt0kMAzAG5PyA7hQ7bTYNmMuAefLJGT5OSKmwulDJMZ8ZaV0d3AFY2uAugCSm23i3loJrdOglvfqO7MvB47zAg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720253160; c=relaxed/simple;
	bh=yRgXLaKmUsIdQHY1Q3h67uj2rWQ7+iou6MCLsSzPh+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I4HU8kLyjS7YMmCdesuOsrL+kE9d9IFcY/Yeuhs6qV1/IFLf5G5e0RYwuTScZfvcHNE8typrrcBHS1yW8zLv1tHgOnKt5mwttEnQdFDT20fI6mtuvdWsmYVwotQg8dZBfAOIK7G6+OTP7Zi1alTQOCvh4FxB97rucf++vfYwEJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AYqjoKCn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AYqjoKCn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F843C2BD10;
	Sat,  6 Jul 2024 08:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720253160;
	bh=yRgXLaKmUsIdQHY1Q3h67uj2rWQ7+iou6MCLsSzPh+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AYqjoKCndsh1dPwy3fITjkAEFgvhA7Ic4mR0JIulCUlq4GOTlrguxNfg5X74DucdV
	 Fb642usa+0w+oLSKjhfSEDuVuZrarWOY4zS7tNcbk8sXJi4boGMQWHq4duu5as14ry
	 j82qJ1S+t9aUtA9+Tb2Wm4Siy1C9laN76TNwM+Ig=
Date: Sat, 6 Jul 2024 10:05:56 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?utf-8?B?5byg54yb?= <zhangmeng.kevin@spacemit.com>
Cc: Yixun Lan <dlan@gentoo.org>, Jisheng Zhang <jszhang@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Conor Dooley <conor@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>, Jiri Slaby <jirislaby@kernel.org>,
	Lubomir Rintel <lkundrak@v3.sk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yangyu Chen <cyy@cyyself.name>,
	Conor Dooley <conor.dooley@microchip.com>,
	Inochi Amaoto <inochiama@outlook.com>, linux-serial@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 06/11] dt-bindings: serial: 8250: Add SpacemiT K1 uart
 compatible
Message-ID: <2024070645-trapper-shucking-acdb@gregkh>
References: <20240703-k1-01-basic-dt-v3-0-12f73b47461e@gentoo.org>
 <20240703-k1-01-basic-dt-v3-6-12f73b47461e@gentoo.org>
 <ZoarsYMNJRu1-_wn@xhacker>
 <20240705064721.GB3042186@ofsar>
 <21b192b47649688e2400e3968e28905bba186d51.42926de8.32d7.41ea.b98f.6e2edb5e6c5a@feishu.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <21b192b47649688e2400e3968e28905bba186d51.42926de8.32d7.41ea.b98f.6e2edb5e6c5a@feishu.cn>

On Sat, Jul 06, 2024 at 04:02:57PM +0800, 张猛 wrote:
> This message and any attachment are confidential and may be privileged or otherwise protected from disclosure. If you are not an intended recipient of this message, please delete it and any attachment from your system and notify the sender immediately by reply e-mail. Unintended recipients should not use, copy, disclose or take any action based on this message or any information contained in this message. Emails cannot be guaranteed to be secure or error free as they can be intercepted, amended, lost or destroyed, and you should take full responsibility for security checking. 

Now deleted.
