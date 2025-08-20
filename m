Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293891B3925
	for <linux-serial@vger.kernel.org>; Wed, 20 Aug 2025 06:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755669619; cv=none; b=hCcEQirqIuH6uK7DsMKwkn1LO0QFx5ye9onLBfJ9e8M3t4/0EagA3zwevqszCQRUeb9D+AHKY4HA02obhbN0VMl+jiDHU32mQ20w2SUvnz3wAR2ETNGl0AgPIXE5GYlMK07oqeKyrbqt5al0540iqio+3JXNXHG1mW30AGfgrk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755669619; c=relaxed/simple;
	bh=sgWFxSDCHgEqBkePeKxi8tjahuCCir9c1Kr+yHuo0/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwBcs597k+4r2e8CwUWf2MmxA/MUFb8Mlfqnf/kNf8vpHWYWhjIo8psWByat9oKBfuWq7faEYXwQ+dfmvZB3CdyltZkugHJ053lPYgBmBSlqRwGu+TAzHqFmDXgl6R3tg6RQiUwD2gck/kcUyF8k1o/6MSc2ID+xs4E88+GimpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hxANGoCw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hxANGoCw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16AC4C4CEEB;
	Wed, 20 Aug 2025 06:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755669618;
	bh=sgWFxSDCHgEqBkePeKxi8tjahuCCir9c1Kr+yHuo0/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hxANGoCwVHdXiXfIfAEKMW2LtwryGQC02XQ6ueJs049XGsrHGmYVDM728drPn0t/M
	 sMkkQLiUvhUusH8yAaziWRkk3MgkhQIU6JnzFhAAyS6JuXjsfS/ykg14ncdMKp9r5V
	 2X6nvvSJc9WHIomQNQwp8a3XKfkAoisCTEZSofeY=
Date: Wed, 20 Aug 2025 08:00:15 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: adriana@arista.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.rg,
	ilpo.jarvinnen@lininux.intel.com, andriy.shevchenko@linux.intel.com,
	jirislaby@kernel.org, john.ogness@linutronix.de
Subject: Re: [PATCH v2] serial: 8250 dw: clear FIFO before writting LCR
Message-ID: <2025082055-daytime-lubricant-c017@gregkh>
References: <20250819190621.3452231-1-adriana@arista.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819190621.3452231-1-adriana@arista.com>

On Tue, Aug 19, 2025 at 12:06:21PM -0700, adriana@arista.com wrote:
> This patch is proposing a custom configuration for Synopsys DesignWare
> serial to be used by products with associated compatible string in the
> device tree.

<snip>

you sent 2 v2 patches?  Which one is which?

confused,

greg k-h
