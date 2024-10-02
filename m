Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0CF1CF284;
	Wed,  2 Oct 2024 14:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727879489; cv=none; b=dRuPtQzn8I8GvKGNEe9Y3Eq0/GOxaE7xM/Pv+gQjnxIIlR3O3yRwXF4QmJiVAs0xrmdwtc5boGiv2NUBaCauMshFd0PCpdEACOqtPKKb0YjwwJ/gV35C382kNA9XivWPgt6E6svITCQWf7mX0XcJFjxdOEdjbH8xikOcG143MZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727879489; c=relaxed/simple;
	bh=yCC4dLGpbROdzpDQZAYq3NCy9m74iSPz3+T4zHW1EBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iv9Dvzg2XMStyW1O+msFSx86hqk5TjSApcyTkjZTID7FeDKoSDaexWfO18RWn1vcp1+eoGU5XAiiWw/+qrrdKgMvd34944PoF8CUhR/xCfJS/u+P3uH8llJMfV8MZ5KeRm22VRQWC4x63lTJ/lajgLX5RVcXTCA2bonMCu3rehs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hNl8aCri; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hNl8aCri"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727879488; x=1759415488;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yCC4dLGpbROdzpDQZAYq3NCy9m74iSPz3+T4zHW1EBI=;
  b=hNl8aCriqyFmmAFN+hj6wQEpkQPjybKhxcs6yC5kZJ6qvteIe0kCzeZQ
   61IBsBkXImdsGT7Snf87508r0hY7+aiw0rD8d4Bxm+G0W3duXrEty+wrG
   73hl5Zkiuw17oLXZ90EMVG8DdLactxNomjmYsqOh9/o9AdW8JFATcN1OD
   4J15H41ytUdMfbdyS5P5ioBc583KwELhFsqqJSfSWcj7SFWpx7jvWzuTD
   uLAqFMeLBXnhU1WVD9861vXrT1bC8MzB1G7ryfVp0rX/yJ4oKFHGQnI/i
   uEhCTHAKjA6ajLg4KzbYRACXMzytpjM56vA15o4BRzAVM4G4/AEPkdwQo
   Q==;
X-CSE-ConnectionGUID: YZzKenYURE6mrK0OlHKYUA==
X-CSE-MsgGUID: iioTe6DrTbSKRHjMqFLYvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="26844656"
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="26844656"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 07:31:28 -0700
X-CSE-ConnectionGUID: 4T6V+lvfQMelSeJnkAvndA==
X-CSE-MsgGUID: FAboQsA/SQmdeedKCmt6dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="78033260"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.154])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 07:31:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sw0Nv-0000000FhdH-0ijP;
	Wed, 02 Oct 2024 17:31:23 +0300
Date: Wed, 2 Oct 2024 17:31:22 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <parker@finest.io>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v3 0/5] serial: 8250_exar: Replace custom EEPROM code
 with eeprom_93cx6
Message-ID: <Zv1ZOs1u1S8B6szs@smile.fi.intel.com>
References: <cover.1727873292.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727873292.git.pnewman@connecttech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Oct 02, 2024 at 10:14:06AM -0400, Parker Newman wrote:
> From: Parker Newman <pnewman@connecttech.com>
> 
> This series of patches replaces the custom 93cx6 EEPROM read functions in
> the 8250_exar driver with the eeprom_93cx6 driver. This removes duplicate code
> and improves code readability.
> 
> In order to use the eeprom_93cx6 driver a quirk needed to be added to add an
> extra clock cycle before reading from the EEPROM. This is similar to the
> quirk in the eeprom_93xx46 driver.

Everything is fine except one minor (in patch 1) and one more serious
(see patches 3 & 4) issue. I just commented on them. Fix and send a final
v4, my tags are already there and you may keep them.

Thank you!

-- 
With Best Regards,
Andy Shevchenko


