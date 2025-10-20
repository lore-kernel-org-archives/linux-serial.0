Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E74226CF0;
	Mon, 20 Oct 2025 14:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760972111; cv=none; b=fCY0oaqkoxqWvsWiti+onMZySpppISIaqavcwUOFXePLE+sUa7WFM4uNrHCexlzoHxiAOGbKddS5IxsUWz/YBZhik3Ziebn/hswLRrEmaJTbCIzn4et27NFF44eJPUmLFqTcW3qa/i8eiidJslzVi6EZKNS5cI5BXJpTvNogMU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760972111; c=relaxed/simple;
	bh=IYe0snIFUIbXZg5W+Qsm8RK0j95K4knnHQxWMLlVglc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LqhMJVLM91FelAWBUChmH1gY8aCnA1FMs+tJPK+qOrEdGHz6h0G7NVRijufoIYQF6JS3CQ54U1+LNgEXYh7rDQhXSaSvTOOUpQtVrQX9Czt1ez0uMUQQyF8LSxmIOFaI2sitShMvRRbyne8k0ZYYVcQ5edlCg+J3cy9vQfe+5iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=p8Wprkh2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p8Wprkh2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Sp3U+8HhX66tVo1WEyU+Xcdj7duMXF6U3RpoRC4a8WQ=; b=p8Wprkh2dVq9SZFDPkia166rcb
	jyDGLg0XwBQvbe4SYn4XdxfdByoB/p054AHhPXAe2gNjvHifQ1DYT5gKigxXOMMrsWftb0ZcpurYL
	3VEdCyrKrib4CtlKsEmpK6yE6TY/WUHs1+hUo25Cx5/jMX6y3c8LLPUIALxFJBOzFJ9Kcxjkoh/Hq
	wNNAxeCvGWH4bVhPbpN3g+Oi3bjIMngVDwAYfqinSFXk1RxB87BFM7/D0pGyqnlNr5bxSFacA2tr3
	mXDXP1CAune12Vw0UJDnl0arWmmqTch6W6P+/BmB5a6+/nI8plVrccA9X8tU+CH4aZtEiAdnYW1ds
	9ijAzTIA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vArHn-0000000AQUT-1Gls;
	Mon, 20 Oct 2025 14:54:59 +0000
Date: Mon, 20 Oct 2025 15:54:59 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Brendan Jackman <jackmanb@google.com>,
	David Hildenbrand <david@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm, vc_screen: move __free() handler that frees a page
 to a common header
Message-ID: <aPZNQ0s8n-QOPhp2@casper.infradead.org>
References: <20251020143055.407696-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020143055.407696-1-rppt@kernel.org>

On Mon, Oct 20, 2025 at 05:30:55PM +0300, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> vc_screen defines __free() handler that frees a page using free_page().
> Move that definition to include/linux/gfp.h next to free_page() and
> rename it from free_page_ptr to free_page.

I don't think this is a good idea.  This is a bad interface and we
should be moving people away from it, not making it easier to use.
