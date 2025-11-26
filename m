Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACC2328251;
	Wed, 26 Nov 2025 12:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764161619; cv=none; b=As964p1jP0HA4TJbV7bUZo0LSLFFvYMAxrpf7oGiWgmc5UiLFmFXNFERwPjGiMuJjMCK99ZMBR6wUWgqcnWL4j16sYVIelyZOcO6d4yOExWExwJwNFM3tNkavTMLA3UMfSGi1hX35nhG4SCEfpXF+ng825PZf4dsVfzjZAyEqC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764161619; c=relaxed/simple;
	bh=F4sTffPx4FZ+9fP61VYlGETvM6sNED/nDu6cMxH1+l8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOkQRr0RLegBcKPTqVcdolf+hgeFohc0EmVEndPLOZKtfIlYWGyeKTLXTTQUqNlh3Xc9dJXToZ7CmWM+xoeQAUej4MuyBQ/gtGxxCH4xIO/C3c3zYDyffeOlzrCTjI3HYUeh6CIVfOhltoSPYRalZN5ZYu4Wa/lpX80jiEZZWeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EPAE3gOB; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EPAE3gOB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764161618; x=1795697618;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F4sTffPx4FZ+9fP61VYlGETvM6sNED/nDu6cMxH1+l8=;
  b=EPAE3gOBmCBrU/ioPZwydOtZja3xEHR3VDHcHn14FIA4lRYzX08dszoe
   jXa85rISMoJ/afZ8gpNagdDUkKV0R0ryNA9mP/c7jLl7QNEY01GkiLldt
   a1rnmbtsBTORd+SOL+1Hp3ni8QnASl5slS/+iSAJ2ARibZp+oBw7vjGOt
   /IwodGc3Y31P+yGy/430nicczPkmfewHf75sUHrcedHlgQcxriJ66jvKa
   MjwNJbvmgzCkR0e5UEMxhwkcLY1Xnv4iKseWPkk+1ESBCQb7gm3K2qlPv
   5npyT6x4X4QYn3ZnGH5GmOd3cI7xYgw5k4ozz98p8grYlDkoZb5ZfnWuV
   g==;
X-CSE-ConnectionGUID: b+RJHb3YSse+qTCzFL7rnQ==
X-CSE-MsgGUID: NLRu/G4NSaW8oSEO3sDjIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="69818265"
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="69818265"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 04:53:38 -0800
X-CSE-ConnectionGUID: TC1fAwrmRCaPFMqqrzm5/w==
X-CSE-MsgGUID: qk0kWylLTVis/1uB/n8Nxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="198043334"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 26 Nov 2025 04:53:36 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 8EB21A0; Wed, 26 Nov 2025 13:53:34 +0100 (CET)
Date: Wed, 26 Nov 2025 13:53:34 +0100
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "jempty.liang" <imntjempty@163.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250-of: Fix style issues in 8250_of.c
Message-ID: <aSb4Tr4iKaR_pqnA@black.igk.intel.com>
References: <20251117034117.55588-1-imntjempty@163.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117034117.55588-1-imntjempty@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Nov 17, 2025 at 03:41:17AM +0000, jempty.liang wrote:
> This patch resolves the warning "sizeof *port should be sizeof(*port)"
> detected by checkpatch.pl.

If you are going to submit more patches like this or related to sizeof, it
would be worth to mention that while sizeof is an operator, the coding style
recommends to use parentheses (but I haven't double checked this, feel free
to find it in the Coding Style documentation).

> -	memset(port, 0, sizeof *port);
> +	memset(port, 0, sizeof(*port));

From C perspective the original one is okay.

-- 
With Best Regards,
Andy Shevchenko


