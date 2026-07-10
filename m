Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEE13F7A95;
	Fri, 10 Jul 2026 12:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783687461; cv=none; b=ArJNUwxsBKv2doznhH82VQcS/Z5i65wWxNP4xokedksgIsHgNW48yGWAlpYDFHt1xn+Vzj/WLxIQA14SQc6IhjwM+1ocHMCmRnwT1FTb2rDIxTQG+zj6hd0hbD06y/Mhq5GWx3dmtVzck5A2XeWNz/4CsHctjjuFDP8fVgoeF3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783687461; c=relaxed/simple;
	bh=++ya+cJWR/7rOGSXj8gyhO2EG2epoVtgfbqXlnqnJao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jzA8v3FP+1xDmIjd0V0PbudEGY9aa3gb5gMUDR/kcGWHnr1qfDTKHR39Z2boQpXWGXkX9EWUi6HxJcQUHjDF4xUJMaoXUHUBtJVoO7LGtv3FRbE15O0w1+TOWCGeoBmtUhFtx3d7djcLftfhtgy1YGAgngbMUrE3Q9s2xzwlA3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EEELqsB/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EEELqsB/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC0F71F000E9;
	Fri, 10 Jul 2026 12:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783687460;
	bh=Q9LEwRfQaoioBH//UsNLh50BwO16qRhtua4e0cQv6bg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EEELqsB/lvAiQCs8s4hbR5ZPsy9SiHScIesdcTHoPgw4dmqwi9bzCfnkQKBR4MHLo
	 2NjKayd+QrPl2Zlw2EESyDj7QOlOmSA0zeFeS7sa5k8c3GQNZ6c/hwnK/mES73dmmK
	 ort1EYjmiIt0MQigSAb0Vh6Me861x9qoFfXLEnWo=
Date: Fri, 10 Jul 2026 14:44:16 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 0/4] tty: replace __get_free_pages() with kmalloc()
Message-ID: <2026071056-comfort-dynamic-a713@gregkh>
References: <20260630-b4-tty-v3-0-a8476c66c582@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630-b4-tty-v3-0-a8476c66c582@kernel.org>

On Tue, Jun 30, 2026 at 12:54:02PM +0300, Mike Rapoport (Microsoft) wrote:
> This is a (tiny) part of larger work of replacing page allocator calls
> with kmalloc.
> 
> Nowadays the right way to say "I need a buffer" is kmalloc() rather than
> ancient and ugly __get_free_pages().

I already applied an earlier version of this series, so can you just
send the fixes you made between them?

thanks,
greg k-h
