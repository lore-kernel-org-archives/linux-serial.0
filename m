Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCC13CF21D;
	Thu, 30 Jul 2026 10:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785408863; cv=none; b=oRVOHgsqXBBY56dXZelsaRvst+5tXo2uFkyon3csviaDWDQ1U1LQ70vFMF+Xf5NljChMLzt7UcxY8sjUuvBVSrvsIGoaW3A9asB5hki8O/1G8i4z1IfWams+A6Ss2cIX84EEEjhKeRmldTqpV3jr6wbs+zDL89xTWqa55iBzLTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785408863; c=relaxed/simple;
	bh=7M7PxMrXz7rT6NNf7IZDmgGIJ3G2vQ9gjAASGaKTFQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FTNayPK0ilL4Ja11RUSFPt9jtJOXFLderBU0mEdQXOqSL3rg6k8mIIFSP/GwzU1oFkFfwDCL7DqfbUm3n5jPHlKiuK1RyApo5GAIwAGVbHtN7M4ZnzzzfN4yiiLXbEF4PWY+66LErp1AF5u6dwwdPlzafcmoiVT+OHSnr1L2PDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tQfBE4L1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tQfBE4L1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996821F000E9;
	Thu, 30 Jul 2026 10:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785408861;
	bh=7M7PxMrXz7rT6NNf7IZDmgGIJ3G2vQ9gjAASGaKTFQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=tQfBE4L10h6MxfMM7dbUNHYdeMUOlox3f1ty4z6drfCujVpu99b8/RH5N3Pr1ZSpv
	 kZacoqZI7o+LMPTd8I+zp4CJzsb8WoFKdIKrHi5P/SKuI2CMSVejX6jwrq1ZF9+eMT
	 Qc+FaKpnfmTGJ73dKgcbtvVazuxtw3W7Tfqk/EPQ=
Date: Thu, 30 Jul 2026 12:54:07 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Long Zhao <longzhao@ambarella.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>, linux-gpio@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/10] serial: ambarella: add Ambarella UART driver
Message-ID: <2026073055-ibuprofen-fading-ed86@gregkh>
References: <20260730104330.81367-1-longzhao@ambarella.com>
 <20260730104330.81367-9-longzhao@ambarella.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730104330.81367-9-longzhao@ambarella.com>

On Thu, Jul 30, 2026 at 06:43:28PM +0800, Long Zhao wrote:
> NOTE: This email (including attachments) contain Ambarella Proprietary and/or Confidential Information and is intended solely for the use of the individual(s) to whom it is addressed. Any unauthorized review, use, disclosure, distribute, copy, or print is prohibited. If you are not an intended recipient, please contact the sender by reply email and destroy all copies of the original message. Thank you.

Now deleted.
