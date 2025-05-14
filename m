Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590C3201004;
	Wed, 14 May 2025 07:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747208314; cv=none; b=TC5aJaaMs6Y88g4HrUeZvp0n5InWBnbHqlLQwGXriCa0yzsHo54nguWIoNTqTZV6hcpUy5wUISCGg9RaMN/cusXfDEkgmZY9N5GNSaPERLlJ98BZrb6/yyM+t/hvuPvFcJd8fjX+GpASDGyUbmuFZBUChcVAoAuDi2Km1Gjwlf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747208314; c=relaxed/simple;
	bh=FAn473klWAnhnmlMdk63GTbxuuQb/yWgRlVVBKaV7Tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqkpKbswGVfo1e4u0uJaAVbu7eFREmmxd5ftwBM9JoS16YVFB2FjLCEzqBu5/svpw2xIirTeYS02kOb229iV+SxyovyFdqWlRO1x86JZgnvYWFJZ9DqkW5eVt3B5kadh4ummcgFQLqASIcyUfpBGnQ3kYXlMBQObfEQujCQomYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NNQc0Geq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NNQc0Geq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFADDC4CEE9;
	Wed, 14 May 2025 07:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747208313;
	bh=FAn473klWAnhnmlMdk63GTbxuuQb/yWgRlVVBKaV7Tw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NNQc0GeqAGdfUW9/KjWYCMCy9pKHow1UJ9WKSATh3epF6ltJ8U47GkbW4E3H6yar2
	 ln+VF+keJNXuyiBvab/PNbKWO9CQosIN2Te6mEgxe6ZUQSStVduesKzVprbAlu7vld
	 lhOUrqlkVyf/OZphw+rx4jrj9OC7ckmMnKAQ5Mk8=
Date: Wed, 14 May 2025 09:36:45 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Judith Mendez <jm@ti.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Bin Liu <b-liu@ti.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andrew Davis <afd@ti.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/7] serial: 8250: Add PRUSS UART driver
Message-ID: <2025051408-discolor-backwash-5574@gregkh>
References: <20250513215934.933807-1-jm@ti.com>
 <20250513215934.933807-4-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513215934.933807-4-jm@ti.com>

On Tue, May 13, 2025 at 04:59:30PM -0500, Judith Mendez wrote:
> From: Bin Liu <b-liu@ti.com>
> 
> This adds a new serial 8250 driver that supports the UART in PRUSS or
> PRU_ICSS*.
> 
> The UART sub-module is based on the industry standard TL16C550 UART
> controller, which has 16-bytes FIFO and supports 16x and 13x over
> samplings.

If it is based on an existing controller, why do we need a new driver
for this?  Please explain in detail why this code is needed at all, and
not just a new "quirk" for the existing driver?

thanks,

greg k-h
