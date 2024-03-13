Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73E92E648
	for <linux-serial@vger.kernel.org>; Wed, 13 Mar 2024 11:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710330662; cv=none; b=UnonPIEVNfgp+X2ejBaiN2CuiMav7J3RZHtFkNLoVp9Axpw8iqCwWRrPOVuwrnSNIA7D8yjr2Qjku9QdYs6SY9JPMZ0fFi4MpRWpHptlt2A4seT0Mx4CKaEi8CWSzaz6ZIplsH5BEPKEveafQseI3xerMGgQl8tJi8N9tDuP/EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710330662; c=relaxed/simple;
	bh=lYlX9ZkZL5jq2+bVay5Rwq4nPvVC5ZvXNJCQ/1EsWAY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SMM5gbuV9MeKsuZ9KonUyS2jdJ4hEEAsv3SQiEYcgmbXFMv6caiJvojgfGFMiJgTOSJhzksre01GQ8ekXkUZt7HWcu1qB+1fuCMpokAhDEtqb5Lg14OULnitxm2ibnDEU1ooawNcUmPFpqW4uEg9XQX1bD9ZWzpqHomIhTqFqmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KJ9hIsaS; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KJ9hIsaS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710330661; x=1741866661;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lYlX9ZkZL5jq2+bVay5Rwq4nPvVC5ZvXNJCQ/1EsWAY=;
  b=KJ9hIsaSPtrfIX2gyFMKdZezZQCPCwMkp5myCReI7OL6oaKeE2efYV7V
   bEkV7Gh1VzVzxp4zl1W70IU/nXUZB5NcLz/dgSRAHgKBtUv0VGE1sREh5
   jlA7R7XFZfLGjMqWDkWzxYZraz3qCOLNnJBgaD6tfL7RJ8W7sN2w762sr
   xAVu43bnRc6yDTmvjWNNedQlESdXCJ3rk9yV8m8poIE8rEy63Qt5EWAbx
   CSFzTYCXJdZoMIfNFGCXwBpL/HVl6GbdA0f13zRP8JESPiI8vXykJBwzI
   z4J+vmih3ffceByaBhp8G11eeaIXhA1dJ6glrgFHpgQ0Wmfz4blKrsSOf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="30523297"
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="30523297"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 04:51:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="914429961"
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="914429961"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 04:50:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rkN8K-0000000CCgD-2pOD;
	Wed, 13 Mar 2024 13:50:56 +0200
Date: Wed, 13 Mar 2024 13:50:56 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: speed_t usage?
Message-ID: <ZfGTIGvFvEMrFwOZ@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

Hi!

Recently while doing some serial driver cleanup I realised that TTY uses
speed_t type for baud rates. What is the appropriate use of it?
Either it is going to be killed (replaced with POD), or should / may we
spread it over tty/serial and further?

-- 
With Best Regards,
Andy Shevchenko


