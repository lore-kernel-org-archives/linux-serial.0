Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793353363;
	b=fEOPX6hokUgEsh0AOhs8nR/JaODJ+WlDdPd9trxBAOKYoHKyKSEP071AyO8mDlW/Ulr+
	 hI/n1+qILkwFveKElXkd+gJveRq5rRx7hmXIFRlJUJJAdKy3nko8n4ZlaO7HWb3IRABBi
	 0MkVmvIcT2ILIOOGUnZOgBUXLOgjwZAHU2ZfeBSL3sFWLhpaP14WwM9lJVMrDPhVR8fXl
	 IBcd/ruUMzANf/UpseoF//eYQjSV146AkKH7AmC7EEs70rIl1EuBLyguPTygHNgBnxQMe
	 UXbm+gAVqqm2hQodmrpc6xYfG3Ej6zfR8RtVQMoTTpARMnXrmDfF2fGSTwLynH6X3ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793353363;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=KPmDcHzIcxGwm0JjIokV3IAY93hpCPYr5bbGmF7kEgs=;
	b=SNr8rEXhGN2siWULk0E97UzyheFIpHz/YMgzYosUMlVz/SzIB5ElLjqn6pWXUWRLtcMC
	 vvAh1EXLm15KS+bY3Unh7eqcXPFL3CMj8BaJveSfDQCWxyk88+oXb45XSF6f723o5hWmf
	 0lBedb9jQVEfBz3KF9zPMPByqnqTpzVqtSTel8DY6OTV2D+K8wQNADl3XRLulteosImim
	 ADoKUzQsH7GwquIIQWsA46JvHKXLHj4DF2ubx7GtLwQ/P0v5+aUTmf2xl7AbP7ofCDz3j
	 jgUFWrWf7RtgsFwUIbRzufCL5GCKpLeyyu/nknGwX9T38k3DwE+YOQiCYaW5AljHLSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=I7fTaQdk;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE64606A31D;
	Fri, 30 Oct 2026 09:42:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AE64606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=I7fTaQdk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793353362; x=1824889362;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S++Fsr5ccoNb10AS9UI5eH0BrHuggXtlsOEEApRXv08=;
  b=I7fTaQdks58DuUE8tJfWqHWIcgZVKX0wMi0kmZa80GeVBH9B5CysmJJo
   nO3mmyjhdhgPZJosD6wlqQn5fb4dCR3U/BCdOBTKM/+xJBHwWjnD/ipGq
   QG75QOeyIPNQlKwvr2L1zPZiSlZ1U4ShSYsuCTKL91EeLIgi/8/DiJxKX
   AkVhZFVqBhivZpxuclNNFBKPcTMxCZwguq1EflVlPFWLhOHjKEitM/u9E
   09VoKszux3W6/ax0wuFsqi/ZaorNmdtWleucP4JJ6Ms9AG9QHzkTokXlM
   X10rS7PeVhzUM8ozh4fvmrhiGlJeeu2HW6emEe5Uo/UUQOyoJW8SnTWRB
   g==;
X-CSE-ConnectionGUID: nRoAOPASSP6nPJukGIMXcQ==
X-CSE-MsgGUID: l0rFhWlIQq+iPD+zhSqkMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2126292"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2126292"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 02:42:42 -0700
X-CSE-ConnectionGUID: R/sn3uAUSNybjoO7cILr1A==
X-CSE-MsgGUID: tuuzPhruQlSkF/lwZlC60g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5271808"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.247])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 02:42:40 -0700
Date: Fri, 30 Oct 2026 11:42:37 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
Cc: James Hilliard <james.hilliard1@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, ilpo.jarvinen@linux.intel.com,
	Raul E Rangel <rrangel@chromium.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] serial: 8250_dw: preserve BUSY-safe fractional
 divisor programming
Message-ID: <auRmjeO8w3yKWDuw@ashevche-desk.local>
References: <20261027-submit-serial-8250-dw-divisor-v1-v4-1-41714a75e15a@gmail.com>
 <20261029182205.3453032-1-vinicius.eduardo.pedrosa@gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029182205.3453032-1-vinicius.eduardo.pedrosa@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 29, 2026 at 03:22:05PM -0300, Vinicius Pedrosa wrote:
> 
> With James's BUSY-safe fix reviewed, would you still be interested in a
> follow-up series moving the idle handling to callbacks in
> dw8250_port_data, including the LPSS conversion?

Yes, sure.

> I have the refactoring ready locally and tested it on an A733 board on
> top of tty-next, but haven't rebased it on James's patch yet. I haven't
> tested the LPSS part on hardware.

We need to test against tty-next branch in Greg's tree. Until James' patches
land there where are stuck.

-- 
With Best Regards,
Andy Shevchenko


