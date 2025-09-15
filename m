Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C4D33EB06;
	Mon, 15 Sep 2025 14:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757947872; cv=none; b=Bf07W6VmeboSC/rmXbm7qD3iDRv1t32RV2MDAz+c0gpZ+cf5pfxSQ+FOOyv095nf9No3RvGm4jpLivSka1PqrbykB06bXQXfPJ85R1lVKDXUdmmy+BPB/QNJK2SDLSuP3rS5WbwRn5BCYkXSOYzU0OmTibVL8r1Q+sIbmTMvo34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757947872; c=relaxed/simple;
	bh=758/qyt7z8YWXOIxh7aGJyvNvH0k/7KRC3Hsiw66ubg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uwhjl2CPcqVo9H60qnc/c4QOpjVgs1aq+IRf6pcq+20HsTWE+Jj0LUwTf29YtWwYfxLQMuhyWiMW/2hAxhfCIN0CPFVW1Sy0iVN6PQKGAPSiXt8uT4HvDQnHVdiDn+b9LszC2V8VXh5NfNs6Ntz/++w993g9fe2odIadadV6DdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H4yyi3hZ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H4yyi3hZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757947871; x=1789483871;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=758/qyt7z8YWXOIxh7aGJyvNvH0k/7KRC3Hsiw66ubg=;
  b=H4yyi3hZnyr7+uymfNJsh+ZUvW/ESRb5FGOk7vOuwO8UZ6+kjEGHiOxC
   W1w2d3LfE2+cgKpQhMmTL0DSqF2CmDqIvBuaMN9vVCQv1yYEud72GYeSf
   zgOGV/zMKUJCB/72zLRSgJqOmJb/XgJHZDaK2E7wUWTIRU23iq3DQv5ao
   I2B7Gyr7brQ/WrfU6ljO8tN1b1wJuwCz11Ou21lEld2w5Sw7m9VgkJFSc
   9l8kGYNRhbjxIUHqeKVuD420jvqVdcQ72jiwzVPPgQsB7rWwFKI0zytmy
   Sa+uxWZdX5MxLfD9HlZR55IOGy5zM+4eQlb8VDxBSctmHD5utz8kR8Vn4
   w==;
X-CSE-ConnectionGUID: RK8Q2bSZQnyRSVNcz/kYDA==
X-CSE-MsgGUID: q935mA4xTPuWShj8cRThWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="59247279"
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="59247279"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 07:51:10 -0700
X-CSE-ConnectionGUID: KR3YtAn8R/WMh/bTm5v1jw==
X-CSE-MsgGUID: hlZp7rZTR8Gr20gFnhvUTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="178649539"
Received: from smile.fi.intel.com ([10.237.72.51])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 07:51:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uyAXl-00000003H8v-3fUX;
	Mon, 15 Sep 2025 17:51:01 +0300
Date: Mon, 15 Sep 2025 17:51:01 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Daniel Golle <daniel@makrotopia.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Yu Jiaoliang <yujiaoliang@vivo.com>,
	Changqi Hu <changqi.hu@mediatek.com>,
	Sam Shih <sam.shih@mediatek.com>,
	Steven Liu <steven.liu@mediatek.com>,
	John Crispin <john@phrozen.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 1/2] tty: serial: 8250_mtk: enable baud clock
Message-ID: <aMgn1XXtgR20CSuI@smile.fi.intel.com>
References: <2de07b0a6d51d5d3bf3e55cd03cf75adfc91ee7d.1757941345.git.daniel@makrotopia.org>
 <bf054186-17fb-4ea4-9d07-488b6792a437@collabora.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf054186-17fb-4ea4-9d07-488b6792a437@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Sep 15, 2025 at 03:41:25PM +0200, AngeloGioacchino Del Regno wrote:
> Il 15/09/25 15:06, Daniel Golle ha scritto:

...

> I've read both of the commits in this series and the code LGTM.
> 
> tty: serial: 8250_mtk: Enable baud clock and manage in runtime PM

"tty: " part is not needed.

> Please, squash the two commits, after which...

-- 
With Best Regards,
Andy Shevchenko


