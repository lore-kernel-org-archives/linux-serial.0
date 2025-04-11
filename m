Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0FE1EFFB8;
	Fri, 11 Apr 2025 14:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744382973; cv=none; b=tWJZy67ouk29k2Mcc24ph2cGJqQv0ZfQgVXEw2ZuW1iXx3gPzoQpW8aWt8ZlfFRXfhykhpErlw1Wk0cFBT1imPAGJ2rrt0idLRGAFlW6pRmCRDf5OwtDwLl0kTuD2Uesh5rWVsIv1Dx55R48F6TTlKdtT2FOaaEDwIQi79jmzW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744382973; c=relaxed/simple;
	bh=bJoT1AGIbnf2HdatmV98iNNEld2eXX5HvG7s7JJY/Qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EgBpXaHo0OniL+cv6HZNskBGW4KvuxLwqYneB1zy+lvJ7QU12NfJ0a2uQIHshIQq9M7BBvfwxvhnP60Y/W7OMMCOHfQJ4GkX9JoomQxtMQFUr9FZNKK9NePLbxVwVHk2WaAs2snN1VXq0huLdSY36Y8V5+A/KYX55k8LU/66ano=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BJ9qEvWm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BJ9qEvWm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03407C4CEE8;
	Fri, 11 Apr 2025 14:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744382972;
	bh=bJoT1AGIbnf2HdatmV98iNNEld2eXX5HvG7s7JJY/Qw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BJ9qEvWmTA4Hrpp7KOhvcp2kctYzUdk0/JphfJ5CrG4ZMvw1bGdGUA2XbpACr69Yh
	 UBP7OOUhqDU4vwxKs5vpXW6uo1tfS/Tkzme9P0B3mkvwX9ILKCYFQQoUeWKHVV8ZM1
	 nobvxsE2+8fVXW8ul8IA+GxggBGuQqZtmlNj2Qg0=
Date: Fri, 11 Apr 2025 16:49:29 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Jiri Slaby <jirislaby@kernel.org>, Nicolas Pitre <npitre@baylibre.com>,
	Dave Mielke <Dave@mielke.cc>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] vt: implement proper Unicode handling
Message-ID: <2025041139-kelp-panhandle-985e@gregkh>
References: <20250410011839.64418-1-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410011839.64418-1-nico@fluxnic.net>

On Wed, Apr 09, 2025 at 09:13:52PM -0400, Nicolas Pitre wrote:
> The Linux VT console has many problems with regards to proper Unicode
> handling:

Wow, very nice work, thanks for doing all of this.  I'll go queue it up
now, the kernel test robot warnings for comments can be fixed up later
if you want to.

greg k-h
