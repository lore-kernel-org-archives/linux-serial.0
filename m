Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84F4323D;
	Fri, 13 Sep 2024 05:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726207071; cv=none; b=NHjuLX8rzLgbs1+TH6yVxhBUnMzs96JNd6QnUnFbYyylWShPwht0SzsOvXQJRuWyINZsMsmIeMN1H2gzhAzdLkBhkXksN/6rv6ZrrbH/J6FPNbRZGvHFJ06x0jmcxDR3fY63WP4lfqAhE74hNTZDAA+KqpeAUMvft1kBYEp5UGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726207071; c=relaxed/simple;
	bh=i2oHzhi3OjrA/yeKLYHkzWF/t73q/CvWLnOx7mHRCPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5y9lufb0mqkSAgoYQRCEQdRSE2feepOphbIAxXSQTax1qVfH3A1ySDXKSImlZv6+ZptiVwewmczLHb67zaN9VNNBoajEKUoSJBjTGq8eFUNlxginyMhAuCI0tchGlM7JXwq9h958tGOhrGay8NbnyYz1UdPM+X2Gu4RC9YGlQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RPpDGyt1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RPpDGyt1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59D9C4CEC0;
	Fri, 13 Sep 2024 05:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726207071;
	bh=i2oHzhi3OjrA/yeKLYHkzWF/t73q/CvWLnOx7mHRCPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RPpDGyt1hAmEtLoJ6yK1ErU81O1+IVwAixICc6f+hXmByIY2e4zkTfGNczGCNgwXd
	 KUgtHwpUL264b+Iv0sqk+mEcCTTTLfZ7F294eCUzrL3ErdEFAJzkv+9wpu3AJh/H7X
	 LMACN7E1MJCwimOhdldylTaOqLdVe2HlpY2z/Tcg=
Date: Fri, 13 Sep 2024 07:57:48 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Raul E Rangel <rrangel@chromium.org>
Cc: linux-serial@vger.kernel.org, pmladek@suse.com,
	rafael.j.wysocki@intel.com, ribalda@chromium.org,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] earlycon: Print a notice when uartclk is unknown
Message-ID: <2024091340-tacky-everybody-b582@gregkh>
References: <20240912173901.3969597-1-rrangel@chromium.org>
 <20240912113616.2.Id2235082fc6c2d238789dfc3ee923492e9ed7387@changeid>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912113616.2.Id2235082fc6c2d238789dfc3ee923492e9ed7387@changeid>

On Thu, Sep 12, 2024 at 11:36:20AM -0600, Raul E Rangel wrote:
> When trying to construct an earlycon=uart parameter it's hard to debug
> why it's not working.  In my specific case it was because the default
> uartclk earlycon assumes doesn't match my hardware. This change adds a
> notice so that the user is made aware of that this assumption is being
> made. This should hopefully lead to them adding a <uartclk> option to
> their earlycon parameter.
> 
> Booting with `console=uart,mmio32,0xfedc9000,115200n8`:
> [    0.000000] earlycon: uart: Unknown uartclk, assuming 1843200hz
> [    0.000000] earlycon: uart0 at MMIO32 0x00000000fedc9000 (options '115200n8')
> 
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
