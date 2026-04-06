Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDD933263B;
	Mon,  6 Apr 2026 12:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775478912; cv=none; b=I3pwjebWf6f//AL9mwO+RPBVKVeVaXb5EvFJuxm3oArrg0oIThoNjgTig8vKD7CJ/VRvK8htfBITVV/xy7EKdaxlHQmoY9uVoBjykSjDVj3FDSUvTRd80dh7A8DiEMga6qwlqPXzhcDv037wZMab1bN3bCMu6bvQSU37/qtNX94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775478912; c=relaxed/simple;
	bh=vo/6lo+iAkG6UawG71EzFRxbyPgiOp0wfB7hhPyA8g0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NhHSijcH3z2UuyqCTdmJN+KRcCFnayNJNQzWOsKeR2PRlRKsKxIE679o1rE+sVTsymCo+V4C8DqBzxe4I7AfExMQmMqKFMOA3rwLPzZJsWG06YXEaNlQRgiaADePGWczF825gOeIk1ZRujuSbKBEG/54EZ8MfF+Kco5h3Cuz0qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1w9jAQ-00040t-00; Mon, 06 Apr 2026 14:34:58 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 6973EC0DC9; Mon,  6 Apr 2026 14:32:19 +0200 (CEST)
Date: Mon, 6 Apr 2026 14:32:19 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Rong Zhang <rongrong@oss.cipunited.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-mips@vger.kernel.org,
	devicetree@vger.kernel.org, Yao Zi <me@ziyao.cc>,
	Icenowy Zheng <uwu@icenowy.me>, Rong Zhang <i@rong.moe>
Subject: Re: [PATCH v2] MIPS: dts: loongson64g-package: Switch to Loongson
 UART driver
Message-ID: <adOn00g-uE3-vRXS@alpha.franken.de>
References: <20260315184401.413975-1-rongrong@oss.cipunited.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260315184401.413975-1-rongrong@oss.cipunited.com>

On Mon, Mar 16, 2026 at 02:44:00AM +0800, Rong Zhang wrote:
> Loongson64g is Loongson 3A4000, whose UART controller is compatible with
> Loongson 2K1500, which is NS16550A-compatible with an additional
> fractional frequency divisor register.
> 
> Update the compatible strings to reflect this, so that 3A4000 can
> benefit from the fractional frequency divisor provided by loongson-uart.
> This is required on some devices, otherwise their UART can't work at
> some high baud rates, e.g., 115200.
> 
> Tested on Loongson-LS3A4000-7A1000-NUC-SE with a 25MHz UART clock.
> Without fractional frequency divisor, the actual baud rate was 111607
> (25MHz / 16 / 14, measured value: 111545) and some USB-to-UART
> converters couldn't work with it at all. With fractional frequency
> divisor, the measured baud rate becomes 115207, which is quite accurate.
> 
> Signed-off-by: Rong Zhang <rongrong@oss.cipunited.com>
> ---
> This patch targets the MIPS tree.
> 
> The series for the serial tree to update dt-bindings and enable building
> 8250_loongson (loongson-uart) on MIPS Loongson64 is sent separately, as
> it's independant of this patch and can be applied in any order (the
> compatible strings here still contain "ns16550a", so no regression will
> be introduced).
> 
> Changes in v2:
> - Separated from v1 (patch 3): https://lore.kernel.org/r/20260314234143.651298-1-rongrong@oss.cipunited.com/
> (thanks Krzysztof Kozlowski)
> ---
>  arch/mips/boot/dts/loongson/loongson64g-package.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

applied to mips-next

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
