Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0A912D758;
	Tue,  4 Jun 2024 13:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717508289; cv=none; b=iyH8ZcRoWMz7YG3JSXhSOZsE+sCCqAmj3C4qCSgVYLDKlwxmjF0b4KTy6u4wyrbfv55L5ITXo7zL0I3oJ+Ns8wTSKVBzpSCSyLjZF+HRdzOeZqMMzoqIvscDdDwhvtJjuLQJSZtIwotmdu7zQx43o/2nauHvrBlJX5RfRHRp790=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717508289; c=relaxed/simple;
	bh=JfeTGJMQpqcsxQBaDNL1F3/rL+Anrp+a1VVtX1Gy+90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkgfsAnNm5ePhcCXc1hBRcHy+uCcFtH+ZjmX9r6vRDhpIMGu1rXmOItiN+S7LMH6AmKolN7eMXDehQfzDhgP9F97UzuTCa0Y/pNuAkaIRJ0cOAYm6/D5pHyCKhOOOslQV8359gSZge9RZNF6U1rUokiO4EYVAayb5m5gQSUkyjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: BNez4u6rQW2Vpe0FdQjAZA==
X-CSE-MsgGUID: dFUMgQCRSwqd7HSe5+03Iw==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="14183280"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="14183280"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 06:38:00 -0700
X-CSE-ConnectionGUID: aaVLdAfJTT24DWCDfnUHuQ==
X-CSE-MsgGUID: 2cwOv7nkSraLTuQSgbm+Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="37114429"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 06:37:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1sEUMN-0000000DZNE-0q7d;
	Tue, 04 Jun 2024 16:37:55 +0300
Date: Tue, 4 Jun 2024 16:37:54 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Hui Wang <hui.wang@canonical.com>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org, jirislaby@kernel.org,
	hvilleneuve@dimonoff.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, lech.perczak@camlingroup.com
Subject: Re: [PATCH v2 1/2] dt-bindings: serial: sc16is7xx: add reset-gpios
Message-ID: <Zl8Ysrvj4L-QL3N6@smile.fi.intel.com>
References: <20240604132726.1272475-1-hui.wang@canonical.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604132726.1272475-1-hui.wang@canonical.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Jun 04, 2024 at 09:27:25PM +0800, Hui Wang wrote:
> In some designs, the chip reset pin is connected to a gpio, this

GPIO

> gpio needs to be set correctly before probing the driver, so adding

GPIO

> a reset-gpios in the device tree.


-- 
With Best Regards,
Andy Shevchenko


