Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC1A1D89EC;
	Tue, 17 Dec 2024 20:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734469008; cv=none; b=hgcWJJu/Gv/o39y8hSs/GvhuiUC5yLzFRE73GFLekP1CXeyX1rluFQ46fu6PEd0R8HHxs/paf5ARqotb0k330njf2D2PoT7dTt7WsAsIqJnY1xRqo7teZ1ok94C/cMLeGfyTAKRX6H7cTmRiEXW/7U4cbGACB+iixwIm/l7Cor4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734469008; c=relaxed/simple;
	bh=Af2KRLSoFf+h0DNrrfx2oP5nBa7sAKsH5w+CNA5GRKA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tlf/502JHZp/BePVRXfJGlnQhx0mSddcnU3gVVsqiF/T3pzTnNiYlo0gi1XNYZLKslbKIyJVRMNku68vewhOKE+ugjNYwiyB0SlatwpdZruwsVmUXS0zu7qXXeCnOg24fU6RNJ6dMYlLilJDijYz59VuaHf+1hHaAZAEFIPHGcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=FhFChqsV; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="FhFChqsV"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 14D7B4040A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1734468999; bh=Af2KRLSoFf+h0DNrrfx2oP5nBa7sAKsH5w+CNA5GRKA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FhFChqsVo58DDf/5cU6Ond1qs+My1/peYw3PcMt/6HdMjBhnMUY7lzhZwkoknrAG6
	 90tt7cwenOllriVj5vsBXdmZfbhyDBcZ8+M4AAGmV4ItbCrAOe1nDPEw7FeYZYxdfw
	 To0mMBH57OOqNrhd8VWL+Rx3AV4b4ZLqeA3ZkAhJ6h5IcduvATIuwhqSCNev5Qvwyc
	 idPT7Qps3EC7JcfYtWJ9lGYTRX3QEqwJEsaiYmug9R447qHKdAYv3g7HKYi/fqmD/z
	 E3KVQpx+wdhkgEL3w6t4AlS0Wvmfvi1hxtzcUHJoULwZ88vqQe9g9btWR64NoOvOAZ
	 MwBmCfcN9k9Gw==
Received: from localhost (unknown [IPv6:2601:280:5e00:625:67c:16ff:fe81:5f9b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 14D7B4040A;
	Tue, 17 Dec 2024 20:56:39 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Sebastian Fricke
 <sebastian.fricke@collabora.com>, workflows@vger.kernel.org, Jason Wessel
 <jason.wessel@windriver.com>, Daniel Thompson <danielt@kernel.org>,
 Douglas Anderson <dianders@chromium.org>, linux-debuggers@vger.kernel.org,
 kgdb-bugreport@lists.sourceforge.net, Alex Shi <alexs@kernel.org>, Hu
 Haowen <2023002089@link.tyut.edu.cn>, Andrew Morton
 <akpm@linux-foundation.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
Subject: Re: [PATCH v3] Documentation: move dev-tools debugging files to
 process/debugging/
In-Reply-To: <20241210000041.305477-1-rdunlap@infradead.org>
References: <20241210000041.305477-1-rdunlap@infradead.org>
Date: Tue, 17 Dec 2024 13:56:38 -0700
Message-ID: <87seqmt4e1.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Randy Dunlap <rdunlap@infradead.org> writes:

> Move gdb and kgdb debugging documentation to the dedicated
> debugging directory (Documentation/process/debugging/).
> Adjust the index.rst files to follow the file movement.
> Adjust files that refer to these moved files to follow the file movement.
> Update location of kgdb.rst in MAINTAINERS file.
> Add a link from dev-tools/index to process/debugging/index.
>
> Note: translations are not updated.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Sebastian Fricke <sebastian.fricke@collabora.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: workflows@vger.kernel.org
> Cc: Jason Wessel <jason.wessel@windriver.com>
> Cc: Daniel Thompson <danielt@kernel.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: linux-debuggers@vger.kernel.org
> Cc: kgdb-bugreport@lists.sourceforge.net
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Alex Shi <alexs@kernel.org>
> Cc: Hu Haowen <2023002089@link.tyut.edu.cn>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-serial@vger.kernel.org
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-by: Daniel Thompson <danielt@kernel.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---

Applied, thanks.

jon
