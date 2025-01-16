Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D55418E76B;
	Thu, 16 Jan 2025 09:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737018170; cv=none; b=iAJXEqXx1lyEgkNnNw07tGuUDQDuuHwtVfHQeocdZKj5s2hTB1hgH8dAKdD4VAW11OmHLCE8fjv4dYjAV+DqnC+gmaAglxk6wp9LqLCJpD5kPb7uqP+S2PM6k6a8TsevZA+NkvoSFkEj7zfvVJXjUDNFyn29QO3VfVt0Fi4ViVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737018170; c=relaxed/simple;
	bh=x2Tfbon9CkXAGMmsSzaE5yGA3x3BeRVKHzCJ7IG5gm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PLNJvNoiY8AfwuGn+A37+pBE5VUmDYgTIdImnK7BYMVsbsmJnMBL7gtwK/d6emgfxexkDaJi8ulY38ZtiH1zpfArUqzET7Gu6dY+1D+utc5FkdhPem5CqHoYTTTaNUrzxmaoHY8eBzQmpMp+OAL3STKwWl3S/QifzPiqYyPh2JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: yeheCvfGQweIQZlId2P0eA==
X-CSE-MsgGUID: /J8Eppp2TBmUXcGieiyyNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="48787211"
X-IronPort-AV: E=Sophos;i="6.13,208,1732608000"; 
   d="scan'208";a="48787211"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 01:02:48 -0800
X-CSE-ConnectionGUID: CsJC3/MaQqqbb31nAkBMWw==
X-CSE-MsgGUID: mww+9wXcQi+Shbbu8zOyPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110515908"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.154])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 01:02:46 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1tYLlz-00000001bSI-1aRc;
	Thu, 16 Jan 2025 11:02:43 +0200
Date: Thu, 16 Jan 2025 11:02:43 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Andre Werner <andre.werner@systec-electronic.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
	hvilleneuve@dimonoff.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	lech.perczak@camlingroup.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, robh@kernel.org
Subject: Re: [PATCH v7] serial: sc16is7xx: Add polling mode if no IRQ pin is
 available
Message-ID: <Z4jLM-EQPOXWj2Xx@smile.fi.intel.com>
References: <CAHp75Vc==m3mE1TtxjHnpwL-d8W4rFnKreu7XB7MWspJKCCOGA@mail.gmail.com>
 <20250116083447.453615-1-andre.werner@systec-electronic.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116083447.453615-1-andre.werner@systec-electronic.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Jan 16, 2025 at 09:34:47AM +0100, Andre Werner wrote:
> Fall back to polling mode if no interrupt is configured because there
> is no possibility to connect the interrupt pin.
> 
> If no interrupt pin is available the driver uses a delayed worker to
> poll the state of interrupt status registers (IIR).

The commit message should be changed to reflect the code.
I.e. "Fix the IRQ check to treat the negative values as No IRQ."

> Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>

> Link: https://lore.kernel.org/r/20250110073104.1029633-2-andre.werner@systec-electronic.com

This should not be here.

> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

It's not signed by Greg.

> V7:
> - Try to improve and unify comments as requested.
> - Fix typo in commit message: pull -> poll

Version should be 1 and Subject has to be changed accordingly.

...

> -	s->polling = !!irq;
> +	s->polling = (irq <= 0);

This is the only line has to be changed in the patch.

-- 
With Best Regards,
Andy Shevchenko


