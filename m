Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4340D187343
	for <linux-serial@vger.kernel.org>; Mon, 12 Aug 2024 17:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723482545; cv=none; b=KqXAsTnF0buev1M9ssIN9u+DrxQF4nJqEW4esQkg2PAy7YBWFBSGnbEI9dBFuELC4vuMvw41Fjm96QGBFHSlO6kDQyAzPwrCexwrHKtOzwHAeXlMKmet1uOy6O2Tc5f8jMaT1TQoueHqXLxhvfc20KPxRoajT08fToFwUKqtj68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723482545; c=relaxed/simple;
	bh=5eFe9VwQ2ggmB+zA/IdJe0la1ZsOzur33CKlMWiZxNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OvavmA8SJR1R0KDbaDUiHIo14cRxkaDyF55SlqyM15BzBpxU56ACKAm14iTni6CRt+ZJ+tUuR8WE26kWZQqkE56f/zpIHhQf8PKATQHcmh7IESoAqtPysPzirDbJMVsVBDLmuJHEYY35RBCOvnZ8ykU81Iw/A9tDCxKU9S17PCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: mqAxdYQYS6iZEXJijn5T3Q==
X-CSE-MsgGUID: gyCrKF+YQZivrLgXAVdCKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="32227889"
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="32227889"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 10:09:03 -0700
X-CSE-ConnectionGUID: iXZnIrgdQQGeXQ8sNQydRQ==
X-CSE-MsgGUID: z5c4dhBZQs6lczSf9mpBRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="63192723"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 10:09:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1sdYXS-0000000EQJA-0Dtl;
	Mon, 12 Aug 2024 20:08:58 +0300
Date: Mon, 12 Aug 2024 20:08:57 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Lech Perczak <lech.perczak@camlingroup.com>
Cc: linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Krzysztof =?utf-8?Q?Drobi=C5=84ski?= <k.drobinski@camlintechnologies.com>,
	Pawel Lenkow <p.lenkow@camlintechnologies.com>,
	Kirill Yatsenko <kirill.yatsenko@camlingroup.com>
Subject: Re: [PATCH v2 2/3] serial: sc16is7xx: fix copy-paste errors in
 EFR_SWFLOWx_BIT macros
Message-ID: <ZrpBqaZVCNXtb3zv@smile.fi.intel.com>
References: <16b7bff3-71ec-4042-a9a8-755f32b85716@camlingroup.com>
 <497a8d04-665b-410c-aad6-e1a05869c744@camlingroup.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <497a8d04-665b-410c-aad6-e1a05869c744@camlingroup.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Aug 12, 2024 at 06:56:02PM +0200, Lech Perczak wrote:
> Comments attached to bits 0 and 1 incorrectly referenced bits 2 and 3,
> which don't match the datasheet - fix them.
> At the same time remove comments for individual macros, as they add
> nothing to the definitions themselves.

Strictly speaking we use term "definitions" or "constants" for the defined
constants instead of "macros" (see Subject).

-- 
With Best Regards,
Andy Shevchenko


