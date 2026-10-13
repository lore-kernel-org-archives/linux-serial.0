Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2867E792;
	Tue, 13 Oct 2026 06:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791872545; cv=none; b=HunbZJFHqBwqsTI72gPye08xMgaVFk6S9KgXMHY77bTK0jsJiV7/fw6+2pAGdCafIQfwzzlxrALp1Y6SeOoOp6qD3jKDxkuwx2E7Eef+VP/wUroZw8UMcnez+c0+KzO2uspk+CLxZuIXrCU6byuDeX12LHm2JTaUfHuPvvw7Gj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791872545; c=relaxed/simple;
	bh=ZfsT/JnJx9KNk/XKB+11jQcQueyMxv3z5WgRkl62X7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TE1bO+WowOW59/g4UeJj+o9yA/PlBgf0LF+2vJnWOlXugo1eOqE2JTfgXZPPHEd+UD0HVMT8an+emI1MPEHmmrNgBNr8oZJO6sXSs9pdJMFQCKOfGW/qwH5MUhNY+KWkt/Ta9weqsnaIgLbBAk4KzhecK5yAdcxwuFyE4ZZta88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lTvYNIP+; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lTvYNIP+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791872544; x=1823408544;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZfsT/JnJx9KNk/XKB+11jQcQueyMxv3z5WgRkl62X7g=;
  b=lTvYNIP+Io6n5D+90GNm9htBHiMwnydDp/krJs9HR0gOmKeqH0Bs8Y+n
   1VhRW2IMXiBihvqaR6R+zmjlcuidwJjicanYcctig77GAdk95ez4cBrmR
   Lw7STKkic8RmlqGjmq6Q2IyKUf6fymQ6zMw0ZOR1Uhzf/LzOYaRij4PM6
   I4Lll9kwfwEAonU9Z1gA/6f6svSecPzKBX+y2xqRteG7gSnsxfzvgmnGm
   HO4fqTmJu/G37oVK7BQemXXAd/dZ/jWl1xjK31rDyQtfiyZzvYV4n4afG
   H0QyE8aHA+k+SrQuTUNEbnrjIX+bcX0nAxo2pM67CDaXlCB8NTKV7o/Lk
   g==;
X-CSE-ConnectionGUID: kUIHDsBXTqOJyaq9gQ9QFA==
X-CSE-MsgGUID: ta201GYmQ5etk4QkG3vgYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="488000"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="488000"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 23:22:23 -0700
X-CSE-ConnectionGUID: WBV46saPQgWfz29cSZhMRA==
X-CSE-MsgGUID: Z44VSfF9SPuWjTtafJMR7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1092067"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 23:22:18 -0700
Date: Tue, 13 Oct 2026 09:22:15 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Phil Rosenthal <phil@phil.gs>
Cc: "git@gregoirelayet.com" <git@gregoirelayet.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Lee Jones <lee@kernel.org>, Tan Siewert <tan.siewert@9elements.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"mfd@lists.linux.dev" <mfd@lists.linux.dev>,
	"andrew@lunn.ch" <andrew@lunn.ch>,
	"jacky_chou@aspeedtech.com" <jacky_chou@aspeedtech.com>,
	"yh_chung@aspeedtech.com" <yh_chung@aspeedtech.com>,
	"ninad@linux.ibm.com" <ninad@linux.ibm.com>,
	"anirudhsriniv@gmail.com" <anirudhsriniv@gmail.com>,
	"andy@kernel.org" <andy@kernel.org>
Subject: Re: [PATCH v6 4/6] mfd: aspeed-pci-core: add AST2600 PCIe BMC device
 driver
Message-ID: <as3OF7O5hnImaAWO@ashevche-desk.local>
References: <20260818-aspeed-driver-v6-v6-0-fd7cc0b338ea@9elements.com>
 <20260818-aspeed-driver-v6-v6-4-fd7cc0b338ea@9elements.com>
 <C5A01ECE-9A61-4BCA-88C6-83A1673AA69C@phil.gs>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C5A01ECE-9A61-4BCA-88C6-83A1673AA69C@phil.gs>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 13, 2026 at 03:04:43AM +0000, Phil Rosenthal wrote:

...

> The simplest fix would be to make aspeed,lpc-interrupts required
> together with aspeed,vuart-over-pci in the binding, or to set SIRQ 0
> and 1 for vuart3 and vuart4 in patch 6/6, so the BMC side always
> matches the host's table.
> 
> The more robust option is to find the vectors at probe, which Tan asked
> about in that thread. That works whatever SIRQs the BMC side uses, so a
> board DT that leaves them out or gets them wrong still gets interrupts,
> and if no vector can be found, the ports fall back to polling instead of
> waiting on a vector that never fires. It would also be the basis for
> stock firmware support if that ends up in this series.

I interpret this clearly as "Let's allow vendors to continue making mistakes
and provide wrong DT/configuration bits." My vote is definitely *no* to a such.
If this needs to be done to support some weird firmware in the wild it must:
- be a quirk that is clear sign that one has avoid such an example
- inform the vendor to fix their crap

Did I get it wrong?

> It's the MSI counterpart of what the 8250 core's autoconfig_irq() does for
> legacy ports with UPF_AUTO_IRQ; I described the method in [1], and it's
> aspeed_pci8250_find_irqs() in [2]. With the DT fix above your boards
> don't strictly need it, but I'm happy to send it as a patch for
> aspeed-pci-core if you'd like it.

-- 
With Best Regards,
Andy Shevchenko


