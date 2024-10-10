Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68D41C9EDD;
	Thu, 10 Oct 2024 14:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728572096; cv=none; b=FnO0vx7Ju7UZj1O6nIh7xCCkF/Fnpa3zkImf8MRoddjo3bMYt8DDwsQC0UUMgViEHpHCutGyVgqnNjaEHy70w7/ebqZrfe9wY92JvzHyAK4oQgFBSLZsU82WzmwWXzULMbGpAldgSv3ouyRi4ITewYqMr+B4QJL8HwtkHEMBM8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728572096; c=relaxed/simple;
	bh=LgiGrQlM3gDVzjYBIboDkagGXFjdao2iqR3QbcZoJF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sI0EaiKJRAXWBzK01INrqVUqWX8Qr161XoSRGMHrPOiXlc4QwM0qjzuTq/Qj9RYD/gnEbFIZRiOCuWgNmxwesDDylp/TzL1UKIpREijg+70CsaOVJoQsOJeDBMzR/fX3aSVLz0VXhEu1is06DxS61iCm8uI812qvC5EkHgF9Q6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iXqA8s3m; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iXqA8s3m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728572095; x=1760108095;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LgiGrQlM3gDVzjYBIboDkagGXFjdao2iqR3QbcZoJF0=;
  b=iXqA8s3mi/WcWDRrNilacyyKP2YuthrUTQsBjtOXmxLiwjBpGfVgHkjK
   hc0NfL9COqn0KHusazoB3sleCnjiDFbDRoPsYV3G9mO7NQSGylxtXLTcn
   a84Kiy7pCqICJxXGFZ20lFAuYowJYiNPrc5uTq0jlOSV0Xdgo0SRa23gM
   BzvXqeMZy3aVCdJh5Li36JoSQI3kJZSJUKsiQsqbYW1S2N6vDXlg4c/L2
   7TxjHHjWAamoXjlHu49pJPP8H2C89jBk4t5u6xZldn7bNFdLpCUf/0N0D
   G7/UquGyD2rlI22ytamctzR+GYhlda3CfWoS3FeUCinC4lQ+mu9HWSoE3
   g==;
X-CSE-ConnectionGUID: mcvZBt+0T7CnE1R/rmzVnA==
X-CSE-MsgGUID: oAe3BW39QqqINxqQFYqXRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="27828123"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="27828123"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 07:54:54 -0700
X-CSE-ConnectionGUID: qkWAqSZRQWO1o9uZ1H90aQ==
X-CSE-MsgGUID: Ip46FiQNQLeLcguU/URfYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="107337394"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 07:54:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1syuYy-00000001ZN8-1eFg;
	Thu, 10 Oct 2024 17:54:48 +0300
Date: Thu, 10 Oct 2024 17:54:48 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>, Yixun Lan <dlan@gentoo.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: serial: snps-dw-apb-uart: Add Sophgo
 SG2044 uarts
Message-ID: <ZwfquBFOVJEz5lTT@smile.fi.intel.com>
References: <20241009233908.153188-1-inochiama@gmail.com>
 <20241009233908.153188-2-inochiama@gmail.com>
 <oyvqsywyznanpx5oflnemcsrk7r7nnhvxl6ly7b55oan2boi5d@kobrtldqbj6m>
 <muz6ze7cxho5niz67agoxwnaowumzlcto2vwydmxs2yzdjmisi@symog2asftmv>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <muz6ze7cxho5niz67agoxwnaowumzlcto2vwydmxs2yzdjmisi@symog2asftmv>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Oct 10, 2024 at 04:23:05PM +0800, Inochi Amaoto wrote:
> On Thu, Oct 10, 2024 at 08:12:41AM +0200, Krzysztof Kozlowski wrote:
> > On Thu, Oct 10, 2024 at 07:39:05AM +0800, Inochi Amaoto wrote:
> > > Add compatibles string for the Sophgo SG2044 uarts.
> > 
> > This we see from the diff, say something about hardware.
> 
> The reason for this compatiable (and the hardware) is mainly in the
> next patch. Will it be better to submit a new verion with improved
> description? If so, I wonder whether I can reserve your ack.
> 
> > I would just add it to starfive enum, but this is fine as well.

Even after reading the second patch I don't understand why you shouldn't re-use
the starfive compatible or make a new one that covers this quirk? At least I would
see that as second patch is basically not needed.

-- 
With Best Regards,
Andy Shevchenko


