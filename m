Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661061AAE1E;
	Thu, 16 Jan 2025 09:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737018204; cv=none; b=Bl1tdxc/n1zL+1Sl8xbVzdF1rKFpOEyVWWGACqyezbD5hmjkTQvzN4YXF+fO2Od4J8DTiF8cXd4+hm8QKD5skaI9ZWn0DdcodMVOdbcjU8KJFpPLY9dbHMdGqnQMvlIzddVRCcagxfHJt+hhskHH8BLqJGj5QQURse+czVVNyGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737018204; c=relaxed/simple;
	bh=IxiSUTEiqx9xW0czLLEyA2qUM2TlVCerz+ACKCB5PeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G8yyqO7QEt00jbLeVrzKv4fnE6jj4BovlTJbHOT1oQHGq4bx+2qsKDHcGyJNsc1C1ok+106su1xm7iRQ5XflDEXyk3VjevODtSpqL3/TMIKsJ3aQVUrwpGqyueAZ6LQXsHbSHl6NuMRYxd8ytFkjWrewFjwSddIDs41nGFzuBqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: a5+KjFCuQDerE1GkqF9Z5A==
X-CSE-MsgGUID: T7mER6xXQzSbGBiyh3icrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="62764467"
X-IronPort-AV: E=Sophos;i="6.13,208,1732608000"; 
   d="scan'208";a="62764467"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 01:03:21 -0800
X-CSE-ConnectionGUID: aUv64c4YTbSB9+Zd3zZU1w==
X-CSE-MsgGUID: Pk6m2RPEQYyMH6B/XcJpug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110054325"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.154])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 01:03:18 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1tYLmV-00000001bSy-1AGa;
	Thu, 16 Jan 2025 11:03:15 +0200
Date: Thu, 16 Jan 2025 11:03:15 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Andre Werner <andre.werner@systec-electronic.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
	hvilleneuve@dimonoff.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	lech.perczak@camlingroup.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, robh@kernel.org
Subject: Re: [PATCH v7] serial: sc16is7xx: Add polling mode if no IRQ pin is
 available
Message-ID: <Z4jLU75SU53VGsRU@smile.fi.intel.com>
References: <CAHp75Vc==m3mE1TtxjHnpwL-d8W4rFnKreu7XB7MWspJKCCOGA@mail.gmail.com>
 <20250116083447.453615-1-andre.werner@systec-electronic.com>
 <58638faa-ddc2-bc64-5467-d62ea6a222cd@systec-electronic.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58638faa-ddc2-bc64-5467-d62ea6a222cd@systec-electronic.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Jan 16, 2025 at 09:42:27AM +0100, Andre Werner wrote:
> Dear Andy,
> 
> I hope this is what you expected and is what I have understood so far.

Nope. Please, find my replies there.

> I performed the rebase to
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> branch. This is a commit that has been created due to the rebase. The
> commit message title is the same as from the previous commit already in
> linux-next and the commit message body differs, because there was a typo
> in the message and the description was still including the "interrupts"
> property from dt to use to select polling mode that is not directly used
> anymore in the latest version of the patch.
> 
> Sorry if I still did something wrong, but this is what I thought I had
> to do.

-- 
With Best Regards,
Andy Shevchenko


